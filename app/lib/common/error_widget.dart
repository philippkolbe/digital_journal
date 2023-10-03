import 'package:flutter/material.dart';

Widget Function(Object error, StackTrace stackTrace) buildErrorWidget({ void Function()? onRetry, String? retryText }) {
  return (Object error, StackTrace stackTrace) => ErrorWidget(
    error: error,
    stackTrace: stackTrace,
    onRetry: onRetry,
    retryText: retryText
  );
}

class ErrorWidget extends StatelessWidget {
  final Object error;
  final StackTrace? stackTrace;
  final void Function()? onRetry;
  late final String retryText;

  ErrorWidget({
    required this.error,
    this.stackTrace,
    this.onRetry,
    retryText,
    super.key,
  }) {
    this.retryText = retryText ?? 'Try again.';
  }
 
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Something went wrong. Please try again.', textScaleFactor: 1.2),
          if (onRetry != null) ElevatedButton(
            onPressed: onRetry!,
            child: Text(retryText),
          ),
          Text(error.toString(), softWrap: true),
          Text(stackTrace.toString(), softWrap: true),
        ],
      )
    );
  }
}