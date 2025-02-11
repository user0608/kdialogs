import 'package:flutter/material.dart';
import 'package:kdialogs/src/strings.dart';

Future<bool> showBottomAlertKDialog(
  BuildContext context, {
  String? title,
  required String message,
  bool retryable = false,
  String? acceptText,
  String? retryText,
}) async {
  title ??= strings.bottomErrorAlertTitle;
  acceptText ??= strings.acceptButtonText;
  retryText ??= strings.errorRetryText;
  final result = await showModalBottomSheet<bool>(
    context: context,
    isDismissible: false,
    backgroundColor: Colors.transparent,
    useSafeArea: true,
    enableDrag: true,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      title ?? "Alert message",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16.0,
                      ),
                      child: SingleChildScrollView(
                        child: Text(message, textAlign: TextAlign.start),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: retryable,
                          child: TextButton(
                            onPressed: () =>
                                Navigator.of(context).pop(retryable),
                            child: Text(retryText ?? "RETRY"),
                          ),
                        ),
                        const SizedBox(width: 22),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(acceptText ?? "ACCEPT"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
  return result ?? false;
}
