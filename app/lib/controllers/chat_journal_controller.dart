import 'package:app/controllers/chat_bot_controller.dart';
import 'package:app/controllers/chat_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/providers/prompts_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatJournalControllerProvider = Provider<ChatJournalController>((ref) {
  final chatHistory = ref.watch(chatControllerProvider);
  final chatController = ref.read(chatControllerProvider.notifier);
  final chatBotController = ref.read(chatBotControllerProvider.notifier);
  final goalPrompts = ref.watch(goalPromptsProvider);
  final controller = ChatJournalController(
    chatHistory.valueOrNull?.chat,
    goalPrompts,
    chatController,
    chatBotController,
  );

  return controller;
});

class ChatJournalController {
  final List<AsyncValue<ChatMessageObj>>? _chatHistory;
  final Map<ChatJournalType, String> _goalPrompts;
  
  final ChatController _chatController;
  final ChatBotController _chatBotController;


  ChatJournalController(
    List<AsyncValue<ChatMessageObj>>? chatHistory,
    this._goalPrompts,
    this._chatController,
    this._chatBotController,
  ) : _chatHistory = chatHistory != null ? List.from(chatHistory) : null;

  Future<void> onChatJournalEntryCreated({ ChatJournalType type = ChatJournalType.standard }) async {    
    if (_goalPrompts[type] != null) {
      final prompt = _goalPrompts[type]!;
      final systemMessage = _chatController.createSystemChatMessage(prompt);
      _chatController.writeChatMessage(systemMessage);

      await _addAssistantResponse([
        AsyncData(systemMessage),
      ]);
    } else {
      await _addAssistantResponse([]);
    }
  }

  Future<void> onChatJournalMessageSent(String content) async {
    final newMessageObj = _chatController.createUserChatMessage(content);
    await _chatController.writeChatMessage(newMessageObj, byUser: true);

    final chatHistoryWithNewMessage = _chatHistory?..insert(0, AsyncData(newMessageObj));    
    await _addAssistantResponse(chatHistoryWithNewMessage);
  }

  Future<void> _addAssistantResponse(List<AsyncValue<ChatMessageObj>>? chatHistory) async {
    _chatController.addLoadingAssistantChatMessage();
    final response = await _chatBotController.writeBotResponse(chatHistory);
    await writeAssistantChatMessage(response);
  }

  Future<void> writeAssistantChatMessage(AsyncValue<ChatMessageObj> message) async {
    await _chatController.writeAssistantChatMessage(message);
  }
}