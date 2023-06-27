import 'package:app/common/utils.dart';
import 'package:app/controllers/progress_controller.dart';
import 'package:app/models/progress.dart';
import 'package:app/providers/current_day_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activeProgressProvider = Provider((ref) {
  final asyncProgression = ref.watch(progressControllerProvider);
  final asyncCurrentDay = ref.watch(currentDayProvider);

  return combineAsync2(asyncCurrentDay, asyncProgression).whenData(
    (data) {
      final currentDay = data.item1;
      final progression = data.item2;
      
      return progression.where(
        (progressEntryObj) => isProgressActive(progressEntryObj, currentDay),
      ).toList();
    },
  );
});


bool isProgressActive(ProgressObj progressObj, DateTime today) {
  final startDate = progressObj.startDate;
  final durationInDays = progressObj.durationInDays;
  final endDate = startDate.add(Duration(days: durationInDays));
  final isInTimeframe = (startDate.isAtSameMomentAs(today) || startDate.isBefore(today))
    && today.isBefore(endDate);
  return isInTimeframe && !progressObj.hasBeenAborted;
}