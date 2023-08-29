import 'dart:convert';

import 'package:app/providers/dot_env_provider.dart';
import 'package:app/providers/id_auth_token_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final httpClientProvider = Provider((ref) {
  final env = ref.watch(dotEnvProvider);
  final idToken = ref.watch(idAuthTokenProvider);
  final baseUrl = env['BACKEND_URL'];
  assert(baseUrl != null, "Backend Url has to be defined to use AI Http Client");

  return AIHttpClient(baseUrl!, idToken.valueOrNull);
});

class AIHttpClient {
  final String baseUrl;
  final String? idToken;
  final http.Client _httpClient;

  AIHttpClient(this.baseUrl, this.idToken) : _httpClient = http.Client();

  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final headers = {
      if (idToken != null) 'Authorization': 'Bearer $idToken'
    };

    return _httpClient.get(url, headers: headers);
  }

  Future<http.Response> post(String endpoint, {Map<String, dynamic> body = const {}}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      if (idToken != null) 'Authorization': 'Bearer $idToken'
    };

    final encodedBody = json.encode(body);

    return _httpClient.post(url, headers: headers, body: encodedBody);
  }
}