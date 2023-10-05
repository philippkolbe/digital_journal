import 'package:app/providers/encrypter_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:app/repositories/attribute_repository.dart';

import 'firebase_test_data.dart';

void main() {
  group('AttributeRepository', () {
    late FakeFirebaseFirestore firestore;
    late BaseAttributeRepository repository;
    late Future<Encrypter> encrypter;

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
      final attribute = await repository.readAttribute(testUserId, testAttributeObj.id!);

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
  });
}
