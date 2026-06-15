// Entry point for the tip_calculator sample (example #12).
//
// The in-tester harness (`SourceFlutterD4rt.buildMultiFile`) calls a
// top-level `Widget build(BuildContext)` rather than `main()`, so
// this file exposes that contract directly.
import 'package:flutter/material.dart';

import 'home.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Tip Calculator',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    ),
    home: const TipCalculatorHome(),
  );
}
