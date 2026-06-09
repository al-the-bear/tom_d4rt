// D4rt macro-benchmark: repeats the real `collections` overview area.
//
// Per the perf-suite design, this *wraps* an existing dart_overview area
// script (imported by relative path) and runs its `main()` many times. Unlike
// the focused micro-benchmarks, this exercises a realistic mixed workload:
// imports, many class definitions, collection literals, iteration and print
// calls — a broad cross-section of the interpreter in one loop. The harness
// runs it via `executeFile` (so the relative import resolves) and suppresses
// the area's console output via a print-swallowing Zone.
import '../../lib/collections/run_collections.dart' as area;

const int kIterations = 25;

int compute() {
  for (var i = 0; i < kIterations; i++) {
    area.main();
  }
  return kIterations;
}

void main() {
  compute();
}
