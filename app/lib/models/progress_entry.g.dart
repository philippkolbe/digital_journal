// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProgressEntryObj _$$_ProgressEntryObjFromJson(Map<String, dynamic> json) =>
    _$_ProgressEntryObj(
      id: json['id'] as String?,
      trackingDate:
          const DateConverter().fromJson(json['trackingDate'] as Timestamp),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$_ProgressEntryObjToJson(_$_ProgressEntryObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'trackingDate': const DateConverter().toJson(instance.trackingDate),
      'isCompleted': instance.isCompleted,
    };
