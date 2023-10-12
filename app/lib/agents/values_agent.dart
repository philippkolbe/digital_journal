import 'dart:convert';

import 'package:app/controllers/attributes_controller.dart';
import 'package:app/models/attributes_action.dart';
import 'package:app/models/chat_message.dart';
import 'package:app/providers/prompts_providers.dart';
import 'package:app/services/ai_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final attributesActionsProvider = FutureProvider<List<AttributesActionObj>>((ref) async {
  final asyncSummaryPrompt = ref.watch(summaryPromptProvider);
  final summaryPrompt = asyncSummaryPrompt.valueOrNull;

  if (summaryPrompt != null) {
    // TODO: can I prevent analyzing when the summary has already been analyzed?

    // Only read the current agents - otherwise there are dependency cycles
    final analysisAgents = ref.read(attributeAnalysisAgentsProvider);

    final actions = await Future.wait(
      analysisAgents.map((agent) => agent.tryAnalyzing(summaryPrompt))
    );

    return actions.expand((list) => list).toList();  // flatten
  } else {
    return [];
  }
});

final attributeAnalysisAgentsProvider = Provider<List<AttributesAgent>>((ref) {
  return [
    ref.watch(valuesAgentProvider),
    ref.watch(likesAgentProvider),
  ];
});

final valuesAgentProvider = Provider<AttributesAgent>((ref) {
  final aiService = ref.watch(aiServiceProvider);
  final attributesController = ref.watch(attributesProvider.notifier);
  final prompts = ref.watch(analysisPromptsProvider);

  return AttributesAgent(
    aiService,
    attributesController,
    prompts[AnalysisPrompts.valueAnalysis]!
  );
});

final likesAgentProvider = Provider<AttributesAgent>((ref) {
  final aiService = ref.watch(aiServiceProvider);
  final attributesController = ref.watch(attributesProvider.notifier);
  final prompts = ref.watch(analysisPromptsProvider);

  return AttributesAgent(
    aiService,
    attributesController,
    prompts[AnalysisPrompts.likeAnalysis]!
  );
});

class AttributesAgent {
  final BaseAIService aiService;
  final AttributesController attributesController;
  final AnalysisPrompt prompt;

  AttributesAgent(this.aiService, this.attributesController, this.prompt);

  Future<List<AttributesActionObj>> tryAnalyzing(String summaryPrompt) async {
    try {
      return await analyze(summaryPrompt);
    } catch (err) {
      print('Error while analyzing the summary');
      print(err);
      return [];
    }
  }

  Future<List<AttributesActionObj>> analyze(String summaryPrompt) async {
    final chatWithPrompts = _createChatWithPrompts(summaryPrompt);
    print(chatWithPrompts[0].content);
    print(chatWithPrompts[1].content);
    print(chatWithPrompts[2].content);
    final aiResponse = await aiService.respondToChat(chatWithPrompts);
    print(aiResponse);
    return _parseAttributeActionsFromAIResponse(aiResponse.content);
  }

  List<ChatMessageObj> _createChatWithPrompts(String summaryPrompt) {
    return [
      _createSystemMessage(),
      _createSummaryMessage(summaryPrompt),
      _createPromptMessage(),
    ];
  }

  ChatMessageObj _createSystemMessage() {
    return SystemChatMessageObj(
      date: DateTime.now(),
      content: prompt.systemMessage
    );
  }
  
  ChatMessageObj _createSummaryMessage(String summaryPrompt) {
    return _createUserChatMessage(summaryPrompt);
  }
  
  ChatMessageObj _createPromptMessage() {
    return _createUserChatMessage(prompt.userPrompt);
  }

  UserChatMessageObj _createUserChatMessage(String content) {
    return UserChatMessageObj(
      date: DateTime.now(),
      content: content,
    );
  }

  List<AttributesActionObj> _parseAttributeActionsFromAIResponse(String aiResponse) {
    final actions = aiResponse.split("\n");
    return actions
      .map(_tryCreatingAttributeAction)
      .whereType<AttributesActionObj>()
      .toList();
  }

  AttributesActionObj? _tryCreatingAttributeAction(String jsonString) {
    try {
      return AttributesActionObj.fromJson(json.decode(jsonString));
    } catch (err) {
      print(err);
      // TODO: how to error handle here?
      return null;
    }
  }
}
