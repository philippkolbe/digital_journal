import 'package:app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class AuthState {
  final UserObj currentUser;
  final User firestoreUser;

  AuthState(this.currentUser, this.firestoreUser);
}
