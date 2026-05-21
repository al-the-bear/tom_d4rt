// Entry point for the Conway's Game of Life D4rt sample.
//
// The in-tester harness (`SourceFlutterD4rt.buildMultiFile`) calls
// a top-level `Widget build(BuildContext)` rather than `main()`, so
// this file exposes that contract directly. When run as a real
// Flutter app you can wrap it with `runApp((c) => build(c))` from
// a separate launcher.
import 'package:flutter/material.dart';

import 'home.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: "Conway's Life",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        brightness: Brightness.light,
      ),
    ),
    home: const ConwayLifeHome(),
  );
}
