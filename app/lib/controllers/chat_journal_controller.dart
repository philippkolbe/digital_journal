import 'package:app/controllers/chat_bot_controller.dart';
import 'package:app/controllers/chat_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/providers/selected_journal_entry_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatJournalControllerProvider = Provider<ChatJournalController>((ref) {
  final selectedJournalEntry = ref.watch(selectedJournalEntryProvider);
  final chatHistory = ref.watch(chatControllerProvider);
  final chatController = ref.read(chatControllerProvider.notifier);
  final chatBotController = ref.read(chatBotControllerProvider.notifier);

  final controller = ChatJournalController(
    selectedJournalEntry.valueOrNull,
    chatHistory.valueOrNull,
    chatController,
    chatBotController,
  );

  // controller.onInit();

  return controller;
});

class ChatJournalController {
  final JournalEntryObj? _selectedJournalEntry;
  final List<AsyncValue<ChatMessageObj>>? _chatHistory;
  
  final ChatController _chatController;
  final ChatBotController _chatBotController;


  ChatJournalController(
    this._selectedJournalEntry,
    this._chatHistory,
    this._chatController,
    this._chatBotController,
  );

  onInit() async {
    if (_chatHistory != null && _chatHistory!.isEmpty) {
    // TODO: This does not seem to work... Someone else has to call it to work I think
      // await onChatJournalEntryCreated();
    }
  }

  Future<void> onChatJournalEntryCreated() async {
    if (_chatHistory != null && _chatHistory!.isEmpty) {
      final prompt = AsyncData(_chatController.createBotChatMessage('Can you ask me journaling questions. Please ask them one at a time. You may ask follow-up questions.'));
      await _writeBotChatMessage([
        prompt,
      ]);
    }
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