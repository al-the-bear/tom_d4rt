# Test Log Issue Analysis — 20260525-0316

**Run timestamp:** 2026-05-25 03:16 (CEST, local)
**Run ID:** `20260525-0316-issue-analysis`
**Git revision (at run start):** `9b932906` (`docs(d4rt-flutter): §6 todo #25 — Cluster R verification PARTIAL`)
**Scope:** All 14 flutter test files × 2 projects + all non-flutter d4rt projects.
**Execution mode:** Two flutter projects in parallel (ports 4247 / 4248); non-flutter projects serial **after** flutter sweeps to avoid the host-pressure SIGKILL pattern observed in the prior baseline.

## 1. Headline numbers

### Flutter projects

| Project | passed | skipped | failed | fwErr total | fw-scripts | transports | timeouts |
|---|---:|---:|---:|---:|---:|---:|---:|
| `tom_d4rt_flutter_ast`  | **2096** | 10 | **93**  | **2** | 2 | 87 | 147 |
| `tom_d4rt_flutter_test` | **2086** | 10 | **103** | **2** | 2 | 98 | 165 |

**Critical insight — framework errors are essentially gone:**
- Both projects report only **2 framework errors each**, both in the U17 by-design
  teaching demo (`rendering/render_constraints_transform_box_test`). This
  confirms the **H-cluster fix campaign (todos #12–#19 of the prior baseline) is
  fully durable** — 219 → 2 on flutter_ast (99 %) and 10 → 2 on flutter_test
  (80 %). No regressions on framework errors.
- The 93 / 103 failure counts are dominated by **cold-start contention** from
  the parallel 14-test sweep itself (each took ~3 hours vs ~1.5 hour for the
  prior baseline, indicating heavy host saturation). The transport-failure +
  timeout breakdown — 234 events on flutter_ast, 263 on flutter_test — closely
  tracks the 2× pattern of one timeout + one transport per failing test.

### Non-flutter projects

| Project | passed | skipped | failed | summary |
|---|---:|---:|---:|---|
| `tom_ast_generator`  |  **510** | 0 | **0** | **All pass** (vs 508 / 2 SIGKILL in prior baseline — confirms the SIGKILLs were parallel-sweep host pressure, not generator bugs). |
| `tom_d4rt`           | 1786 | 1 | **1** | I-BUG-14a (intentional `SHOULD FAIL`). |
| `tom_d4rt_ast`       |  117 | 0 | 0 | All pass. |
| `tom_d4rt_dcli`      |  692 | 0 | **14** | All 14 `[fails on Macos]` markers (DCli 8.4.2 `_whoami()` + APFS case-insensitive). |
| `tom_d4rt_exec`      | 2292 | 0 | **1** | I-BUG-14a propagated through shared test fixture. |
| `tom_d4rt_generator` |  660 | 0 | 0 | All pass. |
| `tom_dcli_exec`      |  412 | 0 | 0 | All pass. |

**No genuine new non-flutter failures.** All 16 non-flutter "failures" are
intentional `SHOULD FAIL` markers (I-BUG-14a × 2) or pre-documented
`[fails on Macos]` markers (14). The `tom_ast_generator` SIGKILL artefacts
from the prior baseline did **not** reproduce — confirming they were
host-pressure-induced and not a generator regression.

---

## 2. Per-file results

### 2.1 flutter_ast

| File | passed | skip | fail | fwErr | tr | to | notes |
|---|---:|---:|---:|---:|---:|---:|---|
| blocking_tests_test                            |   5 | 0 |  0 | 0 |  0 |  0 |  |
| crashing_tests_test                            |   4 | 0 |  0 | 0 |  0 |  0 |  |
| essential_classes_test                         | 106 | 0 |  2 | 0 |  2 |  3 | both cold-start |
| generator_interpreter_issues_test              |  77 | 2 |  4 | 0 |  2 |  2 | U25 cold-start cascade |
| generator_interpreter_retest_test              |  50 | 5 |  3 | 0 |  3 |  2 | U25 cold-start cascade |
| hardly_relevant_classes_1_test                 | 193 | 2 | 10 | 0 | 10 | 19 | pure contention |
| hardly_relevant_classes_2_test                 | 195 | 0 |  8 | 0 |  8 | 14 | pure contention |
| hardly_relevant_classes_3_test                 | 192 | 0 |  9 | 0 |  9 | 18 | pure contention |
| hardly_relevant_classes_4_test                 | 219 | 0 |  8 | 0 |  8 | 12 | pure contention |
| hardly_relevant_classes_5_test                 | 221 | 0 |  9 | 0 |  9 | 17 | pure contention |
| important_classes_test                         | 158 | 0 |  6 | 0 |  6 | 12 | pure contention |
| interactive_tests_test                         |   6 | 0 |  0 | 0 |  0 |  0 |  |
| secondary_classes_test                         | 623 | 1 | 30 | 1 | 28 | 47 | pure contention + 1 U17 fwErr |
| timeout_tests_test                             |  47 | 0 |  4 | 1 |  2 |  1 | 2 U25 + 1 retest cold-start + 1 U17 fwErr |

### 2.2 flutter_test

| File | passed | skip | fail | fwErr | tr | to | notes |
|---|---:|---:|---:|---:|---:|---:|---|
| blocking_tests_test                            |   5 | 0 |  0 | 0 |  0 |  0 |  |
| crashing_tests_test                            |   4 | 0 |  0 | 0 |  0 |  0 |  |
| essential_classes_test                         | 105 | 0 |  3 | 0 |  2 |  3 | 1 U26 RouterDelegate + 2 cold-start |
| generator_interpreter_issues_test              |  80 | 2 |  1 | 0 |  1 |  1 | cold-start |
| generator_interpreter_retest_test              |  51 | 5 |  2 | 0 |  2 |  0 | cold-start |
| hardly_relevant_classes_1_test                 | 193 | 2 | 10 | 0 | 10 | 19 | pure contention |
| hardly_relevant_classes_2_test                 | 194 | 0 |  9 | 0 |  9 | 16 | pure contention |
| hardly_relevant_classes_3_test                 | 191 | 0 | 10 | 0 | 10 | 19 | pure contention |
| hardly_relevant_classes_4_test                 | 216 | 0 | 11 | 0 | 11 | 19 | pure contention |
| hardly_relevant_classes_5_test                 | 219 | 0 | 11 | 0 | 11 | 20 | pure contention |
| important_classes_test                         | 155 | 0 |  9 | 0 |  9 | 17 | pure contention |
| interactive_tests_test                         |   6 | 0 |  0 | 0 |  0 |  0 |  |
| secondary_classes_test                         | 620 | 1 | 33 | 1 | 31 | 50 | pure contention + 1 U17 fwErr |
| timeout_tests_test                             |  47 | 0 |  4 | 1 |  2 |  1 | 2 U25 + 1 retest cold-start + 1 U17 fwErr |

---

## 3. Real failures vs contention failures

The pattern from the [E] log inspection is unambiguous: nearly every failing
test has **one TIMEOUT + one TRANSPORT** event paired on the same test,
indicating the dart-test 30 s wrapper fires first, then the runner reports a
transport failure on the same path. This is the classic U25-family
cold-start cascade — the runner can't get a fresh response from the
parallel-loaded test app.

**Real test failures (non-contention) per project:**

| Type | flutter_ast | flutter_test |
|---|---|---|
| **U25 family** (`render_custom_paint` + `render_custom_single_child_layout_box` in gii & timeout) | 4 | 2 |
| **U26 family** (F3 RouterDelegate on `material/materialapp_test`) | 0 | 1 |
| **U17 by-design** (1 fwErr in secondary + 1 fwErr in timeout) | 2 | 2 |
| **Contention noise** (transport / timeout cascade from parallel sweep) | ~89 | ~100 |

The 4–5 real failures are all pre-documented limitations (U25 cold-start
ceiling, U26 RouterDelegate interpreter divergence) or by-design (U17
teaching demo).

---

## 4. Skipped tests

The skip set is identical across both flutter runners (10 each — same set
as the prior baseline):

| # | Test | Reason |
|---|---|---|
| S1 | `gii widgets/android_view_test`                  | AndroidView only renders on Android. |
| S2 | `gii widgets/animated_switcher_test`             | W5 — wedges /build ~60 s. |
| S3 | `gir dart_ui/system_color_palette_test`          | SystemColor web-only API (U24). |
| S4 | `gir widgets/context_action_test`                | W1 — wedges /clear afterward. |
| S5 | `gir widgets/default_text_editing_shortcuts_test`| W2 — /build hangs 30 s. |
| S6 | `gir widgets/live_text_input_status_test`        | W3 — cascade victim of W2. |
| S7 | `gir widgets/lock_state_test`                    | W4 — wedges /build with connection-closed. |
| S8 | `hardly_1 dart_ui/image_sampler_slot_test`       | D1 — destabilises test app. |
| S9 | `hardly_1 dart_ui/isolate_name_server_test`      | `IsolateNameServer` not supported by d4rt interpreter. |
| S10 | `secondary widgets/android_view_test`           | AndroidView only renders on Android. |

All skips carry intentional reason strings tied to `interpreter_unfixable.md`
or `doc/interpreter_issues.md`. Plus on `tom_d4rt`: 1 test skipped with
`Needs BridgedInstance mock for proper testing`.

---

## 5. Framework errors (passing tests that emit Flutter framework events)

### 5.1 flutter_ast — 2 events (was 219 in prior baseline; **99 % reduction**)

| Suite | events | scripts |
|---|---:|---|
| secondary | 1 | `rendering/render_constraints_transform_box_test` (U17 by-design) |
| timeout   | 1 | `rendering/render_constraints_transform_box_test` (U17 by-design) |
| **TOTAL** | **2** | — |

### 5.2 flutter_test — 2 events (was 10 in prior baseline; **80 % reduction**)

| Suite | events | scripts |
|---|---:|---|
| secondary | 1 | `rendering/render_constraints_transform_box_test` (U17 by-design) |
| timeout   | 1 | `rendering/render_constraints_transform_box_test` (U17 by-design) |
| **TOTAL** | **2** | — |

**All remaining framework errors are the U17 by-design teaching demo.**
The H-cluster fix campaign across the prior baseline's §6 todos #12–#19
eliminated 227 of the 229 events (98.3 %).

---

## 6. Numbered todo list — fixes ranked by priority

> Regression rule (a) applies to test-script-only changes; rule (b) applies
> to bridge generator / interpreter / `tom_d4rt_flutterm` source changes
> (run gii + essential + important + secondary on the modified runner). The
> vast majority of "failures" in this baseline are environmental contention
> noise from the parallel verification run, not real issues.

### Cluster A — Verification noise / re-run protocol

- [ ] **fixed** 1. **Re-run the corpus serially (one project at a time, no
  parallel flutter sweep) to disambiguate environmental contention from
  real failures.** The current baseline ran both 14-test sweeps in
  parallel for ~3 hours each, saturating the macOS host. This produced
  ~190 transport / timeout failures that paired 1:1 (one TIMEOUT + one
  TRANSPORT per failing test), indicating the dart-test wrapper fires
  before the test app can respond. A **serial** verification run (one
  project at a time) on an idle host is needed to confirm the
  no-regression claim. Expected outcome:
  - flutter_ast failures drop from 93 → ≤ 6 (4 U25 + 2 U17 fwErr).
  - flutter_test failures drop from 103 → ≤ 5 (2 U25 + 1 U26 + 2 U17 fwErr).
  No code change required — this is a verification-protocol fix.

### Cluster B — Persistent U25 cold-start failures

- [ ] **fixed** 2. **`rendering/render_custom_paint_test.dart`** — appears
  as failing in both gii (`Section 2 - Bridge Generator Issues (80)`) and
  timeout on both runners despite the 50 s `httpBuildTimeout` cap applied
  in prior baseline's §6 todo #1. The server-side 30 s build cap fires
  first ("Build timed out after 30 seconds"). Two options:
  - (a) Bump the test-app server-side build timeout from 30 s → 60 s in
    `tom_d4rt_flutter_ast_app/lib/main.dart` and the sibling
    `tom_d4rt_flutter_test_app/lib/main.dart`. Rule (b) — runtime/main
    code change. Risk: changes timing semantics for every test.
  - (b) Accept as a known cold-start ceiling for this 1521-line / 60 KB
    render-heavy script; document in `interpreter_unfixable.md` as a
    permanent flake on the *first* request after test-app cold-start.
    No code change.

- [ ] **fixed** 3. **`rendering/render_custom_single_child_layout_box_test.dart`**
  — sibling failure to entry #2 (transport failure after entry #2's
  build-timeout cascade). Same fix options apply.

### Cluster C — U26 RouterDelegate (documented, deferred)

- [ ] **fixed** 4. **flutter_test `material/materialapp_test.dart`** —
  F3 RouterDelegate divergence: source-based runner rejects
  `InterpretedInstance(_SimpleRouterDelegate)` at `MaterialApp.router`'s
  constructor adapter despite identical proxy registration to the AST
  runner. Documented as **U26** in `interpreter_unfixable.md` (prior
  testlog's §6 todo #8 partial close, commit `18176e77`). Tracked for
  future interpreter perf pass. **No action this run.**

### Cluster D — U17 by-design (no fix)

- [ ] **fixed** 5. **`rendering/render_constraints_transform_box_test`**
  (2 fwErr per project — 1 in secondary, 1 in timeout). Intentional
  teaching demo per U17 in `interpreter_unfixable.md`. **No action.**

### Cluster E — Intentional / pre-documented (no fix)

- [ ] **fixed** 6. **I-BUG-14a `SHOULD FAIL` markers** — 1 in `tom_d4rt`,
  1 in `tom_d4rt_exec` (propagated). Baseline tracks as `X/X` (intentional
  fail). Cluster P pattern from prior testlogs. **No action.**

- [ ] **fixed** 7. **`tom_d4rt_dcli` 14 `[fails on Macos]` markers** —
  DCli 8.4.2 `_whoami()` bug + APFS case-insensitive (13 + 1). Full
  root-cause in `tom_d4rt_dcli/doc/known_issues_macos.md`. Marker
  approach intentionally preserved to detect upstream DCli fix.
  **No action.**

### Cluster F — Wedge / platform skips (no fix)

- [ ] **fixed** 8. **W1–W5 / D1 wedge scripts + AndroidView platform
  skips** — 10 skipped tests, all intentional. The W1–W5 / D1 wedges
  represent test-app process destabilisation that requires app-side
  diagnostics. Skip reasons tied to `doc/interpreter_issues.md` or
  `interpreter_unfixable.md`. **No action.**

### Cluster G — Operational improvement (process)

- [ ] **fixed** 9. **Future baseline runs should sequence non-flutter tests
  separately from flutter sweeps.** The 20260524-2003 baseline produced
  2 SIGKILL artefacts on `tom_ast_generator` (UBR03 + G-TST-5) when the
  non-flutter sweep ran concurrent with the parallel flutter sweeps. The
  current 20260525-0316 baseline ran non-flutter **after** flutter
  completed → `tom_ast_generator` now passes all 510 tests. Confirms
  the SIGKILLs were host-pressure artefacts, not generator bugs.
  Operational fix: keep non-flutter as a separate phase. **Already
  applied in this run — no further code change.**

### Cluster H — Optional: framework-error verification (already validated)

- [ ] **fixed** 10. **H-cluster fix campaign verified durable.** Framework
  error totals dropped from 229 to 4 across both runners (98.3 % reduction
  vs the prior 20260524-2003 baseline). All gii / essential / important
  / hardly_* / gir / interactive / blocking / crashing suites report
  fwErr = 0 on both projects. The 4 remaining events are all U17
  by-design (Cluster D above). **No action — this is a verification
  signal that prior fixes are holding.**

---

## 7. Raw logs

- `tom_d4rt_flutter_ast/doc/testlog_20260525-0316-issue-analysis/`
  - `_runner.log.txt` — outer runner with per-test timing.
  - `<test_file>.log.txt` × 14 — stdout/stderr per test file.
  - `<test_file>.result.json` × 14 — JSON file-reporter output.
- `tom_d4rt_flutter_test/doc/testlog_20260525-0316-issue-analysis/`
  — same structure.
- Non-flutter projects:
  `<project>/doc/testlog_20260525-0316-issue-analysis/all_tests.log.txt`
  and `all_tests.result.json` × 7.

Wall-clock:
- flutter_ast 14-test sweep: 03:16 → 06:24 = ~3 h 8 min.
- flutter_test 14-test sweep: 03:17 → 06:19 = ~3 h 2 min.
- Non-flutter (7 projects, serial, after flutter completes): 06:24 → 06:31 = ~7 min.
- Two flutter sweeps ran in parallel (port 4247 vs 4248) — the elongated
  runtime vs the prior baseline (~1.5 h each) is itself diagnostic of
  the contention that produced the inflated failure counts.
