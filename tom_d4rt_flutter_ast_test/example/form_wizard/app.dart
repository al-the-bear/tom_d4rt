// MaterialApp wrapper for the form_wizard sample.
//
// Kept in its own file so `main.dart` reads cleanly as just the
// `Widget build(BuildContext)` contract the harness expects.
import 'package:flutter/material.dart';

import 'home.dart';

class FormWizardApp extends StatelessWidget {
  const FormWizardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign up',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const FormWizardHome(),
    );
  }
}
