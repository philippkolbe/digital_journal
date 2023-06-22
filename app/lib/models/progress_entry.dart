import 'package:app/models/converters/date_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_entry.freezed.dart';
part 'progress_entry.g.dart';

@freezed
abstract class ProgressEntryObj with _$ProgressEntryObj {
  const ProgressEntryObj._();

  const factory ProgressEntryObj({
    String? id,
    @DateConverter() required DateTime trackingDate,
    @Default(false) bool isCompleted,
  }) = _ProgressEntryObj;

  factory ProgressEntryObj.fromJson(Map<String,dynamic> json) => _$ProgressEntryObjFromJson(json);

  factory ProgressEntryObj.fromDocument(DocumentSnapshot doc) {
    final data = doc.data();
    assert(data != null, "Document has to exist to create a ProgressEntryObj");
    (data as Map<String, dynamic>)['id'] = doc.id;
    return ProgressEntryObj.fromJson(data);
  }

  Map<String, dynamic> toDocument() {
    final json = toJson();
    return json
      ..remove('id');
  }
}