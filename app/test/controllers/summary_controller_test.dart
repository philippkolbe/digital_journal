import 'package:app/controllers/summary_controller.dart';
import 'package:app/mocks/data/firebase_test_data.dart';
import 'package:app/mocks/mock_ai_service.dart';
import 'package:app/mocks/mock_chat_controller.dart';
import 'package:app/mocks/mock_prompts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/controllers/chat_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/models/summary.dart';
// ignore: depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';

void main() {
  group("Summary Agent Test", () {
    late MockAIService mockAIService;
    late ChatController chatController;
    late SummaryController summaryController;

    setUp(() {
      mockAIService = MockAIService();
      chatController = MockChatController();
      summaryController = SummaryController(
        testChatJournalEntry,
        chatController,
        mockAIService,
        mockGeneralPrompts,
      );
    });

    test('Test summarize method when journal entry is loading', () async {    
      final chatState = ChatState(journalEntryId: '123', wasModifiedByUser: false, chat: []);

      await summaryController.summarize(null, chatState);

      expect(summaryController.debugState, equals(const AsyncData<SummaryObj?>(null)));
    });

    test('Test summarize method when chat state loading', () async {
      await summaryController.summarize(testChatJournalEntry, null);
      
      expect(summaryController.debugState, equals(const AsyncData<SummaryObj?>(null)));
    });

    test('Test summarize method when different journalEntry loaded', () async {    
      final chatState = ChatState(journalEntryId: '${testChatJournalEntryId}abc', wasModifiedByUser: false, chat: []);  
      await summaryController.summarize(testChatJournalEntry, chatState);

      expect(summaryController.debugState, equals(const AsyncData<SummaryObj?>(null)));
    });

    test('Test summarize method for loading state', () {
      final chatState = ChatState(journalEntryId: testChatJournalEntry.id, wasModifiedByUser: true, chat: [AsyncData(testChatMessageObj)]);

      summaryController.summarize(testChatJournalEntry, chatState);

      expect(summaryController.debugState, isA<AsyncLoading<SummaryObj?>>());
    });

    test('Test summarize method when chatState is modified by user', () async {
      final chatState = ChatState(journalEntryId: testChatJournalEntry.id, wasModifiedByUser: true, chat: [AsyncData(testChatMessageObj)]);

      await summaryController.summarize(testChatJournalEntry, chatState);

      expect(summaryController.debugState, isA<AsyncData<SummaryObj?>>());
      final data = summaryController.debugState.value;
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
      summaryController.setSummary(AsyncData(oldSummaryObj));

      await summaryController.summarize(testChatJournalEntry, chatState);

      // Summary agent shouldnt change anything since the summary is taken from the user message
      expect(summaryController.debugState.value, equals(oldSummaryObj));
    });
    test('Test summarize method when bot has replied', () async {
      final chatState = ChatState(journalEntryId: testChatJournalEntry.id, wasModifiedByUser: false, chat: [
        AsyncData(testChatMessageObj),
        AsyncData(testChatBotMessageObj),
      ]);
      final oldSummaryObj = SummaryObj(date: DateTime.now());
      summaryController.setSummary(AsyncData(oldSummaryObj));

      await summaryController.summarize(testChatJournalEntry, chatState);

      // Summary agent shouldnt change anything since the summary is taken from the user message
      expect(summaryController.debugState.value, equals(oldSummaryObj));
    });

    test('Test onChatStateUpdated method', () async {
      final chatState = ChatState(journalEntryId: testChatJournalEntry.id, wasModifiedByUser: true, chat: [AsyncData(testChatMessageObj)]);

      final future = summaryController.onChatStateUpdated(null, AsyncData(chatState));

      expect(chatController.debugState.valueOrNull?.wasModifiedByUser, isFalse);

      await future;
      expect(summaryController.debugState.valueOrNull, isNotNull);    
    });
  });
}