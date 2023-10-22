import 'package:app/common/async_widget.dart';
import 'package:app/controllers/attributes_controller.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/controllers/journal_prompt_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/views/create/challenge_discovery_wizard.dart';
import 'package:app/views/create/journal_conversation_wizard.dart';
import 'package:app/views/create/mood_chat_journal_wizard.dart';
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
    // We need to wait for the attributes so the prompts can be loaded properly
    final asyncAttributesState = ref.watch(attributesProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AsyncWidget(asyncValue: asyncAttributesState, buildWidget: (attributesState) => Column(
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
            onPressed: _onCreateMoodCheckJournalEntry,
            child: const Text('Mood Check'),
          ),
          ElevatedButton(
            onPressed: _onCreateJournalConversation,
            child: const Text('Journal Conversation'),
          ),
          ElevatedButton(
            onPressed: _onCreateJournalPrompt,
            child: const Text('Journal Prompt'),
          ),
        ],
      )),
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

  void _onCreateMoodCheckJournalEntry() {
    widget.hideSelf();
    widget.setSelectedPage(2);

    _onAddJournalEntry((context) => const MoodChatJournalWizard(), 'Mood Check');
  }

  void _onCreateJournalConversation() {
    widget.hideSelf();
    widget.setSelectedPage(2);

    _onAddJournalEntry((context) => const JournalConversationWizard(), 'Journal Conversation');
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
      final journalController = ref.read(journalEntriesProvider.notifier);

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
