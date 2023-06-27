import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/progress_controller.dart';
import 'package:app/models/progress.dart';
import 'package:app/models/progress_entry.dart';
import 'package:app/providers/active_progress_provider.dart';
import 'package:app/providers/current_day_provider.dart';
import 'package:app/repositories/progress_entry_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _previousCurrentDayProvider = StateProvider<DateTime?>((ref) => null);
final _previousActiveProgressionProvider = StateProvider<List<ProgressObj>?>((ref) => null);
final _previousTodaysProgressProvider = StateProvider<AsyncValue<TodaysProgressState>?>((ref) => null);

final todaysProgressControllerProvider = StateNotifierProvider<
  TodaysProgressController,
  AsyncValue<TodaysProgressState>
>((ref) {
  final authState = ref.watch(authControllerProvider);
  final asyncActiveProgression = ref.watch(activeProgressProvider);
  final asyncCurrentDay = ref.watch(currentDayProvider);

  return TodaysProgressController(
    authState.valueOrNull?.currentUser.id,
    asyncCurrentDay.valueOrNull,
    asyncActiveProgression.valueOrNull,
    ref,
  )..init();
});

typedef TodaysProgressState = Map<
  ProgressObj,
  AsyncValue<ProgressEntryObj?>
>;

class TodaysProgressController extends StateNotifier<AsyncValue<TodaysProgressState>> {
  final String? _userId;
  final DateTime? _currentDay;
  final List<ProgressObj>? _activeProgression;

  final BaseProgressEntryRepository _progressRepository;
  final ProgressController _progressController;
  
  final Ref _ref;

  TodaysProgressController(
    this._userId,
    this._currentDay,
    this._activeProgression,
    this._ref,
  ) :
    _progressRepository = _ref.read(progressEntryRepositoryProvider),
    _progressController = _ref.read(progressControllerProvider.notifier),
    super(const AsyncLoading());

  Future<void> init() async {
    if (_userId != null && _activeProgression != null) {
      final previousTodaysProgress = _ref.read(_previousTodaysProgressProvider)?.valueOrNull;
      if (
        previousTodaysProgress == null ||
        _wasPreviousStateFaulty(previousTodaysProgress) ||
        _isNewDay() ||
        _hasRelevantProgressionUpdates()
      ) {
        await loadTodaysProgressEntries();
      } else {
        try {
          _loadStateFromPreviousState(
            previousTodaysProgress,
            _activeProgression!,
          );
        } catch (err) {
          // TODO: Message Toast the error
          await loadTodaysProgressEntries();
        }
      }
    }
  }

  Future<void> loadTodaysProgressEntries() async {
    try {
      assert(_userId != null, 'User has to be authenticated to load todays progress entries');
      assert(_currentDay != null, 'Current day has to be loaded to load todays progress entries');
      assert(_activeProgression != null, 'Progressions have to be loaded to load todays progress entries');
      state = const AsyncLoading();

      final currentDay = _currentDay!;
      final progressEntries = <ProgressObj, AsyncValue<ProgressEntryObj?>>{};

      await Future.wait(
        _activeProgression!.map(_loadSingleProgressEntry(progressEntries, currentDay)),
      );

      state = AsyncData(progressEntries);
    } catch (err, st) {
      state = AsyncError(err, st);
    }
  }

  _loadSingleProgressEntry(Map<ProgressObj, AsyncValue<ProgressEntryObj?>> map, DateTime currentDay) {
    return (ProgressObj progressObj) async {
      try {
        final todaysProgressEntries = await _progressRepository.readProgressEntriesOfDate(
          _userId!,
          progressObj.id!,
          currentDay,
        );
        
        assert(todaysProgressEntries.length <= 1, 'Should not have more than one progress entry per day per progress.');

        final progressEntryAsyncValue = AsyncData(todaysProgressEntries.firstOrNull);
        map[progressObj] = progressEntryAsyncValue;
      } catch (error, stackTrace) {
        map[progressObj] = AsyncError(error, stackTrace);
      }
    };
  }

  Future<void> toggleChallengeCompletion(ProgressObj progressObj) async {
    final previousStateNotifier = _ref.read(_previousTodaysProgressProvider.notifier);

    try {
      assert(state is! AsyncLoading, 'ProgressObjs must be loaded before completing them.');
      assert(state is! AsyncError, 'Tried toggling after error occured: ${state.error}');

      try {
        state = AsyncData(await _toggleChallengeCompletion(progressObj));
        previousStateNotifier.state = state;
      } catch (err, st) {
        state = AsyncData(state.value!.map((key, value) {
          return MapEntry(key, key == progressObj ? AsyncError(err, st) : value);
        }));
        previousStateNotifier.state = state;
      }
    } catch (err, st) {
      state = AsyncError(err, st);
      previousStateNotifier.state = state;
    }

    _ref.read(_previousCurrentDayProvider.notifier).state = _currentDay;
    _ref.read(_previousActiveProgressionProvider.notifier).state = _activeProgression;
  }

  Future<TodaysProgressState> _toggleChallengeCompletion(ProgressObj progressObj) async {
    // This means we assume that all instance variables are not null. 
    assert(state is AsyncData, 'State must be Data to track progress.');
    assert(progressObj.id != null, 'Must have an id to track its progress.');

    final progressEntry = state.value![progressObj]?.valueOrNull;

    if (progressEntry != null) {
      // Update progress entry: toggle 'isCompleted'
      final newIsCompleted = !progressEntry.isCompleted;

      final updatedProgressEntry = progressEntry.copyWith(isCompleted: newIsCompleted);
      await _progressRepository.updateProgressEntry(_userId!, progressObj.id!, updatedProgressEntry);
      
      _progressController.setProgressCompletedToday(progressObj, newIsCompleted);
      
      return state.value!.map((key, value) => MapEntry(
        key, key == progressObj
          ? AsyncData(updatedProgressEntry)
          : value
        )
      );
    } else {
      // Create new progress entry
      final newProgressEntry = ProgressEntryObj(
        trackingDate: _currentDay!,
        isCompleted: true,
      );
      final createdProgressEntryId = await _progressRepository.createProgressEntry(
        _userId!,
        progressObj.id!,
        newProgressEntry,
      );

      _progressController.setProgressCompletedToday(progressObj, true);
      
      return state.value!.map((key, value) => MapEntry(
        key, key == progressObj
          ? AsyncData(newProgressEntry.copyWith(id: createdProgressEntryId))
          : value
        ));
    }
  }

  bool _wasPreviousStateFaulty(TodaysProgressState previous) {
    return previous
      .entries
      .any((asyncEntry) => asyncEntry.value is! AsyncData);
  }

  bool _isNewDay() {
    final previousCurrentDay = _ref.read(_previousCurrentDayProvider);
    if (previousCurrentDay != _currentDay) {
      return true;
    }

    return false;
  }

  bool _hasRelevantProgressionUpdates() {
    final previousActiveProgression = _ref.read(_previousActiveProgressionProvider);

    if (previousActiveProgression == null || _activeProgression == null) {
      return true;
    }

    // If its shorter it means that stuff was deleted so we can just take the
    // others over to the new state and we don't need to reload
    if (_activeProgression!.length > previousActiveProgression.length) {
      return true;
    }

    if (_activeProgression!.any(
      (current) => previousActiveProgression.every(
        (prev) => prev.id != current.id
      )
    )) {
      return true;
    }

    return false;
  }

  void _loadStateFromPreviousState(
    TodaysProgressState previousState,
    List<ProgressObj> current,
  ) {
    final previousActiveProgression = _ref.read(_previousActiveProgressionProvider)!;

    final Map<ProgressObj, AsyncValue<ProgressEntryObj?>> newState = {};

    for (var i = 0; i < current.length; i++) {
      final currentObj = current[i];
      final previousObj = previousActiveProgression.firstWhere(
        (prevObj) => prevObj.id == currentObj.id,
      );

      final newEntryObj = previousState[previousObj];
      assert(newEntryObj != null, "Could not find entry object in previous state");
      newState[currentObj] = AsyncData(newEntryObj!.value);
    }

    state = AsyncData(newState);
  }
}
