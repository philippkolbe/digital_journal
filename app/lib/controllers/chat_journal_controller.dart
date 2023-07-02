import 'package:app/controllers/chat_bot_controller.dart';
import 'package:app/controllers/chat_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/providers/prompts_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatJournalControllerProvider = Provider<ChatJournalController>((ref) {
  final chatHistory = ref.watch(chatControllerProvider);
  final chatController = ref.read(chatControllerProvider.notifier);
  final chatBotController = ref.read(chatBotControllerProvider.notifier);
  final goalPrompts = ref.read(goalPromptsProvider);
  final controller = ChatJournalController(
    chatHistory.valueOrNull,
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
    this._chatHistory,
    this._goalPrompts,
    this._chatController,
    this._chatBotController,
  );

  Future<void> onChatJournalEntryCreated({ ChatJournalType type = ChatJournalType.standard }) async {    
    await _writeAssistantChatMessage([
      if (_goalPrompts[type] != null)
        AsyncData(AssistantChatMessageObj(
          date: DateTime.now(),
          content: _goalPrompts[type]!,
        )),
    ]);
  }

  Future<void> onChatJournalMessageSent(String content) async {
    final newMessageObj = _chatController.createUserChatMessage(content);
    _chatController.writeChatMessage(newMessageObj);

    final chatHistoryWithNewMessage = _chatHistory?..insert(0, AsyncData(newMessageObj));    
    _writeAssistantChatMessage(chatHistoryWithNewMessage);
  }

  Future<void> _writeAssistantChatMessage(List<AsyncValue<ChatMessageObj>>? chatHistory) async {
    _chatController.addLoadingAssistantChatMessage();
    final response = await _chatBotController.writeBotResponse(chatHistory);
    _chatController.writeAssistantChatMessage(response);
  }
}