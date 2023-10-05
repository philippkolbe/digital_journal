import 'package:app/models/chat_message.dart';
import 'package:app/services/ai_service.dart';

import '../repositories/firebase_test_data.dart';

class MockAIService implements BaseAIService {
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
