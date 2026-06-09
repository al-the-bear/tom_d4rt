// D4rt macro-benchmark: repeats the real `classes` overview area.
//
// Per the perf-suite design, this *wraps* an existing dart_overview area
// script (imported by relative path) and runs its `main()` many times. The
// classes area exercises the OO-heavy side of the interpreter: class
// declarations, constructors (named/factory/redirecting), inheritance and
// interfaces, static members and Object methods. Looping it gives a realistic
// mixed workload dominated by class instantiation and method dispatch — the
// counterpart to `wrap_collections.dart`, which stresses literals/iteration.
//
// The harness runs it via `executeFile` (so the relative import resolves) and
// suppresses the area's console output via a print-swallowing Zone.
import '../../lib/classes/run_classes.dart' as area;

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
