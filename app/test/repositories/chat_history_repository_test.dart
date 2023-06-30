import 'package:app/providers/encrypter_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:app/repositories/chat_history_repository.dart';

import 'firebase_test_data.dart';

void main() {
  group('ChatHistoryRepository', () {
    late FakeFirebaseFirestore firestore;
    late BaseChatHistoryRepository repository;
    late Encrypter encrypter;
    
    setUp(() {
      firestore = setupFakeFirestore(user: true, journal: true, chat: true);
      encrypter = Encrypter('my-test-key-1234');
      repository = ChatHistoryRepository(firestore, encrypter);
    });
    
    test('createChatMessage should add a new chat message to the collection', () async {
      // Prepare test data
      const overwriteId = 'test_chat_message2';
      final chatMessageObj = testChatMessageObj.copyWith(id: overwriteId);
      
      // Execute the method
      final message = await repository.createChatMessage(testUserId, testChatJournalEntryId, chatMessageObj);
      
      // Verify the result
      expect(message.id, isNotEmpty);
      
      // Check if the chat message is added to the collection
      final chatHistoryCollection = firestore
        .collection('users')
        .doc(testUserId)
        .collection('journalEntries')
        .doc(testChatJournalEntryId)
        .collection('chatHistory');
        
      final snapshot = await chatHistoryCollection.doc(message.id).get();
      expect(snapshot.exists, isTrue);
      expect(encrypter.decrypt(snapshot.data()!['content']), chatMessageObj.content);
    });
    
    test('readChatHistory should retrieve the chat history for a user and journal entry', () async {
      final chatHistory = await repository.readChatHistory(testUserId, testChatJournalEntryId);

      expect(chatHistory, isList);
      expect(chatHistory.isNotEmpty, isTrue);
      expect(chatHistory.first.content, testChatMessageObj.content);
    });
  });
}
