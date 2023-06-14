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
        dividerTheme: DividerThemeData(color: Colors.transparent),
        colorScheme: ColorScheme.dark(
          primary: Colors.teal,
          onPrimary: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          filled: true,
          fillColor: Colors.white10,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
      ),
      home: const AuthGate(),
    );
  }
}
