import 'package:app/controllers/journal_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/providers/selected_journal_entry_provider.dart';
import 'package:app/repositories/chat_history_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatJournalView extends ConsumerWidget {
  final JournalEntryObj journalEntry;

  const ChatJournalView({ required this.journalEntry, super.key });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatController = ref.watch(chatHistoryRepositoryProvider);

    return const Text('Journal Entry');
  }
}
