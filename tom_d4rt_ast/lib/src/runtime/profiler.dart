import 'dart:math' show max;

/// Compile-time-gated profiler for D4rt's **initialization** path.
///
/// This profiler measures the one-time setup work that happens when a D4rt
/// runner is constructed and prepared for a run — bridge finalization,
/// warm-parent environment assembly, stdlib registration, module-loader
/// construction, and the declaration/registration passes that precede the
/// actual `main()` call. It is **not** a profiler for the interpreter's hot
/// path; instrumentation deliberately stops at the point where script
/// interpretation begins.
///
/// ## Zero runtime cost when disabled
///
/// [enabled] is a `static const bool`. Every measurement site is written as an
/// `if (D4rtProfiler.enabled) { ... }` guard (or a
/// `D4rtProfiler.enabled ? ... : null` ternary). When [enabled] is `false` the
/// Dart compiler (VM TFA / AOT / dart2js) constant-folds the condition and
/// eliminates the guarded code entirely — no `Stopwatch` allocation, no map
/// lookup, and no call overhead in a normal run.
///
/// ## CRITICAL — never publish with [enabled] == `true`
///
/// Flip [enabled] to `true` only for a local profiling session, then revert it
/// before committing or publishing the package. A `true` value would leave the
/// instrumentation live in shipped builds. A guard test
/// (`test/profiler_disabled_test.dart`) asserts it stays `false`.
///
/// Twin of `tom_d4rt/lib/src/profiler.dart` — keep both in sync.
class D4rtProfiler {
  D4rtProfiler._();

  /// Master compile-time switch. **MUST remain `false` in published code.**
  static const bool enabled = false;

  static final Map<String, _ProfileEntry> _entries = <String, _ProfileEntry>{};
  static final List<String> _order = <String>[];

  /// Records an elapsed [micros] span under [name].
  ///
  /// Only call from inside an `if (D4rtProfiler.enabled)` guard so it is
  /// dead-code-eliminated when the profiler is off.
  static void record(String name, int micros) {
    var entry = _entries[name];
    if (entry == null) {
      entry = _ProfileEntry(name);
      _entries[name] = entry;
      _order.add(name);
    }
    entry.totalMicros += micros;
    entry.count++;
  }

  /// Clears all recorded spans (e.g. between profiling runs).
  static void reset() {
    _entries.clear();
    _order.clear();
  }

  /// Whether any spans have been recorded.
  static bool get hasData => _entries.isNotEmpty;

  /// JSON-serializable snapshot: `{name: {us, ms, n}}` in record order.
  static Map<String, dynamic> snapshot() {
    final out = <String, dynamic>{};
    for (final name in _order) {
      final e = _entries[name]!;
      out[name] = <String, dynamic>{
        'us': e.totalMicros,
        'ms': e.totalMicros / 1000.0,
        'n': e.count,
      };
    }
    return out;
  }

  /// Human-readable multi-line report, longest span first.
  static String report({String title = 'D4rt init profile'}) {
    if (_entries.isEmpty) return '$title: (no spans recorded)';
    final rows = _entries.values.toList()
      ..sort((a, b) => b.totalMicros.compareTo(a.totalMicros));
    final nameW = rows.map((e) => e.name.length).fold<int>(4, max);
    final buf = StringBuffer()..writeln('$title:');
    for (final e in rows) {
      final ms = (e.totalMicros / 1000.0).toStringAsFixed(3);
      buf.writeln('  ${e.name.padRight(nameW)}  ${ms.padLeft(10)} ms  '
          '(${e.count}x)');
    }
    return buf.toString().trimRight();
  }
}

class _ProfileEntry {
  _ProfileEntry(this.name);
  final String name;
  int totalMicros = 0;
  int count = 0;
}
