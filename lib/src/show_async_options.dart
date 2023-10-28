import 'package:flutter/material.dart';
import 'package:kdialogs/kdialogs.dart';

/// Every item must have a unique value,
/// and string values are extracted from the ToString function.
/// To compare objects, please refer to the documentation at
/// https://dart.dev/effective-dart/design#equality.
/// Or use an alternative package like https://pub.dev/packages/equatable
///
Future<List<T>?> showAsyncOptionsDialog<T>(
  BuildContext context, {
  required Future<Set<T>> getOptions,
  bool allowMultipleSelection = false,
  bool searchInput = false,
  String? title,
  String acceptText = "OK",
  String cancelText = "Cancel",
}) async {
  final options = await showAsyncProgressKDialog(context, doProcess: () => getOptions);
  if (options == null) return [];
  if (context.mounted) {
    return await showBasicOptionsKDialog(context,
        options: options,
        allowMultipleSelection: allowMultipleSelection,
        searchInput: searchInput,
        title: title,
        acceptText: acceptText,
        cancelText: cancelText);
  }
  return null;
}
