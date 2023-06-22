import 'package:app/common/async_widget.dart';
import 'package:app/common/utils.dart';
import 'package:app/controllers/progress_controller.dart';
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
    final asyncProgressObjs = ref.watch(progressControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Journey'),
        actions: [
          if (asyncProgressObjs.value != null) _buildCreateButton(),
        ],
      ),
      body: AsyncWidget(
        asyncValue: asyncProgressObjs,
        buildWidget: (progressObjs) {
          return Column(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ChallengeList(
                        progressObjs: progressObjs,
                        title: 'Open Challenges',
                        isActive: true,
                        onPressed: (data) {},
                        onSelected: (data, pressed) {},
                        emptyWidgetBuilder: () => const Text("Start with some challenges!"),
                      ),
                      const SizedBox(height: 15),
                      if (progressObjs.isNotEmpty)
                        ChallengeList(
                          progressObjs: progressObjs,
                          title: 'Completed Challenges',
                          isActive: false,
                          onPressed: (data) {},
                          onSelected: (data, pressed) {},
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCreateButton() {
    return IconButton(
      onPressed: _onAddChallenge,
      icon: const Icon(Icons.add_circle_outlined),
    );
  }

  Future<void> _onAddChallenge() async {
    final progressController = ref.read(progressControllerProvider.notifier);
    final challengeName = 'Journaling';
    final durationInDays = 7;

    await progressController.createProgress(ProgressObj(
      title: challengeName,
      startDate: floorDateToDay(DateTime.now()),
      durationInDays: durationInDays,
    ));
  }
}
