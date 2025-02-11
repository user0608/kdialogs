import 'package:flutter/material.dart';
import 'package:kdialogs/src/show_bottom_alert.dart';
import 'package:kdialogs/src/show_confirmation.dart';
import 'package:kdialogs/src/show_loadings.dart';
import 'package:kdialogs/src/strings.dart';

SnackBar _snackBar({String? message}) {
  message ??= 'Operation completed successfully';
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    duration: const Duration(milliseconds: 1500),
    content: Text(message),
  );
}

Future<T?> showAsyncProgressKDialog<T>(
  BuildContext context, {
  required Future<T> Function() doProcess,
  void Function(T value)? onSuccess,
  void Function(String errMessage)? onError,
  bool retryable = false,
  bool confirmationRequired = false,
  String? confirmationTitle,
  String? confirmationMessage,
  bool showSuccessSnackBar = false,
  String? successMessage,
  String? errorAcceptText,
  String? errorRetryText,
  String? loadingMessage,
  String? bottomErrorAlertTitle,
}) async {
  confirmationMessage ??= strings.confirmationMessage;
  errorAcceptText ??= strings.acceptButtonText;
  errorRetryText ??= strings.errorRetryText;

  if (confirmationRequired) {
    final confirmed = await showConfirmationKDialog(
      context,
      title: confirmationTitle,
      message: confirmationMessage,
    );
    if (!confirmed) return null;
  }
  if (!context.mounted) return null;
  void Function() closeloader = () {};
  try {
    closeloader = loadingMessage == null
        ? await showKDialogWithLoadingIndicator(context)
        : await showKDialogWithLoadingMessage(context, message: loadingMessage);

    final results = await doProcess();
    if (context.mounted) closeloader();
    if (onSuccess != null) onSuccess(results);

    if (context.mounted && (showSuccessSnackBar || successMessage != null)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(_snackBar(message: successMessage));
    }

    return results;
  } catch (err) {
    if (context.mounted) closeloader();

    bool retry = false;
    if (context.mounted) {
      retry = await showBottomAlertKDialog(
        title: bottomErrorAlertTitle,
        context,
        message: err.toString(),
        retryable: retryable,
        acceptText: errorAcceptText,
        retryText: errorRetryText,
      );
    }

    if (retry && context.mounted) {
      return await showAsyncProgressKDialog(
        context,
        doProcess: doProcess,
        onError: onError,
        onSuccess: onSuccess,
        retryable: retryable,
        errorAcceptText: errorAcceptText,
        errorRetryText: errorRetryText,
      );
    }

    if (onError != null) onError(err.toString());
  }

  return null;
}
