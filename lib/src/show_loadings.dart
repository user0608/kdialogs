import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kdialogs/src/strings.dart';

/// returns a function with which we can finish the loading process.
Future<void Function()> showKDialogWithLoadingMessage(
  BuildContext context, {
  String message = "",
  TextStyle textStyle =
      const TextStyle(color: Colors.black38, fontSize: 14, height: 1.2),
}) async {
  message = message.isNotEmpty ? message : strings.loadingDialogMessage;
  final completer = Completer<void Function()>();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      dismiss() => Navigator.of(context).pop();
      if (!completer.isCompleted) completer.complete(dismiss);

      return PopScope(
        canPop: false,
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(24),
          content: SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Text(
                    message,
                    style: textStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  return completer.future;
}

Future<void Function()> showKDialogWithLoadingIndicator(
    BuildContext context) async {
  final completer = Completer<void Function()>();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      dismiss() => Navigator.of(context).pop();
      if (!completer.isCompleted) {
        completer.complete(dismiss);
      }
      return const PopScope(
        canPop: false,
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      );
    },
  );

  return completer.future;
}
