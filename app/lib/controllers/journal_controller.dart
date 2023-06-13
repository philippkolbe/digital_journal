import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/repositories/journal_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final journalControllerProvider = StateNotifierProvider<JournalController, AsyncValue<List<JournalEntryObj>>>((ref) {
  final journalRepository = ref.watch(journalRepositoryProvider);
  final userState = ref.watch(authControllerProvider);
  return JournalController(journalRepository, userState.valueOrNull?.currentUser.id)..init();
});

class JournalController extends StateNotifier<AsyncValue<List<JournalEntryObj>>> {
  final BaseJournalRepository _journalRepository;
  final String? _userId;

  JournalController(this._journalRepository, this._userId) : super(const AsyncLoading());

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

  Future<void> addJournalEntry(JournalEntryObj entryObj) async {
    try {
      assert(state is AsyncData, "Journal entries must be loaded to add new journal entries.");

      if (entryObj is ChatJournalEntryObj) {
        await _journalRepository.createChatJournalEntry(_userId!, entryObj);
      } else if (entryObj is SimpleJournalEntryObj) {
        await _journalRepository.createSimpleJournalEntry(_userId!, entryObj);
      } else {
        throw Exception('Unknown Journal Entry Type $entryObj');
      }

      state = AsyncData(state.value!..insert(0, entryObj));
    } catch (error, stackTrace) {
      // TODO: Handle error by showing it in popup instead of this state
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> deleteJournalEntry(String entryId) async {
    try {
      assert(state is AsyncData, "Journal entries must be loaded to add new journal entries.");

      await _journalRepository.deleteJournalEntry(_userId!, entryId);

      state = AsyncData(state.value!..removeWhere((entry) => entry.id == entryId));
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

  Future<void> updateJournalEntry(JournalEntryObj updatedJournalEntryObj) async {
    try {
      assert(state is AsyncData, "Journal entries must be loaded to update journal entries.");

      await _journalRepository.updateJournalEntry(_userId!, updatedJournalEntryObj);

      state = AsyncData(state.value!.map((entry) => entry.id == updatedJournalEntryObj.id
        ? updatedJournalEntryObj
        : entry).toList());
    } catch (error, stackTrace) {
      // TODO: Handle error by showing it in popup instead of this state
      state = AsyncError(error, stackTrace);
    }
  }

}