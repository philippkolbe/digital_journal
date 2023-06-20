import 'package:app/common/utils.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/providers/selected_journal_entry_provider.dart';
import 'package:app/repositories/chat_history_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatControllerProvider = StateNotifierProvider<ChatController, AsyncValue<ChatState?>>((ref) {
  final selectedJournalEntry = ref.watch(selectedJournalEntryProvider);
  final authState = ref.watch(authControllerProvider);
  final chatHistoryRepository = ref.read(chatHistoryRepositoryProvider);

  return ChatController(
    authState.valueOrNull?.currentUser.id,
    selectedJournalEntry,
    chatHistoryRepository,
  );
});

typedef ChatState = List<AsyncValue<ChatMessageObj>>;

class ChatController extends StateNotifier<AsyncValue<ChatState?>> {
  final String? _userId;
  final AsyncValue<JournalEntryObj?> _asyncSelectedJournalEntry;
  final BaseChatHistoryRepository _chatHistoryRepository;

  ChatController(
    this._userId,
    this._asyncSelectedJournalEntry,
    this._chatHistoryRepository,
  ) : super(const AsyncData(null)) {
    if (_userId != null) {
      state = _initState();
    }
  }

  Future<void> writeUserChatMessage(String content) async {
    final chatMessageObj = createUserChatMessage(content);

    await writeChatMessage(chatMessageObj);
  }

  ChatMessageObj createUserChatMessage(String content) {
    return createChatMessage(content, false);
  }

  ChatMessageObj createBotChatMessage(String content) {
    return createChatMessage(content, true);
  }

  ChatMessageObj createChatMessage(String content, bool isFromBot) {
    return ChatMessageObj(
      id: generateUuid(),
      isFromBot: isFromBot,
      date: DateTime.now(),
      content: content,
    );
  }

  Future<void> writeBotChatMessage(AsyncValue<ChatMessageObj> asyncChatMessageObj) async {
    final indexOfLoadingMessage = _findLoadingMessageIndex();
    if (asyncChatMessageObj is AsyncData) {
      final chatMessageObj = asyncChatMessageObj.value!.copyWith(
        id: generateUuid(),
      );

      assert(chatMessageObj.isFromBot, "Can only write Bot Chat Messages that were written from a bot.");

      await writeChatMessage(chatMessageObj, replaceAt: indexOfLoadingMessage);
    } else {
      state = _addOrReplaceChatMessageInState(asyncChatMessageObj, replaceAt: indexOfLoadingMessage);
    }
  }

  AsyncValue<ChatMessageObj>? addLoadingBotChatMessage() {
    if (state is AsyncData) {
      ChatState history = state.value!;
      const loading = AsyncValue<ChatMessageObj>.loading();
      state = _addChatMessageInState(history, loading);

      return loading;
    } else {
      return null;
    }
  }

  AsyncValue<ChatState?> _initState() {
    return _asyncSelectedJournalEntry.when<AsyncValue<ChatState?>>(
      data: (selectedJournalEntry) {
        if (selectedJournalEntry is ChatJournalEntryObj) {
          return _loadChatHistory(selectedJournalEntry);
        } else {
          return const AsyncData(null);
        }
      },
      error: (err, st) => AsyncError(err, st),
      loading: () => const AsyncLoading(),
    );
  }

  AsyncValue<ChatState> _loadChatHistory(JournalEntryObj journalEntry) {
    try {
      assert(_userId != null, 'User must be authenticated to load their chat history');
      assert(journalEntry.id != null, 'Journal Entries must have an id to load their chat history');

      _readAndSetChatHistoryState(_userId!, journalEntry.id!);

      return const AsyncLoading();
    } catch (err, st) {
      return AsyncError(err, st);
    }
  }

  Future<ChatState> _readAndSetChatHistoryState(String userId, String journalEntryId) async {
    final chatHistory = await _chatHistoryRepository.readChatHistory(userId, journalEntryId);

    final chatState = chatHistory.map((message) => AsyncData(message)).toList();
    state = AsyncData(chatState);

    return chatState;
  }

  int _findLoadingMessageIndex() {
    return state.valueOrNull?.lastIndexWhere((message) => message is AsyncLoading) ?? -1;
  }

  Future<void> writeChatMessage(ChatMessageObj chatMessageObj, { int replaceAt = -1 }) async {
    state = _addOrReplaceChatMessageInState(AsyncData(chatMessageObj), replaceAt: replaceAt);

    try {
      await _createChatMessage(chatMessageObj);
    } catch (err, st) {
      state = AsyncData(
        state.value!.map(
          (asyncMessage) => asyncMessage.valueOrNull == chatMessageObj
            ? AsyncError<ChatMessageObj>(err, st)
            : asyncMessage
        ).toList()
      );
    }
  }

  AsyncValue<ChatState> _addOrReplaceChatMessageInState(AsyncValue<ChatMessageObj> chatMessage, { int replaceAt = -1}) {
    assert(state is AsyncData, 'Chat history state must be loaded to write chat messages');
    ChatState history = state.value!;

    if (replaceAt == -1) {
      return _addChatMessageInState(history, chatMessage);
    } else {
      final messageToReplace = history[replaceAt];
      return AsyncData(
        history.map(
          (asyncMessage) => asyncMessage == messageToReplace
            ? chatMessage
            : asyncMessage
        ).toList(),
      );
    }
  }

  AsyncValue<ChatState> _addChatMessageInState(ChatState history, AsyncValue<ChatMessageObj> chatMessage) {
    return AsyncData([chatMessage, ...history]);
  }

  Future<ChatMessageObj> _createChatMessage(ChatMessageObj chatMessageObj) async {
    assert(_userId != null, 'User must be authenticated to write chat messages.');
    final journalEntryId = _asyncSelectedJournalEntry.valueOrNull?.id;
    assert(journalEntryId != null, 'Journal Entries must be loaded and have an id to write chat messages.');


    return _chatHistoryRepository.createChatMessage(_userId!, journalEntryId!, chatMessageObj);
  }

}
