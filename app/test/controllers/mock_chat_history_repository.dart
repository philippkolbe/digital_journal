import 'package:app/models/chat_message.dart';
import 'package:app/repositories/chat_history_repository.dart';

class MockChatHistoryRepository implements BaseChatHistoryRepository {
  final List<ChatMessageObj> chatHistory = [
    ChatMessageObj(id: '1', isFromBot: true, date: DateTime.now(), content: 'Hello tell me about yourself.'),
    ChatMessageObj(id: '2', isFromBot: false, date: DateTime.now(), content: 'Hi Im a test.'),
  ];
  late int idCount;

  MockChatHistoryRepository() {
   idCount = chatHistory.length;
  }

  /// Its assuming that there is only one user and journal entry
  @override
  Future<List<ChatMessageObj>> readChatHistory(String userId, String journalEntryId) {
    return Future.value(chatHistory);
  }

  @override
  Future<ChatMessageObj> createChatMessage(String userId, String journalEntryId, ChatMessageObj entry) {
    final id = entry.id ?? (++idCount).toString();
    final entryWithId = entry.copyWith(id: id);
    chatHistory.add(entryWithId);
    return Future.value(entryWithId);
  }
}