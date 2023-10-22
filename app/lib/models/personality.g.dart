// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PersonalityObj _$$_PersonalityObjFromJson(Map<String, dynamic> json) =>
    _$_PersonalityObj(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      prompt: json['prompt'] as String,
    );

Map<String, dynamic> _$$_PersonalityObjToJson(_$_PersonalityObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'prompt': instance.prompt,
    };
