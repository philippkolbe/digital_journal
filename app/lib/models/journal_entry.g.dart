// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SimpleJournalEntryObj _$$SimpleJournalEntryObjFromJson(
        Map<String, dynamic> json) =>
    _$SimpleJournalEntryObj(
      id: json['id'] as String?,
      name: json['name'] as String,
      date: const DateConverter().fromJson(json['date'] as Timestamp),
      content: json['content'] as String? ?? "",
      summary: json['summary'] == null
          ? null
          : SummaryObj.fromJson(json['summary'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SimpleJournalEntryObjToJson(
        _$SimpleJournalEntryObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': const DateConverter().toJson(instance.date),
      'content': instance.content,
      'summary': instance.summary,
      'runtimeType': instance.$type,
    };

_$ChatJournalEntryObj _$$ChatJournalEntryObjFromJson(
        Map<String, dynamic> json) =>
    _$ChatJournalEntryObj(
      id: json['id'] as String?,
      name: json['name'] as String,
      date: const DateConverter().fromJson(json['date'] as Timestamp),
      goal: json['goal'] as String?,
      summary: json['summary'] == null
          ? null
          : SummaryObj.fromJson(json['summary'] as Map<String, dynamic>),
      personalityId: json['personalityId'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ChatJournalEntryObjToJson(
        _$ChatJournalEntryObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': const DateConverter().toJson(instance.date),
      'goal': instance.goal,
      'summary': instance.summary,
      'personalityId': instance.personalityId,
      'runtimeType': instance.$type,
    };
