import 'package:app/common/async_widget.dart';
import 'package:app/common/chat_widget.dart';
import 'package:app/common/loading_widget.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/chat_journal_controller.dart';
import 'package:app/controllers/chat_controller.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/providers/selected_journal_entry_provider.dart';
import 'package:app/providers/summary_provider.dart';
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
    final manager = ScaffoldMessenger.of(context);
    print("build");
    final summary = ref.watch(summaryProvider);
    ref.listen(summaryProvider, (prev, next) async {
      final prevSummary = prev?.valueOrNull;
      final summary = next.valueOrNull;
      final journalEntry = ref.read(selectedJournalEntryProvider).valueOrNull;
      if (summary != prevSummary && summary != null && journalEntry != null && (prevSummary == null || summary.date.isAfter(prevSummary.date))) {
        print("SUMMARY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!i");
        await ref.read(journalControllerProvider.notifier).updateJournalEntry(journalEntry.copyWith(
          summary: summary
        ));
        print("${DateTime.now().toString()}: Summary saved");
        ref.read(chatControllerProvider.notifier).setModifiedByUser(journalEntry, false);
        manager.showSnackBar(SnackBar(
          content: Text(summary.content),
          duration: const Duration(seconds: 4),
        ));
      } else {
        print("No summary: ${summary != prevSummary} && ${summary != null} && ${journalEntry != null} && ${prevSummary == null || summary != null && summary.date.isAfter(prevSummary.date)}");
      }
    });
    
    final chatJournalController = ref.watch(chatJournalControllerProvider);
    final asyncChatState = ref.watch(chatControllerProvider);
    final authState = ref.watch(authControllerProvider);

    return AsyncWidget(
      asyncValue: asyncChatState,
      buildWidget: (chatState) {
        if (chatState == null) {
          return const LoadingWidget();
        }
        // TODO: maybe put this into a merged AsyncWidget/Value but this should always be loaded when the user sees this page
        assert(authState is AsyncData);
        final userObj = authState.value!.currentUser;
        return Column(children: [Text(summary.valueOrNull?.date.toLocal().toIso8601String() ?? 'None'), Expanded(child: ChatWidget(
          user: userObj,
          onMessageAdded: (String content) async {
            await chatJournalController.onChatJournalMessageSent(content);
          },
          messages: chatState.chat,
        ))]);
      },
      onRetryAfterError: () => onClose(),
    );
  }
}
