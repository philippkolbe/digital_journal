import 'package:app/agents/summary_agent.dart';
import 'package:app/mocks/data/firebase_test_data.dart';
import 'package:app/mocks/mock_ai_service.dart';
import 'package:app/mocks/mock_chat_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/controllers/chat_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/models/summary.dart';
import 'package:app/providers/prompts_providers.dart';
// ignore: depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';

void main() {
  group("Summary Agent Test", () {
    late MockAIService mockAIService;
    late StateController<AsyncValue<SummaryObj?>> summaryController;
    late ChatController chatController;
    late SummaryAgent summaryAgent;

    setUp(() {
      mockAIService = MockAIService();
      summaryController = StateController<AsyncValue<SummaryObj?>>(const AsyncData(null));
      chatController = MockChatController();
      summaryAgent = SummaryAgent(
        testChatJournalEntry,
        summaryController,
        chatController,
        mockAIService,
        {
          GeneralPrompts.conversationSummary: 'Here is a summary: Nothing has happened so far.',
          GeneralPrompts.summarizeChatMessage: 'Please summarize our conversation up to the message before this one.',
        },
      );
    });

    tearDown(() {
      summaryController.dispose(); // Dispose of the controller after each test.
    });

    test('Test summarize method when journal entry is loading', () async {    
      final chatState = ChatState(journalEntryId: '123', wasModifiedByUser: false, chat: []);

      await summaryAgent.summarize(null, chatState);

      expect(summaryController.state, equals(const AsyncData<SummaryObj?>(null)));
    });

    test('Test summarize method when chat state loading', () async {
      await summaryAgent.summarize(testChatJournalEntry, null);
      
      expect(summaryController.state, equals(const AsyncData<SummaryObj?>(null)));
    });

    test('Test summarize method when different journalEntry loaded', () async {    
      final chatState = ChatState(journalEntryId: '${testChatJournalEntryId}abc', wasModifiedByUser: false, chat: []);  
      await summaryAgent.summarize(testChatJournalEntry, chatState);

      expect(summaryController.state, equals(const AsyncData<SummaryObj?>(null)));
    });

    test('Test summarize method for loading state', () {
      final chatState = ChatState(journalEntryId: testChatJournalEntry.id, wasModifiedByUser: true, chat: [AsyncData(testChatMessageObj)]);

      summaryAgent.summarize(testChatJournalEntry, chatState);

      expect(summaryController.state, isA<AsyncLoading<SummaryObj?>>());
    });

    test('Test summarize method when chatState is modified by user', () async {
      final chatState = ChatState(journalEntryId: testChatJournalEntry.id, wasModifiedByUser: true, chat: [AsyncData(testChatMessageObj)]);

      await summaryAgent.summarize(testChatJournalEntry, chatState);

      expect(summaryController.state, isA<AsyncData<SummaryObj?>>());
      final data = summaryController.state.value;
      expect(data, isNotNull);
      expect(data!.validUpToId, equals(testChatMessageObj.id));
      expect(data.content, equals(mockAIService.mockBotResponse.content));
    });

    test('Test summarize method when bot message is still loading', () async {
      final chatState = ChatState(journalEntryId: testChatJournalEntry.id, wasModifiedByUser: false, chat: [
        AsyncData(testChatMessageObj),
        const AsyncLoading<ChatMessageObj>(),
      ]);
      final oldSummaryObj = SummaryObj(date: DateTime.now());
      summaryController.state = AsyncData(oldSummaryObj);

      await summaryAgent.summarize(testChatJournalEntry, chatState);

      // Summary agent shouldnt change anything since the summary is taken from the user message
      expect(summaryController.state.value, equals(oldSummaryObj));
    });
    test('Test summarize method when bot has replied', () async {
      final chatState = ChatState(journalEntryId: testChatJournalEntry.id, wasModifiedByUser: false, chat: [
        AsyncData(testChatMessageObj),
        AsyncData(testChatBotMessageObj),
      ]);
      final oldSummaryObj = SummaryObj(date: DateTime.now());
      summaryController.state = AsyncData(oldSummaryObj);

      await summaryAgent.summarize(testChatJournalEntry, chatState);

      // Summary agent shouldnt change anything since the summary is taken from the user message
      expect(summaryController.state.value, equals(oldSummaryObj));
    });

    test('Test onChatStateUpdated method', () async {
      final chatState = ChatState(journalEntryId: testChatJournalEntry.id, wasModifiedByUser: true, chat: [AsyncData(testChatMessageObj)]);

      final future = summaryAgent.onChatStateUpdated(null, AsyncData(chatState));

      expect(chatController.debugState.valueOrNull?.wasModifiedByUser, isFalse);

      await future;
      expect(summaryController.debugState.valueOrNull, isNotNull);    
    });
  });
}