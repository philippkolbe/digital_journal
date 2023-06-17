import 'dart:convert';

import 'package:app/providers/dot_env_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final httpClientProvider = Provider((ref) {
  final env = ref.watch(dotEnvProvider);
  final baseUrl = env['BACKEND_URL'];
  assert(baseUrl != null, "Backend Url has to be defined to use AI Http Client");

  return AIHttpClient(baseUrl!);
});

class AIHttpClient {
  final String baseUrl;
  final http.Client _httpClient;

  AIHttpClient(this.baseUrl) : _httpClient = http.Client();

  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return _httpClient.get(url);
  }

  Future<http.Response> post(String endpoint, {Map<String, dynamic> body = const {}}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {'Content-Type': 'application/json'};

    final encodedBody = json.encode(body);

    return _httpClient.post(url, headers: headers, body: encodedBody);
  }
}