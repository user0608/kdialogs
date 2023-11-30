import 'package:flutter/material.dart';

Future<T?> showKDialogContent<T>(
  BuildContext context, {
  EdgeInsetsGeometry contentPadding = const EdgeInsets.symmetric(horizontal: 24),
  EdgeInsetsGeometry scrollPadding = const EdgeInsets.only(bottom: 24),
  EdgeInsetsGeometry titlePading = const EdgeInsets.only(right: 8.0, left: 8.0, top: 5.0),
  TextButton? titleTextButton,
  String? title = "Title!",
  String saveBtnText = "Save",
  void Function()? onSave,
  bool closeOnOutsideTab = false,
  bool batToClose = true,
  bool hideTitileBar = false,
  bool allowBackButtonToClose = true,
  Color? backgroundColor,
  required Widget Function(BuildContext context) builder,
}) async {
  Widget? titleWidget;
  if (!hideTitileBar) {
    titleWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 25,
          onPressed: () => Navigator.of(context).pop(null),
          icon: const Icon(Icons.close),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 1.0),
          child: Text(
            title ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: onSave != null,
                child: TextButton(
                  onPressed: () => {if (onSave != null) onSave()},
                  style: Theme.of(context).textButtonTheme.style,
                  child: Text(saveBtnText),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
  return await showDialog(
    context: context,
    barrierDismissible: closeOnOutsideTab,
    useSafeArea: true,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => allowBackButtonToClose,
        child: AlertDialog(
          backgroundColor: backgroundColor,
          titlePadding: titlePading,
          title: titleWidget,
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            padding: scrollPadding,
            child: Padding(
              padding: contentPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: double.maxFinite),
                  builder(context),
                ],
              ),
            ),
          ),
          actionsPadding: EdgeInsets.zero,
        ),
      );
    },
  );
}
