// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProgressObj _$$_ProgressObjFromJson(Map<String, dynamic> json) =>
    _$_ProgressObj(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String? ?? "",
      startsOn: const DateConverter().fromJson(json['startsOn'] as Timestamp),
      durationInDays: json['durationInDays'] as int,
      daysCompleted: json['daysCompleted'] as int? ?? 0,
      streak: json['streak'] as int? ?? 0,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$_ProgressObjToJson(_$_ProgressObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startsOn': const DateConverter().toJson(instance.startsOn),
      'durationInDays': instance.durationInDays,
      'daysCompleted': instance.daysCompleted,
      'streak': instance.streak,
      'imageUrl': instance.imageUrl,
    };
