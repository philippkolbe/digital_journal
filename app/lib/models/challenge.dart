import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge.freezed.dart';
part 'challenge.g.dart';

@freezed
abstract class ChallengeObj with _$ChallengeObj {
  const ChallengeObj._();

  const factory ChallengeObj({
    String? id,
    @Default(false) bool isPublic,
    required String title,
    @Default("") String description,
    required int durationInDays,
    String? imageUrl,
  }) = _ChallengeObj;

  factory ChallengeObj.fromJson(Map<String,dynamic> json) => _$ChallengeObjFromJson(json);

  factory ChallengeObj.fromDocument(DocumentSnapshot doc) {
    final data = doc.data();
    assert(data != null, "Document has to exist to create a ChallengeObj");
    (data as Map<String, dynamic>)['id'] = doc.id;
    return ChallengeObj.fromJson(data);
  }

  Map<String, dynamic> toDocument() {
    final json = toJson();
    return json
      ..remove('id')
      .remove('isPublic');
  }
}