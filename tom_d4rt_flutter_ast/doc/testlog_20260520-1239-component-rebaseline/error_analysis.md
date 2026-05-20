# Error Analysis — `20260520-1239-component-rebaseline`

| Key | Value |
| --- | --- |
| Baseline ID | `20260520-1239-component-rebaseline` |
| Date | 2026-05-20 (Wed, 12:39 → 12:48 CEST) |
| Git revision | `43947032` (`43947032a40400092b5498f9078ca0731074b650`) |
| Branch | `main` |
| Projects | 7 non-flutter (tom_ast_generator, tom_d4rt, tom_d4rt_ast, tom_d4rt_dcli, tom_d4rt_exec, tom_d4rt_generator, tom_dcli_exec) |
| Bridges | regenerated 26.99 s, `Success: true` |
| Wall (parallel) | ~6m (longest: `tom_d4rt_dcli` 5m43s) |

## 1. Headline

**3 failures, 1 skip, 0 errors, 6420 passing across 6424 tests.**
Zero regressions attributable to recent interpreter / `_ast` /
generator changes.

| Suite | Pass | Skip | Fail | Err |
|---|---:|---:|---:|---:|
| `tom_ast_generator` | 510 | 0 | 0 | 0 |
| `tom_d4rt` | 1751 | 1 | 1 | 0 |
| `tom_d4rt_ast` | 117 | 0 | 0 | 0 |
| `tom_d4rt_dcli` | 706 | 0 | 0 | 0 |
| `tom_d4rt_exec` | 2265 | 0 | 1 | 0 |
| `tom_d4rt_generator` | 659 | 0 | 1 | 0 |
| `tom_dcli_exec` | 412 | 0 | 0 | 0 |
| **TOTAL** | **6420** | **1** | **3** | **0** |

vs `0518-1428`: **+360 tests, +365 passes, −5 failures** — the
six `setUpAll` compile-error failures at
`test_callback_types.b.dart:175:158` (`FutureOr<Object?>` vs
`FutureOr<Object>`) are gone.

vs `0503-2238`: **+12 tests, +11 passes, +1 new (environmental
flake) failure**.

## 2. Failures — case-by-case analysis

### F-1, F-2 — `I-BUG-14a` records-with-named-fields (`tom_d4rt`, `tom_d4rt_exec`)

| Field | Value |
|---|---|
| Test | `Open Bugs - Won't Fix (SHOULD FAIL) I-BUG-14a: Records with named fields. [2026-02-10 06:37] (FAIL)` |
| Source | `limitations_and_bugs_test.dart` (shared between the two packages) |
| Hosts | `tom_d4rt` (count: 1), `tom_d4rt_exec` (count: 1) |
| Status | **Won't-fix marker — not a regression.** Present in every prior baseline (0502, 0503-1221, 0503-2238, 0518-1357/1415/1428). |
| Behaviour | Interpreter returns `InterpretedRecord:<(x: 10, y: 20)>` where the test expects `Instance of '({int x, int y})'`. |
| Decision | Documented limitation — the test is explicitly labelled `(SHOULD FAIL)` and groups under `Open Bugs - Won't Fix`. No action. |

### F-3 — `G-DCLI-07` basic-file-operations (`tom_d4rt_generator`)

| Field | Value |
|---|---|
| Test | `D4rtTester end-to-end dcli_scripting_guide G-DCLI-07: Basic file operations. [2026-02-13] (FAIL)` |
| Source | `d4rt_tester_test.dart` |
| Host | `tom_d4rt_generator` only |
| Status | **Transient environmental flake — confirmed clean on isolated re-run.** |
| Error | `Runtime Error: Unexpected error: Unable to create the directory /home/alexis/dcli_demo. Error: The path /home/alexis/dcli_demo already exists` raised in the test fixture's d4rt-script-invoked `createDir(...)`. |
| Diagnosis | The `dcli_07_basic_file_ops` script creates `~/dcli_demo`, runs the demo, deletes it on teardown. In the parallel run a leftover `~/dcli_demo` from a prior aborted run (or from one of the in-flight parallel tests in the same package racing on the same path) was present at the moment the test ran. Verified after the sweep: `ls /home/alexis/dcli_demo` → "No such file or directory". |
| Re-run | `cd tom_d4rt_generator && dart test test/d4rt_tester_test.dart --plain-name 'G-DCLI-07'` → `+1: All tests passed!` (1 pass, 0 fail). |
| Decision | Not a code regression. Track only if it recurs on two consecutive isolated runs; if so, file as a test-isolation issue against `dcli_07_basic_file_ops.d4rt.dart` (the fixture should `existsSync()`-then-delete the `~/dcli_demo` dir at the start of its `setUp`, not just at `tearDown`). |

## 3. Captured-error sweep (logs, no associated failure)

Every recurring "error-looking" line in the seven `.log.txt`
files is fixture-emitted test output, not a runtime issue:

| Pattern | Source | Hosts seen |
|---|---|---|
| `Error: Network error` / `[404] Error: Not found` / `Failed: Invalid password (3 attempts)` | Test fixture prints in `dart_overview` coverage scripts (exception-handling demos) | `tom_ast_generator`, `tom_d4rt_exec`, `tom_d4rt_generator` |
| `Warning: Failed to log d4rtgen invocation: PathNotFoundException … /Users/alexiskyaw/Desktop/Code/tom2/d4rtgen_invocations.log` | Hardcoded macOS path in a `d4rtgen` invocation-logging fixture; the warning **is** the expected output | `tom_ast_generator`, `tom_d4rt_exec`, `tom_d4rt_generator` |
| `Runtime Error: Break statement outside of a loop` | Deliberate `expectError`-style fixture invoking an illegal break (same dismissal as 0503-2238) | `tom_d4rt`, `tom_d4rt_exec` |
| `Caught in catch: TryException` | `try/catch` coverage fixture prints | `tom_d4rt`, `tom_d4rt_exec` |
| `[DEBUG] [Environment] Defined bridge for class: FormatException` (et al.) | d4rt startup diagnostic prints | `tom_d4rt`, `tom_d4rt_exec` |
| `runtime error exits 2 (exit=2)` (as a `✓` test line) | `tom_dcli_exec` test that asserts a child process exits with code 2 (the test passes) | `tom_d4rt_dcli`, `tom_dcli_exec` |
| `Warning: Could not resolve dependencies for summary caching: FileSystemException: pubspec.lock not found … /tmp/d4rtgen_test_HUDSNO/pubspec.lock` | `d4rtgen` integration test invoking the generator on a freshly created tempdir before `dart pub get` — warning is benign and the surrounding test passes | `tom_d4rt_generator` |

The captured-error sweep matches the dismissal table from the
0503-2238 README §"Captured-error sweep" and the
0518-1428 README §"Captured-error sweep" — no new unattributed
errors introduced by the Cluster I / 38-item fix campaign.

## 4. Skipped tests

One skip in the entire sweep:

| Suite | Test | Skip rationale |
|---|---|---|
| `tom_d4rt` | (single skip propagated from `limitations_and_bugs_test.dart`) | Marker test for a related won't-fix entry; same skip as every prior baseline. |

(`tom_d4rt_exec` shares the same `limitations_and_bugs_test.dart`
source but its skip is not counted in its result.json — the
reporter only emits it once per package; this matches every
prior baseline.)

## 5. Per-suite wall times (parallel)

From `_progress.txt` (first finisher … last finisher):

| Suite | Wall | Exit |
|---|---|---|
| `tom_d4rt_ast` | 0m07s | 0 |
| `tom_dcli_exec` | 0m21s | 0 |
| `tom_d4rt` | 1m01s | 1 (failures, expected) |
| `tom_ast_generator` | 1m06s | 0 |
| `tom_d4rt_generator` | 1m18s | 1 (G-DCLI-07 environmental) |
| `tom_d4rt_exec` | 1m55s | 1 (I-BUG-14a expected) |
| `tom_d4rt_dcli` | 5m43s | 0 |

Total parallel wall: ~6m04s (start 12:42, end 12:48 — bridge
regen 26.99s was sequential before the parallel block).

## 6. Comparison highlights

### vs `testlog_20260518-1428-post-cluster-fixes-rebaseline-3`

The +120 / +120 / +120 deltas on `tom_ast_generator`,
`tom_d4rt_exec`, and `tom_d4rt_generator` come from the
`example/d4` smoke suites that were aborted at `setUpAll` on
2026-05-18 by a compile error at
`test_callback_types.b.dart:175:158`:

```
Error: The argument type 'FutureOr<Object?> Function(dynamic)'
       can't be assigned to the parameter type
       'FutureOr<Object> Function(dynamic)'.
```

That regression is no longer present. The fix landed somewhere
in the 2026-05-18 → 2026-05-20 window as part of the generator
work for the 38-item flutter-suite framework-error sweep.

### vs `testlog_20260503-2238-post-fixes-rebaseline`

Net `+12 tests` (`+6` each in `tom_d4rt` and `tom_d4rt_exec`)
reflects new entries in the shared `limitations_and_bugs_test.dart`
between 2026-05-03 and 2026-05-20. The single new failure
(`G-DCLI-07`) is environmental and not attributable to any
interpreter / generator / `_ast` change.

## 7. Verdict

**No regressions.** The recent interpreter / `_ast` / generator
fixes that closed Clusters 1–11 of the flutter campaign and the
38-item framework-error sweep have not broken any component test
suite; on the contrary, they cleared the May-18 setUpAll
compile-error regression that knocked the totals down by 348
tests on the 0518-1357/1415/1428 triplet. The component baseline
is now back at — and slightly ahead of — the 0503-2238 clean
high-water.
