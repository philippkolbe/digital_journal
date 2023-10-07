import 'package:app/controllers/chat_controller.dart';
import 'package:app/mocks/data/firebase_test_data.dart';
import 'package:app/mocks/mock_chat_history_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockChatController extends ChatController {
  MockChatController() : super(
    testUserId,
    AsyncData(testChatJournalEntry),
    MockChatHistoryRepository()
  );
}