// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personality.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PersonalityObj _$PersonalityObjFromJson(Map<String, dynamic> json) {
  return _PersonalityObj.fromJson(json);
}

/// @nodoc
mixin _$PersonalityObj {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get prompt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PersonalityObjCopyWith<PersonalityObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalityObjCopyWith<$Res> {
  factory $PersonalityObjCopyWith(
          PersonalityObj value, $Res Function(PersonalityObj) then) =
      _$PersonalityObjCopyWithImpl<$Res, PersonalityObj>;
  @useResult
  $Res call({String? id, String name, String description, String prompt});
}

/// @nodoc
class _$PersonalityObjCopyWithImpl<$Res, $Val extends PersonalityObj>
    implements $PersonalityObjCopyWith<$Res> {
  _$PersonalityObjCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = null,
    Object? prompt = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PersonalityObjCopyWith<$Res>
    implements $PersonalityObjCopyWith<$Res> {
  factory _$$_PersonalityObjCopyWith(
          _$_PersonalityObj value, $Res Function(_$_PersonalityObj) then) =
      __$$_PersonalityObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String name, String description, String prompt});
}

/// @nodoc
class __$$_PersonalityObjCopyWithImpl<$Res>
    extends _$PersonalityObjCopyWithImpl<$Res, _$_PersonalityObj>
    implements _$$_PersonalityObjCopyWith<$Res> {
  __$$_PersonalityObjCopyWithImpl(
      _$_PersonalityObj _value, $Res Function(_$_PersonalityObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = null,
    Object? prompt = null,
  }) {
    return _then(_$_PersonalityObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PersonalityObj extends _PersonalityObj {
  const _$_PersonalityObj(
      {this.id,
      required this.name,
      required this.description,
      required this.prompt})
      : super._();

  factory _$_PersonalityObj.fromJson(Map<String, dynamic> json) =>
      _$$_PersonalityObjFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String prompt;

  @override
  String toString() {
    return 'PersonalityObj(id: $id, name: $name, description: $description, prompt: $prompt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PersonalityObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.prompt, prompt) || other.prompt == prompt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, prompt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PersonalityObjCopyWith<_$_PersonalityObj> get copyWith =>
      __$$_PersonalityObjCopyWithImpl<_$_PersonalityObj>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PersonalityObjToJson(
      this,
    );
  }
}

abstract class _PersonalityObj extends PersonalityObj {
  const factory _PersonalityObj(
      {final String? id,
      required final String name,
      required final String description,
      required final String prompt}) = _$_PersonalityObj;
  const _PersonalityObj._() : super._();

  factory _PersonalityObj.fromJson(Map<String, dynamic> json) =
      _$_PersonalityObj.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get prompt;
  @override
  @JsonKey(ignore: true)
  _$$_PersonalityObjCopyWith<_$_PersonalityObj> get copyWith =>
      throw _privateConstructorUsedError;
}
