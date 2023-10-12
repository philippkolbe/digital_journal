import 'package:app/agents/values_agent.dart';
import 'package:app/controllers/attributes_controller.dart';
import 'package:app/controllers/chat_controller.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/controllers/summary_controller.dart';
import 'package:app/models/attributes_action.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void initializeSummaryUpdateObserver(WidgetRef ref) {
  final journalController = ref.read(journalEntriesProvider.notifier);

  ref.listen(summaryProvider, (_, asyncSummaryObj) {
    final summaryObj = asyncSummaryObj.valueOrNull;
    final selectedJournalEntry = ref.read(selectedJournalEntryProvider).valueOrNull;
  
    if (summaryObj != null && selectedJournalEntry != null) {
      journalController.updateJournalEntry(
        selectedJournalEntry.copyWith(
          summary: asyncSummaryObj.valueOrNull,
        ),
      );
    }
  });
}

void initializeChatSummaryObserver(WidgetRef ref) {
  final summaryController = ref.watch(summaryControllerProvider);
  ref.listen<AsyncValue<ChatState?>>(chatControllerProvider, (prev, next) => summaryController.onChatStateUpdated(prev, next, ref.read(selectedJournalEntryProvider).valueOrNull));
}

void initializeAttributesAgentsObserver(WidgetRef ref) {
  final attributesController = ref.watch(attributesProvider.notifier);
  final attributes = ref.watch(attributesProvider);
  // We need to wait until the attributes are properly loaded before starting to update them
  if (attributes.valueOrNull != null) {
    ref.listen(attributesActionsProvider, (previous, asyncAttributesActions) {
      final attributesActions = asyncAttributesActions.valueOrNull;
      if (asyncAttributesActions is AsyncData<List<AttributesActionObj>> && attributesActions != null && attributesActions.isNotEmpty) {
        // TODO: Add information agent + controller
        // TODO: Add agent that looks at all attributes and reduces/combines them
        // TODO: Add attributes to journal conversation
        attributesController.applyAttributesActions(attributesActions);
      }
    });
  }
}