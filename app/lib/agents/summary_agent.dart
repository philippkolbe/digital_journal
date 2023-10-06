import 'package:app/controllers/chat_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/models/summary.dart';
import 'package:app/providers/prompts_providers.dart';
import 'package:app/services/ai_service.dart';

// ignore: depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';

final summaryProvider = StateProvider<AsyncValue<SummaryObj?>>((ref) => const AsyncData(null));

final summaryAgentProvider = Provider((ref) {
  final aiService = ref.watch(aiServiceProvider);
  final prompts = ref.watch(generalPromptsProvider);
  final summaryController = ref.watch(summaryProvider.notifier);

  return SummaryAgent(aiService, prompts, summaryController);
});

class SummaryAgent {
  final BaseAIService aiService;
  final Map<GeneralPrompts, String> prompts;
  final StateController<AsyncValue<SummaryObj?>> summaryController;

  SummaryAgent(
    this.aiService,
    this.prompts,
    this.summaryController,
  );

  Future<void> summarize(
    JournalEntryObj? journalEntry,
    ChatState? chatState,
  ) async {
    if (_isJournalEntryLoading(journalEntry, chatState)) {
      summaryController.state = const AsyncData(null);
      return;
    }

    final previousSummary = journalEntry!.summary;

    if (chatState != null && chatState.wasModifiedByUser) {
      summaryController.state = const AsyncLoading();
      final summaryDate = DateTime.now();
      final summary = await _computeSummary(aiService, prompts, previousSummary, chatState.chat);
      String? validUpToId;
      for (final asyncChatMessage in chatState.chat) {
        if (asyncChatMessage is AsyncData<ChatMessageObj> && asyncChatMessage.value is UserChatMessageObj) {
          validUpToId = asyncChatMessage.value.id;
          break;
        }
      }

      final summaryObj = SummaryObj(
        date: summaryDate,
        content: summary,
        validUpToId: validUpToId,
      );

      summaryController.state = AsyncData(summaryObj);
    }
  }

  bool _isJournalEntryLoading(JournalEntryObj? journalEntry, ChatState? chatState) {
    return (
      journalEntry == null ||
      journalEntry is ChatJournalEntryObj && journalEntry.id != chatState?.journalEntryId
    );
  }

  Future<String> _computeSummary(
    BaseAIService aiService,
    Map<GeneralPrompts, String> prompts,
    SummaryObj? previousSummary,
    ChatHistory chatHistory,
  ) async {
    final relevantChatHistory = _findUnsummarizedChatMessages(chatHistory, previousSummary);

    final chatWithPrompts = [
      _createSystemMessage(prompts),
      if (previousSummary != null)
        _createPreviousSummaryMessage(previousSummary),
      ...relevantChatHistory,
      _createPromptMessage(prompts)
    ];

    final responseMessage = await aiService.respondToChat(chatWithPrompts);
    return responseMessage.content;
  }

  List<ChatMessageObj> _findUnsummarizedChatMessages(ChatHistory chatHistory, SummaryObj? previousSummary) {
    final messages = chatHistory
      .whereType<AsyncData<ChatMessageObj>>()
      .map((asyncMessage) => asyncMessage.value);
    return _findUnsummarizedChatHistory(messages, previousSummary).toList();
  }

  Iterable<ChatMessageObj> _findUnsummarizedChatHistory(
    Iterable<ChatMessageObj> chatHistory,
    SummaryObj? previousSummary
  ) {
    if (previousSummary != null && previousSummary.validUpToId != null) {
      return chatHistory.takeWhile((message) => message.id != previousSummary.validUpToId);
    } else {
      return chatHistory;
    }
  }

  ChatMessageObj _createSystemMessage(Map<GeneralPrompts, String> prompts) {
    return ChatMessageObj.system(
      date: DateTime.now(),
      content: prompts[GeneralPrompts.conversationSummary]!,
    );
  }

  ChatMessageObj _createPreviousSummaryMessage(SummaryObj previousSummary) {
    return ChatMessageObj.user(
      date: DateTime.now(),
      content: createPreviousSummaryUserMessage(previousSummary.content),
    );
  }

  ChatMessageObj _createPromptMessage(Map<GeneralPrompts, String> prompts) {
    return ChatMessageObj.user(
      date: DateTime.now(),
      content: prompts[GeneralPrompts.summarizeChatMessage]!,
    );
  }
}
