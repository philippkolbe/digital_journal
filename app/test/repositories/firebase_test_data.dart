import 'package:app/models/chat_message.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/models/user.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

const testUserId = 'id_test_user';
const testUser = UserObj(id: testUserId, name: 'John Doe');

const testSimpleJournalEntryId = 'id_simple_test_journal_entry';
final testSimpleJournalEntry = JournalEntryObj.simple(
  id: testSimpleJournalEntryId,
  name: 'Simple Journal',
  date: DateTime(2023, 1, 1, 10),
  content: 'Lets do some simple stuff ok?'
) as SimpleJournalEntryObj;

const testChatJournalEntryId = 'id_test_chat_journal_entry';
final testChatJournalEntry = JournalEntryObj.chat(
  id: testChatJournalEntryId,
  name: 'Chat Journal',
  date: DateTime(2023, 1, 1, 11),
  goal: 'Test me'
) as ChatJournalEntryObj;

const testChatMessageId = 'id_test_message';
final testChatMessageObj = ChatMessageObj(
  isFromBot: false,
  id: testChatMessageId,
  date: DateTime(2023, 1, 1, 11, 5),
  content: 'Hello, world!',
);

const testChatBotMessageId = 'id_bot_test_message';
final testChatBotMessageObj = ChatMessageObj(
  isFromBot: true,
  id: testChatBotMessageId,
  date: DateTime(2024, 1, 1, 11, 7),
  content: 'Hi, I am a bot.',
);

FakeFirebaseFirestore setupFakeFirestore({ bool user = false, bool journal = true, bool chat = true }) {
  final firestore = FakeFirebaseFirestore();

  if (user) {
    final userDoc = firestore.collection('users').doc(testUserId);

    userDoc.set(testUser.toDocument());

    if (journal) {
      final journalCollection = userDoc.collection('journalEntries');
      final chatDoc = journalCollection.doc(testChatJournalEntryId);
      chatDoc.set(testChatJournalEntry.toDocument());
      journalCollection.doc(testSimpleJournalEntryId).set(testSimpleJournalEntry.toDocument());
    
      if (chat) {
        chatDoc.collection('chatHistory').doc(testChatMessageId).set(testChatMessageObj.toDocument());
      }
    }
  }

  return firestore;
}