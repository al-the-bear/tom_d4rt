# Test Run Issue Analysis — 20260523-1056-issue-analysis

**Run ID:** `20260523-1056-issue-analysis`
**Date:** 2026-05-23 10:59 → 2026-05-23 13:53 (local, CEST)
**Scope:** All 14 flutter test files for both `tom_d4rt_flutter_ast` and
`tom_d4rt_flutter_test`, plus full `dart test` suites for `tom_d4rt`,
`tom_d4rt_ast`, `tom_d4rt_exec`, `tom_d4rt_dcli`, `tom_d4rt_generator`.
**Git revision:** `ee10ed726300cf119ac76d3b730979251470293c (main)`
**Host:** macOS (Darwin) — note: prior baselines were on Linux; some failures
below are macOS-specific.

**Raw artefacts:**

- `tom_d4rt_flutter_ast/doc/testlog_20260523-1056-issue-analysis/*.{result.json,log.txt}`
- `tom_d4rt_flutter_test/doc/testlog_20260523-1056-issue-analysis/*.{result.json,log.txt}`
- `tom_d4rt{,_ast,_exec,_dcli,_generator}/doc/testlog_20260523-1056-issue-analysis/all_tests.{result.json,log.txt}`
- Driver scripts: `_ai/quests/d4rt/_run_testlog_20260523-1056_{ast,test,nonflutter}.sh`
- Driver logs: `<flutter-project>/doc/testlog_20260523-1056-issue-analysis/_driver.log`
- Aggregation tooling: `ztmp/aggregate_results.py`, `ztmp/flutter_summary.py`
- Per-project aggregated JSON: `<flutter-project>/doc/testlog_20260523-1056-issue-analysis/_aggregate.json`

---

## ⚠️ Run-environment note — parallel-driver contention

The two flutter drivers were started in parallel (different ports — 4247 vs
4248) at 10:59:09 and 10:59:12. The shared CPU/memory while two desktop test
apps and five `dart test` VMs span-up concurrently produced two distinct
contention artefacts:

1. **Both `essential_classes_test` runs failed `setUpAll` at start-up**
   with `Bad state: Test app failed to start within 60 seconds`. Both files
   were re-run solo afterwards and recorded green (ast 108/0; test 103/1 —
   the 1 failure is real, see §1.1) — those are the JSON files now in the
   testlog folder.
2. **44 (ast) / 72 (test) tests show as `errored`** with
   `TimeoutException after 0:00:30.000000` or `Bad state: Transport failure
   while running "…" Operation: POST /build … TimeoutException after
   0:00:25.000000`. Of these, **7 appear in both projects** at the same
   script — those are the only ones likely to be reproducible interpreter
   wedges (Cluster S below). The remaining 37 (ast-only) + 65 (test-only)
   are almost certainly contention, not real bugs.

A serial re-run of one project at a time would be the gold-standard way to
verify cluster S; that is recorded as todo #1 below.

---

## Headline numbers

### Flutter projects (after solo essential re-run)

| Project | passed | failed | errored | skipped | scripts_with_fwerr | total fw_err events |
|---|---:|---:|---:|---:|---:|---:|
| **tom_d4rt_flutter_ast**  | 2145 | 2 | 43 | 9 | 23 | 30 |
| **tom_d4rt_flutter_test** | 2112 | 6 | 72 | 9 | 31 | 38 |

Versus the 20260522-1328 baseline (the comparison reference, after Clusters
G #12/#13 fix):

| Project | Δ passed | Δ failed | Δ errored | Δ skipped |
|---|---:|---:|---:|---:|
| tom_d4rt_flutter_ast  | **−7**  | **−34** | **+42** | −1 |
| tom_d4rt_flutter_test | **−38** | **−32** | **+71** | −1 |

The huge drop in `failed` (Cluster A "Undefined variable: build" 24 scripts;
Cluster B+E+F bridge fixes from clusters 11–13) is largely offset by the
contention-induced rise in `errored`. After eliminating the contention noise
(re-running serially), the headline numbers should be ≈ 2188/0/1 (ast) and
≈ 2184/4/1 (test) — the remaining 4 test-only failures are real Cluster B
regressions in `tom_d4rt_flutter_test` only (see §1.10 and §1.11).

### Non-flutter projects

| Project | passed | failed | errored | skipped |
|---|---:|---:|---:|---:|
| tom_d4rt           | 1786 | 1  | 0 | 1 |
| tom_d4rt_ast       |  117 | 0  | 0 | 0 |
| tom_d4rt_exec      | 2292 | 1  | 0 | 0 |
| tom_d4rt_dcli      |  692 | 13 | 1 | 0 |
| tom_d4rt_generator |  660 | 0  | 0 | 0 |

Versus the 20260522-1328 baseline:

| Project | Δ passed | Δ failed | Δ errored | Δ skipped |
|---|---:|---:|---:|---:|
| tom_d4rt           | **+37** | 0 | **−7** | 0 |
| tom_d4rt_ast       | 0 | 0 | 0 | 0 |
| tom_d4rt_exec      | **+35** | 0 | **−8** | 0 |
| tom_d4rt_dcli      | **−12** | **+12** | 0 | 0 |
| tom_d4rt_generator | **+94** | **−1** | 0 | 0 |

Clusters J (bridged-mixin, 7) and K (`d4` binary text-file-busy, 1) and M
(generator dart_overview, 1) are **all cleared**. The +12 dcli regressions
are macOS-only and pre-known (see §4.D).

The single remaining failure in `tom_d4rt` / `tom_d4rt_exec` is the
intentional `SHOULD FAIL` marker `I-BUG-14a`.

---

## 1. Per-flutter-file failure breakdown (tom_d4rt_flutter_ast)

Runtime errors below are extracted from each `*.log.txt`. The JSON reporter
records the outer `expect(true, …)` assertion; SendTestRunner echoes the
actual D4rt runtime error into stdout.

### 1.1 essential_classes_test — 108 passed (clean after solo re-run)

The first run failed at `setUpAll`: `Bad state: Test app failed to start
within 60 seconds`. After the solo re-run, every script passes. **No
script-level failures.** 4 scripts emit framework errors (see §3).

### 1.2 important_classes_test — 164 passed, 0 failed, 0 errored

Clean. 7 scripts emit framework errors (see §3).

### 1.3 secondary_classes_test — 644 passed, 0 failed, 9 errored, 1 skipped

| # | script | inner error | contention? |
|---|---|---|---|
| E1 | `rendering/render_custom_paint_test.dart` | Transport failure POST /build 25s | **shared with test** — see §S |
| E2 | `services/hybrid_android_view_controller_test.dart` | Transport failure POST /build 25s | ast-only |
| E3 | `widgets/always_scrollable_scroll_physics_test.dart` | TimeoutException 30s | ast-only |
| E4 | `widgets/context_menu_button_item_test.dart` | TimeoutException 30s | ast-only |
| E5 | `widgets/inherited_widget_test.dart` | TimeoutException 30s | ast-only |
| E6 | `widgets/page_storage_bucket_test.dart` | TimeoutException 30s | ast-only |
| E7 | `widgets/raw_view_test.dart` | TimeoutException 30s | ast-only |
| E8 | `widgets/selectable_region_test.dart` | TimeoutException 30s | ast-only |
| E9 | `widgets/sliver_semantics_test.dart` | TimeoutException 30s | ast-only |

**Skipped:** `widgets/android_view_test.dart` — *AndroidView only renders on Android* (platform-gated; OK).
5 scripts emit framework errors (§3).

### 1.4 hardly_relevant_classes_1_test — 195 passed, 0 failed, 8 errored, 2 skipped

| # | script | inner error | contention? |
|---|---|---|---|
| E10 | `cupertino/class_test.dart` | TimeoutException 30s | ast-only |
| E11 | `dart_ui/class_test.dart` | Transport failure 25s | ast-only |
| E12 | `dart_ui/opacity_engine_layer_test.dart` | TimeoutException 30s | **shared** — §S |
| E13 | `dart_ui/uniform_vec2_slot_test.dart` | TimeoutException 30s | ast-only |
| E14 | `foundation/diagnostics_serialization_delegate_test.dart` | TimeoutException 30s | ast-only |
| E15 | `foundation/object_event_test.dart` | TimeoutException 30s | ast-only |
| E16 | `gestures/least_squares_solver_test.dart` | Transport failure 25s | ast-only |
| E17 | `gestures/primary_pointer_gesture_recognizer_test.dart` | Transport failure 25s | ast-only |

**Skipped:**

- `dart_ui/image_sampler_slot_test.dart` — *D1: destabilises the test app for subsequent dart_ui/gestures scripts on Linux. Run via bisect_test.dart instead.* (known interpreter-related instability).
- `dart_ui/isolate_name_server_test.dart` — *IsolateNameServer is not supported by the d4rt interpreter (requires real Dart isolate infrastructure)* (interpreter limitation; OK).

2 scripts emit framework errors (§3).

### 1.5 hardly_relevant_classes_2_test — 197 passed, 0 failed, 6 errored

All 6 entries are TimeoutException 30s or Transport failure 25s; all **ast-only** (no overlap with test project). Likely contention:

| # | script | inner error |
|---|---|---|
| E18 | `material/dynamic_scheme_variant_test.dart` | TimeoutException 30s |
| E19 | `material/hour_format_test.dart` | TimeoutException 30s |
| E20 | `material/progress_indicator_test.dart` | TimeoutException 30s |
| E21 | `material/snack_bar_theme_data_test.dart` | TimeoutException 30s |
| E22 | `material/widget_state_input_border_test.dart` | Transport failure 25s |
| E23 | `painting/one_frame_image_stream_completer_test.dart` | TimeoutException 30s |

### 1.6 hardly_relevant_classes_3_test — 194 passed, 0 failed, 7 errored

| # | script | inner error | contention? |
|---|---|---|---|
| E24 | `rendering/image_filter_config_test.dart` | TimeoutException 30s | ast-only |
| E25 | `rendering/render_app_kit_view_test.dart` | TimeoutException 30s | **shared** — §S |
| E26 | `rendering/sliver_paint_order_test.dart` | Transport failure 25s | ast-only |
| E27 | `services/application_switcher_description_test.dart` | Transport failure 25s | ast-only |
| E28 | `services/keyboard_key_test.dart` | TimeoutException 30s | ast-only |
| E29 | `services/raw_key_event_data_ios_test.dart` | Transport failure 25s | ast-only |
| E30 | `services/text_editing_delta_deletion_test.dart` | Transport failure 25s | ast-only |

### 1.7 hardly_relevant_classes_4_test — 224 passed, 0 failed, 3 errored

| # | script | inner error |
|---|---|---|
| E31 | `widgets/draggable_scrollable_actuator_test.dart` | TimeoutException 30s |
| E32 | `widgets/extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart` | TimeoutException 30s |
| E33 | `widgets/overscroll_notification_test.dart` | Transport failure 25s |

2 scripts emit framework errors (§3).

### 1.8 hardly_relevant_classes_5_test — 226 passed, 0 failed, 4 errored

| # | script | inner error | contention? |
|---|---|---|---|
| E34 | `widgets/restorable_num_n_test.dart` | TimeoutException 30s | ast-only |
| E35 | `widgets/selectable_region_selection_status_test.dart` | TimeoutException 30s | ast-only |
| E36 | `widgets/tree_sliver_state_mixin_test.dart` | TimeoutException 30s | **shared** — §S |
| E37 | `widgets/update_selection_intent_test.dart` | Transport failure 25s | ast-only |

1 script emits framework errors (§3).

### 1.9 crashing_tests_test / blocking_tests_test / interactive_tests_test — clean

0 failures, 0 errors. Interactive test still shows the same soft tap-by-text
issues recorded as InteractResult in stdout but **does not fail** (item I in
prior baseline; tracked as todo #12 below).

### 1.10 timeout_tests_test — 48 passed, 0 failed, 3 errored

| # | script | inner error | contention? |
|---|---|---|---|
| E38 | `rendering/render_custom_paint_test.dart` | Transport failure 25s | **shared** — §S |
| E39 | `retest/widgets/app_kit_view_test.dart` | Transport failure 25s | **shared** — §S |
| E40 | `widgets/sliver_animated_list_state_test.dart` | Transport failure 25s | ast-only |

### 1.11 generator_interpreter_issues_test — 80 passed, 0 failed, 1 errored, 2 skipped

| # | script | inner error |
|---|---|---|
| E41 | `rendering/render_custom_paint_test.dart` | Transport failure 25s — **ast-only here** but mirrors §1.10 wedge |

**Skipped:**

- `widgets/android_view_test.dart` — AndroidView platform-gated (OK).
- `widgets/animated_switcher_test.dart` — *W5: wedges test app /build for ~60s then "Lost connection to device"; cascades 34 subsequent gii tests.* (known wedge; OK to skip).

### 1.12 generator_interpreter_retest_test — 50 passed, 2 failed, 2 errored, 4 skipped

| # | script | inner error |
|---|---|---|
| **F1** | `retest/dart_ui/system_color_palette_test.dart` | `Expected: <true> Actual: <false>` — script asserts behaviour that depends on `SystemColor` API which is unsupported on Linux/macOS without a platform-channel responder. **Real failure**; also fails in test project. |
| **F2** | `retest/material/button_bar_layout_behavior_test.dart` | `Runtime Error: Undefined variable: ButtonBar` — `ButtonBar` was removed from `package:flutter/material.dart` (Flutter 3.x deprecation). **Real failure**; also fails in test project. |
| E42 | `retest/rendering/render_animated_size_state_test.dart` | Transport failure 25s — **shared** — §S |
| E43 | `retest/widgets/app_kit_view_test.dart` | Transport failure 25s — **shared** — §S (and also fails as F4 in test) |

**Skipped:**

- `retest/widgets/context_action_test.dart` — *W1: script passes in isolation but wedges app /clear afterward.* (known wedge).
- `retest/widgets/default_text_editing_shortcuts_test.dart` — *W2: /build hangs 30s, wedges app /clear afterward.* (known wedge).
- `retest/widgets/live_text_input_status_test.dart` — *W3: cascade victim of W2 in retest runs.* (depends on W2 fix).
- `retest/widgets/lock_state_test.dart` — *W4: wedges test app /build with HttpException.* (known wedge).

1 script emits framework errors (§3).

### Summary of real failures in flutter_ast

Just **2 assertion failures** (F1, F2), both in `generator_interpreter_retest_test`. Everything else listed as errored is either contention (37 ast-only entries) or candidate wedges shared with the test project (Cluster §S below).

---

## 2. Per-flutter-file failure breakdown (tom_d4rt_flutter_test) — deltas only

The runtime errors are largely identical to `flutter_ast` for the shared
errored scripts (Cluster §S). The notable **assertion failures unique to
flutter_test** mirror the previously-tracked Cluster B regressions that
have evidently not been ported to the source-based flutter_test runner.

### 2.A essential_classes_test — +1 real failure vs. ast

| # | script | inner error |
|---|---|---|
| **F3** | `material/materialapp_test.dart` | `Runtime Error: Native error during bridged constructor 'router' for class 'MaterialApp': Argument Error: Invalid parameter "routeInformationParser": expected RouteInformationParser<Object>?, got InterpretedInstance(_SimpleRouteParser)` — Cluster B (interpreted subclass unwrap). **Passes in flutter_ast, fails in flutter_test** — fix already shipped for the AST runner has not been ported. |

Plus 4 contention errored: `cupertino/picker_test.dart`,
`material/buttonstyle_test.dart`, `material/stepper_test.dart`,
`widgets/changenotifier_test.dart`. (essential ran solo on flutter_test
*before* the ast driver re-ran essential, so some residual contention
remained — see §S analysis.)

### 2.B important_classes_test — +1 real failure vs. ast

| # | script | inner error |
|---|---|---|
| **F4** | `widgets/decoratedbox_test.dart` | `Runtime Error: Native error during default bridged constructor for 'DecoratedBox': Argument Error: Invalid parameter "decoration": expected Decoration, got InterpretedInstance(DiagonalStripesDecoration)` — Cluster B. **Passes in flutter_ast, fails in flutter_test.** |

Plus 5 contention errored (all `painting/*` + `animation/animationstyle`),
all transport failures / 30s timeouts during the contention window.

### 2.C secondary_classes_test — +2 contention errored, same skip set

11 errored (vs. 9 in ast); the 2 extra are `widgets/proxy_element_test.dart`
and `widgets/text_selection_controls_test.dart`, both
transport-failure-only. No new real failures.

### 2.D hardly_relevant_classes_{1..5}_test — contention-only deltas

Per-suite errored counts are all 1–2 higher than ast and the additional
entries are exclusively TimeoutException/Transport failure with no shared
scripts. Likely pure contention.

### 2.E timeout_tests_test — same 2 shared §S entries; no new real failures

### 2.F generator_interpreter_issues_test — 3 errored (all contention, no new real failures)

### 2.G generator_interpreter_retest_test — +2 real failures vs. ast

| # | script | inner error |
|---|---|---|
| **F5** | `retest/widgets/app_kit_view_test.dart` | `Runtime Error: Native error during default bridged constructor for 'AppKitView': Argument Error: Invalid parameter "gestureRecognizers": cannot convert to Set<Factory<OneSequenceGestureRecognizer>>` — Cluster B (Set<Factory<…>> coercion). **Passes in flutter_ast, fails in flutter_test.** |
| **F6** | `retest/widgets/back_button_listener_test.dart` | `Expected: <true> Actual: <false> A RenderFlex overflowed by 70 pixels on the bottom.` — flutter_test's success check treats framework errors as test failures, so this is actually an H1 layout overflow surfaced as a script failure (the metric line records `frameworkErrors=1`). Passes silently in flutter_ast (where the same overflow is recorded but not converted to a fail). Two reasonable fixes: (a) fix the layout (drop the 70 px overflow); (b) align flutter_ast's stricter failure semantics with flutter_test or vice-versa. |

### Summary of real failures in flutter_test

**6 assertion failures** total: F1 + F2 (same as ast) + F3, F4, F5, F6 (all
Cluster B back-port failures present only in the source-based runner). All
six are deterministic; none are contention.

---

## 3. Framework errors (passing tests that emit Flutter framework events)

Framework error counts dropped sharply versus the 20260522-1328 baseline
(painting/border_test 34→0, dialog 8→0, themes_batch2 8→0, callback_handle
6→0, bottomappbar 5→0, bottomnavigationbar 3→0, themes_batch3 2→0). The
remaining high-count scripts and totals are:

### 3.A tom_d4rt_flutter_ast — 23 scripts, 30 events

| events | suite | script |
|---:|---|---|
| 5 | essential_classes_test | `cupertino/theme_test.dart` |
| 3 | hardly_relevant_classes_1_test | `gestures/i_o_s_scroll_view_fling_velocity_tracker_test.dart` |
| 2 | important_classes_test | `widgets/futurebuilder_test.dart` |
| 2 | hardly_relevant_classes_4_test | `widgets/directional_focus_action_test.dart` |
| 1 | essential_classes_test | `material/dropdown_test.dart` |
| 1 | essential_classes_test | `painting/textstyle_test.dart` |
| 1 | essential_classes_test | `widgets/animation_test.dart` |
| 1 | important_classes_test | `widgets/decoratedbox_test.dart` |
| 1 | important_classes_test | `material/refreshindicator_test.dart` |
| 1 | important_classes_test | `material/dialog_themes_test.dart` |
| 1 | important_classes_test | `material/dropdownform_test.dart` |
| 1 | important_classes_test | `cupertino/cupertino_themes_batch3_test.dart` |
| 1 | important_classes_test | `services/platform_test.dart` |
| 1 | secondary_classes_test | `widgets/placeholder_test.dart` |
| 1 | secondary_classes_test | `painting/box_painter_test.dart` |
| 1 | secondary_classes_test | `painting/decoration_image_painter_test.dart` |
| 1 | secondary_classes_test | `rendering/render_constraints_transform_box_test.dart` |
| 1 | secondary_classes_test | `rendering/render_exclude_semantics_test.dart` |
| 1 | hardly_relevant_classes_1_test | `animation/cubic_test.dart` |
| 1 | hardly_relevant_classes_4_test | `widgets/editable_text_tap_up_outside_intent_test.dart` |
| 1 | hardly_relevant_classes_5_test | `widgets/slotted_multi_child_render_object_widget_test.dart` |
| 1 | timeout_tests_test | `rendering/render_constraints_transform_box_test.dart` |
| 1 | generator_interpreter_retest_test | `retest/material/button_bar_layout_behavior_test.dart` |

Cupertino theme_test (5×56 px bottom overflow) is the largest single
contributor and the natural next H1 target.

### 3.B tom_d4rt_flutter_test — 31 scripts, 38 events

Same set as ast plus 8 additional scripts (all 1–2 events):
`essential_classes_test:widgets/center_test.dart` (1),
`secondary_classes_test:widgets/checked_mode_banner_test.dart` (1),
`hardly_relevant_classes_3_test:services/raw_keyboard_test.dart` (1),
`hardly_relevant_classes_4_test:widgets/callback_shortcuts_test.dart` (2),
`hardly_relevant_classes_4_test:widgets/child_back_button_dispatcher_test.dart` (2),
`hardly_relevant_classes_5_test:widgets/scroll_notification_observer_state_test.dart` (1),
`timeout_tests_test:retest/widgets/back_button_listener_test.dart` (1),
`generator_interpreter_retest_test:retest/widgets/app_kit_view_test.dart` (1),
`generator_interpreter_retest_test:retest/widgets/back_button_listener_test.dart` (1).

All entries are RenderFlex overflows (typically 56 px bottom, 21–25 px
bottom, or 2.0 px right) — same H1 family that was systematically reduced
in prior runs.

---

## §S. Wedge-candidates (shared errored scripts across both projects)

These are the **only** errored entries that appear in *both* flutter_ast
and flutter_test runs — strong signal they are reproducible interpreter
wedges rather than contention artefacts. A serial re-run would confirm.

| # | script | suite(s) | symptom |
|---|---|---|---|
| S1 | `rendering/render_custom_paint_test.dart` | secondary + timeout (+ gii on ast) | Transport failure POST /build 25s |
| S2 | `dart_ui/opacity_engine_layer_test.dart` | hardly_1 | TimeoutException 30s (ast); Transport 25s (test) |
| S3 | `rendering/render_app_kit_view_test.dart` | hardly_3 | TimeoutException 30s (both) |
| S4 | `widgets/tree_sliver_state_mixin_test.dart` | hardly_5 (ast) + hardly_5 (test, also hardly_5) | TimeoutException 30s |
| S5 | `retest/widgets/app_kit_view_test.dart` | timeout (both) — also F5 in retest test | Transport 25s (timeout); native unwrap (retest) |
| S6 | `retest/rendering/render_animated_size_state_test.dart` | retest (both) | Transport failure POST /build 25s |

§S total: **6 candidate wedges** (potentially up to 7 if `render_custom_paint`
appears in three independent suites). Each is a one-or-two-script
investigation — start with isolated repro in `bisect_test.dart`.

---

## 4. Non-flutter project results

### 4.A tom_d4rt — 1786 passed, 1 failed (SHOULD FAIL), 1 skipped

| # | name | error |
|---|---|---|
| F7 | `Open Bugs - Won't Fix (SHOULD FAIL) I-BUG-14a: Records with named fields. [2026-02-10 06:37] (FAIL)` | Pre-existing intentional `SHOULD FAIL` marker. **No fix required.** |

**Skipped (1):** `D4-WRAP-01 — extractBridgedArg unwraps BridgedInstance<int> to double` — *Needs BridgedInstance mock for proper testing* (test-infra; OK).

**Δ from baseline:** Cluster J (7 bridged-mixin errors I-BRIDGE-1/-4/-11/-12/-13/-14/-15) is **cleared**.

### 4.B tom_d4rt_ast — clean

117/117 tests passed. No regressions.

### 4.C tom_d4rt_exec — 2292 passed, 1 failed (SHOULD FAIL)

Same `I-BUG-14a` SHOULD FAIL marker as tom_d4rt (shared fixture).

**Δ from baseline:** Cluster J (7 shared bridged-mixin) and Cluster K (1
`G-TST-9: UBR01 user bridge class (basic)` "Text file busy" on the `d4`
binary) are **cleared**.

### 4.D tom_d4rt_dcli — 692 passed, 13 failed, 1 errored (all macOS-known)

The 13 failures + 1 error are **upstream DCli bugs on macOS**, documented
in `tom_d4rt_dcli/doc/known_issues_macos.md`. Root cause: DCli 8.4.2's
`_whoami()` returns `"root"` instead of the actual user under the macOS
Dart VM (no controlling terminal → `getlogin()` throws `ENXIO` →
incorrectly defaulted to `'root'`). Every test that depends on
`Shell.current.loggedInUser` matching the file owner therefore reports a
permission mismatch.

All 13 failing tests carry the `[fails on Macos]` suffix in their
description. Status: **not fixing — upstream DCli bug**.

| # | test | failure |
|---|---|---|
| F8  | `find case-insensitive matching when specified [fails on Macos]` | macOS Dcli upstream |
| F9  | `isWritable returns true for writable file [fails on Macos]` | macOS Dcli upstream |
| F10 | `isWritable returns true for writable directory [fails on Macos]` | macOS Dcli upstream |
| F11 | `isWritable can write to writable file [fails on Macos]` | macOS Dcli upstream |
| F12 | `chmod via shell makes file writable [fails on Macos]` | macOS Dcli upstream |
| F13 | `chmod via shell handles directory permissions [fails on Macos]` | macOS Dcli upstream |
| F14 | `permission modes mode 644 - rw-r--r-- [fails on Macos]` | macOS Dcli upstream |
| F15 | `permission modes mode 755 - rwxr-xr-x [fails on Macos]` | macOS Dcli upstream |
| F16 | `permission modes mode 600 - rw------- [fails on Macos]` | macOS Dcli upstream |
| F17 | `permission modes mode 700 - rwx------ [fails on Macos]` | macOS Dcli upstream |
| F18 | `special permissions hidden files are accessible [fails on Macos]` | macOS Dcli upstream |
| F19 | `special permissions symlink permissions follow target [fails on Macos]` | macOS Dcli upstream |
| F20 | `real-world scenarios create config file with restricted permissions [fails on Macos]` | macOS Dcli upstream |
| E44 | `real-world scenarios check before writing [fails on Macos]` | `Bad state: No element` — same macOS root cause |

**Δ from baseline:** All 14 macOS-known entries were not surfaced in the
20260522-1328 run (which executed on Linux). The previous run's 2 dcli
failures (`VSCodeWindow.getActiveTextEditor`) are **gone** — either the
gating in Cluster L was applied or the headless test environment no longer
triggers them on macOS.

### 4.E tom_d4rt_generator — 660 passed, 0 failed, clean

**Δ from baseline:** The 20260522-1328 `dart_overview` setUpAll failure is
**cleared**. +94 tests added since baseline.

---

## 5. Skipped tests — full catalogue with reasons

### Flutter projects (9 skips each, identical set)

| # | test | suite | reason | classification |
|---|---|---|---|---|
| K1 | `widgets/android_view_test.dart` | secondary | *AndroidView only renders on Android* | platform-gated; keep skipped |
| K2 | `dart_ui/image_sampler_slot_test.dart` | hardly_1 | *D1: destabilises subsequent dart_ui/gestures scripts on Linux. Run via bisect_test.dart instead.* | known interpreter instability (D1); investigate separately |
| K3 | `dart_ui/isolate_name_server_test.dart` | hardly_1 | *IsolateNameServer is not supported by the d4rt interpreter (requires real Dart isolate infrastructure)* | interpreter limitation; keep skipped |
| K4 | `widgets/android_view_test.dart` | gii | (same as K1) | platform-gated |
| K5 | `widgets/animated_switcher_test.dart` | gii | *W5: wedges test app /build for ~60s then "Lost connection to device"; cascades 34 subsequent gii tests.* | known interpreter wedge (W5); separate cluster work |
| K6 | `retest/widgets/context_action_test.dart` | retest | *W1: script passes in isolation but wedges app /clear afterward, causing cascade of timeouts.* | known interpreter wedge (W1) |
| K7 | `retest/widgets/default_text_editing_shortcuts_test.dart` | retest | *W2: /build hangs 30s, wedges app /clear afterward.* | known interpreter wedge (W2) |
| K8 | `retest/widgets/live_text_input_status_test.dart` | retest | *W3: cascade victim of W2 in retest runs.* | depends on W2 fix |
| K9 | `retest/widgets/lock_state_test.dart` | retest | *W4: wedges test app /build with HttpException: Connection closed before full header was received.* | known interpreter wedge (W4) |

> **Note:** `dart_ui/system_color_palette_test.dart` (previously skipped in
> retest with reason *"SystemColor not supported on Linux"*) is **no longer
> skipped** in this run — its `@Skip` was removed, but the underlying
> interpreter behaviour was not corrected, so the test now **fails** as F1
> in §1.12. Either re-skip it or fix the SystemColor bridge.

### Non-flutter projects

| # | test | project | reason |
|---|---|---|---|
| K10 | `D4-WRAP-01: extractBridgedArg unwraps BridgedInstance<int> to double.` | tom_d4rt | *Needs BridgedInstance mock for proper testing* (test-infra; OK) |

---

## 6. Numbered fix-todo list

Tick each box after fix + cluster-fix protocol (reproduce → fix → mirror
between `tom_d4rt`/`tom_d4rt_ast` if interpreter-side → regenerate bridges
if generator-side → serial-rerun gii+essential+important+secondary +
relevant non-flutter `dart test` → commit).

### Cluster S — Wedge-candidate verification (run serially first)

- [ ] **fixed** 1. Re-run both flutter projects **serially** (one after the
  other, not in parallel) to disambiguate the 37 ast-only + 65 test-only
  contention timeouts from genuine wedges. Expectation: ≈ 2185+ passed / 0
  errored / 1 failed (ast) and ≈ 2185+ passed / 0 errored / 4 failed
  (test). Use the existing driver scripts `_ai/quests/d4rt/_run_testlog_*.sh`
  but with the second driver `wait`-ed on the first.
- [ ] **fixed** 2. **S1** `rendering/render_custom_paint_test.dart` —
  reproduces in 3 suites (secondary, timeout, gii ast). Repro via
  `bisect_test.dart`, classify as wedge or fix the responsible
  CustomPaint bridge/method.
- [ ] **fixed** 3. **S2** `dart_ui/opacity_engine_layer_test.dart` —
  hardly_1 wedge or codegen issue; repro and classify.
- [ ] **fixed** 4. **S3** `rendering/render_app_kit_view_test.dart` —
  shared 30s timeout; macOS-specific (AppKitView platform); decide whether
  to skip with reason or fix.
- [ ] **fixed** 5. **S4** `widgets/tree_sliver_state_mixin_test.dart` —
  shared 30s timeout; investigate the TreeSliverStateMixin demo.
- [ ] **fixed** 6. **S5** `retest/widgets/app_kit_view_test.dart` — both a
  `timeout_tests_test` transport-failure entry AND a `generator_interpreter_retest_test`
  Cluster B real failure (F5); fix the Cluster B unwrap first (todo #8),
  then re-run to confirm the timeout entry also clears.
- [ ] **fixed** 7. **S6** `retest/rendering/render_animated_size_state_test.dart`
  — shared 25s transport failure on /build; investigate render_animated_size.

### Cluster B — Back-port `InterpretedInstance` unwrap to flutter_test

The Cluster B fix shipped for `tom_d4rt_flutter_ast` (the AST-based runner
unwraps `InterpretedInstance` whose declared chain includes the bridged
abstract class) is not in `tom_d4rt_flutter_test`. Four scripts pass in ast
and fail in test:

- [ ] **fixed** 8. **F3** `essential_classes_test material/materialapp_test.dart` —
  `MaterialApp.router(routeInformationParser:)` rejects `_SimpleRouteParser`.
  Port the AST-runner's `D4.unwrapAs<RouteInformationParser>` walk to the
  source-based runner OR migrate `tom_d4rt_flutter_test` to share the AST
  test app.
- [ ] **fixed** 9. **F4** `important_classes_test widgets/decoratedbox_test.dart` —
  `DecoratedBox(decoration: DiagonalStripesDecoration)` rejection; same
  back-port.
- [ ] **fixed** 10. **F5** `retest/widgets/app_kit_view_test.dart` —
  `AppKitView.gestureRecognizers: Set<Factory<…>>` coercion; same back-port.
- [ ] **fixed** 11. **F6** `retest/widgets/back_button_listener_test.dart` —
  framework error (RenderFlex overflowed by 70 px bottom) classified as a
  failure by flutter_test's success check; flutter_ast records the same
  overflow without failing. Fix the layout overflow (preferred — addresses
  the root cause) and then reconcile the runners' failure-on-framework-error
  semantics so they agree.

### Cluster N — New retest/material failure (both projects)

- [ ] **fixed** 12. **F2** `retest/material/button_bar_layout_behavior_test.dart`
  — `Runtime Error: Undefined variable: ButtonBar`. `ButtonBar` was removed
  from `package:flutter/material.dart` (Flutter 3.x deprecation). Either
  rewrite the demo with `OverflowBar`/`Row` or remove the test from the
  `retest` corpus. Affects **both projects**.

### Cluster O — SystemColor regression / mis-skipped

- [ ] **fixed** 13. **F1** `retest/dart_ui/system_color_palette_test.dart` —
  was previously skipped with reason *"SystemColor not supported on Linux"*;
  skip is gone but the underlying limitation is still present. Either re-add
  `@Skip('SystemColor not supported on the current platform')` (the inner
  error matches: `Runtime Error: Unexpected error: Unsupported operation:
  SystemColor not supported on the current platform.`) or implement the
  SystemColor bridge in the interpreter. Affects **both projects**.

### Cluster H — Framework errors (RenderFlex overflows)

- [ ] **fixed** 14. **H-1 (5 events)** `cupertino/theme_test.dart` — 5×
  `RenderFlex overflowed by 56 pixels on the bottom` in essential. Wrap the
  theme-demo column in `SingleChildScrollView` or raise the preview frame's
  fixed height. Affects both projects (identical script).
- [ ] **fixed** 15. **H-2 (3 events)** `gestures/i_o_s_scroll_view_fling_velocity_tracker_test.dart`
  in hardly_1 — investigate the demo's row layout.
- [ ] **fixed** 16. **H-3 (2 events each, both projects)**
  `widgets/futurebuilder_test.dart` (important),
  `widgets/directional_focus_action_test.dart` (hardly_4) — per-script
  layout audit (Flexible/Expanded).
- [ ] **fixed** 17. **H-4 (test-only, 2 events each)**
  `widgets/callback_shortcuts_test.dart`,
  `widgets/child_back_button_dispatcher_test.dart` (hardly_4) — appear only
  in flutter_test; cross-check if the source-based runner's frame size
  differs from the AST runner.
- [ ] **fixed** 18. **H-5 (single-event scripts, fix in batches)** —
  `material/dropdown_test.dart`, `painting/textstyle_test.dart`,
  `widgets/animation_test.dart`, `widgets/decoratedbox_test.dart`,
  `material/refreshindicator_test.dart`, `material/dialog_themes_test.dart`,
  `material/dropdownform_test.dart`,
  `cupertino/cupertino_themes_batch3_test.dart`,
  `services/platform_test.dart`, `widgets/placeholder_test.dart`,
  `painting/box_painter_test.dart`,
  `painting/decoration_image_painter_test.dart`,
  `rendering/render_constraints_transform_box_test.dart` (×2 in different
  suites), `rendering/render_exclude_semantics_test.dart`,
  `animation/cubic_test.dart`,
  `widgets/editable_text_tap_up_outside_intent_test.dart`,
  `widgets/slotted_multi_child_render_object_widget_test.dart`,
  `retest/material/button_bar_layout_behavior_test.dart`. Per-script
  Flexible/Expanded/SizedBox tweaks.
- [ ] **fixed** 19. **H-6 (test-only single events)** —
  `widgets/center_test.dart` (essential),
  `widgets/checked_mode_banner_test.dart` (secondary),
  `services/raw_keyboard_test.dart` (hardly_3),
  `widgets/scroll_notification_observer_state_test.dart` (hardly_5),
  `retest/widgets/back_button_listener_test.dart` (twice),
  `retest/widgets/app_kit_view_test.dart`.

### Cluster I — Interactive tap-by-text (carried over)

- [ ] **fixed** 20. Update `interactive_tests_test.dart` script entries for
  `showdialog_test.dart`, `showdatepicker_test.dart`,
  `showtimepicker_test.dart` — replace `tapText("Option A"/"Cancel")` with
  `tapByKey(…)` or correct localised labels. (Carried over from baseline;
  still soft-fails in stdout but does not fail the test.)

### Cluster P — Pre-existing intentional & not-fixable

- [ ] **fixed** 21. **F7** `I-BUG-14a: Records with named fields` —
  intentional `SHOULD FAIL` marker; verify the description still includes
  the `(SHOULD FAIL)` marker and that the test isn't accidentally counted
  as a regression by downstream tooling. **No code change required.**

### Cluster Q — macOS DCli known-fails (do not fix)

- [ ] **fixed** 22. **F8–F20, E44** — 14 `[fails on Macos]` failures in
  `tom_d4rt_dcli/test/{permissions,directory_operations}_test.dart`.
  Documented upstream DCli 8.4.2 `_whoami()` bug. Verify the existing
  `doc/known_issues_macos.md` covers them and (optionally) gate the
  affected tests with `@TestOn('!mac-os')` so they don't surface as
  failures on macOS hosts. **No interpreter change required.**

### Cluster R — Verification

- [ ] **fixed** 23. After all 1–22 fixes, re-run the four-suite serial
  protocol per project (gii + essential + important + secondary) and
  confirm the headline numbers drop to ≈ 2188/0/0 (ast) and ≈ 2192/0/0
  (test) with framework error totals ≤ 5 each.

---

## 7. Verification protocol notes

Per `_copilot_guidelines/d4rt/` and the quest overview:

1. Reproduce each failing/erroring script in isolation via `bisect_test.dart` *before* changing code.
2. Fix the generator or interpreter (never `.b.dart` files directly — see overview).
3. Mirror any interpreter change between `tom_d4rt` and `tom_d4rt_ast` in the same commit.
4. Regenerate bridges with `tom_d4rt_flutterm/tool/regenerate_bridges.dart` (or set `D4RT_SKIP_BRIDGE_REGEN=1` only when iterating).
5. Re-run **serially** in order: `gii` → `essential` → `important` → `secondary`. Never parallel `flutter test` invocations in the same package — and per this run, **do not run the two flutter projects' drivers in parallel either** unless explicitly addressing the contention by isolating the test apps further.
6. Only commit + push after the four suites pass; one cluster per commit.

> **Operational lesson from this run:** the user's instruction permitted
> parallel runs because the two projects use different HTTP ports
> (4247 vs 4248). In practice, the macOS host's CPU+memory could not keep
> the two test app processes plus five concurrent `dart test` VMs warm
> enough during the start-up window, and again whenever long-running
> render-heavy scripts collided. **All future runs of the joint corpus
> should be serial across projects** to avoid contaminating the metrics
> with timeouts that have no underlying interpreter cause. Todo #1
> captures this as a one-shot rerun task.
