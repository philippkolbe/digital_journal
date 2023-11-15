import 'dart:convert';

import 'package:app/controllers/auth_controller.dart';
import 'package:app/providers/dot_env_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final httpClientProvider = Provider((ref) {
  final user = ref.watch(authControllerProvider).valueOrNull?.firestoreUser;
  final env = ref.watch(dotEnvProvider);
  final baseUrl = env['BACKEND_URL'];
  assert(
      baseUrl != null, "Backend Url has to be defined to use AI Http Client");

  return AIHttpClient(baseUrl!, user);
});

class AIHttpClient {
  final String baseUrl;
  final http.Client _httpClient;
  final User? _user;

  AIHttpClient(this.baseUrl, this._user) : _httpClient = http.Client();

  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final idToken = await _getIdToken();
    final headers = {if (idToken != null) 'Authorization': 'Bearer $idToken'};

    return _httpClient.get(url, headers: headers);
  }

  Future<http.Response> post(String endpoint,
      {Map<String, dynamic> body = const {}}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final idToken = await _getIdToken();
    final headers = {
      'Content-Type': 'application/json',
      if (idToken != null) 'Authorization': 'Bearer $idToken'
    };

    final encodedBody = json.encode(body);

    return _httpClient.post(url, headers: headers, body: encodedBody);
  }

  Future<String?>? _getIdToken() {
    return _user?.getIdToken();
  }
}
