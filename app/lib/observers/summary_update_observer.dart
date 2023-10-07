import 'package:app/controllers/journal_controller.dart';
import 'package:app/controllers/summary_controller.dart';
import 'package:app/providers/selected_journal_entry_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void initializeSummaryUpdateObserver(WidgetRef ref) {
  final journalController = ref.read(journalControllerProvider.notifier);

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