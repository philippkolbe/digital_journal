// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'information.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InformationObj _$InformationObjFromJson(Map<String, dynamic> json) {
  return _InformationObj.fromJson(json);
}

/// @nodoc
mixin _$InformationObj {
  String? get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @DateConverter()
  DateTime get date => throw _privateConstructorUsedError;
  @DateConverter()
  DateTime get expirationDate => throw _privateConstructorUsedError;
  int get importance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InformationObjCopyWith<InformationObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InformationObjCopyWith<$Res> {
  factory $InformationObjCopyWith(
          InformationObj value, $Res Function(InformationObj) then) =
      _$InformationObjCopyWithImpl<$Res, InformationObj>;
  @useResult
  $Res call(
      {String? id,
      String description,
      @DateConverter() DateTime date,
      @DateConverter() DateTime expirationDate,
      int importance});
}

/// @nodoc
class _$InformationObjCopyWithImpl<$Res, $Val extends InformationObj>
    implements $InformationObjCopyWith<$Res> {
  _$InformationObjCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? description = null,
    Object? date = null,
    Object? expirationDate = null,
    Object? importance = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expirationDate: null == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InformationObjCopyWith<$Res>
    implements $InformationObjCopyWith<$Res> {
  factory _$$_InformationObjCopyWith(
          _$_InformationObj value, $Res Function(_$_InformationObj) then) =
      __$$_InformationObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String description,
      @DateConverter() DateTime date,
      @DateConverter() DateTime expirationDate,
      int importance});
}

/// @nodoc
class __$$_InformationObjCopyWithImpl<$Res>
    extends _$InformationObjCopyWithImpl<$Res, _$_InformationObj>
    implements _$$_InformationObjCopyWith<$Res> {
  __$$_InformationObjCopyWithImpl(
      _$_InformationObj _value, $Res Function(_$_InformationObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? description = null,
    Object? date = null,
    Object? expirationDate = null,
    Object? importance = null,
  }) {
    return _then(_$_InformationObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expirationDate: null == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InformationObj extends _InformationObj {
  const _$_InformationObj(
      {this.id,
      required this.description,
      @DateConverter() required this.date,
      @DateConverter() required this.expirationDate,
      required this.importance})
      : super._();

  factory _$_InformationObj.fromJson(Map<String, dynamic> json) =>
      _$$_InformationObjFromJson(json);

  @override
  final String? id;
  @override
  final String description;
  @override
  @DateConverter()
  final DateTime date;
  @override
  @DateConverter()
  final DateTime expirationDate;
  @override
  final int importance;

  @override
  String toString() {
    return 'InformationObj(id: $id, description: $description, date: $date, expirationDate: $expirationDate, importance: $importance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InformationObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.expirationDate, expirationDate) ||
                other.expirationDate == expirationDate) &&
            (identical(other.importance, importance) ||
                other.importance == importance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, description, date, expirationDate, importance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InformationObjCopyWith<_$_InformationObj> get copyWith =>
      __$$_InformationObjCopyWithImpl<_$_InformationObj>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InformationObjToJson(
      this,
    );
  }
}

abstract class _InformationObj extends InformationObj {
  const factory _InformationObj(
      {final String? id,
      required final String description,
      @DateConverter() required final DateTime date,
      @DateConverter() required final DateTime expirationDate,
      required final int importance}) = _$_InformationObj;
  const _InformationObj._() : super._();

  factory _InformationObj.fromJson(Map<String, dynamic> json) =
      _$_InformationObj.fromJson;

  @override
  String? get id;
  @override
  String get description;
  @override
  @DateConverter()
  DateTime get date;
  @override
  @DateConverter()
  DateTime get expirationDate;
  @override
  int get importance;
  @override
  @JsonKey(ignore: true)
  _$$_InformationObjCopyWith<_$_InformationObj> get copyWith =>
      throw _privateConstructorUsedError;
}
