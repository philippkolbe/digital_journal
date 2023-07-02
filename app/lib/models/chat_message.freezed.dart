// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatMessageObj _$ChatMessageObjFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'assistant':
      return AssistantChatMessageObj.fromJson(json);
    case 'user':
      return UserChatMessageObj.fromJson(json);
    case 'system':
      return SystemChatMessageObj.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ChatMessageObj',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ChatMessageObj {
  String? get id => throw _privateConstructorUsedError;
  @DateConverter()
  DateTime get date => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id, @DateConverter() DateTime date, String content)
        assistant,
    required TResult Function(
            String? id, @DateConverter() DateTime date, String content)
        user,
    required TResult Function(
            String? id, @DateConverter() DateTime date, String content)
        system,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id, @DateConverter() DateTime date, String content)?
        assistant,
    TResult? Function(
            String? id, @DateConverter() DateTime date, String content)?
        user,
    TResult? Function(
            String? id, @DateConverter() DateTime date, String content)?
        system,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id, @DateConverter() DateTime date, String content)?
        assistant,
    TResult Function(
            String? id, @DateConverter() DateTime date, String content)?
        user,
    TResult Function(
            String? id, @DateConverter() DateTime date, String content)?
        system,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssistantChatMessageObj value) assistant,
    required TResult Function(UserChatMessageObj value) user,
    required TResult Function(SystemChatMessageObj value) system,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssistantChatMessageObj value)? assistant,
    TResult? Function(UserChatMessageObj value)? user,
    TResult? Function(SystemChatMessageObj value)? system,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssistantChatMessageObj value)? assistant,
    TResult Function(UserChatMessageObj value)? user,
    TResult Function(SystemChatMessageObj value)? system,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageObjCopyWith<ChatMessageObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageObjCopyWith<$Res> {
  factory $ChatMessageObjCopyWith(
          ChatMessageObj value, $Res Function(ChatMessageObj) then) =
      _$ChatMessageObjCopyWithImpl<$Res, ChatMessageObj>;
  @useResult
  $Res call({String? id, @DateConverter() DateTime date, String content});
}

/// @nodoc
class _$ChatMessageObjCopyWithImpl<$Res, $Val extends ChatMessageObj>
    implements $ChatMessageObjCopyWith<$Res> {
  _$ChatMessageObjCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssistantChatMessageObjCopyWith<$Res>
    implements $ChatMessageObjCopyWith<$Res> {
  factory _$$AssistantChatMessageObjCopyWith(_$AssistantChatMessageObj value,
          $Res Function(_$AssistantChatMessageObj) then) =
      __$$AssistantChatMessageObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, @DateConverter() DateTime date, String content});
}

/// @nodoc
class __$$AssistantChatMessageObjCopyWithImpl<$Res>
    extends _$ChatMessageObjCopyWithImpl<$Res, _$AssistantChatMessageObj>
    implements _$$AssistantChatMessageObjCopyWith<$Res> {
  __$$AssistantChatMessageObjCopyWithImpl(_$AssistantChatMessageObj _value,
      $Res Function(_$AssistantChatMessageObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = null,
    Object? content = null,
  }) {
    return _then(_$AssistantChatMessageObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssistantChatMessageObj extends AssistantChatMessageObj {
  const _$AssistantChatMessageObj(
      {this.id,
      @DateConverter() required this.date,
      required this.content,
      final String? $type})
      : $type = $type ?? 'assistant',
        super._();

  factory _$AssistantChatMessageObj.fromJson(Map<String, dynamic> json) =>
      _$$AssistantChatMessageObjFromJson(json);

  @override
  final String? id;
  @override
  @DateConverter()
  final DateTime date;
  @override
  final String content;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ChatMessageObj.assistant(id: $id, date: $date, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssistantChatMessageObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssistantChatMessageObjCopyWith<_$AssistantChatMessageObj> get copyWith =>
      __$$AssistantChatMessageObjCopyWithImpl<_$AssistantChatMessageObj>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id, @DateConverter() DateTime date, String content)
        assistant,
    required TResult Function(
            String? id, @DateConverter() DateTime date, String content)
        user,
    required TResult Function(
            String? id, @DateConverter() DateTime date, String content)
        system,
  }) {
    return assistant(id, date, content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id, @DateConverter() DateTime date, String content)?
        assistant,
    TResult? Function(
            String? id, @DateConverter() DateTime date, String content)?
        user,
    TResult? Function(
            String? id, @DateConverter() DateTime date, String content)?
        system,
  }) {
    return assistant?.call(id, date, content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id, @DateConverter() DateTime date, String content)?
        assistant,
    TResult Function(
            String? id, @DateConverter() DateTime date, String content)?
        user,
    TResult Function(
            String? id, @DateConverter() DateTime date, String content)?
        system,
    required TResult orElse(),
  }) {
    if (assistant != null) {
      return assistant(id, date, content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssistantChatMessageObj value) assistant,
    required TResult Function(UserChatMessageObj value) user,
    required TResult Function(SystemChatMessageObj value) system,
  }) {
    return assistant(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssistantChatMessageObj value)? assistant,
    TResult? Function(UserChatMessageObj value)? user,
    TResult? Function(SystemChatMessageObj value)? system,
  }) {
    return assistant?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssistantChatMessageObj value)? assistant,
    TResult Function(UserChatMessageObj value)? user,
    TResult Function(SystemChatMessageObj value)? system,
    required TResult orElse(),
  }) {
    if (assistant != null) {
      return assistant(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AssistantChatMessageObjToJson(
      this,
    );
  }
}

abstract class AssistantChatMessageObj extends ChatMessageObj {
  const factory AssistantChatMessageObj(
      {final String? id,
      @DateConverter() required final DateTime date,
      required final String content}) = _$AssistantChatMessageObj;
  const AssistantChatMessageObj._() : super._();

  factory AssistantChatMessageObj.fromJson(Map<String, dynamic> json) =
      _$AssistantChatMessageObj.fromJson;

  @override
  String? get id;
  @override
  @DateConverter()
  DateTime get date;
  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$AssistantChatMessageObjCopyWith<_$AssistantChatMessageObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserChatMessageObjCopyWith<$Res>
    implements $ChatMessageObjCopyWith<$Res> {
  factory _$$UserChatMessageObjCopyWith(_$UserChatMessageObj value,
          $Res Function(_$UserChatMessageObj) then) =
      __$$UserChatMessageObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, @DateConverter() DateTime date, String content});
}

/// @nodoc
class __$$UserChatMessageObjCopyWithImpl<$Res>
    extends _$ChatMessageObjCopyWithImpl<$Res, _$UserChatMessageObj>
    implements _$$UserChatMessageObjCopyWith<$Res> {
  __$$UserChatMessageObjCopyWithImpl(
      _$UserChatMessageObj _value, $Res Function(_$UserChatMessageObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = null,
    Object? content = null,
  }) {
    return _then(_$UserChatMessageObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserChatMessageObj extends UserChatMessageObj {
  const _$UserChatMessageObj(
      {this.id,
      @DateConverter() required this.date,
      required this.content,
      final String? $type})
      : $type = $type ?? 'user',
        super._();

  factory _$UserChatMessageObj.fromJson(Map<String, dynamic> json) =>
      _$$UserChatMessageObjFromJson(json);

  @override
  final String? id;
  @override
  @DateConverter()
  final DateTime date;
  @override
  final String content;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ChatMessageObj.user(id: $id, date: $date, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserChatMessageObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserChatMessageObjCopyWith<_$UserChatMessageObj> get copyWith =>
      __$$UserChatMessageObjCopyWithImpl<_$UserChatMessageObj>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id, @DateConverter() DateTime date, String content)
        assistant,
    required TResult Function(
            String? id, @DateConverter() DateTime date, String content)
        user,
    required TResult Function(
            String? id, @DateConverter() DateTime date, String content)
        system,
  }) {
    return user(id, date, content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id, @DateConverter() DateTime date, String content)?
        assistant,
    TResult? Function(
            String? id, @DateConverter() DateTime date, String content)?
        user,
    TResult? Function(
            String? id, @DateConverter() DateTime date, String content)?
        system,
  }) {
    return user?.call(id, date, content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id, @DateConverter() DateTime date, String content)?
        assistant,
    TResult Function(
            String? id, @DateConverter() DateTime date, String content)?
        user,
    TResult Function(
            String? id, @DateConverter() DateTime date, String content)?
        system,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(id, date, content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssistantChatMessageObj value) assistant,
    required TResult Function(UserChatMessageObj value) user,
    required TResult Function(SystemChatMessageObj value) system,
  }) {
    return user(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssistantChatMessageObj value)? assistant,
    TResult? Function(UserChatMessageObj value)? user,
    TResult? Function(SystemChatMessageObj value)? system,
  }) {
    return user?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssistantChatMessageObj value)? assistant,
    TResult Function(UserChatMessageObj value)? user,
    TResult Function(SystemChatMessageObj value)? system,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UserChatMessageObjToJson(
      this,
    );
  }
}

abstract class UserChatMessageObj extends ChatMessageObj {
  const factory UserChatMessageObj(
      {final String? id,
      @DateConverter() required final DateTime date,
      required final String content}) = _$UserChatMessageObj;
  const UserChatMessageObj._() : super._();

  factory UserChatMessageObj.fromJson(Map<String, dynamic> json) =
      _$UserChatMessageObj.fromJson;

  @override
  String? get id;
  @override
  @DateConverter()
  DateTime get date;
  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$UserChatMessageObjCopyWith<_$UserChatMessageObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SystemChatMessageObjCopyWith<$Res>
    implements $ChatMessageObjCopyWith<$Res> {
  factory _$$SystemChatMessageObjCopyWith(_$SystemChatMessageObj value,
          $Res Function(_$SystemChatMessageObj) then) =
      __$$SystemChatMessageObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, @DateConverter() DateTime date, String content});
}

/// @nodoc
class __$$SystemChatMessageObjCopyWithImpl<$Res>
    extends _$ChatMessageObjCopyWithImpl<$Res, _$SystemChatMessageObj>
    implements _$$SystemChatMessageObjCopyWith<$Res> {
  __$$SystemChatMessageObjCopyWithImpl(_$SystemChatMessageObj _value,
      $Res Function(_$SystemChatMessageObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = null,
    Object? content = null,
  }) {
    return _then(_$SystemChatMessageObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SystemChatMessageObj extends SystemChatMessageObj {
  const _$SystemChatMessageObj(
      {this.id,
      @DateConverter() required this.date,
      required this.content,
      final String? $type})
      : $type = $type ?? 'system',
        super._();

  factory _$SystemChatMessageObj.fromJson(Map<String, dynamic> json) =>
      _$$SystemChatMessageObjFromJson(json);

  @override
  final String? id;
  @override
  @DateConverter()
  final DateTime date;
  @override
  final String content;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ChatMessageObj.system(id: $id, date: $date, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SystemChatMessageObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SystemChatMessageObjCopyWith<_$SystemChatMessageObj> get copyWith =>
      __$$SystemChatMessageObjCopyWithImpl<_$SystemChatMessageObj>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id, @DateConverter() DateTime date, String content)
        assistant,
    required TResult Function(
            String? id, @DateConverter() DateTime date, String content)
        user,
    required TResult Function(
            String? id, @DateConverter() DateTime date, String content)
        system,
  }) {
    return system(id, date, content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? id, @DateConverter() DateTime date, String content)?
        assistant,
    TResult? Function(
            String? id, @DateConverter() DateTime date, String content)?
        user,
    TResult? Function(
            String? id, @DateConverter() DateTime date, String content)?
        system,
  }) {
    return system?.call(id, date, content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? id, @DateConverter() DateTime date, String content)?
        assistant,
    TResult Function(
            String? id, @DateConverter() DateTime date, String content)?
        user,
    TResult Function(
            String? id, @DateConverter() DateTime date, String content)?
        system,
    required TResult orElse(),
  }) {
    if (system != null) {
      return system(id, date, content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AssistantChatMessageObj value) assistant,
    required TResult Function(UserChatMessageObj value) user,
    required TResult Function(SystemChatMessageObj value) system,
  }) {
    return system(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AssistantChatMessageObj value)? assistant,
    TResult? Function(UserChatMessageObj value)? user,
    TResult? Function(SystemChatMessageObj value)? system,
  }) {
    return system?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AssistantChatMessageObj value)? assistant,
    TResult Function(UserChatMessageObj value)? user,
    TResult Function(SystemChatMessageObj value)? system,
    required TResult orElse(),
  }) {
    if (system != null) {
      return system(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SystemChatMessageObjToJson(
      this,
    );
  }
}

abstract class SystemChatMessageObj extends ChatMessageObj {
  const factory SystemChatMessageObj(
      {final String? id,
      @DateConverter() required final DateTime date,
      required final String content}) = _$SystemChatMessageObj;
  const SystemChatMessageObj._() : super._();

  factory SystemChatMessageObj.fromJson(Map<String, dynamic> json) =
      _$SystemChatMessageObj.fromJson;

  @override
  String? get id;
  @override
  @DateConverter()
  DateTime get date;
  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$SystemChatMessageObjCopyWith<_$SystemChatMessageObj> get copyWith =>
      throw _privateConstructorUsedError;
}
