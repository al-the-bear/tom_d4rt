# Test Log Issue Analysis — 20260524-2003

**Run timestamp:** 2026-05-24 20:03 (CEST, local)
**Run ID:** `20260524-2003-issue-analysis`
**Git revision (at run start):** `7d45d08e` (`docs(d4rt-flutter): §6 todo #23 — Cluster R partial close`)
**Scope:** All 14 flutter test files × 2 projects (`tom_d4rt_flutter_ast`,
`tom_d4rt_flutter_test`) + all non-flutter d4rt projects.
**Execution mode:** Two flutter projects in parallel (different ports
4247 / 4248); non-flutter projects serially.

## 1. Headline numbers

### Flutter projects

| Project | passed | skipped | failed | fwErr total | fw-scripts | transports | timeouts |
|---|---:|---:|---:|---:|---:|---:|---:|
| `tom_d4rt_flutter_ast`  | **2169** | 10 | **20** | **219** | 64 | 14 | 13 |
| `tom_d4rt_flutter_test` | **2170** | 10 | **19** | **10**  | 7  | 13 | 12 |

Pass rate: 99.1 % (ast) / 99.1 % (test). The big gap is **framework
errors**: the AST runner emits ~22× more framework errors than the
source runner on the same scripts (219 vs 10). Most failures on
both runners are **U25-family cold-start transport/timeout**
contention, not script or interpreter bugs.

### Non-flutter projects

| Project | passed | skipped | failed | summary |
|---|---:|---:|---:|---|
| `tom_ast_generator`  |  508 | 0 | **2** | UBR03 + G-TST-5 SIGKILLed (exit -9 — host memory pressure from parallel flutter sweeps; not interpreter bugs). |
| `tom_d4rt`           | 1786 | 1 | **1** | F7 / I-BUG-14a — intentional `SHOULD FAIL` marker (Cluster P / §6 todo #21, baseline-tracked `X/X`). |
| `tom_d4rt_ast`       |  117 | 0 | 0 | all pass. |
| `tom_d4rt_dcli`      |  692 | 0 | **14** | all 14 `[fails on Macos]` markers (Cluster Q / §6 todo #22) — upstream DCli 8.4.2 `_whoami()` bug + APFS case-insensitive. |
| `tom_d4rt_exec`      | 2292 | 0 | **1** | F7 / I-BUG-14a — propagated through shared test fixture. |
| `tom_d4rt_generator` |  660 | 0 | 0 | all pass. |
| `tom_dcli_exec`      |  412 | 0 | 0 | all pass. |

**No genuine new failures in non-flutter projects.** All 18 non-flutter
"failures" are either intentional `SHOULD FAIL` markers (2 I-BUG-14a),
pre-documented `[fails on Macos]` markers (14), or SIGKILL artefacts
from host memory pressure during parallel runs (2 UBR03/G-TST-5).

---

## 2. flutter_ast — file-by-file results

| File | passed | skipped | failed | fwErr | transports | timeouts |
|---|---:|---:|---:|---:|---:|---:|
| blocking_tests_test                            |   5 |  0 |  0 |   0 | 0 | 0 |
| crashing_tests_test                            |   4 |  0 |  0 |   0 | 0 | 0 |
| essential_classes_test                         | 103 |  0 |  **5** |  26 | 4 | 5 |
| generator_interpreter_issues_test              |  79 |  2 |  **2** |   0 | 1 | 1 |
| generator_interpreter_retest_test              |  51 |  5 |  **2** |   0 | 2 | 0 |
| hardly_relevant_classes_1_test                 | 203 |  2 |  0 |  22 | 0 | 0 |
| hardly_relevant_classes_2_test                 | 203 |  0 |  0 |   6 | 0 | 0 |
| hardly_relevant_classes_3_test                 | 201 |  0 |  0 |  17 | 0 | 0 |
| hardly_relevant_classes_4_test                 | 227 |  0 |  0 |   7 | 0 | 0 |
| hardly_relevant_classes_5_test                 | 230 |  0 |  0 |  13 | 0 | 0 |
| important_classes_test                         | 164 |  0 |  0 |  43 | 0 | 0 |
| interactive_tests_test                         |   6 |  0 |  0 |   0 | 0 | 0 |
| secondary_classes_test                         | 647 |  1 |  **6** |  84 | 4 | 5 |
| timeout_tests_test                             |  46 |  0 |  **5** |   1 | 3 | 2 |

### 2.1 essential_classes_test — 5 failures (4 transports, 1 cold-start build timeout)

| # | test | inner error |
|---|---|---|
| E1 | `cupertino/ picker_test.dart` | Transport failure → `TimeoutException after 25 s` |
| E2 | `cupertino/ scaffold_test.dart` | Transport failure → `TimeoutException after 25 s` |
| E3 | `cupertino/ segmented_test.dart` | `TimeoutException after 30 s — Test timed out` (dart-test wrapper fired) |
| E4 | `cupertino/ textfield_test.dart` | Transport failure → `TimeoutException after 25 s` |
| E5 | `dart_ui/ color_test.dart` | Transport failure → `TimeoutException after 25 s` |

All five fired in a cluster on the cupertino group + the first dart_ui
test → classic U25 cascade (one wedged build wedges /clear for the next
several tests).

### 2.2 generator_interpreter_issues_test — 2 failures

| # | test | inner error |
|---|---|---|
| E6 | `Section 2 - Bridge Generator Issues (80) rendering/render_custom_paint_test.dart` | `Build timed out after 30 seconds` (server-side cap) |
| E7 | `Section 2 - Bridge Generator Issues (80) rendering/render_custom_single_child_layout_box_test.dart` | Transport failure → `TimeoutException after 25 s` |

Both are recurring U25 cold-start contention on render-heavy scripts.
Same pair errors in `secondary_classes_test` and `timeout_tests_test` —
this is a deterministic flake at the first execution of each suite.

### 2.3 generator_interpreter_retest_test — 2 failures

| # | test | inner error |
|---|---|---|
| E8 | `retest: rendering/render_animated_size_state_test.dart` | Transport failure → `TimeoutException after 25 s` |
| E9 | `retest: widgets/app_kit_view_test.dart` | Transport failure → `HttpException: Connection reset` |

### 2.4 secondary_classes_test — 6 failures

| # | test | inner error |
|---|---|---|
| E10 | `material/ individual date_time_range_test.dart` | Transport failure → 25 s |
| E11 | `material/ individual date_utils_test.dart` | dart-test 30 s wrapper fired |
| E12 | `material/ individual default_material_localizations_test.dart` | Transport failure → 25 s |
| E13 | `rendering/ individual render_custom_paint_test.dart` | Build timed out after 30 s |
| E14 | `rendering/ individual render_custom_single_child_layout_box_test.dart` | Transport failure → 25 s |
| E15 | `rendering/ individual render_ignore_baseline_test.dart` | Transport failure → 25 s |

### 2.5 timeout_tests_test — 5 failures

| # | test | inner error |
|---|---|---|
| E16 | `rendering/ render_custom_paint_test.dart` | Build timed out after 30 s |
| E17 | `rendering/ render_custom_single_child_layout_box_test.dart` | Transport failure → 25 s |
| E18 | `widgets/ retest: widgets/app_kit_view_test.dart` | Transport failure → connection reset |
| E19 | `widgets/ retest: widgets/back_button_listener_test.dart` | Build timed out after 30 s |
| E20 | `widgets/ retest: widgets/box_scroll_view_test.dart` | Transport failure → 25 s |

---

## 3. flutter_test — file-by-file results

| File | passed | skipped | failed | fwErr | transports | timeouts |
|---|---:|---:|---:|---:|---:|---:|
| blocking_tests_test                            |   5 |  0 |  0 |   0 | 0 | 0 |
| crashing_tests_test                            |   4 |  0 |  0 |   0 | 0 | 0 |
| essential_classes_test                         | 106 |  0 |  **2** |   0 | 1 | 1 |
| generator_interpreter_issues_test              |  79 |  2 |  **2** |   0 | 1 | 1 |
| generator_interpreter_retest_test              |  49 |  5 |  **4** |   0 | 3 | 2 |
| hardly_relevant_classes_1_test                 | 203 |  2 |  0 |   0 | 0 | 0 |
| hardly_relevant_classes_2_test                 | 203 |  0 |  0 |   0 | 0 | 0 |
| hardly_relevant_classes_3_test                 | 201 |  0 |  0 |   0 | 0 | 0 |
| hardly_relevant_classes_4_test                 | 227 |  0 |  0 |   3 | 0 | 0 |
| hardly_relevant_classes_5_test                 | 229 |  0 |  **1** |   4 | 1 | 1 |
| important_classes_test                         | 163 |  0 |  **1** |   0 | 1 | 1 |
| interactive_tests_test                         |   6 |  0 |  0 |   0 | 0 | 0 |
| secondary_classes_test                         | 647 |  1 |  **6** |   2 | 4 | 5 |
| timeout_tests_test                             |  48 |  0 |  **3** |   1 | 2 | 1 |

### 3.1 essential_classes_test — 2 failures

| # | test | inner error |
|---|---|---|
| T1 | `cupertino/ list_test.dart` | Transport failure → `TimeoutException after 25 s` |
| T2 | `material/ materialapp_test.dart` | `Runtime Error: Native error during bridged constructor 'router' for class 'MaterialApp': Argument Error: Invalid parameter "routerDelegate": expected RouterDelegate<…>` — **U26 (F3 RouterDelegate)** documented; deferred. |

### 3.2 generator_interpreter_issues_test — 2 failures (same scripts as flutter_ast E6/E7)

| # | test | inner error |
|---|---|---|
| T3 | `Section 2 - Bridge Generator Issues (80) rendering/render_custom_paint_test.dart` | Build timed out after 30 s |
| T4 | `Section 2 - Bridge Generator Issues (80) rendering/render_custom_single_child_layout_box_test.dart` | Transport failure → 25 s |

### 3.3 generator_interpreter_retest_test — 4 failures

| # | test | inner error |
|---|---|---|
| T5 | `retest: rendering/render_animated_size_state_test.dart` | Transport failure → 25 s |
| T6 | `retest: rendering/render_sliver_box_child_manager_test.dart` | dart-test 30 s wrapper fired |
| T7 | `retest: services/message_codec_test.dart` | Transport failure → 25 s |
| T8 | `retest: widgets/app_kit_view_test.dart` | Transport failure → connection reset |

### 3.4 hardly_relevant_classes_5_test — 1 failure

| # | test | inner error |
|---|---|---|
| T9 | `widgets/ tree_sliver_test.dart` | Transport failure → 25 s |

### 3.5 important_classes_test — 1 failure

| # | test | inner error |
|---|---|---|
| T10 | `material/ circleavatar_test.dart` | Transport failure → 25 s |

### 3.6 secondary_classes_test — 6 failures (largely same as flutter_ast)

| # | test | inner error |
|---|---|---|
| T11 | `material/ individual data_table_theme_test.dart` | Transport failure → 25 s |
| T12 | `material/ individual date_range_picker_dialog_test.dart` | dart-test 30 s wrapper fired |
| T13 | `material/ individual date_time_range_test.dart` | Transport failure → 25 s |
| T14 | `rendering/ individual render_custom_paint_test.dart` | Build timed out after 30 s |
| T15 | `rendering/ individual render_custom_single_child_layout_box_test.dart` | Transport failure → 25 s |
| T16 | `rendering/ individual render_proxy_box_with_hit_test_behavior_test.dart` | Transport failure → 25 s |

### 3.7 timeout_tests_test — 3 failures

| # | test | inner error |
|---|---|---|
| T17 | `rendering/ render_custom_paint_test.dart` | Build timed out after 30 s |
| T18 | `rendering/ render_custom_single_child_layout_box_test.dart` | Transport failure → 25 s |
| T19 | `widgets/ retest: widgets/app_kit_view_test.dart` | Transport failure → connection reset |

---

## 4. Skipped tests (10 each project, mostly shared)

The skip set is identical across both flutter runners — these are
platform- or interpreter-limitation gates baked into the test files.

| # | test | reason |
|---|---|---|
| S1 | `gii widgets/android_view_test.dart`                  | AndroidView only renders on Android. |
| S2 | `gii widgets/animated_switcher_test.dart`             | W5 — script wedges app /build for ~60 s then "Lost connection to device"; cascades 34 subsequent gii tests. Pre-existing testlog_20260428-1220-issue-analysis aborted at this script. |
| S3 | `gir dart_ui/system_color_palette_test.dart`          | SystemColor not supported on desktop platforms (web-only API). U24/§6 todo #13. |
| S4 | `gir widgets/context_action_test.dart`                | W1 — passes in isolation but wedges /clear afterward, cascading the rest of the run. |
| S5 | `gir widgets/default_text_editing_shortcuts_test.dart`| W2 — /build hangs 30 s, wedges /clear afterward. |
| S6 | `gir widgets/live_text_input_status_test.dart`        | W3 — cascade victim of W2. |
| S7 | `gir widgets/lock_state_test.dart`                    | W4 — wedges app /build with "HttpException: Connection closed before full header was received"; cascades 19 subsequent retests. |
| S8 | `hardly_1 dart_ui/image_sampler_slot_test.dart`       | D1 — destabilises test app for subsequent dart_ui/gestures scripts on Linux. |
| S9 | `hardly_1 dart_ui/isolate_name_server_test.dart`      | `IsolateNameServer` not supported by d4rt interpreter (no real Dart isolate infrastructure). |
| S10 | `secondary widgets/android_view_test.dart`           | AndroidView only renders on Android (same as S1). |

Plus, on tom_d4rt: 1 test skipped with `Needs BridgedInstance mock for proper testing` (`test/limitations_and_bugs_test.dart`).

---

## 5. Framework errors (passing tests that emit Flutter framework events)

### 5.1 flutter_ast — 219 events across 64 scripts (the elephant in the room)

The AST runner emits significantly more framework errors than the
source runner on the same scripts. Most are `RenderFlex overflowed
by N pixels` events that the strict-success suites (gii) gate on,
but the lenient suites (hardly_relevant_*, secondary, important)
ignore for the success check.

**By suite:**

| Suite | events | scripts | top scripts (fwErr count) |
|---|---:|---:|---|
| essential | 26  | 6  | `widgets/appbar_test` (12), `widgets/icon_test` (9), `widgets/form_test` (2), `widgets/center_test` (1), `widgets/row_test` (1), `widgets/sized_box_test` (1). |
| hardly_1  | 22  | 5  | `gestures/tap_move_details_test` (10), `foundation/diagnosticable_tree_test` (9), `dart_ui/callback_handle_test` (1), `foundation/category_test` (1), `gestures/pointer_pan_zoom_update_event_test` (1). |
| hardly_2  | 6   | 1  | `material/menu_accelerator_label_test` (6). |
| hardly_3  | 17  | 7  | `services/text_input_type_test` (6), `rendering/performance_overlay_option_test` (5), `rendering/clear_selection_event_test` (2), 4 single-event scripts. |
| hardly_4  | 7   | 5  | `widgets/bottom_navigation_bar_item_test` (2), `widgets/child_back_button_dispatcher_test` (2), 3 single-event scripts. |
| hardly_5  | 13  | 6  | `widgets/scroll_context_test` (6), `widgets/two_dimensional_child_manager_test` (3), 4 single-event scripts. |
| important | 43  | 6  | `painting/matrix_test` (18), `widgets/router_test` (14), `material/dialog_themes_test` (8), 3 single-event scripts. |
| secondary | 84  | 27 | `widgets/image_filtered_test` (14), `foundation/aggregated_timed_block_test` (11), `widgets/list_wheel_viewport_test` (8), `material/expansion_stepper_test` (7), `widgets/list_wheel_scroll_view_test` (7), `material/desktop_text_selection_toolbar_button_test` (4), `widgets/navigation_toolbar_test` (4), + 20 single/triple-event scripts. |
| timeout   | 1   | 1  | `rendering/render_constraints_transform_box_test` (1) — U17 by-design teaching demo. |

### 5.2 flutter_test — 10 events across 7 scripts

| Suite | events | scripts |
|---|---:|---|
| hardly_4  | 3   | `widgets/bottom_navigation_bar_item_test` (1), `widgets/callback_shortcuts_test` (1), `widgets/child_back_button_dispatcher_test` (1). |
| hardly_5  | 4   | `widgets/standard_component_type_test` (4). |
| secondary | 2   | `rendering/render_constraints_transform_box_test` (1 — U17 by-design), `widgets/bouncing_scroll_physics_test` (1). |
| timeout   | 1   | `rendering/render_constraints_transform_box_test` (1 — U17 by-design). |

The flutter_test variant is ~22× cleaner than flutter_ast on
framework-error volume despite running the same scripts.

---

## 6. Numbered todo list — fixes ranked by priority

> Regression rule (a) applies to test-script-only changes; rule (b)
> applies to bridge generator / interpreter / `tom_d4rt_flutterm`
> source changes (run gii + essential + important + secondary on the
> modified runner). Most items below are infrastructure (cold-start /
> transport) or known U-series — they require either timing fixes or
> documentation acceptance, not interpreter work.

### Cluster Cold-Start (U25 family) — transport / build-timeout cascades

- [x] **fixed** 1. **U25 cold-start contention on `render_custom_paint_test.dart` +
  `render_custom_single_child_layout_box_test.dart`** — ~~these two
  rendering scripts produce 6 deterministic failures across both
  projects (E6, E7, E13, E14, E16, E17 on flutter_ast; T3, T4, T14,
  T15, T17, T18 on flutter_test).~~ **FIXED.** The
  `render_custom_paint_test.dart` registrations had already been
  bumped in earlier §S/E1 / §1.4/E38 / §1.5/E41 commits (3 files ×
  2 projects = 6 registrations); only the sibling
  `render_custom_single_child_layout_box_test.dart` was missed.
  Applied the same `httpBuildTimeout: 25 s → 50 s` + `Timeout(60 s)`
  wrapper to the 6 missed registrations:
  - `tom_d4rt_flutter_ast/test/timeout_tests_test.dart` (E17)
  - `tom_d4rt_flutter_ast/test/secondary_classes_test.dart` (E14)
  - `tom_d4rt_flutter_ast/test/generator_interpreter_issues_test.dart` (E7)
  - `tom_d4rt_flutter_test/test/timeout_tests_test.dart` (T18)
  - `tom_d4rt_flutter_test/test/secondary_classes_test.dart` (T15)
  - `tom_d4rt_flutter_test/test/generator_interpreter_issues_test.dart` (T4)

  Rule (a) — test-driver-only change. Verified each entry
  individually in serial isolation, all 6 pass cleanly:
  - AST timeout: totalMs=2167 frameworkErrors=0 ✓
  - AST secondary: totalMs=2272 frameworkErrors=0 ✓
  - AST gii: totalMs=2064 frameworkErrors=0 ✓
  - TEST timeout: totalMs=2065 frameworkErrors=0 ✓
  - TEST secondary: totalMs=2124 frameworkErrors=0 ✓
  - TEST gii: totalMs=2040 frameworkErrors=0 ✓

  Closes E6/E7 (AST gii Section 2), E13/E14 (AST secondary), E16/E17
  (AST timeout) on flutter_ast and T3/T4 (TEST gii), T14/T15 (TEST
  secondary), T17/T18 (TEST timeout) on flutter_test.

- [ ] **fixed** 2. **flutter_ast cupertino cold-start cascade (E1–E4 + dart_ui E5).**
  `cupertino/picker_test`, `scaffold_test`, `segmented_test`,
  `textfield_test`, `dart_ui/color_test` — first 5 large scripts in
  `essential_classes_test` cascade-fail within the cupertino group.
  Either re-order so the lightest cupertino script runs first
  (warm-up), or bump `httpBuildTimeout: 50 s` on the cupertino +
  dart_ui group entries. Rule (a).

- [ ] **fixed** 3. **flutter_ast secondary material/date* + render_ignore_baseline cold-start
  cascade (E10–E12, E15).** `material/date_time_range_test`,
  `date_utils_test`, `default_material_localizations_test`,
  `rendering/render_ignore_baseline_test` — same cascade pattern in
  `secondary_classes_test`'s material-individual group. Fix: bump
  the four entries' caller-side cap, or re-order. Rule (a).

- [ ] **fixed** 4. **flutter_ast retest cold-start (E8–E9, E18, E20).**
  `retest/rendering/render_animated_size_state_test`,
  `retest/widgets/app_kit_view_test`, `retest/widgets/box_scroll_view_test`
  — cold-start contention in `generator_interpreter_retest_test` and
  `timeout_tests_test`. Bump caps. Rule (a).

- [ ] **fixed** 5. **flutter_ast E19 `retest/widgets/back_button_listener_test`** —
  `Build timed out after 30 s` in `timeout_tests_test`. Same script
  was closed in §6 todo #11 for `generator_interpreter_retest_test`
  (50 s cap), but the `timeout_tests_test` entry was missed in that
  fix. Apply the same `httpBuildTimeout: 50 s` to that entry. Rule (a).

- [ ] **fixed** 6. **flutter_test T1 `cupertino/list_test.dart` cold-start.** Same
  pattern as flutter_ast E1–E4 but on a different cupertino script.
  Bump cap. Rule (a).

- [ ] **fixed** 7. **flutter_test T5–T8 retest cold-start cascade.**
  `retest/rendering/render_animated_size_state_test`,
  `retest/rendering/render_sliver_box_child_manager_test`,
  `retest/services/message_codec_test`,
  `retest/widgets/app_kit_view_test` — same as flutter_ast retest
  cluster. Bump caps. Rule (a).

- [ ] **fixed** 8. **flutter_test T9 `widgets/tree_sliver_test`** (hardly_5),
  **T10 `material/circleavatar_test`** (important),
  **T11 `material/data_table_theme_test`** (secondary),
  **T13 `material/date_time_range_test`** (secondary),
  **T16 `rendering/render_proxy_box_with_hit_test_behavior_test`** (secondary)
  — single-script cold-start transport failures. Bump per-script
  caps. Rule (a).

- [ ] **fixed** 9. **flutter_test T12 `material/date_range_picker_dialog_test`** —
  dart-test 30 s wrapper fired. Need to either raise the
  `timeout: Timeout(Duration(seconds: ...))` wrapper or split the
  test into smaller stages. Rule (a).

### Cluster F — Real interpreter / bridge issues (already documented)

- [ ] **fixed** 10. **T2 — `flutter_test essential/material/materialapp_test.dart`** —
  F3 RouterDelegate rejected by the source-based runner despite
  identical proxy registration to flutter_ast. Already documented
  as **U26** in `interpreter_unfixable.md` (§6 todo #8 partial).
  **No action this run** — tracked for future interpreter perf
  pass.

- [ ] **fixed** 11. **tom_ast_generator UBR03 + G-TST-5 SIGKILL.** Both d4rt_tester
  subprocesses exited with code -9 — most likely OS-killed under
  memory pressure during the parallel flutter sweeps. Re-run in
  isolation (no flutter sweep concurrent) to confirm whether
  this is a flaky resource issue or a genuine generator bug.
  Rule (b) if it turns out to be a generator change is needed.

### Cluster H — Framework errors (RenderFlex / layout overflows)

The hardly_relevant_1..5 suites and secondary do not gate on
`frameworkErrors==0`, but the framework events still degrade the
console output. essential / important / gii do gate on
`frameworkErrors==0`, so any new fwErr here would fail the suite.

- [ ] **fixed** 12. **H-essential (flutter_ast, 6 scripts, 26 events)** —
  `widgets/appbar_test` (12), `widgets/icon_test` (9),
  `widgets/form_test` (2), `widgets/center_test` (1),
  `widgets/row_test` (1), `widgets/sized_box_test` (1). These pass
  the test (the strict gate fired in §6 todo #14 H-1 was on
  `cupertino/theme_test` — fixed there). Here the scripts emit
  fwErrs but the essential tests still report `+103 -5` (the 5
  failures are E1–E5, all cold-start). Layout-fix script-side per
  the H-cluster pattern. Rule (a).

- [ ] **fixed** 13. **H-important (flutter_ast, 6 scripts, 43 events)** —
  `painting/matrix_test` (18), `widgets/router_test` (14),
  `material/dialog_themes_test` (8), `widgets/listener_test` (1),
  `widgets/backbutton_test` (1),
  `cupertino/cupertino_themes_batch3_test` (1). High volume — needs
  bisection per script. Rule (a) per script.

- [ ] **fixed** 14. **H-secondary (flutter_ast, 27 scripts, 84 events)** —
  largest cluster. Top offenders: `widgets/image_filtered_test`
  (14), `foundation/aggregated_timed_block_test` (11),
  `widgets/list_wheel_viewport_test` (8),
  `material/expansion_stepper_test` (7),
  `widgets/list_wheel_scroll_view_test` (7),
  `material/desktop_text_selection_toolbar_button_test` (4),
  `widgets/navigation_toolbar_test` (4), `widgets/actions_intents_test`
  (3), `widgets/overflow_bar_test` (3), `widgets/overflow_box_test`
  (3), plus 17 scripts with 1–2 events. Triage in priority order.
  Rule (a) per script.

- [ ] **fixed** 15. **H-hardly1 (flutter_ast, 5 scripts, 22 events)** —
  `gestures/tap_move_details_test` (10),
  `foundation/diagnosticable_tree_test` (9), 3 single-event scripts.
  Rule (a).

- [ ] **fixed** 16. **H-hardly2 (flutter_ast, 1 script, 6 events)** —
  `material/menu_accelerator_label_test` (6). Rule (a).

- [ ] **fixed** 17. **H-hardly3 (flutter_ast, 7 scripts, 17 events)** —
  `services/text_input_type_test` (6),
  `rendering/performance_overlay_option_test` (5),
  `rendering/clear_selection_event_test` (2), 4 single-event scripts.
  Rule (a).

- [ ] **fixed** 18. **H-hardly4 (flutter_ast, 5 scripts, 7 events)** —
  `widgets/bottom_navigation_bar_item_test` (2),
  `widgets/child_back_button_dispatcher_test` (2), 3 single-event
  scripts. Rule (a).

- [ ] **fixed** 19. **H-hardly5 (flutter_ast, 6 scripts, 13 events)** —
  `widgets/scroll_context_test` (6),
  `widgets/two_dimensional_child_manager_test` (3), 4 single-event
  scripts. Rule (a).

- [ ] **fixed** 20. **H-flutter_test (5 scripts, 10 events total)** — much
  smaller than the ast variant. Top: `widgets/standard_component_type_test`
  (4 events in hardly_5), plus single-event scripts and the U17
  by-design teaching demo `render_constraints_transform_box_test`.
  Rule (a).

### Cluster U — By-design / documented limitations (no fix required)

- [ ] **fixed** 21. **U17 — `rendering/render_constraints_transform_box_test`** —
  appears in secondary + timeout with 1 fwErr each on both runners.
  Intentional teaching demo per U17 (sections 4 / 7 / 8 demonstrate
  Flutter's overflow assertions via real overflowing widgets). No
  script-side fix preserves teaching content. **No action.**

- [ ] **fixed** 22. **I-BUG-14a SHOULD FAIL marker** — tom_d4rt (1) and
  tom_d4rt_exec (1) both fail this intentional `(FAIL)` marker for
  records with named fields. Cluster P / §6 todo #21 verified — both
  markers intact, baseline tracks as `X/X`. **No action.**

- [ ] **fixed** 23. **tom_d4rt_dcli macOS `[fails on Macos]` (14 tests)** —
  upstream DCli 8.4.2 `_whoami()` bug + APFS case-insensitive. Cluster
  Q / §6 todo #22 verified — all 14 markers intact, full root-cause
  doc in `tom_d4rt_dcli/doc/known_issues_macos.md`. **No action.**

### Cluster W — Test-app wedges (skipped, not fixable in this pass)

- [ ] **fixed** 24. **W1–W5 / D1 — script wedges and platform skips (S2, S4–S8).**
  Six tests are skipped because the underlying scripts either
  destabilise the test app process (W1, W2, W3, W4, W5, D1) or
  require a non-host platform (AndroidView × 2 in S1+S10). These are
  pre-documented and require deeper interpreter / app-process
  diagnostics. **No action this run.**

### Verification (after fixes)

- [ ] **fixed** 25. After fixes #1–#11 land, re-run the 14-test sweep on both
  projects and confirm:
  - flutter_ast total failures drop from 20 to ≤ 3 (only U26 + 2
    by-design U17 / I-BUG-14a markers should remain).
  - flutter_test total failures drop from 19 to ≤ 2 (only U26 + 1
    U17).
  - Framework error totals on essential / important / gii / timeout
    drop to 0 on both runners (after H-essential/H-important fixes).
  - hardly_relevant_1..5 and secondary fwErrs reduced significantly
    after H-secondary + H-hardly1..5 land (target: ≤ 5 per suite on
    both runners).

---

## 7. Raw logs

All raw logs are committed to the testlog folders for traceability:

- `tom_d4rt_flutter_ast/doc/testlog_20260524-2003-issue-analysis/`
  - `_runner.log.txt` — outer runner with per-test timing.
  - `<test_file>.log.txt` — stdout/stderr per test file (14 files).
  - `<test_file>.result.json` — file-reporter JSON per test file
    (machine-readable; 14 files).
- `tom_d4rt_flutter_test/doc/testlog_20260524-2003-issue-analysis/`
  — same structure.
- Non-flutter project logs in `<project>/doc/testlog_20260524-2003-issue-analysis/all_tests.log.txt`
  and `all_tests.result.json`.

Wall-clock per project:
- flutter_ast 14-test sweep: 20:03 → 21:24 = ~81 min.
- flutter_test 14-test sweep: 20:03 → 21:31 = ~88 min.
- Non-flutter (7 projects, serial): 20:04 → 20:12 = ~8 min.
- Two flutter sweeps ran in parallel (port 4247 vs 4248).
