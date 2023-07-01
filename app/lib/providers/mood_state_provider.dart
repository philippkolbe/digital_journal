import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Mood {
  great,
  good,
  ok,
  bad,
  terrible,
}

final moodStateProvider = StateProvider<Mood?>((ref) => null);