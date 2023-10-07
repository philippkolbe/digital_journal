// ignore: depend_on_referenced_packages
import 'package:app/models/attributes_action.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attribute.freezed.dart';
part 'attribute.g.dart';

enum AttributeType {
  @JsonValue("like")
  like,
  @JsonValue("dislike")
  dislike,
  @JsonValue("fear")
  fear,
  @JsonValue("value")
  value,
  @JsonValue("goal")
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

  factory AttributeObj.fromCreateAction(CreateAttributeObj action) => AttributeObj.fromJson({
    'runtimeType': action.type.name,
    'description': action.description,
    'level': action.level,
  });

  // TODO: If we used @Freezed(unionKey: 'type') it would be easier
  Map<String, dynamic> toDocument() {
    final json = toJson();
    json['type'] = json['runtimeType'];

    return json
      ..remove('id')
      ..remove('runtimeType');
  }
}
