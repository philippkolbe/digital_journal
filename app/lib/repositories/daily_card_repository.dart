import 'package:app/models/daily_card.dart';
import 'package:app/providers/encrypter_provider.dart';
import 'package:app/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dailyCardRepositoryProvider =
    Provider<BaseDailyCardRepository>((Ref ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  final encrypterFuture = ref.watch(encrypterFutureProvider);
  return DailyCardRepository(firestore, encrypterFuture);
});

abstract class BaseDailyCardRepository {
  Future<DailyCardObj> createDailyCard(String userId, DailyCardObj dailyCard);
  Future<List<DailyCardObj>> readDailyCardsByDate(String userId, DateTime date);
  Future<DailyCardObj> readDailyCard(String userId, String dailyCardId);
  Future<DailyCardObj> updateDailyCard(String userId, DailyCardObj dailyCard);
  Future<void> deleteDailyCard(String userId, String dailyCardId);
}

class DailyCardRepository implements BaseDailyCardRepository {
  final FirebaseFirestore _firestore;
  final Future<BaseEncrypter> _encrypter;

  DailyCardRepository(this._firestore, this._encrypter);

  @override
  Future<DailyCardObj> createDailyCard(
      String userId, DailyCardObj dailyCard) async {
    try {
      final collection = _getDailyCardCollection(userId);
      final doc =
          _convertDailyCardToDocument(dailyCard, encrypter: await _encrypter);

      final id = await _addOrSetDocument(collection, doc, dailyCard.id);

      return dailyCard.copyWith(id: id);
    } catch (e) {
      throw DailyCardException('An error occurred while creating an dailyCard',
          userId: userId, dailyCardId: dailyCard.id);
    }
  }

  @override
  Future<List<DailyCardObj>> readDailyCardsByDate(
      String userId, DateTime date) async {
    try {
      final snapshot = await _getDailyCardCollection(userId)
          .where(
            'date',
            isEqualTo:
                Timestamp.fromDate(DateTime(date.year, date.month, date.day)),
          )
          .orderBy('order', descending: true)
          .get();

      final encrypter = await _encrypter;
      return snapshot.docs
          .map((doc) => _convertDocumentToDailyCard(doc, encrypter: encrypter))
          .toList();
    } catch (e) {
      throw DailyCardException('An error occurred while reading the dailyCard.',
          userId: userId);
    }
  }

  @override
  Future<DailyCardObj> readDailyCard(String userId, String dailyCardId) async {
    try {
      final doc = await _getDailyCardCollection(userId).doc(dailyCardId).get();

      return await _convertDocumentToDailyCard(doc,
          encrypter: await _encrypter);
    } catch (e) {
      throw DailyCardException('An error occurred while reading the dailyCard.',
          userId: userId);
    }
  }

  @override
  Future<DailyCardObj> updateDailyCard(
      String userId, DailyCardObj dailyCard) async {
    try {
      assert(dailyCard.id != null, 'Define an dailyCard id for updating it.');
      final collection = _getDailyCardCollection(userId);
      final doc =
          _convertDailyCardToDocument(dailyCard, encrypter: await _encrypter);

      await collection.doc(dailyCard.id).update(doc);

      // Retrieve and decrypt the updated dailyCard
      final updatedDailyCard = await readDailyCard(userId, dailyCard.id!);

      return updatedDailyCard;
    } catch (e) {
      throw DailyCardException('An error occurred while updating the dailyCard',
          userId: userId, dailyCardId: dailyCard.id);
    }
  }

  @override
  Future<void> deleteDailyCard(String userId, String dailyCardId) async {
    try {
      await _getDailyCardCollection(userId).doc(dailyCardId).delete();
    } catch (e) {
      throw DailyCardException('An error occurred while deleting the dailyCard',
          userId: userId, dailyCardId: dailyCardId);
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

  DailyCardObj _convertDocumentToDailyCard(DocumentSnapshot<Object?> doc,
      {required BaseEncrypter encrypter}) {
    final encryptedObj = DailyCardObj.fromDocument(doc);
    if (encryptedObj is PersonalityPromptDailyCardObj &&
        encryptedObj.prompt != null) {
      return encryptedObj.copyWith(
        // Decrypt any sensitive field here
        prompt: encrypter.decrypt(encryptedObj.prompt!),
      );
    } else {
      return encryptedObj;
    }
  }

  Map<String, dynamic> _convertDailyCardToDocument(DailyCardObj dailyCard,
      {required BaseEncrypter encrypter}) {
    DailyCardObj encrypted = dailyCard;
    if (dailyCard is PersonalityPromptDailyCardObj &&
        dailyCard.prompt != null) {
      encrypted = dailyCard.copyWith(
        prompt: encrypter.encrypt(dailyCard.prompt!),
      );
    }
    return encrypted.toDocument();
  }

  CollectionReference _getDailyCardCollection(String userId) {
    return _firestore.collection('users').doc(userId).collection('dailyCards');
  }
}

class DailyCardException implements Exception {
  String message;
  String userId;
  String? dailyCardId;
  DailyCardException(String message, {required this.userId, this.dailyCardId})
      : message =
            '$message. UserId: $userId. ${dailyCardId != null ? 'DailyCardId: $dailyCardId' : ''}';
}
