import 'package:flutter/material.dart';

Future<bool?> showKDialogConfirm(
  BuildContext context, {
  String? title,
  String message = "Before proceeding, Please confirm this action.",
  String acceptText = "CONFIRM",
  String cancelText = "CANCEL",
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: title != null ? Text(title) : null,
          content: SingleChildScrollView(
            child: ListBody(
              children: [Text(message)],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelText, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(acceptText, style: const TextStyle(fontWeight: FontWeight.bold)),
            )
          ],
        ),
      );
    },
  );
}
