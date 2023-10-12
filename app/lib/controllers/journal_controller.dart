import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/repositories/chat_history_repository.dart';
import 'package:app/repositories/journal_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedJournalEntryIdProvider = Provider<String?>(
  (ref) => ref.watch(selectedJournalEntryProvider).valueOrNull?.id
);

final selectedJournalEntryProvider = StateProvider<AsyncValue<JournalEntryObj?>>((ref) => const AsyncData(null));

final journalEntriesProvider = StateNotifierProvider<JournalController, AsyncValue<List<JournalEntryObj>>>((ref) {
  final journalRepository = ref.read(journalRepositoryProvider);
  final chatHistoryRepository = ref.read(chatHistoryRepositoryProvider);
  final userId = ref.watch(userIdProvider);
  final selectedJournalEntryController = ref.watch(selectedJournalEntryProvider.notifier);

  return JournalController(
    journalRepository,
    chatHistoryRepository,
    userId,
    selectedJournalEntryController,
    ref.read,
  )..init();
});

class JournalController extends StateNotifier<AsyncValue<List<JournalEntryObj>>> {
  final BaseJournalRepository _journalRepository;
  final BaseChatHistoryRepository _chatHistoryRepository;
  final String? _userId;
  final StateController<AsyncValue<JournalEntryObj?>> _selectedJournalEntryController;
  final T Function<T>(ProviderListenable<T> provider) _read;

  JournalController(
    this._journalRepository,
    this._chatHistoryRepository,
    this._userId,
    this._selectedJournalEntryController,
    this._read,
  ) : super(const AsyncLoading());

  Future<void> init() async {
    if (_userId != null) {
      await loadJournalEntries();
    }
  }

  Future<void> loadJournalEntries() async {
    try {
      assert(_userId != null, "User must be authenticated to load its journal entries.");

      if (state is! AsyncLoading) {
        state = const AsyncLoading();
      }

      final journalEntries = await _journalRepository.readAllJournalEntries(_userId!);
      state = AsyncData(journalEntries);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<JournalEntryObj> addJournalEntry(JournalEntryObj entryObj) async {
    // TODO: Error handling... we do want to throw an error because when creating new journal entries fails the selected journal entry should contain an error.
    // TODO: Probably move the selectedJournalEntry into this state or at least modify it via this controller so that it can handle errors.
    assert(state is AsyncData, "Journal entries must be loaded to add new journal entries.");

    String newId;
    if (entryObj is ChatJournalEntryObj) {
      newId = await _journalRepository.createChatJournalEntry(_userId!, entryObj);
    } else if (entryObj is SimpleJournalEntryObj) {
      newId = await _journalRepository.createSimpleJournalEntry(_userId!, entryObj);
    } else {
      throw Exception('Unknown Journal Entry Type $entryObj');
    }

    entryObj = entryObj.copyWith(id: newId);

    state = AsyncData(state.value!..insert(0, entryObj));

    return entryObj;
  }

  Future<void> deleteJournalEntry(String entryId) async {
    try {
      assert(state is AsyncData, "Journal entries must be loaded to add new journal entries.");

      await _journalRepository.deleteJournalEntry(_userId!, entryId);
      await _chatHistoryRepository.deleteChatHistory(_userId!, entryId);

      state = AsyncData(state.value!..removeWhere((entry) => entry.id == entryId));

      if (entryId == _getSelectedJournalEntryId()) {
        _selectedJournalEntryController.state = const AsyncData(null);
      }
    } catch (error, stackTrace) {
      // TODO: Handle error by showing it in popup instead of this state
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> updateSimpleJournalEntryContent(String entryId, String content) async {
    try {
      assert(state is AsyncData, "Journal entries must be loaded to update journal entries.");

      await updateJournalEntryValues(entryId, {
        'content': content,
      });
    } catch (error, stackTrace) {
      // TODO: Handle error by showing it in popup instead of this state
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> updateJournalEntryValues(String entryId, Map<String, dynamic> updates) async {
    try {
      assert(state is AsyncData, "Journal entries must be loaded to update journal entries.");

      final journalEntry = state.value!.firstWhere((entry) => entry.id == entryId);
      var updatedJournalEntry = journalEntry.copyWith(
        name: updates['name'] ?? journalEntry.name,
        date: updates['date'] ?? journalEntry.date,
      );

      if (updates['content'] != null) {
        if (journalEntry is SimpleJournalEntryObj) {
          updatedJournalEntry = (updatedJournalEntry as SimpleJournalEntryObj).copyWith(
            content: updates['content']
          );
        } else {
          throw Exception('Can only update content of SimpleJournalEntries.');
        }
      }

      if (updates['goal'] != null) {
        if (journalEntry is ChatJournalEntryObj) {
          updatedJournalEntry = (updatedJournalEntry as ChatJournalEntryObj).copyWith(
            goal: updates['goal']
          );
        } else {
          throw Exception('Can only update goal of ChatJournalEntries.');
        }
      }

      await updateJournalEntry(updatedJournalEntry);
    } catch (error, stackTrace) {
      // TODO: Handle error by showing it in popup instead of this state
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> updateJournalEntry(JournalEntryObj journalEntryObjUpdate) async {
    try {
      assert(state is AsyncData, "Journal entries must be loaded to update journal entries.");
      assert(journalEntryObjUpdate.id != null, "Journal entry must have an id to update it.");

      final newJournalEntryObj = await _journalRepository.updateJournalEntry(_userId!, journalEntryObjUpdate);

      state = AsyncData(state.value!.map((entry) => entry.id == journalEntryObjUpdate.id
        ? newJournalEntryObj
        : entry).toList());

      if (journalEntryObjUpdate.id == _getSelectedJournalEntryId()) {
        _selectedJournalEntryController.state = AsyncData(newJournalEntryObj);
      }
    } catch (error, stackTrace) {
      // TODO: Handle error by showing it in popup instead of this state
      state = AsyncError(error, stackTrace);
    }
  }

  String? _getSelectedJournalEntryId() {
    return _read(selectedJournalEntryProvider.notifier).state.valueOrNull?.id;
  }
}