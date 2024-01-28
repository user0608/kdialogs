import 'package:flutter/material.dart';
import 'package:kdialogs/src/strings.dart';

/// returns a function with which we can finish the loading process.
Future<void Function()> showKDialogWithLoadingMessage(
  BuildContext context, {
  String? message,
  TextStyle? textStyle,
}) async {
  textStyle ??=
      const TextStyle(color: Colors.black38, fontSize: 14, height: 1.2);
  message ??= strings.loadingDialogMessage;
  void Function()? clouser;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      clouser = () => Navigator.of(context).pop(null);
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
                    message ?? "",
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
  while (clouser == null) {
    // wait until the closure variable becomes non-null.
    await Future.delayed(const Duration(milliseconds: 1));
  }
  return clouser ?? () => {};
}

Future<void Function()> showKDialogWithLoadingIndicator(
    BuildContext context) async {
  void Function()? clouser;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      clouser = () => Navigator.of(context).pop(null);
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
  while (clouser == null) {
    // wait until the closure variable becomes non-null.
    await Future.delayed(const Duration(milliseconds: 1));
  }
  return clouser ?? () => {};
}
