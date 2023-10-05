// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InformationObj _$$_InformationObjFromJson(Map<String, dynamic> json) =>
    _$_InformationObj(
      id: json['id'] as String?,
      description: json['description'] as String,
      date: const DateConverter().fromJson(json['date'] as Timestamp),
      expirationDate:
          const DateConverter().fromJson(json['expirationDate'] as Timestamp),
      importance: json['importance'] as int,
    );

Map<String, dynamic> _$$_InformationObjToJson(_$_InformationObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'date': const DateConverter().toJson(instance.date),
      'expirationDate': const DateConverter().toJson(instance.expirationDate),
      'importance': instance.importance,
    };
