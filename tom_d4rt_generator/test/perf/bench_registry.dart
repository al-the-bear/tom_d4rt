/// Registry of D4rt performance benchmark scripts.
///
/// Shared by the timing test (`d4rt_perf_test.dart`) and the CPU-profiling
/// driver (`d4rt_cpu_profile.dart`) so both run exactly the same corpus.
library;

import 'dart:io';

import 'package:path/path.dart' as p;

/// A named benchmark backed by a script file.
class BenchEntry {
  /// Short display name (used in tables and as a profiler filter key).
  final String name;

  /// Script filename within the perf `scripts/` directory.
  final String fileName;

  /// `micro` = focused single-feature loop; `macro` = wraps a whole
  /// dart_overview area and repeats it.
  final String kind;

  const BenchEntry(this.name, this.fileName, this.kind);
}

/// All benchmarks, micro first then macro. Order is the report order.
const List<BenchEntry> benchmarks = [
  // --- focused micro-benchmarks: one interpreter facet each ---
  BenchEntry('arithmetic', 'bench_arithmetic.dart', 'micro'),
  BenchEntry('string_interp', 'bench_string_interp.dart', 'micro'),
  BenchEntry('list_ops', 'bench_list_ops.dart', 'micro'),
  BenchEntry('map_ops', 'bench_map_ops.dart', 'micro'),
  BenchEntry('method_dispatch', 'bench_method_dispatch.dart', 'micro'),
  BenchEntry('polymorphism', 'bench_polymorphism.dart', 'micro'),
  BenchEntry('closures', 'bench_closures.dart', 'micro'),
  BenchEntry('recursion_fib', 'bench_recursion_fib.dart', 'micro'),
  BenchEntry('pattern_switch', 'bench_pattern_switch.dart', 'micro'),
  BenchEntry('exceptions', 'bench_exceptions.dart', 'micro'),
  // --- macro-benchmarks: wrap a real dart_overview area ---
  BenchEntry('wrap_collections', 'wrap_collections.dart', 'macro'),
  BenchEntry('wrap_classes', 'wrap_classes.dart', 'macro'),
];

/// Resolve the absolute path to the perf `scripts/` directory.
///
/// Tests/tools run from the package root, so the canonical location is
/// `example/dart_overview/perf/scripts`. We also walk a couple of fallbacks
/// in case the working directory is the repo root or the perf folder itself.
String resolveScriptsDir() {
  const rel = 'example/dart_overview/perf/scripts';
  final candidates = <String>[
    rel,
    p.join('tom_d4rt_generator', rel),
    p.join('..', '..', rel),
    'scripts',
  ];
  for (final c in candidates) {
    if (Directory(c).existsSync()) {
      return Directory(c).resolveSymbolicLinksSync();
    }
  }
  throw StateError(
    'Could not locate perf scripts directory. Tried: ${candidates.join(', ')} '
    'from ${Directory.current.path}',
  );
}

/// Absolute path to a benchmark's script file.
String scriptPathFor(BenchEntry entry, String scriptsDir) =>
    p.join(scriptsDir, entry.fileName);
