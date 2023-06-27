import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentDayStream = _createCurrentDayStream();

final currentDayProvider = StreamProvider<DateTime>((ref) => _createCurrentDayStream());

Stream<DateTime> _createCurrentDayStream() {
  final controller = StreamController<DateTime>();
  
  // Emit current day
  _addNewDay(controller);

  // Calculate the time until the next midnight
  final now = DateTime.now();
  final nextMidnight = DateTime(now.year, now.month, now.day + 1);
  final timeUntilMidnight = nextMidnight.difference(now);

  Timer(timeUntilMidnight, () {
    // Update the current day at midnight
    _addNewDay(controller);

    // Set up the recurring timer for the next day
    Timer.periodic(const Duration(days: 1), (_) => _addNewDay(controller));
  });

  return controller.stream;
}

void _addNewDay(StreamController controller) {
  final now = DateTime.now();
  final currentDay = DateTime(now.year, now.month, now.day);
  controller.add(currentDay);
}
