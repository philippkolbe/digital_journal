import 'package:app/common/utils.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatWidget extends StatelessWidget {
  late final List<types.Message> messages;
  late final types.User user;
  final botUser = const types.User(
    id: 'chat_bot_user_id',
    firstName: 'Bot',
  );

  final Function(String) onMessageAdded;

  ChatWidget({
    required UserObj user,
    required this.onMessageAdded,
    required List<AsyncValue<ChatMessageObj>> messages,
    super.key,
  }) {
    this.user = types.User(
      id: user.id,
      firstName: 'You',
    );

    // TODO: Think about this performace... every time we add a new Chat message the entire widget is reloaded and all the messages are reconverted
    this.messages = messages
      .map(_toTextMessage)
      .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Chat(
      messages: messages,
      onSendPressed: _handleSendPressed,
      showUserAvatars: true,
      showUserNames: true,
      user: user,
    );
  }

  types.Message _toTextMessage(AsyncValue<ChatMessageObj> asyncMessageObj) {
    return asyncMessageObj.when<types.Message>(
      data: (messageObj) => messageObj.toTextMessage(user, botUser),
      error: (error, stackTrace) => types.TextMessage(
        id: generateUuid(),
        author: botUser,
        text: 'Something went wrong while loading the response: $error',
        status: types.Status.error,
      ),
      loading: () => types.TextMessage(
        id: generateUuid(),
        author: botUser,
        text: '...',
        status: types.Status.sending,
      ),
    );
  }

  void _addMessage(types.TextMessage message) {
    onMessageAdded(message.text);
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      id: generateUuid(),
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      text: message.text,
    );

    _addMessage(textMessage);
  }
}
