import 'package:app/models/journal_entry.dart';
import 'package:app/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final journalRepositoryProvider = Provider<BaseJournalRepository>((Ref ref) {
  final firestore = ref.read(firebaseFirestoreProvider);

  return JournalRepository(firestore);
});

abstract class BaseJournalRepository {
  Future<String> createSimpleJournalEntry(String userId, SimpleJournalEntryObj entry);
  Future<String> createChatJournalEntry(String userId, ChatJournalEntryObj entry);
  Future<List<JournalEntryObj>> readAllJournalEntries(String userId);
  Future<JournalEntryObj> readJournalEntry(String userId, String entryId);
  Future<void> updateJournalEntry(String userId, JournalEntryObj entry);
  Future<void> deleteJournalEntry(String userId, String entryId);
}

class JournalRepository implements BaseJournalRepository {
  final FirebaseFirestore _firestore;

  JournalRepository(this._firestore);

  @override
  Future<String> createSimpleJournalEntry(String userId, SimpleJournalEntryObj entry) async {
    try {
      final docRef = await _firestore.collection('users').doc(userId).collection('journalEntries').add(entry.toJson());
      return docRef.id;
    } catch (e) {
      // Handle error
      throw e;
    }
  }

  @override
  Future<String> createChatJournalEntry(String userId, ChatJournalEntryObj entry) async {
    try {
      final docRef = await _firestore.collection('users').doc(userId).collection('journalEntries').add(entry.toJson());
      return docRef.id;
    } catch (e) {
      // Handle error
      throw e;
    }
  }

  @override
  Future<List<JournalEntryObj>> readAllJournalEntries(String userId) async {
    try {
      final snapshot =
          await _firestore.collection('users').doc(userId).collection('journalEntries').get();
      return snapshot.docs.map((doc) => _convertToJournalEntry(doc)).toList();
    } catch (e) {
      // Handle error
      throw e;
    }
  }

  @override
  Future<JournalEntryObj> readJournalEntry(String userId, String entryId) async {
    try {
      final docSnapshot = await _firestore.collection('users').doc(userId).collection('journalEntries').doc(entryId).get();
      if (docSnapshot.exists) {
        return _convertToJournalEntry(docSnapshot);
      } else {
        // Entry does not exist
        throw Exception('Journal entry not found.');
      }
    } catch (e) {
      // Handle error
      throw e;
    }
  }

  @override
  Future<void> updateJournalEntry(String userId, JournalEntryObj entry) async {
    try {
      await _firestore.collection('users').doc(userId).collection('journalEntries').doc(entry.id).update(entry.toJson());
    } catch (e) {
      // Handle error
      throw e;
    }
  }

  @override
  Future<void> deleteJournalEntry(String userId, String entryId) async {
    try {
      await _firestore.collection('users').doc(userId).collection('journalEntries').doc(entryId).delete();
    } catch (e) {
      // Handle error
      throw e;
    }
  }

  JournalEntryObj _convertToJournalEntry(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final type = data['type'] as String;

    if (type == 'simple') {
      return SimpleJournalEntryObj.fromJson(data);
    } else if (type == 'chat') {
      return ChatJournalEntryObj.fromJson(data);
    } else {
      throw Exception('Invalid journal entry type.');
    }
  }
}
