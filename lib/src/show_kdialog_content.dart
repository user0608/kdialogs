import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kdialogs/src/strings.dart';

Future<T?> showKDialogContent<T>(
  BuildContext context, {
  EdgeInsetsGeometry contentPadding = const EdgeInsets.only(
    left: 16.0,
    right: 16.0,
    bottom: 8.0,
  ),
  EdgeInsetsGeometry scrollPadding = const EdgeInsets.only(bottom: 24),
  EdgeInsetsGeometry titlePadding =
      const EdgeInsets.only(right: 8.0, left: 8.0, top: 5.0),
  TextButton? titleTextButton,
  String? title,
  String? saveBtnText,
  FutureOr<bool> Function()? onSave, // ✅ Cambiado a Future<bool>
  bool closeOnOutsideTap = false,
  bool hideTitleBar = false,
  bool allowBackButtonToClose = true,
  Color? backgroundColor,
  required Widget Function(BuildContext context) builder,
}) async {
  title ??= strings.defaultDialogTitle;
  saveBtnText ??= strings.saveButtonText;

  Widget? titleWidget;
  if (!hideTitleBar) {
    titleWidget = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              IconButton(
                iconSize: 25,
                onPressed: () => Navigator.of(context).pop(null),
                icon: const Icon(Icons.close),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              )
            ],
          ),
        ),
        if (onSave != null)
          TextButton(
            onPressed: () async {
              bool shouldClose =
                  await onSave(); // ✅ Esperamos el resultado de onSave
              if (shouldClose && context.mounted) {
                Navigator.of(context)
                    .pop(true); // ✅ Cierra el diálogo si onSave devuelve true
              }
            },
            style: Theme.of(context).textButtonTheme.style,
            child: Text(saveBtnText),
          ),
      ],
    );
  }

  return await showDialog<T>(
    context: context,
    barrierDismissible: closeOnOutsideTap,
    useSafeArea: true,
    builder: (context) {
      return PopScope(
        canPop: allowBackButtonToClose,
        child: AlertDialog(
          backgroundColor: backgroundColor,
          titlePadding: titlePadding,
          title: titleWidget,
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            padding: scrollPadding,
            child: Padding(
              padding: contentPadding,
              child: builder(context),
            ),
          ),
          actionsPadding: EdgeInsets.zero,
        ),
      );
    },
  );
}
