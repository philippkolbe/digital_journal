// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChallengeObj _$ChallengeObjFromJson(Map<String, dynamic> json) {
  return _ChallengeObj.fromJson(json);
}

/// @nodoc
mixin _$ChallengeObj {
  String? get id => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get durationInDays => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChallengeObjCopyWith<ChallengeObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeObjCopyWith<$Res> {
  factory $ChallengeObjCopyWith(
          ChallengeObj value, $Res Function(ChallengeObj) then) =
      _$ChallengeObjCopyWithImpl<$Res, ChallengeObj>;
  @useResult
  $Res call(
      {String? id,
      bool isPublic,
      String title,
      String description,
      int durationInDays,
      String? imageUrl});
}

/// @nodoc
class _$ChallengeObjCopyWithImpl<$Res, $Val extends ChallengeObj>
    implements $ChallengeObjCopyWith<$Res> {
  _$ChallengeObjCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? isPublic = null,
    Object? title = null,
    Object? description = null,
    Object? durationInDays = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      durationInDays: null == durationInDays
          ? _value.durationInDays
          : durationInDays // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChallengeObjCopyWith<$Res>
    implements $ChallengeObjCopyWith<$Res> {
  factory _$$_ChallengeObjCopyWith(
          _$_ChallengeObj value, $Res Function(_$_ChallengeObj) then) =
      __$$_ChallengeObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      bool isPublic,
      String title,
      String description,
      int durationInDays,
      String? imageUrl});
}

/// @nodoc
class __$$_ChallengeObjCopyWithImpl<$Res>
    extends _$ChallengeObjCopyWithImpl<$Res, _$_ChallengeObj>
    implements _$$_ChallengeObjCopyWith<$Res> {
  __$$_ChallengeObjCopyWithImpl(
      _$_ChallengeObj _value, $Res Function(_$_ChallengeObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? isPublic = null,
    Object? title = null,
    Object? description = null,
    Object? durationInDays = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_$_ChallengeObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      durationInDays: null == durationInDays
          ? _value.durationInDays
          : durationInDays // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChallengeObj extends _ChallengeObj {
  const _$_ChallengeObj(
      {this.id,
      this.isPublic = false,
      required this.title,
      this.description = "",
      required this.durationInDays,
      this.imageUrl})
      : super._();

  factory _$_ChallengeObj.fromJson(Map<String, dynamic> json) =>
      _$$_ChallengeObjFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey()
  final bool isPublic;
  @override
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  final int durationInDays;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'ChallengeObj(id: $id, isPublic: $isPublic, title: $title, description: $description, durationInDays: $durationInDays, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChallengeObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.durationInDays, durationInDays) ||
                other.durationInDays == durationInDays) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, isPublic, title, description, durationInDays, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChallengeObjCopyWith<_$_ChallengeObj> get copyWith =>
      __$$_ChallengeObjCopyWithImpl<_$_ChallengeObj>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChallengeObjToJson(
      this,
    );
  }
}

abstract class _ChallengeObj extends ChallengeObj {
  const factory _ChallengeObj(
      {final String? id,
      final bool isPublic,
      required final String title,
      final String description,
      required final int durationInDays,
      final String? imageUrl}) = _$_ChallengeObj;
  const _ChallengeObj._() : super._();

  factory _ChallengeObj.fromJson(Map<String, dynamic> json) =
      _$_ChallengeObj.fromJson;

  @override
  String? get id;
  @override
  bool get isPublic;
  @override
  String get title;
  @override
  String get description;
  @override
  int get durationInDays;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_ChallengeObjCopyWith<_$_ChallengeObj> get copyWith =>
      throw _privateConstructorUsedError;
}
