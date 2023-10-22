import 'package:app/models/attribute.dart';
import 'package:app/models/attributes_action.dart';
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
  Future<List<AttributeObj>> applyAttributesActions(String userId, List<AttributesActionObj> actions);
  Future<String> createAttribute(String userId, AttributeObj attribute);
  Future<List<AttributeObj>> readAllAttributes(String userId);
  Future<AttributeObj> readAttribute(String userId, String attributeId);
  Future<AttributeObj> updateAttribute(String userId, AttributeObj attribute);
  Future<void> deleteAttribute(String userId, String attributeId);
}

class AttributeRepository implements BaseAttributeRepository {
  final FirebaseFirestore _firestore;
  final Future<BaseEncrypter> _encrypter;

  AttributeRepository(this._firestore, this._encrypter);

  /// returns the list of all attributes in the repository. 
  @override
  Future<List<AttributeObj>> applyAttributesActions(String userId, List<AttributesActionObj> attributesActions) async {
    try {
      final batch = _firestore.batch();

      final collection = _getAttributeCollection(userId); 
      final encrypter = await _encrypter; 
      for (final action in attributesActions) {
        try {
          _applyAttributesAction(
            action,
            collection,
            batch,
            encrypter,
          );
        } catch (err) {
          // TODO: How should this error be handled? I don't want all of them to be cancelled just because one id is wrong
          print('Error while applying attributeAction $action: ${err.toString()}');
        }
      }

      await batch.commit();
    } catch (err) {
      if (err is FirebaseException && err.code == 'not-found') {
        final all = (await readAllAttributes(userId)).map((e) => e.id);
        final wrongIds = attributesActions.where((act) => act.map(create: (_) => false, update: (u) => !all.contains(u.id), delete: (d) => all.contains(d.id)));
        throw AttributeException('Could not find attributes with ids in attributes batch: ${wrongIds.toString()}',
            userId: userId);
      } else {
        throw AttributeException('An error occurred while applying the attribute action batch: ${err.toString()}',
            userId: userId);
      }
    }

    return readAllAttributes(userId);
  }

  @override
  Future<String> createAttribute(String userId, AttributeObj attribute) async {
    try {
      final collection = _getAttributeCollection(userId);
      final doc = _convertAttributeToDocument(attribute, encrypter: await _encrypter);

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
      final doc = _convertAttributeToDocument(attribute, encrypter: await _encrypter);

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

  void _applyAttributesAction(
    AttributesActionObj attributesAction,
    CollectionReference collection,
    WriteBatch batch,
    BaseEncrypter encrypter,
  ) {
    return attributesAction.map<void>(
      create: (action) => _addAttributeToBatch(
        AttributeObj.fromCreateAction(action),
        collection,
        batch,
        encrypter,
      ),
      update: (action) => _updateAttributeInBatch(
        action,
        collection,
        batch,
        encrypter,  
      ),
      delete: (action) => _deleteAttributeInBatch(
        action.id,
        collection,
        batch
      ),
    );
  }

  void _addAttributeToBatch(
    AttributeObj attribute,
    CollectionReference collection,
    WriteBatch batch,
    BaseEncrypter encrypter,
  ) {
    final doc = attribute.id != null ? collection.doc(attribute.id) : collection.doc();

    batch.set(doc, _convertAttributeToDocument(
      attribute,
      encrypter: encrypter
    ));
  }

  void _updateAttributeInBatch(
    UpdateAttributeObj update,
    CollectionReference collection,
    WriteBatch batch,
    BaseEncrypter encrypter,
  ) {
    final doc = collection.doc(update.id);

    final encrypted = update.description != null
      ? update.copyWith(
        description: encrypter.encrypt(update.description!),
      )
      : update;

    final updateMap = Map<String, dynamic>.fromEntries(
      encrypted.toJson()
        .remove('action')
        .entries
        .where((entry) => entry.value != null)
    );

    batch.update(doc, updateMap);
  }

  void _deleteAttributeInBatch(
    String attributeId,
    CollectionReference collection,
    WriteBatch batch,
  ) {
    final doc = collection.doc(attributeId);

    batch.delete(doc);
  }

  Map<String, dynamic> _convertAttributeToDocument(AttributeObj attribute, { required BaseEncrypter encrypter }) {
    return attribute
      .copyWith(
        // Encrypt any sensitive field here
        description: encrypter.encrypt(attribute.description),
      )
      .toDocument();
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
