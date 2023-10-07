import 'package:app/controllers/journal_controller.dart';
import 'package:flutter/material.dart';
import 'package:app/models/journal_entry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JournalListEntryWidget extends ConsumerWidget {
  final JournalEntryObj journalEntry;
  final Function(BuildContext, JournalEntryObj) onSelected;

  const JournalListEntryWidget({
    required this.journalEntry,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedJournalEntry = ref.watch(selectedJournalEntryProvider);
    final journalController = ref.watch(journalEntriesProvider.notifier);

    return Dismissible(
      key: Key(journalEntry.id!),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        if (journalEntry.id != null) {
          journalController.deleteJournalEntry(journalEntry.id!);
        } else {
          // TODO error handling
          print("Trying to delete entry with id null");
        }
      },
      child: ListTile(
        onTap: () => onSelected(context, journalEntry),
        leading: Icon(
          journalEntry is SimpleJournalEntryObj ? Icons.article : Icons.chat,
        ),
        title: Text(journalEntry.name),
        subtitle: Text('${journalEntry.date.day}.${journalEntry.date.month}.${journalEntry.date.year} ${journalEntry.date.hour}:${journalEntry.date.minute}'),
        selected: selectedJournalEntry.valueOrNull?.id == journalEntry.id,
      ),
    );
  }
}