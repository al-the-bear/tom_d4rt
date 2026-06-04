// Entry point for the note_app sample (example #14).
//
// The in-tester harness (`SourceFlutterD4rt.buildMultiFile`) calls a
// top-level `Widget build(BuildContext)` rather than `main()`, so
// this file exposes that contract directly.
import 'package:flutter/material.dart';

import 'app.dart';

Widget build(BuildContext context) {
  return const NoteApp();
}
