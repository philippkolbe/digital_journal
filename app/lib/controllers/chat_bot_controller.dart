import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/chat_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/providers/selected_journal_entry_provider.dart';
import 'package:app/repositories/ai_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatBotControllerProvider = StateNotifierProvider<ChatBotController, AsyncValue<ChatMessageObj?>>((ref) {
  final selectedJournalEntry = ref.watch(selectedJournalEntryProvider);
  final authState = ref.watch(authControllerProvider);
  final chatHistory = ref.watch(chatControllerProvider);
  final chatController = ref.read(chatControllerProvider.notifier);
  final aiRepository = ref.read(aiRepositoryProvider);

  return ChatBotController(
    authState.valueOrNull?.currentUser.id,
    selectedJournalEntry.valueOrNull,
    chatHistory.valueOrNull,
    chatController,
    aiRepository,
  );
});

/// This Controller is responsible for fetching the bot response from the AIRepository and adding it to the Chat History.
/// TODO: Think about if this should be a StateNotifier and what the state should be. Currently it is not being used.
/// An idea is that the chat view shows both the chat history and the chat bots response. Then we can implement
/// streaming the OpenAI response and showing it incrementally.
/// On the other hand, the current solution allows the user to write chat messages while the bot is responding and still showing them in the right order.
/// TODO: This should be handled correctly by waiting until one response has been finished before starting the next and including all the bots messages inbetween.
class ChatBotController extends StateNotifier<AsyncValue<ChatMessageObj?>> {
  final String? _userId;
  final JournalEntryObj? _selectedJournalEntry;
  final List<AsyncValue<ChatMessageObj>>? _chatHistory;
  final ChatController _chatController;
  final BaseAIRepository _aiRepository;

  ChatBotController(
    this._userId,
    this._selectedJournalEntry,
    this._chatHistory,
    this._chatController,
    this._aiRepository,
  ) : super(const AsyncData(null));

  Future<void> writeBotResponse() async {
    state = const AsyncLoading();
    _chatController.addLoadingBotChatMessage();

    try {
      assert(_userId != null, 'User must be authenticated to chat with bot.');

      final chatMessages = (_chatHistory
        ?.map((value) => value.valueOrNull)
        .whereType<ChatMessageObj>()
        .toList() ?? []);

      final botResponse = await _aiRepository.respondToChat(chatMessages);

      state = AsyncData(botResponse);

      await _chatController.writeBotChatMessage(botResponse);
    } catch (e, st) {
      state = AsyncError(e, st);
      _chatController.addErrorBotChatMessage(e, st);
    }
  }
}