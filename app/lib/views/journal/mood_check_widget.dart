import 'package:app/providers/mood_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoodCheckWidget extends ConsumerWidget {
  final Function? _onContinue;
  const MoodCheckWidget({Function? onContinue, super.key}) : 
    _onContinue = onContinue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moodStateController = ref.read(moodStateProvider.notifier);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("How are you feeling?"),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mood buttons
              ElevatedButton(
                onPressed: () => _onSelect(moodStateController, Mood.bad),
                child: const Text('Bad'),
              ),
              ElevatedButton(
                onPressed: () => _onSelect(moodStateController, Mood.ok),
                child: const Text('OK'),
              ),
              ElevatedButton(
                onPressed: () => _onSelect(moodStateController, Mood.good),
                child: const Text('Good'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onSelect(StateController<Mood?> moodStateController, Mood mood) {
    moodStateController.state = Mood.good;

    if (_onContinue != null) {
      _onContinue!();
    }
  }
}
