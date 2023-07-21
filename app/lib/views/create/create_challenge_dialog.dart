import 'package:app/common/utils.dart';
import 'package:app/controllers/progress_controller.dart';
import 'package:app/models/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateChallengeDialog extends ConsumerStatefulWidget {
  const CreateChallengeDialog({
    super.key,
  });

  @override
  CreateChallengeDialogState createState() => CreateChallengeDialogState();
}

class CreateChallengeDialogState extends ConsumerState<CreateChallengeDialog> {
  String challengeName = '';
  int durationInDays = 0;

  String? challengeNameError;
  String? durationError;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Challenge'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                challengeName = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Challenge Name',
              errorText: challengeNameError,
            ),
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                durationInDays = int.tryParse(value) ?? 0;
              });
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Duration in Days',
              errorText: durationError,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              challengeNameError = challengeName.isEmpty
                  ? 'Please enter a name'
                  : '';
              durationError = durationInDays <= 0
                  ? 'Please enter a positive number'
                  : '';
            });

            if (challengeName.isNotEmpty && durationInDays > 0) {
              _onAddChallenge(challengeName, durationInDays);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }

  Future<void> _onAddChallenge(String challengeName, int durationInDays) async {
    final progressController = ref.read(progressControllerProvider.notifier);

    await progressController.createProgress(ProgressObj(
      title: challengeName,
      startDate: floorDateToDay(DateTime.now()),
      durationInDays: durationInDays,
    ));
  }
}