import 'package:app/common/utils.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/journal_controller.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/repositories/chat_history_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: This is actually a chatProvider...
final chatControllerProvider = StateNotifierProvider<ChatController, AsyncValue<ChatState?>>((ref) {
  // It's enough to read the journal entry because we are being updated when the id changes (which depends on the journalEntry)
  // We don't want to watch it as summary updates etc. that neither affect the loaded state nor the selected id made this controller rebuild during usage
  // Note that this means that the selected journalEntry might not be up to date.
  final asyncSelectedJournalEntry = ref.read(selectedJournalEntryProvider);
  final selectedJournalEntryId = ref.watch(selectedJournalEntryIdProvider);
  final userId = ref.watch(userIdProvider);
  final chatHistoryRepository = ref.watch(chatHistoryRepositoryProvider);

  return ChatController(
    userId,
    selectedJournalEntryId,
    asyncSelectedJournalEntry,
    chatHistoryRepository,
  );
});

// sorted descendingly by date i.e. newest chat messages are at the front!
typedef ChatHistory = List<AsyncValue<ChatMessageObj>>;

class ChatState {
  final String? journalEntryId;
  final ChatHistory chat;
  final bool wasModifiedByUser;
  ChatState({this.journalEntryId, this.chat=const [], this.wasModifiedByUser=false});
}

class ChatController extends StateNotifier<AsyncValue<ChatState?>> {
  final String? _userId;
  final String? _selectedJournalEntryId;
  final BaseChatHistoryRepository _chatHistoryRepository;

  ChatController(
    this._userId,
    this._selectedJournalEntryId,
    asyncSelectedJournalEntry,
    this._chatHistoryRepository,
  ) : super(const AsyncData(null)) {
    if (_userId != null) {
      state = _initState(asyncSelectedJournalEntry);
    }
  }

  Future<void> writeSystemChatMessage(String content) async {
    final chatMessageObj = createSystemChatMessage(content);

    await writeChatMessage(chatMessageObj);
  }

  ChatMessageObj createSystemChatMessage(String content) {
    return SystemChatMessageObj(
      id: generateUuid(),
      date: DateTime.now(),
      content: content,
    );
  }

  Future<void> writeUserChatMessage(String content) async {
    final chatMessageObj = createUserChatMessage(content);

    await writeChatMessage(chatMessageObj, byUser: true);
  }

  ChatMessageObj createUserChatMessage(String content) {
    return UserChatMessageObj(
      id: generateUuid(),
      date: DateTime.now(),
      content: content,
    );
  }

  ChatMessageObj createAssistantChatMessage(String content) {
    return ChatMessageObj.assistant(
      id: generateUuid(),
      date: DateTime.now(),
      content: content,
    );
  }

  Future<void> writeAssistantChatMessage(AsyncValue<ChatMessageObj> asyncChatMessageObj) async {
    if (!mounted) {
      return;
    }
    final indexOfLoadingMessage = _findLoadingMessageIndex();
    if (asyncChatMessageObj is AsyncData) {
      final chatMessageObj = asyncChatMessageObj.value!.copyWith(
        id: generateUuid(),
      );

      assert(chatMessageObj is AssistantChatMessageObj, "Can only write Assistant Chat Messages that were written from assistant.");

      await writeChatMessage(chatMessageObj, replaceAt: indexOfLoadingMessage);
    } else {
      state = _addOrReplaceChatMessageInState(asyncChatMessageObj, replaceAt: indexOfLoadingMessage);
    }
  }

  AsyncValue<ChatMessageObj>? addLoadingAssistantChatMessage() {
    if (state is AsyncData && state.value != null) {
      ChatState history = state.value!;
      const loading = AsyncValue<ChatMessageObj>.loading();
      state = _addChatMessageInState(history, loading, false);

      return loading;
    } else {
      return null;
    }
  }

  void setModifiedByUser(JournalEntryObj entry, bool wasModifiedByUser) {
    if (!mounted) {
      return;
    }
    final chatState = state.valueOrNull;
    if (state is AsyncData && chatState!.journalEntryId == entry.id) {
      state = AsyncData(ChatState(
        chat: chatState.chat,
        journalEntryId: chatState.journalEntryId,
        wasModifiedByUser: wasModifiedByUser
      ));
    }
  }

  AsyncValue<ChatState?> _initState(AsyncValue<JournalEntryObj?> asyncSelectedJournalEntry) {
    return asyncSelectedJournalEntry.when<AsyncValue<ChatState?>>(
      data: (selectedJournalEntry) {
        if (selectedJournalEntry is ChatJournalEntryObj) {
          return _tryLoadingChatHistory(selectedJournalEntry);
        } else {
          return const AsyncData(null);
        }
      },
      error: (err, st) => AsyncError(err, st),
      loading: () => const AsyncLoading(),
    );
  }

  AsyncValue<ChatState> _tryLoadingChatHistory(JournalEntryObj journalEntry) {
    try {
      assert(_userId != null, 'User must be authenticated to load their chat history');
      assert(journalEntry.id != null, 'Journal Entries must have an id to load their chat history');

      _loadChatHistory(_userId!, journalEntry.id!);

      return const AsyncLoading();
    } catch (err, st) {
      return AsyncError(err, st);
    }
  }

  Future<ChatHistory> _loadChatHistory(String userId, String journalEntryId) async {
    final chatHistory = await _chatHistoryRepository.readChatHistory(userId, journalEntryId);

    final chatHistoryState = chatHistory.map((message) => AsyncData(message)).toList();
    state = _createLoadedChatState(chatHistoryState);

    return chatHistoryState;
  }

  int _findLoadingMessageIndex() {
    return state.valueOrNull?.chat.lastIndexWhere((message) => message is AsyncLoading) ?? -1;
  }

  Future<ChatMessageObj?> writeChatMessage(
    ChatMessageObj chatMessageObj,
    { int replaceAt = -1, bool byUser = false } // TODO: one could read byUser from chatMessageObj type
  ) async {
    try {
      final updatedChatMessageObj = await _createChatMessage(chatMessageObj);

      state = _addOrReplaceChatMessageInState(
        AsyncData(updatedChatMessageObj),
        replaceAt: replaceAt,
        byUser: byUser,
      );

      return updatedChatMessageObj;
    } catch (err, st) {
      if (state is AsyncData) {
        state = state.whenData((value) => _createChatState(
          value!.chat.map(
            (asyncMessage) => asyncMessage.valueOrNull == chatMessageObj
              ? AsyncError<ChatMessageObj>(err, st)
              : asyncMessage
          ).toList()),
        );
      } else {
        state = AsyncError(err, st);
      }
      
      return null;
    }
  }

  AsyncValue<ChatState> _addOrReplaceChatMessageInState(
    AsyncValue<ChatMessageObj> chatMessage,
    { int replaceAt = -1, bool byUser = false }
  ) {
    assert(state is AsyncData && state.value != null, 'Chat history state must be loaded to write chat messages');
    ChatState history = state.value!;

    if (replaceAt == -1) {
      return _addChatMessageInState(history, chatMessage, byUser);
    } else {
      final messageToReplace = history.chat[replaceAt];
      return _createLoadedChatState(
        history.chat.map(
          (asyncMessage) => asyncMessage == messageToReplace
            ? chatMessage
            : asyncMessage
        ).toList(),
        modifiedByUser: byUser
      );
    }
  }

  AsyncValue<ChatState> _addChatMessageInState(
    ChatState history,
    AsyncValue<ChatMessageObj> chatMessage,
    bool byUser
  ) {
    return _createLoadedChatState(
      [chatMessage, ...history.chat],
      modifiedByUser: byUser,
    );
  }

  AsyncValue<ChatState> _createLoadedChatState(
    ChatHistory chat,
    { bool modifiedByUser = false }
  ) {
    return AsyncData(_createChatState(chat, modifiedByUser: modifiedByUser));
  }

  ChatState _createChatState(ChatHistory chat, { bool modifiedByUser = false }) {
    return ChatState(
      journalEntryId: _selectedJournalEntryId,
      chat: chat,
      wasModifiedByUser: modifiedByUser,
    );
  }

  Future<ChatMessageObj> _createChatMessage(ChatMessageObj chatMessageObj) async {
    assert(_userId != null, 'User must be authenticated to write chat messages.');
    assert(_selectedJournalEntryId != null, 'Journal Entries must be loaded and have an id to write chat messages.');

    return _chatHistoryRepository.createChatMessage(_userId!, _selectedJournalEntryId!, chatMessageObj);
  }
}
