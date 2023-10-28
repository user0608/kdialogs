import 'package:flutter/material.dart';

Future<List<T>> showBasicOptionsKDialog<T>(
  BuildContext context, {
  required Set<T> options,
  bool allowMultipleSelection = false,
  bool searchInput = false,
  String? title,
  String acceptText = "OK",
  String cancelText = "Cancel",
}) async {
  var selectedOptions = <T>{};

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
  if (!(result ?? false)) return [];
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
            decoration: InputDecoration(
              hintText: "Search",
              suffixIcon: IconButton(
                onPressed: () {
                  _searchController.clear();
                  search(_searchController.text);
                },
                icon: const Icon(Icons.clear_rounded),
              ),
            ),
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
