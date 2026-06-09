/// D4rt interpreter performance timing test.
///
/// This is a *throughput + regression* test, not a hard threshold gate. For
/// each benchmark script it:
///   - runs the harness (warmup + measured `compute()` calls),
///   - asserts the script executed successfully and returned a checksum
///     (so a script that starts throwing or returns null fails here),
///   - records ns/op for the printed report.
///
/// It runs with the `BenchConfig.quick` budget so the whole suite finishes in
/// a few seconds under `dart test` / `testkit`. For real profiling numbers run
/// the full-budget driver via `test/perf/run_profile.sh` (see perf/README.md).
///
/// We do NOT assert absolute timings: CI hosts vary wildly and a wall-clock
/// threshold would be a flaky gate. The value here is (a) proof every
/// interpreter path still executes, and (b) a human-readable throughput table
/// in the test log for tracking trends across commits.
@Timeout(Duration(minutes: 4))
library;

import 'package:test/test.dart';

import 'bench_registry.dart';
import 'd4rt_perf_harness.dart';

void main() {
  group('D4rt interpreter performance', () {
    late final String scriptsDir;
    final results = <BenchResult>[];

    setUpAll(() {
      scriptsDir = resolveScriptsDir();
    });

    for (final entry in benchmarks) {
      test('${entry.kind}: ${entry.name} executes and is measured', () {
        final result = runFileBenchmark(
          entry.name,
          scriptPathFor(entry, scriptsDir),
          config: BenchConfig.quick,
        );
        results.add(result);

        // Regression guard: the script must have run cleanly...
        expect(result.success, isTrue,
            reason: 'benchmark ${entry.name} failed: ${result.error}');
        // ...completed at least one measured call...
        expect(result.calls, greaterThan(0),
            reason: '${entry.name} produced no measured calls');
        // ...and returned a non-null checksum (proves compute() ran a body).
        expect(result.checksum, isNotNull,
            reason: '${entry.name} returned a null checksum');
      });
    }

    tearDownAll(() {
      // Emit a throughput table to the test log for trend tracking.
      final buffer = StringBuffer()
        ..writeln('')
        ..writeln('=== D4rt interpreter throughput (quick budget) ===')
        ..writeln(resultTableHeader());
      for (final r in results) {
        buffer.writeln(formatResultRow(r));
      }
      buffer.writeln('Note: quick budget — relative comparison only. '
          'Use run_profile.sh for full-budget numbers and CPU samples.');
      // Use printOnFailure-independent stdout: a plain print is fine here.
      // ignore: avoid_print
      print(buffer.toString());
    });
  });
}
