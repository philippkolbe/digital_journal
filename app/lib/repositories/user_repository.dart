import 'package:app/providers/general_providers.dart';

import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final firebaseFirestore = ref.watch(firebaseFirestoreProvider);
 
  return UserRepository(firebaseFirestore);
});

abstract class BaseUserRepostory {
  Future<void> createUser(UserObj user);
  Future<UserObj?> readUser(String id);
}

class UserRepository implements BaseUserRepostory {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository(this._firebaseFirestore);

  get _userCollection => _firebaseFirestore.collection('users');

  @override
  Future<void> createUser(UserObj user) async {
    await _userCollection.doc(user.id).set(user.toJson());
  }

  @override
  Future<UserObj?> readUser(String id) async {
    final userDoc = await _userCollection.doc(id).get();
    if (userDoc.exists) {
      return UserObj.fromDocument(userDoc);
    }
    return null;
  }  
}
