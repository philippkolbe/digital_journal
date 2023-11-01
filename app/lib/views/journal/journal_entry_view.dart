import 'package:app/common/async_widget.dart';
import 'package:app/common/error_widget.dart' as error;
import 'package:app/common/loading_widget.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/models/mood.dart';
import 'package:app/providers/mood_state_provider.dart';
import 'package:app/views/journal/chat_journal_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JournalEntryView extends ConsumerWidget {

  const JournalEntryView({ super.key });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSelectedJournalEntry = ref.watch(selectedJournalEntryProvider);
    final selectedJournalEntryController = ref.watch(selectedJournalEntryProvider.notifier);
    final moodStateController = ref.watch(moodStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(asyncSelectedJournalEntry.valueOrNull?.name ?? ''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _closeJournalEntryView(
            context,
            selectedJournalEntryController,
            moodStateController,
          ),
        ),
      ),
      body: AsyncWidget(
        asyncValue: asyncSelectedJournalEntry,
        buildWidget: (selectedJournalEntry) => _buildSpecificJournalEntryView(
          context,
          selectedJournalEntryController,
          moodStateController,
          selectedJournalEntry,
        ),
        retryText: 'Back',
        onRetryAfterError: () => _closeJournalEntryView(
          context,
          selectedJournalEntryController,
          moodStateController,
        ),
      ),
    );
  }

  Widget _buildSpecificJournalEntryView(
    BuildContext context,
    StateController<AsyncValue<JournalEntryObj?>> selectedJournalEntryController,
    StateController<Mood?> moodStateController,
    JournalEntryObj? journalEntry,
  ) {
    if (journalEntry is SimpleJournalEntryObj) {
      return const Text('Simple');
    } else if (journalEntry is ChatJournalEntryObj) {
      return ChatJournalView(
        journalEntry: journalEntry,
        onClose: () => _closeJournalEntryView(context, selectedJournalEntryController, moodStateController),
      );
    } else if (journalEntry == null) {
      return const LoadingWidget();
    } else {
      return error.ErrorWidget(
        error: 'Unknown Journal Entry Type: ${journalEntry.runtimeType}',
      );
    }
  }

  void _closeJournalEntryView(
    BuildContext context,
    StateController<AsyncValue<JournalEntryObj?>> selectedJournalEntryController,
    StateController<Mood?> moodStateController,
  ) {
    Navigator.pop(context);
    selectedJournalEntryController.state = const AsyncData(null);
    // TODO: This feels wrong here but where else to reset it?
    moodStateController.state = null;
  }
}