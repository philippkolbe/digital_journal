import 'package:app/models/converters/date_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'information.freezed.dart';
part 'information.g.dart';

@freezed
class InformationObj with _$InformationObj {
  const InformationObj._();

  const factory InformationObj({
    String? id,
    required String description,
    @DateConverter() required DateTime date,
    @DateConverter() required DateTime expirationDate,
    required int importance,
  }) = _InformationObj;

  factory InformationObj.fromJson(Map<String, dynamic> json) =>
      _$InformationObjFromJson(json);

  factory InformationObj.fromDocument(DocumentSnapshot doc) {
    final data = doc.data();

    assert(data != null, "Document has to exist to create an InformationObj");
    (data as Map<String, dynamic>)['id'] = doc.id;
    return InformationObj.fromJson(data);
  }


  Map<String, dynamic> toDocument() {
    return toJson()
      ..remove('id');
  }
}