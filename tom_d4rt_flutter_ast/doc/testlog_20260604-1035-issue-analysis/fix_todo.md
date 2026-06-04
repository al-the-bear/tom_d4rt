# Fix-it todo — run `20260604-1035-issue-analysis`

All 77 failures (15 AST + 62 source-direct) share **one** root cause: the
harness's hardcoded 25 s `POST /build` request timeout
(`_httpBuildTimeout = Duration(seconds: 25)` in `test/send_test_runner.dart`)
fires before a heavy script finishes parse + interpret + first-frame + settle
on a loaded host. There are **no** framework/overflow errors and **no**
interpreter/bridge logic failures to fix. The work is in the harness, not the
interpreter or generator.

Each item has a `fixed` checkbox; tick it only when the listed scripts pass on
a clean serial re-run (`./test/run_issue_analysis_tests.sh <new-id>`).

---

## Root-cause fix (do this first — clears the bulk)

1. [ ] **fixed** — Raise the default `_httpBuildTimeout` in **both**
   `tom_d4rt_flutter_ast/test/send_test_runner.dart` and
   `tom_d4rt_flutter/test/send_test_runner.dart` from `25 s` to a value
   comfortably under the 60 s per-test budget (e.g. **45 s**), so a busy host
   stops turning slow-but-correct builds into transport failures. Keep the
   per-script `httpBuildTimeout` override path intact. Verify `dart analyze`
   clean in both test dirs.

2. [ ] **fixed** — Add per-script `httpBuildTimeout` overrides for the genuinely
   heavy scripts that may still approach the raised ceiling under load — at
   minimum `cupertino/class_test.dart` (70 KB source) and any script whose
   `build-metric` `totalMs` in the logs is within ~20 % of the new ceiling.
   Source the candidate list from the `[build-metric] … totalMs=` lines in the
   run's `*.log.txt`.

3. [ ] **fixed** — Re-run **both** corpora serially with a fresh ID
   (AST then source-direct, never parallel — see `test/README.md`) and confirm
   transport failures drop to zero. Capture the new `metrics.txt` for the
   regression record.

---

## Per-file verification — `tom_d4rt_flutter_ast` (AST)

4. [ ] **fixed** — `important_classes_test`: `material/bottomappbar_test.dart`.
5. [ ] **fixed** — `hardly_relevant_classes_1_test`: `animation/animation_behavior_test.dart`,
   `animation/animation_eager_listener_mixin_test.dart`,
   `animation/animation_local_listeners_mixin_test.dart`,
   `animation/animation_local_status_listeners_mixin_test.dart`.
6. [ ] **fixed** — `hardly_relevant_classes_4_test`: `widgets/action_dispatcher_test.dart`,
   `widgets/animated_widget_base_state_test.dart`,
   `widgets/app_lifecycle_listener_test.dart`,
   `widgets/autocomplete_first_option_intent_test.dart`,
   `widgets/autocomplete_highlighted_option_test.dart`,
   `widgets/autocomplete_last_option_intent_test.dart`,
   `widgets/autocomplete_next_option_intent_test.dart`.
7. [ ] **fixed** — `blocking_tests_test`: `retest/widgets/default_text_editing_shortcuts_test.dart` (W2),
   `widgets/display_feature_sub_screen_test.dart`, `widgets/appbar_test.dart`.

## Per-file verification — `tom_d4rt_flutter` (source-direct)

8. [ ] **fixed** — `important_classes_test`: `services/asset_test.dart`,
   `rendering/gradient_rendering_test.dart`.
9. [ ] **fixed** — `secondary_classes_test` (28 scripts — see `error_analysis.md` §2b).
10. [ ] **fixed** — `hardly_relevant_classes_1_test`: `cupertino/class_test.dart`,
    `dart_ui/backdrop_filter_engine_layer_test.dart`,
    `dart_ui/opacity_engine_layer_test.dart`,
    `foundation/foundation_service_extensions_test.dart`,
    `gestures/gesture_recognizer_state_test.dart`,
    `gestures/pointer_signal_event_test.dart`.
11. [ ] **fixed** — `hardly_relevant_classes_2_test`: `material/carousel_view_test.dart`,
    `material/drawer_controller_test.dart`, `material/end_drawer_button_test.dart`,
    `material/grid_tile_bar_test.dart`, `material/material_banner_closed_reason_test.dart`,
    `material/navigation_drawer_theme_test.dart`, `material/navigation_indicator_test.dart`,
    `material/paddle_range_slider_value_indicator_shape_test.dart`.
12. [ ] **fixed** — `timeout_tests_test` (15 scripts — see `error_analysis.md` §2b).
13. [ ] **fixed** — `generator_interpreter_retest_test`: `retest/dart_ui/key_event_type_test.dart`.
14. [ ] **fixed** — `interactive_tests_test`: `showDialog static demo — taps rendered Cancel label`,
    `showBottomSheet static demo — taps the rendered Share ListTile`.

---

## Framework / overflow errors

15. [ ] **fixed** — *None observed.* No `RenderFlex`/overflow banners, no
    `EXCEPTION CAUGHT BY` framework banners, and `capturedFrameworkErrors=0`
    on every build in both projects. No action required; tick on the next run
    if it stays clean.

---

## Notes

- Do **not** "fix" the 4 legitimate skips (`android_view_test`,
  `isolate_name_server_test`, `system_color_palette_test`) — they are
  platform/interpreter-capability gates, not regressions. See
  `error_analysis.md` §4.
- The fix lives in the test harness (`send_test_runner.dart`), so it does not
  require the tom_d4rt ↔ tom_d4rt_ast interpreter-mirror sync.
