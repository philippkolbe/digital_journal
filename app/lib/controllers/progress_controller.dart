import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/progress.dart';
import 'package:app/repositories/progress_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final progressControllerProvider = StateNotifierProvider<ProgressController, AsyncValue<List<ProgressObj>>>((ref) {
  final progressRepository = ref.watch(progressRepositoryProvider);
  final userId = ref.watch(userIdProvider);
  return ProgressController(progressRepository, userId)..init();
});

class ProgressController extends StateNotifier<AsyncValue<List<ProgressObj>>> {
  final BaseProgressRepository _progressRepository;
  final String? _userId;

  ProgressController(this._progressRepository, this._userId)
      : super(const AsyncLoading());

  Future<void> init() async {
    if (_userId != null) {
      await loadProgressions();
    }
  }

  Future<void> loadProgressions() async {
    try {
      assert(
          _userId != null, "User must be authenticated to load progressions.");

      if (state is! AsyncLoading) {
        state = const AsyncLoading();
      }

      final progressions =
          await _progressRepository.readAllProgressions(_userId!);
      state = AsyncData(progressions);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<ProgressObj?> createProgress(ProgressObj progress) async {
    try {
      assert(state is AsyncData,
          "Progressions must be loaded to create a new progress.");

      final newId =
          await _progressRepository.createProgress(_userId!, progress);
      progress = progress.copyWith(id: newId);

      state = AsyncData(state.value!..insert(0, progress));

      return progress;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return null;
    }
  }

  Future<void> updateProgress(ProgressObj progress) async {
    try {
      assert(state is AsyncData,
          "Progressions must be loaded to update a progress.");

      final newProgress =
          await _progressRepository.updateProgress(_userId!, progress);

      state = AsyncData(state.value!
          .map((entry) => entry.id == progress.id ? newProgress : entry)
          .toList());
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> deleteProgress(String progressId) async {
    try {
      assert(state is AsyncData,
          "Progressions must be loaded to delete a progress.");

      await _progressRepository.deleteProgress(_userId!, progressId);

      state = AsyncData(
          state.value!..removeWhere((progress) => progress.id == progressId));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> setProgressCompletedToday(ProgressObj progress, bool isCompleted) async {
    try {
      if (progress.hasBeenCompletedToday == isCompleted) {
        return;
      }

      assert(state is AsyncData,
          "Progressions must be loaded to abort a challenge.");

      final daysCompletedUpdate = isCompleted 
        ? 1
        : -1;

      final updatedProgress = progress.copyWith(
        hasBeenCompletedToday: isCompleted,
        daysCompleted: progress.daysCompleted + daysCompletedUpdate
      );
      await _progressRepository.updateProgress(_userId!, updatedProgress);

      state = AsyncData(state.value!
          .map((entry) => entry.id == progress.id ? updatedProgress : entry)
          .toList());
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> abortChallenge(ProgressObj progress) async {
    try {
      assert(state is AsyncData,
          "Progressions must be loaded to abort a challenge.");

      final updatedProgress = progress.copyWith(hasBeenAborted: true);
      await _progressRepository.updateProgress(_userId!, updatedProgress);

      state = AsyncData(state.value!
          .map((entry) => entry.id == progress.id ? updatedProgress : entry)
          .toList());
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
