import 'package:app/repositories/ai_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import 'ai_api_test_data.dart';
import 'firebase_test_data.dart';
import 'mock_http_client.dart';

void main() {
  group('ChatHistoryRepository', () {
    late MockHttpClient httpClient;
    late BaseAIRepository repository;
    
    setUp(() {
      httpClient = MockHttpClient();
      repository = AIRepository(httpClient: httpClient, userId: testUserId);
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