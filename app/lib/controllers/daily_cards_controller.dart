import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/daily_card.dart';
import 'package:app/repositories/daily_card_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dailyCardsControllerProvider = Provider<DailyCardController>((ref) {
  final dailyCardRepository = ref.read(dailyCardRepositoryProvider);
  final userId = ref.watch(userIdProvider);

  return DailyCardController(
    dailyCardRepository,
    userId,
  );
});

class DailyCardController {
  final BaseDailyCardRepository _dailyCardRepository;
  final String? _userId;

  DailyCardController(
    this._dailyCardRepository,
    this._userId,
  );

  Future<DailyCardObj> addDailyCard(DailyCardObj dailyCardObj) async {
    return _dailyCardRepository.createDailyCard(_userId!, dailyCardObj);
  }

  Future<void> deleteDailyCard(String entryId) async {
    return _dailyCardRepository.deleteDailyCard(_userId!, entryId);
  }

  Future<DailyCardObj> updateDailyCard(DailyCardObj dailyCardObjUpdate) async {
    return _dailyCardRepository.updateDailyCard(_userId!, dailyCardObjUpdate);
  }
}
