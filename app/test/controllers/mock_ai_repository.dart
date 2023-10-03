import 'package:app/models/chat_message.dart';
import 'package:app/repositories/ai_repository.dart';

import '../repositories/firebase_test_data.dart';

class MockAIRepository implements BaseAIRepository {
  ChatMessageObj mockBotResponse = testChatMessageObj;
  Exception? mockBotException;
  
  @override
  Future<ChatMessageObj> respondToMessage(ChatMessageObj chatMessageObj) {
    return respondToChat([chatMessageObj]);
  }

  @override
  Future<ChatMessageObj> respondToChat(List<ChatMessageObj> history) {
    if (mockBotException == null) {
      return Future.value(mockBotResponse);
    } else {
      return Future.error(mockBotException!);
    }
  }
}
