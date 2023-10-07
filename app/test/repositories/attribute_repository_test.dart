import 'package:app/mocks/data/firebase_test_data.dart';
import 'package:app/models/attribute.dart';
import 'package:app/models/attributes_action.dart';
import 'package:app/providers/encrypter_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:app/repositories/attribute_repository.dart';

void main() {
  group('AttributeRepository', () {
    late FakeFirebaseFirestore firestore;
    late BaseAttributeRepository repository;
    late Future<BaseEncrypter> encrypter;

    setUp(() {
      firestore = setupFakeFirestore(user: true, attribute: true);
      encrypter = Future.value(Encrypter('my-test-key-1234'));
      repository = AttributeRepository(firestore, encrypter);
    });

    test('createAttribute should add a new attribute to the collection', () async {
      // Prepare test data
      const overwriteId = 'test_attribute2';
      final attributeObj = testAttributeObj.copyWith(id: overwriteId);

      // Execute the method
      final attributeId = await repository.createAttribute(testUserId, attributeObj);

      // Verify the result
      expect(attributeId, isNotEmpty);

      // Check if the attribute is added to the collection
      final attributeCollection = firestore
          .collection('users')
          .doc(testUserId)
          .collection('attributes');

      final snapshot = await attributeCollection.doc(attributeId).get();
      expect(snapshot.exists, isTrue);
      expect((await encrypter).decrypt(snapshot.data()!['description']), attributeObj.description);
    });

    test('readAllAttributes should retrieve all attributes for a user', () async {
      final attributes = await repository.readAllAttributes(testUserId);

      expect(attributes, isList);
      expect(attributes.isNotEmpty, isTrue);
      expect(attributes.first.description, testAttributeObj.description);
    });

    test('readAttribute should retrieve a specific attribute for a user', () async {
      final attribute = await repository.readAttribute(testUserId, testAttributeId);

      expect(attribute, isNotNull);
      expect(attribute.description, testAttributeObj.description);
    });

    test('updateAttribute should update an attribute', () async {
      // Prepare test data
      const updatedDescription = 'Updated Description';
      final updatedAttributeObj = testAttributeObj.copyWith(description: updatedDescription);

      // Execute the method
      final updatedAttribute = await repository.updateAttribute(testUserId, updatedAttributeObj);

      // Verify the result
      expect(updatedAttribute, isNotNull);
      expect(updatedAttribute.description, updatedDescription);

      // Check if the attribute is updated in the collection
      final attributeCollection = firestore
          .collection('users')
          .doc(testUserId)
          .collection('attributes')
          .doc(updatedAttributeObj.id);

      final snapshot = await attributeCollection.get();
      expect(snapshot.exists, isTrue);
      expect((await encrypter).decrypt(snapshot.data()!['description']), updatedDescription);
    });

    test('deleteAttribute should delete an attribute', () async {
      // Execute the method
      await repository.deleteAttribute(testUserId, testAttributeId);

      // Check if the attribute is deleted from the collection
      final attributeCollection = firestore
          .collection('users')
          .doc(testUserId)
          .collection('attributes')
          .doc(testAttributeId);

      final snapshot = await attributeCollection.get();
      expect(snapshot.exists, isFalse);
    });

    test('applyAttributesActions should create, update and delete attributes', () async {
      const attributeIdToUpdate = testAttributeId;
      const attributeIdToDelete = testFearId;
      const createGoalDescription = 'Get this test to run';
      const updatedDescription = 'I want an update';
      final actions = [
        const AttributesActionObj.create(type: AttributeType.goal, description: createGoalDescription, level: 10),
        const AttributesActionObj.update(id: attributeIdToUpdate, description: updatedDescription, level: 1),
        const AttributesActionObj.delete(id: attributeIdToDelete),
      ];

      // Execute the method
      final attributes = await repository.applyAttributesActions(
        testUserId,
        actions  
      );

      final attributeCollection = firestore
        .collection('users')
        .doc(testUserId)
        .collection('attributes');

      // Check if attribute was created
      final created = attributes.firstWhere((element) => element.description == createGoalDescription);
      expect(created, isNotNull);

      // Check if document was created
      final createdSnapshot = await attributeCollection.doc(created.id).get();
      expect(createdSnapshot.exists, isTrue);
      expect((await encrypter).decrypt(createdSnapshot.data()!['description']), createGoalDescription);

      // Check if was updated 
      final updated = attributes.singleWhere((element) => element.id == attributeIdToUpdate);
      expect(updated.description, equals(updatedDescription));
      expect(updated.level, equals(1));

      // Check if update was applied in collection
      final updatedSnapshot = await attributeCollection.doc(attributeIdToUpdate).get();
      expect(updatedSnapshot.exists, isTrue);
      expect((await encrypter).decrypt(updatedSnapshot.data()!['description']), updatedDescription);

      // Check if deleted
      expect(attributes.every((attr) => attr.id != attributeIdToDelete), isTrue);

      // Check if the attribute is deleted from the collection
      final deletedSnapshot = await attributeCollection.doc(testFearId).get();
      expect(deletedSnapshot.exists, isFalse);
    });
  });
}
