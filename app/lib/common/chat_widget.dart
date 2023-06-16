import 'package:app/common/utils.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatPage extends StatelessWidget {
  late final List<types.Message> messages;
  late final types.User user;
  final botUser = const types.User(
    id: 'chat_bot_user_id',
    firstName: 'Bot',
  );

  final Function(ChatMessageObj) onMessageAdded;

  ChatPage({
    required UserObj user,
    required this.onMessageAdded,
    List<ChatMessageObj> messages = const [],
    super.key,
  }) {
    this.user = types.User(
      id: user.id,
      firstName: 'You',
    );

    // TODO: Think about this performace... every time we add a new Chat message the entire widget is reloaded and all the messages are reconverted
    this.messages = messages
      .map((messageObj) => messageObj.toTextMessage(this.user, botUser))
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

  void _addMessage(types.TextMessage message) {
    final messageObj = ChatMessageObj.fromTextMessage(message, isFromBot: false);
    onMessageAdded(messageObj);
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
