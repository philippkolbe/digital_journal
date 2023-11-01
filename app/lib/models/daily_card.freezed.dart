// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DailyCardObj _$DailyCardObjFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'personalityPrompt':
      return PersonalityPromptDailyCardObj.fromJson(json);
    case 'moodCheck':
      return MoodCheckDailyCardObj.fromJson(json);
    case 'futureCard':
      return FutureDailyCardObj.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'DailyCardObj',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$DailyCardObj {
  String? get id => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id,
            int? order,
            @DateConverter() DateTime date,
            String personalityId,
            String? prompt)
        personalityPrompt,
    required TResult Function(
            String? id, int? order, @DateConverter() DateTime date, Mood? mood)
        moodCheck,
    required TResult Function(String? id) futureCard,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? id, int? order, @DateConverter() DateTime date,
            String personalityId, String? prompt)?
        personalityPrompt,
    TResult? Function(
            String? id, int? order, @DateConverter() DateTime date, Mood? mood)?
        moodCheck,
    TResult? Function(String? id)? futureCard,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? id, int? order, @DateConverter() DateTime date,
            String personalityId, String? prompt)?
        personalityPrompt,
    TResult Function(
            String? id, int? order, @DateConverter() DateTime date, Mood? mood)?
        moodCheck,
    TResult Function(String? id)? futureCard,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PersonalityPromptDailyCardObj value)
        personalityPrompt,
    required TResult Function(MoodCheckDailyCardObj value) moodCheck,
    required TResult Function(FutureDailyCardObj value) futureCard,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PersonalityPromptDailyCardObj value)? personalityPrompt,
    TResult? Function(MoodCheckDailyCardObj value)? moodCheck,
    TResult? Function(FutureDailyCardObj value)? futureCard,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PersonalityPromptDailyCardObj value)? personalityPrompt,
    TResult Function(MoodCheckDailyCardObj value)? moodCheck,
    TResult Function(FutureDailyCardObj value)? futureCard,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyCardObjCopyWith<DailyCardObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyCardObjCopyWith<$Res> {
  factory $DailyCardObjCopyWith(
          DailyCardObj value, $Res Function(DailyCardObj) then) =
      _$DailyCardObjCopyWithImpl<$Res, DailyCardObj>;
  @useResult
  $Res call({String? id});
}

/// @nodoc
class _$DailyCardObjCopyWithImpl<$Res, $Val extends DailyCardObj>
    implements $DailyCardObjCopyWith<$Res> {
  _$DailyCardObjCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PersonalityPromptDailyCardObjCopyWith<$Res>
    implements $DailyCardObjCopyWith<$Res> {
  factory _$$PersonalityPromptDailyCardObjCopyWith(
          _$PersonalityPromptDailyCardObj value,
          $Res Function(_$PersonalityPromptDailyCardObj) then) =
      __$$PersonalityPromptDailyCardObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      int? order,
      @DateConverter() DateTime date,
      String personalityId,
      String? prompt});
}

/// @nodoc
class __$$PersonalityPromptDailyCardObjCopyWithImpl<$Res>
    extends _$DailyCardObjCopyWithImpl<$Res, _$PersonalityPromptDailyCardObj>
    implements _$$PersonalityPromptDailyCardObjCopyWith<$Res> {
  __$$PersonalityPromptDailyCardObjCopyWithImpl(
      _$PersonalityPromptDailyCardObj _value,
      $Res Function(_$PersonalityPromptDailyCardObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? order = freezed,
    Object? date = null,
    Object? personalityId = null,
    Object? prompt = freezed,
  }) {
    return _then(_$PersonalityPromptDailyCardObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      personalityId: null == personalityId
          ? _value.personalityId
          : personalityId // ignore: cast_nullable_to_non_nullable
              as String,
      prompt: freezed == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonalityPromptDailyCardObj extends PersonalityPromptDailyCardObj {
  const _$PersonalityPromptDailyCardObj(
      {this.id,
      this.order,
      @DateConverter() required this.date,
      required this.personalityId,
      this.prompt,
      final String? $type})
      : $type = $type ?? 'personalityPrompt',
        super._();

  factory _$PersonalityPromptDailyCardObj.fromJson(Map<String, dynamic> json) =>
      _$$PersonalityPromptDailyCardObjFromJson(json);

  @override
  final String? id;
  @override
  final int? order;
  @override
  @DateConverter()
  final DateTime date;
  @override
  final String personalityId;
  @override
  final String? prompt;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DailyCardObj.personalityPrompt(id: $id, order: $order, date: $date, personalityId: $personalityId, prompt: $prompt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalityPromptDailyCardObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.personalityId, personalityId) ||
                other.personalityId == personalityId) &&
            (identical(other.prompt, prompt) || other.prompt == prompt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, order, date, personalityId, prompt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalityPromptDailyCardObjCopyWith<_$PersonalityPromptDailyCardObj>
      get copyWith => __$$PersonalityPromptDailyCardObjCopyWithImpl<
          _$PersonalityPromptDailyCardObj>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id,
            int? order,
            @DateConverter() DateTime date,
            String personalityId,
            String? prompt)
        personalityPrompt,
    required TResult Function(
            String? id, int? order, @DateConverter() DateTime date, Mood? mood)
        moodCheck,
    required TResult Function(String? id) futureCard,
  }) {
    return personalityPrompt(id, order, date, personalityId, prompt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? id, int? order, @DateConverter() DateTime date,
            String personalityId, String? prompt)?
        personalityPrompt,
    TResult? Function(
            String? id, int? order, @DateConverter() DateTime date, Mood? mood)?
        moodCheck,
    TResult? Function(String? id)? futureCard,
  }) {
    return personalityPrompt?.call(id, order, date, personalityId, prompt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? id, int? order, @DateConverter() DateTime date,
            String personalityId, String? prompt)?
        personalityPrompt,
    TResult Function(
            String? id, int? order, @DateConverter() DateTime date, Mood? mood)?
        moodCheck,
    TResult Function(String? id)? futureCard,
    required TResult orElse(),
  }) {
    if (personalityPrompt != null) {
      return personalityPrompt(id, order, date, personalityId, prompt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PersonalityPromptDailyCardObj value)
        personalityPrompt,
    required TResult Function(MoodCheckDailyCardObj value) moodCheck,
    required TResult Function(FutureDailyCardObj value) futureCard,
  }) {
    return personalityPrompt(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PersonalityPromptDailyCardObj value)? personalityPrompt,
    TResult? Function(MoodCheckDailyCardObj value)? moodCheck,
    TResult? Function(FutureDailyCardObj value)? futureCard,
  }) {
    return personalityPrompt?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PersonalityPromptDailyCardObj value)? personalityPrompt,
    TResult Function(MoodCheckDailyCardObj value)? moodCheck,
    TResult Function(FutureDailyCardObj value)? futureCard,
    required TResult orElse(),
  }) {
    if (personalityPrompt != null) {
      return personalityPrompt(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PersonalityPromptDailyCardObjToJson(
      this,
    );
  }
}

abstract class PersonalityPromptDailyCardObj extends DailyCardObj {
  const factory PersonalityPromptDailyCardObj(
      {final String? id,
      final int? order,
      @DateConverter() required final DateTime date,
      required final String personalityId,
      final String? prompt}) = _$PersonalityPromptDailyCardObj;
  const PersonalityPromptDailyCardObj._() : super._();

  factory PersonalityPromptDailyCardObj.fromJson(Map<String, dynamic> json) =
      _$PersonalityPromptDailyCardObj.fromJson;

  @override
  String? get id;
  int? get order;
  @DateConverter()
  DateTime get date;
  String get personalityId;
  String? get prompt;
  @override
  @JsonKey(ignore: true)
  _$$PersonalityPromptDailyCardObjCopyWith<_$PersonalityPromptDailyCardObj>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MoodCheckDailyCardObjCopyWith<$Res>
    implements $DailyCardObjCopyWith<$Res> {
  factory _$$MoodCheckDailyCardObjCopyWith(_$MoodCheckDailyCardObj value,
          $Res Function(_$MoodCheckDailyCardObj) then) =
      __$$MoodCheckDailyCardObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id, int? order, @DateConverter() DateTime date, Mood? mood});
}

/// @nodoc
class __$$MoodCheckDailyCardObjCopyWithImpl<$Res>
    extends _$DailyCardObjCopyWithImpl<$Res, _$MoodCheckDailyCardObj>
    implements _$$MoodCheckDailyCardObjCopyWith<$Res> {
  __$$MoodCheckDailyCardObjCopyWithImpl(_$MoodCheckDailyCardObj _value,
      $Res Function(_$MoodCheckDailyCardObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? order = freezed,
    Object? date = null,
    Object? mood = freezed,
  }) {
    return _then(_$MoodCheckDailyCardObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mood: freezed == mood
          ? _value.mood
          : mood // ignore: cast_nullable_to_non_nullable
              as Mood?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoodCheckDailyCardObj extends MoodCheckDailyCardObj {
  const _$MoodCheckDailyCardObj(
      {this.id,
      this.order,
      @DateConverter() required this.date,
      this.mood,
      final String? $type})
      : $type = $type ?? 'moodCheck',
        super._();

  factory _$MoodCheckDailyCardObj.fromJson(Map<String, dynamic> json) =>
      _$$MoodCheckDailyCardObjFromJson(json);

  @override
  final String? id;
  @override
  final int? order;
  @override
  @DateConverter()
  final DateTime date;
  @override
  final Mood? mood;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DailyCardObj.moodCheck(id: $id, order: $order, date: $date, mood: $mood)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoodCheckDailyCardObj &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.mood, mood) || other.mood == mood));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, order, date, mood);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoodCheckDailyCardObjCopyWith<_$MoodCheckDailyCardObj> get copyWith =>
      __$$MoodCheckDailyCardObjCopyWithImpl<_$MoodCheckDailyCardObj>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id,
            int? order,
            @DateConverter() DateTime date,
            String personalityId,
            String? prompt)
        personalityPrompt,
    required TResult Function(
            String? id, int? order, @DateConverter() DateTime date, Mood? mood)
        moodCheck,
    required TResult Function(String? id) futureCard,
  }) {
    return moodCheck(id, order, date, mood);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? id, int? order, @DateConverter() DateTime date,
            String personalityId, String? prompt)?
        personalityPrompt,
    TResult? Function(
            String? id, int? order, @DateConverter() DateTime date, Mood? mood)?
        moodCheck,
    TResult? Function(String? id)? futureCard,
  }) {
    return moodCheck?.call(id, order, date, mood);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? id, int? order, @DateConverter() DateTime date,
            String personalityId, String? prompt)?
        personalityPrompt,
    TResult Function(
            String? id, int? order, @DateConverter() DateTime date, Mood? mood)?
        moodCheck,
    TResult Function(String? id)? futureCard,
    required TResult orElse(),
  }) {
    if (moodCheck != null) {
      return moodCheck(id, order, date, mood);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PersonalityPromptDailyCardObj value)
        personalityPrompt,
    required TResult Function(MoodCheckDailyCardObj value) moodCheck,
    required TResult Function(FutureDailyCardObj value) futureCard,
  }) {
    return moodCheck(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PersonalityPromptDailyCardObj value)? personalityPrompt,
    TResult? Function(MoodCheckDailyCardObj value)? moodCheck,
    TResult? Function(FutureDailyCardObj value)? futureCard,
  }) {
    return moodCheck?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PersonalityPromptDailyCardObj value)? personalityPrompt,
    TResult Function(MoodCheckDailyCardObj value)? moodCheck,
    TResult Function(FutureDailyCardObj value)? futureCard,
    required TResult orElse(),
  }) {
    if (moodCheck != null) {
      return moodCheck(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MoodCheckDailyCardObjToJson(
      this,
    );
  }
}

abstract class MoodCheckDailyCardObj extends DailyCardObj {
  const factory MoodCheckDailyCardObj(
      {final String? id,
      final int? order,
      @DateConverter() required final DateTime date,
      final Mood? mood}) = _$MoodCheckDailyCardObj;
  const MoodCheckDailyCardObj._() : super._();

  factory MoodCheckDailyCardObj.fromJson(Map<String, dynamic> json) =
      _$MoodCheckDailyCardObj.fromJson;

  @override
  String? get id;
  int? get order;
  @DateConverter()
  DateTime get date;
  Mood? get mood;
  @override
  @JsonKey(ignore: true)
  _$$MoodCheckDailyCardObjCopyWith<_$MoodCheckDailyCardObj> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FutureDailyCardObjCopyWith<$Res>
    implements $DailyCardObjCopyWith<$Res> {
  factory _$$FutureDailyCardObjCopyWith(_$FutureDailyCardObj value,
          $Res Function(_$FutureDailyCardObj) then) =
      __$$FutureDailyCardObjCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id});
}

/// @nodoc
class __$$FutureDailyCardObjCopyWithImpl<$Res>
    extends _$DailyCardObjCopyWithImpl<$Res, _$FutureDailyCardObj>
    implements _$$FutureDailyCardObjCopyWith<$Res> {
  __$$FutureDailyCardObjCopyWithImpl(
      _$FutureDailyCardObj _value, $Res Function(_$FutureDailyCardObj) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_$FutureDailyCardObj(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FutureDailyCardObj extends FutureDailyCardObj {
  const _$FutureDailyCardObj({this.id, final String? $type})
      : $type = $type ?? 'futureCard',
        super._();

  factory _$FutureDailyCardObj.fromJson(Map<String, dynamic> json) =>
      _$$FutureDailyCardObjFromJson(json);

  @override
  final String? id;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DailyCardObj.futureCard(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FutureDailyCardObj &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FutureDailyCardObjCopyWith<_$FutureDailyCardObj> get copyWith =>
      __$$FutureDailyCardObjCopyWithImpl<_$FutureDailyCardObj>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? id,
            int? order,
            @DateConverter() DateTime date,
            String personalityId,
            String? prompt)
        personalityPrompt,
    required TResult Function(
            String? id, int? order, @DateConverter() DateTime date, Mood? mood)
        moodCheck,
    required TResult Function(String? id) futureCard,
  }) {
    return futureCard(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? id, int? order, @DateConverter() DateTime date,
            String personalityId, String? prompt)?
        personalityPrompt,
    TResult? Function(
            String? id, int? order, @DateConverter() DateTime date, Mood? mood)?
        moodCheck,
    TResult? Function(String? id)? futureCard,
  }) {
    return futureCard?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? id, int? order, @DateConverter() DateTime date,
            String personalityId, String? prompt)?
        personalityPrompt,
    TResult Function(
            String? id, int? order, @DateConverter() DateTime date, Mood? mood)?
        moodCheck,
    TResult Function(String? id)? futureCard,
    required TResult orElse(),
  }) {
    if (futureCard != null) {
      return futureCard(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PersonalityPromptDailyCardObj value)
        personalityPrompt,
    required TResult Function(MoodCheckDailyCardObj value) moodCheck,
    required TResult Function(FutureDailyCardObj value) futureCard,
  }) {
    return futureCard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PersonalityPromptDailyCardObj value)? personalityPrompt,
    TResult? Function(MoodCheckDailyCardObj value)? moodCheck,
    TResult? Function(FutureDailyCardObj value)? futureCard,
  }) {
    return futureCard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PersonalityPromptDailyCardObj value)? personalityPrompt,
    TResult Function(MoodCheckDailyCardObj value)? moodCheck,
    TResult Function(FutureDailyCardObj value)? futureCard,
    required TResult orElse(),
  }) {
    if (futureCard != null) {
      return futureCard(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FutureDailyCardObjToJson(
      this,
    );
  }
}

abstract class FutureDailyCardObj extends DailyCardObj {
  const factory FutureDailyCardObj({final String? id}) = _$FutureDailyCardObj;
  const FutureDailyCardObj._() : super._();

  factory FutureDailyCardObj.fromJson(Map<String, dynamic> json) =
      _$FutureDailyCardObj.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$FutureDailyCardObjCopyWith<_$FutureDailyCardObj> get copyWith =>
      throw _privateConstructorUsedError;
}
