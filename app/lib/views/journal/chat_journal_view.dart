import 'package:app/controllers/summary_controller.dart';
import 'package:app/agents/values_agent.dart';
import 'package:app/common/async_widget.dart';
import 'package:app/common/chat_widget.dart';
import 'package:app/common/loading_widget.dart';
import 'package:app/controllers/attributes_controller.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/chat_journal_controller.dart';
import 'package:app/controllers/chat_controller.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/models/summary.dart';
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
  
    _handleAIAgents(ref);

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
            print("____________________________CHAT_________________________");
            await chatJournalController.onChatJournalMessageSent(content);
          },
          messages: chatState.chat,
        );
      },
      onRetryAfterError: () => onClose(),
    );
  }

  // TODO: Is this the right spot for it? Maybe one could let the "agent" act autonomously by just starting it once at the start of the app. Then it can listen on its own but listening should only be done in build... it could just be passed on
  void _handleAIAgents(WidgetRef ref) {
    // Then we listen to the summary to update it in our journal entry
    _listenToUpdateJournalEntrySummary(ref);
    
    // We also listen to the summary to analyze it
    _listenToSummaryToAnalyze(ref);
  }

  void _listenToUpdateJournalEntrySummary(WidgetRef ref) {
    final selectedJournalEntry = ref.watch(selectedJournalEntryProvider).valueOrNull;

    ref.listen(summaryProvider, (prev, next) async {
      final journalController = ref.read(journalEntriesProvider.notifier);
      await _updateSummaryInJournalEntry(
        journalController,
        selectedJournalEntry,
        prev?.valueOrNull,
        next.valueOrNull,
      );
    });
  }

  Future<void> _updateSummaryInJournalEntry(
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

  void _listenToSummaryToAnalyze(WidgetRef ref) {
    final attributesController = ref.watch(attributesControllerProvider.notifier);
    final attributes = ref.watch(attributesControllerProvider);
    // We need to wait until the attributes are properly loaded to start updating them
    if (attributes.valueOrNull != null) {
      print("ref.listen");
      ref.listen(attributesActionsProvider, (previous, asyncAttributesActions) {
        final attributesActions = asyncAttributesActions.valueOrNull;
        if (attributesActions != null && attributesActions.isNotEmpty) {
          // TODO: Its being called twice per action
          // TODO: Some tests for this applyAction stuff
          // TODO: Add information agent + controller
          // TODO: Add agent that looks at all attributes and reduces/combines them
          // TODO: Add attributes to prompt generation
          print("neew attributes");
          print(previous);
          print(asyncAttributesActions);
          attributesController.applyAttributesActions(attributesActions);
        }
      });
    }
  }
}
