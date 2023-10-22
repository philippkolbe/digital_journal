import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/chat_controller.dart';
import 'package:app/controllers/chat_journal_controller.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/mocks/data/firebase_test_data.dart';
import 'package:app/mocks/mock_ai_service.dart';
import 'package:app/mocks/mock_chat_history_repository.dart';
import 'package:app/mocks/mock_journal_repository.dart';
import 'package:app/mocks/mock_progress_repository.dart';
import 'package:app/mocks/mock_prompts.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/providers/prompts_providers.dart';
import 'package:app/repositories/chat_history_repository.dart';
import 'package:app/repositories/journal_repository.dart';
import 'package:app/repositories/progress_repository.dart';
import 'package:app/services/ai_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Integration: Chat Journal", () {
    test("Chat bot should respond", () async {
      final container = ProviderContainer(
        overrides: [
          aiServiceProvider.overrideWithValue(MockAIService()),
          progressRepositoryProvider.overrideWithValue(MockProgressRepository()),
          journalRepositoryProvider.overrideWithValue(MockJournalRepository()),
          chatHistoryRepositoryProvider.overrideWithValue(MockChatHistoryRepository(chatHistory: [])),
          generalPromptsProvider.overrideWithValue(mockGeneralPrompts),
          userIdProvider.overrideWith((ref) => testUserId),
          selectedJournalEntryProvider.overrideWith((ref) => AsyncData(testChatJournalEntry)),
        ]
      );

      await container.read(chatJournalControllerProvider).onChatJournalEntryCreated();

      expect(container.read(chatControllerProvider).hasValue, isTrue);
      var chat = container.read(chatControllerProvider).value!.chat;
      expect(chat.length, equals(2));
      expect(chat.first.value, isA<AssistantChatMessageObj>());
      expect(chat.last.value, isA<SystemChatMessageObj>());
      expect(chat.last.value!.content.trim(), startsWith("You are a friendly"));

      const firstMessage = "My user message";
      await container.read(chatJournalControllerProvider).onChatJournalMessageSent(firstMessage);
      chat = container.read(chatControllerProvider).value!.chat;
      expect(chat.length, equals(4));
      expect(chat.first.value, isA<AssistantChatMessageObj>());
      expect(chat[1].value, isA<UserChatMessageObj>());
      expect(chat[1].value!.content, firstMessage);
      expect(chat[2].value, isA<AssistantChatMessageObj>());
      expect(chat[2].value!.id, isNot(chat.first.value!.id));
    });

/*     testWidgets("Summarizer should analyze after user message", (tester) async {
      final container = ProviderContainer(
        overrides: [
          aiServiceProvider.overrideWithValue(MockAIService()),
          progressRepositoryProvider.overrideWithValue(MockProgressRepository()),
          journalRepositoryProvider.overrideWithValue(MockJournalRepository()),
          chatHistoryRepositoryProvider.overrideWithValue(MockChatHistoryRepository(chatHistory: [])),
          generalPromptsProvider.overrideWithValue(mockGeneralPrompts),
          userIdProvider.overrideWith((ref) => testUserId),
        ]
      );

      await tester.pumpWidget(ProviderScope(
        parent: container,
        overrides: [
          aiServiceProvider.overrideWithValue(MockAIService()),
          progressRepositoryProvider.overrideWithValue(MockProgressRepository()),
          journalRepositoryProvider.overrideWithValue(MockJournalRepository()),
          chatHistoryRepositoryProvider.overrideWithValue(MockChatHistoryRepository(chatHistory: [])),
          generalPromptsProvider.overrideWithValue(mockGeneralPrompts),
          userIdProvider.overrideWith((ref) => testUserId),
        ],
        child: Consumer(builder: (ctx, ref, _) {
          observeProviders(ref);
          return Container();
        }),
      ));

      // Selecting and deselcting journalEntries: summaryProvider is always null (by design)
      container.read(selectedJournalEntryProvider.notifier).state = AsyncData(testSimpleJournalEntry);
      expect(container.read(summaryProvider).value, isNull);

      // Creating and selecting
      container.read(selectedJournalEntryProvider.notifier).state = AsyncData(testChatJournalEntry);
      expect(container.read(summaryProvider).value, isNull);

      await container.read(chatJournalControllerProvider).onChatJournalEntryCreated();
      expect(container.read(summaryProvider).value, isNull);

      const firstMessage = "My user message";
      await container.read(chatJournalControllerProvider).onChatJournalMessageSent(firstMessage);
      final summary = container.read(summaryProvider).value;
      expect(summary, isA<SummaryObj>());
      // Summary should go up to the first user message
      expect(summary!.validUpToId, container.read(chatControllerProvider).value!.chat[1].value!.id);
    });
 */
/*     testWidgets("Summaries should be stored in repository", (WidgetTester tester) async {
      final container = ProviderContainer(
        overrides: [
          aiServiceProvider.overrideWithValue(MockAIService()),
          progressRepositoryProvider.overrideWithValue(MockProgressRepository()),
          journalRepositoryProvider.overrideWithValue(MockJournalRepository()),
          chatHistoryRepositoryProvider.overrideWithValue(MockChatHistoryRepository(chatHistory: [])),
          generalPromptsProvider.overrideWithValue(mockGeneralPrompts),
          userIdProvider.overrideWith((ref) => testUserId),
          selectedJournalEntryProvider.overrideWith((ref) => AsyncData(testChatJournalEntry)),
        ]
      );

      
      await tester.pumpWidget(ProviderScope(
        parent: container,
        child: Consumer(builder: (ctx, ref, _) {
          observeProviders(ref);
          return Container();
        }),
      ));

      const firstMessage = "My user message";
      await container.read(chatJournalControllerProvider).onChatJournalMessageSent(firstMessage);
      final summary = container.read(selectedJournalEntryProvider).value!.summary;
      expect(summary, isNotNull);
      expect(summary!.validUpToId, equals(container.read(chatControllerProvider).value!.chat[1].value!.id));
    }); */
  });
}