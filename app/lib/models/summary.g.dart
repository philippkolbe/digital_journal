// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SummaryObj _$$_SummaryObjFromJson(Map<String, dynamic> json) =>
    _$_SummaryObj(
      date: const DateConverter().fromJson(json['date'] as Timestamp),
      validUpToId: json['validUpToId'] as String?,
      content: json['content'] as String? ?? "",
    );

Map<String, dynamic> _$$_SummaryObjToJson(_$_SummaryObj instance) =>
    <String, dynamic>{
      'date': const DateConverter().toJson(instance.date),
      'validUpToId': instance.validUpToId,
      'content': instance.content,
    };
