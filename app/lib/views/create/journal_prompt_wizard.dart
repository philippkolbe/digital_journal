import 'package:app/common/async_widget.dart';
import 'package:app/controllers/chat_journal_controller.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/controllers/journal_prompt_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/providers/selected_journal_entry_provider.dart';
import 'package:app/views/journal/journal_entry_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JournalPromptWizard extends ConsumerWidget {
  const JournalPromptWizard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedJournalEntryController = ref.read(selectedJournalEntryProvider.notifier);
    final journalController = ref.read(journalControllerProvider.notifier);
    final journalPromptController = ref.read(journalPromptControllerProvider.notifier);
    final chatJournalController = ref.watch(chatJournalControllerProvider);
    final asyncSelectedJournalEntry = ref.watch(selectedJournalEntryProvider);
    final journalPrompt = ref.watch(journalPromptControllerProvider);

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

              _closeView(
                context,
                selectedJournalEntryController,
                journalPromptController,
              );
            },
          ),
          title: const Text("Journal Prompt"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
          child: Center(
            child: selectedJournalEntry != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPrompt(journalPrompt, journalPromptController),
                    const SizedBox(height: 30),
                    if (journalPrompt.valueOrNull != null)
                      _buildStartJournalingButton(
                        context,
                        ref,
                        chatJournalController,
                        journalPrompt,
                      ),
                  ],
                )
              : const Text("Something went wrong."),
          )
        ),
      ),
    );
  }

  Widget _buildPrompt(AsyncValue<ChatMessageObj?> prompt, JournalPromptController journalPromptController) {
    return AsyncWidget(
      asyncValue: prompt,
      buildWidget: (prompt) => Row(
        children: [
          Expanded(child: Text(prompt?.content ?? 'Something went wrong. Please try again.', textScaleFactor: 1.2,)),
          const SizedBox(width: 10),
          _buildRefreshButton(journalPromptController),
        ],
      ),
      buildErrorWidget: (err, st) => Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Something went wrong. Please try again.', textScaleFactor: 1.2),
                Text(err.toString(), softWrap: true),  
              ]
            ),
          ),
          const SizedBox(width: 10),
          _buildRefreshButton(journalPromptController),
        ],
      ),
    );
  }

  Widget _buildRefreshButton(JournalPromptController journalPromptController) {
    return IconButton(
      onPressed: () => journalPromptController.reload(),
      icon: const Icon(Icons.replay),
    );
  }

  Widget _buildStartJournalingButton(
    BuildContext context,
    WidgetRef ref,
    ChatJournalController chatJournalController,
    AsyncValue<ChatMessageObj?> journalPrompt,
  ) {
    return ElevatedButton(
      onPressed: () => _onPromptAccepted(
        ref,
        context,
        chatJournalController,
        journalPrompt,
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min, // Adjust the button width based on the content
        children: [
          Icon(Icons.arrow_forward),
          SizedBox(width: 8.0),
          Text("Start Journaling"),
        ],
      ),
    );
  }

  void _onPromptAccepted(
    WidgetRef ref,
    BuildContext context,
    ChatJournalController chatJournalController,
    AsyncValue<ChatMessageObj?> journalPrompt,
  ) {
    if (journalPrompt.valueOrNull != null) {
      final convertedPrompt = AsyncData<ChatMessageObj>(journalPrompt.value!);
      chatJournalController.writeAssistantChatMessage(convertedPrompt);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const JournalEntryView()),
    );
  }

  void _closeView(
    BuildContext context,
    StateController<AsyncValue<JournalEntryObj?>> selectedJournalEntryController,
    JournalPromptController journalPromptController,
  ) {
    Navigator.pop(context);
    selectedJournalEntryController.state = const AsyncData(null);
    journalPromptController.reset();;
  }
}