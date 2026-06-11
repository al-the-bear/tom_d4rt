// Entry point for the self-running particle-field profiling sample.
//
// Like the other samples, the in-tester harness
// (`SourceFlutterD4rt.buildProgram`) calls a top-level
// `Widget build(BuildContext)` rather than `main()`.
//
// This sample is wired to start on its own — see `home.dart`. Launch it
// hands-free via the host app's autorun:
//   flutter run -d macos --profile \
//       --dart-define=AUTORUN_SAMPLE=profiler_field
import 'package:flutter/material.dart';

import 'home.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Profiler · Particle Field',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
    ),
    home: const ProfilerFieldHome(),
  );
}
