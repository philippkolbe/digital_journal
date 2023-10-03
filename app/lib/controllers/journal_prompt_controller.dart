import 'package:app/models/chat_message.dart';
import 'package:app/repositories/ai_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final journalPromptControllerProvider = StateNotifierProvider<JournalPromptController, AsyncValue<ChatMessageObj?>>((ref) {
  final aiRepository = ref.watch(aiRepositoryProvider);

  return JournalPromptController(
    aiRepository
  );
});

// Create a StateNotifier that manages the state
class JournalPromptController extends StateNotifier<AsyncValue<ChatMessageObj?>> {
  BaseAIRepository repository;
  JournalPromptController(this.repository) : super(const AsyncValue.data(null));

  void reset() {
    state = const AsyncValue.data(null);
  }

  Future<void> reload() async {
    state = const AsyncValue.loading();
    await _loadJournalingPrompt();
  }

  Future<void> _loadJournalingPrompt() async {
    try {
      final result = await repository.respondToMessage(_createAIPromptMessage());
      final processed = _postProcessPrompt(result);
      state = AsyncValue.data(processed);
    } catch (error, st) {
      state = AsyncValue.error(error, st);
    }
  }

  ChatMessageObj _createAIPromptMessage() {
    return ChatMessageObj.user(
      date: DateTime.now(),
      content: _createAIPrompt(),
    );
  }

  String _createAIPrompt() {
    return 'Write a journaling prompt.';
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
