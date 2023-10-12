// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LikeAttributeObj _$$LikeAttributeObjFromJson(Map<String, dynamic> json) =>
    _$LikeAttributeObj(
      id: json['id'] as String?,
      countingId: json['countingId'] as String?,
      type: $enumDecodeNullable(_$AttributeTypeEnumMap, json['type']) ??
          AttributeType.like,
      description: json['description'] as String,
      level: json['level'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LikeAttributeObjToJson(_$LikeAttributeObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countingId': instance.countingId,
      'type': _$AttributeTypeEnumMap[instance.type]!,
      'description': instance.description,
      'level': instance.level,
      'runtimeType': instance.$type,
    };

const _$AttributeTypeEnumMap = {
  AttributeType.like: 'like',
  AttributeType.dislike: 'dislike',
  AttributeType.fear: 'fear',
  AttributeType.value: 'value',
  AttributeType.goal: 'goal',
};

_$DislikeAttributeObj _$$DislikeAttributeObjFromJson(
        Map<String, dynamic> json) =>
    _$DislikeAttributeObj(
      id: json['id'] as String?,
      countingId: json['countingId'] as String?,
      type: $enumDecodeNullable(_$AttributeTypeEnumMap, json['type']) ??
          AttributeType.dislike,
      description: json['description'] as String,
      level: json['level'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DislikeAttributeObjToJson(
        _$DislikeAttributeObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countingId': instance.countingId,
      'type': _$AttributeTypeEnumMap[instance.type]!,
      'description': instance.description,
      'level': instance.level,
      'runtimeType': instance.$type,
    };

_$FearAttributeObj _$$FearAttributeObjFromJson(Map<String, dynamic> json) =>
    _$FearAttributeObj(
      id: json['id'] as String?,
      countingId: json['countingId'] as String?,
      type: $enumDecodeNullable(_$AttributeTypeEnumMap, json['type']) ??
          AttributeType.fear,
      description: json['description'] as String,
      level: json['level'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$FearAttributeObjToJson(_$FearAttributeObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countingId': instance.countingId,
      'type': _$AttributeTypeEnumMap[instance.type]!,
      'description': instance.description,
      'level': instance.level,
      'runtimeType': instance.$type,
    };

_$ValueAttributeObj _$$ValueAttributeObjFromJson(Map<String, dynamic> json) =>
    _$ValueAttributeObj(
      id: json['id'] as String?,
      countingId: json['countingId'] as String?,
      type: $enumDecodeNullable(_$AttributeTypeEnumMap, json['type']) ??
          AttributeType.value,
      description: json['description'] as String,
      level: json['level'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ValueAttributeObjToJson(_$ValueAttributeObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countingId': instance.countingId,
      'type': _$AttributeTypeEnumMap[instance.type]!,
      'description': instance.description,
      'level': instance.level,
      'runtimeType': instance.$type,
    };

_$GoalAttributeObj _$$GoalAttributeObjFromJson(Map<String, dynamic> json) =>
    _$GoalAttributeObj(
      id: json['id'] as String?,
      countingId: json['countingId'] as String?,
      type: $enumDecodeNullable(_$AttributeTypeEnumMap, json['type']) ??
          AttributeType.goal,
      description: json['description'] as String,
      level: json['level'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$GoalAttributeObjToJson(_$GoalAttributeObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countingId': instance.countingId,
      'type': _$AttributeTypeEnumMap[instance.type]!,
      'description': instance.description,
      'level': instance.level,
      'runtimeType': instance.$type,
    };
