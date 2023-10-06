import 'package:app/controllers/chat_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/models/summary.dart';
import 'package:app/providers/prompts_providers.dart';
import 'package:app/services/ai_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final summaryProvider = StateProvider<AsyncValue<SummaryObj?>>((ref) => const AsyncData(null));

Future<void> summarize(AsyncValue<JournalEntryObj?> asyncJournalEntry, AsyncValue<ChatState?> asyncChatState, Map<GeneralPrompts, String> prompts, BaseAIService aiService, StateController<AsyncValue<SummaryObj?>> summaryStateNotifier) async {
  final journalEntry = asyncJournalEntry.valueOrNull;

  final chatState = asyncChatState.valueOrNull;

  if (_isJournalEntryLoading(journalEntry, chatState)) {
    summaryStateNotifier.state = const AsyncData(null);
    return;
  }

  final previousSummary = journalEntry!.summary;

  if (chatState != null && chatState.wasModifiedByUser) {
    summaryStateNotifier.state = const AsyncLoading();
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

    summaryStateNotifier.state = AsyncData(summaryObj);

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