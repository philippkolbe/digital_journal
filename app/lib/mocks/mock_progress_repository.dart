import 'package:app/models/progress.dart';
import 'package:app/repositories/progress_repository.dart';

class MockProgressRepository implements BaseProgressRepository {
  final progress1 = ProgressObj(id: '1', title: 'Progress 1', startDate: DateTime(2024, 1, 1), durationInDays: 365);
  final progress2 = ProgressObj(id: '2', title: 'Progress 2', startDate: DateTime(2024, 1, 3), durationInDays: 3);

  late final Map<String, ProgressObj> progressEntries;
  late int idCount;

  MockProgressRepository() {
    progressEntries = {
      progress1.id!: progress1,
      progress2.id!: progress2,
    };
    idCount = progressEntries.length;
  }

  @override
  Future<List<ProgressObj>> readAllProgressions(String userId) {
    return Future.value(progressEntries.values.toList());
  }

  @override
  Future<ProgressObj> readProgression(String userId, String entryId) {
    return Future.value(progressEntries[entryId]);
  }

  @override
  Future<String> createProgress(String userId, ProgressObj entry) {
    final id = entry.id ?? (++idCount).toString();
    progressEntries[id] = entry;
    return Future.value(id);
  }

  @override
  Future<void> deleteProgress(String userId, String entryId) {
    progressEntries.remove(entryId);
    return Future.value();
  }

  @override
  Future<ProgressObj> updateProgress(String userId, ProgressObj entry) {
    final existingEntry = progressEntries[entry.id!];
    if (existingEntry != null) {
      final mergedJson = {...existingEntry.toJson(), ...entry.toJson()};
      final mergedEntry = ProgressObj.fromJson(mergedJson);
      progressEntries[entry.id!] = mergedEntry;
      return Future.value(mergedEntry);
    } else {
      throw ProgressException('Progress entry does not exist.', userId: userId, progressId: entry.id);
    }
  }
}
