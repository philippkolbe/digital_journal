import 'package:app/controllers/personality_controller.dart';
import 'package:app/controllers/summary_controller.dart';
import 'package:app/common/utils.dart';
import 'package:app/controllers/attributes_controller.dart';
import 'package:app/controllers/progress_controller.dart';
import 'package:app/providers/mood_state_provider.dart';
import 'package:app/providers/reflecting_on_challenge_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ChatJournalType {
  standard,
  reflection,
  goalDiscovery,
  likeAnalysis,
  valueAnalysis
}

enum GeneralPrompts {
  conversationSummary,
  summarizeChatMessage,
}

enum AnalysisPrompts {
  likeAnalysis,
  valueAnalysis,
  informationAnalysis,
}

final goalPromptsProvider = Provider<Map<ChatJournalType, String>>((ref) {
  final mood = ref.watch(moodStateProvider);
  final reflectingOnChallenge = ref.watch(reflectingOnChallengeProvider);
  final challenges = ref.watch(progressControllerProvider).valueOrNull;
  // load attributes (likes, dislikes, goals, values, fears)
  // load information from memory
  // load current daytime (morning, afternoon, evening, night), day of week, date

  // Define the hard-coded prompts for each chat journal type
  final personalityPrompt = ref.watch(selectedPersonalityProvider)?.prompt ?? getStandardPersonalityPrompt();
  
  return {
    ChatJournalType.standard: '''
      $personalityPrompt. You don't have to introduce yourself. By asking simple, non-intrusive questions, you empower users to delve deeper into their thoughts. Always ask one question at a time and await the users answer before asking more questions.
      Your first answer should be one simple question. ${mood != null ? 'The user entered that he is feeling ${moodToString(mood)}. ' : ''}Remember to stick to your personality. Be very concise in answers.''',
    ChatJournalType.reflection: '''
      You are a friendly and motivating journaling companion within an app. The chat users now you already - you don’t have to introduce yourself. As users chat with you, you provide guidance for journaling and self-reflection.
      Help them reflect about their feelings and progress on challenges. Always ask one question at a time and await the users answer before asking more questions. Your first answer should be one simple question.
      The user just completed a daily challenge named "$reflectingOnChallenge". ${mood != null ? 'They said that now they feel ${moodToString(mood)}. ' : ''}
      Remember to maintain a quiet and supportive presence, akin to a trusted journal. Be very concise in answers.''',
    ChatJournalType.goalDiscovery: '''
      You are a friendly and motivating journaling companion within an app. The chat users now you already - you don’t have to introduce yourself. As users chat with you, you provide guidance for journaling and self-reflection.
      Your goal is to help users explore their emotions and personal development. By asking simple, non-intrusive questions, you empower users to delve deeper into their thoughts. Always ask one question at a time and await the users answer before asking more questions.
      Your first answer should be one simple question. Once you identify a SMART goal with the user, you suggest specific daily challenges that align with their aspirations. Ask at least 3 questions one after another before you start identifying goals. The user is currently doing the challenges ${challenges != null ? challenges.map((c) => c.title).join(', ') : ''}.
      Remember to maintain a quiet and supportive presence, akin to a trusted journal. Be very concise in answers.''',
  };
});

String getStandardPersonalityPrompt() {
  return '''You are a friendly and motivating journaling companion within an app. As users chat with you, you provide guidance for journaling and self-reflection. Your goal is to help users explore their emotions and personal development. Remember to maintain a quiet and supportive presence, akin to a trusted journal.''';
}

final generalPromptsProvider = Provider<Map<GeneralPrompts, String>>((ref) {
  return {
    GeneralPrompts.conversationSummary: '''
      As a summarizer within a journaling app, continuously summarize the ongoing conversation for other GPT-3.5 instances. The goal is to include all relevant information regarding the user's fears, goals, values, likes, and dislikes. The summary's readability for humans is not a priority; it's solely for other AI instances to analyze. Prioritize maximum brevity without compromising completeness; shorter summaries are preferred when the information is irrelevant.
      If the user provides a summary of the conversation, ensure that the newly created summary includes all relevant information from the user's summary. No need to mention that summarized information was provided. Focus solely on the content's relevance.
    ''', // one could tell the bot how many tokens the conversation is supposed to have...
    GeneralPrompts.summarizeChatMessage: '''Summarize our conversation up to the message before this one. You're answer does not have to be human readable so be as concise as possible.''',
  };
});

final summaryPromptProvider = Provider<AsyncValue<String?>>((ref) {
  final asyncSummary = ref.watch(summaryProvider);
  return asyncSummary.whenData((summary) => summary != null 
    ? createPreviousSummaryUserMessage(summary.content)
    : null);
});

String createPreviousSummaryUserMessage(String? summary) {
  if (summary != null) {
    return '''Here is a summary of our conversation up to this point:
$summary''';
  } else {
    return "";
  }
}

class AnalysisPrompt {
  final String systemMessage;
  final String userPrompt;

  AnalysisPrompt(this.systemMessage, this.userPrompt);
}

final analysisPromptsProvider = Provider<Map<AnalysisPrompts, AnalysisPrompt>>((ref) {
  final attributesState = ref.watch(attributesProvider).valueOrNull;
  final attributesString = attributesState?.attributes
    .map((attr) {
      final json = attr.toJson();
      json['id'] = json['countingId'];
      return json
        ..remove('countingId')
        ..remove('runtimeType');
    })
    .join("\n");

  return {
    AnalysisPrompts.likeAnalysis: AnalysisPrompt('''
        Your role as an analyst in a journaling app is to manage and update a user's database of likes and dislikes, based on a conversation between the user and their journaling assistant. As the user has lots of conversations with the journaling assistant it is more important to capture general middle- to longterm important attributes than specifics of this conversation. This also means that you should not delete attributes that were not mentioned. Each attribute should follow this format:

        Like: {"type": "like", "description": "Like Description", "level": 1-10}
        Dislike: {"type": "dislike", "description": "Dislike Description", "level": 1-10}
        Your tasks include:

        Updating existing entries by referencing their IDs if the user provides changes in the description or level, including generalizing specific entries to broader categories. Output these updates in the following format:
        {"id": "existing-entry-id", "action": "update", "description": "new-description", "level": new-level}.
        You may leave out the description field if you do not want to update it.

        Adding new entries without specifying an ID for any goals, fears, or values that the user explicitly mentions or that can be inferred from their conversation. Output these new entries in the following format:
        {"action": "create", "type": "attribute-type", "description": "Attribute Description", "level": 1-10}

        Removing entries by referencing their IDs if the user explicitly states that this attribute is not true anymore. Output these removals in the following format:
        {"id": "existing-entry-id", "action": "delete"}

        Your output should be a list of these actions, including updates, new entries, and removals, based on the user's conversation. This list will be used to update the user's database entries. You should not actively participate in the conversation or provide responses; your sole focus is on managing the attributes using IDs.

        Only output the new, updated or deleted attributes in json format and don't add any other text. Here is an example output:
        {"id": "3", "action": "delete"}
        {"id": "2", "action": "update", "level": 4}
        {"action": "create", "type": "value", "description": "Family", "level": 3}

        Analyze the entire summary of the conversation but do not answer it. Only output the updates to the database. Make sure to only use the allowed types 'like' and 'dislike'.
      ''',
      '''
        ${attributesString != null && attributesString.isNotEmpty
          ? 'This is a list of the users existing attributes: \n $attributesString'
          : ''}
        Analyze the entire conversation. Only output the new, updated or deleted attributes in json format and don't add any other text. Especially, do not answer the user or finish the conversation.
      '''
    ),
    AnalysisPrompts.valueAnalysis: AnalysisPrompt('''
        Your role as an psycho-analyst in a journaling app is to manage and update a user's database of personal attributes, holding 
        fears, goals, and values, based on a conversation between the user and their journaling assistant. As the user has lots of conversations with the journaling assistant it is more important to capture general middle- to longterm important attributes than specifics of this conversation. This also means that you should not delete attributes that were not mentioned.
        You may read through the lines though and add attributes that the user did not explicitly mention as they might not want those attributes to be true but they describe the person well. Each attribute should follow this format:

        Goals: {"id": "goal1", "type": "goal", "description": "Goal Description", "level": 1-10}
        Fears: {"id": "fear1", "type": "fear", "description": "Fear Description", "level": 1-10}
        Values: {"id": "value1", "type": "value", "description": "Value Description", "level": 1-10}
        Your tasks include:

        Updating existing entries by referencing their IDs if the user provides changes in the description or level, including generalizing specific entries to broader categories. Output these updates in the following format:
        {"id": "existing-entry-id", "action": "update", "description": "new-description", "level": new-level}.
        You may leave out the description field if you do not want to update it.

        Adding new entries without specifying an ID for any goals, fears, or values that the user explicitly mentions or that can be inferred from their conversation. Output these new entries in the following format:
        {"action": "create", "type": "attribute-type", "description": "Attribute Description", "level": 1-10}

        Removing entries by referencing their IDs if the user explicitly states that this attribute is not true anymore. Output these removals in the following format:
        {"id": "existing-entry-id", "action": "delete"}

        Your output should be a list of these actions, including updates, new entries, and removals, based on the user's conversation. This list will be used to update the user's database entries. You should not actively participate in the conversation or provide responses; your sole focus is on managing the attributes using IDs.

        Only output the new, updated or deleted attributes in json format and don't add any other text. Especially, do not answer the user or finish the conversation. Here is an example output:
        {"id": "value3", "action": "delete"}
        {"action": "update", "id": "goal2", "level": 4}
        {"action": "create", "type": "value", "description": "Family", "level": 3}

        Analyze the entire conversation but do not answer it. Only output the updates to the database. Make sure to only use these allowed types 'goal', 'fear' and 'value'.
      ''',
      '''
        This is a list of the users existing attributes:
        ${attributesState?.attributes
          .map((attr) => attr.toJson().remove('runtimeType'))
          .join("\n")
          ?? 'There are no existing attributes.'}
        Analyze the entire conversation. Only output the new, updated or deleted attributes in json format and don't add any other text. Especially, do not answer the user or finish the conversation.
      ''' // TODO: Map ids to human readable ids like goal1, etc.
      // TODO: We should add a confidence score
    ),
    AnalysisPrompts.informationAnalysis: AnalysisPrompt('''
      Imagine you are an assistant in a journaling app that helps users keep track of important information from their conversations. You have a 'memory' where each piece of information has an id, a creation date (DD.MM.YYYY HH:MM), a description, an importance score (1-10), and an expiration date (DD.MM.YYYY HH:MM). The 'expiration date' represents when the information may no longer be relevant or important, and it can be an estimation.
      Your task is to process a conversation between the user and the journaling assistant and make updates to the 'memory' based on the following actions: 'create,' 'delete,' and 'update.'

      Please generate appropriate JSON responses for each action as follows:

      For a 'create' action, provide a JSON object with fields for 'action,' 'date,' 'description,' 'importance,' and 'expiresAt'. Make sure to always add a valid expiration date even if it is only an estimation.
      For a 'delete' action, provide a JSON object with the 'id' to be deleted.
      For an 'update' action, provide a JSON object with the 'id' to be updated and the field(s) to be modified.
      Ensure that your responses are correctly formatted and follow the provided instructions. You have access to the current date and the list of information stored in memory as a JSON list.

      Note: Do not delete information from the memory unless the user explicitly states that the information is no longer valid.

      Only output json valid text - do not respond with any other text.
      An example output would be:
      { "action": "create", "date": "04.10.2023 10:00", "description": "Excited about dinner with girlfriend tonight",  "importance": 8, "expiresAt": "11.10.2023 23:59" }
      { "id": "info2", "action": "delete" }
      { "id": "info3", "action": "update", "importance": 3 }
    ''',
    '''
      It is ${getNowString()}. Here is a list of the information currently in memory:
      { "id": "info1", "date": "04.10.2023 10:00", "description": "Excited about dinner with girlfriend tonight",  "importance": 8, "expiresAt": "11.10.2023 23:59" }.

      Extract all of the relevant information from our conversation. Only output json valid text and don't respond with any other text. You may write several information entries or update or delete existing ones.
    '''),
  };
});