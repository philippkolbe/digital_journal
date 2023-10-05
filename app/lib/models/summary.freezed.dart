// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SummaryObj _$SummaryObjFromJson(Map<String, dynamic> json) {
  return _SummaryObj.fromJson(json);
}

/// @nodoc
mixin _$SummaryObj {
  @DateConverter()
  DateTime get date => throw _privateConstructorUsedError;
  String? get validUpToId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SummaryObjCopyWith<SummaryObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SummaryObjCopyWith<$Res> {
  factory $SummaryObjCopyWith(
          SummaryObj value, $Res Function(SummaryObj) then) =
      _$SummaryObjCopyWithImpl<$Res, SummaryObj>;
  @useResult
  $Res call(
      {@DateConverter() DateTime date, String? validUpToId, String content});
}

/// @nodoc
class _$SummaryObjCopyWithImpl<$Res, $Val extends SummaryObj>
    implements $SummaryObjCopyWith<$Res> {
  _$SummaryObjCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? validUpToId = freezed,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      validUpToId: freezed == validUpToId
          ? _value.validUpToId
          : validUpToId // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SummaryObjCopyWith<$Res>
    implements $SummaryObjCopyWith<$Res> {
  factory _$$_SummaryObjCopyWith(
          _$_SummaryObj value, $Res Function(_$_SummaryObj) then) =
      __$$_SummaryObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@DateConverter() DateTime date, String? validUpToId, String content});
}

/// @nodoc
class __$$_SummaryObjCopyWithImpl<$Res>
    extends _$SummaryObjCopyWithImpl<$Res, _$_SummaryObj>
    implements _$$_SummaryObjCopyWith<$Res> {
  __$$_SummaryObjCopyWithImpl(
      _$_SummaryObj _value, $Res Function(_$_SummaryObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? validUpToId = freezed,
    Object? content = null,
  }) {
    return _then(_$_SummaryObj(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      validUpToId: freezed == validUpToId
          ? _value.validUpToId
          : validUpToId // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SummaryObj implements _SummaryObj {
  const _$_SummaryObj(
      {@DateConverter() required this.date,
      this.validUpToId,
      this.content = ""});

  factory _$_SummaryObj.fromJson(Map<String, dynamic> json) =>
      _$$_SummaryObjFromJson(json);

  @override
  @DateConverter()
  final DateTime date;
  @override
  final String? validUpToId;
  @override
  @JsonKey()
  final String content;

  @override
  String toString() {
    return 'SummaryObj(date: $date, validUpToId: $validUpToId, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SummaryObj &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.validUpToId, validUpToId) ||
                other.validUpToId == validUpToId) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, validUpToId, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SummaryObjCopyWith<_$_SummaryObj> get copyWith =>
      __$$_SummaryObjCopyWithImpl<_$_SummaryObj>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SummaryObjToJson(
      this,
    );
  }
}

abstract class _SummaryObj implements SummaryObj {
  const factory _SummaryObj(
      {@DateConverter() required final DateTime date,
      final String? validUpToId,
      final String content}) = _$_SummaryObj;

  factory _SummaryObj.fromJson(Map<String, dynamic> json) =
      _$_SummaryObj.fromJson;

  @override
  @DateConverter()
  DateTime get date;
  @override
  String? get validUpToId;
  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$_SummaryObjCopyWith<_$_SummaryObj> get copyWith =>
      throw _privateConstructorUsedError;
}
