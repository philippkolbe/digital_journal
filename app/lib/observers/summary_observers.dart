import 'package:app/controllers/chat_controller.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/controllers/summary_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void initializeSummaryUpdateObserver(WidgetRef ref) {
  final journalController = ref.read(journalEntriesProvider.notifier);

  ref.listen(summaryProvider, (_, asyncSummaryObj) {
    final summaryObj = asyncSummaryObj.valueOrNull;
    final selectedJournalEntry = ref.read(selectedJournalEntryProvider).valueOrNull;
  
    if (summaryObj != null && selectedJournalEntry != null) {
      journalController.updateJournalEntry(
        selectedJournalEntry.copyWith(
          summary: asyncSummaryObj.valueOrNull,
        ),
      );
    }
  });
}

void initializeChatSummaryObserver(WidgetRef ref) {
  final summaryController = ref.read(summaryProvider.notifier);
  ref.listen<AsyncValue<ChatState?>>(chatControllerProvider, summaryController.onChatStateUpdated);
}