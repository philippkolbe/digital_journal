import 'dart:convert';

import 'package:app/mocks/data/ai_api_test_data.dart';
import 'package:app/providers/http_client_provider.dart';
import 'package:app/services/ai_service.dart';
// ignore: implementation_imports
import 'package:http/src/response.dart';

class MockHttpClient implements AIHttpClient {
  @override
  final baseUrl = 'mock';
  final idToken = 'mock';

  @override
  Future<Response> get(String endpoint) {
    throw UnimplementedError('Endpoint $endpoint unimplemented for GET from MockHttpClient');
  }

  @override
  Future<Response> post(String endpoint, {Map<String, dynamic> body = const {}}) {
    if (endpoint == AIService.chatRoute) {
      return Future.value(Response(
        jsonEncode(mockChatResponseBody),
        200,
      ));
    } else {
      throw UnimplementedError('Endpoint $endpoint unimplemented for POST to MockHttpClient');
    }
  }
}