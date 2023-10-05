import 'package:app/models/attribute.dart';
import 'package:app/providers/encrypter_provider.dart';
import 'package:app/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final attributeRepositoryProvider = Provider<BaseAttributeRepository>((Ref ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  final encrypterFuture = ref.watch(encrypterFutureProvider);
  return AttributeRepository(firestore, encrypterFuture);
});

abstract class BaseAttributeRepository {
  Future<String> createAttribute(String userId, AttributeObj attribute);
  Future<List<AttributeObj>> readAllAttributes(String userId);
  Future<AttributeObj> readAttribute(String userId, String attributeId);
  Future<AttributeObj> updateAttribute(String userId, AttributeObj attribute);
  Future<void> deleteAttribute(String userId, String attributeId);
}

class AttributeRepository implements BaseAttributeRepository {
  final FirebaseFirestore _firestore;
  final Future<Encrypter> _encrypter;

  AttributeRepository(this._firestore, this._encrypter);

  @override
  Future<String> createAttribute(String userId, AttributeObj attribute) async {
    try {
      final collection = _getAttributeCollection(userId);
      final doc = attribute
          .copyWith(
            // Encrypt any sensitive field here
            description: (await _encrypter).encrypt(attribute.description),
          )
          .toDocument();

      return _addOrSetDocument(collection, doc, attribute.id);
    } catch (e) {
      throw AttributeException('An error occurred while creating an attribute',
          userId: userId, attributeId: attribute.id);
    }
  }

  @override
  Future<List<AttributeObj>> readAllAttributes(String userId) async {
    try {
      final snapshot =
          await _getAttributeCollection(userId).get();

      final encrypter = await _encrypter;

      return snapshot.docs.map((doc) {
        final encryptedObj = AttributeObj.fromDocument(doc);
        return encryptedObj.copyWith(
          // Decrypt any sensitive field here
          description: encrypter.decrypt(encryptedObj.description),
        );
      }).toList();
    } catch (e) {
      throw AttributeException(
          'An error occurred while reading all attributes',
          userId: userId);
    }
  }

  @override
  Future<AttributeObj> readAttribute(String userId, String attributeId) async {
    try {
      final doc =
          await _getAttributeCollection(userId).doc(attributeId).get();
      final encrypter = await _encrypter;
      final encryptedObj = AttributeObj.fromDocument(doc);

      return encryptedObj.copyWith(
        // Decrypt any sensitive field here
        description: encrypter.decrypt(encryptedObj.description),
      );
    } catch (e) {
      throw AttributeException(
          'An error occurred while reading the attribute.',
          userId: userId);
    }
  }

  @override
  Future<AttributeObj> updateAttribute(
      String userId, AttributeObj attribute) async {
    try {
      assert(
          attribute.id != null, 'Define an attribute id for updating it.');
      final collection = _getAttributeCollection(userId);
      final doc = attribute.toDocument();

      await collection.doc(attribute.id).update(doc);

      // Retrieve and decrypt the updated attribute
      final updatedAttribute = await readAttribute(userId, attribute.id!);

      return updatedAttribute;
    } catch (e) {
      throw AttributeException(
          'An error occurred while updating the attribute',
          userId: userId, attributeId: attribute.id);
    }
  }

  @override
  Future<void> deleteAttribute(String userId, String attributeId) async {
    try {
      await _getAttributeCollection(userId).doc(attributeId).delete();
    } catch (e) {
      throw AttributeException(
          'An error occurred while deleting the attribute',
          userId: userId, attributeId: attributeId);
    }
  }

  Future<String> _addOrSetDocument(
      CollectionReference collection, Map<String, dynamic> doc, String? id) async {
    if (id != null) {
      await collection.doc(id).set(doc);
      return id;
    } else {
      final newDoc = await collection.add(doc);
      return newDoc.id;
    }
  }

  CollectionReference _getAttributeCollection(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('attributes');
  }
}

class AttributeException implements Exception {
  String message;
  String userId;
  String? attributeId;
  AttributeException(String message, {required this.userId, this.attributeId})
      : message =
            '$message. UserId: $userId. ${attributeId != null ? 'AttributeId: $attributeId' : ''}';
}
