// ignore: depend_on_referenced_packages
import 'package:app/models/attribute.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attributes_action.freezed.dart';
part 'attributes_action.g.dart';

@Freezed(unionKey: 'action')
class AttributesActionObj with _$AttributesActionObj {
  const AttributesActionObj._();

  @Assert('level > 0 && level <= 10')
  const factory AttributesActionObj.create({
    required AttributeType type,
    required String description,
    required int level,
  }) = CreateAttributeObj;

  @Assert('level == null || level > 0 && level <= 10')
  const factory AttributesActionObj.update({
    required String id,
    String? description,
    int? level,
  }) = UpdateAttributeObj;
  
  const factory AttributesActionObj.delete({
    required String id,
  }) = DeleteAttributeObj;

  factory AttributesActionObj.fromJson(Map<String, dynamic> json) => _$AttributesActionObjFromJson(json);
}
