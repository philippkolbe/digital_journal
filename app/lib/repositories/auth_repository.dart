import 'package:app/providers/general_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<BaseAuthRepository>((ref) {
  final firebaseAuth = ref.read(firebaseAuthProvider);
  return AuthRepository(firebaseAuth);
});

abstract class BaseAuthRepository {
  Future<UserCredential> signInAnonymously();
  Future<void> signOut();
  Stream<User?> get authStateChanges;
}

class AuthRepository implements BaseAuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<UserCredential> signInAnonymously() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      return userCredential;
    } catch (e) {
      print('Signing in anonymously failed: $e');
      throw AuthException('Failed to create anonymous user');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print('Signing out failed: $e');
      throw AuthException('Failed to sign out');
    }
  }
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}
