import 'package:flutter/material.dart';

/// The showKBottomErrorMessage function returns true if the "Retry Operation" option is selected
/// and false in all other cases.
Future<bool> showKBottomErrorMessage(
  BuildContext context, {
  String title = "Error, Something was wrong...",
  required String message,
  bool retryable = false,
  String acceptText = "ACCEPT",
  String retryText = "RETRY",
}) async {
  final size = MediaQuery.of(context).size;
  final result = await showModalBottomSheet<bool>(
    context: context,
    isDismissible: false,
    backgroundColor: Colors.transparent,
    useSafeArea: true,
    enableDrag: true,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
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
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  SizedBox(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: size.height * 0.4,
                        minHeight: 55,
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
                            onPressed: () => Navigator.of(context).pop(retryable),
                            child: Text(retryText),
                          ),
                        ),
                        const SizedBox(width: 22),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(acceptText),
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
