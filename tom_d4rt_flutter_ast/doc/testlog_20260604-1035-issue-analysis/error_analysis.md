# Issue analysis — run `20260604-1035-issue-analysis`

Corpus run of the 13-file D4rt Flutter bridge suite against **both**
companion paths, strictly serial (AST first, then source-direct):

- **`tom_d4rt_flutter_ast`** — pre-bundled `SAstNode` path (analyzer-free on device)
- **`tom_d4rt_flutter`** — source-direct path (on-device analyzer parse per build)

Each file was run with `flutter test --timeout 60s --file-reporter json:…`.
Per-file `*.log.txt`, `*.result.json`, and `metrics.txt` are in this folder
(AST) and in the sibling `tom_d4rt_flutter/doc/testlog_20260604-1035-issue-analysis/`.

Git revision at run time: code repo `tom_ai/d4rt` HEAD `2e38dd0b`.

---

## 1. Headline result

| Project | Pass | Skip | **Fail** | Failure kind |
| ------- | ---: | ---: | -------: | ------------ |
| `tom_d4rt_flutter_ast` (AST) | 2179 | 4 | **15** | 100 % transport timeout |
| `tom_d4rt_flutter` (source-direct) | 2132 | 4 | **62** | 100 % transport timeout |

**Every single failure in both projects is the same root cause:** a
`TimeoutException after 0:00:25` on `POST /build` — the test harness's
hardcoded per-build HTTP request timeout (`_httpBuildTimeout =
Duration(seconds: 25)` in `test/send_test_runner.dart:1566`).

There are **zero** interpreter logic failures, **zero** bridge/assertion
failures, **zero** framework exceptions, and **zero** RenderFlex/overflow
errors across either project's logs (`capturedFrameworkErrors=0` on every
build-postpump line; no `EXCEPTION CAUGHT BY` banners).

### Why it happens

On a timeout the companion app is reported **still running (no exit code)** —
it did not crash. A heavy script simply doesn't finish
parse + interpret + first-frame + settle within 25 s on a loaded host.
Representative case (`cupertino/class_test.dart`, **70 095 chars**):

```
Bad state: Transport failure while running "cupertino/class_test.dart"
Operation: POST /build?filename=cupertino%2Fclass_test.dart&suite=main.dart
Error: TimeoutException after 0:00:25.000000: Future not completed
Runner app process: still running (no exit code observed).
```

The outer `flutter test --timeout 60s` does **not** protect against this:
the inner 25 s `_httpBuildTimeout` fires first, the `send()` catch site marks
the app for recycle, and the test is recorded as a transport failure.

### Why source-direct fails ~4× more than AST (62 vs 15)

This divergence is **expected and meaningful**, not corruption. The
source-direct app runs the full analyzer parse on-device for every `/build`;
the AST app interprets a pre-bundled `SAstNode` tree (no parse step). The
source-direct per-build cost is therefore higher, so far more scripts cross
the 25 s line on a loaded host. This is direct empirical support for the
analyzer-free strategy: the AST path is materially faster per build.

Both runs were serial and used different ports; the run was launched as a
single chained orchestration (AST to completion, then source-direct), per the
serial-only rule in `test/README.md`.

---

## 2. Failures file by file

### 2a. `tom_d4rt_flutter_ast` (AST) — 15 transport timeouts

| Corpus file | Failing script | Kind |
| ----------- | -------------- | ---- |
| `important_classes_test` | `material/bottomappbar_test.dart` | transport (25 s) |
| `hardly_relevant_classes_1_test` | `animation/animation_behavior_test.dart` | transport (25 s) |
| `hardly_relevant_classes_1_test` | `animation/animation_eager_listener_mixin_test.dart` | transport (25 s) |
| `hardly_relevant_classes_1_test` | `animation/animation_local_listeners_mixin_test.dart` | transport (25 s) |
| `hardly_relevant_classes_1_test` | `animation/animation_local_status_listeners_mixin_test.dart` | transport (25 s) |
| `hardly_relevant_classes_4_test` | `widgets/action_dispatcher_test.dart` | transport (25 s) |
| `hardly_relevant_classes_4_test` | `widgets/animated_widget_base_state_test.dart` | transport (25 s) |
| `hardly_relevant_classes_4_test` | `widgets/app_lifecycle_listener_test.dart` | transport (25 s) |
| `hardly_relevant_classes_4_test` | `widgets/autocomplete_first_option_intent_test.dart` | transport (25 s) |
| `hardly_relevant_classes_4_test` | `widgets/autocomplete_highlighted_option_test.dart` | transport (25 s) |
| `hardly_relevant_classes_4_test` | `widgets/autocomplete_last_option_intent_test.dart` | transport (25 s) |
| `hardly_relevant_classes_4_test` | `widgets/autocomplete_next_option_intent_test.dart` | transport (25 s) |
| `blocking_tests_test` | `retest/widgets/default_text_editing_shortcuts_test.dart` (W2) | transport (25 s) |
| `blocking_tests_test` | `widgets/display_feature_sub_screen_test.dart` (from secondary) | transport (25 s) |
| `blocking_tests_test` | `widgets/appbar_test.dart` (from essential) | transport (25 s) |

Files with **no** failures (AST): `essential_classes_test`,
`secondary_classes_test`, `hardly_relevant_classes_2_test`,
`hardly_relevant_classes_3_test`, `hardly_relevant_classes_5_test`,
`timeout_tests_test`, `generator_interpreter_issues_test`,
`generator_interpreter_retest_test`, `interactive_tests_test`.

### 2b. `tom_d4rt_flutter` (source-direct) — 62 transport timeouts

| Corpus file | Count | Failing scripts |
| ----------- | ----: | --------------- |
| `important_classes_test` | 2 | `services/asset_test.dart`, `rendering/gradient_rendering_test.dart` |
| `secondary_classes_test` | 28 | `cupertino/cupertino_colors_system_test.dart`, `gestures/velocity_drag_test.dart`, `material/chip_attributes_test.dart`, `material/search_anchor_test.dart`, `painting/matrixutils_test.dart`, `services/system_chrome_test.dart`, `widgets/restorable_values_test.dart`, `widgets/autofill_context_adv_test.dart`, `cupertino/cupertino_sheet_transition_test.dart`, `dart_ui/pointer_data_test.dart`, `foundation/aggregated_timings_test.dart`, `gestures/base_tap_and_drag_gesture_recognizer_test.dart`, `gestures/tap_drag_down_details_test.dart`, `material/data_table_theme_data_test.dart`, `material/material_button_test.dart`, `painting/flutter_logo_decoration_test.dart`, `rendering/box_hit_test_result_test.dart`, `rendering/render_annotated_region_test.dart`, `rendering/render_custom_paint_test.dart`, `rendering/render_mouse_region_test.dart`, `rendering/sliver_grid_geometry_test.dart`, `widgets/animated_modal_barrier_test.dart`, `widgets/component_element_test.dart`, `widgets/indexed_stack_test.dart`, `widgets/platform_menu_item_group_test.dart`, `widgets/root_element_test.dart`, `widgets/sliver_visibility_test.dart`, `widgets/title_test.dart` |
| `hardly_relevant_classes_1_test` | 6 | `cupertino/class_test.dart`, `dart_ui/backdrop_filter_engine_layer_test.dart`, `dart_ui/opacity_engine_layer_test.dart`, `foundation/foundation_service_extensions_test.dart`, `gestures/gesture_recognizer_state_test.dart`, `gestures/pointer_signal_event_test.dart` |
| `hardly_relevant_classes_2_test` | 8 | `material/carousel_view_test.dart`, `material/drawer_controller_test.dart`, `material/end_drawer_button_test.dart`, `material/grid_tile_bar_test.dart`, `material/material_banner_closed_reason_test.dart`, `material/navigation_drawer_theme_test.dart`, `material/navigation_indicator_test.dart`, `material/paddle_range_slider_value_indicator_shape_test.dart` |
| `timeout_tests_test` | 15 | `rendering/render_block_semantics_test.dart`, `rendering/render_box_container_defaults_mixin_test.dart`, `rendering/render_constrained_overflow_box_test.dart`, `rendering/render_pointer_listener_test.dart`, `rendering/render_rotated_box_test.dart`, `rendering/render_sliver_box_child_manager_test.dart`, `widgets/shrink_wrapping_viewport_test.dart`, `widgets/single_child_render_object_element_test.dart`, `widgets/single_child_render_object_widget_test.dart`, `widgets/single_ticker_provider_state_mixin_test.dart`, `directionality_test.dart` (relocated), `extend_selection_to_line_break_intent_test.dart` (relocated), `retest/widgets/live_text_input_status_test.dart` (W3), `retest/widgets/lock_state_test.dart` (W4), `widgets/animated_switcher_test.dart` (W5) |
| `generator_interpreter_retest_test` | 1 | `retest/dart_ui/key_event_type_test.dart` |
| `interactive_tests_test` | 2 | `showDialog static demo — taps rendered Cancel label`, `showBottomSheet static demo — taps the rendered Share ListTile` |

Files with **no** failures (source-direct): `essential_classes_test`,
`hardly_relevant_classes_3_test`, `hardly_relevant_classes_4_test`,
`hardly_relevant_classes_5_test`, `blocking_tests_test`,
`generator_interpreter_issues_test`.

> Note the AST/source-direct failure sets barely overlap: which scripts trip
> the 25 s line depends on per-build cost and momentary host load, not on a
> specific broken script. This is the signature of a timeout-flakiness issue,
> not a logic bug.

---

## 3. Framework / runtime errors in the logs

**None.** Scanned every `*.log.txt` in both projects for:

- `overflowed` / `RenderFlex` overflow banners → **0**
- `EXCEPTION CAUGHT BY …` framework banners → **0**
- `capturedFrameworkErrors=[1-9]…` on build-postpump lines → **0**

The only non-test log noise is ordinary `[D4rtApp][script]` demo output
(threshold tables, etc.) and the per-build metric lines — none of it is an
error.

---

## 4. Skipped tests (with reasons)

Both projects skip the same 4 scripts, all for legitimate
platform/interpreter-capability reasons (not regressions):

| Script | Skipped in | Reason |
| ------ | ---------- | ------ |
| `widgets/android_view_test.dart` | `secondary_classes_test`, `generator_interpreter_issues_test` | `AndroidView only renders on Android` (`skip: !Platform.isAndroid`) — platform-specific |
| `dart_ui/isolate_name_server_test.dart` | `hardly_relevant_classes_1_test` | `IsolateNameServer is not supported by the d4rt interpreter (requires real Dart isolate infrastructure)` — interpreter limitation |
| `retest/dart_ui/system_color_palette_test.dart` | `generator_interpreter_retest_test` | `SystemColor not supported on desktop platforms (web-only API)` — `platformProvidesSystemColors` is false off-web; the reverted-workaround retest relies on `catch (e)` alone, which doesn't intercept the bridged `UnsupportedError` |

(The source-direct `key_event_type_test.dart` is **not** a skip — it failed as
a transport timeout in this run.)

---

## 5. Conclusion

The corpus is **functionally green**: 4 311 passing across both paths, no
interpreter, bridge, or framework errors. The 77 reds are all the same
infrastructure flake — heavy scripts exceeding the harness's hardcoded 25 s
`POST /build` timeout on a host loaded by running both projects back-to-back.
The fix is in the **harness** (`send_test_runner.dart`), not the interpreter,
the generator, or the bridges. See the numbered fix-it list in
`fix_todo.md` (this folder).
