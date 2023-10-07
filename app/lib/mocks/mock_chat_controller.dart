import 'package:app/controllers/chat_controller.dart';
import 'package:app/mocks/data/firebase_test_data.dart';
import 'package:app/mocks/mock_chat_history_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockChatController extends ChatController {
  /// initializeEmpty = false -> then the respository will load a default value of 2 items
  MockChatController({ bool initializeEmpty = false }) : super(
    testUserId,
    AsyncData(testChatJournalEntry),
    MockChatHistoryRepository(
      chatHistory: initializeEmpty ? [] : null
    ),
  );
}