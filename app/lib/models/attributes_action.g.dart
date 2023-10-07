// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attributes_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateAttributeObj _$$CreateAttributeObjFromJson(Map<String, dynamic> json) =>
    _$CreateAttributeObj(
      type: $enumDecode(_$AttributeTypeEnumMap, json['type']),
      description: json['description'] as String,
      level: json['level'] as int,
      $type: json['action'] as String?,
    );

Map<String, dynamic> _$$CreateAttributeObjToJson(
        _$CreateAttributeObj instance) =>
    <String, dynamic>{
      'type': _$AttributeTypeEnumMap[instance.type]!,
      'description': instance.description,
      'level': instance.level,
      'action': instance.$type,
    };

const _$AttributeTypeEnumMap = {
  AttributeType.like: 'like',
  AttributeType.dislike: 'dislike',
  AttributeType.fear: 'fear',
  AttributeType.value: 'value',
  AttributeType.goal: 'goal',
};

_$UpdateAttributeObj _$$UpdateAttributeObjFromJson(Map<String, dynamic> json) =>
    _$UpdateAttributeObj(
      id: json['id'] as String?,
      description: json['description'] as String?,
      level: json['level'] as int?,
      $type: json['action'] as String?,
    );

Map<String, dynamic> _$$UpdateAttributeObjToJson(
        _$UpdateAttributeObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'level': instance.level,
      'action': instance.$type,
    };

_$DeleteAttributeObj _$$DeleteAttributeObjFromJson(Map<String, dynamic> json) =>
    _$DeleteAttributeObj(
      id: json['id'] as String,
      $type: json['action'] as String?,
    );

Map<String, dynamic> _$$DeleteAttributeObjToJson(
        _$DeleteAttributeObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': instance.$type,
    };
