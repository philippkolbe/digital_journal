import 'package:app/models/converters/date_converter.dart';
import 'package:app/models/mood.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'daily_card.freezed.dart';
part 'daily_card.g.dart';

@Freezed(unionKey: 'type')
class DailyCardObj with _$DailyCardObj {
  const DailyCardObj._();

  const factory DailyCardObj.personalityPrompt({
    String? id,
    int? order,
    @DateConverter() required DateTime date,
    required String personalityId,
    String? prompt,
  }) = PersonalityPromptDailyCardObj;

  const factory DailyCardObj.moodCheck({
    String? id,
    int? order,
    @DateConverter() required DateTime date,
    Mood? mood,
  }) = MoodCheckDailyCardObj;

  const factory DailyCardObj.futureCard({
    String? id, // necessary so that all other obj union types are ensured to have the id key.
  }) = FutureDailyCardObj;

  factory DailyCardObj.fromJson(Map<String, dynamic> json) => _$DailyCardObjFromJson(json);

  factory DailyCardObj.fromDocument(DocumentSnapshot doc) {
    final data = doc.data();

    assert(data != null, "Document has to exist to create an DailyCardObj");
    (data as Map<String, dynamic>)['id'] = doc.id;
    return DailyCardObj.fromJson(data);
  }

  Map<String, dynamic> toDocument() {
    return toJson()
      ..remove('id');
  }
}
