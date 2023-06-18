import 'package:app/controllers/chat_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/repositories/ai_repository.dart';
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
      final asyncJournalEntry = testChatJournalEntry;
      chatController = ChatController(testUserId, AsyncData(asyncJournalEntry), chatHistoryRepository);
      final chatHistory = chatController.debugState.valueOrNull;
      chatBotController = ChatBotController(testUserId, testChatJournalEntry, chatHistory, chatController, aiRepository);
    });

    test('initial state is null', () {
      expect(chatBotController.debugState, isA<AsyncData>());
      expect(chatBotController.debugState.value, isNull);
    });

    test('writeBotResponse changes state to AsyncData with bot response', () async {
      final mockBotResponse = testChatBotMessageObj;

      aiRepository.mockBotResponse = mockBotResponse;

      await chatBotController.writeBotResponse();

      expect(chatBotController.debugState, isA<AsyncData<ChatMessageObj?>>());
      expect(chatBotController.debugState.value, equals(mockBotResponse));
    });

    test('writeBotResponse adds bot message to chat history', () async {
      final mockBotResponse = testChatBotMessageObj;

      aiRepository.mockBotResponse = mockBotResponse;

      await chatBotController.writeBotResponse();

      final newHistory = chatController.debugState.value!;
      expect(newHistory, hasLength(3));
      expect(newHistory[0].value, mockBotResponse);
    });

    test('writeBotResponse leads to AsyncError if AIRepository fails', () async {
      final mockBotException = AIException('Gotcha!');;

      aiRepository.mockBotException = mockBotException;

      await chatBotController.writeBotResponse();
      expect(chatBotController.debugState, isA<AsyncError>());
      expect(chatBotController.debugState.error, mockBotException);

      final history = chatController.debugState.value!;
      expect(history[0], isA<AsyncError>());
      expect(history[0].error, mockBotException);
    });
  });
}
