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
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () async {
                  final close = await showKLoadingIndicatorWithMessage(context);
                  await Future.delayed(const Duration(seconds: 2));
                  close();
                },
                child: const Text("Loading With Message"),
              ),
              FilledButton(
                onPressed: () async {
                  final close = await showKLoadingIndicator(context);
                  await Future.delayed(const Duration(seconds: 2));
                  close();
                },
                child: const Text("Just Loading"),
              ),
              FilledButton(
                onPressed: () async {
                  await showKBottomErrorMessage(context, message: "This is an error message", retryable: true);
                },
                child: const Text("Bottom Error Message"),
              ),
              FilledButton(
                onPressed: () async {
                  await showKDialogContent(
                    context,
                    closeOnOutsideTab: false,
                    builder: (context) {
                      return Column(
                        children: [
                          const Text("Hello there!!!"),
                          Container(
                            color: Colors.green,
                            width: 100.0,
                            height: 100.0,
                          )
                        ],
                      );
                    },
                  );
                },
                child: const Text("Show Simple Content"),
              ),
              FilledButton(
                onPressed: () async {
                  final _ = await showKDialogConfirm(context, title: "Confirm Message");
                },
                child: const Text("Show Confirm Dialog"),
              ),
              FilledButton(
                onPressed: () async {
                  final _ = await showKDialogProcessing<String>(
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
                  final _ = await showKDialogProcessing<String>(
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
                  final _ = await showKDialogProcessing<String>(
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
            ],
          ),
        ),
      ),
    );
  }
}
