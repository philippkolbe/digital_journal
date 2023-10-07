import 'package:app/common/async_widget.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/providers/selected_journal_entry_provider.dart';
import 'package:app/views/journal/journal_list_entry_widget.dart';
import 'package:app/views/journal/journal_entry_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JournalPage extends ConsumerWidget {
  const JournalPage({ super.key });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncJournalState = ref.watch(journalEntriesProvider);
    final journalController = ref.read(journalEntriesProvider.notifier);
    final selectedJournalEntryController = ref.read(selectedJournalEntryProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Journal'),
      ),
      // TODO: Search bar or filter options can be added here
      body: AsyncWidget(
        asyncValue: asyncJournalState,
        buildWidget: (journalState) {
          if (journalState.isNotEmpty) {
            return ListView.builder(
              itemCount: journalState.length,
              itemBuilder: (context, index) {
                final journalEntry = journalState[index];
                return JournalListEntryWidget(
                  journalEntry: journalEntry,
                  onSelected: (BuildContext context, JournalEntryObj selectedJournalEntry) => 
                    _onOpenJournalEntry(context, selectedJournalEntry, selectedJournalEntryController),
                );
              },
            );
          } else {
            return const Text("Start journaling!");
          }
        },
        onRetryAfterError: () => journalController.loadJournalEntries(),
      ),
    );
  }

  void _onOpenJournalEntry(
    BuildContext context,
    JournalEntryObj journalEntry,
    StateController<AsyncValue<JournalEntryObj?>> selectedJournalEntryController,
  ) {
    _selectJournalEntry(selectedJournalEntryController, journalEntry);
    _pushJournalEntryRoute(context);
  }

  void _pushJournalEntryRoute(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const JournalEntryView(),
      ),
    );
  }

  void _selectJournalEntry(
    StateController<AsyncValue<JournalEntryObj?>> selectedJournalEntryController,
    JournalEntryObj journalEntryObj,
  ) {
    selectedJournalEntryController.state = AsyncData(journalEntryObj);
  }
}
