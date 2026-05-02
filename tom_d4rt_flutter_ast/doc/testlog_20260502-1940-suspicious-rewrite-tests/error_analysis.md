# Error Analysis — `tom_d4rt_flutter_ast` `suspicious_rewrite_tests.dart`

| Field | Value |
| -- | -- |
| Run ID | `20260502-1940-suspicious-rewrite-tests` |
| Project | `tom_ai/d4rt/tom_d4rt_flutter_ast` |
| Git revision | `1b1c1e86` (branch `main`) |
| Test file | `test/suspicious_rewrite_tests.dart` |
| Command | `flutter test test/suspicious_rewrite_tests.dart --file-reporter json:doc/testlog_20260502-1940-suspicious-rewrite-tests/suspicious_rewrite_tests.result.json` |
| Started | 2026-05-02 19:40 |
| Total wall time | 1299.4 s (21 min 39 s) — exit code 1 |
| Tests run | 117 visible (3 hidden setup hooks) |
| Passed | 70 |
| **Failed** | **47** |
| Tests with framework errors | 23 (all of which still report `success`) |

## TL;DR

47 visible failures fall into **two distinct buckets**:

1. **11 deterministic runtime errors in script/bridge code** (status=error,
   httpStatus=400 returned from the test app to the harness). These reproduce
   each run; the script raised a concrete bridge / interpreter error that needs
   a code fix in either the script, the generated bridges, or the interpreter.

2. **36 cascading 30-second `TimeoutException` failures** beginning right after
   `widgets/autofill_group_state_test.dart` (the 70th visible test). Every
   subsequent widget script never receives a HTTP response and the harness gives
   up at 30 s — no `[METRIC]` line is emitted for any of them. This is the
   classic "test app is wedged from here on" pattern: one test left the app
   process in a bad state and every following script inherits the hang. The
   total cost of the cascade is exactly 36×30 s ≈ 18 min — most of the run.

23 additional scripts log Flutter framework errors (overflow, BoxConstraints,
RenderBox-not-laid-out, native bridge errors) **without** failing — the
harness counts them under `frameworkErrors=N` in the `[METRIC]` line and
prints a `⚠️ FRAMEWORK ERROR` summary, but the test itself is still marked
passing. These are silent quality regressions worth tracking.

## Bucket 1 — deterministic script/bridge errors (11 failures)

All 11 failed before the cascade began. Each script returned `httpStatus=400`
with multiple `outputLines` of error context. The unique runtime errors are:

| # | File | Runtime error |
| -- | -- | -- |
| 1 | `cupertino/cupertino_text_selection_handle_controls_test.dart` | Native error during default bridged constructor for `CupertinoTextField`: assertion `(maxLines == null) \|\| (minLines == null) \|\| (maxLines >= minLines)` failed — script supplies `minLines > maxLines`. |
| 2 | `cupertino/textfield_test.dart` | Same `CupertinoTextField` `minLines > maxLines` assertion. |
| 3 | `foundation/target_platform_test.dart` | Native error during default bridged constructor for `Text`: `Invalid parameter "data": expected String, got Null` — script passes a `null` to `Text(...)`. |
| 4 | `material/button_bar_layout_behavior_test.dart` | `Undefined variable: ButtonBarThemeData` — `ButtonBarThemeData` was removed from public Material; the bridge no longer exposes it. |
| 5 | `material/button_bar_theme_test.dart` | `Type 'ButtonBarThemeData' not found for instantiation.` — same root cause as above. |
| 6 | `material/button_text_theme_test.dart` | `Undefined variable: ButtonBarThemeData` — same root cause. |
| 7 | `material/time_of_day_format_test.dart` | Native error during default bridged constructor for `Text`: `Invalid parameter "data": expected String, got Null`. |
| 8 | `painting/axis_test.dart` | `Value used in collection 'for-in' must be an Iterable, but got BridgedInstance<Object>` — the script iterates with `for (... in ...)` over something the bridge surfaces as a non-iterable opaque object. |
| 9 | `services/message_codec_test.dart` | Native error during bridged method call `encodeMessage` on `StandardMessageCodec`: `Invalid argument: Instance of 'BridgedInstance<Object>'` — `BridgedInstance` not unwrapped before being passed to the codec. |
| 10 | `services/method_codec_test.dart` | Native error during bridged method call `decodeEnvelope` on `StandardMethodCodec`: `PlatformException(BOOT_FAIL, ...)` — script intentionally simulates a boot failure but the script's `expect` does not tolerate the bubbling exception. |
| 11 | `services/spell_check_service_test.dart` | Native error during default bridged constructor for `SpellCheckConfiguration`: `Invalid parameter "spellCheckService": expected SpellCheckService?, got InterpretedInstance(_MockSpellCheckService)` — script's interpreted `_MockSpellCheckService` does not extend the native `SpellCheckService` shape; the bridge constructor rejects an `InterpretedInstance`. |

### Failure clusters

- **Three classes of bridge/interpreter mismatch**:
  - **(A)** `BridgedInstance<Object>` not unwrapped where a native value is
    expected — affects `services/message_codec`, `painting/axis_test`. The
    interpreter or generator should auto-unwrap `BridgedInstance<Object>` for
    iteration / native method args.
  - **(B)** `InterpretedInstance` of a Dart-script subclass not accepted in
    place of a native abstract base — affects
    `services/spell_check_service_test`. The interpreter needs to recognise
    that `_MockSpellCheckService extends SpellCheckService` (interpreted side)
    so the proxy bridge wraps it.
  - **(C)** Removed Material API: `ButtonBarThemeData` was removed from
    public Material in current Flutter (3.41.6 SDK). The audit-flagged
    `button_bar_*` and `button_text_theme` scripts are still authored against
    the old API. Either re-author against the replacement or mark these as
    skipped pending SDK migration.

- **Two `Text(null)` regressions** — `target_platform_test` and
  `time_of_day_format_test` both pass a null where the native `Text`
  constructor demands a non-null `String`. Script-side bug.

- **Two `CupertinoTextField` assertion failures** — both scripts compose
  `minLines: x, maxLines: y` with `x > y`. Script-side bug.

## Bucket 2 — 30-second timeout cascade (36 failures)

Starting at the 70th visible test (`widgets/autofill_group_state_test.dart`
*succeeded* at `03:21`), every subsequent script times out exactly 30 s after
it is dispatched, in strict alphabetical order through the `widgets/` set.
The harness records no `[METRIC]` line for any of them — meaning the test app
never replied at all. The transcript looks like:

```
03:23 +70 -11: widgets/ automatic_keep_alive_client_mixin_test.dart
03:53 +70 -12: widgets/ automatic_keep_alive_client_mixin_test.dart [E]
  TimeoutException after 0:00:30.000000
04:23 +70 -13: widgets/ back_button_listener_test.dart
04:53 +70 -14: widgets/ back_button_listener_test.dart [E]
...continues until windowing_owner_win32_test.dart at 21:23
```

The 36 timed-out scripts are:

```
automatic_keep_alive_client_mixin_test.dart      keep_alive_handle_test.dart
back_button_listener_test.dart                   navigatorstate_test.dart
backdrop_group_test.dart                         regular_window_controller_mac_o_s_test.dart
border_tween_test.dart                           regular_window_controller_test.dart
box_scroll_view_test.dart                        regular_window_test.dart
clip_r_superellipse_test.dart                    route_transition_record_test.dart
constrained_layout_builder_test.dart             scroll_increment_type_test.dart
constraints_transform_box_test.dart              selectable_region_selection_status_test.dart
context_action_test.dart                         selection_details_test.dart
default_selection_style_test.dart                snapshot_mode_test.dart
default_text_editing_shortcuts_test.dart         tooltip_window_controller_delegate_test.dart
default_text_style_transition_test.dart          unmanaged_restoration_scope_test.dart
dismiss_intent_test.dart                         web_browser_detection_test.dart
do_nothing_action_test.dart                      widget_inspector_service_extensions_test.dart
do_nothing_and_stop_propagation_intent_test.dart windowing_owner_mac_o_s_test.dart
drag_target_details_test.dart                    windowing_owner_win32_test.dart
hero_controller_scope_test.dart
i_o_s_system_context_menu_item_copy_test.dart
i_o_s_system_context_menu_item_cut_test.dart
img_element_platform_view_test.dart
```

Note that the cascade includes **all 12 deep-demo files I rewrote in Batch 11
and Batch 12** (`regular_window_test.dart`, `route_transition_record_test.dart`,
`scroll_increment_type_test.dart`, `selectable_region_selection_status_test.dart`,
`selection_details_test.dart`, `snapshot_mode_test.dart`,
`tooltip_window_controller_delegate_test.dart`,
`unmanaged_restoration_scope_test.dart`, `web_browser_detection_test.dart`,
`widget_inspector_service_extensions_test.dart`,
`windowing_owner_mac_o_s_test.dart`, `windowing_owner_win32_test.dart`) but
also the 24 unrelated tests that come before them alphabetically. So the
cascade is **not** caused by my recent rewrites alone — `autofill_group_state`
or whatever followed it left the app in a bad state.

### Suspected root cause

Three plausible candidates, in decreasing likelihood:

1. **Test app process wedged after `autofill_group_state_test.dart`.** That
   script's `frameworkErrors=0` on the green path but its source is 77 KB and
   produces a 810 KB AST bundle — a fairly big payload. If it left an isolate,
   timer, or stream subscription dangling, every subsequent
   `clearMs`-then-bundle cycle on the same app could deadlock waiting for the
   prior frame.

2. **HTTP server / port stuck.** `httpMs` for the cascade is `null` — no `[METRIC]`
   means the harness never even got to the metric line. Likely the GET/POST
   simply never completes because the app's HTTP handler is single-threaded and
   the previous request is still pending.

3. **Large bundle bottleneck.** Several Batch-11/12 deep demos exceed 90 KB of
   source and decompose to >800 KB of bundle JSON, which compounded with a
   30-s harness timeout leaves no slack. But this would only explain the
   biggest scripts, not all 36 — including `do_nothing_action_test.dart` which
   should be tiny.

The decisive test is to run a single failing widget script in isolation
(`flutter test test/suspicious_rewrite_tests.dart --plain-name 'automatic_keep_alive_client_mixin'`
or via direct harness call). If it passes alone, hypothesis 1 or 2 is the
cause; if it still times out, the demo itself is the offender.

## File-by-file framework errors (still passing)

These 23 tests pass but the in-app harness logs Flutter rendering/exception
errors that should not be silently tolerated:

| File | frameworkErrors | First error category |
| -- | -- | -- |
| `cupertino/cupertino_desktop_text_selection_controls_test.dart` | 29 | `BoxConstraints has a negative minimum height` |
| `cupertino/cupertino_focus_halo_test.dart` | 7 | Same — negative minHeight |
| `cupertino/form_test.dart` | 45 | Same + `RenderBox was not laid out: _RenderEditableCustomPaint NEEDS-LAYOUT NEEDS-PAINT` (`box.dart:2251 'hasSize'`) |
| `cupertino/inherited_cupertino_theme_test.dart` | 13 | Negative-minHeight |
| `cupertino/overlay_visibility_mode_test.dart` | 27 | Negative-minHeight |
| `material/gapped_range_slider_track_shape_test.dart` | 15 | `Null check operator used on a null value` (slider parts) |
| `material/gapped_slider_track_shape_test.dart` | 18 | `slider_parts.dart:1080 'sliderTheme.trackGap != null'` |
| `material/list_tile_title_alignment_test.dart` | 23 | `BoxConstraints forces an infinite height` |
| `material/navigation_rail_label_type_test.dart` | 4 | `RenderFlex overflowed by 4.0/44 pixels on the bottom` |
| `material/progress_indicator_test.dart` | 1 | `Progress bar value, minValue, and maxValue must be valid numbers. value: "0%", minValue: "0", maxValue: "100"` (string vs num) |
| `material/theme_extension_test.dart` | 1 | `Undefined property or method 'surfaceTint' on bridged instance of 'ThemeExtension'` (bridge gap) |
| `material/thumb_test.dart` | 2 | `SliderThemeData` thumb shape rejects `InterpretedInstance(_DiamondThumbShape/_SquareCheckerThumbShape)` (bucket-1B class shows up here too, but the `expect()` still passes) |
| `proxies/customclipper_proxy_test.dart` | 4 | `type '_NativePath' is not a subtype of type 'Rect' in type cast` |
| `proxies/custompaint_proxy_test.dart` | 1 | `Build scheduled during frame.` |
| `proxies/multichildlayout_proxy_test.dart` | 14 | `RenderCustomMultiChildLayoutBox object was given an infinite size during layout` |
| `rendering/render_editable_painter_test.dart` | 3 | Negative-minHeight |
| `rendering/render_sliver_floating_pinned_persistent_header_test.dart` | 11 | `RenderParagraph object was given an infinite size during layout` |
| `rendering/render_ui_kit_view_test.dart` | 21 | `BoxConstraints forces an infinite height` |
| `repro_fa5/canary_must_fail.dart` | 1 | `InternalInterpreterException: Bad state: fa5-canary: deliberate throw to verify harness signal` (intentional) |
| `repro_fa6/canary_must_fail.dart` | 1 | Same intentional canary |
| `services/raw_key_up_event_test.dart` | 4 | `Undefined variable: RawKeyboardListener` (deprecated since Flutter 3.18, removed) |
| `services/smart_quotes_type_test.dart` | 9 | Negative-minHeight |
| `widgets/align_transition_test.dart` | 1 | Native error during default bridged constructor for `AlignTransition`: `expected Widget, got InterpretedInstance(_Planet)` (bucket-1B shape mismatch leaking in) |

The dominant non-canary category is **`BoxConstraints has a negative minimum
height` raised from `_RenderEditableCustomPaint`** — most of the Cupertino
text-input demos hit it dozens of times because the in-app harness is sized
narrower than what the demo's `EditableText` expects. This is harness sizing
related, not a script bug per se.

The two intentional canaries (`repro_fa5/canary_must_fail.dart` and
`repro_fa6/canary_must_fail.dart`) emitting an `InternalInterpreterException`
are by design.

## Recommended next steps

1. **Investigate the timeout cascade trigger** — run
   `flutter test --plain-name 'automatic_keep_alive_client_mixin'`
   alone and confirm whether (a) it passes in isolation and the wedge is
   stateful in the test app, or (b) the script itself is the wedge. If (a),
   add a `tearDown` in the harness that recycles the test app between tests in
   the `widgets/` cluster, or split `suspicious_rewrite_tests.dart` into smaller
   sharded files.

2. **Track the 11 bucket-1 errors** in `interpreter_issues.md` as concrete
   clusters: the bridge-vs-`BridgedInstance<Object>` unwrap issue (#8, #9, #11,
   `widgets/align_transition`, `material/thumb` framework error), the
   `Text(null)` script bugs (#3, #7), the deprecated `ButtonBarThemeData`
   removal (#4-6), and the two `CupertinoTextField` `minLines>maxLines`
   script bugs (#1-2).

3. **Decide policy for the 23 silent-framework-error tests** — currently they
   pass with up to 45 errors logged. Either (i) tighten the harness so any
   `frameworkErrors > N` fails the test, or (ii) accept them as harness
   quirks and document the threshold. The negative-minHeight category and the
   intentional canaries should at minimum be classified.

## Bucket 1 progress — 2026-05-02

The sister `tom_d4rt_flutter_test` run had **12** bucket-1 entries (this
project has 11) — the 12th being `rendering/sliver_paint_order_test.dart`,
which fails on the analyzer-based interpreter but passes on the AST-based
one. That divergence was a `tom_d4rt ↔ tom_d4rt_ast` sync violation and is
now **CLOSED** in commit `3321f23d` (this project's run is unaffected since
the script already passed here).

The other 11 entries in this project remain OPEN; see the sister log
(`tom_d4rt_flutter_test/.../error_analysis.md` "Bucket 1 progress") for the
per-item triage:

- **CupertinoTextField #1, #2**: script analysis shows the scripts use
  `maxLines: null` correctly — bridge is the offender, needs generator
  investigation.
- **Text(null) #3, #7**: no syntactic `Text(null)` in either script;
  null `data` arises at runtime, needs bisection.
- **ButtonBarThemeData #4-6**: removed-API; pending placeholder vs
  OverflowBar rewrite policy.
- **method_codec BOOT_FAIL #10**: catch sites exist for
  `PlatformException`; the bubbling suggests bridged type-matching
  mismatch — same shape as #11 spell-check. Bridge / interpreter, not
  a script fix.
- **#8 axis, #9 message_codec, #11 spell_check**: bridge / interpreter
  unwrap or proxy gaps — see flutter_test sister log.
