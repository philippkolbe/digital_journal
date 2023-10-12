import 'package:app/common/error_widget.dart' as err;
import 'package:app/common/loading_widget.dart';
import 'package:app/common/utils.dart';
// ignore: depend_on_referenced_packages
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncWidget<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(T) buildWidget;
  final Widget Function(Object, StackTrace)? buildErrorWidget;
  final void Function()? onRetryAfterError;
  final String? retryText;

  const AsyncWidget({
    required this.asyncValue,
    required this.buildWidget,
    this.retryText,
    this.onRetryAfterError,
    this.buildErrorWidget,
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      data: (T data) => buildWidget(data),
      error: buildErrorWidget ??
        err.buildErrorWidget(onRetry: onRetryAfterError, retryText: retryText),
      loading: () => const LoadingWidget(),
    );
  }
}

class AsyncWidget2<T1, T2> extends StatelessWidget {
  final AsyncValue<T1> asyncValue1;
  final AsyncValue<T2> asyncValue2;
  final AsyncValue<Tuple2<T1, T2>> asyncValue;
  final Widget Function(T1, T2) buildWidget;
  final void Function()? onRetryAfterError;
  final String? retryText;

  AsyncWidget2({
    required this.asyncValue1,
    required this.asyncValue2,
    required this.buildWidget,
    this.retryText,
    this.onRetryAfterError,
    super.key,
  }) : asyncValue = combineAsync2(asyncValue1, asyncValue2);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: asyncValue.when(
        data: (Tuple2<T1, T2> data) => buildWidget(data.item1, data.item2),
        error: err.buildErrorWidget(onRetry: onRetryAfterError, retryText: retryText),
        loading: () => const LoadingWidget(),
      ),
    );
  }
}