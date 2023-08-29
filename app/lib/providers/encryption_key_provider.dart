import 'dart:math';

import 'package:app/providers/shared_preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

final encryptionKeyFutureProvider = Provider((ref) async {
  final prefs = await ref.watch(sharedPreferencesFutureProvider);
  // Load the key from local storage
  final encryptionKey = prefs.getString('encryption_key');

  if (encryptionKey != null) {
    // Key exists in local storage
    return encryptionKey;
  } else {
    // Key does not exist, generate a new one and save it to local storage
    final newKey = generateRandomKey();
    await prefs.setString('encryption_key', newKey);
    return newKey;
  }
});

final encryptionKeyProvider = FutureProvider(
  (ref) => ref.watch(encryptionKeyFutureProvider),
);

String generateRandomKey() {
  const keyLength = "please-change-this-soon-to-local".length;
  final random = Random.secure();
  final bytes = List<int>.generate(keyLength, (_) => random.nextInt(256));
  return base64Url.encode(bytes);
}