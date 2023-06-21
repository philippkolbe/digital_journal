// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProgressObj _$ProgressObjFromJson(Map<String, dynamic> json) {
  return _ProgressObj.fromJson(json);
}

/// @nodoc
mixin _$ProgressObj {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @DateConverter()
  DateTime get startsOn => throw _privateConstructorUsedError;
  int get durationInDays => throw _privateConstructorUsedError;
  int get daysCompleted => throw _privateConstructorUsedError;
  int get streak => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProgressObjCopyWith<ProgressObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressObjCopyWith<$Res> {
  factory $ProgressObjCopyWith(
          ProgressObj value, $Res Function(ProgressObj) then) =
      _$ProgressObjCopyWithImpl<$Res, ProgressObj>;
  @useResult
  $Res call(
      {String? id,
      String title,
      String description,
      @DateConverter() DateTime startsOn,
      int durationInDays,
      int daysCompleted,
      int streak,
      String? imageUrl});
}

/// @nodoc
class _$ProgressObjCopyWithImpl<$Res, $Val extends ProgressObj>
    implements $ProgressObjCopyWith<$Res> {
  _$ProgressObjCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? startsOn = null,
    Object? durationInDays = null,
    Object? daysCompleted = null,
    Object? streak = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startsOn: null == startsOn
          ? _value.startsOn
          : startsOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationInDays: null == durationInDays
          ? _value.durationInDays
          : durationInDays // ignore: cast_nullable_to_non_nullable
              as int,
      daysCompleted: null == daysCompleted
          ? _value.daysCompleted
          : daysCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      streak: null == streak
          ? _value.streak
          : streak // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProgressObjCopyWith<$Res>
    implements $ProgressObjCopyWith<$Res> {
  factory _$$_ProgressObjCopyWith(
          _$_ProgressObj value, $Res Function(_$_ProgressObj) then) =
      __$$_ProgressObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String title,
      String description,
      @DateConverter() DateTime startsOn,
      int durationInDays,
      int daysCompleted,
      int streak,
      String? imageUrl});
}

/// @nodoc
class __$$_ProgressObjCopyWithImpl<$Res>
    extends _$ProgressObjCopyWithImpl<$Res, _$_ProgressObj>
    implements _$$_ProgressObjCopyWith<$Res> {
  __$$_ProgressObjCopyWithImpl(
      _$_ProgressObj _value, $Res Function(_$_ProgressObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? startsOn = null,
    Object? durationInDays = null,
    Object? daysCompleted = null,
    Object? streak = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_$_ProgressObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startsOn: null == startsOn
          ? _value.startsOn
          : startsOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationInDays: null == durationInDays
          ? _value.durationInDays
          : durationInDays // ignore: cast_nullable_to_non_nullable
              as int,
      daysCompleted: null == daysCompleted
          ? _value.daysCompleted
          : daysCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      streak: null == streak
          ? _value.streak
          : streak // ignore: cast_nullable_to_non_nullable
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
class _$_ProgressObj extends _ProgressObj {
  const _$_ProgressObj(
      {this.id,
      required this.title,
      this.description = "",
      @DateConverter() required this.startsOn,
      required this.durationInDays,
      this.daysCompleted = 0,
      this.streak = 0,
      this.imageUrl})
      : super._();

  factory _$_ProgressObj.fromJson(Map<String, dynamic> json) =>
      _$$_ProgressObjFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @DateConverter()
  final DateTime startsOn;
  @override
  final int durationInDays;
  @override
  @JsonKey()
  final int daysCompleted;
  @override
  @JsonKey()
  final int streak;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'ProgressObj(id: $id, title: $title, description: $description, startsOn: $startsOn, durationInDays: $durationInDays, daysCompleted: $daysCompleted, streak: $streak, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProgressObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startsOn, startsOn) ||
                other.startsOn == startsOn) &&
            (identical(other.durationInDays, durationInDays) ||
                other.durationInDays == durationInDays) &&
            (identical(other.daysCompleted, daysCompleted) ||
                other.daysCompleted == daysCompleted) &&
            (identical(other.streak, streak) || other.streak == streak) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, startsOn,
      durationInDays, daysCompleted, streak, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProgressObjCopyWith<_$_ProgressObj> get copyWith =>
      __$$_ProgressObjCopyWithImpl<_$_ProgressObj>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProgressObjToJson(
      this,
    );
  }
}

abstract class _ProgressObj extends ProgressObj {
  const factory _ProgressObj(
      {final String? id,
      required final String title,
      final String description,
      @DateConverter() required final DateTime startsOn,
      required final int durationInDays,
      final int daysCompleted,
      final int streak,
      final String? imageUrl}) = _$_ProgressObj;
  const _ProgressObj._() : super._();

  factory _ProgressObj.fromJson(Map<String, dynamic> json) =
      _$_ProgressObj.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  String get description;
  @override
  @DateConverter()
  DateTime get startsOn;
  @override
  int get durationInDays;
  @override
  int get daysCompleted;
  @override
  int get streak;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_ProgressObjCopyWith<_$_ProgressObj> get copyWith =>
      throw _privateConstructorUsedError;
}
