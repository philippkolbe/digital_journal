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
  final assistantUser = const types.User(
    id: 'chat_bot_user_id',
    firstName: 'Journal',
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
      .whereType<types.Message>()
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
      theme: MyChatTheme(Theme.of(context)),
    );
  }

  types.Message? _toTextMessage(AsyncValue<ChatMessageObj> asyncMessageObj) {
    return asyncMessageObj.when(
      data: (messageObj) => messageObj.toTextMessage(user, assistantUser),
      error: (error, stackTrace) => types.TextMessage(
        id: generateUuid(),
        author: assistantUser,
        text: 'Something went wrong while loading the response: $error',
        status: types.Status.error,
      ),
      loading: () => types.TextMessage(
        id: generateUuid(),
        author: assistantUser,
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

const _default = DefaultChatTheme();
class MyChatTheme extends ChatTheme {
  MyChatTheme(ThemeData theme) : super(
    errorColor: theme.colorScheme.error,
    backgroundColor: theme.colorScheme.background,
    inputBackgroundColor: theme.colorScheme.surface,
    inputTextColor: theme.colorScheme.onSurface,
    primaryColor: theme.colorScheme.primary,
    receivedMessageDocumentIconColor: theme.colorScheme.onPrimary,
    secondaryColor: theme.colorScheme.secondary,
    sentMessageDocumentIconColor: theme.colorScheme.onPrimary,
    userAvatarImageBackgroundColor: theme.colorScheme.primary,
    userAvatarNameColors: [theme.colorScheme.onBackground],

    attachmentButtonIcon: _default.attachmentButtonIcon,
    attachmentButtonMargin: _default.attachmentButtonMargin,
    dateDividerMargin: _default.dateDividerMargin,
    dateDividerTextStyle: _default.dateDividerTextStyle,
    deliveredIcon: _default.deliveredIcon,
    documentIcon: _default.documentIcon,
    emptyChatPlaceholderTextStyle: _default.emptyChatPlaceholderTextStyle,
    errorIcon: _default.errorIcon,
    inputBorderRadius: _default.inputBorderRadius,
    inputMargin: _default.inputMargin,
    inputPadding: _default.inputPadding,
    inputTextDecoration: _default.inputTextDecoration,
    inputTextStyle: _default.inputTextStyle,
    messageBorderRadius: _default.messageBorderRadius,
    messageInsetsHorizontal: _default.messageInsetsHorizontal,
    messageInsetsVertical: _default.messageInsetsVertical,
    receivedEmojiMessageTextStyle: _default.receivedEmojiMessageTextStyle,
    receivedMessageBodyTextStyle: _default.receivedMessageBodyTextStyle,
    receivedMessageCaptionTextStyle: _default.receivedMessageCaptionTextStyle,
    receivedMessageLinkDescriptionTextStyle: _default.receivedMessageLinkDescriptionTextStyle,
    receivedMessageLinkTitleTextStyle: _default.receivedMessageLinkTitleTextStyle,
    seenIcon: _default.seenIcon,
    sendButtonIcon: _default.sendButtonIcon,
    sendButtonMargin: _default.sendButtonMargin,
    sendingIcon: _default.sendingIcon,
    sentEmojiMessageTextStyle: _default.sentEmojiMessageTextStyle,
    sentMessageBodyTextStyle: _default.sentMessageBodyTextStyle,
    sentMessageCaptionTextStyle: _default.sentMessageCaptionTextStyle,
    sentMessageLinkDescriptionTextStyle: _default.sentMessageLinkDescriptionTextStyle,
    sentMessageLinkTitleTextStyle: _default.sentMessageLinkTitleTextStyle,
    statusIconPadding: _default.statusIconPadding,
    systemMessageTheme: _default.systemMessageTheme,
    typingIndicatorTheme: _default.typingIndicatorTheme,
    unreadHeaderTheme: _default.unreadHeaderTheme,
    userAvatarTextStyle: _default.userAvatarTextStyle,
    userNameTextStyle: _default.userNameTextStyle,
  );
}