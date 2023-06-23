import 'package:app/models/progress_entry.dart';
import 'package:app/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final progressEntryRepositoryProvider = Provider<BaseProgressEntryRepository>((Ref ref) {
  final firestore = ref.read(firebaseFirestoreProvider);

  return ProgressEntryRepository(firestore);
});

abstract class BaseProgressEntryRepository {
  Future<String> createProgressEntry(String userId, String progressId, ProgressEntryObj progressEntry);
  Future<List<ProgressEntryObj>> readAllProgressEntries(String userId, String progressId);
  Future<ProgressEntryObj> readProgressEntry(String userId, String progressId, String progressEntryId);
  Future<ProgressEntryObj> updateProgressEntry(String userId, String progressId, ProgressEntryObj progressEntry);
  Future<void> deleteProgressEntry(String userId, String progressId, String progressEntryId);
}

class ProgressEntryRepository implements BaseProgressEntryRepository {
  final FirebaseFirestore _firestore;

  ProgressEntryRepository(this._firestore);

  @override
  Future<String> createProgressEntry(String userId, String progressId, ProgressEntryObj progressEntry) async {
    try {
      final collection = _getProgressEntryCollection(userId, progressId);
      final doc = progressEntry.toDocument();

      return _addOrSetDocument(collection, doc, progressEntry.id);
    } catch (e) {
      throw ProgressEntryException('An error occurred while creating a progress',
          userId: userId, progressId: progressId, progressEntryId: progressEntry.id);
    }
  }

  @override
  Future<List<ProgressEntryObj>> readAllProgressEntries(String userId, String progressId) async {
    try {
      final snapshot =
          await _getProgressEntryCollection(userId, progressId).get();
      return snapshot.docs
          .map((doc) => ProgressEntryObj.fromDocument(doc))
          .toList();
    } catch (e) {
      throw ProgressEntryException('An error occurred while reading all progressions',
          userId: userId, progressId: progressId);
    }
  }

  @override
  Future<ProgressEntryObj> readProgressEntry(String userId, String progressId, String progressEntryId) async {
    try {
      final doc = await _getProgressEntryCollection(userId, progressId)
          .doc(progressEntryId)
          .get();
      return ProgressEntryObj.fromDocument(doc);
    } catch (e) {
      throw ProgressEntryException('An error occurred while reading all progressions',
          userId: userId, progressId: progressId, progressEntryId: progressEntryId);
    }
  }

  @override
  Future<ProgressEntryObj> updateProgressEntry(String userId, String progressId, ProgressEntryObj progressEntry) async {
    try {
      assert(progressEntry.id != null, 'Define a progress entry id for updating it.');
      await _getProgressEntryCollection(userId, progressId)
          .doc(progressEntry.id)
          .update(progressEntry.toDocument());

      return readProgressEntry(userId, progressId, progressEntry.id!);
    } catch (e) {
      throw ProgressEntryException('An error occurred while updating the progress',
          userId: userId, progressId: progressId, progressEntryId: progressEntry.id);
    }
  }

  @override
  Future<void> deleteProgressEntry(String userId, String progressId, String progressEntryId) async {
    try {
      await _getProgressEntryCollection(userId, progressId)
          .doc(progressEntryId)
          .delete();
    } catch (e) {
      throw ProgressEntryException('An error occurred while deleting the progress',
          userId: userId, progressId: progressId);
    }
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

  CollectionReference _getProgressEntryCollection(String userId, String progressId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('progressions')
        .doc(progressId)
        .collection('entries');
  }
}

class ProgressEntryException implements Exception {
  String message;
  String userId;
  String progressId;
  String? progressEntryId;
  ProgressEntryException(
      String message, {required this.userId, required this.progressId, this.progressEntryId})
      : message =
            '$message. UserId: $userId. ProgressId: $progressId. ${progressEntryId != null ? 'ProgressEntryId: $progressId' : ''}';
}
