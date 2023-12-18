import 'package:app/models/chat_message.dart';
import 'package:app/models/information.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/models/summary.dart';
import 'package:app/models/user.dart';
import 'package:app/models/attribute.dart';


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
  goal: 'Test me',
  summary: SummaryObj(
    date: DateTime(2023, 1, 1, 11, 2),
    content: "This is the shortest summary for this chat journal ever!",
    validUpToId: testChatMessageId,
  ),
) as ChatJournalEntryObj;

const testChatMessageId = 'id_test_message';
final testChatMessageObj = ChatMessageObj.user(
  id: testChatMessageId,
  date: DateTime(2023, 1, 1, 11, 5),
  content: 'Hello, world!',
);

const testChatBotMessageId = 'id_bot_test_message';
final testChatBotMessageObj = ChatMessageObj.assistant(
  id: testChatBotMessageId,
  date: DateTime(2024, 1, 1, 11, 7),
  content: 'Hi, I am a bot.',
);

const testAttributeId = 'id_test_attribute';
const testAttributeObj = AttributeObj.like(
  id: testAttributeId,
  description: 'This is a test attribute description',
  level: 5,
);

const testFearId = 'id_test_fear';
const testFearObj = AttributeObj.fear(
  id: testFearId,
  description: 'I FEAR DARTH VADER',
  level: 9,
);

const testInformationId = 'id_test_information';
final testInformationObj = InformationObj(
  id: testInformationId,
  description: 'Some random info',
  date: DateTime(2024, 1, 1, 11, 7),
  expirationDate: DateTime(2024, 1, 1, 19, 7),
  importance: 3,
);

FakeFirebaseFirestore setupFakeFirestore({ user = false, journal = true, chat = true, attribute = true, information = true }) {
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

    if (attribute) {
      final attributeCollection = userDoc.collection('attributes');
      final attributeDoc = attributeCollection.doc(testAttributeId);
      attributeDoc.set(testAttributeObj.toDocument());

      final fearDoc = attributeCollection.doc(testFearId);
      fearDoc.set(testFearObj.toDocument());
    }

    if (information) {
      final informationCollection = userDoc.collection('information');
      final informationDoc = informationCollection.doc(testInformationId);
      informationDoc.set(testInformationObj.toDocument());
    }
  }

  return firestore;
}