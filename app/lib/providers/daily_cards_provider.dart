import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/daily_card.dart';
import 'package:app/providers/current_day_provider.dart';
import 'package:app/repositories/daily_card_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dailyCardsProviderFamily =
    FutureProviderFamily<List<DailyCardObj>, DateTime>((ref, date) async {
  final day = DateTime(date.day, date.month, date.year);
  final today = ref.watch(currentDayProvider).valueOrNull;
  final userId = ref.watch(userIdProvider);
  if (today == null || userId == null) {
    return [];
  }

  if (day.isAfter(today)) {
    return const [FutureDailyCardObj()];
  }

  return await ref
      .read(dailyCardRepositoryProvider)
      .readDailyCardsByDate(userId, day);
});
