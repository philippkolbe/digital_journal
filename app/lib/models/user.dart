import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserObj with _$User {
  const factory UserObj({
    required String id,
    String? name,
  }) = _User;

  factory UserObj.fromFirebaseUser(auth.User user) => UserObj(
    id: user.uid,
    name: user.displayName ?? 'Anonymous',  
  );

  factory UserObj.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory UserObj.fromDocument(DocumentSnapshot doc) => UserObj(
    id: doc.id,
    name: doc['name'] ?? 'Anonymous',
  );
}
