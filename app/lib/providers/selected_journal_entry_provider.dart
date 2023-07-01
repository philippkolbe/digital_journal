import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/journal_entry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedJournalEntryProvider = StateProvider<AsyncValue<JournalEntryObj?>>(
  (ref) {
    ref.watch(authControllerProvider);

    return const AsyncData(null);
  }
);