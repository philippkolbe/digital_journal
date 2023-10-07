import 'package:app/observers/midnight_observer.dart';
import 'package:app/observers/summary_observers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void initializeObservers(WidgetRef ref) {
  initializeMidnightObserver(ref);
}

void observeProviders(WidgetRef ref) {
  initializeSummaryUpdateObserver(ref);
  initializeChatSummaryObserver(ref);
}