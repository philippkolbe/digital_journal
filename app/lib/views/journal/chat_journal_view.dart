import 'package:app/common/async_widget.dart';
import 'package:app/common/chat_widget.dart';
import 'package:app/common/loading_widget.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/chat_journal_controller.dart';
import 'package:app/controllers/chat_controller.dart';
import 'package:app/models/journal_entry.dart';
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
          messages: chatState,
        );
      },
      onRetryAfterError: () => onClose(),
    );
  }
}
