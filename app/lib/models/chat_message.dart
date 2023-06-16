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

  const factory ChatMessageObj({
    String? id,
    required bool isFromBot,
    @DateConverter() required DateTime date,
    required String content,
  }) = _ChatMessage;

  factory ChatMessageObj.fromJson(Map<String,dynamic> json) => _$ChatMessageObjFromJson(json);

  factory ChatMessageObj.fromDocument(DocumentSnapshot doc) {
    return ChatMessageObj.fromJson(doc.data() as Map<String, dynamic>);
  }

  factory ChatMessageObj.fromTextMessage(chat_types.TextMessage message, { isFromBot = false }) {
    return ChatMessageObj(
      id: message.id,
      content: message.text,
      date: DateTime.fromMillisecondsSinceEpoch(message.createdAt!),
      isFromBot: false,
    );
  }

  Map<String, dynamic> toDocument() {
    final json = toJson();
    return json..remove('id');
  }

  chat_types.TextMessage toTextMessage(chat_types.User user, chat_types.User botUser) {
    assert(id != null, "Needs id to convert toTextMessage");

    return chat_types.TextMessage(
      id: id!,
      text: content,
      createdAt: date.millisecondsSinceEpoch,
      author: isFromBot ? botUser : user,
    );
  }
}