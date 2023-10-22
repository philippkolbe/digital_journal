import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'personality.freezed.dart';
part 'personality.g.dart';

@freezed
class PersonalityObj with _$PersonalityObj {
  const PersonalityObj._();

  const factory PersonalityObj({
    String? id,
    required String name,
    required String description,
    required String prompt,
  }) = _PersonalityObj;

  factory PersonalityObj.fromJson(Map<String, dynamic> json) =>
      _$PersonalityObjFromJson(json);

  factory PersonalityObj.fromDocument(DocumentSnapshot doc) {
    final data = doc.data();

    assert(data != null, "Document has to exist to create an PersonalityObj");
    (data as Map<String, dynamic>)['id'] = doc.id;
    return PersonalityObj.fromJson(data);
  }


  Map<String, dynamic> toDocument() {
    return toJson()
      ..remove('id');
  }
}