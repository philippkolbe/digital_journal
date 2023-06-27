import 'package:app/common/async_widget.dart';
import 'package:app/common/utils.dart';
import 'package:app/controllers/progress_controller.dart';
import 'package:app/controllers/todays_progress_controller.dart';
import 'package:app/models/progress.dart';
import 'package:app/models/progress_entry.dart';
import 'package:app/providers/active_progress_provider.dart';
import 'package:app/providers/current_day_provider.dart';
import 'package:app/views/tracking/challenge_list.dart';
import 'package:app/views/tracking/create_challenge_dialog.dart';
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
    final todaysProgressController = ref.read(todaysProgressControllerProvider.notifier);
    final asyncTodaysProgress = ref.watch(todaysProgressControllerProvider);
    final asyncProgressObjs = ref.watch(activeProgressProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Journey'),
        actions: [
          if (asyncProgressObjs.valueOrNull != null) _buildCreateButton(context),
        ],
      ),
      body: AsyncWidget2(
        asyncValue1: asyncProgressObjs,
        asyncValue2: asyncTodaysProgress,
        buildWidget: (progressObjs, todaysProgress) {
          final openChallenges = progressObjs
            .where((obj) => !obj.hasBeenCompletedToday)
            .toList();

          final completedChallenges = progressObjs
            .where((obj) => obj.hasBeenCompletedToday)
            .toList();

          return Column(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (progressObjs.isEmpty)
                        const Text("Start with some challenges!"),
                      if (progressObjs.isNotEmpty)
                        _buildChallengeList(
                          'Open Challenges',
                          openChallenges,
                          todaysProgress,
                          todaysProgressController,
                          emptyWidgetText: "Congratulations! You have completed all your challenges for today."
                        ),
                      const SizedBox(height: 15),
                      if (completedChallenges.isNotEmpty)
                        _buildChallengeList(
                          'Completed Challenges',
                          completedChallenges,
                          todaysProgress,
                          todaysProgressController,
                          isActive: false,
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

  ChallengeList _buildChallengeList(
    String title,
    List<ProgressObj> progressObjs,
    Map<ProgressObj, AsyncValue<ProgressEntryObj?>> todaysProgress,
    TodaysProgressController todaysProgressController,
    {
      bool isActive = true,
      String emptyWidgetText = "",  
    }
  ) {
    return ChallengeList(
      progressObjs: progressObjs,
      areSelected: Map.fromEntries(progressObjs.map(
        (progressObj) => MapEntry(
          progressObj,
          todaysProgress[progressObj]?.whenData(
            (progressEntryObj) => progressEntryObj?.isCompleted ?? false,
          ) ?? AsyncError<bool>(
            'Couldnt load progress of $progressObj',
            StackTrace.current,
          ),
        ),
      )),
      title: title,
      isActive: isActive, 
      onPressed: (progressObj) {},
      onSelected: (progressObj, pressed) {
        // TODO: pressed, dont toggle
        todaysProgressController.toggleChallengeCompletion(progressObj);
      },
      emptyWidgetBuilder: () => Text(emptyWidgetText),
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return IconButton(
      onPressed: () => _showCreateChallengeDialog(context),
      icon: const Icon(Icons.add_circle_outlined),
    );
  }

  Future<void> _showCreateChallengeDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CreateChallengeDialog(
          onChallengeCreate: _onAddChallenge,
        );
      },
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
