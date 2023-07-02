import 'package:app/models/converters/date_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat_types;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@freezed
abstract class ChatMessageObj with _$ChatMessageObj {
  const ChatMessageObj._();

  const factory ChatMessageObj.assistant({
    String? id,
    @DateConverter() required DateTime date,
    required String content,
  }) = AssistantChatMessageObj;

  const factory ChatMessageObj.user({
    String? id,
    @DateConverter() required DateTime date,
    required String content,
  }) = UserChatMessageObj;

  const factory ChatMessageObj.system({
    String? id,
    @DateConverter() required DateTime date,
    required String content,
  }) = SystemChatMessageObj;

  factory ChatMessageObj.fromJson(Map<String, dynamic> json) => _$ChatMessageObjFromJson(json);

  factory ChatMessageObj.fromDocument(DocumentSnapshot doc) {
    final data = doc.data();
    assert(data != null, "Document has to exist to create a ChatMessageObj");
    (data as Map<String, dynamic>)['id'] = doc.id;

    final role = data['role'];
    if (role == 'assistant') {
      return AssistantChatMessageObj.fromJson(data);
    } else if (role == 'user') {
      return UserChatMessageObj.fromJson(data);
    } else {
      return SystemChatMessageObj.fromJson(data);
    }
  }

  factory ChatMessageObj.fromTextMessage(chat_types.TextMessage message) {
    return UserChatMessageObj(
      id: message.id,
      content: message.text,
      date: DateTime.fromMillisecondsSinceEpoch(message.createdAt!),
    );
  }

  Map<String, dynamic> toDocument() {
    final json = toJson();
    return json
      ..addAll({
        'role': _getRole(),
      })
      ..remove('runtimeType')
      ..remove('id');
  }

  chat_types.TextMessage? toTextMessage(chat_types.User user, chat_types.User assistantUser) {
    assert(id != null, "Needs id to convert toTextMessage");

    if (this is UserChatMessageObj) {
      return chat_types.TextMessage(
        id: id!,
        text: content,
        createdAt: date.millisecondsSinceEpoch,
        author: user,
      );
    } else if (this is AssistantChatMessageObj) {
      return chat_types.TextMessage(
        id: id!,
        text: content,
        createdAt: date.millisecondsSinceEpoch,
        author: assistantUser,
      );
    }

    return null;
  }

  Map<String, dynamic> toAIMessage() {
    return {
      'role': _getRole(),
      'content': content,
    };
  }

  String _getRole() {
    return when(
      assistant: (_, __, ___) => 'assistant',
      user: (_, __, ___) => 'user',
      system: (_, __, ___) => 'system',
    );
  }
}
