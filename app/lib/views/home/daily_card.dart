import 'package:app/controllers/journal_controller.dart';
import 'package:app/controllers/personality_controller.dart';
import 'package:app/models/daily_card.dart';
import 'package:app/models/journal_entry.dart';
import 'package:app/views/create/journal_prompt_wizard.dart';
import 'package:app/views/create/mood_chat_journal_wizard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DailyCardBuilder extends StatelessWidget {
  final DailyCardObj dailyCard;

  const DailyCardBuilder(this.dailyCard, {super.key});

  @override
  Widget build(BuildContext context) {
    return dailyCard.map(
        personalityPrompt: _buildPersonalityPrompt,
        moodCheck: _buildMoodCheck,
        futureCard: _buildFutureCard);
  }

  Widget _buildPersonalityPrompt(PersonalityPromptDailyCardObj cardObj) {
    return PersonalityPromptCard(cardObj);
  }

  Widget _buildMoodCheck(MoodCheckDailyCardObj cardObj) {
    return MoodCheckDailyCard(cardObj);
  }

  Widget _buildFutureCard(FutureDailyCardObj cardObj) {
    return FutureDailyCard(cardObj);
  }
}

abstract class DailyCardDefinition<T> extends ConsumerWidget {
  final T card;
  const DailyCardDefinition(this.card, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: getBackgroundColor(context, ref),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5.0,
        margin: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                getTitle(context, ref),
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              buildContent(context, ref),
            ],
          ),
        ),
      ),
    );
  }

  String getTitle(BuildContext context, WidgetRef ref);
  Widget buildContent(BuildContext context, WidgetRef ref);

  Color getBackgroundColor(BuildContext context, WidgetRef ref) {
    return Theme.of(context).cardColor;
  }

  void _onAddJournalEntry(BuildContext context, WidgetRef ref,
      Widget Function(BuildContext) buildWidget, String name,
      {String? personalityId}) async {
    final selectedJournalEntryController =
        ref.read(selectedJournalEntryProvider.notifier);
    selectedJournalEntryController.state = const AsyncLoading();

    _pushChatJournalWizardRoute(context, buildWidget);

    try {
      final journalController = ref.read(journalEntriesProvider.notifier);

      final newJournalEntryObj = await journalController.addJournalEntry(
        ChatJournalEntryObj(
          name: name,
          date: DateTime.now(),
          personalityId: personalityId,
        ),
      );

      selectedJournalEntryController.state = AsyncData(newJournalEntryObj);
    } catch (err, st) {
      selectedJournalEntryController.state = AsyncError(err, st);
    }
  }

  void _pushChatJournalWizardRoute(
      BuildContext context, Widget Function(BuildContext) buildWidget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: buildWidget,
      ),
    );
  }
}

class PersonalityPromptCard
    extends DailyCardDefinition<PersonalityPromptDailyCardObj> {
  const PersonalityPromptCard(super.card, {super.key});

  @override
  String getTitle(BuildContext context, WidgetRef ref) {
    return ref
            .watch(personalityProviderFamily(card.personalityId))
            .valueOrNull
            ?.name ??
        'Daily Prompt';
  }

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    if (card.prompt != null) {
      return Text(card.prompt!);
    } else {
      return ElevatedButton(
          onPressed: () => _onCreateJournalPrompt(context, ref),
          child: const Text("Generate Daily Prompt"));
    }
  }

  void _onCreateJournalPrompt(BuildContext context, WidgetRef ref) {
    _onAddJournalEntry(context, ref,
        (context) => JournalPromptWizard(dailyCard: card), 'Daily Prompt',
        personalityId: card.personalityId);
  }
}

class MoodCheckDailyCard extends DailyCardDefinition<MoodCheckDailyCardObj> {
  const MoodCheckDailyCard(super.card, {super.key});

  @override
  String getTitle(BuildContext context, WidgetRef ref) {
    return "Mood Check";
  }

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    if (card.mood != null) {
      return Container();
    } else {
      return Column(
        children: [
          const Text("How are you feeling today?"),
          ElevatedButton(
            child: const Text("Start Mood Check"),
            onPressed: () => _onCreateMoodCheckJournalEntry(context, ref),
          ),
        ],
      );
    }
  }

  void _onCreateMoodCheckJournalEntry(BuildContext context, WidgetRef ref) {
    _onAddJournalEntry(context, ref,
        (context) => MoodChatJournalWizard(dailyCard: card), 'Mood Check');
  }
}

class FutureDailyCard extends DailyCardDefinition {
  const FutureDailyCard(super.card, {super.key});

  @override
  String getTitle(BuildContext context, WidgetRef ref) {
    return "Come back later!";
  }

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return const Text(
        "The content for this day will be unlocked when you come back on this day.");
  }
}
