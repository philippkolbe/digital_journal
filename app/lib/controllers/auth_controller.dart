import 'package:app/controllers/auth_state.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:app/models/user.dart';
import 'package:app/repositories/auth_repository.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  return AuthController(authRepository, userRepository);
});

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthController(this._authRepository, this._userRepository) : super(AuthInitial());

  void init() {
    _authRepository.authStateChanges.listen((firestoreUser) async {
      try {
        if (firestoreUser != null) {
          final currentUser = await _fetchOrCreateCurrentUser(firestoreUser);
          state = AuthAuthenticated(currentUser, firestoreUser);
        } else {
          state = AuthUnauthenticated();
        }
      } catch (e) {
        print('Failed to sign in anonymously: $e');
        state = AuthError('An error occured while fetching current user');
      }
    });
  }

  Future<UserObj> _fetchOrCreateCurrentUser(User firestoreUser) async {
    final currentUser = await _userRepository.readUser(firestoreUser.uid);
    return currentUser ?? await _createUser(firestoreUser);
  }

  Future<UserObj> _createUser(User firestoreUser) async {
    final createdUserObj = UserObj.fromFirestoreUser(firestoreUser);
    await _userRepository.createUser(createdUserObj);
    return createdUserObj;
  }


  Future<void> signInAnonymously() async {
    try {
      await _authRepository.signInAnonymously();
    } catch (e) {
      print('Failed to sign in anonymously: $e');
      state = AuthError('An error occurred while signing in.');
    }
  }

  Future<void> signOut() async {
    try {
      await _authRepository.signOut();
    } catch (e) {
      print('Failed to sign out: $e');
    }
  }
}