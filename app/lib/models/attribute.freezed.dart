// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attribute.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AttributeObj _$AttributeObjFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'like':
      return LikeAttributeObj.fromJson(json);
    case 'dislike':
      return DislikeAttributeObj.fromJson(json);
    case 'fear':
      return FearAttributeObj.fromJson(json);
    case 'value':
      return ValueAttributeObj.fromJson(json);
    case 'goal':
      return GoalAttributeObj.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'AttributeObj',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$AttributeObj {
  String? get id => throw _privateConstructorUsedError;
  AttributeType get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        like,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        dislike,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        fear,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        value,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        goal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        like,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        dislike,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        fear,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        value,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        goal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        like,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        dislike,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        fear,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        value,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        goal,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LikeAttributeObj value) like,
    required TResult Function(DislikeAttributeObj value) dislike,
    required TResult Function(FearAttributeObj value) fear,
    required TResult Function(ValueAttributeObj value) value,
    required TResult Function(GoalAttributeObj value) goal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LikeAttributeObj value)? like,
    TResult? Function(DislikeAttributeObj value)? dislike,
    TResult? Function(FearAttributeObj value)? fear,
    TResult? Function(ValueAttributeObj value)? value,
    TResult? Function(GoalAttributeObj value)? goal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LikeAttributeObj value)? like,
    TResult Function(DislikeAttributeObj value)? dislike,
    TResult Function(FearAttributeObj value)? fear,
    TResult Function(ValueAttributeObj value)? value,
    TResult Function(GoalAttributeObj value)? goal,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttributeObjCopyWith<AttributeObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttributeObjCopyWith<$Res> {
  factory $AttributeObjCopyWith(
          AttributeObj value, $Res Function(AttributeObj) then) =
      _$AttributeObjCopyWithImpl<$Res, AttributeObj>;
  @useResult
  $Res call({String? id, AttributeType type, String description, int level});
}

/// @nodoc
class _$AttributeObjCopyWithImpl<$Res, $Val extends AttributeObj>
    implements $AttributeObjCopyWith<$Res> {
  _$AttributeObjCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = null,
    Object? description = null,
    Object? level = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LikeAttributeObjCopyWith<$Res>
    implements $AttributeObjCopyWith<$Res> {
  factory _$$LikeAttributeObjCopyWith(
          _$LikeAttributeObj value, $Res Function(_$LikeAttributeObj) then) =
      __$$LikeAttributeObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, AttributeType type, String description, int level});
}

/// @nodoc
class __$$LikeAttributeObjCopyWithImpl<$Res>
    extends _$AttributeObjCopyWithImpl<$Res, _$LikeAttributeObj>
    implements _$$LikeAttributeObjCopyWith<$Res> {
  __$$LikeAttributeObjCopyWithImpl(
      _$LikeAttributeObj _value, $Res Function(_$LikeAttributeObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = null,
    Object? description = null,
    Object? level = null,
  }) {
    return _then(_$LikeAttributeObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$LikeAttributeObj extends LikeAttributeObj {
  const _$LikeAttributeObj(
      {this.id,
      this.type = AttributeType.like,
      required this.description,
      required this.level,
      final String? $type})
      : $type = $type ?? 'like',
        super._();

  factory _$LikeAttributeObj.fromJson(Map<String, dynamic> json) =>
      _$$LikeAttributeObjFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey()
  final AttributeType type;
  @override
  final String description;
  @override
  final int level;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AttributeObj.like(id: $id, type: $type, description: $description, level: $level)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LikeAttributeObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, description, level);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LikeAttributeObjCopyWith<_$LikeAttributeObj> get copyWith =>
      __$$LikeAttributeObjCopyWithImpl<_$LikeAttributeObj>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        like,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        dislike,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        fear,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        value,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        goal,
  }) {
    return like(id, type, description, level);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        like,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        dislike,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        fear,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        value,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        goal,
  }) {
    return like?.call(id, type, description, level);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        like,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        dislike,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        fear,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        value,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        goal,
    required TResult orElse(),
  }) {
    if (like != null) {
      return like(id, type, description, level);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LikeAttributeObj value) like,
    required TResult Function(DislikeAttributeObj value) dislike,
    required TResult Function(FearAttributeObj value) fear,
    required TResult Function(ValueAttributeObj value) value,
    required TResult Function(GoalAttributeObj value) goal,
  }) {
    return like(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LikeAttributeObj value)? like,
    TResult? Function(DislikeAttributeObj value)? dislike,
    TResult? Function(FearAttributeObj value)? fear,
    TResult? Function(ValueAttributeObj value)? value,
    TResult? Function(GoalAttributeObj value)? goal,
  }) {
    return like?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LikeAttributeObj value)? like,
    TResult Function(DislikeAttributeObj value)? dislike,
    TResult Function(FearAttributeObj value)? fear,
    TResult Function(ValueAttributeObj value)? value,
    TResult Function(GoalAttributeObj value)? goal,
    required TResult orElse(),
  }) {
    if (like != null) {
      return like(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LikeAttributeObjToJson(
      this,
    );
  }
}

abstract class LikeAttributeObj extends AttributeObj {
  const factory LikeAttributeObj(
      {final String? id,
      final AttributeType type,
      required final String description,
      required final int level}) = _$LikeAttributeObj;
  const LikeAttributeObj._() : super._();

  factory LikeAttributeObj.fromJson(Map<String, dynamic> json) =
      _$LikeAttributeObj.fromJson;

  @override
  String? get id;
  @override
  AttributeType get type;
  @override
  String get description;
  @override
  int get level;
  @override
  @JsonKey(ignore: true)
  _$$LikeAttributeObjCopyWith<_$LikeAttributeObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DislikeAttributeObjCopyWith<$Res>
    implements $AttributeObjCopyWith<$Res> {
  factory _$$DislikeAttributeObjCopyWith(_$DislikeAttributeObj value,
          $Res Function(_$DislikeAttributeObj) then) =
      __$$DislikeAttributeObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, AttributeType type, String description, int level});
}

/// @nodoc
class __$$DislikeAttributeObjCopyWithImpl<$Res>
    extends _$AttributeObjCopyWithImpl<$Res, _$DislikeAttributeObj>
    implements _$$DislikeAttributeObjCopyWith<$Res> {
  __$$DislikeAttributeObjCopyWithImpl(
      _$DislikeAttributeObj _value, $Res Function(_$DislikeAttributeObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = null,
    Object? description = null,
    Object? level = null,
  }) {
    return _then(_$DislikeAttributeObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$DislikeAttributeObj extends DislikeAttributeObj {
  const _$DislikeAttributeObj(
      {this.id,
      this.type = AttributeType.dislike,
      required this.description,
      required this.level,
      final String? $type})
      : $type = $type ?? 'dislike',
        super._();

  factory _$DislikeAttributeObj.fromJson(Map<String, dynamic> json) =>
      _$$DislikeAttributeObjFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey()
  final AttributeType type;
  @override
  final String description;
  @override
  final int level;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AttributeObj.dislike(id: $id, type: $type, description: $description, level: $level)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DislikeAttributeObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, description, level);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DislikeAttributeObjCopyWith<_$DislikeAttributeObj> get copyWith =>
      __$$DislikeAttributeObjCopyWithImpl<_$DislikeAttributeObj>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        like,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        dislike,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        fear,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        value,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        goal,
  }) {
    return dislike(id, type, description, level);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        like,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        dislike,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        fear,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        value,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        goal,
  }) {
    return dislike?.call(id, type, description, level);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        like,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        dislike,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        fear,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        value,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        goal,
    required TResult orElse(),
  }) {
    if (dislike != null) {
      return dislike(id, type, description, level);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LikeAttributeObj value) like,
    required TResult Function(DislikeAttributeObj value) dislike,
    required TResult Function(FearAttributeObj value) fear,
    required TResult Function(ValueAttributeObj value) value,
    required TResult Function(GoalAttributeObj value) goal,
  }) {
    return dislike(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LikeAttributeObj value)? like,
    TResult? Function(DislikeAttributeObj value)? dislike,
    TResult? Function(FearAttributeObj value)? fear,
    TResult? Function(ValueAttributeObj value)? value,
    TResult? Function(GoalAttributeObj value)? goal,
  }) {
    return dislike?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LikeAttributeObj value)? like,
    TResult Function(DislikeAttributeObj value)? dislike,
    TResult Function(FearAttributeObj value)? fear,
    TResult Function(ValueAttributeObj value)? value,
    TResult Function(GoalAttributeObj value)? goal,
    required TResult orElse(),
  }) {
    if (dislike != null) {
      return dislike(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DislikeAttributeObjToJson(
      this,
    );
  }
}

abstract class DislikeAttributeObj extends AttributeObj {
  const factory DislikeAttributeObj(
      {final String? id,
      final AttributeType type,
      required final String description,
      required final int level}) = _$DislikeAttributeObj;
  const DislikeAttributeObj._() : super._();

  factory DislikeAttributeObj.fromJson(Map<String, dynamic> json) =
      _$DislikeAttributeObj.fromJson;

  @override
  String? get id;
  @override
  AttributeType get type;
  @override
  String get description;
  @override
  int get level;
  @override
  @JsonKey(ignore: true)
  _$$DislikeAttributeObjCopyWith<_$DislikeAttributeObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FearAttributeObjCopyWith<$Res>
    implements $AttributeObjCopyWith<$Res> {
  factory _$$FearAttributeObjCopyWith(
          _$FearAttributeObj value, $Res Function(_$FearAttributeObj) then) =
      __$$FearAttributeObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, AttributeType type, String description, int level});
}

/// @nodoc
class __$$FearAttributeObjCopyWithImpl<$Res>
    extends _$AttributeObjCopyWithImpl<$Res, _$FearAttributeObj>
    implements _$$FearAttributeObjCopyWith<$Res> {
  __$$FearAttributeObjCopyWithImpl(
      _$FearAttributeObj _value, $Res Function(_$FearAttributeObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = null,
    Object? description = null,
    Object? level = null,
  }) {
    return _then(_$FearAttributeObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$FearAttributeObj extends FearAttributeObj {
  const _$FearAttributeObj(
      {this.id,
      this.type = AttributeType.fear,
      required this.description,
      required this.level,
      final String? $type})
      : $type = $type ?? 'fear',
        super._();

  factory _$FearAttributeObj.fromJson(Map<String, dynamic> json) =>
      _$$FearAttributeObjFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey()
  final AttributeType type;
  @override
  final String description;
  @override
  final int level;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AttributeObj.fear(id: $id, type: $type, description: $description, level: $level)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FearAttributeObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, description, level);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FearAttributeObjCopyWith<_$FearAttributeObj> get copyWith =>
      __$$FearAttributeObjCopyWithImpl<_$FearAttributeObj>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        like,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        dislike,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        fear,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        value,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        goal,
  }) {
    return fear(id, type, description, level);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        like,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        dislike,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        fear,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        value,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        goal,
  }) {
    return fear?.call(id, type, description, level);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        like,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        dislike,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        fear,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        value,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        goal,
    required TResult orElse(),
  }) {
    if (fear != null) {
      return fear(id, type, description, level);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LikeAttributeObj value) like,
    required TResult Function(DislikeAttributeObj value) dislike,
    required TResult Function(FearAttributeObj value) fear,
    required TResult Function(ValueAttributeObj value) value,
    required TResult Function(GoalAttributeObj value) goal,
  }) {
    return fear(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LikeAttributeObj value)? like,
    TResult? Function(DislikeAttributeObj value)? dislike,
    TResult? Function(FearAttributeObj value)? fear,
    TResult? Function(ValueAttributeObj value)? value,
    TResult? Function(GoalAttributeObj value)? goal,
  }) {
    return fear?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LikeAttributeObj value)? like,
    TResult Function(DislikeAttributeObj value)? dislike,
    TResult Function(FearAttributeObj value)? fear,
    TResult Function(ValueAttributeObj value)? value,
    TResult Function(GoalAttributeObj value)? goal,
    required TResult orElse(),
  }) {
    if (fear != null) {
      return fear(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FearAttributeObjToJson(
      this,
    );
  }
}

abstract class FearAttributeObj extends AttributeObj {
  const factory FearAttributeObj(
      {final String? id,
      final AttributeType type,
      required final String description,
      required final int level}) = _$FearAttributeObj;
  const FearAttributeObj._() : super._();

  factory FearAttributeObj.fromJson(Map<String, dynamic> json) =
      _$FearAttributeObj.fromJson;

  @override
  String? get id;
  @override
  AttributeType get type;
  @override
  String get description;
  @override
  int get level;
  @override
  @JsonKey(ignore: true)
  _$$FearAttributeObjCopyWith<_$FearAttributeObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValueAttributeObjCopyWith<$Res>
    implements $AttributeObjCopyWith<$Res> {
  factory _$$ValueAttributeObjCopyWith(
          _$ValueAttributeObj value, $Res Function(_$ValueAttributeObj) then) =
      __$$ValueAttributeObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, AttributeType type, String description, int level});
}

/// @nodoc
class __$$ValueAttributeObjCopyWithImpl<$Res>
    extends _$AttributeObjCopyWithImpl<$Res, _$ValueAttributeObj>
    implements _$$ValueAttributeObjCopyWith<$Res> {
  __$$ValueAttributeObjCopyWithImpl(
      _$ValueAttributeObj _value, $Res Function(_$ValueAttributeObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = null,
    Object? description = null,
    Object? level = null,
  }) {
    return _then(_$ValueAttributeObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$ValueAttributeObj extends ValueAttributeObj {
  const _$ValueAttributeObj(
      {this.id,
      this.type = AttributeType.value,
      required this.description,
      required this.level,
      final String? $type})
      : $type = $type ?? 'value',
        super._();

  factory _$ValueAttributeObj.fromJson(Map<String, dynamic> json) =>
      _$$ValueAttributeObjFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey()
  final AttributeType type;
  @override
  final String description;
  @override
  final int level;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AttributeObj.value(id: $id, type: $type, description: $description, level: $level)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValueAttributeObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, description, level);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValueAttributeObjCopyWith<_$ValueAttributeObj> get copyWith =>
      __$$ValueAttributeObjCopyWithImpl<_$ValueAttributeObj>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        like,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        dislike,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        fear,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        value,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        goal,
  }) {
    return value(id, type, description, level);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        like,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        dislike,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        fear,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        value,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        goal,
  }) {
    return value?.call(id, type, description, level);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        like,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        dislike,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        fear,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        value,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        goal,
    required TResult orElse(),
  }) {
    if (value != null) {
      return value(id, type, description, level);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LikeAttributeObj value) like,
    required TResult Function(DislikeAttributeObj value) dislike,
    required TResult Function(FearAttributeObj value) fear,
    required TResult Function(ValueAttributeObj value) value,
    required TResult Function(GoalAttributeObj value) goal,
  }) {
    return value(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LikeAttributeObj value)? like,
    TResult? Function(DislikeAttributeObj value)? dislike,
    TResult? Function(FearAttributeObj value)? fear,
    TResult? Function(ValueAttributeObj value)? value,
    TResult? Function(GoalAttributeObj value)? goal,
  }) {
    return value?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LikeAttributeObj value)? like,
    TResult Function(DislikeAttributeObj value)? dislike,
    TResult Function(FearAttributeObj value)? fear,
    TResult Function(ValueAttributeObj value)? value,
    TResult Function(GoalAttributeObj value)? goal,
    required TResult orElse(),
  }) {
    if (value != null) {
      return value(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ValueAttributeObjToJson(
      this,
    );
  }
}

abstract class ValueAttributeObj extends AttributeObj {
  const factory ValueAttributeObj(
      {final String? id,
      final AttributeType type,
      required final String description,
      required final int level}) = _$ValueAttributeObj;
  const ValueAttributeObj._() : super._();

  factory ValueAttributeObj.fromJson(Map<String, dynamic> json) =
      _$ValueAttributeObj.fromJson;

  @override
  String? get id;
  @override
  AttributeType get type;
  @override
  String get description;
  @override
  int get level;
  @override
  @JsonKey(ignore: true)
  _$$ValueAttributeObjCopyWith<_$ValueAttributeObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GoalAttributeObjCopyWith<$Res>
    implements $AttributeObjCopyWith<$Res> {
  factory _$$GoalAttributeObjCopyWith(
          _$GoalAttributeObj value, $Res Function(_$GoalAttributeObj) then) =
      __$$GoalAttributeObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, AttributeType type, String description, int level});
}

/// @nodoc
class __$$GoalAttributeObjCopyWithImpl<$Res>
    extends _$AttributeObjCopyWithImpl<$Res, _$GoalAttributeObj>
    implements _$$GoalAttributeObjCopyWith<$Res> {
  __$$GoalAttributeObjCopyWithImpl(
      _$GoalAttributeObj _value, $Res Function(_$GoalAttributeObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = null,
    Object? description = null,
    Object? level = null,
  }) {
    return _then(_$GoalAttributeObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$GoalAttributeObj extends GoalAttributeObj {
  const _$GoalAttributeObj(
      {this.id,
      this.type = AttributeType.goal,
      required this.description,
      required this.level,
      final String? $type})
      : $type = $type ?? 'goal',
        super._();

  factory _$GoalAttributeObj.fromJson(Map<String, dynamic> json) =>
      _$$GoalAttributeObjFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey()
  final AttributeType type;
  @override
  final String description;
  @override
  final int level;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AttributeObj.goal(id: $id, type: $type, description: $description, level: $level)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalAttributeObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, description, level);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalAttributeObjCopyWith<_$GoalAttributeObj> get copyWith =>
      __$$GoalAttributeObjCopyWithImpl<_$GoalAttributeObj>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        like,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        dislike,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        fear,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        value,
    required TResult Function(
            String? id, AttributeType type, String description, int level)
        goal,
  }) {
    return goal(id, type, description, level);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        like,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        dislike,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        fear,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        value,
    TResult? Function(
            String? id, AttributeType type, String description, int level)?
        goal,
  }) {
    return goal?.call(id, type, description, level);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        like,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        dislike,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        fear,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        value,
    TResult Function(
            String? id, AttributeType type, String description, int level)?
        goal,
    required TResult orElse(),
  }) {
    if (goal != null) {
      return goal(id, type, description, level);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LikeAttributeObj value) like,
    required TResult Function(DislikeAttributeObj value) dislike,
    required TResult Function(FearAttributeObj value) fear,
    required TResult Function(ValueAttributeObj value) value,
    required TResult Function(GoalAttributeObj value) goal,
  }) {
    return goal(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LikeAttributeObj value)? like,
    TResult? Function(DislikeAttributeObj value)? dislike,
    TResult? Function(FearAttributeObj value)? fear,
    TResult? Function(ValueAttributeObj value)? value,
    TResult? Function(GoalAttributeObj value)? goal,
  }) {
    return goal?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LikeAttributeObj value)? like,
    TResult Function(DislikeAttributeObj value)? dislike,
    TResult Function(FearAttributeObj value)? fear,
    TResult Function(ValueAttributeObj value)? value,
    TResult Function(GoalAttributeObj value)? goal,
    required TResult orElse(),
  }) {
    if (goal != null) {
      return goal(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalAttributeObjToJson(
      this,
    );
  }
}

abstract class GoalAttributeObj extends AttributeObj {
  const factory GoalAttributeObj(
      {final String? id,
      final AttributeType type,
      required final String description,
      required final int level}) = _$GoalAttributeObj;
  const GoalAttributeObj._() : super._();

  factory GoalAttributeObj.fromJson(Map<String, dynamic> json) =
      _$GoalAttributeObj.fromJson;

  @override
  String? get id;
  @override
  AttributeType get type;
  @override
  String get description;
  @override
  int get level;
  @override
  @JsonKey(ignore: true)
  _$$GoalAttributeObjCopyWith<_$GoalAttributeObj> get copyWith =>
      throw _privateConstructorUsedError;
}
