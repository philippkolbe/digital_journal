import 'package:app/mocks/data/firebase_test_data.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/providers/encrypter_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/repositories/journal_repository.dart';

void main() {
  group('JournalRepository', () {
    late FirebaseFirestore firestore;
    late BaseJournalRepository repository;
    late Future<BaseEncrypter> encrypter;
    
    setUp(() {
      firestore = setupFakeFirestore(user: true, journal: true);
      encrypter = Future.value(Encrypter('my-test-key-1234'));
      repository = JournalRepository(firestore, encrypter);
    });
    
    test('createSimpleJournalEntry should add a new simple journal entry to the collection', () async {
      // Prepare test data
      const userId = testUserId;
      const overwriteId = 'test_simple_journal_entry_id_2';
      final entry = testSimpleJournalEntry.copyWith(id: overwriteId);
      
      // Execute the method
      final entryId = await repository.createSimpleJournalEntry(userId, entry);
      
      expect(entryId, entry.id);
      // Check if the entry is added to the collection
      final entryDoc = await firestore.collection('users').doc(userId).collection('journalEntries').doc(entryId).get();
      expect(entryDoc.exists, isTrue);
      expect((await encrypter).decrypt(entryDoc.data()!['content']), testSimpleJournalEntry.content);
    });
    
    test('createChatJournalEntry should add a new chat journal entry to the collection', () async {
      // Prepare test data
      const userId = testUserId;
      const overwriteId = 'test_chat_journal_entry_id_2';
      final entry = testChatJournalEntry.copyWith(id: overwriteId);
      
      // Execute the method
      final entryId = await repository.createChatJournalEntry(userId, entry);

      expect(entryId, entry.id);

      // Check if the entry is added to the collection
      final entryDoc = await firestore.collection('users').doc(userId).collection('journalEntries').doc(entryId).get();
      expect(entryDoc.exists, isTrue);
      expect((await encrypter).decrypt(entryDoc.data()!['summaryContent']), testChatJournalEntry.summary!.content);
    });
    
    test('readAllJournalEntries should retrieve all journal entries for a user', () async {
      // Prepare test data
      const userId = testUserId;
      
      // Execute the method
      final entries = await repository.readAllJournalEntries(userId);
      
      // Verify the result
      expect(entries.length, equals(2));
      expect((await encrypter).decrypt(entries[0].summary!.content), testChatJournalEntry.summary!.content);
      expect((await encrypter).decrypt((entries[1] as SimpleJournalEntryObj).content!), testSimpleJournalEntry.content);
    });
    
    test('readJournalEntry should retrieve a specific journal entry for a user', () async {
      // Prepare test data
      const userId = testUserId;
      const entryId = testSimpleJournalEntryId;
      
      // Execute the method
      final entry = await repository.readJournalEntry(userId, entryId);
      
      // Verify the result
      expect((await encrypter).decrypt((entry as SimpleJournalEntryObj).content!), testSimpleJournalEntry.content);
    });
    
    test('readJournalEntry should throw an exception for a non-existing journal entry', () async {
      // Prepare test data
      const userId = testUserId;
      const nonExistingEntryId = 'nonexistingentry';
      
      // Execute the method and verify the exception
      expect(
        () => repository.readJournalEntry(userId, nonExistingEntryId),
        throwsA(isA<JournalException>()),
      );
    });
    
    test('updateJournalEntry should update an existing journal entry', () async {
      // Prepare test data
      const userId = testUserId;
      final updatedEntry = testSimpleJournalEntry.copyWith(name: 'Updated Journal');
      
      // Execute the method
      await repository.updateJournalEntry(userId, updatedEntry);
      
      // Check if the entry is updated in the collection
      final entryDoc = await firestore.collection('users').doc(userId).collection('journalEntries').doc(updatedEntry.id).get();
      expect(entryDoc.exists, isTrue);
      expect((await encrypter).decrypt(entryDoc.data()!['content']), updatedEntry.content);
      expect((await encrypter).decrypt(entryDoc.data()!['name']), updatedEntry.name);
    });
    
    test('deleteJournalEntry should delete an existing journal entry', () async {
      // Prepare test data
      const userId = testUserId;
      const entryId = testSimpleJournalEntryId;
      
      // Execute the method
      await repository.deleteJournalEntry(userId, entryId);
      
      // Check if the entry is deleted from the collection
      final entryDoc = await firestore.collection('users').doc(userId).collection('journalEntries').doc(entryId).get();
      expect(entryDoc.exists, isFalse);
    });
  });
}
