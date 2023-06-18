import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/chat_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/providers/selected_journal_entry_provider.dart';
import 'package:app/repositories/ai_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatBotControllerProvider = StateNotifierProvider<ChatBotController, AsyncValue<String?>>((ref) {
  final selectedJournalEntry = ref.watch(selectedJournalEntryProvider);
  final authState = ref.watch(authControllerProvider);
  final chatHistory = ref.watch(chatControllerProvider);
  final chatController = ref.read(chatControllerProvider.notifier);
  final aiRepository = ref.read(aiRepositoryProvider);

  return ChatBotController(
    authState.valueOrNull?.currentUser.id,
    selectedJournalEntry,
    chatHistory.valueOrNull,
    chatController,
    aiRepository,
  );
});

class ChatBotController extends StateNotifier<AsyncValue<String?>> {
  final String? _userId;
  final AsyncValue<JournalEntryObj?> _asyncSelectedJournalEntry;
  final List<AsyncValue<ChatMessageObj>>? _chatHistory;
  final ChatController _chatController;
  final BaseAIRepository _aiRepository;

  ChatBotController(
    this._userId,
    this._asyncSelectedJournalEntry,
    this._chatHistory,
    this._chatController,
    this._aiRepository,
  ) : super(const AsyncData(null));

  Future<void> writeBotResponse() async {
    
  }
}