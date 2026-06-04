// Entry point for the kanban_board sample (example #18).
//
// The in-tester harness (`SourceFlutterD4rt.buildMultiFile`) calls
// a top-level `Widget build(BuildContext)` rather than `main()`, so
// this file exposes that contract directly.
import 'package:flutter/material.dart';

import 'home.dart';

Widget build(BuildContext context) {
  return const MaterialApp(
    title: 'Kanban Board',
    home: KanbanHome(),
  );
}
