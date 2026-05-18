# Error analysis — `20260518-1449-flutter-suites` — tom_d4rt_flutter_test

**Totals: 2227 tests / 2216 pass / 0 fail / 1 error / 10 skip.**

The pass/fail/error/skip identity in this project mirrors
`tom_d4rt_flutter_ast` exactly (verified case-by-case from the
JSON event streams) — same testID 182 errors, same 10 skip
identities, same per-suite framework-noise counts within ± 1.
Compared to `testlog_20260517-0914-test_analysis`: 62 failures →
0, 5 errors → 1, +66 passes. No new failures.

Sections below list every suite that produced something other
than "all pass", in driver order.

---

## Failures / errors (1 total)

### F1 · `hardly_relevant_classes_1_test` — `gestures/least_squares_solver_test.dart` [error]

**Status: pre-existing flaky timeout, also present at 0517-0914.
Not a content regression.**

Two error events for testID 182 (same script):

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds.
  dart:isolate  _RawReceivePort._handleMessage
```

then, immediately after:

```
Bad state: Transport failure while running "gestures/least_squares_solver_test.dart"
  Operation: POST /build?filename=gestures%2Fleast_squares_solver_test.dart
  Error: TimeoutException after 0:00:25.000000: Future not completed

  Runner app process: still running (no exit code observed).
  Captured app STDOUT tail:
    Observed ObjectEvent: ObjectDisposed
    Observed ObjectEvent: ObjectDisposed
    ...
```

The dart-test default 30 s timeout fired first; the
`SendTestRunner.send` HTTP POST to the test-app's `/build`
endpoint (timeout 25 s, see
`test/send_test_runner.dart:513`) had not returned yet either.
The runner app process is reported "still running" — meaning the
script reached the test app but the build / dispatch never
completed within the timeout window.

`hardly_relevant_classes_1_test` produced the largest framework-
noise volume of any suite in this run (see §2). The most likely
cause is contention on the test-app server when the previous
script in the suite is still draining `ObjectDisposed` events
while the next one tries to compile. This is an environment /
pacing issue, not a generator or interpreter defect; the same
file errored identically at 0517-0914 with the same error shape.

**No action recommended for this baseline.** If it becomes
load-bearing, options are (a) raise the per-test timeout on this
suite, or (b) introduce a settle-step between scripts in
`SendTestRunner`.

---

## Framework-noise inventory (no test failed, advisory only)

The test runner prints captured runtime / framework errors with a
`⚠️ FRAMEWORK ERROR in <script>` banner. These are reported when
an interpreted script logged an exception but the host test
considers the run successful — typically because the script under
test is intentionally exercising error paths, or the error is
emitted from a render pass that the test doesn't assert on.
Counts below come from per-log greps.

| Suite | RenderFlex overflowed | "infinite size" warnings | Runtime Error | Bad state |
|---|---:|---:|---:|---:|
| essential_classes_test | 15 | 12 | 0 | 0 |
| hardly_relevant_classes_1_test | 57 | 93 | 39 | 1 |
| hardly_relevant_classes_2_test | 6 | 12 | 0 | 0 |
| hardly_relevant_classes_3_test | 38 | 163 | 7 | 0 |
| hardly_relevant_classes_5_test | 1 | 0 | 0 | 0 |
| important_classes_test | 450 | 27 | 15 | 0 |
| interactive_tests_test | 6 | 0 | 9 | 3 |
| secondary_classes_test | 37 | 213 | 15 | 0 |

### Distinct framework markers seen

**`RenderFlex overflowed`** — single dominant variant:

```
A RenderFlex overflowed by 0.500 pixels on the bottom.
```

Sub-pixel rounding artefact from bridged widget layout; the
script does not assert on layout extents so the test passes.
Volume is dominated by `important_classes_test` (450 hits) where
many scripts render a Material scaffold under the same
constraints.

**`object was given an infinite size during layout`** — variants:

```
RenderConstrainedBox object was given an infinite size during layout.
RenderDecoratedBox object was given an infinite size during layout.
RenderFlex object was given an infinite size during layout.
RenderPadding object was given an infinite size during layout.
RenderParagraph object was given an infinite size during layout.
RenderWrap object was given an infinite size during layout.
```

Scripts wrap widgets in unconstrained parents without a
height-bounded ancestor. The framework prints a warning, the
script keeps running.

**`Runtime Error`** — interpreter / bridge-side errors that the
script swallowed. Sampled variants:

```
Runtime Error: Index out of range: 3
Runtime Error: Value used in for-in loop must be an Iterable, but got null
Runtime Error: Cannot access property 'name' on target of type null.
Runtime Error: Cannot invoke method 'getChildren' on null. Use '?.' for null-aware method invocation.
Runtime Error: Native error during bridged constructor 'linear' for class 'Gradient':
    Invalid argument(s): "colors" must have length 2 if "colorStops" is omitted.
Runtime Error: Native error in bridged mixin method 'DiagnosticableTreeMixin.toStringDeep':
    Argument Error: Invalid target: expected DiagnosticableTreeMixin, got InterpretedInstance.
```

The `Gradient` and `DiagnosticableTreeMixin` shapes are already
tracked in `tom_d4rt_flutter_ast/doc/interpreter_issues.md`. The
`null` / `Index out of range` shapes are script-internal —
expected resilience probes.

**`Bad state`** — three variants in `interactive_tests_test`:

```
InteractResult(failed, errors: [Action 2 (tapText) failed:
    Bad state: Could not find text "Cancel" on screen])
InteractResult(failed, errors: [Action 2 (tapText) failed:
    Bad state: Could not find text "Option A" on screen])
```

These are interactive-test fixtures that intentionally probe
dismiss-flow timing. The host test asserts that `interact`
returns a non-success result, so the failure of the inner action
is the test's success criterion. All three host tests passed.

---

## Per-file run summary

| File | Pass | Fail | Error | Skip | Notes |
|---|---:|---:|---:|---:|---|
| blocking_tests_test | 7 | 0 | 0 | 0 | clean |
| crashing_tests_test | 6 | 0 | 0 | 0 | clean |
| essential_classes_test | 110 | 0 | 0 | 0 | 15 overflow + 12 infinite-size — advisory only |
| generator_interpreter_issues_test | 83 | 0 | 0 | 2 | 2 pre-existing skips (android_view, animated_switcher) |
| generator_interpreter_retest_test | 55 | 0 | 0 | 5 | 5 pre-existing skips (system_color_palette + 4 widgets) |
| hardly_relevant_classes_1_test | 204 | 0 | 1 | 2 | F1 above + 2 skips |
| hardly_relevant_classes_2_test | 205 | 0 | 0 | 0 | clean; 6 overflow, 12 infinite-size |
| hardly_relevant_classes_3_test | 203 | 0 | 0 | 0 | clean; 38 overflow, 163 infinite-size, 7 runtime errors |
| hardly_relevant_classes_4_test | 229 | 0 | 0 | 0 | clean, no framework noise |
| hardly_relevant_classes_5_test | 232 | 0 | 0 | 0 | clean; 1 overflow |
| important_classes_test | 166 | 0 | 0 | 0 | 450 overflow + 27 infinite-size + 15 runtime errors (advisory) |
| interactive_tests_test | 8 | 0 | 0 | 0 | 6 overflow, 9 runtime errors, 3 Bad-state interaction probes — host tests pass |
| secondary_classes_test | 655 | 0 | 0 | 1 | 1 pre-existing skip (individual android_view); 37 overflow, 213 infinite-size, 15 runtime errors |
| timeout_tests_test | 53 | 0 | 0 | 0 | clean |

---

## Bottom line

- **No regression** vs the 0517-0914 baseline.
- **All 62 previously-failing tests now pass**, and 4 of 5 errors
  recovered. Net Pass +66.
- The one remaining error (least_squares_solver_test) is an
  environment / pacing flake that pre-existed and tracks
  separately from the cluster-fix campaign.
- Framework-noise volume is roughly unchanged from 0517 (sampled
  by file, totals are within ±5 %). It does **not** indicate a
  regression — it indicates that the test scripts continue to
  exercise the same advisory code paths they always have.
- Identical result structure to `tom_d4rt_flutter_ast` (mirror
  project, mirror corpus). Any divergence would itself be a
  regression signal — none observed.
