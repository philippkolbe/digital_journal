import 'package:app/mocks/data/firebase_test_data.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/repositories/chat_history_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/controllers/chat_controller.dart';

import 'package:app/mocks/mock_chat_history_repository.dart';

void main() {
  late ChatController chatController;
  late BaseChatHistoryRepository mockChatHistoryRepository;

  group('ChatController', () { 

    setUp(() {
      mockChatHistoryRepository = MockChatHistoryRepository();
      chatController = ChatController(
        testUserId,
        testChatJournalEntryId,
        AsyncValue.data(testChatJournalEntry),
        mockChatHistoryRepository,
      );
    });

    test('writeUserChatMessage should add a user chat message to the chat history', () async {
      // Arrange
      const content = 'Hello, this is a user message';

      final historyLengthBefore = (await mockChatHistoryRepository.readChatHistory(testUserId, testChatJournalEntryId)).length;

      expect(chatController.debugState.value!.wasModifiedByUser, isFalse);
      // Act
      await chatController.writeUserChatMessage(content);

      // Assert
      expect(chatController.debugState.value!.wasModifiedByUser, isTrue);

      final state = chatController.debugState.value!.chat;
      expect(state.length - historyLengthBefore, 1);
      expect(state[0].valueOrNull, isA<UserChatMessageObj>());
      expect(state[0].valueOrNull!.content, content);

      final history = await mockChatHistoryRepository.readChatHistory(testUserId, testChatJournalEntryId);
      expect(history.length - historyLengthBefore, 1);
      expect(history[0], isA<UserChatMessageObj>());
      expect(history[0].content, content);
    });

    test('writeBotChatMessage should add a bot chat message to the chat history', () async {
      // Arrange
      final botChatMessage = testChatBotMessageObj;
      final content = botChatMessage.content;

      final historyLengthBefore = (await mockChatHistoryRepository.readChatHistory(testUserId, testChatJournalEntryId)).length;

      // Act
      await chatController.writeAssistantChatMessage(AsyncData(botChatMessage));


      // Assert
      expect(chatController.debugState.value!.wasModifiedByUser, isFalse);

      final state = chatController.debugState.value!.chat;
      expect(state.length - historyLengthBefore, 1);
      expect(state[0].valueOrNull, isA<AssistantChatMessageObj>());
      expect(state[0].valueOrNull!.content, content);

      final history = await mockChatHistoryRepository.readChatHistory(testUserId, testChatJournalEntryId);
      expect(history.length - historyLengthBefore, 1);
      expect(history[0], isA<AssistantChatMessageObj>());
      expect(history[0].content, content);
      expect(state[0].value!.id, isNotNull);
    });

    test('addLoadingBotChatMessage should add a loading message to the chat history', () async {
      final historyLengthBefore = (await mockChatHistoryRepository.readChatHistory(testUserId, testChatJournalEntryId)).length;

      // Act
      chatController.addLoadingAssistantChatMessage();

      // Assert
      expect(chatController.debugState.value!.wasModifiedByUser, isFalse);

      final state = chatController.debugState.value!.chat;
      expect(state.length - historyLengthBefore, 1);
      expect(state[0] is AsyncLoading, true);
    });

    test('writeBotChatMessage should replace the loading bot chat message', () async {
      // Arrange
      final botChatMessage = testChatBotMessageObj;
      // Act
      final loading = chatController.addLoadingAssistantChatMessage();
      await chatController.writeAssistantChatMessage(AsyncData(botChatMessage));


      // Assert
      expect(chatController.debugState.value!.wasModifiedByUser, isFalse);
      
      final state = chatController.debugState.value!.chat;
      expect(state.length, 3);
      expect(state.contains(loading), false);
      expect(state[0] is AsyncData, true);
      expect(state[0].value!.id, isNotNull);
    });

    test('addErrorBotChatMessage should replace the loading bot chat message', () async {
      // Arrange
      final error = Error();
      final st = StackTrace.current;
      // Act
      final loading = chatController.addLoadingAssistantChatMessage();
      chatController.writeAssistantChatMessage(AsyncError(error, st));

      // Assert
      expect(chatController.debugState.value!.wasModifiedByUser, isFalse);

      final state = chatController.debugState.value!.chat;
      expect(state.length, 3);
      expect(state.contains(loading), false);
      expect(state[0] is AsyncError, true);
    });
  });
}
