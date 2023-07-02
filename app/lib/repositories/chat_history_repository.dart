
import 'package:app/models/chat_message.dart';
import 'package:app/providers/encrypter_provider.dart';
import 'package:app/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatHistoryRepositoryProvider = Provider<BaseChatHistoryRepository>((Ref ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  final encrypter = ref.read(encrypterProvider);
  return ChatHistoryRepository(firestore, encrypter);
});

abstract class BaseChatHistoryRepository {
  Future<ChatMessageObj> createChatMessage(String userId, String jornalEntryId, ChatMessageObj chatMessageObj);
  Future<List<ChatMessageObj>> readChatHistory(String userId, String journalEntryId);
  Future<void> deleteChatHistory(String userId, String journalEntryId);
}

class ChatHistoryRepository implements BaseChatHistoryRepository {
  final FirebaseFirestore _firestore;
  final Encrypter _encrypter;

  ChatHistoryRepository(this._firestore, this._encrypter);

  @override
  Future<ChatMessageObj> createChatMessage(String userId, String journalEntryId, ChatMessageObj chatMessageObj) async {
    try {
      final collection = _getChatHistoryCollection(userId, journalEntryId);
      final doc = chatMessageObj
        .copyWith(
          content: _encrypter.encrypt(chatMessageObj.content),
        )
        .toDocument();

      if (chatMessageObj.id != null) {
        collection.doc(chatMessageObj.id).set(doc);
        return chatMessageObj;
      } else {
        final newDoc = await collection.add(doc);
        return chatMessageObj.copyWith(id: newDoc.id);
      }
    } catch (e) {
      throw ChatHistoryException("Error while creating chat entry for user $userId and journal entry $journalEntryId");
    }
  }

  @override
  Future<List<ChatMessageObj>> readChatHistory(String userId, String journalEntryId) async {
    try {
      final snapshot = await _getChatHistoryCollection(userId, journalEntryId)
        .orderBy('date', descending: true)
        .get();

      return snapshot.docs.map((doc) {
        final encryptedObj = ChatMessageObj.fromDocument(doc);
        return encryptedObj.copyWith(
          content: _encrypter.decrypt(encryptedObj.content),
        );
      }).toList();
    } catch (e) {
      throw ChatHistoryException("Error while reading chat history for user $userId and journal entry $journalEntryId");
    }
  }

  @override
  Future<void> deleteChatHistory(String userId, String journalEntryId) async {
    try {
      final snapshot = await _getChatHistoryCollection(userId, journalEntryId).get();

      final batch = _firestore.batch();

      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      throw ChatHistoryException("Error while deleting chat history for user $userId and journal entry $journalEntryId");
    }
  }

  CollectionReference _getChatHistoryCollection(String userId, String journalEntryId) {
    return _firestore
      .collection('users')
      .doc(userId)
      .collection('journalEntries')
      .doc(journalEntryId)
      .collection('chatHistory');
  }
}

class ChatHistoryException implements Exception {
  final String message;

  ChatHistoryException(this.message);
}
