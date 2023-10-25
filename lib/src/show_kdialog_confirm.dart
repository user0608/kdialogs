import 'package:flutter/material.dart';

Future<bool> showKDialogConfirm(
  BuildContext context, {
  String? title,
  String message = "Before proceeding, Please confirm this action.",
  String acceptText = "CONFIRM",
  String cancelText = "CANCEL",
}) async {
  final width = MediaQuery.of(context).size.width;
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: title != null ? Text(title) : null,
          content: SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(width: width),
                ListBody(
                  children: [
                    Text(message),
                  ],
                ),
              ],
            ),
          ),
          actionsPadding: title == null ? const EdgeInsets.only(right: 24, bottom: 8) : null,
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
  return result ?? false;
}
