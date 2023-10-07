import 'package:app/controllers/states/auth_state.dart';
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

final userIdProvider = Provider((ref) {
  final authState = ref.watch(authControllerProvider);
  return authState.valueOrNull?.currentUser.id;
});

class AuthController extends StateNotifier<AsyncValue<AuthState?>> {
  final BaseAuthRepository _authRepository;
  final BaseUserRepository _userRepository;

  AuthController(this._authRepository, this._userRepository) : super(const AsyncData(null));

  void appStarted() {
    _authRepository.authStateChangesStream.listen(onAuthStateChanged);
    signInAnonymously();
  }

  void onAuthStateChanged(firebaseUser) async {
    try {
      if (firebaseUser != null) {
        state = const AsyncLoading();
        final currentUser = await _fetchOrCreateCurrentUser(firebaseUser);
        state = AsyncData(AuthState(
          currentUser: currentUser,
          firestoreUser: firebaseUser
        ));
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