import 'package:app/controllers/auth_state.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/models/user.dart';
import 'package:app/repositories/auth_repository.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<AuthState?>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  return AuthController(authRepository, userRepository)..appStarted();
});

class AuthController extends StateNotifier<AsyncValue<AuthState?>> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthController(this._authRepository, this._userRepository) : super(const AsyncData(null));

  void appStarted() {
    _authRepository.authStateChanges.listen(onAuthStateChanged);
    signInAnonymously();
  }

  void onAuthStateChanged(firebaseUser) async {
    try {
      print("Auth state $firebaseUser");
      if (firebaseUser != null) {
        state = const AsyncLoading();
        final currentUser = await _fetchOrCreateCurrentUser(firebaseUser);
        state = AsyncData(AuthState(currentUser, firebaseUser));
      } else {
        state = const AsyncData(null);
      }
    } catch (e) {
      print('Failed to fetch current user: $e');
      state = AsyncError('An error occured while loading your data.', StackTrace.current);
    }
  }

  Future<UserObj> _fetchOrCreateCurrentUser(User firebaseUser) async {
    final currentUser = await _fetchUser(firebaseUser);
    return currentUser ?? await _createUser(firebaseUser);
  }

  Future<UserObj?> _fetchUser(User firebaseUser) {
    return _userRepository.readUser(firebaseUser.uid);
  }

  Future<UserObj> _createUser(User firebaseUser) async {
    final createdUserObj = UserObj.fromFirebaseUser(firebaseUser);
    await _userRepository.createUser(createdUserObj);
    return createdUserObj;
  }


  Future<void> signInAnonymously() async {
    try {
      state = const AsyncLoading();
      await _authRepository.signInAnonymously();
    } catch (e) {
      print('Failed to sign in anonymously: $e');
      state = AsyncError('An error occurred while signing in.', StackTrace.current);
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