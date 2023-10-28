import 'package:flutter/material.dart';

/// Every item must have a unique value,
/// and string values are extracted from the ToString function.
/// To compare objects, please refer to the documentation at
/// https://dart.dev/effective-dart/design#equality.
/// Or use an alternative package like https://pub.dev/packages/equatable
Future<List<T>?> showBasicOptionsKDialog<T>(
  BuildContext context, {
  required Set<T> options,
  Set<String>? selectedStrings,
  Set<T>? selectedItems,
  bool allowMultipleSelection = false,
  bool searchInput = false,
  String? title,
  String acceptText = "OK",
  String cancelText = "Cancel",
}) async {
  var selectedOptions = <T>{};
  if (selectedStrings != null) {
    for (var opt in options) {
      if (selectedStrings.contains(opt.toString())) {
        selectedOptions.add(opt);
      }
    }
  }

  if (selectedItems != null) {
    selectedOptions.clear();
    for (var itm in options) {
      if (selectedItems.contains(itm)) {
        selectedOptions.add(itm);
      }
    }
  }

  void select(T itm) {
    if (!allowMultipleSelection) selectedOptions.clear();
    selectedOptions.add(itm);
  }

  void unselect(T itm) => selectedOptions.remove(itm);

  void isSelected(T itm) => selectedOptions.contains(itm);

  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: title != null ? Text(title) : null,
          content: _Content(
            options: options,
            select: select,
            unselect: unselect,
            isSelected: isSelected,
            searchInput: searchInput,
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
  if (!(result ?? false)) return null;
  return selectedOptions.toList();
}

class _Content<T> extends StatefulWidget {
  const _Content({
    required this.options,
    required this.select,
    required this.unselect,
    required this.isSelected,
    required this.searchInput,
  });

  final bool searchInput;
  final Set<T> options;
  final Function(T) select;
  final Function(T) unselect;
  final Function(T) isSelected;

  @override
  State<_Content<T>> createState() => _ContentState<T>();
}

class _ContentState<T> extends State<_Content<T>> {
  final _searchController = TextEditingController();
  late Set<T> _options;
  @override
  void initState() {
    _options = widget.options;
    super.initState();
  }

  Set<T> filterFunc(Set<T> elements, String filterValue) {
    return elements.where((elm) {
      final elmString = elm.toString().trim().toLowerCase();
      return elmString.contains(filterValue.trim().toLowerCase());
    }).toSet();
  }

  void search(String value) {
    final filter = filterFunc;
    setState(() {
      _options = filter(widget.options, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width),
        Visibility(
          visible: widget.searchInput,
          maintainSize: false,
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(hintText: "Search"),
            onChanged: search,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: widget.searchInput ? 60.0 : 0),
          child: SingleChildScrollView(
            child: ListBody(
              children: _options.map((op) => buildItem(op)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildItem(op) {
    return Row(
      children: [
        Checkbox(
            value: widget.isSelected(op),
            onChanged: (value) {
              setState(() {
                if (value ?? false) {
                  widget.select(op);
                } else {
                  widget.unselect(op);
                }
              });
            }),
        Expanded(
          child: Text(op.toString()),
        ),
      ],
    );
  }
}
