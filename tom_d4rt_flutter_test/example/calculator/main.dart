// Calculator — entry #4 from `doc/example_app_plan.md`.
//
// Desk calculator with a `GridView.count` keypad, expression display
// at the top, scrolling history strip above the keys. Long-press
// backspace repeats. Built around the canonical d4rt-friendly
// pattern: script-defined `StatefulWidget` + `State<T>` + `setState`
// driving a plain (non-`ChangeNotifier`) engine class.
//
// Exercises:
//   * `GridView.count` button layout
//   * `setState` after every input (digit / operator / clear)
//   * Expression parser (two-pass operator precedence) script-side
//   * `Future.microtask` deferred housekeeping after `=`
//   * `LongPressGestureRecognizer` via `GestureDetector` on backspace
import 'package:flutter/material.dart';

import 'home.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Calculator',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        brightness: Brightness.light,
      ),
    ),
    home: const CalculatorHome(),
  );
}
