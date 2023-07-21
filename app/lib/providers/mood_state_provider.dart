import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Mood {
  great,
  good,
  ok,
  bad,
  terrible,
}

final moodStateProvider = StateProvider<Mood?>((ref) => null);

String moodToString(Mood? mood) {
  switch (mood) {
    case Mood.great:
      return 'great';
    case Mood.good:
      return 'good';
    case Mood.ok:
      return 'okay';
    case Mood.bad:
      return 'bad';
    case Mood.terrible:
      return 'terrible';
    default:
      return 'Unknown';
  }
}