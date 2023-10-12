import 'dart:convert';

import 'package:app/controllers/auth_controller.dart';
// import 'package:app/mocks/mock_ai_service.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/providers/http_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final aiServiceProvider = Provider<BaseAIService>((ref) {
  final userId = ref.watch(userIdProvider);
  final httpClient = ref.watch(httpClientProvider);
  // return MockAIService();
  return AIService(
    httpClient: httpClient,
    userId: userId
  );
});

abstract class BaseAIService {
  Future<ChatMessageObj> respondToMessage(ChatMessageObj chatMessageObj);
  Future<ChatMessageObj> respondToChat(List<ChatMessageObj> chatMessages);
}

class AIService implements BaseAIService {
  static const String chatRoute = '/chat';
  
  final AIHttpClient httpClient;
  final String? userId;

  AIService({required this.httpClient, required this.userId });

  @override
  Future<ChatMessageObj> respondToMessage(ChatMessageObj chatMessageObj) {
    return respondToChat([chatMessageObj]);
  }

  @override
  Future<ChatMessageObj> respondToChat(List<ChatMessageObj> chatMessages) async {
    try {
      final botResponse = await _post(chatRoute, {
        'user_id': userId,
        'messages': chatMessages
          .map((chatMessageObj) => chatMessageObj.toAIMessage())
          .toList(),
      });

      return AssistantChatMessageObj(
        date: DateTime.now(),
        content: botResponse,
      );
    } catch (e) {
      throw AIException('AI chat request failed: $e');
    }
  }

  Future<String> _post(String path, Map<String, dynamic> body) async {
    assert(userId != null, "User must be authenticated to use the AI Repository.");

    final response = await httpClient.post(
      AIService.chatRoute,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      assert(data['success'] is bool, 'Success field should be a boolean but is ${data['success']?.runtimeType}');
      bool successful = data['success'] as bool;
      if (successful) {
        assert(data['response'] is String, 'Response field should be a string but is ${data['response']?.runtimeType}');
        return data['response'];
      } else {
        throw Exception('Error: ${data['error']}');
      }
    } else {
      throw Exception('Status code ${response.statusCode}: ${response.reasonPhrase}.');
    }
  }
}

class AIException implements Exception {
  final String message;

  AIException(this.message);

  @override
  String toString() {
    return 'AIException: $message';
  }
}
