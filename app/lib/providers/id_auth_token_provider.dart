import 'package:app/controllers/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final idAuthTokenProvider = FutureProvider<String?>((ref) {
  final user = ref.watch(authControllerProvider).valueOrNull?.firestoreUser;
  
  return user?.getIdToken();
});
