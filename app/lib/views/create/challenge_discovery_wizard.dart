import 'package:app/common/async_widget.dart';
import 'package:app/controllers/chat_journal_controller.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/providers/prompts_providers.dart';
import 'package:app/views/journal/journal_entry_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChallengeDiscoveryWizard extends ConsumerStatefulWidget {
  const ChallengeDiscoveryWizard({Key? key}) : super(key: key);

  @override
  ChallengeDiscoveryWizardState createState() => ChallengeDiscoveryWizardState();
}

class ChallengeDiscoveryWizardState extends ConsumerState<ChallengeDiscoveryWizard> with SingleTickerProviderStateMixin {
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
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncSelectedJournalEntry = ref.watch(selectedJournalEntryProvider);
    final journalController = ref.watch(journalEntriesProvider.notifier);
    final selectedJournalEntryController = ref.watch(selectedJournalEntryProvider.notifier);
    final chatJournalController = ref.watch(chatJournalControllerProvider);

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
                );
              },
          ),
          title: const Text("Challenge Discovery"),
        ),
        body: Center(
          child: selectedJournalEntry != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Challenge Discovery is a process that helps you identify challenges, set goals, and track your progress. It's a great way to improve your habits and achieve your targets! We will help you create a SMART goal that is Specific Measurable Achievable Relevant and Time-constrained.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 30),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _animation.value,
                          child: child,
                        );
                      },
                      child: ElevatedButton(
                        onPressed: () => _onStartChallengeDiscovery(chatJournalController),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_forward),
                            SizedBox(width: 8.0),
                            Text("Start Discovering Challenges"),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const Text("Something went wrong."),
        ),
      ),
    );
  }

  void _onStartChallengeDiscovery(ChatJournalController chatJournalController) {
    chatJournalController.onChatJournalEntryCreated(type: ChatJournalType.goalDiscovery);

    Navigator.pushReplacement(
      context,
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
