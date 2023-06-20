import 'package:app/common/async_widget.dart';
import 'package:app/controllers/chat_journal_controller.dart';
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
    final asyncJournalState = ref.watch(journalControllerProvider);
    final journalController = ref.read(journalControllerProvider.notifier);
    final chatJournalController = ref.watch(chatJournalControllerProvider);
    final selectedJournalEntryController = ref.read(selectedJournalEntryProvider.notifier);

    return AsyncWidget(
      asyncValue: asyncJournalState,
      buildWidget: (journalState) {
        return Column(
          children: [
            AppBar(
              title: const Text('Your Journal'),
              actions: [
                IconButton(
                  onPressed: () => _onAddJournalEntry(
                    context,
                    journalController,
                    selectedJournalEntryController,
                  ),
                  icon: const Icon(Icons.add_circle_outlined),
                ),
              ]
            ),
            // TODO: Search bar or filter options can be added here
            Expanded(
              child: ListView.builder(
                itemCount: journalState.length,
                itemBuilder: (context, index) {
                  final journalEntry = journalState[index];
                  return JournalListEntryWidget(
                    journalEntry: journalEntry,
                    onSelected: (BuildContext context, JournalEntryObj selectedJournalEntry) => 
                      _onOpenJournalEntry(context, selectedJournalEntry, selectedJournalEntryController),
                  );
                },
              ),
            ),
          ],
        );
      },
      onRetryAfterError: () => journalController.loadJournalEntries(),
    );
  }

  void _onAddJournalEntry(
    BuildContext context,
    JournalController journalController,
    StateController<AsyncValue<JournalEntryObj?>> selectedJournalEntryController,
  ) async {
    selectedJournalEntryController.state = const AsyncLoading();

    _pushJournalEntryRoute(context);


    try {
      final newJournalEntryObj = await journalController.addJournalEntry(JournalEntryObj.chat(
        name: 'New Journal Entry',
        date: DateTime.now(),
      ));

      _selectJournalEntry(selectedJournalEntryController, newJournalEntryObj!);
    } catch (err, st) {
      selectedJournalEntryController.state = AsyncError(err, st);
    }
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
