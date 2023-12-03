import 'package:flutter/material.dart';
import 'package:kdialogs/src/show_bottom_alert.dart';

Future<T?> wrapAsyncAction<T>(
  BuildContext context, {
  required Future<T> Function() doProcess,
  void Function(T value)? onSuccess,
  void Function(String errMessage)? onError,
  String errorAcceptText = "ACCEPT",
}) async {
  T? results;
  try {
    results = await doProcess();
    if (onSuccess != null && results != null) {
      onSuccess(results);
    }
  } catch (err) {
    if (context.mounted) {
      await showBottomAlertKDialog(
        context,
        message: err.toString(),
        acceptText: errorAcceptText,
      );
    }
    if (onError != null) onError(err.toString());
  }
  return results;
}
