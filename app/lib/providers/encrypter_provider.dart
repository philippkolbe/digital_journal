import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/providers/encryption_key_provider.dart';
import 'package:encrypt/encrypt.dart' as encr;

final encrypterProvider = Provider((ref) {
  final asyncEncryptionKey = ref.watch(encryptionKeyProvider);
  return asyncEncryptionKey.whenData((encryptionKey) => Encrypter(encryptionKey));
});

final encrypterFutureProvider = Provider((ref) async {
  final encryptionKey = await ref.watch(encryptionKeyFutureProvider);
  return Encrypter(encryptionKey);
});


class Encrypter {
  final _iv = encr.IV.fromLength(16);
  final encr.Key _encryptionKey;
  late final encr.Encrypter _encrypter;

  Encrypter(String key) :
    _encryptionKey = encr.Key.fromUtf8(key) {
      _encrypter = encr.Encrypter(encr.AES(_encryptionKey, mode: encr.AESMode.cbc));
    }

  String encrypt(String text) {
    final encrypted = _encrypter.encrypt(text, iv: _iv);
    return encrypted.base64;
  }

  String decrypt(String encryptedText) {
    try {
      final encrypted = encr.Encrypted.from64(encryptedText);
      return _encrypter.decrypt(encrypted, iv: _iv);
    } catch (e) {
      // This means that it was not encoded originally. Should probably clean the db to prevent these cases.
      return encryptedText;
    }
  }
}