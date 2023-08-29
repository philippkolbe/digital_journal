import 'dart:math';

import 'package:app/providers/shared_preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _random = Random();
const _keyLength = 32;

String generateRandomKey() {
  return String.fromCharCodes(
    Iterable.generate(_keyLength, (_) => _chars.codeUnitAt(_random.nextInt(_chars.length)))
  );
}