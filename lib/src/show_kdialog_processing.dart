import 'package:flutter/material.dart';
import 'package:kdialogs/src/show_kbottom_error.dart';
import 'package:kdialogs/src/show_kdialog_confirm.dart';
import 'package:kdialogs/src/show_kloading_indicator.dart';

SnackBar _snackBar({String? message}) {
  message ??= 'Operation completed successfully';
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    duration: const Duration(milliseconds: 1500),
    content: Text(message),
  );
}

Future<T?> showKDialogProcessing<T>(
  BuildContext context, {
  required Future<T> Function() doProcess,
  void Function(T value)? onSuccess,
  void Function(String errMessage)? onError,
  bool retryable = false,
  bool confirmationRequired = false,
  String? confirmationTitle,
  String confirmationMessage = "Are you sure you want to proceed with this operation?",
  bool showSuccessSnackBar = false,
  String? successMessage,
  String acceptText = "ACCEPT",
  String retryText = "RETRY",
  String? loadingMessage,
}) async {
  if (confirmationRequired) {
    final confirmed = await showKDialogConfirm(
      context,
      title: confirmationTitle,
      message: confirmationMessage,
    );
    if (!confirmed) return null;
  }
  if (context.mounted) {
    void Function() closeloader;
    if (loadingMessage == null) {
      closeloader = await showKLoadingIndicator(context);
    } else {
      closeloader = await showKLoadingIndicatorWithMessage(context, message: loadingMessage);
    }
    T? results;
    try {
      results = await doProcess();
      closeloader();
      if (onSuccess != null && results != null) onSuccess(results);
      if (context.mounted && (showSuccessSnackBar || successMessage != null)) {
        ScaffoldMessenger.of(context).showSnackBar(_snackBar(message: successMessage));
      }
    } catch (err) {
      closeloader();
      bool? retry;
      if (context.mounted) {
        retry = await showKBottomErrorMessage(
          context,
          message: err.toString(),
          retryable: retryable,
          acceptText: acceptText,
          retryText: retryText,
        );
      }
      if ((retry ?? false) && context.mounted) {
        return await showKDialogProcessing(
          context,
          doProcess: doProcess,
          onError: onError,
          onSuccess: onSuccess,
          retryable: retryable,
          acceptText: acceptText,
          retryText: retryText,
        );
      }
      if (onError != null) onError(err.toString());
    }
    return results;
  }
  return null;
}
