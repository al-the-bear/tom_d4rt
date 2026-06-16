# D4rt Interpreter Performance Suite

> **Attribution.** The `tom_d4rt` project is an extended clone of the original
> d4rt project by Moustapha Kodjo Amadou, initially published in 2025. The
> complete interpreter is based on his idea.

A small, focused benchmark + profiling harness for the D4rt interpreter
(`tom_d4rt`). It exists to answer two questions:

1. **Does every interpreter feature still execute?** (regression signal)
2. **Where does the interpreter spend its time?** (bottleneck signal)

It deliberately uses *short, loop-heavy* scripts so a single run exercises one
interpreter facet many thousands of times — the shape that makes a sampling
profiler useful.

## Layout

```
example/dart_overview/perf/
  scripts/                 # the benchmark inputs (interpreted, not compiled)
    bench_*.dart           #   focused micro-benchmarks (one facet each)
    wrap_*.dart            #   macro-benchmarks: wrap a whole dart_overview area
  results/
    cpu_profile_latest.txt # last profiler run (captured snapshot)
  d4rt_perf_analysis.md    # bottleneck findings + recommendations
  README.md                # this file

test/perf/                 # the harness + drivers (compiled Dart)
  d4rt_perf_harness.dart   # shared measurement logic
  bench_registry.dart      # the benchmark corpus (shared by test + profiler)
  d4rt_perf_test.dart      # `dart test` / `testkit` timing + regression test
  d4rt_cpu_profile.dart    # CPU-profiling driver (vm_service)
  run_profile.sh           # launches the driver in profile mode
```

## Benchmark script shape

Every script follows the same contract so the harness can drive it generically:

```dart
const int kIterations = 20000;     // tunable inner-loop count
int compute() { /* loop kIterations times */ return checksum; }
void main() { compute(); }         // one call, keeps the file runnable on its own
```

- `kIterations` is read by the harness for the ns/op math.
- `compute()` returns a checksum so the timing test can assert the script
  actually produced a value (a cheap regression guard).
- `main()` calls `compute()` once so the script also runs standalone under the
  normal `run_overview_in_d4rt.dart` driver.

The scripts are **interpreted by D4rt**, not compiled, so they use relative
imports (the only kind `executeFile` resolves) and minimal idioms. They are
excluded from static analysis in `analysis_options.yaml` for that reason.

## How the harness measures

`runFileBenchmark` (see `d4rt_perf_harness.dart`):

1. Loads the script **once** with `executeFile`. This pays the parse +
   import-resolution + first-`main()` cost a single time and is never measured.
2. Reads `kIterations` via `eval('kIterations')`.
3. Warms the interpreter by calling `eval('compute()')` for a warmup window.
4. Measures: calls `eval('compute()')` until a time budget elapses, counting
   calls. `eval` of the nine-character `compute()` expression re-parses only
   those characters, so measured time is dominated by the interpreted loop body
   — **interpretation cost, isolated from parse cost.**

Interpreted `print` output is swallowed by a `runZoned` print hook.

## Running

### Timing + regression test (fast, CI-friendly)

```sh
cd tom_d4rt_generator
dart test test/perf/d4rt_perf_test.dart
# or: testkit :test --test-args="--name 'performance'"
```

Uses the `quick` budget (~300 ms/benchmark). Asserts each script runs and
returns a checksum; prints a throughput table to the log. Does **not** assert
absolute timings (those are host-dependent and would be a flaky gate).

### Profile mode (full budget + CPU samples)

```sh
cd tom_d4rt_generator
test/perf/run_profile.sh                        # all benchmarks
test/perf/run_profile.sh --budget-ms=3000       # longer windows
test/perf/run_profile.sh --only=list_ops,recursion_fib
test/perf/run_profile.sh --top=40
```

`run_profile.sh` launches the Dart VM with `--profiler --enable-vm-service`,
runs the corpus, then pulls aggregated CPU samples via `vm_service` and prints
the hottest functions by **exclusive** (self) and **inclusive** (self+callees)
ticks. Output is also written to `results/cpu_profile_latest.txt`.

## Findings

See [`d4rt_perf_analysis.md`](d4rt_perf_analysis.md) for the bottleneck
analysis and concrete optimization recommendations.
