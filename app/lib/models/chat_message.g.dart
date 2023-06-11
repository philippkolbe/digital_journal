// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatMessage _$$_ChatMessageFromJson(Map<String, dynamic> json) =>
    _$_ChatMessage(
      id: json['id'] as String?,
      isFromBot: json['isFromBot'] as bool,
      date: const DateConverter().fromJson(json['date'] as Timestamp),
      content: json['content'] as String,
    );

Map<String, dynamic> _$$_ChatMessageToJson(_$_ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isFromBot': instance.isFromBot,
      'date': const DateConverter().toJson(instance.date),
      'content': instance.content,
    };
