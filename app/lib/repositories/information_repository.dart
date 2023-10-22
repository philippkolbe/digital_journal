import 'package:app/models/information.dart';
import 'package:app/providers/encrypter_provider.dart';
import 'package:app/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final informationRepositoryProvider =
    Provider<BaseInformationRepository>((Ref ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  final encrypterFuture = ref.watch(encrypterFutureProvider);
  return InformationRepository(firestore, encrypterFuture);
});

abstract class BaseInformationRepository {
  Future<InformationObj> createInformation(
      String userId, InformationObj informationObj);
  Future<List<InformationObj>> readAllInformation(String userId);
  Future<InformationObj> readInformation(
      String userId, String informationId);
  Future<InformationObj> updateInformation(
      String userId, InformationObj informationObj);
  Future<void> deleteInformation(String userId, String informationId);
}

class InformationRepository implements BaseInformationRepository {
  final FirebaseFirestore _firestore;
  final Future<BaseEncrypter> _encrypter;

  InformationRepository(this._firestore, this._encrypter);

  @override
  Future<InformationObj> createInformation(
      String userId, InformationObj informationObj) async {
    try {
      final collection = _getInformationCollection(userId);
      final doc = informationObj
          .copyWith(
            // Encrypt the description field
            description: (await _encrypter).encrypt(informationObj.description),
          )
          .toDocument();

      if (informationObj.id != null) {
        collection.doc(informationObj.id).set(doc);
        return informationObj;
      } else {
        final newDoc = await collection.add(doc);
        return informationObj.copyWith(id: newDoc.id);
      }
    } catch (e) {
      throw InformationException(
          "Error while creating information for user $userId");
    }
  }

  @override
  Future<List<InformationObj>> readAllInformation(String userId) async {
    try {
      final snapshot =
          await _getInformationCollection(userId).orderBy('date').get();

      final encrypter = await _encrypter;

      return snapshot.docs.map((doc) {
        final encryptedObj = InformationObj.fromDocument(doc);
        return encryptedObj.copyWith(
          // Decrypt the description field
          description: encrypter.decrypt(encryptedObj.description),
        );
      }).toList();
    } catch (e) {
      throw InformationException(
          "Error while reading all information for user $userId");
    }
  }

  @override
  Future<InformationObj> readInformation(
      String userId, String informationId) async {
    try {
      final doc =
          await _getInformationCollection(userId).doc(informationId).get();
      final encrypter = await _encrypter;
      final encryptedObj = InformationObj.fromDocument(doc);

      return encryptedObj.copyWith(
        // Decrypt the description field
        description: encrypter.decrypt(encryptedObj.description),
      );
    } catch (e) {
      throw InformationException(
          "Error while reading information for user $userId and informationId $informationId");
    }
  }

  @override
  Future<InformationObj> updateInformation(
      String userId, InformationObj informationObj) async {
    try {
      assert(
          informationObj.id != null, 'Define an information id for updating it.');
      final collection = _getInformationCollection(userId);
      final doc = informationObj.toDocument();

      // TODO: Encrypt
      await collection.doc(informationObj.id).update(doc);

      // Retrieve and decrypt the updated information
      final updatedInformation = await readInformation(userId, informationObj.id!);

      return updatedInformation;
    } catch (e) {
      throw InformationException(
          "Error while updating information for user $userId");
    }
  }

  @override
  Future<void> deleteInformation(String userId, String informationId) async {
    try {
      await _getInformationCollection(userId).doc(informationId).delete();
    } catch (e) {
      throw InformationException(
          "Error while deleting information for user $userId and informationId $informationId");
    }
  }

  CollectionReference _getInformationCollection(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('information');
  }
}

class InformationException implements Exception {
  final String message;

  InformationException(this.message);
}
