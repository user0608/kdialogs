import 'package:flutter/material.dart';
import 'package:kdialogs/src/strings.dart';

Future<bool> showConfirmationKDialog(
  BuildContext context, {
  String? title,
  String? message,
  String? acceptText,
  String? cancelText,
}) async {
  message ??= strings.confirmDialogText;
  acceptText ??= strings.confirmButtonText;
  cancelText ??= strings.cancelButtonText;

  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          title: title != null ? Text(title) : null,
          content: SingleChildScrollView(
            child: Text(message!),
          ),
          actionsPadding: title == null
              ? const EdgeInsets.only(right: 24, bottom: 8)
              : null,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                cancelText!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                acceptText!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    },
  );

  return result ?? false;
}

Future<bool> showConfirmationKDialogWithCallback(
  BuildContext context, {
  required void Function() onConfirm,
  String? title,
  String? message,
  String? acceptText,
  String? cancelText,
}) async {
  final bool answer = await showConfirmationKDialog(
    context,
    title: title,
    acceptText: acceptText,
    cancelText: cancelText,
    message: message,
  );

  if (answer == true) onConfirm();

  return answer;
}
