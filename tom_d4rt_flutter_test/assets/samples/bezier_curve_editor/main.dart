// Entry point for the bezier_curve_editor sample (example #19).
//
// The in-tester harness (`SourceFlutterD4rt.buildMultiFile`) calls
// a top-level `Widget build(BuildContext)` rather than `main()`, so
// this file exposes that contract directly.
import 'package:flutter/material.dart';

import 'home.dart';

Widget build(BuildContext context) {
  return const MaterialApp(
    title: 'Bezier curve editor',
    home: BezierHome(),
  );
}
