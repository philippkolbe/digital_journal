import 'package:app/common/error_widget.dart';
import 'package:app/common/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncWidget<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(T) buildWidget;
  final void Function()? onRetryAfterError;
  final String? retryText;

  const AsyncWidget({
    required this.asyncValue,
    required this.buildWidget,
    this.retryText,
    this.onRetryAfterError,
    super.key,
  });
 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: asyncValue.when(
        data: (T data) => buildWidget(data),
        error: buildErrorWidget(onRetry: onRetryAfterError, retryText: retryText),
        loading: () => const LoadingWidget(),
      ),
    );
  }
}