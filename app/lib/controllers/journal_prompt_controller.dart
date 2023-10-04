import 'package:app/models/chat_message.dart';
import 'package:app/providers/prompts_providers.dart';
import 'package:app/repositories/ai_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final journalPromptControllerProvider = StateNotifierProvider<JournalPromptController, AsyncValue<ChatMessageObj?>>((ref) {
  final aiRepository = ref.watch(aiRepositoryProvider);
  final prompts = ref.watch(generalPromptsProvider);

  return JournalPromptController(
    aiRepository,
    prompts
  );
});

// Create a StateNotifier that manages the state
class JournalPromptController extends StateNotifier<AsyncValue<ChatMessageObj?>> {
  BaseAIRepository repository;
  Map<GeneralPrompts, String> prompts;

  JournalPromptController(this.repository, this.prompts) : super(const AsyncValue.data(null));

  void reset() {
    state = const AsyncValue.data(null);
  }

  Future<void> reload() async {
    state = const AsyncValue.loading();
    await _loadJournalingPrompt();
  }

  Future<void> _loadJournalingPrompt() async {
    try {
      final result = await repository.respondToMessage(_createAIPrompt());
      final processed = _postProcessPrompt(result);
      state = AsyncValue.data(processed);
    } catch (error, st) {
      state = AsyncValue.error(error, st);
    }
  }

  ChatMessageObj _createAIPrompt() {
    return ChatMessageObj.user(
      date: DateTime.now(),
      content: prompts[GeneralPrompts.journalingPrompt]!,
    );
  }

  ChatMessageObj _postProcessPrompt(ChatMessageObj msg) {
    final content = msg.content.trim();
    if (content.startsWith("\"") && content.endsWith("\"")) {
      final newContent = content.substring(1, content.length - 1);
      return msg.copyWith(
        content: newContent,
      );
    } else {
      return msg;
    }
  }
}
