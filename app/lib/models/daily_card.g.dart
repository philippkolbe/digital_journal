// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonalityPromptDailyCardObj _$$PersonalityPromptDailyCardObjFromJson(
        Map<String, dynamic> json) =>
    _$PersonalityPromptDailyCardObj(
      id: json['id'] as String?,
      order: json['order'] as int?,
      date: const DateConverter().fromJson(json['date'] as Timestamp),
      personalityId: json['personalityId'] as String,
      prompt: json['prompt'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PersonalityPromptDailyCardObjToJson(
        _$PersonalityPromptDailyCardObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'date': const DateConverter().toJson(instance.date),
      'personalityId': instance.personalityId,
      'prompt': instance.prompt,
      'type': instance.$type,
    };

_$MoodCheckDailyCardObj _$$MoodCheckDailyCardObjFromJson(
        Map<String, dynamic> json) =>
    _$MoodCheckDailyCardObj(
      id: json['id'] as String?,
      order: json['order'] as int?,
      date: const DateConverter().fromJson(json['date'] as Timestamp),
      mood: $enumDecodeNullable(_$MoodEnumMap, json['mood']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$MoodCheckDailyCardObjToJson(
        _$MoodCheckDailyCardObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'date': const DateConverter().toJson(instance.date),
      'mood': _$MoodEnumMap[instance.mood],
      'type': instance.$type,
    };

const _$MoodEnumMap = {
  Mood.great: 5,
  Mood.good: 4,
  Mood.ok: 3,
  Mood.bad: 2,
  Mood.terrible: 1,
};

_$FutureDailyCardObj _$$FutureDailyCardObjFromJson(Map<String, dynamic> json) =>
    _$FutureDailyCardObj(
      id: json['id'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$FutureDailyCardObjToJson(
        _$FutureDailyCardObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.$type,
    };
