// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SimpleJournalEntryObj _$$SimpleJournalEntryObjFromJson(
        Map<String, dynamic> json) =>
    _$SimpleJournalEntryObj(
      id: json['id'] as String,
      name: json['name'] as String,
      date: const DateConverter().fromJson(json['date'] as Timestamp),
      content: json['content'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SimpleJournalEntryObjToJson(
        _$SimpleJournalEntryObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': const DateConverter().toJson(instance.date),
      'content': instance.content,
      'runtimeType': instance.$type,
    };

_$ChatJournalEntryObj _$$ChatJournalEntryObjFromJson(
        Map<String, dynamic> json) =>
    _$ChatJournalEntryObj(
      id: json['id'] as String,
      name: json['name'] as String,
      date: const DateConverter().fromJson(json['date'] as Timestamp),
      goal: json['goal'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ChatJournalEntryObjToJson(
        _$ChatJournalEntryObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': const DateConverter().toJson(instance.date),
      'goal': instance.goal,
      'runtimeType': instance.$type,
    };
