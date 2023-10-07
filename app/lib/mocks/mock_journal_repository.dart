import 'package:app/models/journal_entry.dart';
import 'package:app/repositories/journal_repository.dart';

class MockJournalRepository implements BaseJournalRepository {
  final simpleJournalEntry = SimpleJournalEntryObj(id: '1', name: 'Simple Entry 1', date: DateTime.now(), content: 'Content 1');
  final chatJournalEntry = ChatJournalEntryObj(id: '2', name: 'Chat Entry 1', date: DateTime.now(), goal: 'Goal 1');

  late final Map<String, JournalEntryObj> journalEntries;
  late int idCount;

  MockJournalRepository() {
    journalEntries = {
      simpleJournalEntry.id!: simpleJournalEntry,
      chatJournalEntry.id!: chatJournalEntry,
    };
    idCount = journalEntries.length;
  }

  /// Its assuming that there is only one user
  @override
  Future<List<JournalEntryObj>> readAllJournalEntries(String userId) {
    return Future.value(journalEntries.values.toList());
  }

  @override
  Future<JournalEntryObj> readJournalEntry(String userId, String entryId) {
    return Future.value(journalEntries[entryId]);
  }

  @override
  Future<String> createSimpleJournalEntry(String userId, SimpleJournalEntryObj entry) {
    final id = entry.id ?? (++idCount).toString();
    journalEntries[id] = entry;
    return Future.value(id);
  }

  @override
  Future<String> createChatJournalEntry(String userId, ChatJournalEntryObj entry) {
    final id = entry.id ?? (++idCount).toString();
    journalEntries[id] = entry;
    return Future.value(id);
  }

  @override
  Future<void> deleteJournalEntry(String userId, String entryId) {
    journalEntries.remove(entryId);
    return Future.value();
  }

  @override
  Future<JournalEntryObj> updateJournalEntry(String userId, JournalEntryObj entry) {
    final existingEntry = journalEntries[entry.id!];
    if (existingEntry != null) {
      journalEntries[entry.id!] = entry;
      return Future.value(entry);
    } else {
      throw JournalException('Journal entry does not exist.', userId: userId, entryId: entry.id);
    }
  }
}