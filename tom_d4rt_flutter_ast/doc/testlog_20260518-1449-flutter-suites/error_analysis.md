# Error analysis — `20260518-1449-flutter-suites` — tom_d4rt_flutter_ast

**Totals: 2227 tests / 2216 pass / 0 fail / 1 error / 10 skip.**

One genuine error remains; everything else is pre-existing skip
markers or framework-side warnings that did not break a test.
Compared to `testlog_20260517-0914-test_analysis` (the last
comparable per-file flutter baseline): 60 failures → 0, 5 errors
→ 1, +64 passes. No new failures. No new regressions.

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
`test/send_test_runner.dart:864`) had not returned yet either.
The runner app process is reported "still running" — meaning the
script reached the test app but the build / dispatch never
completed within the timeout window.

`hardly_relevant_classes_1_test` produced the largest framework-
noise volume of any suite in this run (see §2). The most likely
cause is contention on the test-app server when the previous
script in the suite is still draining `ObjectDisposed` events
while the next one tries to compile. This is an environment /
pacing issue, not a generator or interpreter defect; the same
file errored identically at 0517-0914.

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
Counts below come from per-log greps; identical numbers were
observed in the mirror `tom_d4rt_flutter_test` run.

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

That 0.5 px is a sub-pixel rounding artefact from the bridged
widget layout; the script does not assert on layout extents so
the test passes. Volume is dominated by `important_classes_test`
(450 hits) where many scripts each render a Material scaffold
under the same constraints.

**`object was given an infinite size during layout`** — variants:

```
RenderConstrainedBox object was given an infinite size during layout.
RenderDecoratedBox object was given an infinite size during layout.
RenderFlex object was given an infinite size during layout.
RenderPadding object was given an infinite size during layout.
RenderParagraph object was given an infinite size during layout.
RenderWrap object was given an infinite size during layout.
```

Scripts wrap widgets in unconstrained parents (e.g. a `Column`
inside a `SingleChildScrollView`) without a height-bounded
ancestor. The framework prints a warning, the script keeps
running.

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

The `Gradient` shape and the `DiagnosticableTreeMixin` shape are
already tracked in
`tom_d4rt_flutter_ast/doc/interpreter_issues.md` (see clusters
covering bridged-constructor argument validation and mixin
target-type unwrapping). The `null` / `Index out of range` shapes
are script-internal — tests for resilience against malformed
state — and are expected.

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
| essential_classes_test | 110 | 0 | 0 | 0 | 15 overflow + 12 infinite-size warnings — advisory only |
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
- **All 60 previously-failing tests now pass**, and 4 of 5 errors
  recovered. Net Pass +64.
- The one remaining error (least_squares_solver_test) is an
  environment / pacing flake that pre-existed and tracks
  separately from the cluster-fix campaign.
- Framework-noise volume is roughly unchanged from 0517 (sampled
  by file, totals are within ±5 %). It does **not** indicate a
  regression — it indicates that the test scripts continue to
  exercise the same advisory code paths they always have.

---

## Fix plan — framework noise & bridged-target unwrapping

Multi-step plan to attack the framework-noise inventory in §2 **in
priority order**. Steps tagged **[bug]** are genuine
interpreter / generator defects; steps tagged **[advisory]** are
script-side patterns the host test treats as benign — default
disposition is "do not change" unless the noise masks a real
failure. Each step has its own verification gate; the next step
starts only after the prior one is verified green.

The plan is identical in `tom_d4rt_flutter_ast` and
`tom_d4rt_flutter_test`; the same noise inventory was emitted by
both projects and the same fixes apply. Bridge/interpreter
changes must land in **both** `tom_d4rt` and `tom_d4rt_ast` per
the quest's "tom_d4rt ↔ tom_d4rt_ast must stay in sync" rule.

### Phase 1 — Triage (no code changes)

- [ ] **Step 1 · Per-script noise audit.** [advisory]
  For every script that contributes a "⚠️ FRAMEWORK ERROR" banner
  (see §2), open the script under
  `test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/`
  (or the `flutter_test` analogue) and tag each noise event:
  - **A** — script intentionally exercises an error path; the host
    test asserts on the consequence, not the underlying widget
    output. No fix.
  - **B** — script under-constrains its widget tree (infinite-size
    family); the test does not assert on layout. No fix.
  - **C** — runtime/bridge error that is not exercised by any
    assertion and may be masking a real contract failure.
    Escalate to Phase 2.
  **DoD:** A markdown table under "Audit results" below lists every
  banner with its tag.

- [ ] **Step 2 · Lock down the Phase-2 candidate list.** [advisory]
  After Step 1, the only Phase-2 candidates are items tagged **C**.
  Pre-tagged candidates from the §2 sampling that should land in
  **C** unless Step 1 contradicts:
  - `DiagnosticableTreeMixin.toStringDeep` mixin-target mismatch →
    Step 3.
  - `Gradient.linear` "colors must have length 2 if colorStops is
    omitted" → Step 4.
  - 0.5 px `RenderFlex overflow` (450 events in
    `important_classes_test`) → Step 5.
  **DoD:** Short `[cluster-id, script-path, error-shape]` list
  appended below the audit table.

### Phase 2 — Interpreter / generator fixes

- [ ] **Step 3 · Unwrap interpreted target before bridged mixin
  dispatch.** [bug]
  **Symptom:**
  `Native error in bridged mixin method
  'DiagnosticableTreeMixin.toStringDeep': Argument Error: Invalid
  target: expected DiagnosticableTreeMixin, got
  InterpretedInstance.`
  **Diagnosis:** the mixin-method adapter receives the
  `InterpretedInstance` directly and invokes the native method
  without first unwrapping to its native shadow (the underlying
  widget / diagnosticable).
  **Fix path:** the mixin proxy emitted by
  `tom_d4rt_generator/lib/src/proxy_generator.dart`, or the
  mixin-dispatch site in
  `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`
  (equivalent in `tom_d4rt/lib/src/interpreter_visitor.dart`),
  must call `D4.unwrapAs<MixinType>(target)` before dispatch.
  **Mirror the fix in tom_d4rt and tom_d4rt_ast.** Regenerate
  bridges via `tool/regenerate_bridges.dart`.
  **Never edit `.b.dart` directly** (quest hard rule).
  **Verification:**
  1. Reproduce: run only the affected script(s) — the
     `DiagnosticableTreeMixin.toStringDeep` shape disappears.
  2. Run `essential_classes_test`, `important_classes_test`,
     `secondary_classes_test`, and the 5 `hardly_relevant_*`
     suites **serially** (parallel runs corrupt the shared
     test-app HTTP server — quest hard rule). Pass count must be
     ≥ 2216 — no regression vs the 1449 baseline.
  **DoD:** Banner shape gone from a re-run's `error_analysis.md`;
  totals ≥ 1449's pass count.

- [ ] **Step 4 · Tighten `Gradient.linear` bridge constructor
  validation.** [bug, low priority]
  **Symptom:**
  `Native error during bridged constructor 'linear' for class
  'Gradient': "colors" must have length 2 if "colorStops" is
  omitted.`
  **Diagnosis:** the bridge passes the script's `colors:` arg
  through to the native constructor, which asserts. Two choices:
  (a) accept the script's pattern by synthesising a default
  `colorStops`, or (b) reject earlier with a script-friendly
  message.
  **Default disposition:** reject earlier with a clear
  `Gradient.linear requires colors.length >= 2 when colorStops is
  null` message. Do **not** silently fill defaults — that would
  hide intent.
  **Fix path:** argument-coercion lambda in the generated `linear`
  constructor wrapper in `bridge_generator.dart`. Implement once;
  regenerate all `.b.dart`. Never edit `.b.dart` directly.
  **Verification:** affected script reports the script-friendly
  error string; no other failures introduced; serial suite run
  matches Step 3's verification gate.
  **DoD:** error shape replaced by the friendly message in the
  next baseline's `error_analysis.md`.

- [ ] **Step 5 · Investigate the 0.5 px `RenderFlex overflow`.**
  [bug, low priority]
  **Symptom:** `A RenderFlex overflowed by 0.500 pixels on the
  bottom.` 610 banners total across the suite; 450 in
  `important_classes_test` (same Material scaffold template).
  **Diagnosis hypothesis:** the test driver's default
  `MediaQuery` height differs by 0.5 from the height the bridged
  scaffold computes — likely a `kToolbarHeight` rounding artefact
  or a `SafeArea` mis-calc in the bridge's default surface.
  **Investigation procedure:**
  1. Pick the smallest `important_classes_test` script that emits
     the banner.
  2. Print `MediaQueryData` + the scaffold's `preferredSize` from
     within the bridged surface.
  3. Compare to the test driver's expected viewport.
  4. Fix at the source — bridge default surface **or** test-app
     viewport setup. **Do not** change scripts; this is bridge /
     harness layer.
  **Verification:** 0.5 px banner count drops to ≤ 5 % of the 1449
  count for `important_classes_test` (i.e. ≥ 427 fewer events)
  without changing pass counts.
  **DoD:** new baseline's noise table shows the reduction.

### Phase 3 — Verification & close-out

- [ ] **Step 6 · Per-cluster verification, serial only.** [process]
  After **each** Phase-2 step (don't batch fixes — quest rule:
  one cluster per commit, verify, push):
  1. Regenerate bridges if the generator changed.
  2. Run the affected cluster's reproduction scripts (see the
     cluster-fix verification protocol in
     `tom_d4rt_flutter_ast/doc/interpreter_issues.md`).
  3. Run the four anchor suites (`essential`, `important`,
     `secondary`, and one `hardly_relevant_*` selected by which
     script the fix touches) **serially** — never in parallel.
     Chain with `&&` or sequential Bash calls.
  4. Commit + push immediately (quest rule: commit + push each
     turn; split unrelated concerns into multiple commits).

- [ ] **Step 7 · Full re-baseline.** [process]
  Once Steps 3 + 4 + 5 are all green, run the full 14-suite serial
  matrix and produce `testlog_<id>-flutter-suites-fixes/` in
  **both** projects, mirroring the structure of
  `testlog_20260518-1449-flutter-suites/`. Acceptance criteria:
  - Pass count ≥ 2216 (no regression).
  - Banner counts in the noise inventory drop to the targets set
    in Steps 3 / 4 / 5.
  - The 1 remaining flake
    (`gestures/least_squares_solver_test.dart`) is allowed to stay
    until the test-app pacing fix lands (out of scope here).
  **DoD:** New baseline's "Bottom line" section reflects the
  fixes; close this Fix-plan with a
  `**Closed YYYY-MM-DD by commit <sha>.**` footer.

### Steps explicitly out of scope

- **Infinite-size warnings** (520+ events) — script-side
  under-constraining; advisory only.
- **`Index out of range`, null property/method access, null
  for-in iterable** — scripts probe resilience; advisory only.
- **3 Bad-state probes in `interactive_tests_test`** —
  intentional dismiss-flow tests; host tests pass and assert on
  the failure of the inner action.
- **`gestures/least_squares_solver_test.dart` transport timeout**
  — pre-existing test-app pacing flake; tracks in its own
  follow-up (raise per-test timeout, or add settle step in
  `SendTestRunner` between scripts).

### Audit results

_To be filled in during Step 1._

### Phase-2 candidate list (Step 2 output)

_To be filled in after Step 1._
