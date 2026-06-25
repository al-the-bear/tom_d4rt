import 'package:tom_d4rt/d4rt.dart' show D4rtProfiler;

/// Shared compile-time profiling switch for the flutter (source) test harness.
///
/// Both the HTTP test app (`test/tom_d4rt_flutter_test_app`) and the test
/// drivers (`test/send_test_runner.dart` and the profiler scripts) reference
/// this single class so there is one source of truth for whether D4rt's
/// init-path profiler is compiled in.
///
/// [enabled] simply mirrors the interpreter's [D4rtProfiler.enabled] gate. When
/// the interpreter profiler is off (`false` — the published default), every
/// profiling branch in the app and driver is dead-code-eliminated, so there is
/// zero runtime cost.
///
/// ## CRITICAL — never publish with profiling on
///
/// Profiling requires flipping `D4rtProfiler.enabled` to `true` in `tom_d4rt`
/// (and using a path dependency so the change is picked up). Revert it before
/// committing or publishing — the `profiler_disabled_test.dart` guards enforce
/// this in the interpreter packages.
class ProfilingMetrics {
  ProfilingMetrics._();

  /// True when D4rt's init-path profiler is compiled in.
  static const bool enabled = D4rtProfiler.enabled;

  /// JSON-serializable snapshot of the recorded init-path spans.
  static Map<String, dynamic> snapshot() => D4rtProfiler.snapshot();

  /// Human-readable multi-line report of the recorded init-path spans.
  static String report({String title = 'D4rt init profile'}) =>
      D4rtProfiler.report(title: title);

  /// Clears all recorded spans (e.g. between profiling runs).
  static void reset() => D4rtProfiler.reset();
}
