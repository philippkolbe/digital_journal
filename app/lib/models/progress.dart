import 'package:app/models/converters/date_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress.freezed.dart';
part 'progress.g.dart';

@freezed
abstract class ProgressObj with _$ProgressObj {
  const ProgressObj._();

  const factory ProgressObj({
    String? id,
    required String title,
    @Default("") String description,
    @DateConverter() required DateTime startsOn,
    required int durationInDays,
    @Default(0) int daysCompleted,
    @Default(false) bool hasBeenCompletedToday,
    @Default(0) int streak,
    String? imageUrl,
  }) = _ProgressObj;

  factory ProgressObj.fromJson(Map<String,dynamic> json) => _$ProgressObjFromJson(json);

  factory ProgressObj.fromDocument(DocumentSnapshot doc) {
    final data = doc.data();
    assert(data != null, "Document has to exist to create a ProgressObj");
    (data as Map<String, dynamic>)['id'] = doc.id;
    return ProgressObj.fromJson(data);
  }

  Map<String, dynamic> toDocument() {
    final json = toJson();
    return json
      ..remove('id');
  }
}