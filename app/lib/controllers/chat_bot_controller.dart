import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/services/ai_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatBotControllerProvider = StateNotifierProvider<ChatBotController, AsyncValue<ChatMessageObj?>>((ref) {
  final authState = ref.watch(authControllerProvider);
  final aiRepository = ref.read(aiServiceProvider);

  return ChatBotController(
    authState.valueOrNull?.currentUser.id,
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
  final BaseAIService _aiRepository;

  ChatBotController(
    this._userId,
    this._aiRepository,
  ) : super(const AsyncData(null));

  // TODO: Don't use AsyncValues here I think
  Future<AsyncValue<ChatMessageObj>> writeBotResponse(List<AsyncValue<ChatMessageObj>>? chatHistory) async {
    state = const AsyncLoading();

    try {
      assert(_userId != null, 'User must be authenticated to chat with bot.');

      final chatMessages = (chatHistory
        ?.map((value) => value.valueOrNull)
        .whereType<ChatMessageObj>()
        .toList()
        .reversed
        .toList() ?? []);

      final botResponse = await _aiRepository.respondToChat(chatMessages);
      final asyncData = AsyncData(botResponse);

      state = asyncData;
      return asyncData;
    } catch (e, st) {
      final asyncError = AsyncError<ChatMessageObj>(e, st);
      state = asyncError;
      return asyncError;
    }
  }
}