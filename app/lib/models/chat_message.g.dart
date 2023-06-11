// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatMessage _$$_ChatMessageFromJson(Map<String, dynamic> json) =>
    _$_ChatMessage(
      isFromBot: json['isFromBot'] as bool,
      id: json['id'] as String,
      date: const DateConverter().fromJson(json['date'] as Timestamp),
      content: json['content'] as String,
    );

Map<String, dynamic> _$$_ChatMessageToJson(_$_ChatMessage instance) =>
    <String, dynamic>{
      'isFromBot': instance.isFromBot,
      'id': instance.id,
      'date': const DateConverter().toJson(instance.date),
      'content': instance.content,
    };
