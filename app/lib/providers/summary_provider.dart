import 'package:app/controllers/chat_controller.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/models/summary.dart';
import 'package:app/providers/prompts_providers.dart';
import 'package:app/providers/selected_journal_entry_provider.dart';
import 'package:app/services/ai_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final summaryProvider = FutureProvider<SummaryObj?>((ref) async {
  final asyncJournalEntry = ref.watch(selectedJournalEntryProvider);
  final journalEntry = asyncJournalEntry.valueOrNull;

  final asyncChatState = ref.watch(chatControllerProvider);
  final chatState = asyncChatState.valueOrNull;

  if (_isJournalEntryLoading(journalEntry, chatState)) {
    return null;
  }

  final journalRepository = ref.watch(journalControllerProvider.notifier);
  final aiService = ref.watch(aiServiceProvider);
  final prompts = ref.watch(generalPromptsProvider);
  final previousSummary = journalEntry!.summary;

  if (chatState != null && chatState.modifiedByUser) {
    final summaryDate = DateTime.now();
    final summary = await _computeSummary(aiService, prompts, previousSummary, chatState.chat);
    final validUpToId = chatState.chat.firstOrNull?.valueOrNull?.id;
    final summaryObj = SummaryObj(
      date: summaryDate,
      content: summary,
      validUpToId: validUpToId,
    );

    // final lastDate = ref.state.valueOrNull?.date;
    // if (lastDate == null || summaryDate.isAfter(lastDate)) {
    //   journalRepository.updateJournalEntry(journalEntry.copyWith(
    //     summary: summaryObj,
    //   ));
    // }

    // lets hope that provider can deal with asynchronous requests properly.
    // I am scared that summaries that need longer to compute might overwrite newer summaries.
    // We are catching the overwrite in firebase above but I hope that riverpod will catch the overwrite of the provider itself...
    return summaryObj;
  } else {
    return previousSummary;
  }
});

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