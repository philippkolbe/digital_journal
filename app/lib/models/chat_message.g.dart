// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssistantChatMessageObj _$$AssistantChatMessageObjFromJson(
        Map<String, dynamic> json) =>
    _$AssistantChatMessageObj(
      id: json['id'] as String?,
      date: const DateConverter().fromJson(json['date'] as Timestamp),
      content: json['content'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AssistantChatMessageObjToJson(
        _$AssistantChatMessageObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': const DateConverter().toJson(instance.date),
      'content': instance.content,
      'runtimeType': instance.$type,
    };

_$UserChatMessageObj _$$UserChatMessageObjFromJson(Map<String, dynamic> json) =>
    _$UserChatMessageObj(
      id: json['id'] as String?,
      date: const DateConverter().fromJson(json['date'] as Timestamp),
      content: json['content'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UserChatMessageObjToJson(
        _$UserChatMessageObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': const DateConverter().toJson(instance.date),
      'content': instance.content,
      'runtimeType': instance.$type,
    };

_$SystemChatMessageObj _$$SystemChatMessageObjFromJson(
        Map<String, dynamic> json) =>
    _$SystemChatMessageObj(
      id: json['id'] as String?,
      date: const DateConverter().fromJson(json['date'] as Timestamp),
      content: json['content'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SystemChatMessageObjToJson(
        _$SystemChatMessageObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': const DateConverter().toJson(instance.date),
      'content': instance.content,
      'runtimeType': instance.$type,
    };
