import 'package:app/controllers/chat_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/controllers/chat_bot_controller.dart';

import '../repositories/firebase_test_data.dart';
import 'mock_ai_repository.dart';
import 'mock_chat_history_repository.dart';

void main() {
  group('ChatBotController', () {
    late ChatBotController chatBotController;
    late ChatController chatController;
    late MockChatHistoryRepository chatHistoryRepository;
    late MockAIRepository aiRepository;

    setUp(() {
      aiRepository = MockAIRepository();
      chatHistoryRepository = MockChatHistoryRepository();
      final asyncJournalEntry = AsyncData(testChatJournalEntry);
      chatController = ChatController(testUserId, asyncJournalEntry, chatHistoryRepository);
      final chatHistory = chatController.debugState.valueOrNull;
      chatBotController = ChatBotController(testUserId, asyncJournalEntry, chatHistory, chatController, aiRepository);
    });

    test('initial state is null', () {
      expect(chatBotController.debugState, isA<AsyncData>());
      expect(chatBotController.debugState.value, isNull);
    });

    test('writeBotResponse changes state to loading', () async {
      expect(chatBotController.debugState, isNull);

      chatBotController.writeBotResponse();

      expect(chatBotController.debugState, isA<AsyncLoading<String?>>());
    });

    test('writeBotResponse changes state to AsyncData with bot response', () async {
      final mockBotResponse = testChatMessageObj;

      aiRepository.mockBotResponse = mockBotResponse;

      await chatBotController.writeBotResponse();

      expect(chatBotController.debugState, isA<AsyncData<String?>>());
      expect(chatBotController.debugState.value, equals(mockBotResponse));
    });

    test('writeBotResponse adds bot message to chat history', () async {
      final mockBotResponse = testChatMessageObj;

      aiRepository.mockBotResponse = mockBotResponse;

      await chatBotController.writeBotResponse();

      final newHistory = await chatHistoryRepository.readChatHistory(testUserId, testChatJournalEntryId);
      expect(newHistory, hasLength(3));
      expect(newHistory[0], testChatMessageObj);
    });
  });
}
