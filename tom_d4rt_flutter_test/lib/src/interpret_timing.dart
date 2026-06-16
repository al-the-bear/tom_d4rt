// Interpretation timing instrumentation for the demo/test app.
//
// Wraps a D4rt interpret call (`build` / `buildProgram` / `buildMultiFile`)
// with the opt-in [D4rtProfile] phase profiler so the per-build cost breakdown
// is visible in the console and queryable by the UI.
//
// Why this exists: interpreting a Flutter script through SourceFlutterD4rt
// stalls ~0.8s per build (and ~1.4s the very first time). A headless
// experiment (test/interpret_timing_profile_test.dart) attributed the cost —
// it is NOT the analyzer parse (~1ms) and NOT the complexity of the widget
// tree (a 1000-line sample costs the same as a one-widget snippet). It is
// `pass2.imports` (single-file) / `parse`→ModuleLoader (multi-file): resolving
// the `import 'package:flutter/material.dart'` directive re-registers the whole
// Material bridge surface by name into a fresh scope on every execute().

import 'package:flutter/foundation.dart';
import 'package:tom_d4rt_flutter/tom_d4rt_flutter.dart' show D4rtProfile;

/// The phase breakdown + wall time of the most recent [timedInterpret] call,
/// so a UI overlay can display it without re-running the profiler.
class LastInterpretTiming {
  /// Label of the last measured build (e.g. the script name).
  static String? label;

  /// Total wall time of the last interpret call, in milliseconds.
  static double wallMs = 0;

  /// The last [D4rtProfile.report] output (per-phase breakdown).
  static String report = '';

  /// True once at least one build has been measured.
  static bool get hasData => label != null;
}

/// Runs [body] (a D4rt interpret call) with the [D4rtProfile] enabled, records
/// the phase breakdown into [LastInterpretTiming], logs it, and returns the
/// body's result. Restores the profiler's prior enabled state so nested or
/// concurrent measurement does not leak the flag.
T timedInterpret<T>(String label, T Function() body) {
  final priorEnabled = D4rtProfile.enabled;
  D4rtProfile.enabled = true;
  D4rtProfile.reset();
  final sw = Stopwatch()..start();
  try {
    return body();
  } finally {
    sw.stop();
    LastInterpretTiming.label = label;
    LastInterpretTiming.wallMs = sw.elapsedMicroseconds / 1000.0;
    LastInterpretTiming.report = D4rtProfile.report();
    D4rtProfile.enabled = priorEnabled;
    debugPrint('[interpret-timing] "$label" '
        'wall=${LastInterpretTiming.wallMs.toStringAsFixed(1)}ms\n'
        '${LastInterpretTiming.report}');
  }
}
