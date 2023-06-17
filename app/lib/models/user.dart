import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat_types;

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class UserObj with _$UserObj {
  const UserObj._();

  const factory UserObj({
    required String id,
    String? name,
  }) = _User;

  factory UserObj.fromFirebaseUser(auth.User user) => UserObj(
    id: user.uid,
    name: user.displayName ?? 'Anonymous',  
  );

  factory UserObj.fromJson(Map<String, dynamic> json) => _$UserObjFromJson(json);

  factory UserObj.fromDocument(DocumentSnapshot doc) => UserObj(
    id: doc.id,
    name: doc['name'] ?? 'Anonymous',
  );

  Map<String, dynamic> toDocument() {
    final json = toJson();
    return json..remove('id');
  }

  chat_types.User toChatUser() {
    return chat_types.User(
      id: id,
      firstName: name,
    );
  }
}
