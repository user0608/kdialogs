import 'package:flutter/material.dart';
import 'package:kdialogs/src/strings.dart';

/// Every item must have a unique value,
/// and string values are extracted from the ToString function.
/// To compare objects, please refer to the documentation at
/// https://dart.dev/effective-dart/design#equality.
/// Or use an alternative package like https://pub.dev/packages/equatable

abstract class SelectOption {
  String getID();
  String getLabel();
}

class StringOption implements SelectOption {
  final String value;
  const StringOption(this.value);
  @override
  String getID() => value;
  @override
  String getLabel() => value;
}

List<StringOption> stringOptionsAdapter(List<String> values) {
  return values.map((s) => StringOption(s)).toList();
}

Future<List<T>?> showBasicOptionsKDialog<T extends SelectOption>(
  BuildContext context, {
  required List<T> options,
  List<String> initialSelection = const [],
  bool allowMultipleSelection = false,
  bool searchInput = false,
  String? title,
  String? acceptText,
  String? cancelText,
}) async {
  acceptText ??= strings.acceptButtonText;
  cancelText ??= strings.cancelButtonText;

  var selectedOptions = options
      .where((opt) => initialSelection.contains(opt.getID()))
      .toSet(); // Evita duplicados

  bool isSelected(T itm) => selectedOptions.contains(itm);
  void select(T itm) {
    if (!allowMultipleSelection) selectedOptions.clear();
    selectedOptions.add(itm);
  }

  void unselect(T itm) => selectedOptions.remove(itm);

  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          title: title != null ? Text(title) : null,
          content: _Content<T>(
            options: options,
            select: select,
            unselect: unselect,
            isSelected: isSelected,
            searchInput: searchInput,
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
  return result == true ? selectedOptions.toList() : null;
}

class _Content<T extends SelectOption> extends StatefulWidget {
  const _Content({
    required this.options,
    required this.select,
    required this.unselect,
    required this.isSelected,
    required this.searchInput,
  });

  final bool searchInput;
  final List<T> options;
  final Function(T) select;
  final Function(T) unselect;
  final bool Function(T) isSelected;

  @override
  State<_Content<T>> createState() => _ContentState<T>();
}

class _ContentState<T extends SelectOption> extends State<_Content<T>> {
  final _searchController = TextEditingController();
  late List<T> _filteredOptions;

  @override
  void initState() {
    _filteredOptions = widget.options;
    super.initState();
  }

  void search(String value) {
    setState(() {
      _filteredOptions = widget.options
          .where((elm) =>
              elm.getLabel().toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.searchInput)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextField(
              controller: _searchController,
              decoration:
                  InputDecoration(hintText: strings.searchLabelInputText),
              onChanged: search,
            ),
          ),
        Expanded(
          child: SingleChildScrollView(
            child: ListBody(
              children: _filteredOptions.map((op) => buildItem(op)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildItem(T op) {
    return Row(
      children: [
        Checkbox(
          value: widget.isSelected(op),
          onChanged: (value) {
            setState(() {
              value == true ? widget.select(op) : widget.unselect(op);
            });
          },
        ),
        Expanded(
          child: Text(op.getLabel()),
        ),
      ],
    );
  }
}
