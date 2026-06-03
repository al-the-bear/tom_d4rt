# Error Analysis — `tom_d4rt_flutter_test` `suspicious_rewrite_tests.dart`

| Field | Value |
| -- | -- |
| Run ID | `20260502-1940-suspicious-rewrite-tests` |
| Project | `tom_ai/d4rt/tom_d4rt_flutter_test` |
| Git revision | `1b1c1e86` (branch `main`) |
| Test file | `test/suspicious_rewrite_tests.dart` |
| Command | `flutter test test/suspicious_rewrite_tests.dart --file-reporter json:doc/testlog_20260502-1940-suspicious-rewrite-tests/suspicious_rewrite_tests.result.json` |
| Started | 2026-05-02 19:40 (after the flutter_ast run, serial) |
| Total wall time | 1270.4 s (21 min 10 s) — exit code 1 |
| Tests run | 117 visible (3 hidden setup hooks) |
| Passed | 69 |
| **Failed** | **48** |
| Tests with framework errors | 23 (all of which still report `success`) |

## Comparison vs `tom_d4rt_flutter_ast` (sister run)

The two projects share `suspicious_rewrite_tests.dart` byte-for-byte (modulo
the underlying interpreter — `tom_d4rt_flutter_test` runs against the
analyzer-based `tom_d4rt`, `tom_d4rt_flutter_ast` runs against the
analyzer-free `tom_d4rt_ast`). Diff between the two runs:

| Metric | flutter_ast | flutter_test | Delta |
| -- | -- | -- | -- |
| Wall time | 21:39 | 21:10 | -29 s |
| Pass | 70 | 69 | **-1** |
| Fail | 47 | 48 | **+1** |
| Bucket-1 (script/bridge errors before cascade) | 11 | **12** | +1 |
| Bucket-2 (timeout cascade after autofill_group_state) | 36 | 36 | 0 |

The single divergence is **`rendering/sliver_paint_order_test.dart`**, which
**fails on `flutter_test` but passes on `flutter_ast`**:

```
✗ BUILD ERROR in rendering/sliver_paint_order_test.dart:
  Runtime Error: Identifier 'all' resolved to List<BridgedEnumValue>,
  which is not a class type that can be instantiated.
  #0  InterpreterVisitor.visitInstanceCreationExpression
       (package:tom_d4rt/src/interpreter_visitor.dart:9210:7)
```

The script is constructing something via `Identifier.all(...)`-style call where
`all` resolves to a `List<BridgedEnumValue>` (likely a generated `*.values`-
style helper). The two interpreters disagree on whether that resolution should
succeed — the AST-driven path lets it through, the analyzer-driven path
errors. **Per the workspace `tom_d4rt ↔ tom_d4rt_ast` synchronisation rule
this divergence is itself a bug:** either both should pass (fix `tom_d4rt`'s
`visitInstanceCreationExpression` to handle the same case the AST mirror does)
or both should fail. Add to `interpreter_issues.md` as a new cluster.

## TL;DR

48 visible failures fall into **two distinct buckets**:

1. **12 deterministic runtime errors in script/bridge code** (status=error,
   httpStatus=400 returned from the test app to the harness). 11 of these are
   identical to the `flutter_ast` run; the 12th (`sliver_paint_order_test.dart`)
   only fails on this project — see comparison above.

2. **36 cascading 30-second `TimeoutException` failures** beginning right after
   `widgets/autofill_group_state_test.dart` (the 70th visible test).
   Identical to the `flutter_ast` cascade — same trigger, same set, same
   timing pattern. The total cost of the cascade is ~18 min.

## Bucket 1 — deterministic script/bridge errors (12 failures)

| # | File | Runtime error |
| -- | -- | -- |
| 1 | `cupertino/cupertino_text_selection_handle_controls_test.dart` | Native error during default bridged constructor for `CupertinoTextField`: assertion `(maxLines == null) \|\| (minLines == null) \|\| (maxLines >= minLines)` failed — script supplies `minLines > maxLines`. |
| 2 | `cupertino/textfield_test.dart` | Same `CupertinoTextField` `minLines > maxLines` assertion. |
| 3 | `foundation/target_platform_test.dart` | Native error during default bridged constructor for `Text`: `Invalid parameter "data": expected String, got Null`. |
| 4 | `material/button_bar_layout_behavior_test.dart` | `Undefined variable: ButtonBarThemeData` — removed-API. |
| 5 | `material/button_bar_theme_test.dart` | `Type 'ButtonBarThemeData' not found for instantiation.` |
| 6 | `material/button_text_theme_test.dart` | `Undefined variable: ButtonBarThemeData`. |
| 7 | `material/time_of_day_format_test.dart` | Native error during default bridged constructor for `Text`: `Invalid parameter "data": expected String, got Null`. |
| 8 | `painting/axis_test.dart` | `Value used in collection 'for-in' must be an Iterable, but got BridgedInstance<Object>`. |
| 9 | **`rendering/sliver_paint_order_test.dart`** | `Identifier 'all' resolved to List<BridgedEnumValue>, which is not a class type that can be instantiated.` (**flutter_test only — divergence vs flutter_ast**) |
| 10 | `services/message_codec_test.dart` | Native error during bridged method call `encodeMessage` on `StandardMessageCodec`: `Invalid argument: Instance of 'BridgedInstance<Object>'`. |
| 11 | `services/method_codec_test.dart` | Native error during bridged method call `decodeEnvelope` on `StandardMethodCodec`: `PlatformException(BOOT_FAIL, ...)`. |
| 12 | `services/spell_check_service_test.dart` | Native error during default bridged constructor for `SpellCheckConfiguration`: `Invalid parameter "spellCheckService": expected SpellCheckService?, got InterpretedInstance(_MockSpellCheckService)`. |

### Failure clusters (same as flutter_ast plus #9)

- **(A) `BridgedInstance<Object>` not unwrapped where a native value is
  expected** — `services/message_codec`, `painting/axis_test`,
  and the `widgets/align_transition` framework error below.
- **(B) `InterpretedInstance` of a Dart-script subclass not accepted in place
  of a native abstract base** — `services/spell_check_service_test`,
  `material/thumb_test` (framework-error variant).
- **(C) Removed Material API: `ButtonBarThemeData`** — `material/button_bar_*`,
  `material/button_text_theme`. Both bridges should expose nothing for it
  (and the scripts must be re-authored against the replacement Material 3 API).
- **(D) `Text(null)` script bugs** — `target_platform_test`,
  `time_of_day_format_test`.
- **(E) `CupertinoTextField` `minLines > maxLines`** — `cupertino_text_selection_handle_controls_test`,
  `textfield_test`. Script-side bugs.
- **(F) Enum-values resolution divergence (flutter_test only)** —
  `sliver_paint_order_test` constructs `Identifier(all: ...)` where the
  analyzer-based interpreter resolves `all` to a `List<BridgedEnumValue>` and
  refuses to use it as a constructor target. The AST-based interpreter
  resolves the same identifier as a class. **Fix `tom_d4rt` to match
  `tom_d4rt_ast` (or the other way round, after deciding which is correct).**

## Bucket 2 — 30-second timeout cascade (36 failures)

Identical to the `flutter_ast` run: every widget test alphabetically after
`widgets/autofill_group_state_test.dart` times out at 30 s without any
`[METRIC]` line. The 36 timed-out scripts are:

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

Cascade trigger and root-cause hypotheses are the same as the flutter_ast
run (see the sister `error_analysis.md`). The fact that **both projects
exhibit the identical cascade with the identical trigger and identical set of
timed-out scripts** is strong evidence that the wedge is in the test-app
process or harness rather than in either interpreter — the bug is in
something both runs share (the `suspicious_rewrite_tests.dart` harness, the
test-app HTTP server, or `autofill_group_state_test.dart` itself).

## File-by-file framework errors (still passing)

These 23 tests pass but log Flutter rendering/exception errors that should
not be silently tolerated. The list is byte-identical to the flutter_ast run:

| File | frameworkErrors | First error category |
| -- | -- | -- |
| `cupertino/cupertino_desktop_text_selection_controls_test.dart` | 29 | `BoxConstraints has a negative minimum height` |
| `cupertino/cupertino_focus_halo_test.dart` | 7 | Negative-minHeight |
| `cupertino/form_test.dart` | 45 | Negative-minHeight + `RenderBox NEEDS-LAYOUT NEEDS-PAINT` (`box.dart:2251 'hasSize'`) |
| `cupertino/inherited_cupertino_theme_test.dart` | 13 | Negative-minHeight |
| `cupertino/overlay_visibility_mode_test.dart` | 27 | Negative-minHeight |
| `material/gapped_range_slider_track_shape_test.dart` | 15 | `Null check operator used on a null value` |
| `material/gapped_slider_track_shape_test.dart` | 18 | `slider_parts.dart:1080 'sliderTheme.trackGap != null'` |
| `material/list_tile_title_alignment_test.dart` | 23 | `BoxConstraints forces an infinite height` |
| `material/navigation_rail_label_type_test.dart` | 4 | `RenderFlex overflowed by 4.0/44 pixels on the bottom` |
| `material/progress_indicator_test.dart` | 1 | `Progress bar value, minValue, and maxValue must be valid numbers. value: "0%", minValue: "0", maxValue: "100"` |
| `material/theme_extension_test.dart` | 1 | `Undefined property or method 'surfaceTint' on bridged instance of 'ThemeExtension'` (bridge gap) |
| `material/thumb_test.dart` | 2 | `SliderThemeData` rejects `InterpretedInstance(_DiamondThumbShape/_SquareCheckerThumbShape)` (bucket-B leaking in non-fatal) |
| `proxies/customclipper_proxy_test.dart` | 4 | `type '_NativePath' is not a subtype of type 'Rect' in type cast` |
| `proxies/custompaint_proxy_test.dart` | 1 | `Build scheduled during frame.` |
| `proxies/multichildlayout_proxy_test.dart` | 14 | `RenderCustomMultiChildLayoutBox given an infinite size` |
| `rendering/render_editable_painter_test.dart` | 3 | Negative-minHeight |
| `rendering/render_sliver_floating_pinned_persistent_header_test.dart` | 11 | `RenderParagraph given an infinite size` |
| `rendering/render_ui_kit_view_test.dart` | 21 | `BoxConstraints forces an infinite height` |
| `repro_fa5/canary_must_fail.dart` | 1 | `InternalInterpreterException: Bad state: fa5-canary` (intentional) |
| `repro_fa6/canary_must_fail.dart` | 1 | Same intentional canary |
| `services/raw_key_up_event_test.dart` | 4 | `Undefined variable: RawKeyboardListener` (removed-API) |
| `services/smart_quotes_type_test.dart` | 9 | Negative-minHeight |
| `widgets/align_transition_test.dart` | 1 | Native error during default bridged constructor for `AlignTransition`: `expected Widget, got InterpretedInstance(_Planet)` |

## Recommended next steps

1. **Reconcile the `sliver_paint_order_test.dart` divergence** — fix
   `tom_d4rt/lib/src/interpreter_visitor.dart` (`visitInstanceCreationExpression`
   ~line 9210) to match `tom_d4rt_ast`'s handling of an identifier that
   resolves to `List<BridgedEnumValue>` in instance-creation context, or
   reverse the resolution if the analyzer-based reading is the spec.
   Per the cross-sync rule any interpreter fix must be mirrored — this one
   already gives us the divergence to bridge.

2. **Investigate the timeout cascade trigger** — same recommendation as
   flutter_ast: run `widgets/autofill_group_state_test.dart` plus the next
   one or two scripts in isolation to identify whether the wedge is from
   `autofill_group_state` itself or from whatever runs first in the
   alphabetical `widgets/` set after it. Because the cascade is identical
   in both projects, the fix is harness-side, not interpreter-side.

3. **Track the 11 shared bucket-1 errors** as the same clusters identified in
   the flutter_ast analysis (BridgedInstance unwrap, Interpreted/native shape
   mismatch, removed `ButtonBarThemeData`, `Text(null)` script bugs, the two
   `CupertinoTextField` script bugs).

4. **Decide policy for the 23 silent-framework-error tests** — same
   recommendation as flutter_ast. Both projects emit the same set of
   `frameworkErrors > 0` tests with the same counts, so any policy change
   should be applied to both harnesses uniformly.

## Bucket 1 progress — 2026-05-02

| # | File | Status |
| -- | -- | -- |
| 9 | `rendering/sliver_paint_order_test.dart` | **CLOSED** (commit `3321f23d`). |
| 1, 2, 3, 4-6, 7, 8, 10, 11, 12 | All others | OPEN — reasoning below. |

### #9 sliver_paint_order divergence — fix details

Restructured `tom_d4rt/lib/src/interpreter_visitor.dart`
`visitInstanceCreationExpression` to mirror `tom_d4rt_ast`'s upfront
if/elif/else resolution: when the AST shape is unresolved
(`constructorName.name == null`) and `importPrefix != null`, we now decide
whether `importPrefix` is the class name (named-ctor case, e.g.
`Border.all(...)`) **before** any `environment.get(constructorName)` lookup.
Previously the lookup ran first and a local variable named after the
constructor (`final List<SliverPaintOrder> all = SliverPaintOrder.values;`)
shadowed `Border.all`. Reproduced in isolation with a minimal class+enum
script; full `tom_d4rt` suite still at the prior baseline (+1745 ~1 -1, the
single failure being the `I-BUG-14a` Won't-Fix). Cross-sync rule satisfied:
the AST side already had the correct logic.

### Why the other 11 are still OPEN

- **#1, #2 CupertinoTextField `minLines > maxLines`**: script inspection
  shows the scripts pass `maxLines: null` correctly (e.g.
  `cupertino/textfield_test.dart:513` `maxLines: null, minLines: 4`). The
  bridge is substituting a default for the explicit `null` before the
  assertion — this is a **bridge bug**, not a script bug. Needs generator
  / D4 helper investigation.
- **#3, #7 Text(null)**: no syntactic `Text(null)` exists in either script.
  The null `data` arg arises at runtime (likely from a function returning
  String when the bridged enum case is non-exhaustive against the bridged
  enum representation). Needs runtime bisection.
- **#4-6 ButtonBarThemeData removed**: `ButtonBar`, `ButtonBarTheme`,
  `ButtonBarThemeData`, and `ButtonBarLayoutBehavior` are all removed in
  the current Flutter SDK. The three scripts are large (1346–1455 lines)
  and exercise the removed API throughout. Pending policy decision: skip
  via placeholder `build()` body, or rewrite against `OverflowBar`.
- **#10 method_codec BOOT_FAIL**: the script DOES wrap the `BOOT_FAIL`
  `decodeEnvelope` calls in `try { ... } on PlatformException catch (e)`
  (lines 1000, 1041, 1813, 1838). The bubbling exception suggests the
  bridged `PlatformException` type does not match the script's catch type
  in d4rt — same shape as the spell-check #12 case. Bridge / interpreter
  exception-type matching, not a script-side fix.
- **#8 painting/axis_test**, **#10 message_codec**, **#12 spell_check**:
  bridge / interpreter unwrap or proxy gaps as listed in clusters (A) and
  (B); require generator or interpreter changes.
