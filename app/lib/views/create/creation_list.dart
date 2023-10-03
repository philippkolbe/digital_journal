import 'package:app/controllers/journal_controller.dart';
import 'package:app/controllers/journal_prompt_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/providers/selected_journal_entry_provider.dart';
import 'package:app/views/create/challenge_discovery_wizard.dart';
import 'package:app/views/create/chat_journal_wizard.dart';
import 'package:app/views/create/create_challenge_dialog.dart';
import 'package:app/views/create/journal_prompt_wizard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreationList extends ConsumerStatefulWidget {
  final VoidCallback hideSelf;
  final Function(int) setSelectedPage;
  
  const CreationList(this.hideSelf, this.setSelectedPage, {super.key});

  @override
  CreationListState createState() => CreationListState();
}

class CreationListState extends ConsumerState<CreationList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: _onCreateChallenge,
            child: const Text('Challenge'),
          ),
          ElevatedButton(
            onPressed: _onStartChallengeDiscovery,
            child: const Text('Challenge Discovery'),
          ),
          ElevatedButton(
            onPressed: _onCreateChatJournalEntry,
            child: const Text('Journal Conversation'),
          ),
          ElevatedButton(
            onPressed: _onCreateJournalPrompt,
            child: const Text('Journal Prompt'),
          ),
        ],
      ),
    );
  }

  void _onCreateChallenge() {
    widget.hideSelf();
    widget.setSelectedPage(1);

    showDialog(
      context: context,
      builder: (BuildContext context) => const CreateChallengeDialog(),
    );
  }

  void _onStartChallengeDiscovery() {
    widget.hideSelf();
    widget.setSelectedPage(1);

    _onAddJournalEntry((context) => const ChallengeDiscoveryWizard(), 'Challenge Discovery');
  }

  void _onCreateChatJournalEntry() {
    widget.hideSelf();
    widget.setSelectedPage(2);

    _onAddJournalEntry((context) => const ChatJournalWizard(), 'New Journal Conversation');
  }

  void _onCreateJournalPrompt() {
    widget.hideSelf();
    widget.setSelectedPage(2);
    
    final journalPromptController = ref.read(journalPromptControllerProvider.notifier);
    journalPromptController.reload();

    _onAddJournalEntry((context) => const JournalPromptWizard(), 'New Journal Entry');
  }

  void _onAddJournalEntry(Widget Function(BuildContext) buildWidget, String name) async {
    final selectedJournalEntryController = ref.read(selectedJournalEntryProvider.notifier);
    selectedJournalEntryController.state = const AsyncLoading();

    _pushChatJournalWizardRoute(buildWidget);

    try {
      final journalController = ref.read(journalControllerProvider.notifier);

      final newJournalEntryObj = await journalController.addJournalEntry(
        ChatJournalEntryObj(
          name: name,
          date: DateTime.now(),
        ),
      );

      selectedJournalEntryController.state = AsyncData(newJournalEntryObj);
    } catch (err, st) {
      selectedJournalEntryController.state = AsyncError(err, st);
    }
  }

  void _pushChatJournalWizardRoute(Widget Function(BuildContext) buildWidget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: buildWidget,
      ),
    );
  }
}
