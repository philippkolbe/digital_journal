// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChallengeObj _$$_ChallengeObjFromJson(Map<String, dynamic> json) =>
    _$_ChallengeObj(
      id: json['id'] as String?,
      isPublic: json['isPublic'] as bool? ?? false,
      title: json['title'] as String,
      description: json['description'] as String? ?? "",
      durationInDays: json['durationInDays'] as int,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$_ChallengeObjToJson(_$_ChallengeObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isPublic': instance.isPublic,
      'title': instance.title,
      'description': instance.description,
      'durationInDays': instance.durationInDays,
      'imageUrl': instance.imageUrl,
    };
