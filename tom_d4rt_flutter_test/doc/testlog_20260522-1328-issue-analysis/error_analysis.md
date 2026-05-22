# Test Run Issue Analysis — 20260522-1328-issue-analysis

**Run ID:** `20260522-1328-issue-analysis`
**Date:** 2026-05-22 13:28 → 2026-05-22 15:05 (local)
**Scope:** All 14 flutter test files for both `tom_d4rt_flutter_ast` and `tom_d4rt_flutter_test`, plus full `dart test` suites for `tom_d4rt`, `tom_d4rt_ast`, `tom_d4rt_exec`, `tom_d4rt_dcli`, `tom_d4rt_generator`.
**Raw artefacts:**
- `tom_d4rt_flutter_ast/doc/testlog_20260522-1328-issue-analysis/*.{result.json,log.txt}`
- `tom_d4rt_flutter_test/doc/testlog_20260522-1328-issue-analysis/*.{result.json,log.txt}`
- `tom_d4rt{,_ast,_exec,_dcli,_generator}/doc/testlog_20260522-1328-issue-analysis/all_tests.{result.json,log.txt}`
- Aggregation tooling: `ztmp/aggregate_results.py`, `ztmp/flutter_summary.py`, `ztmp/full_dump.py`, `ztmp/extract_failures.py`, `ztmp/map_ast_errors.py`

---

## Headline numbers

### Flutter projects

| Project | passed | failed | errored | skipped | framework_errors |
|---|---:|---:|---:|---:|---:|
| **tom_d4rt_flutter_ast** | 2152 | 36 | 1 | 10 | 4 |
| **tom_d4rt_flutter_test** | 2150 | 38 | 1 | 10 | 5 |

The two projects share the same script corpus. Two extra `flutter_test` failures are project-specific (see §3.G). The +1 framework error in `flutter_test` is the `flutter_logo_style_test.dart` transport-timeout that wedges the run.

### Non-flutter projects

| Project | passed | failed | errored | skipped |
|---|---:|---:|---:|---:|
| tom_d4rt | 1749 | 1 | 7 | 1 |
| tom_d4rt_ast | 117 | 0 | 0 | 0 |
| tom_d4rt_exec | 2257 | 1 | 8 | 0 |
| tom_d4rt_dcli | 704 | 1 | 1 | 0 |
| tom_d4rt_generator | 566 | 1 | 0 | 0 |

The bridged-mixin cluster (7 entries) is shared between `tom_d4rt` and `tom_d4rt_exec` — same fixture, two execution surfaces.

---

## 1. Per-flutter-file failure breakdown (tom_d4rt_flutter_ast)

The runtime errors below were extracted from each `*.log.txt` (the JSON reporter only records the outer `expect(true, ...)` failure; SendTestRunner echoes the actual D4rt runtime error into stdout).

### 1.1 essential_classes_test (8 failed, 0 skipped, 1 framework error)

| # | script | inner error |
|---|---|---|
| 1 | `animation/tween_test.dart` | Runtime Error: Undefined variable: `build` |
| 2 | `cupertino/scaffold_test.dart` | Runtime Error: Undefined variable: `build` |
| 3 | `cupertino/theme_test.dart` | Runtime Error: Undefined variable: `build` |
| 4 | `foundation/key_test.dart` | Runtime Error: Native error during static bridged method call `Timer.run`: `RangeError (length): Invalid value: Only valid value is 0: 1` |
| 5 | `gestures/details_test.dart` | Runtime Error: Undefined variable: `build` |
| 6 | `material/materialapp_test.dart` | Runtime Error: Native error during bridged constructor `router` for class `MaterialApp`: Argument Error: Invalid parameter `routeInformationParser`: expected `RouteInformationParser<Object>?`, got `InterpretedInstance(_SimpleRouteParser)` |
| 7 | `painting/gradient_shadow_test.dart` | Runtime Error: Undefined variable: `build` |
| 8 | `painting/textstyle_test.dart` | Runtime Error: Undefined variable: `build` |

**Framework error block:** `material/buttons_test.dart` — `A RenderFlex overflowed by 34 pixels on the bottom` (test passes; flutter logs the overflow).

### 1.2 important_classes_test (2 failed, 1 errored, 0 skipped, 1 framework error)

| # | script | inner error |
|---|---|---|
| 9 | `widgets/decoratedbox_test.dart` | Runtime Error: Native error during default bridged constructor for `DecoratedBox`: Argument Error: Invalid parameter `decoration`: expected `Decoration`, got `InterpretedInstance(DiagonalStripesDecoration)` |
| 10 | `widgets/interactiveviewer_test.dart` | Bad state: Cannot resolve import `package:vector_math/vector_math_64.dart` from main.dart: Package import is not bridged and not in the same package. |
| 11 | `services/codecs_test.dart` | Runtime Error: Native error during bridged method call `decodeEnvelope` on `StandardMethodCodec`: `PlatformException(CAMERA_UNAVAILABLE, No camera matches the requested mode., {requested: front}, null)` |

**Framework error block:** sequence of `A RenderFlex overflowed by 23/23/23/39/15 pixels on the bottom` across `material/circleavatar_test.dart` through `material/togglebuttons_test.dart` (all tests pass; flutter logs the overflows).

### 1.3 secondary_classes_test (5 failed, 0 errored, 1 skipped, 1 framework error)

| # | script | inner error |
|---|---|---|
| 12 | `foundation/buffers_misc_test.dart` | Runtime Error: Bridged class `Float64List` has no instance method named `toList` (in Map literal) |
| 13 | `dart_ui/accessibility_features_test.dart` | Runtime Error: Undefined variable: `build` |
| 14 | `foundation/read_buffer_test.dart` | Runtime Error: Bridged class `Int32List` has no instance method named `toList` |
| 15 | `material/checkbox_list_tile_test.dart` | Runtime Error: Undefined variable: `build` |
| 16 | `rendering/render_exclude_semantics_test.dart` | Runtime Error: Undefined variable: `build` |

**Skipped:** `widgets/android_view_test.dart` — `AndroidView only renders on Android` (platform-gated; OK).
**Framework error block:** `cupertino/cupertino_form_scroll_test.dart` — 2.0 px right overflow (test passes).

### 1.4 hardly_relevant_classes_1_test (11 failed, 2 skipped)

| # | script | inner error |
|---|---|---|
| 17 | `dart_ui/app_lifecycle_state_test.dart` | Undefined variable: `build` |
| 18 | `dart_ui/backdrop_filter_engine_layer_test.dart` | Undefined variable: `build` |
| 19 | `dart_ui/blend_mode_test.dart` | Undefined variable: `build` |
| 20 | `dart_ui/blur_style_test.dart` | Undefined variable: `build` |
| 21 | `dart_ui/box_width_style_test.dart` | Undefined variable: `build` |
| 22 | `dart_ui/channel_buffers_test.dart` | Undefined variable: `build` |
| 23 | `dart_ui/class_test.dart` | Undefined variable: `build` |
| 24 | `foundation/text_tree_configuration_test.dart` | Runtime Error: Cannot invoke method `toStringDeep` on null. Use `?.` for null-aware method invocation. |
| 25 | `gestures/class_test.dart` | Undefined variable: `build` |
| 26 | `gestures/i_o_s_scroll_view_fling_velocity_tracker_test.dart` | Undefined variable: `build` |
| 27 | `gestures/polynomial_fit_test.dart` | Runtime Error: Bridged class `Float64List` has no instance method named `map` |

**Skipped:**
- `dart_ui/image_sampler_slot_test.dart` — `D1: destabilises the test app for subsequent dart_ui/gestures scripts on Linux. Run via bisect_test.dart instead.` (known interpreter-related instability)
- `dart_ui/isolate_name_server_test.dart` — `IsolateNameServer is not supported by the d4rt interpreter (requires real Dart isolate infrastructure)` (interpreter limitation; OK)

### 1.5 hardly_relevant_classes_2_test (3 failed, 0 skipped)

| # | script | inner error |
|---|---|---|
| 28 | `material/drawer_button_test.dart` | Undefined variable: `build` |
| 29 | `material/dynamic_scheme_variant_test.dart` | Undefined variable: `build` |
| 30 | `material/material_tap_target_size_test.dart` | Undefined variable: `build` |

### 1.6 hardly_relevant_classes_3/4/5_test — clean (0 failures, 0 skips, 0 framework errors)

### 1.7 crashing_tests_test / timeout_tests_test / blocking_tests_test — clean

### 1.8 generator_interpreter_issues_test (1 failed, 2 skipped)

| # | script | inner error |
|---|---|---|
| 31 | `services/codecs_test.dart` | Same `PlatformException(CAMERA_UNAVAILABLE, ...)` as essential — dual coverage; one root cause (#11). |

**Skipped:**
- `widgets/android_view_test.dart` — AndroidView platform-gated (OK).
- `widgets/animated_switcher_test.dart` — `W5: wedges test app /build for ~60s then "Lost connection to device"; cascades 34 subsequent gii tests` (known wedge; OK to skip).

### 1.9 generator_interpreter_retest_test (6 failed, 5 skipped)

| # | script | inner error |
|---|---|---|
| 32 | `retest/material/button_bar_layout_behavior_test.dart` | Undefined variable: `build` |
| 33 | `retest/material/button_text_theme_test.dart` | Undefined variable: `build` |
| 34 | `retest/material/dropdown_menu_close_behavior_test.dart` | Undefined variable: `build` |
| 35 | `retest/material/material_banner_closed_reason_test.dart` | Undefined variable: `build` |
| 36 | `retest/material/navigation_destination_label_behavior_test.dart` | Undefined variable: `build` |
| 37 | `retest/widgets/app_kit_view_test.dart` | Runtime Error: Native error during default bridged constructor for `AppKitView`: Argument Error: Invalid parameter `gestureRecognizers`: cannot convert to `Set<Factory<OneSequenceGestureRecognizer>>` |

**Skipped:**
- `dart_ui/system_color_palette_test.dart` — `SystemColor not supported on Linux` (platform-gated)
- `widgets/context_action_test.dart` — `W1: script passes in isolation but wedges app /clear afterward, causing cascade of timeouts` (known interpreter wedge)
- `widgets/default_text_editing_shortcuts_test.dart` — `W2: /build hangs 30s, wedges app /clear afterward` (known wedge)
- `widgets/live_text_input_status_test.dart` — `W3: cascade victim of W2` (depends on W2 fix)
- `widgets/lock_state_test.dart` — `W4: wedges test app /build with HttpException: Connection closed before full header was received` (known wedge)

### 1.10 interactive_tests_test (0 failed, 1 framework error)

Framework block: three modal/dialog interactions (`showdialog_test`, `showdatepicker_test`, `showtimepicker_test`) report `tapText` couldn't find the dismiss button. These are recorded as `InteractResult(failed, ...)` in stdout but the test itself does not fail — the harness tolerates the missed taps and verifies a fallback dismiss. Worth tracking as a soft regression.

---

## 2. Per-flutter-file failure breakdown (tom_d4rt_flutter_test) — deltas only

The runtime errors are identical to `flutter_ast` for the shared 36 scripts. Two extra failures and one extra framework error are project-specific.

### 2.A essential_classes_test — +1 failure vs. ast

| # | script | inner error |
|---|---|---|
| 38 | `foundation/notifier_test.dart` | Runtime Error: Unexpected error: type `BridgedInstance<Object>` is not a subtype of type `Color` of `newValue` — **passes in flutter_ast, fails in flutter_test**. Cross-project divergence — indicates a ValueNotifier-related bridge/coercion difference between the two test app builds. |

### 2.B hardly_relevant_classes_2_test — +1 failure & +1 framework error vs. ast

| # | script | inner error |
|---|---|---|
| 39 | `painting/flutter_logo_style_test.dart` | Bad state: Transport failure while running the script. `Operation: POST /build…`, `TimeoutException after 0:00:25.000000`. Test app process did not exit; subsequent scripts continued. **Cascade-style wedge — flutter_ast was not affected this run.** |

Framework block: same transport timeout (already counted as failure #39, but `aggregate_results.py` also surfaces it as a framework error in flutter_test only).

### 2.C secondary_classes_test — bridge symptom flips

In `flutter_test`, additional script also has `Native error during bridged method call 'decodeEnvelope' on StandardMethodCodec: PlatformException(CAMERA_UNAVAILABLE…)` symptom on `services/codecs_test.dart` (same root cause as #11/#31).

All other failures and skips match `flutter_ast` 1:1.

---

## 3. Failure clusters (root-cause grouping)

These are the **fix axes** — each numbered entry above maps to exactly one of the clusters below. All numbered todos in §5 reference these clusters.

### Cluster A — `Undefined variable: build` (24 scripts)

Scripts in batches 40–43 (hand-authored deep-demo rewrites) reference a top-level `build` identifier that the d4rt interpreter cannot resolve. The pattern is reproducibly the same Runtime Error string across every affected script. Two possible script-side errors:

1. Extracted `Widget build(BuildContext context) { ... }` helper at top level but call site uses bare `build(...)`, which d4rt resolves as a variable rather than the top-level function symbol.
2. Reference to `StatefulWidget.build` from a closure where d4rt's static-AST environment lookup fails.

Affected scripts (24):

```
animation/tween_test.dart
cupertino/scaffold_test.dart
cupertino/theme_test.dart
gestures/details_test.dart
painting/gradient_shadow_test.dart
painting/textstyle_test.dart
dart_ui/accessibility_features_test.dart
material/checkbox_list_tile_test.dart
rendering/render_exclude_semantics_test.dart
dart_ui/app_lifecycle_state_test.dart
dart_ui/backdrop_filter_engine_layer_test.dart
dart_ui/blend_mode_test.dart
dart_ui/blur_style_test.dart
dart_ui/box_width_style_test.dart
dart_ui/channel_buffers_test.dart
dart_ui/class_test.dart
gestures/class_test.dart
gestures/i_o_s_scroll_view_fling_velocity_tracker_test.dart
material/drawer_button_test.dart
material/dynamic_scheme_variant_test.dart
material/material_tap_target_size_test.dart
retest/material/button_bar_layout_behavior_test.dart
retest/material/button_text_theme_test.dart
retest/material/dropdown_menu_close_behavior_test.dart
retest/material/material_banner_closed_reason_test.dart
retest/material/navigation_destination_label_behavior_test.dart
```

**Fix strategy:** decide once whether this is (a) a uniform script-side authoring bug (then bulk-rewrite the demos), or (b) a d4rt interpreter regression on top-level function resolution from closures (then fix tom_d4rt + tom_d4rt_ast in sync). Start by reproducing one minimal script with the exact `Undefined variable: build` error in `tom_d4rt_exec` or via `bisect_test.dart`, then bisect to the line that triggers it.

### Cluster B — `InterpretedInstance` not accepted by Flutter constructor arg

3 scripts fail because a user-defined subclass of a bridged Flutter type can't be passed to a constructor expecting the bridged type:

- `material/materialapp_test.dart` — `_SimpleRouteParser` extends `RouteInformationParser` but is rejected by `MaterialApp.router(routeInformationParser:)`.
- `widgets/decoratedbox_test.dart` — `DiagonalStripesDecoration` extends `Decoration` but rejected by `DecoratedBox(decoration:)`.
- `retest/widgets/app_kit_view_test.dart` — `gestureRecognizers: Set<Factory<OneSequenceGestureRecognizer>>` collection conversion fails.

**Root cause:** the relaxer (`tom_d4rt_generator/lib/src/relaxer_generator.dart`) or the constructor coercion path doesn't unwrap an `InterpretedInstance` whose declared `extends` chain includes a bridged Flutter abstract class. Likely missing a hierarchy-walk that recognises the interpreted subclass through `D4.unwrapAs<Decoration>` / `D4.unwrapAs<RouteInformationParser>`.

### Cluster C — Missing bridge: `package:vector_math/vector_math_64.dart`

`widgets/interactiveviewer_test.dart` imports `vector_math_64`, which is not present in `tom_d4rt_flutterm`'s `bridgedLibraries`. Either:

- Add the bridge to `tom_d4rt_flutterm` (generator + buildkit.yaml), OR
- Rewrite the demo to use only the Matrix4-style helpers exported by `package:flutter/widgets.dart` (which re-exports a subset).

### Cluster D — Bridged-typed-data extension methods missing

- `foundation/buffers_misc_test.dart` — `Float64List.toList()` missing
- `foundation/read_buffer_test.dart` — `Int32List.toList()` missing
- `gestures/polynomial_fit_test.dart` — `Float64List.map()` missing

These are `Iterable<num>` extension methods that Dart's typed_data lists inherit from `List<num>`. The d4rt bridge for the typed-data variants doesn't expose them. Fix in `tom_d4rt_ast/lib/src/stdlib/typed_data.dart` (and the corresponding `tom_d4rt` mirror) by adding the inherited list methods.

### Cluster E — Bridged constructor native exceptions

- `foundation/key_test.dart` — `Timer.run` called with an arity/length mismatch in script. Likely a `List<...>` of zero/one element passed where the bridge expects an explicit callback.
- `services/codecs_test.dart` (counted twice: essential + gii) — `StandardMethodCodec.decodeEnvelope` throws `PlatformException(CAMERA_UNAVAILABLE…)`. The script appears to be feeding a real error envelope and not catching the platform exception, so this is a script-side bug (missing `try/catch`).

### Cluster F — Script-internal null deref

- `foundation/text_tree_configuration_test.dart` — `Cannot invoke method 'toStringDeep' on null`. The script reaches a code path where a `DiagnosticsNode` ancestor wasn't initialised. Pure script-side fix.

### Cluster G — flutter_test-only regressions

- `foundation/notifier_test.dart` — passes in `flutter_ast`, fails in `flutter_test` with `BridgedInstance<Object>` not `Color`. Indicates the older `flutter_test` runner sends an unwrapped `Object` where the AST runner correctly unwraps to `Color`. **Decide whether to lift `flutter_test` to the AST-runner equivalent or back-port the unwrap.**
- `painting/flutter_logo_style_test.dart` — Transport timeout in `flutter_test` (25 s POST /build). Test app didn't die but couldn't service this script. Single occurrence — re-run to confirm reproducibility before classifying as a wedge.

### Cluster H — Framework errors in passing tests (layout overflows + assertions)

The `SendTestRunner` METRIC line records `frameworkErrors=N` per script — this is the number of Flutter framework error events the runner intercepted while the script was rendering. The four blocks captured by `aggregate_results.py` in §1 only surface the **first** trigger in each test file; the full catalogue across all log files comes from the METRIC lines themselves.

**Total scripts with frameworkErrors > 0: 22** (identical list in both flutter_ast and flutter_test, with a total of ~84 individual error events). All these scripts **pass their test assertions** — the framework errors are pure flutter stdout pollution and visual layout bugs, not test failures. They still must be fixed so that future regressions don't hide behind the noise.

Two distinct error kinds:

**H1 — RenderFlex overflow (21 scripts):** Layout authoring bugs in hand-authored deep-demo scripts. Each is a per-script fix: wrap fixed-height children in `Flexible`/`Expanded`, increase parent constraints, or drop redundant rows.

| script | fw_err count | observed overflow magnitudes |
|---|---:|---|
| `painting/border_test.dart` | 34 | **not RenderFlex** — see H2 below |
| `material/dialog_test.dart` | 8 | up to 64 px bottom |
| `cupertino/cupertino_themes_batch2_test.dart` | 8 | various, mixed direction |
| `dart_ui/callback_handle_test.dart` | 6 | various |
| `material/bottomappbar_test.dart` | 5 | various bottom |
| `material/bottomnavigationbar_test.dart` | 3 | various bottom |
| `cupertino/cupertino_nav_segmented_test.dart` | 2 | various |
| `cupertino/cupertino_themes_batch3_test.dart` | 2 | various |
| `widgets/cliprrect_test.dart` | 2 | various |
| `animation/cubic_test.dart` | 1 | bottom |
| `foundation/diagnosticable_tree_mixin_test.dart` | 1 | bottom |
| `material/dropdownform_test.dart` | 1 | bottom |
| `material/dropdown_test.dart` | 1 | bottom |
| `material/mergeable_test.dart` | 1 | bottom |
| `material/progress_test.dart` | 1 | bottom |
| `rendering/debug_overflow_indicator_mixin_test.dart` | 1 | intentional? — verify (the overflow indicator demo *may* render an overflow on purpose) |
| `rendering/render_constraints_transform_box_test.dart` | 1 | bottom |
| `retest/widgets/app_kit_view_test.dart` | 1 | bottom (this script *also* fails — Cluster B; H1 is a secondary issue) |
| `scheduler/ticker_test.dart` | 1 | various |
| `services/platform_test.dart` | 1 | bottom |
| `widgets/animation_test.dart` | 1 | bottom |
| `widgets/slotted_multi_child_render_object_widget_test.dart` | 1 | bottom |

Plus the four blocks already captured in §§1.1–1.3:

- `material/buttons_test.dart` — 3× 34 px bottom (essential_classes_test block)
- `material/{circleavatar,scrollbar,segmentedbutton,selectabletext,sliverappbar,togglebuttons}_test.dart` — 23/23/23/39/15 px bottom (important_classes_test block)
- `cupertino/cupertino_form_scroll_test.dart` — 2.0 px right (secondary_classes_test block)

> Note: `material/buttons_test.dart`, the `circleavatar→togglebuttons` cluster, and `cupertino_form_scroll_test.dart` do **not** show frameworkErrors>0 in their own METRIC lines — the overflow events were emitted **between** scripts (during `WidgetsBinding` teardown of the previous test). They are still real bugs in the listed scripts and must be fixed alongside the 21 scripts above. Effective Cluster H surface: **~27 distinct scripts**.

**H2 — `painting/border_test.dart` (1 script, 34 fires):** Not an overflow. Every fire is the Flutter assertion `A borderRadius can only be given on borders with uniform colors.` — the deep-demo composes `Border` instances with non-uniform side colors and then passes them to a `BoxDecoration(border: ..., borderRadius: ...)`. Either drop the `borderRadius` for the non-uniform examples or switch them to a `BorderRadius.zero` showcase row. Single script, isolated fix.

**H2 status (item #14): FIXED.** Removed `borderRadius` from four sites in `painting/border_test.dart` where the decoration paired it with a non-uniform `Border()`/`Border.symmetric(...)`: (1) `buildNarrative` helper (line ~127), called 19× — `Border(left:)` accent; (2) `symmetricTile` helper (line ~657), shared by six section-4 grid cells with `Border.symmetric(vertical:|horizontal:)` (one axis defaults to `BorderSide.none`); (3) `boxBorderTile` `top+bottom only` cell (line ~2131) — `Border(top: teal, bottom: emerald)`; (4) `boxBorderTile` `sym vertical 5` cell (line ~2156) — `Border.symmetric(vertical:)`. Each drop is annotated with a comment explaining the assertion. The script is shared with `tom_d4rt_flutter_ast` (single source under `tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/`); the fix applies to both projects. Single-script regression run from `tom_d4rt_flutter_ast` confirms 0 borderRadius assertions remain. **Follow-up still open:** 32 `RenderFlex overflowed` events (16× 2.0 px right + 16× 14 px bottom) remain in this script — pre-existing H1 overflows that were undercounted because H2 dominated the 34-event total. Tracked here for the H1 sub-pass on `painting/border_test.dart` (separate session).

**Effect on tests:** zero. But: framework errors hide later regressions and pollute the run output; fixing them keeps the signal clean.

### Cluster I — Interactive tests soft-fail on tap-by-text

`material/showdialog_test.dart`, `showdatepicker_test.dart`, `showtimepicker_test.dart`: `Action 2 (tapText) failed: Bad state: Could not find text "Option A"/"Cancel" on screen`. Test passes (fallback dismiss path works), but interaction script can't locate the labelled button. Likely a localisation/material-3 label change since the interaction scripts were authored. Fix is to update `tapText` argument or pivot to `tapByKey`.

---

## 4. Non-flutter failures

### 4.A tom_d4rt (1 failed, 7 errored)

| # | name | error |
|---|---|---|
| 40 | I-BRIDGE-1: Can call bridged mixin methods with multiple arguments | Undefined variable: `calculate` (Original error: Undefined property `calculate` on `Calculator`.) |
| 41 | I-BRIDGE-4: Can use bridged class as mixin | Undefined variable: `mixinMethod` (Original error: Undefined property `mixinMethod` on `MyClass`.) |
| 42 | I-BRIDGE-11: Math operations with bridged mixin | Undefined variable: `calculateArea` (in Map literal) |
| 43 | I-BRIDGE-12: Complex data processing with multiple mixins | Undefined variable: `validateEmail` |
| 44 | I-BRIDGE-13: Validation mixin functionality | Undefined variable: `clearValidationErrors` |
| 45 | I-BRIDGE-14: Cache mixin functionality | Undefined variable: `setCache` |
| 46 | I-BRIDGE-15: Event mixin functionality | Error during constructor execution for class `EventManager`: Undefined variable: `addEventListener` |
| 47 | I-BUG-14a: Records with named fields (SHOULD FAIL) | `Expected: <Instance of '({int x, int y})'>` — **known pre-existing, marked SHOULD FAIL** |

**Skipped (1):** D4-WRAP-01 — *Needs BridgedInstance mock for proper testing* (test-infra; OK).

**Cluster J — Bridged-mixin resolution:** all 7 I-BRIDGE entries share root cause — bridged-class methods aren't being resolved when the bridged class is used as a `mixin` (vs. when used directly). The interpreter's method dispatch path for mixed-in bridged members is not walking the bridge's method table.

### 4.B tom_d4rt_ast — clean

117/117 tests passed. No regressions.

### 4.C tom_d4rt_exec (1 failed, 8 errored)

Same 7 I-BRIDGE failures + I-BUG-14a (records SHOULD FAIL) as tom_d4rt (shared fixture).

Plus:

| # | name | error |
|---|---|---|
| 48 | G-TST-9: UBR01 user bridge class (basic) | `ProcessException: Text file busy` on the `d4` binary |

**Cluster K — d4 binary "Text file busy":** the D4rtTester end-to-end test runs the `d4` binary; OS reports it as in-use. Likely a race against the build/test process; rebuild the binary out-of-tree or run the test serially after a stable rebuild.

### 4.D tom_d4rt_dcli (1 failed, 1 errored)

| # | name | error |
|---|---|---|
| 49 | VS Code Scripting API — `VSCodeWindow.getActiveTextEditor` returns editor info | `type 'Null' is not a subtype of type 'Map<String, dynamic>'` |
| 50 | VS Code Scripting API — Live Bridge Commands: script can get active editor through bridge | `Expected: <true>` |

**Cluster L — VS Code Scripting API:** `getActiveTextEditor` returns null in the headless test run (no VS Code instance to bridge to). Either gate these tests on a live bridge or provide a mock.

### 4.E tom_d4rt_generator (1 failed)

| # | name | error |
|---|---|---|
| 51 | `dart_overview` coverage (setUpAll) | `Expected: true` |

**Cluster M — generator regression:** isolated bridge-generator coverage setup. Re-run with `--verbose` to capture the setUpAll diagnostic that should explain what `dart_overview` is missing.

---

## 5. Numbered fix todo list

Each item references the cluster (A–M) and the failure numbers from §§1–4. Tick when verified across the four suites (gii + essential + important + secondary, plus the relevant non-flutter `dart test`) per `_copilot_guidelines/d4rt/` cluster-fix protocol.

### Cluster A — Undefined variable: `build`

- [ ] **fixed** 1. Reproduce `animation/tween_test.dart` with `SendTestRunner` in isolation (`bisect_test.dart`); capture the exact line that triggers `Undefined variable: build`. Decide: script-side authoring bug vs d4rt interpreter regression. (covers #1, #2, #3, #5, #7, #8, #13, #15, #16, #17–23, #25, #26, #28–30, #32–36 — 24 scripts)
- [ ] **fixed** 2. If script-side: bulk-rewrite the affected scripts (replace bare `build(...)` calls with the actual identifier, or move helpers inline). Mirror to flutter_test if their script-sets diverge.
- [ ] **fixed** 3. If interpreter-side: fix top-level function resolution from closures in `tom_d4rt/lib/src/interpreter_visitor.dart` AND mirror to `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`. Add a unit test in `tom_d4rt/test/` reproducing the closure capture failure.

### Cluster B — `InterpretedInstance` not accepted by Flutter constructor

- [ ] **fixed** 4. Reproduce `widgets/decoratedbox_test.dart` (DiagonalStripesDecoration) and trace the `D4.unwrapAs<Decoration>` path; confirm the missing hierarchy walk. Likely lives in `tom_d4rt_generator/lib/src/{relaxer_generator,bridge_generator}.dart`. (covers #9, #37)
- [ ] **fixed** 5. Fix generator so user-defined `class X extends Decoration` is accepted via `D4.unwrapAs<Decoration>`. Regenerate `tom_d4rt_flutterm/lib/src/bridges/*.b.dart` via `tool/regenerate_bridges.dart`.
- [ ] **fixed** 6. Apply the same fix to `RouteInformationParser` and `Set<Factory<OneSequenceGestureRecognizer>>` coercion. (covers #6, #37)

### Cluster C — Missing `vector_math_64` bridge

- [ ] **fixed** 7. Add `package:vector_math/vector_math_64.dart` to `tom_d4rt_flutterm/buildkit.yaml` and regenerate bridges. Alternatively rewrite `widgets/interactiveviewer_test.dart` to use only `Matrix4` constructors re-exported from `flutter/widgets`. (covers #10)

### Cluster D — Bridged-typed-data missing list methods

- [ ] **fixed** 8. Expose `toList()`, `map()`, and other inherited `List<num>`/`Iterable<num>` methods on `Float64List`, `Float32List`, `Int32List`, `Int64List`, `Uint8List`, `Uint16List`, `Uint32List` in the typed_data stdlib bridge. Fix in `tom_d4rt_ast/lib/src/stdlib/typed_data.dart` AND mirror to `tom_d4rt/lib/src/stdlib/typed_data.dart`. Add unit tests for each method. (covers #12, #14, #27)

### Cluster E — Bridged constructor native exceptions

- [ ] **fixed** 9. `foundation/key_test.dart` — find the `Timer.run` call site that passes an empty/single-element list; fix script-side OR detect and wrap with proper error. (covers #4)
- [ ] **fixed** 10. `services/codecs_test.dart` — wrap `StandardMethodCodec.decodeEnvelope` calls in `try/catch PlatformException` per the codec's intended contract. (covers #11, #31)

### Cluster F — Script-internal null deref

- [ ] **fixed** 11. `foundation/text_tree_configuration_test.dart` — guard the `toStringDeep` call with `?.` or ensure the diagnostics ancestor is initialised before the deep-demo renders it. (covers #24)

### Cluster G — flutter_test-only regressions

- [ ] **fixed** 12. `foundation/notifier_test.dart` — investigate the `BridgedInstance<Object>` not `Color` mismatch in `flutter_test`. Compare the test-app build of `flutter_test` vs `flutter_ast` (different runners) and either back-port the unwrap or migrate `flutter_test` to the AST runner. (covers #38)
- [ ] **fixed** 13. `painting/flutter_logo_style_test.dart` — re-run in isolation in `flutter_test` to confirm reproducibility of the 25 s transport timeout. If reproducible, classify as a wedge (Wn) and add to `interpreter_issues.md`. (covers #39)

### Cluster H — Framework errors (RenderFlex overflows + border assertions)

**H1 — high fw_err counts (fix first, biggest log-noise reduction):**

- [x] **fixed (partial — H2 cleared; H1 follow-up 32 events remains)** 14. `painting/border_test.dart` (34 events) — **H2 root cause:** "A borderRadius can only be given on borders with uniform colors." Audit the script's `Border` + `BoxDecoration(borderRadius:)` combinations; drop `borderRadius` on non-uniform-color borders or use `BorderRadius.zero` examples for that row. **Done:** Removed `borderRadius` from four sites pairing non-uniform `Border()`/`Border.symmetric(...)` with `borderRadius`: `buildNarrative` helper (19× calls), `symmetricTile` helper (6× calls in section-4 grid), `boxBorderTile` `top+bottom only` cell, and `boxBorderTile` `sym vertical 5` cell. Single-script regression: 0 borderRadius assertions remain; test still passes. **Follow-up (open):** 32 `RenderFlex overflowed` events (16× 2.0 px right + 16× 14 px bottom) — pre-existing H1 overflows that were undercounted because H2 dominated the 34-event total. Sub-folded into Cluster H1 work for this script (see Cluster H summary).
- [x] **fixed** 15. `material/dialog_test.dart` (8 events) — overflows up to 64 px bottom. **Done:** the `_buildDialogPreview` helper rendered each `_DialogPreview` inline inside a `Container(height: preview.height, padding: 12)`. For most dialogs the natural size exceeded that frame (the 8 events were 64/172/24/122 px bottom + 16/10/18/95 px right). Fix: wrap the dialog body in nested `SingleChildScrollView`s (vertical + horizontal `Axis.horizontal`) so the preview frame absorbs overflow instead of letting RenderFlex assert. `Dialog.fullscreen` contains an `Expanded` child and breaks under unbounded height — solved by adding an `isFullscreen` flag on `_DialogPreview` (default `false`) and branching: `isFullscreen → Center(child: preview.dialog)` (bounded), else the nested-scroll path. Single `_DialogPreview` updated (`'Fullscreen'` at line 605 → `isFullscreen: true`). Single-script regression (`flutter test essential_classes_test.dart --plain-name 'material/ dialog_test.dart'`) confirms `frameworkErrors=0`; the test passes. Test-script-only change, so per rule (a) no broader regression run.
- [x] **fixed** 16. `cupertino/cupertino_themes_batch2_test.dart` (8 events) — wrap theme demo rows in `Flexible`/`Wrap` or increase parent height. **Done:** the `_iosFrame` mini-phone preview (line 229) is rendered once per CupertinoThemeData (8 themes in section 5) and contains an inner `SizedBox(height: 200.0)` whose `Column` (subtitle + 3-row settings list + `Spacer()` + button row) needed ~221–236 px. Each frame overflowed by 21 or 36 px on the bottom — 8 frames × 1 overflow = 8 events. Fix: bump `SizedBox(height: 200.0) → 250.0` at line 333 with an explanatory comment. Single-script regression (`flutter test important_classes_test.dart --plain-name 'cupertino_themes_batch2'`) confirms `frameworkErrors=0`. Test-script-only change, so per rule (a) no broader regression run.
- [ ] **fixed** 17. `dart_ui/callback_handle_test.dart` (6 events) — same layout audit; demo cards need responsive sizing.
- [ ] **fixed** 18. `material/bottomappbar_test.dart` (5 events) — BottomAppBar inside fixed-height demo cards overflows; raise card height or shrink content.

**H1 — medium fw_err counts (2–3 events each):**

- [ ] **fixed** 19. `material/bottomnavigationbar_test.dart` (3 events) — layout audit.
- [ ] **fixed** 20. `cupertino/cupertino_nav_segmented_test.dart` (2 events) — layout audit.
- [ ] **fixed** 21. `cupertino/cupertino_themes_batch3_test.dart` (2 events) — layout audit.
- [ ] **fixed** 22. `widgets/cliprrect_test.dart` (2 events) — layout audit.

**H1 — single-event scripts (one bullet covers all, but verify per-script):**

- [ ] **fixed** 23. Fix one-event overflows in the remaining 12 scripts: `animation/cubic_test.dart`, `foundation/diagnosticable_tree_mixin_test.dart`, `material/dropdownform_test.dart`, `material/dropdown_test.dart`, `material/mergeable_test.dart`, `material/progress_test.dart`, `rendering/render_constraints_transform_box_test.dart`, `retest/widgets/app_kit_view_test.dart` (also fixed by Cluster B item 4), `scheduler/ticker_test.dart`, `services/platform_test.dart`, `widgets/animation_test.dart`, `widgets/slotted_multi_child_render_object_widget_test.dart`. Per-script `Flexible`/`Expanded`/`SizedBox` adjustments.
- [ ] **fixed** 24. `rendering/debug_overflow_indicator_mixin_test.dart` (1 event) — **verify whether the overflow is intentional** (the demo's whole purpose is to render an `OverflowIndicator`). If intentional, suppress via `FlutterError.onError` for that one paint pass; if accidental, fix layout.

**H1 — overflows recorded between scripts (in adjacent-script captures, not METRIC):**

- [ ] **fixed** 25. `material/buttons_test.dart` (34 px bottom × 3) — overflow surfaced in essential_classes_test block; fix the demo's Wrap/Row that exceeds 600 px.
- [ ] **fixed** 26. `material/{circleavatar,scrollbar,segmentedbutton,selectabletext,sliverappbar,togglebuttons}_test.dart` (23/23/23/39/15 px bottom) — important_classes_test block; one or more of these six scripts is leaving a teardown overflow. Bisect by running them individually.
- [ ] **fixed** 27. `cupertino/cupertino_form_scroll_test.dart` (2.0 px right) — secondary_classes_test block; nudge horizontal padding by 2 px or wrap right child in `Flexible`.

### Cluster I — Interactive tap-by-text mismatches

- [ ] **fixed** 28. Update `interactive_tests_test.dart` script entries for `showdialog_test.dart`, `showdatepicker_test.dart`, `showtimepicker_test.dart` — replace `tapText("Option A"/"Cancel")` with `tapByKey(...)` or correct localised labels. Verify against the current Material 3 button labels.

### Cluster J — Bridged-mixin resolution (tom_d4rt + tom_d4rt_exec, shared fixture)

- [ ] **fixed** 29. Diagnose I-BRIDGE-1 (`Calculator.calculate`) — verify the bridged-mixin's method table is registered. Likely in `tom_d4rt/lib/src/runtime_types.dart` / `tom_d4rt_ast/lib/src/runtime/runtime_types.dart` — `InterpretedClass` mixin resolution. Add a unit test that exercises the failing dispatch.
- [ ] **fixed** 30. Mirror the fix between `tom_d4rt` and `tom_d4rt_ast`. Re-run the shared fixture under both; covers #40–46 in one pass.
- [ ] **fixed** 31. Confirm I-BUG-14a (records with named fields) remains marked `SHOULD FAIL` — no fix required; this is by-design. (covers #47)

### Cluster K — d4 binary "Text file busy" (tom_d4rt_exec)

- [ ] **fixed** 32. G-TST-9: rebuild the `d4` binary into a fresh path before running D4rtTester e2e, OR serialise the test against the build step. Investigate parallel test runners holding an fd on the binary. (covers #48)

### Cluster L — VS Code Scripting API (tom_d4rt_dcli)

- [ ] **fixed** 33. Gate `VSCodeWindow.getActiveTextEditor` tests on an environment variable (`TOM_LIVE_VSCODE=1`) so headless CI skips them; OR provide a `MockVSCodeWindow` returning a stub editor. (covers #49, #50)

### Cluster M — generator dart_overview coverage

- [ ] **fixed** 34. tom_d4rt_generator `dart_overview` setUpAll failure — re-run with verbose output, capture the diagnostic, fix the missing bridge or coverage entry. (covers #51)

### Verification step for Cluster H

- [ ] **fixed** 35. After H1+H2 fixes, re-run the four-suite serial protocol (gii + essential + important + secondary) and confirm `aggregate_results.py framework_errors` count drops from 4→0 in flutter_ast and 5→0 in flutter_test (the transport-timeout block in flutter_test goes away with item 13).

---

## 6. Already-skipped tests (acknowledge but do not re-fix)

| Test | Reason | Action |
|---|---|---|
| `widgets/android_view_test.dart` | AndroidView only renders on Android | Keep skipped (platform-gated). |
| `dart_ui/system_color_palette_test.dart` | SystemColor not supported on Linux | Keep skipped (platform-gated). |
| `dart_ui/isolate_name_server_test.dart` | IsolateNameServer needs real Dart isolates | Keep skipped (interpreter limitation). |
| `dart_ui/image_sampler_slot_test.dart` (D1) | Destabilises subsequent dart_ui/gestures scripts | Keep skipped until D1 root cause is found. |
| `widgets/animated_switcher_test.dart` (W5) | Wedges test app /build for ~60s, cascades 34 gii tests | Keep skipped — needs separate W5 cluster work. |
| `widgets/context_action_test.dart` (W1) | Passes in isolation but wedges /clear | Keep skipped — W1 cluster work. |
| `widgets/default_text_editing_shortcuts_test.dart` (W2) | /build hangs 30s, wedges /clear | Keep skipped — W2 cluster work. |
| `widgets/live_text_input_status_test.dart` (W3) | Cascade victim of W2 | Re-evaluate once W2 fixed. |
| `widgets/lock_state_test.dart` (W4) | Wedges /build with HttpException | Keep skipped — W4 cluster work. |
| `D4-WRAP-01` (tom_d4rt) | Needs BridgedInstance mock | Keep skipped — test-infra. |

---

## 7. Notes on verification protocol

Per `_copilot_guidelines/d4rt/` and the quest overview ("Cluster-fix verification protocol"):

1. Reproduce each failing script in isolation via `bisect_test.dart` before changing code.
2. Fix the generator or interpreter (never `.b.dart` files directly).
3. Mirror any interpreter change between `tom_d4rt` and `tom_d4rt_ast` in the same commit.
4. Regenerate bridges with `tom_d4rt_flutterm/tool/regenerate_bridges.dart` (or set `D4RT_SKIP_BRIDGE_REGEN=1` only when iterating).
5. Re-run, **serially**, in this order: `gii` → `essential` → `important` → `secondary`. Never parallel `flutter test` invocations in the same package.
6. Only commit + push after the four suites pass; one cluster per commit.

The Cluster A pattern (`Undefined variable: build` × 24) deserves a single-bullet investigation before any other work — if it turns out to be a script-side typo, the failure count drops from 36→12 in `flutter_ast` and 38→13 in `flutter_test`, which would refocus the rest of the campaign.

Cluster H (framework errors) covers **22 scripts with ~84 events** and contributes zero test failures but heavy log noise. Address it after Clusters A–G since fixing it doesn't change pass/fail counts — but do address it: every overflow that lives is one more place a real regression can hide.
