import 'package:app/repositories/chat_history_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/controllers/chat_controller.dart';

import '../repositories/firebase_test_data.dart';
import 'mock_chat_history_repository.dart';

void main() {
  late ChatController chatController;
  late BaseChatHistoryRepository mockChatHistoryRepository;

  group('ChatController', () { 

    setUp(() {
      mockChatHistoryRepository = MockChatHistoryRepository();
      chatController = ChatController(
        testUserId,
        AsyncValue.data(testChatJournalEntry),
        mockChatHistoryRepository,
      );
    });

    test('writeUserChatMessage should add a user chat message to the chat history', () async {
      // Arrange
      const content = 'Hello, this is a user message';

      final historyLengthBefore = (await mockChatHistoryRepository.readChatHistory(testUserId, testChatJournalEntryId)).length;

      // Act
      await chatController.writeUserChatMessage(content);

      // Assert
      final state = chatController.debugState.value!;
      expect(state.length - historyLengthBefore, 1);
      expect(state[0].valueOrNull!.isFromBot, false);
      expect(state[0].valueOrNull!.content, content);

      final history = await mockChatHistoryRepository.readChatHistory(testUserId, testChatJournalEntryId);
      expect(history.length - historyLengthBefore, 1);
      expect(history[0].isFromBot, false);
      expect(history[0].content, content);
    });

    test('writeBotChatMessage should add a bot chat message to the chat history', () async {
      // Arrange
      const content = 'Hello, this is a bot message';

      final historyLengthBefore = (await mockChatHistoryRepository.readChatHistory(testUserId, testChatJournalEntryId)).length;

      // Act
      await chatController.writeBotChatMessage(content);

      // Assert
      final state = chatController.debugState.value!;
      expect(state.length - historyLengthBefore, 1);
      expect(state[0].valueOrNull!.isFromBot, true);
      expect(state[0].valueOrNull!.content, content);

      final history = await mockChatHistoryRepository.readChatHistory(testUserId, testChatJournalEntryId);
      expect(history.length - historyLengthBefore, 1);
      expect(history[0].isFromBot, true);
      expect(history[0].content, content);
      expect(state[0].value!.id, isNotNull);
    });

    test('addLoadingBotChatMessage should add a loading message to the chat history', () async {
      final historyLengthBefore = (await mockChatHistoryRepository.readChatHistory(testUserId, testChatJournalEntryId)).length;

      // Act
      chatController.addLoadingBotChatMessage();

      // Assert
      final state = chatController.debugState.value!;
      expect(state.length - historyLengthBefore, 1);
      expect(state[0] is AsyncLoading, true);
    });

    test('writeBotChatMessage should replace the loading bot chat message', () async {
      // Arrange
      const content = 'Hello, this is longer a bot message.';
      // Act
      final loading = chatController.addLoadingBotChatMessage();
      await chatController.writeBotChatMessage(content);

      // Assert
      final state = chatController.debugState.value!;
      expect(state.length, 3);
      expect(state.contains(loading), false);
      expect(state[0] is AsyncData, true);
      expect(state[0].value!.id, isNotNull);
    });
  });
}
