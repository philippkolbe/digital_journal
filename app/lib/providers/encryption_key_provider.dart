import 'package:app/providers/dot_env_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final encryptionKeyProvider = Provider((ref) {
  final env = ref.watch(dotEnvProvider);
  // TODO: Store key locally
  return env['ENCRYPTION_KEY']!;
});