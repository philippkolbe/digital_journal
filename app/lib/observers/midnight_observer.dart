import 'dart:async';

import 'package:app/controllers/progress_controller.dart';
import 'package:app/models/progress.dart';
import 'package:app/providers/active_progress_provider.dart';
import 'package:app/providers/current_day_provider.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:app/repositories/progress_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void initializeMidnightObserver(WidgetRef ref) {
  final authStream = ref.read(authRepositoryProvider).authStateChangesStream;

  StreamSubscription? sub;
  authStream.listen((newUser) async { // Add async to allow use of await


  while (newUser == null) {
    await Future.delayed(Duration.zero);
  }

  if (newUser != null) {
    sub?.cancel();
    sub = currentDayStream.listen((DateTime currentDay) async {
        final progressRepository = ref.read(progressRepositoryProvider);      

        List<ProgressObj> allProgressObjs = await progressRepository.readAllProgressions(newUser.uid);

        final List<ProgressObj> newProgressObjs = [];
        for (var progressObj in allProgressObjs) {
          if (isProgressActive(progressObj, currentDay)) {
            final daysSinceStart = currentDay.difference(progressObj.startDate).inDays;
            final hasBeenCompleted = progressObj.hasBeenCompletedToday;
            final daysCompleted = progressObj.daysCompleted;

            final isNewDay = daysSinceStart > daysCompleted
              || (daysCompleted == daysSinceStart && hasBeenCompleted);

            if (isNewDay) {
              newProgressObjs.add(progressObj.copyWith(
                daysCompleted: daysSinceStart,
                hasBeenCompletedToday: false,
                streak: isNewDay && !hasBeenCompleted ? 0 : progressObj.streak,
              ));
            }
          }
        }


        await Future.wait(newProgressObjs.map(
          (updatedProgressObj) => progressRepository.updateProgress(
            newUser.uid,
            updatedProgressObj,
          ),
        ));

        final controller = ref.read(progressControllerProvider.notifier);
        // TODO: This throws on start because user is not loaded
        await controller.loadProgressions();
      });
    }
  });
}