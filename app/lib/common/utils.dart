import 'package:tuple/tuple.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

var _uuid = const Uuid();

String generateUuid() {
  return _uuid.v4();
}

String getNowString() {
  final now = DateTime.now();

  return '${now.day}.${now.month}.${now.year} ${now.hour}:${now.minute}';
}

DateTime floorDateToDay(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

AsyncValue<Tuple2<T, R>> combineAsync2<T, R>(
  AsyncValue<T> asyncOne,
  AsyncValue<R> asyncTwo,
) {
  if (asyncOne is AsyncError) {
    final error = asyncOne as AsyncError<T>;
    return AsyncError(error.error, error.stackTrace);
  } else if (asyncTwo is AsyncError) {
    final error = asyncTwo as AsyncError<R>;
    return AsyncError(error.error, error.stackTrace);
  } else if (asyncOne is AsyncLoading || asyncTwo is AsyncLoading) {
    return const AsyncLoading();
  } else if (asyncOne is AsyncData && asyncTwo is AsyncData) {
    return AsyncData(Tuple2<T, R>((asyncOne as AsyncData).value, (asyncTwo as AsyncData).value));
  } else {
    throw 'Unsupported case';
  }
}