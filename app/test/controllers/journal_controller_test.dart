import 'package:app/controllers/journal_controller.dart';
import 'package:app/mocks/data/firebase_test_data.dart';
import 'package:app/models/journal_entry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/mocks/mock_chat_history_repository.dart';
import 'package:app/mocks/mock_journal_repository.dart';

void main() {
  group('JournalControllerTest', () {
    late JournalController controller;
    late MockJournalRepository repository;
    late MockChatHistoryRepository chatHistoryRepository;
    setUp(() async {
      repository = MockJournalRepository();
      chatHistoryRepository = MockChatHistoryRepository();
      controller = JournalController(repository, chatHistoryRepository, testUserId);
      await controller.init();
    });

    test('Initial state is loading', () {
      final loadingController = JournalController(repository, chatHistoryRepository, testUserId);
      expect(loadingController.debugState, const AsyncValue<List<JournalEntryObj>>.loading());
    });

    test('Fetch journal entries successfully', () async {
      await controller.loadJournalEntries();

      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());
      expect(controller.debugState.valueOrNull, await repository.readAllJournalEntries(testUserId));
    });

    test('Loading journal entries while user unauthorized should throw', () async {
      final unauthorizedController = JournalController(repository, chatHistoryRepository, null);

      await unauthorizedController.loadJournalEntries();
      expect(unauthorizedController.debugState, isA<AsyncError>());
    });

    test('Add chat journal entry successfully', () async {
      await controller.addJournalEntry(testChatJournalEntry);

      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());
      expect(controller.debugState.valueOrNull!.first, testChatJournalEntry);
      expect(controller.debugState.valueOrNull!.first, await repository.readJournalEntry(testUserId, testChatJournalEntry.id!));
    });

    test('Add simple journal entry successfully', () async {
      await controller.addJournalEntry(testSimpleJournalEntry);

      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());
      expect(controller.debugState.valueOrNull!.first, testSimpleJournalEntry);
      expect(controller.debugState.valueOrNull!.first, await repository.readJournalEntry(testUserId, testSimpleJournalEntry.id!));
    });
  
    test('Adding journal entry while loading should throw error', () async {
      final unauthorizedController = JournalController(repository, chatHistoryRepository, null);

      expect(
        () => unauthorizedController.addJournalEntry(testChatJournalEntry),
        throwsA(isAssertionError)
      );
    });

    test('Delete journal entry successfully', () async {
      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());
      final idToDelete = repository.simpleJournalEntry.id!;
      final lengthBefore = controller.debugState.value!.length;
      await controller.deleteJournalEntry(idToDelete);

      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());
      expect(controller.debugState.value, hasLength(lengthBefore - 1));
      expect(controller.debugState.value!.every((entry) => entry.id != idToDelete), isTrue);
      expect(await repository.readAllJournalEntries(testUserId), hasLength(lengthBefore - 1));
    });

    test('Update simple journal entry content successfully', () async {
      final idToUpdate = repository.simpleJournalEntry.id!;
      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());

      const newContent = 'New content';
      await controller.updateSimpleJournalEntryContent(idToUpdate, newContent);

      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());
      final updatedEntry = controller.debugState.value!.firstWhere((entry) => entry.id == repository.simpleJournalEntry.id);
      expect(updatedEntry, isA<SimpleJournalEntryObj>());
      expect((updatedEntry as SimpleJournalEntryObj).content, newContent);
    
      final updatedRepositoryEntry = await repository.readJournalEntry(testUserId, repository.simpleJournalEntry.id!);
      expect((updatedRepositoryEntry as SimpleJournalEntryObj).content, newContent);
    });

    test('Updating chat journal entry content is not allowed', () async {
      final idToUpdate = repository.chatJournalEntry.id!;
      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());

      const newContent = 'New content';
      await controller.updateSimpleJournalEntryContent(idToUpdate, newContent);

      expect(controller.debugState, isA<AsyncError<List<JournalEntryObj>>>());
    });
  });
}