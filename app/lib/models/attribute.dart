// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attribute.freezed.dart';
part 'attribute.g.dart';

enum AttributeType {
  like,
  dislike,
  fear,
  value,
  goal,
}

@freezed
class AttributeObj with _$AttributeObj {
  const AttributeObj._();

  const factory AttributeObj.like({
    String? id,
    @Default(AttributeType.like) AttributeType type,
    required String description,
    required int level,
  }) = LikeAttributeObj;

  const factory AttributeObj.dislike({
    String? id,
    @Default(AttributeType.dislike) AttributeType type,
    required String description,
    required int level,
  }) = DislikeAttributeObj;

  const factory AttributeObj.fear({
    String? id,
    @Default(AttributeType.fear) AttributeType type,
    required String description,
    required int level,
  }) = FearAttributeObj;

  const factory AttributeObj.value({
    String? id,
    @Default(AttributeType.value) AttributeType type,
    required String description,
    required int level,
  }) = ValueAttributeObj;

  const factory AttributeObj.goal({
    String? id,
    @Default(AttributeType.goal) AttributeType type,
    required String description,
    required int level,
  }) = GoalAttributeObj;

  factory AttributeObj.fromJson(Map<String, dynamic> json) =>
      _$AttributeObjFromJson(json);

  factory AttributeObj.fromDocument(DocumentSnapshot doc) {
    final data = doc.data();

    assert(data != null, "Document has to exist to create an AttributeObj");
    (data as Map<String, dynamic>)['id'] = doc.id;
    data['runtimeType'] = data['type'];
    return AttributeObj.fromJson(data);
  }

  // TODO: If we just named this runtimeType these conversions would be easier...
  Map<String, dynamic> toDocument() {
    final json = toJson();
    json['type'] = json['runtimeType'];

    return json
      ..remove('id')
      ..remove('runtimeType');
  }
}
