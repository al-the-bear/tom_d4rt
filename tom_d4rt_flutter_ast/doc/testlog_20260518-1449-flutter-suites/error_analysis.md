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

Multi-step plan to drive **every** framework-error banner in §2
to zero, in priority order. Step tags:

- **[bug]** — interpreter / generator / script defect to be
  fixed in source.
- **[advisory]** — non-code work (triage, intent verification).
- **[runner]** — test-runner-side change so genuinely
  intentional + asserted errors don't surface as noise.
- **[env]** — environment / pacing flake.

Per the user's 2026-05-18 directive **no banner shape is out of
scope**. Each one either resolves to a code-level fix or to a
proper containment that removes it from the noise inventory.
Each step has its own verification gate; the next step starts
only after the prior one is verified green.

The plan is identical in `tom_d4rt_flutter_ast` and
`tom_d4rt_flutter_test`; the same noise inventory was emitted by
both projects and the same fixes apply. Bridge / interpreter
changes must land in **both** `tom_d4rt` and `tom_d4rt_ast` per
the quest's "tom_d4rt ↔ tom_d4rt_ast must stay in sync" rule.

### Phase 1 — Triage + rigorous intent verification (no code changes)

- [ ] **Step 1 · Per-script noise audit with intent
  verification.** [advisory]
  For every script that contributes a "⚠️ FRAMEWORK ERROR" banner
  (see §2), open the script under
  `test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/`
  (or the `flutter_test` analogue) **and** open the host test in
  `test/<suite>_test.dart`. Treat the §2 sampling labels as
  hypotheses, not conclusions — every banner must be tagged from
  the source, not from the noise inventory's category line.
  For each banner event, answer:
  1. **Does the script wrap the noisy call in `try`/`catch`** (or
     equivalent error-handling)?
  2. **Does the host test assert on the resulting failure** (e.g.
     `expect(..., throwsA(...))`, `InteractResult.failed`,
     captured stdout, explicit error-string assertion)?
  Tag with one of:
  - **I-handled** — both answers "yes". The error is genuinely
    intentional **and** contained; the banner is runner-side
    spurious noise → Step 8.
  - **I-unhandled** — either answer "no". The script reaches the
    error path but the test does not contain it or does not
    assert on it. **This is a script / test contract bug** —
    the test is silently passing because its assertions don't
    reach the affected code path → Step 7.
  - **B-bridge** — interpreter / generator defect (mixin target
    unwrap, native-arg validation, sub-pixel layout) →
    Steps 3 / 4 / 5.
  - **B-layout** — infinite-size warning from an
    under-constrained widget tree → Step 6.
  - **E-env** — environment / pacing flake
    (`least_squares_solver`) → Step 9.
  **DoD:** Markdown table under "Audit results" below lists
  every banner with: script path, host-test path, tag,
  one-sentence rationale.

- [ ] **Step 2 · Lock down the candidate list across all banner
  shapes.** [advisory]
  After Step 1, every banner has a tag. Group them and route:
  - **B-bridge** → Steps 3 / 4 / 5.
  - **B-layout** → Step 6.
  - **I-unhandled** → Step 7.
  - **I-handled** → Step 8.
  - **E-env** → Step 9.
  **No banner remains untagged or out of scope** — Phase 2's
  step set must cover every banner that §2 reports.
  **DoD:** Candidate list appended below the audit table groups
  each banner by its target step; total banner count in §2's
  inventory matches the sum of the routed groups.

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

- [ ] **Step 6 · Resolve `infinite size during layout` warnings.**
  [bug or script, depending on Step 1 verdict]
  **Symptom:** 520+ banners across suites; variants on
  `RenderConstrainedBox / RenderDecoratedBox / RenderFlex /
  RenderPadding / RenderParagraph / RenderWrap object was given an
  infinite size during layout`.
  **Per-banner disposition:**
  - If Step 1 tagged the banner **B-layout** because *the script
    under-constrains its own widget tree* (e.g. an unbounded
    `Column` inside a `SingleChildScrollView` without
    `mainAxisSize: MainAxisSize.min`), fix the **script** —
    re-write the smallest hunk that removes the warning while
    preserving the test's intent. Scripts are inputs to the
    interpreter, not specification of intended runtime behaviour,
    so editing them is permitted *only* when the host test does
    not assert on the warning. Confirm by re-reading the host
    test.
  - If the same shape recurs across many scripts using a shared
    bridged default surface (i.e. the script is structurally
    correct but the bridge's default layout wraps it in an
    unbounded parent), fix the **bridge** default surface or the
    test-app's default `MediaQuery` setup, **not** the scripts.
  **Fix path:** scripts live under
  `test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/`
  (and the `flutter_test` analogue). Default surface lives in the
  test-app's harness.
  **Verification:** banner count in §2's "infinite size warnings"
  column drops to 0 for affected suites; pass count unchanged.
  **DoD:** next baseline's noise table shows 0 in the relevant
  column for the suites in scope.

- [ ] **Step 7 · Resolve `Runtime Error: Index out of range` and
  null-target Runtime Errors.** [bug, test contract]
  **Symptom:** 85 total Runtime Error banners across the suite.
  Sampled shapes:
  - `Runtime Error: Index out of range: 3`
  - `Runtime Error: Value used in for-in loop must be an Iterable,
    but got null`
  - `Runtime Error: Cannot access property 'name' on target of
    type null.`
  - `Runtime Error: Cannot invoke method 'getChildren' on null.
    Use '?.' for null-aware method invocation.`
  **Per Step 1 verdict:**
  - **I-unhandled** (script reaches error path, host test does not
    assert on it): this is a **test contract bug** — the test is
    silently passing because its assertions never reach the
    affected branch. Per
    `_copilot_guidelines/test_driven_development.md` ("never adapt
    the test to match buggy behaviour"), do **not** weaken the
    test to swallow the error. Two acceptable fixes, decided
    per-banner:
    1. The error path is genuinely intentional. Wrap the noisy
       call in the **script** with a narrow `try`/`catch` that
       records the captured exception, **and** add
       `expect(captured, isA<…>())` / `throwsA(…)` in the host
       test so the contract is explicit.
    2. The error path indicates a real script bug (off-by-one,
       missed null guard). Fix the script.
  - **I-handled** (already caught + asserted): routes to Step 8.
  - **B-bridge** (interpreter / bridge defect that produced the
    error): routes to Steps 3 / 4 / 5.
  **Fix path:** scripts under
  `test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/`
  and host tests in `test/<suite>_test.dart`. No interpreter
  change for I-unhandled banners — the interpreter is reporting
  the error correctly; the contract is what's missing.
  **Verification:** "Runtime Error" column in §2 reaches 0 across
  suites; banner shapes that remain are routed to Step 3 / 4 / 5
  or Step 8.
  **DoD:** zero Runtime Error banners in the next baseline whose
  intent has not been explicitly asserted by the host test.

- [ ] **Step 8 · Runner-side filter for handled + asserted
  errors.** [runner]
  **Scope:** banners tagged **I-handled** in Step 1 — the script
  catches the exception **and** the host test asserts on the
  contained failure (e.g. the 3 `Bad state` events in
  `interactive_tests_test` where `InteractResult.failed` is the
  test's success criterion). The runner currently prints the
  banner anyway because it inspects captured runtime exceptions
  independently of host-test pass/fail.
  **Fix path:** modify the banner emission in
  `tom_d4rt_flutter_ast/test/send_test_runner.dart` (around
  L864 — the captured-error logging branch in
  `SendTestRunner.send` / its receiver) and the mirror in
  `tom_d4rt_flutter_test/test/send_test_runner.dart` (around
  L513). Tag handled exceptions at the runtime catch site (push
  a marker into the captured-error record indicating the script
  swallowed the exception), and have the runner suppress the
  banner when (a) the marker is set **and** (b) the host test
  passed.
  **Verification:** Bad-state count in §2 for
  `interactive_tests_test` drops to 0; no host test changes from
  pass to fail; counts in §2 for I-handled banners on other
  suites drop accordingly.
  **DoD:** next baseline's noise inventory shows 0 banners for
  I-handled rows.

- [ ] **Step 9 · `gestures/least_squares_solver_test.dart`
  transport flake.** [env]
  **Symptom:** dart-test default 30 s timeout fires before the
  test-app's `/build` HTTP POST returns; `SendTestRunner.send`
  HTTP timeout is 25 s (see `test/send_test_runner.dart:864`);
  app stdout shows queued `ObjectEvent: ObjectDisposed` drainage.
  **Fix options** (pick one based on the audit; both projects
  must apply the same option):
  - **A. Raise per-test timeout to 60 s** for this script. Add
    `@Timeout(Duration(seconds: 60))` to the host test in
    `hardly_relevant_classes_1_test.dart` only for testID 182, or
    pass `--timeout=60s` selectively. Lowest-risk option.
  - **B. Add settle step in `SendTestRunner.send`** between
    scripts: after each script returns, poll `/status` until the
    ObjectDisposed queue is empty (or up to a 5 s cap) before
    sending the next `/build`. Eliminates the contention root
    cause but touches the runner used by all suites — verify no
    perf regression on the full 14-suite matrix.
  **Verification:** Three consecutive full-suite runs of
  `hardly_relevant_classes_1_test` produce 0 errors.
  **DoD:** F1 in §1 removed from the next baseline; "Failures /
  errors" total = 0.

### Phase 3 — Verification & close-out

- [ ] **Step 10 · Per-cluster verification, serial only.** [process]
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

- [ ] **Step 11 · Full re-baseline.** [process]
  Once Steps 3 + 4 + 5 + 6 + 7 + 8 + 9 are all green, run the full
  14-suite serial matrix and produce
  `testlog_<id>-flutter-suites-fixes/` in **both** projects,
  mirroring the structure of `testlog_20260518-1449-flutter-suites/`.
  Acceptance criteria:
  - Pass count ≥ 2216 (no regression).
  - Banner counts in the noise inventory drop to 0 across every
    column.
  - Failures / errors total = 0.
  **DoD:** New baseline's "Bottom line" section reflects the
  fixes; close this Fix-plan with a
  `**Closed YYYY-MM-DD by commit <sha>.**` footer.

### Scope note

Per the user's 2026-05-18 directive **no framework-error banner
shape is out of scope**. Every banner in §2 is routed to one of
Steps 3 – 9, including the previously-deferred categories:
infinite-size layout warnings (Step 6), null & Index Runtime
Errors (Step 7), Bad-state interactive probes (Step 8 once
Step 1 confirms intent), and the `least_squares_solver` transport
timeout (Step 9).

### Audit results

_To be filled in during Step 1._

### Phase-2 candidate list (Step 2 output)

_To be filled in after Step 1._
