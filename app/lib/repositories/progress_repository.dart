import 'package:app/models/progress.dart';
import 'package:app/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final progressRepositoryProvider = Provider<BaseProgressRepository>((Ref ref) {
  final firestore = ref.read(firebaseFirestoreProvider);

  return ProgressRepository(firestore);
});

abstract class BaseProgressRepository {
  Future<String> createProgress(String userId, ProgressObj progress);
  Future<List<ProgressObj>> readAllProgressions(String userId);
  Future<void> updateProgress(String userId, ProgressObj progress);
  Future<void> deleteProgress(String userId, String progressId);
}

class ProgressRepository implements BaseProgressRepository {
  final FirebaseFirestore _firestore;

  ProgressRepository(this._firestore);

  @override
  Future<String> createProgress(String userId, ProgressObj progress) async {
    try {
      final collection = _getProgressCollection(userId);
      final doc = progress.toDocument();

      return _addOrSetDocument(collection, doc, progress.id);
    } catch (e) {
      throw ProgressException('An error occurred while creating a progress',
          userId: userId, progressId: progress.id);
    }
  }

  @override
  Future<List<ProgressObj>> readAllProgressions(String userId) async {
    try {
      final snapshot = await _getProgressCollection(userId).get();
      return snapshot.docs.map((doc) => ProgressObj.fromDocument(doc)).toList();
    } catch (e) {
      throw ProgressException(
          'An error occurred while reading all progressions',
          userId: userId);
    }
  }

  @override
  Future<void> updateProgress(String userId, ProgressObj progress) async {
    try {
      assert(progress.id != null, 'Define a progress id for updating it.');
      await _getProgressCollection(userId)
          .doc(progress.id)
          .update(progress.toDocument());
    } catch (e) {
      throw ProgressException('An error occurred while updating the progress',
          userId: userId, progressId: progress.id);
    }
  }

  @override
  Future<void> deleteProgress(String userId, String progressId) async {
    try {
      await _getProgressCollection(userId).doc(progressId).delete();
    } catch (e) {
      throw ProgressException('An error occurred while deleting the progress',
          userId: userId, progressId: progressId);
    }
  }

  Future<String> _addOrSetDocument(CollectionReference collection,
      Map<String, dynamic> doc, String? id) async {
    if (id != null) {
      await collection.doc(id).set(doc);
      return id;
    } else {
      final newDoc = await collection.add(doc);
      return newDoc.id;
    }
  }

  CollectionReference _getProgressCollection(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('progressions');
  }
}

class ProgressException implements Exception {
  String message;
  String userId;
  String? progressId;
  ProgressException(String message, {required this.userId, this.progressId})
      : message =
            '$message. UserId: $userId. ${progressId != null ? 'ProgressId: $progressId' : ''}';
}
