import 'package:app/controllers/journal_controller.dart';
import 'package:app/mocks/data/firebase_test_data.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/models/summary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/mocks/mock_chat_history_repository.dart';
import 'package:app/mocks/mock_journal_repository.dart';

void main() {
  group('JournalControllerTest', () {
    late JournalController controller;
    late MockJournalRepository repository;
    late MockChatHistoryRepository chatHistoryRepository;
    late ProviderContainer container;
    setUp(() async {
      repository = MockJournalRepository();
      chatHistoryRepository = MockChatHistoryRepository();
      container = ProviderContainer();
      controller = _initJournalController(
          container, repository, chatHistoryRepository, testUserId);
      await controller.init();
    });

    test('Initial state is loading', () {
      final loadingController = _initJournalController(
          container, repository, chatHistoryRepository, testUserId);
      expect(loadingController.debugState,
          const AsyncValue<List<JournalEntryObj>>.loading());
    });

    test('Fetch journal entries successfully', () async {
      await controller.loadJournalEntries();

      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());
      expect(controller.debugState.valueOrNull,
          await repository.readAllJournalEntries(testUserId));
    });

    test('Loading journal entries while user unauthorized should throw',
        () async {
      final unauthorizedController = _initJournalController(
          container, repository, chatHistoryRepository, null);

      await unauthorizedController.loadJournalEntries();
      expect(unauthorizedController.debugState, isA<AsyncError>());
    });

    test('Add chat journal entry successfully', () async {
      await controller.addJournalEntry(testChatJournalEntry);

      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());
      expect(controller.debugState.valueOrNull!.first, testChatJournalEntry);
      expect(
          controller.debugState.valueOrNull!.first,
          await repository.readJournalEntry(
              testUserId, testChatJournalEntry.id!));
    });

    test('Add simple journal entry successfully', () async {
      await controller.addJournalEntry(testSimpleJournalEntry);

      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());
      expect(controller.debugState.valueOrNull!.first, testSimpleJournalEntry);
      expect(
          controller.debugState.valueOrNull!.first,
          await repository.readJournalEntry(
              testUserId, testSimpleJournalEntry.id!));
    });

    test('Adding journal entry while loading should throw error', () async {
      final container = ProviderContainer();
      final selectedJournalEntryController =
          container.read(selectedJournalEntryProvider.notifier);
      final unauthorizedController = JournalController(
          repository,
          chatHistoryRepository,
          null,
          selectedJournalEntryController,
          container.read);

      expect(() => unauthorizedController.addJournalEntry(testChatJournalEntry),
          throwsA(isAssertionError));
    });

    test('Delete selected journal entry successfully', () async {
      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());
      final toDelete = repository.simpleJournalEntry;
      final lengthBefore = controller.debugState.value!.length;

      // Select to be deleted object
      container.read(selectedJournalEntryProvider.notifier).state =
          AsyncData(toDelete);

      await controller.deleteJournalEntry(toDelete.id!);

      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());
      expect(controller.debugState.value, hasLength(lengthBefore - 1));
      expect(
          controller.debugState.value!
              .every((entry) => entry.id != toDelete.id),
          isTrue);
      expect(await repository.readAllJournalEntries(testUserId),
          hasLength(lengthBefore - 1));

      expect(container.read(selectedJournalEntryProvider),
          equals(const AsyncData<JournalEntryObj?>(null)));
    });

    test('Delete not selected journal entry without deselecting', () async {
      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());
      final toDelete = repository.simpleJournalEntry;

      // Select to be deleted object
      final selected = AsyncData<JournalEntryObj?>(repository.chatJournalEntry);
      container.read(selectedJournalEntryProvider.notifier).state = selected;

      await controller.deleteJournalEntry(toDelete.id!);

      expect(container.read(selectedJournalEntryProvider), equals(selected));
    });

    test('Update simple journal entry content successfully', () async {
      final toUpdate = repository.simpleJournalEntry;
      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());

      // Select to be updated object
      container.read(selectedJournalEntryProvider.notifier).state =
          AsyncData(toUpdate);

      const newContent = 'New content';
      await controller.updateSimpleJournalEntryContent(
          toUpdate.id!, newContent);

      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());
      final updatedEntry = controller.debugState.value!
          .firstWhere((entry) => entry.id == repository.simpleJournalEntry.id);
      expect(updatedEntry, isA<SimpleJournalEntryObj>());
      expect((updatedEntry as SimpleJournalEntryObj).content, newContent);

      final updatedRepositoryEntry = await repository.readJournalEntry(
          testUserId, repository.simpleJournalEntry.id!);
      expect((updatedRepositoryEntry as SimpleJournalEntryObj).content,
          newContent);

      final newSelectedObject =
          container.read(selectedJournalEntryProvider).valueOrNull;
      expect(newSelectedObject, updatedEntry);
    });

    test('Updating chat journal entry content is not allowed', () async {
      final idToUpdate = repository.chatJournalEntry.id!;
      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());

      const newContent = 'New content';
      await controller.updateSimpleJournalEntryContent(idToUpdate, newContent);

      expect(controller.debugState, isA<AsyncError<List<JournalEntryObj>>>());
    });

    test('Updating summary of selected entry', () async {
      final toUpdate = repository.chatJournalEntry;
      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());

      // Select to be updated object
      container.read(selectedJournalEntryProvider.notifier).state =
          AsyncData(toUpdate);

      const newSummary = 'New summary';
      await controller.updateJournalEntry(toUpdate.copyWith(
          summary: SummaryObj(
        date: DateTime.now(),
        content: newSummary,
      )));

      expect(controller.debugState, isA<AsyncValue<List<JournalEntryObj>>>());
      final updatedEntry = controller.debugState.value!
          .firstWhere((entry) => entry.id == repository.chatJournalEntry.id);
      expect(updatedEntry, isA<ChatJournalEntryObj>());
      expect((updatedEntry as ChatJournalEntryObj).summary, isNotNull);
      expect(updatedEntry.summary!.content, newSummary);

      final updatedRepositoryEntry = await repository.readJournalEntry(
          testUserId, repository.chatJournalEntry.id!);
      expect(
          (updatedRepositoryEntry as ChatJournalEntryObj).summary, isNotNull);
      expect(updatedRepositoryEntry.summary!.content, newSummary);

      final newSelectedObject =
          container.read(selectedJournalEntryProvider).valueOrNull;
      expect(newSelectedObject, updatedEntry);
    });
  });
}

JournalController _initJournalController(
    ProviderContainer container,
    MockJournalRepository repository,
    MockChatHistoryRepository chatHistoryRepository,
    String? userId) {
  final selectedJournalEntryController =
      container.read(selectedJournalEntryProvider.notifier);
  final loadingController = JournalController(repository, chatHistoryRepository,
      userId, selectedJournalEntryController, container.read);
  return loadingController;
}
