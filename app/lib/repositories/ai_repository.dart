import 'dart:convert';

import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/providers/http_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

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
        if (data['successful']) {
          final botResponse = data['response'] as String;

          final botMessage = ChatMessageObj(
            isFromBot: true,
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
