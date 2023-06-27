import 'package:flutter/material.dart';

class CreateChallengeDialog extends StatefulWidget {
  final void Function(String challengeName, int durationInDays) onChallengeCreate;

  const CreateChallengeDialog({
    required this.onChallengeCreate,
    super.key,
  });

  @override
  CreateChallengeDialogState createState() => CreateChallengeDialogState();
}

class CreateChallengeDialogState extends State<CreateChallengeDialog> {
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
              widget.onChallengeCreate(challengeName, durationInDays);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}