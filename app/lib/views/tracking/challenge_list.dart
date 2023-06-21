
import 'package:app/common/challenge_progress_widget.dart';
import 'package:app/models/progress.dart';
import 'package:flutter/material.dart';

class ChallengeList extends StatefulWidget {
  final List<ProgressObj> progressObjs;
  final Widget Function()? emptyWidgetBuilder;
  final String title;
  final bool isActive;
  final Function(ProgressObj) onPressed;
  final Function(ProgressObj, bool?) onSelected;

  const ChallengeList({
    required this.progressObjs,
    required this.title,
    required this.isActive,
    required this.onPressed,
    required this.onSelected,
    this.emptyWidgetBuilder,
    super.key,
  });

  @override
  ChallengeListState createState() => ChallengeListState();
}

class ChallengeListState extends State<ChallengeList> {
  final _scrollController = ScrollController();
  bool _showScrollIndicator = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleScroll());
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 5),
        SizedBox(
          height: 130,
          child: widget.progressObjs.isNotEmpty || widget.emptyWidgetBuilder == null
            ? Stack(
              alignment: Alignment.center,
              children: [
                ListView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  children: widget.progressObjs.map((progressObj) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: UserChallengeProgressCard(
                        progressObj: progressObj,
                        isActive: widget.isActive,
                        onPressed: widget.onPressed,
                        onSelected: widget.onSelected,
                      ),
                    ),
                  )).toList(),
                ),
                _buildScrollIndicator(),
              ],
            )
            : widget.emptyWidgetBuilder!(),
        ),
      ],
    );
  }

  Visibility _buildScrollIndicator() {
    final widget = Visibility(
      visible: _showScrollIndicator,
      child: Positioned(
        right: 16.0,
        top: 50.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        ),
      ),
    );
  
    return widget;
  }
}
