import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

class DurationConverter implements JsonConverter<Duration, int> {
  const DurationConverter();

  @override
  Duration fromJson(int durationInMs) {
    return Duration(milliseconds: durationInMs);
  }

  @override
  int toJson(Duration duration) {
    return duration.inMilliseconds;
  }
}