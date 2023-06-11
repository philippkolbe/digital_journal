// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JournalEntryObj _$JournalEntryObjFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'simple':
      return SimpleJournalEntryObj.fromJson(json);
    case 'chat':
      return ChatJournalEntryObj.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'JournalEntryObj',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$JournalEntryObj {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @DateConverter()
  DateTime get date => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? id, String name,
            @DateConverter() DateTime date, String? content)
        simple,
    required TResult Function(String? id, String name,
            @DateConverter() DateTime date, String? goal)
        chat,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? id, String name, @DateConverter() DateTime date,
            String? content)?
        simple,
    TResult? Function(String? id, String name, @DateConverter() DateTime date,
            String? goal)?
        chat,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? id, String name, @DateConverter() DateTime date,
            String? content)?
        simple,
    TResult Function(String? id, String name, @DateConverter() DateTime date,
            String? goal)?
        chat,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimpleJournalEntryObj value) simple,
    required TResult Function(ChatJournalEntryObj value) chat,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimpleJournalEntryObj value)? simple,
    TResult? Function(ChatJournalEntryObj value)? chat,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimpleJournalEntryObj value)? simple,
    TResult Function(ChatJournalEntryObj value)? chat,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JournalEntryObjCopyWith<JournalEntryObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JournalEntryObjCopyWith<$Res> {
  factory $JournalEntryObjCopyWith(
          JournalEntryObj value, $Res Function(JournalEntryObj) then) =
      _$JournalEntryObjCopyWithImpl<$Res, JournalEntryObj>;
  @useResult
  $Res call({String? id, String name, @DateConverter() DateTime date});
}

/// @nodoc
class _$JournalEntryObjCopyWithImpl<$Res, $Val extends JournalEntryObj>
    implements $JournalEntryObjCopyWith<$Res> {
  _$JournalEntryObjCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? date = null,
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
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SimpleJournalEntryObjCopyWith<$Res>
    implements $JournalEntryObjCopyWith<$Res> {
  factory _$$SimpleJournalEntryObjCopyWith(_$SimpleJournalEntryObj value,
          $Res Function(_$SimpleJournalEntryObj) then) =
      __$$SimpleJournalEntryObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String name,
      @DateConverter() DateTime date,
      String? content});
}

/// @nodoc
class __$$SimpleJournalEntryObjCopyWithImpl<$Res>
    extends _$JournalEntryObjCopyWithImpl<$Res, _$SimpleJournalEntryObj>
    implements _$$SimpleJournalEntryObjCopyWith<$Res> {
  __$$SimpleJournalEntryObjCopyWithImpl(_$SimpleJournalEntryObj _value,
      $Res Function(_$SimpleJournalEntryObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? date = null,
    Object? content = freezed,
  }) {
    return _then(_$SimpleJournalEntryObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SimpleJournalEntryObj extends SimpleJournalEntryObj {
  const _$SimpleJournalEntryObj(
      {this.id,
      required this.name,
      @DateConverter() required this.date,
      this.content = "",
      final String? $type})
      : $type = $type ?? 'simple',
        super._();

  factory _$SimpleJournalEntryObj.fromJson(Map<String, dynamic> json) =>
      _$$SimpleJournalEntryObjFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  @DateConverter()
  final DateTime date;
  @override
  @JsonKey()
  final String? content;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'JournalEntryObj.simple(id: $id, name: $name, date: $date, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimpleJournalEntryObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, date, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SimpleJournalEntryObjCopyWith<_$SimpleJournalEntryObj> get copyWith =>
      __$$SimpleJournalEntryObjCopyWithImpl<_$SimpleJournalEntryObj>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? id, String name,
            @DateConverter() DateTime date, String? content)
        simple,
    required TResult Function(String? id, String name,
            @DateConverter() DateTime date, String? goal)
        chat,
  }) {
    return simple(id, name, date, content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? id, String name, @DateConverter() DateTime date,
            String? content)?
        simple,
    TResult? Function(String? id, String name, @DateConverter() DateTime date,
            String? goal)?
        chat,
  }) {
    return simple?.call(id, name, date, content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? id, String name, @DateConverter() DateTime date,
            String? content)?
        simple,
    TResult Function(String? id, String name, @DateConverter() DateTime date,
            String? goal)?
        chat,
    required TResult orElse(),
  }) {
    if (simple != null) {
      return simple(id, name, date, content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimpleJournalEntryObj value) simple,
    required TResult Function(ChatJournalEntryObj value) chat,
  }) {
    return simple(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimpleJournalEntryObj value)? simple,
    TResult? Function(ChatJournalEntryObj value)? chat,
  }) {
    return simple?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimpleJournalEntryObj value)? simple,
    TResult Function(ChatJournalEntryObj value)? chat,
    required TResult orElse(),
  }) {
    if (simple != null) {
      return simple(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SimpleJournalEntryObjToJson(
      this,
    );
  }
}

abstract class SimpleJournalEntryObj extends JournalEntryObj {
  const factory SimpleJournalEntryObj(
      {final String? id,
      required final String name,
      @DateConverter() required final DateTime date,
      final String? content}) = _$SimpleJournalEntryObj;
  const SimpleJournalEntryObj._() : super._();

  factory SimpleJournalEntryObj.fromJson(Map<String, dynamic> json) =
      _$SimpleJournalEntryObj.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  @DateConverter()
  DateTime get date;
  String? get content;
  @override
  @JsonKey(ignore: true)
  _$$SimpleJournalEntryObjCopyWith<_$SimpleJournalEntryObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatJournalEntryObjCopyWith<$Res>
    implements $JournalEntryObjCopyWith<$Res> {
  factory _$$ChatJournalEntryObjCopyWith(_$ChatJournalEntryObj value,
          $Res Function(_$ChatJournalEntryObj) then) =
      __$$ChatJournalEntryObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id, String name, @DateConverter() DateTime date, String? goal});
}

/// @nodoc
class __$$ChatJournalEntryObjCopyWithImpl<$Res>
    extends _$JournalEntryObjCopyWithImpl<$Res, _$ChatJournalEntryObj>
    implements _$$ChatJournalEntryObjCopyWith<$Res> {
  __$$ChatJournalEntryObjCopyWithImpl(
      _$ChatJournalEntryObj _value, $Res Function(_$ChatJournalEntryObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? date = null,
    Object? goal = freezed,
  }) {
    return _then(_$ChatJournalEntryObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      goal: freezed == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatJournalEntryObj extends ChatJournalEntryObj {
  const _$ChatJournalEntryObj(
      {this.id,
      required this.name,
      @DateConverter() required this.date,
      this.goal,
      final String? $type})
      : $type = $type ?? 'chat',
        super._();

  factory _$ChatJournalEntryObj.fromJson(Map<String, dynamic> json) =>
      _$$ChatJournalEntryObjFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  @DateConverter()
  final DateTime date;
  @override
  final String? goal;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'JournalEntryObj.chat(id: $id, name: $name, date: $date, goal: $goal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatJournalEntryObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.goal, goal) || other.goal == goal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, date, goal);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatJournalEntryObjCopyWith<_$ChatJournalEntryObj> get copyWith =>
      __$$ChatJournalEntryObjCopyWithImpl<_$ChatJournalEntryObj>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? id, String name,
            @DateConverter() DateTime date, String? content)
        simple,
    required TResult Function(String? id, String name,
            @DateConverter() DateTime date, String? goal)
        chat,
  }) {
    return chat(id, name, date, goal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? id, String name, @DateConverter() DateTime date,
            String? content)?
        simple,
    TResult? Function(String? id, String name, @DateConverter() DateTime date,
            String? goal)?
        chat,
  }) {
    return chat?.call(id, name, date, goal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? id, String name, @DateConverter() DateTime date,
            String? content)?
        simple,
    TResult Function(String? id, String name, @DateConverter() DateTime date,
            String? goal)?
        chat,
    required TResult orElse(),
  }) {
    if (chat != null) {
      return chat(id, name, date, goal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimpleJournalEntryObj value) simple,
    required TResult Function(ChatJournalEntryObj value) chat,
  }) {
    return chat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimpleJournalEntryObj value)? simple,
    TResult? Function(ChatJournalEntryObj value)? chat,
  }) {
    return chat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimpleJournalEntryObj value)? simple,
    TResult Function(ChatJournalEntryObj value)? chat,
    required TResult orElse(),
  }) {
    if (chat != null) {
      return chat(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatJournalEntryObjToJson(
      this,
    );
  }
}

abstract class ChatJournalEntryObj extends JournalEntryObj {
  const factory ChatJournalEntryObj(
      {final String? id,
      required final String name,
      @DateConverter() required final DateTime date,
      final String? goal}) = _$ChatJournalEntryObj;
  const ChatJournalEntryObj._() : super._();

  factory ChatJournalEntryObj.fromJson(Map<String, dynamic> json) =
      _$ChatJournalEntryObj.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  @DateConverter()
  DateTime get date;
  String? get goal;
  @override
  @JsonKey(ignore: true)
  _$$ChatJournalEntryObjCopyWith<_$ChatJournalEntryObj> get copyWith =>
      throw _privateConstructorUsedError;
}
