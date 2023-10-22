import 'package:app/models/personality.dart';
import 'package:app/providers/encrypter_provider.dart';
import 'package:app/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final personalityRepositoryProvider =
    Provider<BasePersonalityRepository>((Ref ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  final encrypterFuture = ref.watch(encrypterFutureProvider);
  return PersonalityRepository(firestore, encrypterFuture);
});

abstract class BasePersonalityRepository {
  Future<PersonalityObj> createPersonality(
      PersonalityObj personalityObj, { String? userId });
  Future<List<PersonalityObj>> readAllPersonalities({ String? userId });
  Future<PersonalityObj> readPersonality(
      String personalityId, { String? userId });
  Future<PersonalityObj> updatePersonality(
      PersonalityObj personalityObj, { String? userId });
  Future<void> deletePersonality(String personalityId, { String? userId });
}

class PersonalityRepository implements BasePersonalityRepository {
  final FirebaseFirestore _firestore;
  final Future<BaseEncrypter> _encrypter;

  PersonalityRepository(this._firestore, this._encrypter);

  @override
  Future<PersonalityObj> createPersonality(PersonalityObj personalityObj, {
    String? userId,
  }) async {
    try {
      final collection = _getPersonalityCollection(userId);
      final doc = personalityObj
          .copyWith(
            // Encrypt the description field (only of private)
            // description: (await _encrypter).encrypt(personalityObj.description),
          )
          .toDocument();

      if (personalityObj.id != null) {
        collection.doc(personalityObj.id).set(doc);
        return personalityObj;
      } else {
        final newDoc = await collection.add(doc);
        return personalityObj.copyWith(id: newDoc.id);
      }
    } catch (e) {
      throw PersonalityException(
          "Error while creating personality for user $userId");
    }
  }

  @override
  Future<List<PersonalityObj>> readAllPersonalities({String? userId}) async {
    try {
      final snapshot =
          await _getPersonalityCollection(userId).get();

      // final encrypter = await _encrypter;

      return snapshot.docs.map((doc) {
        final encryptedObj = PersonalityObj.fromDocument(doc);
        return encryptedObj.copyWith(
          // Decrypt the description field (only of private)
          // description: encrypter.decrypt(encryptedObj.description),
        );
      }).toList();
    } catch (e) {
      throw PersonalityException(
          "Error while reading all personality for user $userId");
    }
  }

  @override
  Future<PersonalityObj> readPersonality(String personalityId, {
    String? userId,
  }) async {
    try {
      final doc =
          await _getPersonalityCollection(userId).doc(personalityId).get();
      // final encrypter = await _encrypter;
      final encryptedObj = PersonalityObj.fromDocument(doc);

      return encryptedObj.copyWith(
        // Decrypt the description field
        // description: encrypter.decrypt(encryptedObj.description),
      );
    } catch (e) {
      throw PersonalityException(
          "Error while reading personality for user $userId and personalityId $personalityId");
    }
  }

  @override
  Future<PersonalityObj> updatePersonality(PersonalityObj personalityObj, {
    String? userId
  }) async {
    try {
      assert(
          personalityObj.id != null, 'Define an personality id for updating it.');
      final collection = _getPersonalityCollection(userId);
      final doc = personalityObj.toDocument();

      await collection.doc(personalityObj.id).update(doc);

      // Retrieve and decrypt the updated personality
      final updatedPersonality = await readPersonality(personalityObj.id!, userId: userId);

      return updatedPersonality;
    } catch (e) {
      throw PersonalityException(
          "Error while updating personality for user $userId");
    }
  }

  @override
  Future<void> deletePersonality(String personalityId, {
    String? userId,
  }) async {
    try {
      await _getPersonalityCollection(userId).doc(personalityId).delete();
    } catch (e) {
      throw PersonalityException(
          "Error while deleting personality for user $userId and personalityId $personalityId");
    }
  }

  CollectionReference _getPersonalityCollection(String? userId) {
    return _firestore.collection('personalities');
  }
}

class PersonalityException implements Exception {
  final String message;

  PersonalityException(this.message);
}
