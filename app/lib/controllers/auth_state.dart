import 'package:app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {
  AuthAuthenticated? get asAuthenticated =>
      this is AuthAuthenticated ? this as AuthAuthenticated : null;
}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserObj currentUser;
  final User firestoreUser;

  AuthAuthenticated(this.currentUser, this.firestoreUser);
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}
