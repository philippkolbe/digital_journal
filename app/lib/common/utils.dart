import 'package:uuid/uuid.dart';

var _uuid = const Uuid();

String generateUuid() {
  return _uuid.v4();
}