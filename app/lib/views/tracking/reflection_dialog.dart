import 'package:app/controllers/chat_journal_controller.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/providers/mood_state_provider.dart';
import 'package:app/providers/prompts_providers.dart';
import 'package:app/providers/selected_journal_entry_provider.dart';
import 'package:app/views/journal/journal_entry_view.dart';
import 'package:app/views/journal/mood_check_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReflectionDialog extends ConsumerWidget {
  final String challengeName;
  const ReflectionDialog({required this.challengeName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: this is not so nice but prevents the chatJournalController from calling an unmounted version
    ref.watch(chatJournalControllerProvider);

    final chatJournalController = ref.read(chatJournalControllerProvider);
    final journalController = ref.read(journalControllerProvider.notifier);
    final selectedJournalEntryController = ref.read(selectedJournalEntryProvider.notifier);
    final moodStateController = ref.read(moodStateProvider.notifier);

    return AlertDialog(
      title: Text("Reflect on $challengeName"),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MoodCheckWidget(
          onContinue: () async {
            selectedJournalEntryController.state = const AsyncLoading();
            final journalEntry = await journalController.addJournalEntry(ChatJournalEntryObj(
              name: 'Reflection on $challengeName',
              date: DateTime.now(),
            ));
            selectedJournalEntryController.state = AsyncData(journalEntry);
          },
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            moodStateController.state = null;
          },
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: () {
            // Perform the desired actions on button press
            chatJournalController.onChatJournalEntryCreated(type: ChatJournalType.reflection);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const JournalEntryView()),
            );
          },
          child: const Text('Reflect more'),
        ),
      ],
    );
  }
}
