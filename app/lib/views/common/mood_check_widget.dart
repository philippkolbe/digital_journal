import 'package:app/providers/mood_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoodCheckWidget extends ConsumerWidget {
  final Function? _onContinue;

  const MoodCheckWidget({Key? key, Function? onContinue})
      : _onContinue = onContinue,
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moodStateController = ref.watch(moodStateProvider.notifier);
    final currentMood = ref.watch(moodStateProvider);

    final primaryColor = Theme.of(context).colorScheme.primary;
    final selectedColor = primaryColor;
    final unselectedColor = Colors.grey.shade300;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              "How are you feeling?",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMoodButton(
                moodStateController,
                currentMood,
                Mood.bad,
                'Bad',
                primaryColor,
                selectedColor,
                unselectedColor,
              ),
              const SizedBox(width: 10.0),
              _buildMoodButton(
                moodStateController,
                currentMood,
                Mood.ok,
                'OK',
                primaryColor,
                selectedColor,
                unselectedColor,
              ),
              const SizedBox(width: 10.0),
              _buildMoodButton(
                moodStateController,
                currentMood,
                Mood.good,
                'Good',
                primaryColor,
                selectedColor,
                unselectedColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoodButton(
    StateController<Mood?> moodStateController,
    Mood? currentMood,
    Mood mood,
    String label,
    Color primaryColor,
    Color selectedColor,
    Color unselectedColor,
  ) {
    final isSelected = currentMood == mood;

    return ElevatedButton(
      onPressed: () => _onSelect(moodStateController, mood),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        backgroundColor: isSelected ? selectedColor : unselectedColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16.0,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  void _onSelect(StateController<Mood?> moodStateController, Mood mood) {
    moodStateController.state = mood;

    if (_onContinue != null) {
      _onContinue!();
    }
  }
}
