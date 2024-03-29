import 'package:app/mocks/data/ai_api_test_data.dart';
import 'package:app/mocks/data/firebase_test_data.dart';
import 'package:app/services/ai_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/mocks/mock_http_client.dart';

void main() {
  group('ChatHistoryRepository', () {
    late MockHttpClient httpClient;
    late BaseAIService repository;
    
    setUp(() {
      httpClient = MockHttpClient();
      repository = AIService(httpClient: httpClient, userId: testUserId);
    });
    
    test('createChatMessage should add a new chat message to the collection', () async {
      // Prepare the test data
      final history = [testChatMessageObj];
      // Execute the method
      final responseMessage = await repository.respondToChat(history);
      
      // Verify the result
      expect(responseMessage.content, mockChatResponse);      
    });
  });
}