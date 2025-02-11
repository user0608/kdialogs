import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kdialogs/kdialogs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KDialogs',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () async {
                    final close = await showKDialogWithLoadingMessage(context);
                    await Future.delayed(const Duration(seconds: 2));
                    close();
                  },
                  child: const Text("Loading With Message"),
                ),
                FilledButton(
                  onPressed: () async {
                    final close =
                        await showKDialogWithLoadingIndicator(context);
                    await Future.delayed(const Duration(seconds: 2));
                    close();
                  },
                  child: const Text("Just Loading"),
                ),
                FilledButton(
                  onPressed: () async {
                    await showBottomAlertKDialog(
                      context,
                      message: "This is an error message",
                      retryable: true,
                    );
                  },
                  child: const Text("Bottom Error Message"),
                ),
                FilledButton(
                  onPressed: () async {
                    await showBottomAlertKDialog(
                      context,
                      message:
                          "This is an error message. It is intentionally very long to test the dialog's capacity to handle extensive text. "
                          "Sometimes, error messages can be lengthy and descriptive, providing detailed information about what went wrong, "
                          "suggested solutions, and even additional debugging steps. If the dialog is properly designed, it should be able to "
                          "wrap the text correctly, offer scrolling if necessary, and ensure that the message remains readable on different screen sizes.",
                      retryable: true,
                    );
                  },
                  child: const Text("Large Error Message"),
                ),
                FilledButton(
                  onPressed: () async {
                    await showKDialogContent(
                      context,
                      closeOnOutsideTap: false,
                      onSave: () {
                        return true;
                      },
                      title: "Title",
                      builder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Hello there!!!"),
                            Container(
                              color: Colors.green,
                              width: 100.0,
                              height: 800.0,
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: const Text("Show Simple Content"),
                ),
                TextButton(
                  onPressed: () async {
                    final _ = await showConfirmationKDialog(context,
                        message: "Are you sure?");
                  },
                  child: const Text("Simple Confirm Dialog"),
                ),
                FilledButton(
                  onPressed: () async {
                    final _ = await showConfirmationKDialog(context,
                        title: "Confirm Message");
                  },
                  child: const Text("Show Confirm Dialog"),
                ),
                FilledButton(
                  onPressed: () async {
                    final _ = await showAsyncProgressKDialog<String>(
                      context,
                      doProcess: () async {
                        await Future.delayed(const Duration(seconds: 2));
                        return "value";
                      },
                      showSuccessSnackBar: true,
                    );
                  },
                  child: const Text("Success Process"),
                ),
                FilledButton(
                  onPressed: () async {
                    final _ = await showAsyncProgressKDialog<String>(
                      context,
                      doProcess: () async {
                        await Future.delayed(const Duration(seconds: 2));
                        throw "This is an error indicating that the process could not be completed";
                      },
                      showSuccessSnackBar: true,
                    );
                  },
                  child: const Text("Process With Error"),
                ),
                FilledButton(
                  onPressed: () async {
                    final _ = await showAsyncProgressKDialog<String>(
                      context,
                      doProcess: () async {
                        await Future.delayed(const Duration(seconds: 2));
                        throw "This is an error indicating that the process could not be completed";
                      },
                      confirmationRequired: true,
                      showSuccessSnackBar: true,
                      loadingMessage: "Procesing...",
                      retryable: true,
                    );
                  },
                  child: const Text("Process With Error and Retry"),
                ),
                FilledButton(
                  onPressed: () async {
                    final selecteds = await showBasicOptionsKDialog(
                      context,
                      allowMultipleSelection: true,
                      searchInput: true,
                      initialSelection: ["Opcion 1", "Opcion 5"],
                      options: getOptions(),
                    );
                    if (selecteds == null) return;
                    for (final v in selecteds) {
                      debugPrint(v.getLabel());
                    }
                  },
                  child: const Text("Show Options With Initial String"),
                ),
                FilledButton(
                  onPressed: () async {
                    final result = await showBasicOptionsKDialog(
                      context,
                      allowMultipleSelection: true,
                      searchInput: true,
                      initialSelection: [Person(id: "2", name: "Jose")]
                          .map((p) => p.getID())
                          .toList(),
                      options: [
                        Person(id: "1", name: "Kevin"),
                        Person(id: "2", name: "Jose"),
                        Person(id: "3", name: "Martin"),
                      ],
                    );
                    if (result == null) return;
                    for (var i in result) {
                      if (kDebugMode) print(i.name);
                    }
                  },
                  child: const Text("Show Options With Initial Options"),
                ),
                FilledButton(
                  onPressed: () async {
                    final _ = await showBasicOptionsKDialog(
                      context,
                      allowMultipleSelection: true,
                      searchInput: true,
                      title: 'List Options',
                      options: getOptions(),
                    );
                  },
                  child: const Text("Show Options"),
                ),
                FilledButton(
                  onPressed: () async {
                    final selecteds = await showAsyncOptionsDialog(
                      context,
                      allowMultipleSelection: true,
                      searchInput: true,
                      initialSelection: ["Opcion 1"],
                      getOptions: () async {
                        final options = getOptions();
                        await Future.delayed(const Duration(seconds: 1));
                        return options;
                      },
                    );
                    if (selecteds == null) return;
                    for (final v in selecteds) {
                      debugPrint(v.getLabel());
                    }
                  },
                  child: const Text("Show Async Options"),
                ),
                FilledButton(
                  onPressed: () async {
                    final _ = await showConfirmationKDialogWithCallback(
                      context,
                      onConfirm: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("OK!!!")),
                        );
                      },
                    );
                  },
                  child: const Text("On Confirm DO"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<SelectOption> getOptions() {
  const values = [
    "Opcion 1",
    "Opcion 2",
    "Opcion 3",
    "Opcion 4",
    "Opcion 5",
    "Opcion 6",
    "Opcion 7",
    "Opcion 8",
    "Opcion 9",
    "Opcion 10",
    "Opcion 11",
    "Opcion 12",
    "Opcion 13",
    "Opcion 14",
    "Opcion 15",
    "Opcion 16",
    "Opcion 17",
    "Opcion 18",
    "Opcion 19",
    "Opcion 20",
    "Opcion 21",
    "Opcion 22",
  ];
  return stringOptionsAdapter(values);
}

class Person implements SelectOption {
  final String? id;
  final String? name;

  Person({
    this.id,
    this.name,
  });

  @override
  String getID() => id ?? "-";
  @override
  String getLabel() => name ?? "-";
}
