import 'package:app/models/information.dart';
import 'package:app/providers/encrypter_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:app/repositories/information_repository.dart';

import 'firebase_test_data.dart';

void main() {
  group('InformationRepository', () {
    late FakeFirebaseFirestore firestore;
    late BaseInformationRepository repository;
    late Future<Encrypter> encrypter;

    setUp(() {
      firestore = setupFakeFirestore(user: true, information: true);
      encrypter = Future.value(Encrypter('my-test-key-1234'));
      repository = InformationRepository(firestore, encrypter);
    });

    test('createInformation should add a new information to the collection', () async {
      // Prepare test data
      final informationObj = InformationObj(
        description: 'My information description',
        date: DateTime.now(),
        expirationDate: DateTime.now().add(const Duration(days: 30)),
        importance: 5,
      );

      // Execute the method
      final newInformation = await repository.createInformation(testUserId, informationObj);

      // Verify the result
      expect(newInformation.id, isNotEmpty);

      // Check if the information is added to the collection
      final informationCollection = firestore
          .collection('users')
          .doc(testUserId)
          .collection('information');

      final snapshot = await informationCollection.doc(newInformation.id).get();
      expect(snapshot.exists, isTrue);
      expect((await encrypter).decrypt(snapshot.data()!['description']), informationObj.description);
    });

    test('readAllInformation should retrieve all information for a user', () async {
      final information = await repository.readAllInformation(testUserId);

      expect(information, isList);
      expect(information.isNotEmpty, isTrue);
      // Add more assertions here based on your InformationObj structure.
    });

    test('readInformation should retrieve a specific information for a user', () async {
      // Execute the method
      final information = await repository.readInformation(testUserId, testInformationId);

      expect(information, isNotNull);
  
      expect(information.description, testInformationObj.description);
      expect(information.date, testInformationObj.date);
      expect(information.expirationDate, testInformationObj.expirationDate);
      expect(information.importance, testInformationObj.importance);
    });

    test('updateInformation should update an information', () async {
      // Prepare test data
      const updatedDescription = 'Updated Information Description';
      final updatedInformationObj = testInformationObj.copyWith(
        description: updatedDescription,
      );

      // Execute the method
      final updatedInformation = await repository.updateInformation(testUserId, updatedInformationObj);

      expect(updatedInformation, isNotNull);
      expect(updatedInformation.description, updatedDescription);
      expect(updatedInformation.date, testInformationObj.date);
      expect(updatedInformation.expirationDate, testInformationObj.expirationDate);
      expect(updatedInformation.importance, testInformationObj.importance);
      // Add more assertions here based on your InformationObj structure.
    });

    test('deleteInformation should delete an information', () async {
      // Execute the method
      await repository.deleteInformation(testUserId, testInformationId);

      // Check if the information is deleted from the collection
      final informationCollection = firestore
          .collection('users')
          .doc(testUserId)
          .collection('information')
          .doc(testInformationId);

      final snapshot = await informationCollection.get();
      expect(snapshot.exists, isFalse);
    });
  });
}
