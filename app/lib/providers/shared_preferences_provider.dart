import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesFutureProvider = Provider((ref) => SharedPreferences.getInstance());
final sharedPreferencesProvider = FutureProvider((ref) => ref.watch(sharedPreferencesFutureProvider));