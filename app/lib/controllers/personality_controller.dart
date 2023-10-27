import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/models/personality.dart';
import 'package:app/repositories/personality_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final StateProvider<PersonalityObj?> selectedPersonalityProvider = StateProvider<PersonalityObj?>((ref) => null);

final personalitiesProvider = StateNotifierProvider<PersonalityController, AsyncValue<List<PersonalityObj>>>((ref) {
  final personalityRepository = ref.read(personalityRepositoryProvider);
  final userId = ref.watch(userIdProvider);
  final selectedPersonalityController = ref.watch(selectedPersonalityProvider.notifier);

  final controller = PersonalityController(
    personalityRepository,
    userId,
    selectedPersonalityController,
    ref.read,
  )..init();

  ref.listen(selectedJournalEntryProvider, (asyncPrevJournalEntry, asyncJournalEntry) {
    ChatJournalEntryObj? lastChatJournalEntry;
    final journalEntry = asyncJournalEntry.valueOrNull;
    if (journalEntry != null) {
      if (journalEntry is ChatJournalEntryObj) {
        lastChatJournalEntry = journalEntry;
      }
    } else {
      final prevJournalEntry = asyncPrevJournalEntry?.valueOrNull;
      if (prevJournalEntry is ChatJournalEntryObj) {
        lastChatJournalEntry = prevJournalEntry;
      }
    }
    
    final id = lastChatJournalEntry?.personalityId;
    if (id != null) {
      ref.read(selectedPersonalityProvider.notifier).state = controller.getPersonalityFromId(id);
    }
  });

  return controller;
});

class PersonalityController extends StateNotifier<AsyncValue<List<PersonalityObj>>> {
  final BasePersonalityRepository _personalityRepository;
  final String? _userId;
  final StateController<PersonalityObj?> _selectedPersonalityController;
  final T Function<T>(ProviderListenable<T> provider) _read;

  PersonalityController(
    this._personalityRepository,
    this._userId,
    this._selectedPersonalityController,
    this._read,
  ) : super(const AsyncLoading());

  Future<void> init() async {
    if (_userId != null) {
      await loadPersonalities();
    }
  }

  Future<void> loadPersonalities() async {
    try {
      assert(_userId != null, "User must be authenticated to load its (custom) personalities.");

      if (state is! AsyncLoading) {
        state = const AsyncLoading();
      }

      final personalities = await _personalityRepository.readAllPersonalities(userId: _userId!);
      state = AsyncData(personalities);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<PersonalityObj> addPersonality(PersonalityObj personalityObj) async {
    // TODO: Error handling...
    assert(state is AsyncData, "Personalities must be loaded to add new custom personalities.");

    personalityObj = await _personalityRepository.createPersonality(personalityObj, userId: _userId!);

    state = AsyncData(state.value!..insert(0, personalityObj));

    return personalityObj;
  }

  Future<void> deletePersonality(String entryId) async {
    try {
      assert(state is AsyncData, "Personalities must be loaded to delete custom personalities.");

      await _personalityRepository.deletePersonality(entryId, userId: _userId!);

      state = AsyncData(state.value!..removeWhere((entry) => entry.id == entryId));

      if (entryId == _getSelectedPersonalityId()) {
        _selectedPersonalityController.state = null;
      }
    } catch (error, stackTrace) {
      // TODO: Handle error by showing it in popup instead of this state
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> updatePersonality(PersonalityObj personalityObjUpdate) async {
    try {
      assert(state is AsyncData, "Personalities must be loaded to update custom personalities.");
      assert(personalityObjUpdate.id != null, "Personality must have an id to update it.");

      final newPersonalityObj = await _personalityRepository.updatePersonality(personalityObjUpdate, userId: _userId!);

      state = AsyncData(state.value!.map((entry) => entry.id == personalityObjUpdate.id
        ? newPersonalityObj
        : entry).toList());

      if (personalityObjUpdate.id == _getSelectedPersonalityId()) {
        _selectedPersonalityController.state = newPersonalityObj;
      }
    } catch (error, stackTrace) {
      // TODO: Handle error by showing it in popup instead of this state
      state = AsyncError(error, stackTrace);
    }
  }

  String? _getSelectedPersonalityId() {
    return _read(selectedPersonalityProvider.notifier).state?.id;
  }

  PersonalityObj? getPersonalityFromId(String id) {
    return state.valueOrNull?.firstWhereOrNull((personality) => personality.id == id);
  }
}