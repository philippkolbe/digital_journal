import 'package:app/agents/summary_agent.dart';
import 'package:app/common/async_widget.dart';
import 'package:app/common/chat_widget.dart';
import 'package:app/common/loading_widget.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/chat_journal_controller.dart';
import 'package:app/controllers/chat_controller.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/models/summary.dart';
import 'package:app/providers/selected_journal_entry_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatJournalView extends ConsumerWidget {
  final JournalEntryObj journalEntry;
  final void Function() onClose;

  const ChatJournalView({
    required this.journalEntry,
    required this.onClose,
    super.key
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatJournalController = ref.watch(chatJournalControllerProvider);
    final asyncChatState = ref.watch(chatControllerProvider);
    final authState = ref.watch(authControllerProvider);

    _handleSummary(ref);

    return AsyncWidget(
      asyncValue: asyncChatState,
      buildWidget: (chatState) {
        if (chatState == null) {
          return const LoadingWidget();
        }
        // TODO: maybe put this into a merged AsyncWidget/Value but this should always be loaded when the user sees this page
        assert(authState is AsyncData);
        final userObj = authState.value!.currentUser;
        return ChatWidget(
          user: userObj,
          onMessageAdded: (String content) async {
            await chatJournalController.onChatJournalMessageSent(content);
          },
          messages: chatState.chat,
        );
      },
      onRetryAfterError: () => onClose(),
    );
  }

  // TODO: Is this the right spot for it?
  void _handleSummary(WidgetRef ref) {
    final selectedJournalEntry = ref.watch(selectedJournalEntryProvider).valueOrNull;

    // First we listen to the chat to let the agent summarize it
    _listenToChatToSummarize(ref, selectedJournalEntry);

    // Then we listen to the summary to update it in our journal entry
    _listenToUpdateJournalEntrySummary(ref, selectedJournalEntry);
    // We also listen to the summary to analyze it
    //...
  }

  void _listenToChatToSummarize(WidgetRef ref, JournalEntryObj? selectedJournalEntry) {
    final summaryAgent = ref.watch(summaryAgentProvider);

    ref.listen(chatControllerProvider, (_, asyncChatState) async {
      final chatState = asyncChatState.valueOrNull;
      // First thing: We set flag back to false because we are handling this request now!
      if (chatState != null && chatState!.wasModifiedByUser) {
        final chatController = ref.read(chatControllerProvider.notifier);
        chatController.setModifiedByUser(journalEntry, false);
      }

      // Now we do the actual summary. In here the correct update of the summaryProvider is happening 
      await summaryAgent.summarize(
        selectedJournalEntry,
        chatState,
      );
    });
  }

  void _listenToUpdateJournalEntrySummary(WidgetRef ref, JournalEntryObj? selectedJournalEntry) {
    ref.listen(summaryProvider, (prev, next) async {
      final journalController = ref.read(journalControllerProvider.notifier);
      _updateSummaryInJournalEntry(
        journalController,
        selectedJournalEntry,
        prev?.valueOrNull,
        next.valueOrNull,
      );
    });
  }

  void _updateSummaryInJournalEntry(
    JournalController journalController,
    JournalEntryObj? journalEntry,
    SummaryObj? prevSummary,
    SummaryObj? summary,
  ) async {
    if (journalEntry != null && _hasSummaryChanged(prevSummary, summary, journalEntry)) {
      final updatedJournalEntry = journalEntry.copyWith(
        summary: summary,
      );

      await journalController.updateJournalEntry(updatedJournalEntry);
    }
  }

  bool _hasSummaryChanged(SummaryObj? prevSummary, SummaryObj? summary, JournalEntryObj? journalEntry) {
    return (
      summary != null &&
      summary != prevSummary &&
      (prevSummary == null || summary.date.isAfter(prevSummary.date))
    );
  }
}
