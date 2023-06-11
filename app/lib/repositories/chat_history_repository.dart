
import 'package:app/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseChatHistoryRepository {
  Future<String> createChatMessage(String userId, String jornalEntryId, ChatMessageObj chatMessageObj);
  Future<List<ChatMessageObj>> readChatHistory(String userId, String journalEntryId);
}

class ChatHistoryRepository implements BaseChatHistoryRepository {
  final FirebaseFirestore _firestore;

  ChatHistoryRepository(this._firestore);

  @override
  Future<String> createChatMessage(String userId, String journalEntryId, ChatMessageObj chatMessageObj) async {
    try {
      final docRef = await _getChatHistoryCollection(userId, journalEntryId)
        .add(chatMessageObj.toDocument());

      return docRef.id;
    } catch (e) {
      throw ChatHistoryException("Error while creating chat entry for user $userId and journal entry $journalEntryId");
    }
  }

  @override
  Future<List<ChatMessageObj>> readChatHistory(String userId, String journalEntryId) async {
    try {
      final snapshot = await _getChatHistoryCollection(userId, journalEntryId)
        .orderBy('date')
        .get();

      return snapshot.docs.map((doc) => ChatMessageObj.fromDocument(doc)).toList();
    } catch (e) {
      throw ChatHistoryException("Error while reading chat history for user $userId and journal entry $journalEntryId");
    }
  }

  CollectionReference _getChatHistoryCollection(String userId, String journalEntryId) {
    return _firestore
      .collection('users')
      .doc()
      .collection('journalEntries')
      .doc(journalEntryId)
      .collection('chatHistory');
  }
}

class ChatHistoryException implements Exception {
  final String message;

  ChatHistoryException(this.message);
}
