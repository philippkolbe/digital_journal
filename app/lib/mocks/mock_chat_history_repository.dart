import 'package:app/models/chat_message.dart';
import 'package:app/repositories/chat_history_repository.dart';

class MockChatHistoryRepository implements BaseChatHistoryRepository {
  late List<ChatMessageObj> chatHistory;
  late int idCount;

  MockChatHistoryRepository({ List<ChatMessageObj>? chatHistory }) {
    this.chatHistory = chatHistory ?? [
      ChatMessageObj.user(id: '2', date: DateTime(2023, 6, 16, 10, 51), content: 'Hi Im a test.'),
      ChatMessageObj.assistant(id: '1', date: DateTime(2023, 6, 16, 10, 50), content: 'Hello tell me about yourself.'),
    ];
    idCount = this.chatHistory!.length;
  }

  /// Its assuming that there is only one user and journal entry
  @override
  Future<List<ChatMessageObj>> readChatHistory(String userId, String journalEntryId) {
    return Future.value([...chatHistory]..sort((a, b) => b.date.compareTo(a.date)));
  }

  @override
  Future<ChatMessageObj> createChatMessage(String userId, String journalEntryId, ChatMessageObj entry) {
    final id = entry.id ?? (++idCount).toString();
    final entryWithId = entry.copyWith(id: id);
    chatHistory.add(entryWithId);
    return Future.value(entryWithId);
  }

  @override
  Future<void> deleteChatHistory(String userId, String journalEntryId) {
    chatHistory = [];
    return Future.value();
  }
}