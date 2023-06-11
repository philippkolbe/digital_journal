import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/models/user.dart';

import 'firebase_test_data.dart';

void main() {
  group('UserRepository', () {
    late FakeFirebaseFirestore firestore;
    late BaseUserRepository repository;
    
    setUp(() {
      firestore = FakeFirebaseFirestore();
      repository = UserRepository(firestore);
    });
    
    test('createUser should add a new user to the collection', () async {
      await repository.createUser(testUser);
      
      final userDoc = await firestore.collection('users').doc(testUserId).get();
      expect(userDoc.exists, isTrue);
      expect(userDoc.data(), equals(testUser.toJson()));
    });
    
    test('readUser should retrieve an existing user from the collection', () async {
      const user = UserObj(id: testUserId, name: 'John Doe');
      await firestore.collection('users').doc(testUserId).set(user.toJson());
      
      final retrievedUser = await repository.readUser(testUserId);
      
      expect(retrievedUser, isNotNull);
      expect(retrievedUser!.id, equals(user.id));
      expect(retrievedUser.name, equals(user.name));
    });
    
    test('readUser should return null for a non-existing user', () async {
      const nonExistingUserId = 'nonexistinguser';
      
      final retrievedUser = await repository.readUser(nonExistingUserId);
      
      expect(retrievedUser, isNull);
    });
  });
}
