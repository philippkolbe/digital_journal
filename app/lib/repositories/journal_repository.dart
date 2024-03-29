import 'package:app/models/journal_entry.dart';
import 'package:app/providers/encrypter_provider.dart';
import 'package:app/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final journalRepositoryProvider = Provider<BaseJournalRepository>((Ref ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  final encrypterFuture = ref.watch(encrypterFutureProvider);

  return JournalRepository(firestore, encrypterFuture);
});

abstract class BaseJournalRepository {
  Future<String> createSimpleJournalEntry(String userId, SimpleJournalEntryObj entry);
  Future<String> createChatJournalEntry(String userId, ChatJournalEntryObj entry);
  Future<List<JournalEntryObj>> readAllJournalEntries(String userId);
  Future<JournalEntryObj> readJournalEntry(String userId, String entryId);
  Future<JournalEntryObj> updateJournalEntry(String userId, JournalEntryObj entry);
  Future<void> deleteJournalEntry(String userId, String entryId);
}

class JournalRepository implements BaseJournalRepository {
  final FirebaseFirestore _firestore;
  final Future<BaseEncrypter> _encrypter;

  JournalRepository(this._firestore, this._encrypter);

  @override
  Future<String> createSimpleJournalEntry(String userId, SimpleJournalEntryObj entry) async {
    try {
      final collection = _getJournalEntriesCollection(userId);
      final doc = await _createDocData(entry);

      return _addOrSetDocument(collection, doc, entry.id);
    } catch (e) {
      throw JournalException('An error occured while creating a simple journal entry', userId: userId, entryId: entry.id);
    }
  }

  @override
  Future<String> createChatJournalEntry(String userId, ChatJournalEntryObj entry) async {
    try {
      final collection = _getJournalEntriesCollection(userId);
      final doc = await _createDocData(entry);

      return _addOrSetDocument(collection, doc, entry.id);
    } catch (e) {
      throw JournalException('An error occured while creating a chat journal entry', userId: userId, entryId: entry.id);
    }
  }

  @override
  Future<List<JournalEntryObj>> readAllJournalEntries(String userId) async {
    try {
      final snapshot = await _getJournalEntriesCollection(userId)
        .orderBy('date', descending: true)
        .get();
      return Future.wait(snapshot.docs.map(_createJournalEntryObj).toList());
    } catch (e) {
      throw JournalException('An error occured while reading all journal entries', userId: userId);
    }
  }

  @override
  Future<JournalEntryObj> readJournalEntry(String userId, String entryId) async {
    try {
      final docSnapshot = await _getJournalEntriesCollection(userId).doc(entryId).get();
      if (docSnapshot.exists) {
        return _createJournalEntryObj(docSnapshot);
      } else {
        // Entry does not exist
        throw Exception('Journal entry not found.');
      }
    } catch (e) {
      throw JournalException('An error occured while reading the journal entry', userId: userId, entryId: entryId);
    }
  }

  @override
  Future<JournalEntryObj> updateJournalEntry(String userId, JournalEntryObj entry) async {
    try {
      assert(entry.id != null, 'Define an entry id for updating it.');

      await _getJournalEntriesCollection(userId)
        .doc(entry.id)
        .update(await _createDocData(entry));

      return readJournalEntry(userId, entry.id!);
    } catch (e) {
      throw JournalException('An error occured while updating the journal entry', userId: userId, entryId: entry.id);
    }
  }

  @override
  Future<void> deleteJournalEntry(String userId, String entryId) async {
    try {
      await _getJournalEntriesCollection(userId).doc(entryId).delete();
    } catch (e) {
      throw JournalException('An error occured while deleting the journal entry', userId: userId, entryId: entryId);
    }
  }

  Future<Map<String, dynamic>> _createDocData(JournalEntryObj entry) async {
    final encrypter = await _encrypter;
    final data = entry.toDocument();
    if (data['name'] != null) {
      data['name'] = encrypter.encrypt(data['name']);
    }

    if (data['summaryContent'] != null) {
      data['summaryContent'] = encrypter.encrypt(data['summaryContent']);
    }
    
    if (data['content'] != null) {
      data['content'] = encrypter.encrypt(data['content']);
    }

    return data;
  }

  Future<String> _addOrSetDocument(CollectionReference collection, Map<String, dynamic> doc, String? id) async {
    if (id != null) {
      await collection.doc(id).set(doc);
      return id;
    } else {
      final newDoc = await collection.add(doc);
      return newDoc.id;
    }
  }

  Future<JournalEntryObj> _createJournalEntryObj(DocumentSnapshot doc) async {
    final encrypter = await _encrypter;

    var obj = JournalEntryObj.fromDocument(doc);
    if (obj.summary != null) {
      obj = obj.copyWith(
        summary: obj.summary!.copyWith(
          content: encrypter.decrypt(obj.summary!.content),
        ),
      );
    }

    if (obj is SimpleJournalEntryObj && obj.content != null) {
      obj = obj.copyWith(
        content: encrypter.decrypt(obj.content!),
      );
    }

    return obj.copyWith(
      name: encrypter.decrypt(obj.name),
    );
  }

  CollectionReference _getJournalEntriesCollection(String userId) {
    return _firestore
      .collection('users')
      .doc(userId)
      .collection('journalEntries');
  }
}

class JournalException implements Exception {
  String message;
  String userId;
  String? entryId;
  JournalException(String message, { required this.userId, this.entryId }) :
    message = '$message. UserId: $userId. ${entryId != null ? 'EntryId: $entryId' : ''}';
}