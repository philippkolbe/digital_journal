import 'package:app/controllers/chat_bot_controller.dart';
import 'package:app/controllers/chat_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatJournalControllerProvider = Provider<ChatJournalController>((ref) {
  final chatHistory = ref.watch(chatControllerProvider);
  final chatController = ref.read(chatControllerProvider.notifier);
  final chatBotController = ref.read(chatBotControllerProvider.notifier);

  final controller = ChatJournalController(
    chatHistory.valueOrNull,
    chatController,
    chatBotController,
  );

  return controller;
});

class ChatJournalController {
  final List<AsyncValue<ChatMessageObj>>? _chatHistory;
  
  final ChatController _chatController;
  final ChatBotController _chatBotController;


  ChatJournalController(
    this._chatHistory,
    this._chatController,
    this._chatBotController,
  );

  Future<void> onChatJournalEntryCreated() async {
    // This will generate a response based on the system message
    await _writeBotChatMessage([]);
  }

  Future<void> onChatJournalMessageSent(String content) async {
    final newMessageObj = _chatController.createUserChatMessage(content);
    _chatController.writeChatMessage(newMessageObj);

    final chatHistoryWithNewMessage = _chatHistory?..insert(0, AsyncData(newMessageObj));    
    _writeBotChatMessage(chatHistoryWithNewMessage);
  }

  Future<void> _writeBotChatMessage(List<AsyncValue<ChatMessageObj>>? chatHistory) async {
    _chatController.addLoadingBotChatMessage();
    final response = await _chatBotController.writeBotResponse(chatHistory);
    _chatController.writeBotChatMessage(response);
  }
}