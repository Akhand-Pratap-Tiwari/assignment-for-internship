import 'package:flutter/material.dart';

import 'auth_gate.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment',
      debugShowCheckedModeBanner: true,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        primaryColor: Colors.amber,
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          extendedTextStyle:
              TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      home: const AuthGate(),
    );
  }
}
