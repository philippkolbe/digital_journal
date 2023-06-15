import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:app/repositories/chat_history_repository.dart';

import 'firebase_test_data.dart';

void main() {
  group('ChatHistoryRepository', () {
    late FakeFirebaseFirestore firestore;
    late BaseChatHistoryRepository repository;
    
    setUp(() {
      firestore = setupFakeFirestore(user: true, journal: true, chat: true);
      repository = ChatHistoryRepository(firestore);
    });
    
    test('createChatMessage should add a new chat message to the collection', () async {
      // Prepare test data
      const overwriteId = 'test_chat_message2';
      final chatMessageObj = testChatMessageObj.copyWith(id: overwriteId);
      
      // Execute the method
      final messageId = await repository.createChatMessage(testUserId, testSimpleJournalEntryId, chatMessageObj);
      
      // Verify the result
      expect(messageId, isNotEmpty);
      
      // Check if the chat message is added to the collection
      final chatHistoryCollection = firestore
        .collection('users')
        .doc(testUserId)
        .collection('journalEntries')
        .doc(testSimpleJournalEntryId)
        .collection('chatHistory');
        
      final snapshot = await chatHistoryCollection.doc(messageId).get();
      expect(snapshot.exists, isTrue);
    });
    
    test('readChatHistory should retrieve the chat history for a user and journal entry', () async {
      final chatHistory = await repository.readChatHistory(testUserId, testChatJournalEntryId);

      expect(chatHistory, isList);
      expect(chatHistory.isNotEmpty, isTrue);
    });
  });
}
