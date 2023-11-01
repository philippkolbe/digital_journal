import 'package:freezed_annotation/freezed_annotation.dart';

enum Mood {
  @JsonValue(5)
  great,
  @JsonValue(4)
  good,
  @JsonValue(3)
  ok,
  @JsonValue(2)
  bad,
  @JsonValue(1)
  terrible,
}
