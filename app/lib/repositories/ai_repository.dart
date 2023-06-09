import 'dart:convert';

import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/providers/http_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final aiRepositoryProvider = Provider<BaseAIRepository>((ref) {
  final asyncAuthState = ref.read(authControllerProvider);
  final httpClient = ref.read(httpClientProvider);
  return AIRepository(
    httpClient: httpClient,
    userId: asyncAuthState.valueOrNull?.currentUser.id
  );
});

abstract class BaseAIRepository {
  Future<ChatMessageObj> respondToChat(List<ChatMessageObj> chatMessages);
}

class AIRepository implements BaseAIRepository {
  static const String chatRoute = '/chat';
  
  final AIHttpClient httpClient;
  final String? userId;

  AIRepository({required this.httpClient, required this.userId });

  @override
  Future<ChatMessageObj> respondToChat(List<ChatMessageObj> chatMessages) async {
    try {
      assert(userId != null, "User must be authenticated to use the AI Repository.");

      final response = await httpClient.post(
        AIRepository.chatRoute,
        body: {
          'user_id': userId,
          'messages': chatMessages
            .map((chatMessageObj) => chatMessageObj.toAIMessage())
            .toList(),
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        assert(data['success'] is bool, 'Success field should be a boolean but is ${data['success']?.runtimeType}');
        bool successful = data['success'] as bool;
        if (successful) {
          assert(data['response'] is String, 'Response field should be a string but is ${data['response']?.runtimeType}');
          final botResponse = data['response'] as String;

          final botMessage = AssistantChatMessageObj(
            date: DateTime.now(),
            content: botResponse,
          );

          return botMessage;
        } else {
          throw Exception('Error: ${data['error']}');
        }
      } else {
        throw Exception('Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw AIException('AI request failed: $e');
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
