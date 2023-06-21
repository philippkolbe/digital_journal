import 'dart:typed_data';
import 'dart:ui';

import 'package:app/models/progress.dart';
import 'package:flutter/material.dart';

class UserChallengeProgressCard extends StatelessWidget {
  final _aspectRatio = 4 / 3;
  final _borderRadius = BorderRadius.circular(8);
  final _insetAmount = 4.0;

  final Function(ProgressObj) onPressed;
  final Function(ProgressObj, bool?) onSelected;
  final bool isActive;
  final ProgressObj progressObj;

  UserChallengeProgressCard({
    required this.onPressed,
    required this.onSelected,
    required this.progressObj,
    this.isActive = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(progressObj),
      child: Container(
        decoration: _buildCardDecoration(),
        child: ClipRRect(
          borderRadius: _borderRadius,
          child: AspectRatio(
            aspectRatio: _aspectRatio - 0.03, // to fix overflow...
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageStack(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      borderRadius: _borderRadius,
      border: Border.all(
        color: Colors.black, // Set the color of the border
        width: 2.0, // Set the width of the border
      ),
    );
  }

  Stack _buildImageStack(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        _buildImage(),
        _buildBlurFilter(),
        _buildCardContent(),
        _buildProgressIndicator(context),
        _buildCheckbox(),
      ],
    );
  }

  AspectRatio _buildImage() {
    return AspectRatio(
      aspectRatio: _aspectRatio,
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: OverflowBox(
          maxHeight: double.infinity,
          alignment: Alignment.center,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(                                       
              isActive ? Colors.transparent : Colors.white,                                                         
              BlendMode.saturation,
            ),
            child: Image.network(
              progressObj.imageUrl ??
                  'https://kripalu.org/sites/default/files/GettyImages-911876528_journal_hero.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }

  BackdropFilter _buildBlurFilter() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
      ),
    );
  }

  BackdropFilter _buildGreyFilter() {
    return BackdropFilter(
      filter: ImageFilter.matrix(Float64List.fromList([
        0.2126, 0.7152, 0.0722, 0,
        0.2126, 0.7152, 0.0722, 0,
        0.2126, 0.7152, 0.0722, 0,
        0,      0,      0,      1,
      ])),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
      ),
    );
  }

  Container _buildCardContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _insetAmount, vertical: 2 * _insetAmount),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            progressObj.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          // const SizedBox(height: 2),
          // Text('Card Subtitle'),
        ],
      ),
    );
  }

  Positioned _buildProgressIndicator(BuildContext context) {
    return Positioned(
      bottom: 4,
      left: 4,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${progressObj.daysCompleted}/${progressObj.durationInDays}d'),
            SizedBox(
              height: 8,
              width: 80,
              child: LinearProgressIndicator(
                value: progressObj.daysCompleted / progressObj.durationInDays,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _buildCheckbox() {
    return Positioned(
      top: 0,
      right: 0,
      child: Transform.scale(
        scale: 1.5,
        child: Checkbox(
          value: true,
          onChanged: (value) {
            onSelected(progressObj, value);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
