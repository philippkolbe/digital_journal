import 'package:app/controllers/chat_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/models/summary.dart';
import 'package:app/providers/prompts_providers.dart';
import 'package:app/services/ai_service.dart';

// ignore: depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';

/// This provider holds a summary of the current conversation.
/// Note that it does not hold the summary of conversations that were selected but the user not written into again.
/// That value should be saved in the selectedJournalEntry though. The advantage like this is that we don't analyze old summaries that have already been analyzed
/// but one could think about changing this.
final summaryProvider = StateProvider<AsyncValue<SummaryObj?>>((ref) => const AsyncData(null));

final summaryControllerProvider = Provider<SummaryController>((ref) {
  final aiService = ref.watch(aiServiceProvider);
  final prompts = ref.watch(generalPromptsProvider);
  final chatController = ref.watch(chatControllerProvider.notifier);

  final summaryStateController = ref.read(summaryProvider.notifier);

  return SummaryController(
    chatController,
    summaryStateController,
    aiService,
    prompts,
  );
});

class SummaryController {
  final BaseAIService _aiService;
  final Map<GeneralPrompts, String> _prompts;
  final ChatController _chatController;
  final StateController<AsyncValue<SummaryObj?>> _summaryStateController;

  SummaryController(
    this._chatController,
    this._summaryStateController,
    this._aiService,
    this._prompts,
  );

  /// We use this method mainly for testing
  void setSummary(AsyncValue<SummaryObj?> summaryObj) {
    _summaryStateController.state = summaryObj;
  }

  Future<void> onChatStateUpdated(
    AsyncValue<ChatState?>? prevChatState,
    AsyncValue<ChatState?> asyncChatState,
    JournalEntryObj? selectedJournalEntry,
  ) async {
    final chatState = asyncChatState.valueOrNull;
    if (chatState != null && selectedJournalEntry != null && chatState.wasModifiedByUser) {
      // First thing: We set flag back to false because we are handling this request now!
      _chatController.setModifiedByUser(selectedJournalEntry, false);

      if (_isCorrectJournalEntryLoaded(selectedJournalEntry, chatState)) {
        // Now we do the actual summary. In here the correct update of the summaryProvider is happening 
        await summarize(
          selectedJournalEntry,
          chatState,
        );

      } else {
        _summaryStateController.state = const AsyncData(null);
      }
    }
  }

  Future<void> summarize(
    JournalEntryObj journalEntry,
    ChatState chatState,
  ) async {
    final previousSummary = journalEntry.summary;

    if (chatState.wasModifiedByUser) {
      _summaryStateController.state = const AsyncLoading();
      final summaryDate = DateTime.now();
      final summary = await _computeSummary(_aiService, _prompts, previousSummary, chatState.chat);
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

      _summaryStateController.state = AsyncData(summaryObj);
    }
  }

  bool _isCorrectJournalEntryLoaded(JournalEntryObj journalEntry, ChatState chatState) {
    return journalEntry is! ChatJournalEntryObj || journalEntry.id == chatState.journalEntryId;
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