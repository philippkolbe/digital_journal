import 'package:app/common/async_widget.dart';
import 'package:app/controllers/chat_journal_controller.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/providers/selected_journal_entry_provider.dart';
import 'package:app/views/journal/journal_entry_view.dart';
import 'package:app/views/journal/mood_check_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatJournalWizard extends ConsumerWidget {
  const ChatJournalWizard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedJournalEntryController = ref.read(selectedJournalEntryProvider.notifier);
    final journalController = ref.read(journalControllerProvider.notifier);
    final chatJournalController = ref.read(chatJournalControllerProvider);
    final asyncSelectedJournalEntry = ref.watch(selectedJournalEntryProvider);

    return AsyncWidget(
      asyncValue: asyncSelectedJournalEntry,
      buildWidget: (selectedJournalEntry) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (selectedJournalEntry?.id != null) {
                journalController.deleteJournalEntry(selectedJournalEntry!.id!);
              }

              _closeJournalEntryView(
                context,
                selectedJournalEntryController
              );
            },
          ),
        ),
        body: selectedJournalEntry != null
          ? MoodCheckWidget(
            onContinue: () => _onMoodCheckCompleted(
              context,
              chatJournalController,
            ),
          )
          : const Center(child: Text("Something went wrong.")),
      ),
    );
  }

  void _onMoodCheckCompleted(
    BuildContext context,
    ChatJournalController chatJournalController,
  ) {
    chatJournalController.onChatJournalEntryCreated();

    Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (context) => const JournalEntryView()),
    );
  }

  void _closeJournalEntryView(
    BuildContext context,
    StateController<AsyncValue<JournalEntryObj?>> selectedJournalEntryController,
  ) {
    Navigator.pop(context);
    selectedJournalEntryController.state = const AsyncData(null);
  }
}