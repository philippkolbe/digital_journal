import 'package:app/controllers/chat_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/services/ai_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/controllers/chat_bot_controller.dart';

import '../repositories/firebase_test_data.dart';
import 'mock_ai_service.dart';
import 'mock_chat_history_repository.dart';

void main() {
  group('ChatBotController', () {
    late ChatBotController chatBotController;
    late ChatController chatController;
    late MockChatHistoryRepository chatHistoryRepository;
    late MockAIService aiRepository;

    setUp(() {
      aiRepository = MockAIService();
      chatHistoryRepository = MockChatHistoryRepository();
      final asyncJournalEntry = testChatJournalEntry;
      chatController = ChatController(testUserId, AsyncData(asyncJournalEntry), chatHistoryRepository);
      chatBotController = ChatBotController(testUserId, aiRepository);
    });

    test('initial state is null', () {
      expect(chatBotController.debugState, isA<AsyncData>());
      expect(chatBotController.debugState.value, isNull);
    });

    test('writeBotResponse changes state to AsyncData with bot response', () async {
      final mockBotResponse = testChatBotMessageObj;

      aiRepository.mockBotResponse = mockBotResponse;

      await chatHistoryRepository.readChatHistory(testUserId, testChatJournalEntryId);
      // Chat history is loaded
      final response = await chatBotController.writeBotResponse(chatController.debugState.valueOrNull?.chat);

      expect(chatBotController.debugState, isA<AsyncData<ChatMessageObj?>>());
      expect(chatBotController.debugState.value, equals(mockBotResponse));

      expect(response, isA<AsyncData>());
      expect(response.value!.id, isNotNull);
      expect(response.value!.content, mockBotResponse.content);
      expect(response.value!.date, mockBotResponse.date);
    });

    test('writeBotResponse leads to AsyncError if AIRepository fails', () async {
      final mockBotException = AIException('Gotcha!');

      aiRepository.mockBotException = mockBotException;

      await chatHistoryRepository.readChatHistory(testUserId, testChatJournalEntryId);
      // Chat history is loaded
      final response = await chatBotController.writeBotResponse(chatController.debugState.valueOrNull?.chat);
      expect(chatBotController.debugState, isA<AsyncError>());
      expect(chatBotController.debugState.error, mockBotException);

      expect(response, isA<AsyncError>());
      expect(response.error, mockBotException);
    });
  });
}
