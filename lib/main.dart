import 'dart:async';
import 'dart:developer';

import 'package:app/featues/main_page.dart';
import 'package:flutter/material.dart';

import 'config/injector.dart';

FutureOr<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await configureDependencies();
      runApp(const MyApp());
    },
    (error, stackTrace) {
      log('Error: $error');
      log('Stack Trace: $stackTrace');
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent[700],
          titleTextStyle: const TextStyle(color: Colors.white),
        ),
      ),
      home: const MainPage(),
    );
  }
}
