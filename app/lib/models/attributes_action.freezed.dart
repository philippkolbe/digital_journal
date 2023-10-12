// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attributes_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AttributesActionObj _$AttributesActionObjFromJson(Map<String, dynamic> json) {
  switch (json['action']) {
    case 'create':
      return CreateAttributeObj.fromJson(json);
    case 'update':
      return UpdateAttributeObj.fromJson(json);
    case 'delete':
      return DeleteAttributeObj.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'action', 'AttributesActionObj',
          'Invalid union type "${json['action']}"!');
  }
}

/// @nodoc
mixin _$AttributesActionObj {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AttributeType type, String description, int level)
        create,
    required TResult Function(String id, String? description, int? level)
        update,
    required TResult Function(String id) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AttributeType type, String description, int level)?
        create,
    TResult? Function(String id, String? description, int? level)? update,
    TResult? Function(String id)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AttributeType type, String description, int level)? create,
    TResult Function(String id, String? description, int? level)? update,
    TResult Function(String id)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateAttributeObj value) create,
    required TResult Function(UpdateAttributeObj value) update,
    required TResult Function(DeleteAttributeObj value) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateAttributeObj value)? create,
    TResult? Function(UpdateAttributeObj value)? update,
    TResult? Function(DeleteAttributeObj value)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateAttributeObj value)? create,
    TResult Function(UpdateAttributeObj value)? update,
    TResult Function(DeleteAttributeObj value)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttributesActionObjCopyWith<$Res> {
  factory $AttributesActionObjCopyWith(
          AttributesActionObj value, $Res Function(AttributesActionObj) then) =
      _$AttributesActionObjCopyWithImpl<$Res, AttributesActionObj>;
}

/// @nodoc
class _$AttributesActionObjCopyWithImpl<$Res, $Val extends AttributesActionObj>
    implements $AttributesActionObjCopyWith<$Res> {
  _$AttributesActionObjCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CreateAttributeObjCopyWith<$Res> {
  factory _$$CreateAttributeObjCopyWith(_$CreateAttributeObj value,
          $Res Function(_$CreateAttributeObj) then) =
      __$$CreateAttributeObjCopyWithImpl<$Res>;
  @useResult
  $Res call({AttributeType type, String description, int level});
}

/// @nodoc
class __$$CreateAttributeObjCopyWithImpl<$Res>
    extends _$AttributesActionObjCopyWithImpl<$Res, _$CreateAttributeObj>
    implements _$$CreateAttributeObjCopyWith<$Res> {
  __$$CreateAttributeObjCopyWithImpl(
      _$CreateAttributeObj _value, $Res Function(_$CreateAttributeObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? description = null,
    Object? level = null,
  }) {
    return _then(_$CreateAttributeObj(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AttributeType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateAttributeObj extends CreateAttributeObj {
  const _$CreateAttributeObj(
      {required this.type,
      required this.description,
      required this.level,
      final String? $type})
      : assert(level > 0 && level <= 10),
        $type = $type ?? 'create',
        super._();

  factory _$CreateAttributeObj.fromJson(Map<String, dynamic> json) =>
      _$$CreateAttributeObjFromJson(json);

  @override
  final AttributeType type;
  @override
  final String description;
  @override
  final int level;

  @JsonKey(name: 'action')
  final String $type;

  @override
  String toString() {
    return 'AttributesActionObj.create(type: $type, description: $description, level: $level)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateAttributeObj &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, description, level);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateAttributeObjCopyWith<_$CreateAttributeObj> get copyWith =>
      __$$CreateAttributeObjCopyWithImpl<_$CreateAttributeObj>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AttributeType type, String description, int level)
        create,
    required TResult Function(String id, String? description, int? level)
        update,
    required TResult Function(String id) delete,
  }) {
    return create(type, description, level);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AttributeType type, String description, int level)?
        create,
    TResult? Function(String id, String? description, int? level)? update,
    TResult? Function(String id)? delete,
  }) {
    return create?.call(type, description, level);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AttributeType type, String description, int level)? create,
    TResult Function(String id, String? description, int? level)? update,
    TResult Function(String id)? delete,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(type, description, level);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateAttributeObj value) create,
    required TResult Function(UpdateAttributeObj value) update,
    required TResult Function(DeleteAttributeObj value) delete,
  }) {
    return create(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateAttributeObj value)? create,
    TResult? Function(UpdateAttributeObj value)? update,
    TResult? Function(DeleteAttributeObj value)? delete,
  }) {
    return create?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateAttributeObj value)? create,
    TResult Function(UpdateAttributeObj value)? update,
    TResult Function(DeleteAttributeObj value)? delete,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateAttributeObjToJson(
      this,
    );
  }
}

abstract class CreateAttributeObj extends AttributesActionObj {
  const factory CreateAttributeObj(
      {required final AttributeType type,
      required final String description,
      required final int level}) = _$CreateAttributeObj;
  const CreateAttributeObj._() : super._();

  factory CreateAttributeObj.fromJson(Map<String, dynamic> json) =
      _$CreateAttributeObj.fromJson;

  AttributeType get type;
  String get description;
  int get level;
  @JsonKey(ignore: true)
  _$$CreateAttributeObjCopyWith<_$CreateAttributeObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateAttributeObjCopyWith<$Res> {
  factory _$$UpdateAttributeObjCopyWith(_$UpdateAttributeObj value,
          $Res Function(_$UpdateAttributeObj) then) =
      __$$UpdateAttributeObjCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String? description, int? level});
}

/// @nodoc
class __$$UpdateAttributeObjCopyWithImpl<$Res>
    extends _$AttributesActionObjCopyWithImpl<$Res, _$UpdateAttributeObj>
    implements _$$UpdateAttributeObjCopyWith<$Res> {
  __$$UpdateAttributeObjCopyWithImpl(
      _$UpdateAttributeObj _value, $Res Function(_$UpdateAttributeObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = freezed,
    Object? level = freezed,
  }) {
    return _then(_$UpdateAttributeObj(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateAttributeObj extends UpdateAttributeObj {
  const _$UpdateAttributeObj(
      {required this.id, this.description, this.level, final String? $type})
      : assert(level == null || level > 0 && level <= 10),
        $type = $type ?? 'update',
        super._();

  factory _$UpdateAttributeObj.fromJson(Map<String, dynamic> json) =>
      _$$UpdateAttributeObjFromJson(json);

  @override
  final String id;
  @override
  final String? description;
  @override
  final int? level;

  @JsonKey(name: 'action')
  final String $type;

  @override
  String toString() {
    return 'AttributesActionObj.update(id: $id, description: $description, level: $level)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateAttributeObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, description, level);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateAttributeObjCopyWith<_$UpdateAttributeObj> get copyWith =>
      __$$UpdateAttributeObjCopyWithImpl<_$UpdateAttributeObj>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AttributeType type, String description, int level)
        create,
    required TResult Function(String id, String? description, int? level)
        update,
    required TResult Function(String id) delete,
  }) {
    return update(id, description, level);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AttributeType type, String description, int level)?
        create,
    TResult? Function(String id, String? description, int? level)? update,
    TResult? Function(String id)? delete,
  }) {
    return update?.call(id, description, level);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AttributeType type, String description, int level)? create,
    TResult Function(String id, String? description, int? level)? update,
    TResult Function(String id)? delete,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(id, description, level);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateAttributeObj value) create,
    required TResult Function(UpdateAttributeObj value) update,
    required TResult Function(DeleteAttributeObj value) delete,
  }) {
    return update(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateAttributeObj value)? create,
    TResult? Function(UpdateAttributeObj value)? update,
    TResult? Function(DeleteAttributeObj value)? delete,
  }) {
    return update?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateAttributeObj value)? create,
    TResult Function(UpdateAttributeObj value)? update,
    TResult Function(DeleteAttributeObj value)? delete,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateAttributeObjToJson(
      this,
    );
  }
}

abstract class UpdateAttributeObj extends AttributesActionObj {
  const factory UpdateAttributeObj(
      {required final String id,
      final String? description,
      final int? level}) = _$UpdateAttributeObj;
  const UpdateAttributeObj._() : super._();

  factory UpdateAttributeObj.fromJson(Map<String, dynamic> json) =
      _$UpdateAttributeObj.fromJson;

  String get id;
  String? get description;
  int? get level;
  @JsonKey(ignore: true)
  _$$UpdateAttributeObjCopyWith<_$UpdateAttributeObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteAttributeObjCopyWith<$Res> {
  factory _$$DeleteAttributeObjCopyWith(_$DeleteAttributeObj value,
          $Res Function(_$DeleteAttributeObj) then) =
      __$$DeleteAttributeObjCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$DeleteAttributeObjCopyWithImpl<$Res>
    extends _$AttributesActionObjCopyWithImpl<$Res, _$DeleteAttributeObj>
    implements _$$DeleteAttributeObjCopyWith<$Res> {
  __$$DeleteAttributeObjCopyWithImpl(
      _$DeleteAttributeObj _value, $Res Function(_$DeleteAttributeObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$DeleteAttributeObj(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeleteAttributeObj extends DeleteAttributeObj {
  const _$DeleteAttributeObj({required this.id, final String? $type})
      : $type = $type ?? 'delete',
        super._();

  factory _$DeleteAttributeObj.fromJson(Map<String, dynamic> json) =>
      _$$DeleteAttributeObjFromJson(json);

  @override
  final String id;

  @JsonKey(name: 'action')
  final String $type;

  @override
  String toString() {
    return 'AttributesActionObj.delete(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteAttributeObj &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteAttributeObjCopyWith<_$DeleteAttributeObj> get copyWith =>
      __$$DeleteAttributeObjCopyWithImpl<_$DeleteAttributeObj>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AttributeType type, String description, int level)
        create,
    required TResult Function(String id, String? description, int? level)
        update,
    required TResult Function(String id) delete,
  }) {
    return delete(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AttributeType type, String description, int level)?
        create,
    TResult? Function(String id, String? description, int? level)? update,
    TResult? Function(String id)? delete,
  }) {
    return delete?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AttributeType type, String description, int level)? create,
    TResult Function(String id, String? description, int? level)? update,
    TResult Function(String id)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateAttributeObj value) create,
    required TResult Function(UpdateAttributeObj value) update,
    required TResult Function(DeleteAttributeObj value) delete,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateAttributeObj value)? create,
    TResult? Function(UpdateAttributeObj value)? update,
    TResult? Function(DeleteAttributeObj value)? delete,
  }) {
    return delete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateAttributeObj value)? create,
    TResult Function(UpdateAttributeObj value)? update,
    TResult Function(DeleteAttributeObj value)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DeleteAttributeObjToJson(
      this,
    );
  }
}

abstract class DeleteAttributeObj extends AttributesActionObj {
  const factory DeleteAttributeObj({required final String id}) =
      _$DeleteAttributeObj;
  const DeleteAttributeObj._() : super._();

  factory DeleteAttributeObj.fromJson(Map<String, dynamic> json) =
      _$DeleteAttributeObj.fromJson;

  String get id;
  @JsonKey(ignore: true)
  _$$DeleteAttributeObjCopyWith<_$DeleteAttributeObj> get copyWith =>
      throw _privateConstructorUsedError;
}
