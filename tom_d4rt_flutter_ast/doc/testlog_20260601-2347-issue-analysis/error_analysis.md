# Error Analysis — 20260601-2347

| Field | Value |
| --- | --- |
| **Fix-ID** | `20260601-2347-issue-analysis` |
| **Sweep timestamp** | 2026-06-01 23:50:00 → 2026-06-02 03:04:14 CEST (3 h 14 min wall) |
| **Non-Flutter run** | 2026-06-02 03:09:19 → 03:11:49 CEST |
| **Git revision** (sweep time) | `1cc2a53c` — `fix(d4rt-flutter-test): close C.202 — remove interactive_tests @Timeout(240s)` (branch `main`) |
| **Flutter projects swept** | `tom_d4rt_flutter_ast` (AST-bundle path, port 14250), `tom_d4rt_flutter_test` (source-direct path, port 14251) |
| **Non-Flutter projects** | `tom_d4rt`, `tom_d4rt_ast`, `tom_ast_generator`, `tom_d4rt_generator`, `tom_d4rt_exec` |
| **Driver script** | `tom_d4rt_flutter_ast/tool/sweep_both_projects.sh` (both projects parallel; files serial within each project) |
| **Files swept** | 14 per Flutter project = 28; 5 non-Flutter projects |
| **Per-file budget** | essential 300, important 900, secondary 3000, hardly_relevant_* 1200, crashing 300, timeout 900, blocking 300, generator_* 900, interactive 900 (s) |

---

## 0. Headline — this sweep is host-load-contaminated; treat with care

> **0 genuine test failures. 174 Flutter "errors" (AST 74 + TEST 100), but the overwhelming majority are CPU-starvation artifacts, not code regressions.** The machine was saturated by macOS Exchange-sync daemons during the overnight run.

**Proof of contamination:**

- Right after the sweep, `ps`/`uptime` showed `exchangenotesd` at **51 % CPU** + `exchangesyncd` at **36 % CPU** + Telegram at 11 % — these background daemons were active across the 23:50→03:04 window.
- METRIC timings (per successful `/build`): mean `totalMs` ≈ **6000 ms** (normal range for this corpus is ~2500–3500 ms). AST had **374** builds > 10 s and **118** builds > 20 s; TEST had **361** > 10 s and **157** > 20 s. Max build hit **30 211 ms / 30 277 ms** — i.e. right at the **30 s per-test timeout wall**.
- The 107 `Test timed out after 30 seconds` errors are builds whose interpretation crossed 30 s purely from CPU starvation (e.g. `progress_indicator_test.dart` showed `interpretEndMs=17585` — a script that normally interprets in ~2–3 s).
- The 67 transport wedges are spread across **66 distinct scripts**, nearly all **single-occurrence**; only **one** script (`dart_ui/backdrop_filter_engine_layer_test.dart`) wedged on **both** projects. A genuine per-script wedge reproduces; a random single-occurrence spread across every category is the signature of load.
- The previous sweep at a near-identical revision (`20260529-1944`, AST = 2191 pass / 0 fail / **4** err) is unreachable from a code change alone; the jump to 74/100 err with 8 files KILLED at budget is environmental.

**Consequence for the TODO list (§8):** the very first step is a **clean re-run on a quiescent host**. Only errors that survive that re-run are genuine and worth a code fix. Two genuine *interpreter* bugs were nonetheless found in the logs (they do not depend on load) and are actionable immediately — see §4 and TODO #2/#3.

---

## 1. Top-level summary

### Flutter projects

| Project | Pass | Fail | Error | Skip | Files clean | Notes |
| --- | ---: | ---: | ---: | ---: | --- | --- |
| `tom_d4rt_flutter_ast` | **1754** | **0** | **74** | 4 | 6/14 | 8 files KILLED at budget (load) |
| `tom_d4rt_flutter_test` | **1888** | **0** | **100** | 4 | 6/14 | 8 files KILLED at budget (load) |
| **Combined** | **3642** | **0** | **174** | 8 | 12/28 | — |

Error split: **107 × `Test timed out after 30 s`** + **61 × transport `POST /build` wedge** + **6 × transport `GET /clear` wedge** = 174.

### Non-Flutter projects (clean, deterministic — not load-sensitive)

| Project | Pass | Fail | Error | Skip | Verdict |
| --- | ---: | ---: | ---: | ---: | --- |
| `tom_d4rt` | 1786 | 1 | 0 | 1 | ✅ the 1 "fail" is the intentional `I-BUG-14a` *Won't-Fix (SHOULD FAIL)* test |
| `tom_d4rt_ast` | 124 | 0 | 0 | 0 | ✅ all green |
| `tom_ast_generator` | 510 | 0 | 0 | 0 | ✅ all green |
| `tom_d4rt_generator` | 660 | 0 | 0 | 0 | ✅ all green |
| `tom_d4rt_exec` | 2292 | 1 | 0 | 0 | ✅ the 1 "fail" is the same intentional `I-BUG-14a` test |
| **Combined** | **5372** | **2** | **0** | **1** | ✅ **0 genuine failures** (no suite load/compile failures) |

---

## 2. Per-file results — Flutter

### `tom_d4rt_flutter_ast` (port 14250)

| File | Pass | Err | Skip | Done? | Wall | In-flight at kill |
| --- | ---: | ---: | ---: | --- | --- | --- |
| `essential_classes_test` | 38 | 2 | 0 | ⚠️ KILLED | 300 s | `material/formcontrols_test.dart` |
| `important_classes_test` | 129 | 7 | 0 | ⚠️ KILLED | 900 s | `gestures/recognizers_test.dart` |
| `secondary_classes_test` | 505 | 28 | 1 | ⚠️ KILLED | 3000 s | `widgets/list_wheel_element_test.dart` |
| `hardly_relevant_classes_1_test` | 165 | 6 | 1 | ⚠️ KILLED | 1200 s | `gestures/least_squares_solver_test.dart` |
| `hardly_relevant_classes_2_test` | 162 | 4 | 0 | ⚠️ KILLED | 1200 s | `material/vertical_divider_test.dart` |
| `hardly_relevant_classes_3_test` | 192 | 9 | 0 | ✅ | 1160 s | — |
| `hardly_relevant_classes_4_test` | 217 | 10 | 0 | ✅ | 1160 s | — |
| `hardly_relevant_classes_5_test` | 147 | 2 | 0 | ⚠️ KILLED | 1200 s | `widgets/snapshot_widget_test.dart` |
| `crashing_tests_test` | 4 | 0 | 0 | ✅ | 20 s | — |
| `timeout_tests_test` | 49 | 2 | 0 | ✅ | 220 s | — |
| `blocking_tests_test` | 5 | 0 | 0 | ✅ | 50 s | — |
| `generator_interpreter_issues_test` | 79 | 3 | 1 | ✅ | 480 s | — |
| `generator_interpreter_retest_test` | 56 | 1 | 1 | ✅ | 330 s | — |
| `interactive_tests_test` | 6 | 0 | 0 | ✅ | 30 s | — |
| **AST totals** | **1754** | **74** | **4** | 6/14 | | |

### `tom_d4rt_flutter_test` (port 14251)

| File | Pass | Err | Skip | Done? | Wall | In-flight at kill |
| --- | ---: | ---: | ---: | --- | --- | --- |
| `essential_classes_test` | 55 | 3 | 0 | ⚠️ KILLED | 300 s | `painting/border_radius_test.dart` |
| `important_classes_test` | 146 | 10 | 0 | ⚠️ KILLED | 900 s | `rendering/sliver_delegates_test.dart` |
| `secondary_classes_test` | 496 | 31 | 1 | ⚠️ KILLED | 3000 s | `widgets/leaf_render_object_element_test.dart` |
| `hardly_relevant_classes_1_test` | 191 | 9 | 1 | ⚠️ KILLED | 1200 s | — |
| `hardly_relevant_classes_2_test` | 192 | 9 | 0 | ⚠️ KILLED | 1200 s | — |
| `hardly_relevant_classes_3_test` | 189 | 12 | 0 | ✅ | 1090 s | — |
| `hardly_relevant_classes_4_test` | 202 | 8 | 0 | ⚠️ KILLED | 1200 s | — |
| `hardly_relevant_classes_5_test` | 218 | 12 | 0 | ✅ | 1050 s | — |
| `crashing_tests_test` | 4 | 0 | 0 | ✅ | 20 s | — |
| `timeout_tests_test` | 49 | 2 | 0 | ✅ | 340 s | — |
| `blocking_tests_test` | 5 | 0 | 0 | ✅ | 60 s | — |
| `generator_interpreter_issues_test` | 79 | 3 | 1 | ✅ | 610 s | — |
| `generator_interpreter_retest_test` | 56 | 1 | 1 | ✅ | 490 s | — |
| `interactive_tests_test` | 6 | 0 | 0 | ✅ | 30 s | — |
| **TEST totals** | **1888** | **100** | **4** | 6/14 | | |

Full per-test error listings are in `_parsed_ast.txt` and `_parsed_test.txt` in this folder.

---

## 3. Error classification

| Class | Count | Cause | Genuine bug? |
| --- | ---: | --- | --- |
| `Test timed out after 30 seconds` | 107 | `/build` interpretation crossed 30 s under CPU starvation | **No** (load) — re-verify under low load |
| Transport `POST /build` `TimeoutException 25 s` | 61 | build wedged / starved before the 25 s client timeout | **Mostly no** (load) — re-verify |
| Transport `GET /clear` `TimeoutException 5 s` | 6 | clear wedged before the 5 s client timeout (§U28 family) | **Mostly no** (load) — re-verify |
| `Undefined variable` runtime errors | 2 scripts | interpreter scope/resolution bug (see §4) | **YES** — load-independent |

The two intrinsically genuine errors are the interpreter runtime bugs in §4. Everything in the first three rows must be re-confirmed against a clean re-run; the appendix (§9) lists every affected script so the clean run can be diffed against it.

**Cross-project repeat transport script (the genuine-wedge candidate):** only `dart_ui/backdrop_filter_engine_layer_test.dart` wedged on **both** AST and TEST in this sweep. All other 65 transport scripts wedged on exactly one project — the load fingerprint.

---

## 4. Framework / interpreter errors captured in the logs (user-requested "flutter output … internal problems")

The test_apps' own `frameworkErrors=` counter reported **0 on every successful build** — no `overflowed by`, no `Codec failed`, no NaN Rect/Offset, no `RenderConstraintsTransformBox overflowed`, no `check that it really is our descendant`, no `infinite size during layout` anywhere in 28 logs. The Phase-A suppression removals from the 1944 campaign are holding.

However, two **genuine interpreter runtime errors** were captured in the raw flutter stdout — they fired during scheduler/animation frame callbacks **after** the capture window closed (so they did not fail a test, but would "show a red screen" in a real app). These are load-independent and must be fixed:

| # | Script (project) | Error | Mechanism |
| --- | --- | --- | --- |
| F1 | `material/progress_indicator_test.dart` (TEST) | `Runtime Error: Undefined variable: _slowProgress` → `EXCEPTION CAUGHT BY SCHEDULER LIBRARY` (`RuntimeD4rtException` in a `SchedulerBinding._invokeFrameCallback`) | A variable (`_slowProgress`) referenced inside a scheduler/animation frame callback is **not in the interpreter's closure scope** at callback-invocation time. Stack: `visitSimpleIdentifier` → … → `InterpretedFunction.call` → `D4.callInterpreterCallback` → `SchedulerBinding._invokeFrameCallback`. Fired at `gen=44` *after* the build's `/clear`. |
| F2 | `widgets/scroll_hold_controller_test.dart` (TEST) | `Runtime Error: Undefined variable: _ScrollPhase (Original error: Undefined property '_ScrollPhase' on _FlingAndHoldSectionState.)` | A **private top-level type/enum `_ScrollPhase`** is not resolved when accessed from inside a `State` subclass (`_FlingAndHoldSectionState`). Either the private-type lookup in the interpreter fails, or the script's scoping is malformed. |

Both observed only on the **source-direct (TEST)** project this run because the AST project KILLED the host files earlier under load before reaching those scripts — they must be **re-checked on both projects** (TODO #2/#3).

### Benign / intentional log noise (no action)

- `Runtime Error: Native error during bridged method call 'decodeEnvelope' on StandardMethodCodec/JSONMethodCodec: PlatformException(CAMERA_UNAVAILABLE…/BOOT_FAIL…)` — emitted **by design** by scripts that test method-codec error envelopes: `services/method_codec_test.dart`, `retest/rendering/render_android_view_test.dart`, `retest/widgets/android_view_surface_test.dart`. These assert the codec *correctly surfaces* a `PlatformException`. Not bugs.

---

## 5. Metrics

Per-`/build` METRIC lines (`[METRIC] script=… totalMs=… frameworkErrors=… interpretEndMs=…`) are in each `*.log.txt`.

| Project | Successful builds (METRIC lines) | Mean totalMs | Max totalMs | >5 s | >10 s | >20 s | frameworkErrors>0 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| AST | 1818 | 6042 | 30211 | 598 | 374 | 118 | **0** |
| TEST | 1978 | 5662 | 30277 | 484 | 361 | 157 | **0** |

Normal mean for this corpus is ~2500–3500 ms (cf. 1944 sweep). The 1.7–2.4× inflation + the long tail crossing 30 s is the quantitative load signature.

Wall-time (driver log): AST 23:50:00 → 03:00:09 (≈ 3 h 10 m); TEST 23:50:00 → 03:04:09 (≈ 3 h 14 m). Compare 1944: AST 1 h 39 m / TEST 1 h 52 m — i.e. this run was ~1.8× slower wall-to-wall, consistent with the per-build inflation.

---

## 6. Skipped tests (8 total = 4 per Flutter project + 1 in tom_d4rt)

| Script / test | Host suite(s) | Skip reason | Rationale |
| --- | --- | --- | --- |
| `widgets/android_view_test.dart` | `secondary_classes_test` + `generator_interpreter_issues_test` (both projects) | `AndroidView only renders on Android` | Platform-only. **Intentional, no fix.** |
| `dart_ui/isolate_name_server_test.dart` | `hardly_relevant_classes_1_test` (both projects) | `IsolateNameServer is not supported by the d4rt interpreter (requires real Dart isolate infrastructure)` | Permanent interpreter limitation. **Intentional, no fix.** |
| `retest/dart_ui/system_color_palette_test.dart` | `generator_interpreter_retest_test` (both projects) | `SystemColor not supported on desktop platforms (web-only API)` | Desktop-platform skip (§U24 workaround). **Intentional, no fix.** |
| `tom_d4rt` — 1 skipped test | `tom_d4rt` suite | (interpreter-limitation skip in the dart suite) | Pre-existing, intentional. |

Same 3 Flutter rationales × 2 projects + the `android_view` double-count = 8 Flutter skips. No new skips to investigate; all are documented in the test sources as platform-only or interpreter-limitation.

---

## 7. tom_d4rt / tom_d4rt_exec single "failure" — intentional

Both `tom_d4rt` and `tom_d4rt_exec` report exactly one failing test, identical:

```
group: "Open Bugs - Won't Fix (SHOULD FAIL)"
test:  I-BUG-14a: Records with named fields. [2026-02-10 06:37] (FAIL)
  Expected: <Instance of '({int x, int y})'>
  Actual:   InterpretedRecord:<(x: 10, y: 20)>
  Which: is not an instance of '({int x, int y})'
```

This is a **documented known limitation** asserted as a deliberate `SHOULD FAIL` test (interpreted records are not native Dart record instances). **No action** — listed for completeness.

---

## 8. Numbered TODO list — fix-id `20260601-2347-issue-analysis`

> Process top-to-bottom. Tick `[x]` when done. **Steps 1 is a gate**: most of the 174 Flutter errors are host-load artifacts, so a clean re-run is required before sinking effort into individual transport/timeout scripts. Steps 2–3 (genuine interpreter bugs) and Step 8 (hardening) can proceed immediately and in parallel with Step 1.

1. [ ] **fixed** — **Re-run the full Flutter sweep on a quiescent host (GATE).** Before launching: quiesce/await the background load — `exchangenotesd`, `exchangesyncd`, Telegram, Spotlight/Time-Machine — and confirm 1-min load average < 4. Re-run `tom_d4rt_flutter_ast/tool/sweep_both_projects.sh testlog_<new-id> 14250 14251`, re-parse with `ztmp/parse_results.py`, and **diff the error set against §9**. *Done when:* a sweep completes with all 28 files within budget (no KILLED) and the surviving error set is identified. Errors that disappear are confirmed load artifacts; errors that survive feed Steps 5–6.

2. [ ] **fixed** — **Fix genuine interpreter bug F1: `Undefined variable: _slowProgress`** (`material/progress_indicator_test.dart`). Reproduce in isolation on **both** AST and TEST (`flutter test test/important_classes_test.dart` / direct script send). Add a focused repro test capturing a variable referenced inside a scheduler/animation frame callback. Root-cause the closure-scope loss at callback time; fix in the interpreter (`tom_d4rt/lib/src/interpreter_visitor.dart` ↔ `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` — mirror both per the quest sync rule) or, if it's a script scoping error, in the script. *Done when:* no `EXCEPTION CAUGHT BY SCHEDULER LIBRARY` / `_slowProgress` in the logs and the script builds with `frameworkErrors=0` on both projects.

3. [ ] **fixed** — **Fix genuine interpreter bug F2: `Undefined variable: _ScrollPhase` / `Undefined property '_ScrollPhase' on _FlingAndHoldSectionState`** (`widgets/scroll_hold_controller_test.dart`). Reproduce in isolation on both projects. Add a repro test exercising a **private top-level type/enum referenced from inside a `State` subclass**. Fix the interpreter's private-type resolution (mirror `tom_d4rt` ↔ `tom_d4rt_ast`) or the script. *Done when:* no `_ScrollPhase` runtime error and the script passes on both projects.

4. [ ] **fixed** — **Investigate the sole cross-project transport wedge `dart_ui/backdrop_filter_engine_layer_test.dart`.** It wedged on both AST and TEST, making it the most likely *genuine* §U28-family wedge rather than a load artifact. After Step 1's clean re-run, reproduce in isolation on both projects under low load; if it still wedges, fix per the §U28 verify protocol (the real culprit may be the predecessor script in its host file); if it passes clean, record it as a load artifact and close.

5. [ ] **fixed** — **Triage residual transport wedges (post clean re-run).** For every script in §9.A (66 distinct) that **still** produces a `Transport failure (POST /build | GET /clear)` in the Step-1 clean run, reproduce in isolation and fix it (§U28 protocol: verify-in-isolation, suspect the predecessor in the host file, then fix interpreter or script). Scripts that pass clean are confirmed load artifacts — no fix, just record. *Done when:* every §9.A script is either fixed or proven a load artifact.

6. [ ] **fixed** — **Triage residual 30 s-timeout tests (post clean re-run).** For every test in §9.B (≈169 distinct) that **still** exceeds 30 s under low load, read its `interpretEndMs` from the METRIC line, profile the slow path, and speed it to ≤ 10 s. Per the quest rule, >30 s is a bug — **do not** re-introduce `_slowTestTimeout`/`@Timeout` wrappers. Tests that complete < 30 s in the clean run are confirmed load artifacts — no fix. *Done when:* every §9.B test is either sped up or proven a load artifact.

7. [ ] **fixed** — **Confirm/close the intentional cases (no code change).** Verify the codec-envelope scripts (`services/method_codec_test.dart`, `retest/rendering/render_android_view_test.dart`, `retest/widgets/android_view_surface_test.dart`) still emit their `PlatformException` `decodeEnvelope` errors **by design** and pass, and that `I-BUG-14a` remains the only "failure" in `tom_d4rt`/`tom_d4rt_exec`. Document in the next sweep's analysis. *Done when:* confirmed and noted.

8. [ ] **fixed** — **Environmental hardening of the sweep driver.** Add a pre-flight load guard to `sweep_both_projects.sh`: abort (or wait) if the 1-min load average exceeds a threshold or if `exchangesyncd`/`exchangenotesd`/Spotlight are consuming significant CPU, so future sweeps cannot silently produce a load-contaminated baseline like this one. Optionally log the load average alongside each `[METRIC]` line. *Done when:* the guard is in place and documented in the script header.

---

## 9. Appendix — full affected-script lists (baseline for the Step-1 diff)

### 9.A — Transport-wedge scripts (66 distinct; both projects combined)

```
cupertino/cupertino_desktop_text_selection_controls_test.dart
cupertino/cupertino_themes_batch3_test.dart
dart_ui/backdrop_filter_engine_layer_test.dart      <-- only cross-project repeat
dart_ui/color_space_test.dart
dart_ui/shader_mask_engine_layer_test.dart
dart_ui/stroke_cap_test.dart
dart_ui/vertex_mode_test.dart
foundation/diagnostics_tree_style_test.dart
foundation/object_disposed_test.dart
foundation/timed_block_test.dart
gestures/gesture_recognizer_state_test.dart
gestures/pointer_exit_event_test.dart
material/adaptive_text_selection_toolbar_test.dart
material/calendar_delegate_test.dart
material/carousel_scroll_physics_test.dart
material/chip_variants_test.dart
material/cupertino_based_material_theme_data_test.dart
material/desktop_text_selection_toolbar_test.dart
material/dialog_advanced_test.dart
material/drawer_controller_state_test.dart
material/gregorian_calendar_delegate_test.dart
material/material_state_mixin_test.dart
material/raw_chip_test.dart
material/scaffold_fab_test.dart
material/themes_advanced_test.dart
painting/image_size_info_test.dart
physics/simulations_test.dart
rendering/flow_painting_context_test.dart
rendering/performance_overlay_option_test.dart
rendering/render_custom_single_child_layout_box_test.dart
rendering/render_sized_overflow_box_test.dart
rendering/render_sliver_types_test.dart
rendering/stack_fit_test.dart
retest/material/navigation_rail_label_type_test.dart
retest/rendering/render_android_view_test.dart
semantics/attributed_string_property_test.dart
services/class_test.dart
services/i_o_s_system_context_menu_item_data_copy_test.dart
services/mouse_cursor_session_test.dart
services/selection_changed_cause_test.dart
services/system_sound_type_test.dart
widgets/app_kit_view_test.dart
widgets/border_tween_test.dart
widgets/constrainedbox_test.dart
widgets/context_menu_button_type_test.dart
widgets/customscrollview_test.dart
widgets/defaulttextstyle_test.dart
widgets/delete_character_intent_test.dart
widgets/dialog_window_controller_mac_o_s_test.dart
widgets/dismiss_direction_test.dart
widgets/do_nothing_and_stop_propagation_intent_test.dart
widgets/draggablescrollablesheet_test.dart
widgets/extend_selection_by_character_intent_test.dart
widgets/fade_in_image_test.dart
widgets/i_o_s_system_context_menu_item_copy_test.dart
widgets/inherited_theme_test.dart
widgets/logical_key_set_test.dart
widgets/object_key_test.dart
widgets/platform_menu_delegate_test.dart
widgets/raw_menu_overlay_info_test.dart
widgets/raw_web_image_test.dart
widgets/render_object_to_widget_element_test.dart
widgets/render_object_widgets_adv_test.dart
widgets/scroll_drag_controller_test.dart
widgets/sizing_test.dart
widgets/transpose_characters_intent_test.dart
```

### 9.B — 30 s-timeout test names (distinct; both projects combined)

The leading token (`cupertino/`, `material/ batch 3`, `… individual …`, `Section 2 …`, `retest: …`) is the host-suite grouping prefix as reported by the test runner. See `_parsed_ast.txt` / `_parsed_test.txt` for which project + host file each belongs to.

```
Section 1 retest: material/navigation_rail_label_type_test.dart
Section 1 retest: rendering/render_android_view_test.dart
Section 2 rendering/box_hit_test_result_test.dart
Section 2 rendering/render_custom_single_child_layout_box_test.dart
Section 2 widgets/inherited_theme_test.dart
Section 2 widgets/render_object_element_test.dart
Section 2 widgets/traversal_direction_test.dart
cupertino/class_test.dart
cupertino/cupertino_colors_system_test.dart
cupertino/cupertino_desktop_text_selection_controls_test.dart
cupertino/cupertino_page_route_test.dart
cupertino/cupertino_themes_batch3_test.dart
cupertino/datepicker_modes_test.dart
cupertino/cupertino_picker_default_selection_overlay_test.dart
cupertino/list_test.dart
cupertino/picker_test.dart
dart_ui/backdrop_filter_engine_layer_test.dart
dart_ui/color_space_test.dart
dart_ui/immutable_buffer_test.dart
dart_ui/spell_out_string_attribute_test.dart
dart_ui/string_attribute_test.dart
dart_ui/ztmp_path_metrics_access_test.dart
dart_ui/opacity_engine_layer_test.dart
dart_ui/shader_mask_engine_layer_test.dart
dart_ui/stroke_cap_test.dart
dart_ui/text_test.dart
dart_ui/vertex_mode_test.dart
foundation/diagnostics_tree_style_test.dart
foundation/timed_block_test.dart
foundation/int_property_test.dart
foundation/object_disposed_test.dart
gestures/gesture_callbacks_test.dart
gestures/gesture_recognizer_state_test.dart
gestures/i_o_s_scroll_view_fling_velocity_tracker_test.dart
gestures/long_press_down_details_test.dart
gestures/serial_tap_down_details_test.dart
gestures/pointer_exit_event_test.dart
material/dropdownform_test.dart
material/menu_themes_test.dart
material/navigation_themes_test.dart
material/rawscrollbar_test.dart
material/carousel_scroll_physics_test.dart
material/chip_variants_test.dart
material/cupertino_based_material_theme_data_test.dart
material/dialog_advanced_test.dart
material/drawer_controller_state_test.dart
material/dynamic_scheme_variant_test.dart
material/fab_location_types_test.dart
material/floatingactionbutton_test.dart
material/gregorian_calendar_delegate_test.dart
material/icon_test.dart
material/icons_test.dart
material/adaptive_text_selection_toolbar_test.dart
material/calendar_delegate_test.dart
material/desktop_text_selection_toolbar_test.dart
material/input_decoration_theme_test.dart
material/range_slider_track_shape_test.dart
material/round_slider_overlay_shape_test.dart
material/slider_tick_mark_shape_test.dart
material/tab_bar_indicator_size_test.dart
material/typography_test.dart
material/material_state_mixin_test.dart
material/menu_button_theme_data_test.dart
material/raw_chip_test.dart
material/scaffold_fab_test.dart
material/scaffold_prelayout_geometry_test.dart
material/theme_data_tween_test.dart
material/themes_advanced_test.dart
material/tooltip_state_test.dart
painting/image_size_info_test.dart
painting/image_chunk_event_test.dart
painting/linear_border_test.dart
painting/matrix_test.dart
physics/clamped_simulation_test.dart
physics/simulations_test.dart
physics/springdescription_test.dart
rendering/flow_painting_context_test.dart
rendering/container_box_parent_data_test.dart
rendering/list_body_parent_data_test.dart
rendering/render_absorb_pointer_test.dart
rendering/render_box_container_defaults_mixin_test.dart
rendering/render_custom_paint_test.dart
rendering/render_list_wheel_viewport_test.dart
rendering/render_merge_semantics_test.dart
rendering/render_sized_overflow_box_test.dart
rendering/render_sliver_fill_remaining_test.dart
rendering/renderer_binding_test.dart
rendering/rendering_flutter_binding_test.dart
rendering/table_cell_parent_data_test.dart
rendering/performance_overlay_option_test.dart
rendering/placeholder_span_index_semantics_tag_test.dart
rendering/render_clip_r_superellipse_test.dart
rendering/render_custom_multi_child_layout_box_test.dart
rendering/render_pointer_listener_test.dart
rendering/render_sliver_box_child_manager_test.dart
rendering/render_sliver_constrained_cross_axis_test.dart
rendering/render_sliver_types_test.dart
rendering/select_all_selection_event_test.dart
rendering/select_word_selection_event_test.dart
rendering/stack_fit_test.dart
semantics/attributed_string_property_test.dart
semantics/class_test.dart
semantics/semantics_data_test.dart
services/class_test.dart
services/i_o_s_system_context_menu_item_data_copy_test.dart
services/i_o_s_system_context_menu_item_data_test.dart
services/autofill_scope_test.dart
services/browser_context_menu_test.dart
services/process_text_service_test.dart
services/scribe_test.dart
services/key_message_test.dart
services/keyboard_test.dart
services/method_codec_test.dart
services/mouse_cursor_session_test.dart
services/raw_key_event_data_web_test.dart
services/retest: method_codec_test.dart
services/selection_changed_cause_test.dart
services/services_advanced_test.dart
services/system_sound_type_test.dart
services/text_editing_delta_non_text_update_test.dart
widgets/app_kit_view_test.dart
widgets/keepalive_test.dart
widgets/router_test.dart
widgets/border_tween_test.dart
widgets/box_scroll_view_test.dart
widgets/clip_r_superellipse_test.dart
widgets/constrainedbox_test.dart
widgets/context_menu_button_type_test.dart
widgets/customscrollview_test.dart
widgets/defaulttextstyle_test.dart
widgets/delete_character_intent_test.dart
widgets/dialog_window_controller_mac_o_s_test.dart
widgets/dismiss_direction_test.dart
widgets/do_nothing_and_stop_propagation_intent_test.dart
widgets/draggablescrollablesheet_test.dart
widgets/editable_text_misc_test.dart
widgets/enable_widget_inspector_scope_test.dart
widgets/extend_selection_by_character_intent_test.dart
widgets/focus_attachment_test.dart
widgets/i_o_s_system_context_menu_item_copy_test.dart
widgets/img_element_platform_view_test.dart
widgets/animated_physical_model_test.dart
widgets/build_owner_test.dart
widgets/fade_in_image_test.dart
widgets/inherited_theme_test.dart
widgets/inspector_button_test.dart
widgets/logical_key_set_test.dart
widgets/object_key_test.dart
widgets/platform_menu_delegate_test.dart
widgets/raw_menu_overlay_info_test.dart
widgets/raw_web_image_test.dart
widgets/render_object_to_widget_element_test.dart
widgets/render_object_widgets_adv_test.dart
widgets/request_focus_action_test.dart
widgets/restorable_num_n_test.dart
widgets/retest: context_action_test.dart
widgets/scroll_drag_controller_test.dart
widgets/scroll_metrics_test.dart
widgets/scrollable_details_test.dart
widgets/select_action_test.dart
widgets/selection_types_test.dart
widgets/shortcut_registry_entry_test.dart
widgets/sizing_test.dart
widgets/sliver_reorderable_list_state_test.dart
widgets/table_wrap_flow_test.dart
widgets/text_selection_gesture_detector_builder_delegate_test.dart
widgets/transpose_characters_intent_test.dart
widgets/unmanaged_restoration_scope_test.dart
widgets/visibility_test.dart
widgets/widget_state_outlined_border_test.dart
```

### 9.C — Genuine interpreter-bug scripts (load-independent — fix regardless of re-run)

```
material/progress_indicator_test.dart        -> F1  Undefined variable: _slowProgress (scheduler callback scope)
widgets/scroll_hold_controller_test.dart     -> F2  Undefined variable: _ScrollPhase (private type on State subclass)
```
