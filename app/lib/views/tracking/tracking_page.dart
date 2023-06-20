import 'package:app/common/async_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrackingPage extends ConsumerWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('test'),
      ),
      body: const Column(),
    );
  }
}