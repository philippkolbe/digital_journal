import 'package:app/models/progress.dart';
import 'package:app/views/tracking/challenge_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrackingPage extends ConsumerStatefulWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends ConsumerState<TrackingPage> {
  @override
  Widget build(BuildContext context) {
    final completedProgressObjs = [
      ProgressObj(
        title: 'Completed Challenge 1',
        startDate: DateTime.now(),
        durationInDays: 7,
        daysCompleted: 7,
      ),
      ProgressObj(
        title: 'Completed Challenge 2',
        startDate: DateTime.now(),
        durationInDays: 14,
        daysCompleted: 14,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Journey'),
        actions: [],
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChallengeList(
                progressObjs: [
                  ProgressObj(
                    title: 'Journaling',
                    startDate: DateTime.now(),
                    durationInDays: 7,
                    daysCompleted: 3,
                  ),
                  ProgressObj(
                    title: 'Jogging',
                    startDate: DateTime.now(),
                    durationInDays: 21,
                    daysCompleted: 4,
                  ),
                  ProgressObj(
                    title: 'Jogging',
                    startDate: DateTime.now(),
                    durationInDays: 21,
                    daysCompleted: 4,
                  ),
                ],
                title: 'Open Challenges',
                isActive: true,
                onPressed: (data) {},
                onSelected: (data, pressed) {},
                emptyWidgetBuilder: () => const Text("Start with some challenges!"),
              ),
              const SizedBox(height: 15),
              if (completedProgressObjs.isNotEmpty)
                ChallengeList(
                  progressObjs: completedProgressObjs,
                  title: 'Completed Challenges',
                  isActive: false,
                  onPressed: (data) {},
                  onSelected: (data, pressed) {},
                ),
            ],
          ),
        ),
      ),
    );
  }
}
