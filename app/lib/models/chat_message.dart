import 'package:app/models/converters/date_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Map<String, dynamic> toDocument() {
    final json = toJson();
    return json..remove('id');
  }
}