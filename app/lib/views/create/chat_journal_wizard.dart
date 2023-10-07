import 'package:app/common/async_widget.dart';
import 'package:app/controllers/chat_journal_controller.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/providers/mood_state_provider.dart';
import 'package:app/providers/selected_journal_entry_provider.dart';
import 'package:app/views/journal/journal_entry_view.dart';
import 'package:app/views/common/mood_check_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatJournalWizard extends ConsumerStatefulWidget {
  const ChatJournalWizard({Key? key}) : super(key: key);

  @override
  ChatJournalWizardState createState() => ChatJournalWizardState();
}

class ChatJournalWizardState extends ConsumerState<ChatJournalWizard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedJournalEntryController = ref.read(selectedJournalEntryProvider.notifier);
    final journalController = ref.read(journalEntriesProvider.notifier);
    final moodStateController = ref.read(moodStateProvider.notifier);
    final chatJournalController = ref.watch(chatJournalControllerProvider);
    final asyncSelectedJournalEntry = ref.watch(selectedJournalEntryProvider);
    final selectedMood = ref.watch(moodStateProvider);

    if (selectedMood != null && !_animationController.isAnimating) {
      _animationController.animateTo(1);
    }

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
                selectedJournalEntryController,
                moodStateController,
              );
            },
          ),
          title: const Text("Journal Entry"),
        ),
        body: Center(
          child: selectedJournalEntry != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MoodCheckWidget(),
                    const SizedBox(height: 30),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _animation.value,
                          child: child,
                        );
                      },
                      child: _buildStartJournalingButton(ref, chatJournalController) ,
                    ),
                  ],
                )
              : const Text("Something went wrong."),
        ),
      ),
    );
  }

  Widget _buildStartJournalingButton(
    WidgetRef ref,
    ChatJournalController chatJournalController,
  ) {
    return ElevatedButton(
      onPressed: () => _onMoodCheckCompleted(
        ref,
        context,
        chatJournalController,
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

  void _onMoodCheckCompleted(
    WidgetRef ref,
    BuildContext context,
    ChatJournalController chatJournalController,
  ) {
    chatJournalController.onChatJournalEntryCreated();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const JournalEntryView()),
    );
  }

  void _closeJournalEntryView(
    BuildContext context,
    StateController<AsyncValue<JournalEntryObj?>> selectedJournalEntryController,
    StateController<Mood?> moodStateController,
  ) {
    Navigator.pop(context);
    selectedJournalEntryController.state = const AsyncData(null);
    moodStateController.state = null;
  }
}
