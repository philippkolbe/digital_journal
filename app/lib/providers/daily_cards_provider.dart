import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/personality_controller.dart';
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

  final dailyCardRepository = ref.read(dailyCardRepositoryProvider);

  var allCards = await dailyCardRepository.readDailyCardsByDate(userId, day);

  final todaysPersonality = ref.watch(personalityByDayProviderFamily(day));
  if (allCards.isEmpty && todaysPersonality.valueOrNull != null) {
    allCards = await Future.wait([
      dailyCardRepository.createDailyCard(
          userId,
          PersonalityPromptDailyCardObj(
              date: day, personalityId: todaysPersonality.valueOrNull!.id!)),
      dailyCardRepository.createDailyCard(
          userId,
          MoodCheckDailyCardObj(
            date: day,
          )),
    ]);
  }

  return allCards;
});
