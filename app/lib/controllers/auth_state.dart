import 'package:app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  final UserObj currentUser;
  final User firestoreUser;

  AuthState(this.currentUser, this.firestoreUser);
}
