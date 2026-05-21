// Entry point for the todo_list sample (example #13).
//
// The in-tester harness (`SourceFlutterD4rt.buildMultiFile`) calls a
// top-level `Widget build(BuildContext)` rather than `main()`, so
// this file exposes that contract directly.
import 'package:flutter/material.dart';

import 'home.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Todo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    ),
    home: const TodoListHome(),
  );
}
