// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProgressEntryObj _$ProgressEntryObjFromJson(Map<String, dynamic> json) {
  return _ProgressEntryObj.fromJson(json);
}

/// @nodoc
mixin _$ProgressEntryObj {
  String? get id => throw _privateConstructorUsedError;
  @DateConverter()
  DateTime get trackingDate => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProgressEntryObjCopyWith<ProgressEntryObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressEntryObjCopyWith<$Res> {
  factory $ProgressEntryObjCopyWith(
          ProgressEntryObj value, $Res Function(ProgressEntryObj) then) =
      _$ProgressEntryObjCopyWithImpl<$Res, ProgressEntryObj>;
  @useResult
  $Res call(
      {String? id, @DateConverter() DateTime trackingDate, bool isCompleted});
}

/// @nodoc
class _$ProgressEntryObjCopyWithImpl<$Res, $Val extends ProgressEntryObj>
    implements $ProgressEntryObjCopyWith<$Res> {
  _$ProgressEntryObjCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? trackingDate = null,
    Object? isCompleted = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      trackingDate: null == trackingDate
          ? _value.trackingDate
          : trackingDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProgressEntryObjCopyWith<$Res>
    implements $ProgressEntryObjCopyWith<$Res> {
  factory _$$_ProgressEntryObjCopyWith(
          _$_ProgressEntryObj value, $Res Function(_$_ProgressEntryObj) then) =
      __$$_ProgressEntryObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id, @DateConverter() DateTime trackingDate, bool isCompleted});
}

/// @nodoc
class __$$_ProgressEntryObjCopyWithImpl<$Res>
    extends _$ProgressEntryObjCopyWithImpl<$Res, _$_ProgressEntryObj>
    implements _$$_ProgressEntryObjCopyWith<$Res> {
  __$$_ProgressEntryObjCopyWithImpl(
      _$_ProgressEntryObj _value, $Res Function(_$_ProgressEntryObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? trackingDate = null,
    Object? isCompleted = null,
  }) {
    return _then(_$_ProgressEntryObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      trackingDate: null == trackingDate
          ? _value.trackingDate
          : trackingDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProgressEntryObj extends _ProgressEntryObj {
  const _$_ProgressEntryObj(
      {this.id,
      @DateConverter() required this.trackingDate,
      this.isCompleted = false})
      : super._();

  factory _$_ProgressEntryObj.fromJson(Map<String, dynamic> json) =>
      _$$_ProgressEntryObjFromJson(json);

  @override
  final String? id;
  @override
  @DateConverter()
  final DateTime trackingDate;
  @override
  @JsonKey()
  final bool isCompleted;

  @override
  String toString() {
    return 'ProgressEntryObj(id: $id, trackingDate: $trackingDate, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProgressEntryObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.trackingDate, trackingDate) ||
                other.trackingDate == trackingDate) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, trackingDate, isCompleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProgressEntryObjCopyWith<_$_ProgressEntryObj> get copyWith =>
      __$$_ProgressEntryObjCopyWithImpl<_$_ProgressEntryObj>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProgressEntryObjToJson(
      this,
    );
  }
}

abstract class _ProgressEntryObj extends ProgressEntryObj {
  const factory _ProgressEntryObj(
      {final String? id,
      @DateConverter() required final DateTime trackingDate,
      final bool isCompleted}) = _$_ProgressEntryObj;
  const _ProgressEntryObj._() : super._();

  factory _ProgressEntryObj.fromJson(Map<String, dynamic> json) =
      _$_ProgressEntryObj.fromJson;

  @override
  String? get id;
  @override
  @DateConverter()
  DateTime get trackingDate;
  @override
  bool get isCompleted;
  @override
  @JsonKey(ignore: true)
  _$$_ProgressEntryObjCopyWith<_$_ProgressEntryObj> get copyWith =>
      throw _privateConstructorUsedError;
}
