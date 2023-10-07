import 'package:app/mocks/data/firebase_test_data.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/services/ai_service.dart';

class MockAIService implements BaseAIService {
  ChatMessageObj mockBotResponse = testChatBotMessageObj;
  Exception? mockBotException;
  Duration responseDuration;

  MockAIService({this.responseDuration = const Duration(milliseconds: 0)});

  @override
  Future<ChatMessageObj> respondToMessage(ChatMessageObj chatMessageObj) {
    return respondToChat([chatMessageObj]);
  }

  @override
  Future<ChatMessageObj> respondToChat(List<ChatMessageObj> history) async {
    await Future.delayed(responseDuration);
    if (mockBotException == null) {
      return mockBotResponse;
    } else {
      return Future.error(mockBotException!);
    }
  }
}
