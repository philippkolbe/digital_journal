import 'package:app/controllers/attributes_controller.dart';
import 'package:app/models/attribute.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/services/ai_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final journalPromptControllerProvider = StateNotifierProvider<JournalPromptController, AsyncValue<ChatMessageObj?>>((ref) {
  final aiRepository = ref.watch(aiServiceProvider);
  final attributes = ref.watch(attributesProvider);

  return JournalPromptController(
    aiRepository,
    attributes.valueOrNull,
  );
});

// Create a StateNotifier that manages the state
class JournalPromptController extends StateNotifier<AsyncValue<ChatMessageObj?>> {
  final BaseAIService _aiService;
  final AttributesState? _attributesState;

  JournalPromptController(this._aiService, this._attributesState) : super(const AsyncData(null));

  void reset() {
    state = const AsyncValue.data(null);
  }

  Future<void> reload() async {
    final oldState = state;
    state = const AsyncValue.loading();
    await _loadJournalingPrompt(oldState.valueOrNull);
  }

  Future<void> _loadJournalingPrompt(ChatMessageObj? lastJournalingPrompt) async {
    try {
      final result = await _aiService.respondToMessage(_createAIPrompt(lastJournalingPrompt));
      final processed = _postProcessPrompt(result);
      if (mounted) {
        state = AsyncValue.data(processed);
      }
    } catch (error, st) {
      state = AsyncValue.error(error, st);
    }
  }

  ChatMessageObj _createAIPrompt(ChatMessageObj? lastJournalingPrompt) {
    return ChatMessageObj.user(
      date: DateTime.now(),
      content: _getPrompt(lastJournalingPrompt?.content),
    );
  }

  String _getPrompt(String? lastPrompt) {
    final currentDate = DateTime.now().toLocal();
    return '''You are a journaling prompt generator in a journaling app. It is ${currentDate.day}.${currentDate.month}.${currentDate.year} ${currentDate.hour}:${currentDate.minute}.
${lastPrompt != null ? 'The last prompt the user journaled about was "$lastPrompt" so choose a prompt focusing on a different topic' : ''}. 
${_createAttributesInfo()}
You may use this information but you can also come up with completely new prompts. Consider that the information has been found through similar prompts and the user does not want to answer the same prompts all the time.
Suggest a journaling prompt that helps you find out more information about the user.''';
  }

  String _createAttributesInfo() {
    if (_attributesState == null) {
      return "";
    }

    final attributesStrings = [
      _createAttributeInfo(AttributeType.like, 'Likes'),
      _createAttributeInfo(AttributeType.dislike, 'Dislikes'),
      _createAttributeInfo(AttributeType.fear, 'Values'),
      _createAttributeInfo(AttributeType.fear, 'Fears'),
      _createAttributeInfo(AttributeType.goal, 'Goals'),
    ]..shuffle();

    return '''I will give you some information about the user. The numbers in brackets represent the importance/level of the info where 10 means most important:
    ${attributesStrings.join("\n")}''';
  }

  String _createAttributeInfo(AttributeType type, String name) {
    final attributes = _attributesState!.groupedByType[type]!;

    if (attributes.isEmpty) {
      return '';
    }

    final shuffledList = attributes
      .map((attr) => '${attr.description} (${attr.level})')
      .toList()
      ..shuffle();

    return '$name: ${shuffledList.join(", ")}';
  }

  ChatMessageObj _postProcessPrompt(ChatMessageObj msg) {
    var content = msg.content.trim();
    if (content.startsWith("\"") && content.endsWith("\"")) {
      content = content.substring(1, content.length - 1);
    }

    if (content.startsWith("Prompt: ")) {
      content = content.substring(9);
    } else if (content.startsWith("Journaling Prompt: ")) {
      content = content.substring(20);
    }

    if (content.startsWith("\"") && content.endsWith("\"")) {
      content = content.substring(1, content.length - 1);
    }

    return msg.copyWith(
      content: content,
    );
  }
}
