import 'package:app/common/challenge_progress_widget.dart';
import 'package:app/models/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrackingPage extends ConsumerStatefulWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends ConsumerState<TrackingPage> {
  final _scrollListHeight = 130.0;
  
  final ScrollController _scrollController = ScrollController();
  bool _showScrollIndicator = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    setState(() {
      _showScrollIndicator = _scrollController.position.maxScrollExtent >
          _scrollController.position.pixels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Journey'),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Open Challenges', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 5),
            _buildChallengeList(),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeList() {
    final progressObjs = [
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
    ];

    return SizedBox(
      height: _scrollListHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildChallengeListView(progressObjs),
          Visibility(
            visible: _showScrollIndicator,
            child: _buildScrollIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeListView(List<ProgressObj> progressObjs) {
    return ListView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      children: progressObjs
          .map(_buildChallengeListEntry)
          .toList(),
    );
  }

  Widget _buildChallengeListEntry(progressObj) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: UserChallengeProgressCard(
          progressObj: progressObj,
          onPressed: (data) {},
        ),
      ),
    );
  }

  Widget _buildScrollIndicator() {
    return Positioned(
      right: 0.0,
      top: _scrollListHeight/2 - 16,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.7), // Adjust the color and opacity as desired
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(8.0),
        child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
      ),
    );
  }
}