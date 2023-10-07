import 'package:app/mocks/data/firebase_test_data.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/services/ai_service.dart';

class MockAIService implements BaseAIService {
  ChatMessageObj mockBotResponse = testChatBotMessageObj;
  Exception? mockBotException;
  
  @override
  Future<ChatMessageObj> respondToMessage(ChatMessageObj chatMessageObj) {
    return respondToChat([chatMessageObj]);
  }

  @override
  Future<ChatMessageObj> respondToChat(List<ChatMessageObj> history) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (mockBotException == null) {
      return Future.value(mockBotResponse);
    } else {
      return Future.error(mockBotException!);
    }
  }
}
