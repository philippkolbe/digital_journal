import 'dart:convert';

import 'package:app/providers/http_client_provider.dart';
import 'package:app/repositories/ai_repository.dart';
import 'package:http/src/response.dart';

import 'ai_api_test_data.dart';

class MockHttpClient implements AIHttpClient {
  @override
  final baseUrl = 'mock';
  @override
  final idToken = 'mock';

  @override
  Future<Response> get(String endpoint) {
    throw UnimplementedError('Endpoint $endpoint unimplemented for GET from MockHttpClient');
  }

  @override
  Future<Response> post(String endpoint, {Map<String, dynamic> body = const {}}) {
    if (endpoint == AIRepository.chatRoute) {
      return Future.value(Response(
        jsonEncode(mockChatResponseBody),
        200,
      ));
    } else {
      throw UnimplementedError('Endpoint $endpoint unimplemented for POST to MockHttpClient');
    }
  }
}