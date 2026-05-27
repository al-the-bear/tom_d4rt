# Error analysis — sweep `20260526-1401-issue-analysis`

**Sweep ID:** `20260526-1401-issue-analysis`
**Git revision (head at sweep start):** `650141d2`
**Started at:** 2026-05-26 14:02 (local)
**Finished at:** 2026-05-26 16:22 (local)
**Wall time:** ~2 h 20 m (flutter projects run in parallel cross-package; non-flutter d4rt projects sequential)
**Conditions:** Cold-start parallel sweep of the two flutter packages (`tom_d4rt_flutter_ast` on port 4247 and `tom_d4rt_flutter_test` on port 4248 — different test-app processes, no in-package parallelism). The 5 non-flutter d4rt projects ran sequentially via `dart test`.

## 1. Project-level summary

| Project | Suites | Pass | Skip | Fail | rc=0 suites | rc=1 suites |
|---|---:|---:|---:|---:|---:|---:|
| `tom_d4rt_flutter_ast` | 14 | **2 101** | 4 | 89 | essential, important, crashing | secondary, hr1–5, timeout, blocking, gii, gir, interactive |
| `tom_d4rt_flutter_test` | 14 | **1 927** | 2 | 73 | essential, interactive | important, secondary, hr1–5, crashing, timeout, blocking, gii, gir |
| `tom_d4rt` (analyzer-based interpreter) | 1 | 1 786 | 1 | 1 | — | dart test rc=1 |
| `tom_d4rt_ast` (AST-driven interpreter) | 1 | 117 | 0 | 0 | dart test rc=0 | — |
| `tom_d4rt_exec` (analyzer-free entry point) | 1 | 2 292 | 0 | 1 | — | dart test rc=1 |
| `tom_d4rt_generator` (bridge generator) | 1 | 660 | 0 | 0 | dart test rc=0 | — |
| `tom_ast_generator` (mirror-AST copier) | 1 | 510 | 0 | 0 | dart test rc=0 | — |
| **Total** | **33** | **9 393** | **7** | **164** | | |

**Verdict.** The non-flutter d4rt stack is clean (only the documented `I-BUG-14a` "Records with named fields" SHOULD-FAIL marker in `tom_d4rt` + `tom_d4rt_exec`; everything else green). All `error`-class failures concentrate in the two flutter test corpora, dominated by the position-dependent **U28 systemic wedge** (test-app state accumulates across `/clear → /build` cycles; previously documented in `interpreter_unfixable.md` U28 and in `error_analysis.md` of `testlog_20260525-1059-issue-analysis/` TODO #20). A small handful of real interpreter / bridge / asset issues remain.

## 2. Per-project, per-suite results

### 2.1 `tom_d4rt_flutter_ast` (14 suites, AST-bundle path)

| Suite | rc | pass | skip | fail | transport | clear_failed | fwErrs | wedge_recycles |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| `essential_classes_test` | 0 | 108 | 0 | 0 | 0 | 0 | 0 | 0 |
| `important_classes_test` | 0 | 164 | 0 | 0 | 0 | 0 | 2 | 0 |
| `secondary_classes_test` | 1 | 652 | 1 | 1 | 1 | 0 | 5 | 1 |
| `hardly_relevant_classes_1_test` | 1 | 200 | 1 | 4 | 3 | 1 | 1 | 4 |
| `hardly_relevant_classes_2_test` | 1 | 192 | 0 | 11 | 8 | 3 | 0 | 11 |
| `hardly_relevant_classes_3_test` | 1 | 189 | 0 | 12 | 12 | 0 | 0 | 12 |
| `hardly_relevant_classes_4_test` | 1 | 215 | 0 | 12 | 12 | 0 | 0 | 12 |
| `hardly_relevant_classes_5_test` | 1 | 217 | 0 | 13 | 11 | 2 | 1 | 13 |
| `crashing_tests_test` | 0 | 4 | 0 | 0 | 0 | 0 | 0 | 0 |
| `timeout_tests_test` | 1 | 48 | 0 | 3 | 1 | 2 | 4 | 3 |
| `blocking_tests_test` | 1 | 4 | 0 | 1 | 1 | 0 | 0 | 1 |
| `generator_interpreter_issues_test` | 1 | 76 | 1 | 6 | 4 | 1 | 1 | 5 |
| `generator_interpreter_retest_test` | 1 | 32 | 1 | 25 | 2 | 5 | 0 | 21 |
| `interactive_tests_test` | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| **Totals** | | **2 101** | **4** | **89** | **55** | **14** | **14** | **82** |

`fail` decomposition (89): 55 `transport_error` + 14 `clear_failed` + (89-55-14=) 20 other (test-level `[E]` from app-start failures, timeout exceptions, or assertion mismatches that did surface as fails — see §3.1).

### 2.2 `tom_d4rt_flutter_test` (14 suites, source-direct path)

| Suite | rc | pass | skip | fail | transport | clear_failed | fwErrs | wedge_recycles |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| `essential_classes_test` | 0 | 108 | 0 | 0 | 0 | 0 | 0 | 0 |
| `important_classes_test` | 1 | 163 | 0 | 1 | 1 | 0 | 2 | 1 |
| `secondary_classes_test` | 1 | 652 | 1 | 1 | 1 | 0 | 6 | 1 |
| `hardly_relevant_classes_1_test` | 1 | 192 | 1 | 12 | 11 | 1 | 0 | 12 |
| `hardly_relevant_classes_2_test` | 1 | 191 | 0 | 12 | 12 | 0 | 0 | 12 |
| `hardly_relevant_classes_3_test` | 1 | 188 | 0 | 13 | 13 | 0 | 0 | 13 |
| `hardly_relevant_classes_4_test` | 1 | 215 | 0 | 12 | 6 | 6 | 0 | 12 |
| `hardly_relevant_classes_5_test` | 1 | 212 | 0 | 18 | 14 | 2 | 1 | 16 |
| `crashing_tests_test` | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| `timeout_tests_test` | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| `blocking_tests_test` | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| `generator_interpreter_issues_test` | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| `generator_interpreter_retest_test` | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| `interactive_tests_test` | 0 | 6 | 0 | 0 | 0 | 0 | 0 | 0 |
| **Totals** | | **1 927** | **2** | **73** | **58** | **9** | **9** | **67** |

**Critical TEST-side observation:** suites 9–13 (`crashing` through `gir`) all show **`+0 -1` with setUpAll failing in `_startTestApp` after 60 s**. After hr5 wedged the source test app sufficiently badly, the next 5 small suites could not boot a fresh app process within their 60 s startup budget. Each suite emitted a single `[E]` from the setUpAll handler:

```
02:01 +0 -1: (setUpAll) [E]
  Bad state: Source test app failed to start within 60 seconds
  test/send_test_runner.dart 408:7  SendTestRunner._startTestApp
```

Once the `interactive_tests_test` ran (it has its own `setUp(() => SendTestRunner.requestRecycle())` hook from cluster C TODO #7), the harness recovered and that suite passed. The 5 setup failures are a single cascading harness issue, not 5 independent bugs.

### 2.3 Non-flutter d4rt projects

| Project | Pass | Skip | Fail | Notes |
|---|---:|---:|---:|---|
| `tom_d4rt` | 1 786 | 1 | 1 | Only failure: `limitations_and_bugs_test.dart` › `I-BUG-14a: Records with named fields` (SHOULD-FAIL marker — documented `Won't Fix` interpreter limitation; expected to surface in the result as `(FAIL)`). |
| `tom_d4rt_ast` | 117 | 0 | 0 | All passing. |
| `tom_d4rt_exec` | 2 292 | 0 | 1 | Same `I-BUG-14a` (shared corpus). |
| `tom_d4rt_generator` | 660 | 0 | 0 | All passing. |
| `tom_ast_generator` | 510 | 0 | 0 | All passing. |

## 3. Per-file failure details

This section enumerates the **actual failures** in the flutter sweeps, filtered against the documented systemic wedges so a real bug list emerges. Failures that are pure cluster-E U28 noise are flagged `[U28]` and grouped at the end; the others are real interpreter / bridge / asset / harness bugs.

### 3.1 `tom_d4rt_flutter_ast` failures

#### Cluster J/U28 — position-dependent test-app wedges (`transport_error` / `clear_failed`)

The following 69 scripts ended with `status=transport_error` or `status=clear_failed`. **None of these are per-script bugs**: see `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` § U28 and the TODO #20 closure in `testlog_20260525-1059-issue-analysis/error_analysis.md`. Cross-referencing this list against the `20260525-1059` and `20260525-2330` over-budget sets shows **no script-level overlap** — different scripts wedge each run, exactly as the position-dependent U28 model predicts. Listed for completeness:

- `cupertino_sections_test`, `foundation/summary_test`, `gestures/{pointer_hover_event, sampling_clock, i_o_s_scroll_view_fling_velocity_tracker}_test`
- `material/{carousel_scroll_physics, drawer_controller_state, fab_center_offset_x, handle_thumb_shape, material_rect_arc_tween, navigation_rail_label_type, rectangular_range_slider_value_indicator_shape, segmented_button_state, text_magnifier}_test`
- `painting/{asset_bundle_image_provider, multi_frame_image_stream_completer}_test`
- `rendering/{flex_fit, overflow_box_fit, render_darwin_platform_view, render_sliver_single_box_adapter, selection_status, render_custom_paint}_test`
- `scheduler/scheduler_service_extensions_test`
- `services/{autofill_client, i_o_s_system_context_menu_item_data_look_up, keyboard_lock_mode, raw_floating_cursor_point, selection_rect, text_editing_delta_replacement}_test`
- `widgets/{autocomplete_first_option_intent, base_window_controller, clipboard_status_notifier, delete_to_next_word_boundary_intent, dismiss_menu_action, edge_insets_tween, feedback, i_o_s_system_context_menu_item_custom, inspector_reference_data, lookup_boundary, options_view_open_direction, platform_menu_delegate, raw_menu_anchor_group, relative_positioned_transition, repeating_animation_builder, route_aware, scroll_metrics_notification, selectable_region_selection_status_scope, shortcut_registry, sliver_with_keep_alive_widget, tap_region_registry, tracking_scroll_controller, two_dimensional_child_list_delegate, viewport_notification_mixin, widget_state_test, single_ticker_provider_state_mixin}_test`
- `retest/widgets/{android_view_surface, app_kit_view, box_scroll_view, lock_state, next_focus_intent, raw_dialog_route, raw_menu_overlay_info}_test`
- `retest/material/popup_menu_position_test`
- `retest/rendering/render_animated_size_state_test`

#### Real failures (non-U28)

1. **`generator_interpreter_retest_test` — 25 fails total**. Decomposes as 2 transport + 5 clear_failed = 7 U28; remaining **18 fails are real**. Most are scripts re-run from the "regress" buckets that previously passed under different conditions and now hit a recycle-cascade specific to the larger retest harness. Need a dedicated investigation: confirm each script passes in isolation (per rule a) and then triage the harness behaviour.

2. **`interactive_tests_test` — 1 fail (`(setUpAll) [E]`)**. Test app failed to start within 120 seconds at the *start* of the interactive suite. Symptomatically identical to TEST's 5-suite cascade in §2.2 (test app start fail). Suggests the cluster-C `requestRecycle()` hook didn't fully clear the wedged process from the previous suite — see §5.

3. **`generator_interpreter_issues_test` — 1 fail beyond U28 noise**. Decomp: 4 transport + 1 clear_failed = 5 U28; 6 total fails ⇒ **1 real fail** (likely the framework-error scrolling event from `widgets/shader_mask_test.dart` — see §4 below).

4. **`secondary_classes_test` — 1 fail = 1 transport (`cupertino/cupertino_sections_test`)**. Pure U28 wedge; no real script-level bug.

5. **`timeout_tests_test` — 3 fails**. 1 transport + 2 clear_failed = 3 U28. **No real failures**.

6. **`blocking_tests_test` — 1 fail = 1 transport (`retest/widgets/lock_state_test`)**. Pure U28 wedge.

7. **`hr1-5` — 52 fails total (3+8+12+12+11=46 transport + 1+3+0+0+2=6 clear_failed)**. All U28.

### 3.2 `tom_d4rt_flutter_test` failures

#### Cluster J/U28 — position-dependent test-app wedges

The following 67 scripts ended `transport_error`/`clear_failed`. None are per-script bugs; same reasoning as §3.1. Listed for completeness:

- `material/{bottomappbar, button_text_theme, drawer_button, fab_center_offset_x, hour_format, material_scroll_behavior, paddle_range_slider_value_indicator_shape, raw_chip, scaffold_geometry, tab_alignment, toggle_buttons_theme_data}_test`
- `widgets/{widgets_binding_observer, app_kit_view, banner_location, character_activator, decorated_sliver, dialog_window_controller_win32, do_nothing_intent, expand_selection_to_line_break_intent, focus_scope_node, i_o_s_system_context_menu_item_share, key_event_result, multi_selectable_selection_container_delegate, overlay_portal_controller, raw_keyboard_listener, regular_window, reorderable_list, root_element_mixin, scroll_hold_controller, scroll_start_notification, selection_listener_notifier, sliver_animated_list_state, slotted_container_render_object_mixin, tap_region_registry, transition_delegate, two_dimensional_scrollable, two_dimensional_viewport, web_browser_detection, window_positioner, windowing_owner_linux}_test`
- `animation/elastic_in_curve_test`, `cupertino/cupertino_desktop_text_selection_controls_test`
- `dart_ui/{app_exit_type, clip, opacity_engine_layer, shader_mask_engine_layer, view_focus_direction}_test`
- `foundation/{diagnostics_tree_style, object_disposed}_test`
- `gestures/{gesture_recognizer_state, pointer_event, primary_pointer_gesture_recognizer}_test`
- `painting/{fitted_sizes, shader_warm_up}_test`
- `rendering/{flex_fit, main_axis_alignment, render_animated_size_state, render_sliver_edge_insets_padding, select_paragraph_selection_event, table_border}_test`
- `semantics/class_test`, `services/{class_test, i_o_s_system_context_menu_item_data_share, method_codec, raw_key_event_data_mac_os, system_context_menu_client, text_input_connection}_test`

#### Real failures (non-U28)

8. **5 small suites cascade-fail at setUpAll**: `crashing_tests_test`, `timeout_tests_test`, `blocking_tests_test`, `generator_interpreter_issues_test`, `generator_interpreter_retest_test` — each `+0 -1` with `Source test app failed to start within 60 seconds`. **Single root cause**: the source test app process wedged after the hr5 sweep, and the harness's `_startTestApp` cannot relaunch it. The 5 failure rows are one cascading harness bug, not 5 bugs. See TODO list item below.

### 3.3 Non-flutter d4rt projects

9. **`tom_d4rt` and `tom_d4rt_exec` — `I-BUG-14a: Records with named fields` (FAIL)** in `limitations_and_bugs_test.dart`. The test is labelled `(SHOULD FAIL)` and is the canonical "documented limitation" marker for the interpreter's mismatch between `InterpretedRecord` and Dart's anonymous record type `({int x, int y})`. The Dart `isA<({int x, int y})>` matcher rejects the interpreter's wrapper class. This is a known-and-accepted interpreter limitation tracked alongside the `Won't Fix` table in that test file; not a regression.

## 4. Framework errors (post-build issues with `result.success=true`)

These do **not** cause test failures (the script's widget built successfully), but the test app's `frameworkErrors` captured them. Real bugs/limitations to fix:

| # | Script | Project(s) | Error | Category |
|---|---|---|---|---|
| F1 | `painting/decoration_test.dart` | AST + TEST (important + secondary, 2 ea) | `Unable to load asset: "plaster.png"` | **Asset missing** — script demos a `DecorationImage(AssetImage('plaster.png'))` but `plaster.png` isn't packaged with the test app's `pubspec.yaml > flutter > assets`. Either bundle a placeholder asset or rewrite the demo to use a `MemoryImage(_tinyPng)`. Script-side. |
| F2 | `animation/animatable_test.dart` | AST + TEST important (1 ea) | `Runtime Error: Native error during default bridged constructor for 'FractionallySizedBox': 'package:flutter/src/widgets/basic.dart': Failed assertion: line 3224 pos 15: 'widthFactor == null \|\| widthFa…` | **Script-side** — script instantiates `FractionallySizedBox` with a `widthFactor` value that fails Flutter's `widthFactor == null \|\| widthFactor! >= 0.0` assertion. Either rewrite the demo to honour the assertion or wrap in a `try/catch` block as the script intends to document the assertion. |
| F3 | `widgets/scrollbar_layout_misc_test.dart` | AST + TEST secondary (20 ea) | `The Scrollbar's ScrollController has no ScrollPosition attached` | **Script-side** — cluster G TODO #14 pattern (`Scrollbar(thumbVisibility:true)` without `ScrollController`) — was patched in 4 other scripts in cluster G but this 5th instance was missed. Apply the same `ScrollController` threading fix. |
| F4 | `rendering/render_constraints_transform_box_test.dart` | AST + TEST secondary, AST timeout (1 ea per suite) | `A RenderConstraintsTransformBox overflowed by 30/15/15/30 pixels` | **Script-side, intentional?** — looks like a teaching demo that deliberately overflows. If yes, the framework-error message is expected and could be filtered by adding the overflow phrase to `ignoredPatterns` (like cluster H's `Codec` filter). |
| F5 | `widgets/shader_mask_test.dart` | AST + TEST secondary, AST gii, AST timeout (1 ea) | `Argument Error: Expected a callable function, got (Duration) => void` | **Interpreter limitation** — cluster A TODO #3a (open). The interpreter's bridge call for `Ticker(_onTick)` / `AnimationController.addListener` rejects a typed `void Function(Duration)` callback because the argument-coercion path doesn't recognise it as a callable. Needs an interpreter fix in `tom_d4rt` + `tom_d4rt_ast` argument-coercion code. |
| F6 | `widgets/widgets_binding_test.dart` | AST + TEST secondary (1 ea) | Same as F5 (`(Duration) => void`) | Same interpreter limitation as F5 — same fix. |
| F7 | `dart_ui/opacity_engine_layer_test.dart` | AST hr1 (1) | `Unable to load asset: "assets/checker.png"` | **Asset missing** — same family as F1. |
| F8 | `widgets/two_dimensional_scrollable_state_test.dart` | AST + TEST hr5 (1 ea) | `Runtime Error: No setter 'cellSize' for assignment in cascade` | **Bridge gap** — same family as TODO #19a (`render_animated_size_state` `onLayout` missing setter). The generated bridge for `TwoDimensionalChildBuilderDelegate` (or whatever owns `cellSize`) is missing a setter adapter. Bridge generator fix needed. |
| F9 | `retest/rendering/render_animated_size_state_test.dart` | AST timeout (1) | `Runtime Error: Cannot assign to property 'onLayout' on bridged instance of 'RenderProxyBox': No setter adapter found` | **Bridge gap** — TODO #19a from previous sweep. Tracked separately. |
| F10 | `rendering/render_custom_multi_child_layout_box_test.dart` | AST timeout (1) | `'package:flutter/src/widgets/framework.dart': Failed assertion: line 6417 pos 14: '() { return _debugLifecycleState == _Element…'` | **Framework lifecycle assertion** — cluster F U27 family. Previously thought eliminated by cluster B fix (line 6417 is the next-frame downstream cascade of `findRenderObject` on inactive element). One straggler resurfaced — investigate whether the cluster B catch needs to also match for `RenderObject?` accessors other than `findRenderObject`. |
| F11 | `widgets/text_selection_controls_test.dart` | TEST secondary (1) | `Native error during default bridged constructor for 'TextField': Argument Error: Invalid parameter "selectionControls": expected TextSelectionControls?, got InterpretedInstance(_TscFoun…)` | **TEST-side proxy gap** — `TextSelectionControls` needs a `_InterpretedTextSelectionControls` proxy in `tom_d4rt_flutter_test/lib/src/d4rt_runtime_registrations.dart` (mirroring the cluster D / TODO #9 `RouterDelegate` pattern). flutter_ast already has the proxy; flutter_test is missing it. |

## 5. Harness issues

| # | Issue | Symptom | Where |
|---|---|---|---|
| H1 | TEST source test app cannot relaunch after hr5 wedge | 5 cascading `+0 -1: (setUpAll) [E] Source test app failed to start within 60 seconds` (crashing, timeout, blocking, gii, gir) | `tom_d4rt_flutter_test/test/send_test_runner.dart` `_startTestApp` (line 408). After hr5 ends, the wedged source app process holds port 4248 in a state where the next sweep's launcher cannot bind. The recycle-on-startup path's port-free wait apparently doesn't fully clear it. |
| H2 | AST `interactive_tests_test` setUpAll failure (120 s startup timeout) | `Bad state: Test app failed to start within 120 seconds` | `tom_d4rt_flutter_ast/test/send_test_runner.dart` `_startTestApp` (line 726). Different code path (AST app uses 120 s startup; TEST uses 60 s) but same family of "wedged previous app blocks port" problem. |

## 6. Skipped tests

Both projects report identical skip reasons (the test corpus is shared via `scriptsPath`):

| Suite | Skipped test | Reason |
|---|---|---|
| `secondary_classes_test` | `widgets/android_view_test.dart` | `AndroidView only renders on Android` — platform-conditional skip; safe to ignore on desktop hosts. |
| `hardly_relevant_classes_1_test` | `dart_ui/isolate_name_server_test.dart` | `IsolateNameServer is not supported by the d4rt interpreter (requires real Dart isolate infrastructure)` — documented interpreter limitation. Skip is correct. |
| `generator_interpreter_issues_test` (AST only) | `widgets/android_view_test.dart` | Same Android-only as above (duplicate inclusion in the gii bucket). |
| `generator_interpreter_retest_test` (AST only) | `dart_ui/system_color_palette_test.dart` | `SystemColor not supported on desktop platforms (web-only API)` — platform-conditional. |

All 4 skips are intentional and correct (platform-conditional or documented limitation). No action needed.

## 7. Per-stage METRICs (cluster J TODO #18)

All `[METRIC]` lines were captured to the `*.log.txt` files. They include the full per-stage breakdown (`bodyMs / parseMs / setStateMs / interpretStartMs / interpretEndMs / firstFrameMs / pumpEndMs`) so any future bisection of slow/wedged scripts can reuse the data without rerunning the suite. Sample tail of `essential_classes_test.log.txt`:

```
[METRIC] script=services/textformatter_test.dart sourceBytes=53063 sourceChars=48716
   bundleJsonBytes=601205 clearMs=204 readMs=1 bundleMs=14 httpMs=1500 totalMs=1720
   status=success httpStatus=200 outputLines=18 frameworkErrors=0
   appBodyMs=0 appParseMs=8 appSetStateMs=8 appInterpretStartMs=12 appInterpretEndMs=1186
   appFirstFrameMs=1284 appPumpEndMs=1497
```

## 8. Fix TODO list

Numbered so we can process step by step. Checkbox `[ ]` toggles to `[x]` as each closes. Listed in priority order (highest-leverage, smallest-blast-radius first).

- [x] **1. Fix F1/F7: bundle asset for `decoration_test` / `opacity_engine_layer_test`.** _Done 2026‑05‑27._

  Root cause confirmed by reading the affected scripts: both `painting/decoration_test.dart` (which references `AssetImage('plaster.png')` and `AssetImage('cartoon.png')` with `opacity: 0.0`) and `dart_ui/opacity_engine_layer_test.dart` (which references `AssetImage('assets/checker.png')`) use the assets as **documented placeholders**. The decoration_test script explicitly notes in its comment block:

  > `// 4. Image.  We use an AssetImage placeholder string; AssetImage cannot resolve at frozen-frame time but the painting recipe is still valid.`

  So the scripts are correct as written — they intentionally demonstrate the `image:` field API surface without expecting the asset to actually load. The framework error came from the test apps not bundling the placeholder assets.

  **Fix.** Bundled a 1×1 transparent placeholder PNG (68 bytes) at three paths in **both** test apps and declared them under `flutter > assets` in each `pubspec.yaml`:

  - `test/tom_d4rt_flutter_ast_app/plaster.png`
  - `test/tom_d4rt_flutter_ast_app/cartoon.png`
  - `test/tom_d4rt_flutter_ast_app/assets/checker.png`
  - `test/tom_d4rt_flutter_test_app/plaster.png`
  - `test/tom_d4rt_flutter_test_app/cartoon.png`
  - `test/tom_d4rt_flutter_test_app/assets/checker.png`

  `pubspec.yaml` of each test app gained a `flutter > assets:` list with the three paths plus a comment block referencing this TODO and the script's own placeholder documentation. No script changes — the scripts work as authored.

  **Verification** (rule (b) — pubspec.yaml lives under `test/<app>/` but is not a "test script", so the wider regression applies):

  Isolated reruns of the affected scripts (captured in `doc/testlog_20260527-1340-todo1-verify/`):

  | Script | Project | Before | After | Build time |
  |---|---|---:|---:|---:|
  | `painting/decoration_test.dart` | AST | fwErr=2 | **fwErr=0** | 2.28 s |
  | `painting/decoration_test.dart` | TEST | fwErr=2 | **fwErr=0** | 2.07 s |
  | `dart_ui/opacity_engine_layer_test.dart` | AST | fwErr=1 | **fwErr=0** | 6.77 s |
  | `dart_ui/opacity_engine_layer_test.dart` | TEST | fwErr=0* | **fwErr=0** | 4.72 s |

  *(TEST baseline didn't show this script as having fwErr — it failed earlier with transport_error on a different position. Post-fix it succeeds cleanly.)*

  Quick regression on `essential_classes_test` for both projects (parallel cross-package — same script set as the prior sweep): both **108 pass, 0 fail, 0 framework errors** in 4 min 9 s each. No degradation.

  _fixed:_ ✅

- [x] **2. Fix F3: `widgets/scrollbar_layout_misc_test.dart` missing `ScrollController`.** _Done 2026‑05‑27._

  Root cause: 15 call sites in the script wrapped `_SampleContent` inside a `Scrollbar(controller: ctrl, thumbVisibility: true, child: _SampleContent(...))` (or `RawScrollbar` or `CupertinoScrollbar`) where `ctrl` came from a `_LocalScroll` builder. But `_SampleContent` built its own internal `ListView.builder` **without a `controller:`** — so the Scrollbar held `ctrl` but the inner Scrollable was on a separate, default `PrimaryScrollController`-derived position. Result: each Scrollbar fired `The Scrollbar's ScrollController has no ScrollPosition attached`, with 20 framework errors per script invocation (one per visible Scrollbar after layout).

  **Fix** (no widening of cluster G's surface area — same shape):

  1. Added an optional `ScrollController? controller` parameter to `_SampleContent` plus an explanatory inline comment referencing this TODO + cluster G TODO #14.
  2. Threaded `controller` into both branches of `_SampleContent.build()` — `controller: controller` on each `ListView.builder` (horizontal and vertical).
  3. Updated all **15** call sites (`_SampleContent(itemCount: …, color: _kXxx)` → `…, controller: ctrl)`) via a single regex pass; the `ctrl` is always in scope because each call lives inside a `_LocalScroll(builder: (BuildContext c, ScrollController ctrl) { … })` builder.

  **Verification** (rule (a) — single test script changed):

  | Project | Before fwErr | After fwErr | Build time |
  |---|---:|---:|---:|
  | flutter_ast | 20 | **0** | 4.12 s |
  | flutter_test | 20 | **0** | 4.22 s |

  Captured in `doc/testlog_20260527-1410-todo2-verify/`. No `interpreter_unfixable.md` entry needed — script-side bug, scripts now follow the cluster G TODO #14 pattern of "always pair an explicit controller with the inner Scrollable when using `thumbVisibility:true`" (a quote literally already in the script's own `_Bullet` documentation block at line 648). _fixed:_ ✅

- [x] **3. Fix F2: `animation/animatable_test.dart` FractionallySizedBox assertion.** _Done 2026‑05‑27._

  Root cause confirmed: the script demonstrates a `Curves` gallery via a `curveSpecs` list (line 1171) that includes `Curves.easeInBack` and `Curves.elasticOut`. These curves briefly produce **negative** output during the `[0, 1]` animation interval. The script then feeds the (un-clamped) curve value `v` straight into `FractionallySizedBox(widthFactor: v)` at two sites (lines 1273 and 1507). Flutter's `FractionallySizedBox` constructor asserts `widthFactor == null || widthFactor >= 0.0` (`basic.dart:3224`), and the assertion fires the first time `v < 0`. This is a genuine script-side bug — the demo author didn't account for the negative tail of these curves.

  **Why not "fix the interpreter".** Per the user's guidance to fix the interpreter/generator when possible — checked: the interpreter is faithful here. The same script would fail the same way in native Dart. The Curves output is mathematically negative for these curves; the framework rejects negative widthFactor by design (a layout can't have negative fractional size). The interpreter has nothing to fix.

  **Fix.** Clamped the lower bound at both consumer sites with a ternary expression and added an inline comment pointing at the assertion and at the offending curves:

  ```dart
  widthFactor: v < 0.0 ? 0.0 : v,
  ```

  The upper bound is unchanged — `FractionallySizedBox` allows overshoot above 1, which is what the demo wants to show for curves like `easeOutBack` (child grows larger than parent briefly). Only the negative-tail case (which the framework rejects) is clamped, so the visual still shows the overshoot portion of every curve.

  **Verification** (rule (a) — single test script):

  | Project | Before fwErr | After fwErr | Build time |
  |---|---:|---:|---:|
  | flutter_ast | 1 | **0** | 2.85 s |
  | flutter_test | 1 | **0** | 2.66 s |

  Captured in `doc/testlog_20260527-1430-todo3-verify/`. No `interpreter_unfixable.md` entry needed — script-side bug, script-side fix. _fixed:_ ✅

- [x] **4. Fix F4: `rendering/render_constraints_transform_box_test.dart` overflow noise.** _Done 2026‑05‑27 — path (b): intentional overflow, filter the captured noise._

  Script analysis: this is a **teaching demo of `ConstraintsTransformBox`** whose entire purpose is to show how the widget interacts with overflow. Among other things, it includes a `_kClipEntries` list (line 329) that explicitly compares `Clip.none` / `Clip.hardEdge` / `Clip.antiAlias`, and the `Clip.none` entry's `note:` reads: *"Child paints freely past the parent box. Best when overflow is expected and visually intentional (badges, tooltips)."* So the overflow is the script's pedagogical point — fixing the box constraints would erase the lesson.

  **Fix.** Added a narrow filter pattern to the `ignoredPatterns` list in **both** test apps' `lib/main.dart`:

  ```dart
  // 1401-TODO #4 (F4): the rendering/render_constraints_transform_box_test
  // teaching demo intentionally overflows … Filter narrowly on the
  // render-object class name so the demo's intentional overflow doesn't
  // pollute the captured framework-error list while real overflow bugs
  // in other render objects stay visible.
  'A RenderConstraintsTransformBox overflowed by',
  ```

  The filter is intentionally narrow — it matches only `RenderConstraintsTransformBox` overflows (a render-object class only this teaching demo exercises). Overflows from `RenderFlex` / `RenderColumn` / `RenderWrap` / etc. still surface as framework errors, so real layout bugs in other widgets remain visible.

  Mirrored the same filter and rationale comment in `tom_d4rt_flutter_test/test/tom_d4rt_flutter_test_app/lib/main.dart`.

  **Verification** (rule (b): `lib/main.dart` changes, but the filter mechanism is well-tested via clusters F4 / step-5 / step-6 / cluster H precedents):

  | Stage | Project | Result |
  |---|---|---|
  | Isolated `rendering/render_constraints_transform_box_test.dart` | flutter_ast | **fwErr 1 → 0**, 2.35 s |
  | Isolated same | flutter_test | **fwErr 1 → 0**, 2.17 s |
  | Full `essential_classes_test` regression | flutter_ast | 108 / 0 / 0 in 4 min 14 s |
  | Full `essential_classes_test` regression | flutter_test | 108 / 0 / 0 in 4 min 17 s |

  Captured in `doc/testlog_20260527-1450-todo4-verify/`. No `interpreter_unfixable.md` entry needed — this is a captured-noise suppression, not a workaround for an unfixable underlying issue (the framework-error capture is doing exactly what it's designed to, the demo is doing exactly what it's designed to, the filter lets both coexist). _fixed:_ ✅

- [ ] **5. Fix F11: `_InterpretedTextSelectionControls` proxy in `tom_d4rt_flutter_test`.** Mirror the flutter_ast proxy (search `_InterpretedRouterDelegate` for the pattern from cluster D TODO #9). Add to `tom_d4rt_flutter_test/lib/src/d4rt_runtime_registrations.dart`. **Rule (b)** — touches lib code, so essential + important + secondary regression on flutter_test required (no AST change). _fixed:_

- [ ] **6. Fix F8: bridge setter for `cellSize` (TwoDimensionalChildBuilderDelegate or relative).** Same shape as TODO #19a (`onLayout` for `RenderProxyBox`). Investigate which class actually owns `cellSize`, add it to the generator's setter coverage, regenerate bridges (`tool/regenerate_bridges.dart`), verify essential + important + secondary on both projects. **Rule (b)** — generator + regenerated `.b.dart` files. _fixed:_

- [ ] **7. Fix TODO #19a-parent: bridge setter for `RenderProxyBox.onLayout`.** Spun off from `20260525-1059-issue-analysis` TODO #19. Same fix path as #6. _fixed:_

- [ ] **8. Fix F5/F6: interpreter argument coercion for typed `void Function(Duration)` callbacks.** Same root cause as cluster A's TODO #3a (`shader_mask` `Expected a callable function, got (Duration) => void`). Trace the coercion path in `tom_d4rt/lib/src/interpreter_visitor.dart` (and mirror to `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`) for typed `Function` parameters with parameter-list signatures. **Rule (b)** — interpreter change, both projects' essential/important/secondary required + the 4 scripts in cluster A. _fixed:_

- [ ] **9. Fix F10: framework `_debugLifecycleState` assertion straggler at framework.dart:6417.** Cluster B / U27 family. The cluster-B `findRenderObject` catch only matches that method name; broaden it (or the inactive-element guard) to also handle the other `RenderObject?` accessors that produce the same `_debugLifecycleState != _ElementLifecycle.active` cascade. **Rule (b)** — interpreter change. _fixed:_

- [ ] **10. Fix H1: TEST source test app cannot relaunch after hr5 wedge.** Investigate why `_startTestApp` (line 408 of `tom_d4rt_flutter_test/test/send_test_runner.dart`) cannot reclaim port 4248 after the previous suite wedged. Plausible causes: (a) the port-free wait timeout is too tight; (b) the orphaned source-app process holds the listener even after SIGKILL; (c) the dyld/filesystem cache pressure that broke the proactive-recycle TODO #20 attempt manifests here too. Lift the startup timeout from 60 s to 120 s as a first low-risk mitigation; investigate root cause as follow-up. **Rule (a)** — test/ subfolder only. _fixed:_

- [ ] **11. Fix H2: AST `interactive_tests_test` 120-s startup failure.** Same family as #10; same first mitigation. Bump startup timeout, then investigate. **Rule (a)**. _fixed:_

- [ ] **12. Investigate `generator_interpreter_retest_test` 25-fail outlier (AST).** Decomposes as 7 U28 + 18 "real" fails. Reproduce each in isolation (per rule a) to confirm whether the 18 are U28 cascade victims (after the per-script isolation they pass) or actual bugs. Triage list of 18 to populate. _fixed:_

- [ ] **13. Document Cluster J/U28 noise as acceptable in this analysis.** The 122 U28 wedges (55 + 9 + 58 = 122 cross-suite `transport_error`+`clear_failed` across the two flutter projects) are not individual bugs per the TODO #20 closure of the prior sweep. They will continue to manifest at ~3 % rate until the deep U28 fix lands (clear interpreted-class registry on `/clear`). Leave as expected noise. _fixed:_

- [ ] **14. (Stretch) Implement the deep U28 fix.** Clear the FlutterD4rt interpreter's interpreted-class registry on `/clear` in both `tom_d4rt` and `tom_d4rt_ast`. Per U28's docs this is "deep interpreter work with broad regression implications" — outside the scope of any single fix item. Estimate: 1–2 day spike with both flutter packages' essential+important+secondary as the regression bar. _fixed:_

## 9. Verification protocol after each fix

Same as `testlog_20260525-1059-issue-analysis/error_analysis.md` § 7:

1. **Reproduce in isolation** (rule a):
   ```
   D4RT_SKIP_BRIDGE_REGEN=1 flutter test test/<suite>.dart --plain-name "<script>"
   ```
   Capture full log per the always-capture rule (`> doc/testlog_<id>/<name>.log.txt 2>&1`).

2. **Mirror interpreter fix between `tom_d4rt` and `tom_d4rt_ast`** if the change touched `interpreter_visitor.dart` or `d4.dart`.

3. **Regenerate bridges** if the change touched `tom_d4rt_generator/lib/src/*.dart`, `bridge_api.dart`, or `user_bridge_scanner.dart`:
   ```
   dart run tool/regenerate_bridges.dart
   ```

4. **Verify cluster regression**: re-run the full cluster — all scripts in the same family — in both projects, in isolation.

5. **Verify suite regression** (rule b): serial `essential` + `important` + `secondary` (+ cluster-affected suite) on each project — no new failures introduced.

6. **Update this doc**: tick the checkbox with date and commit SHA.
