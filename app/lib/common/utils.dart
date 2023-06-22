import 'package:uuid/uuid.dart';

var _uuid = const Uuid();

String generateUuid() {
  return _uuid.v4();
}

DateTime floorDateToDay(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}