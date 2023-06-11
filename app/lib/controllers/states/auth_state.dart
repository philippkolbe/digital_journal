import 'package:app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    required UserObj currentUser,
    required User firestoreUser,
  }) = _AuthState;
}
