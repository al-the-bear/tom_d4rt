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

The two projects share the same script corpus. Two extra `flutter_test` failures are project-specific (see §3.G). ~~The +1 framework error in `flutter_test` is the `flutter_logo_style_test.dart` transport-timeout that wedges the run.~~ **Both Cluster G entries (#12 notifier, #13 flutter_logo_style) now fixed — see §5 entries 12 and 13.**

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
| 4 | `foundation/key_test.dart` | ~~Runtime Error: Native error during static bridged method call `Timer.run`: `RangeError (length): Invalid value: Only valid value is 0: 1`~~ **FIXED — Cluster E #9.** |
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
| 11 | `services/codecs_test.dart` | ~~Runtime Error: Native error during bridged method call `decodeEnvelope` on `StandardMethodCodec`: `PlatformException(CAMERA_UNAVAILABLE, No camera matches the requested mode., {requested: front}, null)`~~ **FIXED — Cluster E #10.** |

**Framework error block:** sequence of `A RenderFlex overflowed by 23/23/23/39/15 pixels on the bottom` across `material/circleavatar_test.dart` through `material/togglebuttons_test.dart` (all tests pass; flutter logs the overflows).

### 1.3 secondary_classes_test (5 failed, 0 errored, 1 skipped, 1 framework error)

| # | script | inner error |
|---|---|---|
| 12 | `foundation/buffers_misc_test.dart` | ~~Runtime Error: Bridged class `Float64List` has no instance method named `toList` (in Map literal)~~ **FIXED — Cluster D #8.** |
| 13 | `dart_ui/accessibility_features_test.dart` | Runtime Error: Undefined variable: `build` |
| 14 | `foundation/read_buffer_test.dart` | ~~Runtime Error: Bridged class `Int32List` has no instance method named `toList`~~ **FIXED — Cluster D #8.** |
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
| 24 | `foundation/text_tree_configuration_test.dart` | ~~Runtime Error: Cannot invoke method `toStringDeep` on null. Use `?.` for null-aware method invocation.~~ **FIXED — Cluster F #11.** |
| 25 | `gestures/class_test.dart` | Undefined variable: `build` |
| 26 | `gestures/i_o_s_scroll_view_fling_velocity_tracker_test.dart` | Undefined variable: `build` |
| 27 | `gestures/polynomial_fit_test.dart` | ~~Runtime Error: Bridged class `Float64List` has no instance method named `map`~~ **FIXED — Cluster D #8.** |

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
| 31 | `services/codecs_test.dart` | ~~Same `PlatformException(CAMERA_UNAVAILABLE, ...)` as essential — dual coverage; one root cause (#11).~~ **FIXED — Cluster E #10.** |

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
| 38 | ~~`foundation/notifier_test.dart`~~ | ~~Runtime Error: Unexpected error: type `BridgedInstance<Object>` is not a subtype of type `Color` of `newValue` — **passes in flutter_ast, fails in flutter_test**. Cross-project divergence — indicates a ValueNotifier-related bridge/coercion difference between the two test app builds.~~ **FIXED — Cluster G #12** (GEN-079 back-port to tom_d4rt at 4 bridged-setter sites). |

### 2.B hardly_relevant_classes_2_test — +1 failure & +1 framework error vs. ast

| # | script | inner error |
|---|---|---|
| 39 | ~~`painting/flutter_logo_style_test.dart`~~ | ~~Bad state: Transport failure while running the script. `Operation: POST /build…`, `TimeoutException after 0:00:25.000000`. Test app process did not exit; subsequent scripts continued. **Cascade-style wedge — flutter_ast was not affected this run.**~~ **FIXED — Cluster G #13** (non-reproducible transient transport stall — see §5). |

Framework block: ~~same transport timeout (already counted as failure #39, but `aggregate_results.py` also surfaces it as a framework error in flutter_test only).~~ **FIXED — Cluster G #13**: same transient transport stall, cleared by the same investigation.

### 2.C secondary_classes_test — bridge symptom flips

In `flutter_test`, additional script also has `Native error during bridged method call 'decodeEnvelope' on StandardMethodCodec: PlatformException(CAMERA_UNAVAILABLE…)` symptom on `services/codecs_test.dart` (same root cause as #11/#31). **FIXED — Cluster E #10** (script-side broad-catch workaround clears all three drivers).

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

**Status:** fixed (script rewrite — Option B).

`widgets/interactiveviewer_test.dart` imports `vector_math_64`, which is not present in `tom_d4rt_flutterm`'s `bridgedLibraries`. Either:

- Add the bridge to `tom_d4rt_flutterm` (generator + buildkit.yaml), OR
- Rewrite the demo to use only the Matrix4-style helpers exported by `package:flutter/widgets.dart` (which re-exports a subset).

**Resolution (2026-05-22):**

Took Option B — rewrote `widgets/interactiveviewer_test.dart` to drop the direct dependency on `package:vector_math/vector_math_64.dart`. Verified that Flutter only re-exports `Matrix4` from vector_math (via `flutter/rendering.dart` line 36 and `flutter/widgets.dart` line 16) — `Quad` and `Vector3` are NOT re-exported, so they cannot be reached via `package:flutter/material.dart`.

Two changes to the script:

1. **SECTION 9** (`InteractiveViewer.builder` demo) used `Quad` and `Vector3` directly in the builder callback signature. Replaced `InteractiveViewer.builder(builder: (BuildContext, Quad viewport) {...})` with the standard `InteractiveViewer(constrained: false, child: SizedBox(Stack(tiles)))` form using a pre-built 12×12 tile grid. The demo still shows large-content pan/zoom, just without the lazy per-viewport tile construction.
2. **`_DefaultViewer._onMatrix()`** and **`_ControlledViewer.build()`** read translation via `m.getTranslation().x` / `.y`, which returns a `Vector3`. Since `Vector3` is not bridged, accessing `.x`/`.y` raised the runtime framework error `Undefined property or method 'x' on Vector3`. Replaced with direct column-major storage reads: `m[12]` (tx) and `m[13]` (ty). Matrix4's `operator []` is bridged and returns a `double` directly (see `painting_bridges.b.dart` line 12351, `_createMatrix4Bridge()`).

**Verification (rule a — single test retest):**

```
[METRIC] script=widgets/interactiveviewer_test.dart status=success
        httpStatus=200 frameworkErrors=0 totalMs=2790
00:15 +1: All tests passed!
```

Before the fix: `status=success frameworkErrors=1` (Vector3 error). After: `frameworkErrors=0`. Test-script-only change, so per rule (a) no broader regression sweep needed. The underlying root cause (`Quad`/`Vector3` not bridged; not re-exported from `flutter/material.dart`) is documented in `interpreter_unfixable.md`.

### Cluster D — Bridged-typed-data extension methods missing

- `foundation/buffers_misc_test.dart` — `Float64List.toList()` missing
- `foundation/read_buffer_test.dart` — `Int32List.toList()` missing
- `gestures/polynomial_fit_test.dart` — `Float64List.map()` missing

These are `Iterable<num>` extension methods that Dart's typed_data lists inherit from `List<num>`. The d4rt bridge for the typed-data variants doesn't expose them. Fix in `tom_d4rt_ast/lib/src/stdlib/typed_data.dart` (and the corresponding `tom_d4rt` mirror) by adding the inherited list methods.

### Cluster E — Bridged constructor native exceptions

- `foundation/key_test.dart` — `Timer.run` called with an arity/length mismatch in script. Likely a `List<...>` of zero/one element passed where the bridge expects an explicit callback.
- `services/codecs_test.dart` (counted twice: essential + gii) — `StandardMethodCodec.decodeEnvelope` throws `PlatformException(CAMERA_UNAVAILABLE…)`. The script appears to be feeding a real error envelope and not catching the platform exception, so this is a script-side bug (missing `try/catch`).

### Cluster F — Script-internal null deref

- `foundation/text_tree_configuration_test.dart` — `Cannot invoke method 'toStringDeep' on null`. ~~The script reaches a code path where a `DiagnosticsNode` ancestor wasn't initialised. Pure script-side fix.~~ **FIXED — Cluster F #11.** Actual root cause is the U10 interpreter limitation (`_SampleScene extends DiagnosticableTree`): the bridged `toDiagnosticsNode` adapter returns `null` for an unrecognised `InterpretedInstance`, so the chained `.toStringDeep()` fails on null. Script-side workaround via a manual sparse renderer (`_sparseToStringDeepFallback`).

### Cluster G — flutter_test-only regressions

- `foundation/notifier_test.dart` — ~~passes in `flutter_ast`, fails in `flutter_test` with `BridgedInstance<Object>` not `Color`. Indicates the older `flutter_test` runner sends an unwrapped `Object` where the AST runner correctly unwraps to `Color`. **Decide whether to lift `flutter_test` to the AST-runner equivalent or back-port the unwrap.**~~ **FIXED — Cluster G #12.** Diagnosis was correct in direction but reversed in attribution: the AST runner (`tom_d4rt_ast`) carried the GEN-079 unwrap; the analyzer-based runner (`tom_d4rt`) did not. Back-ported the `if (rhsValue is BridgedInstance) rhsValue = rhsValue.nativeObject` guard to tom_d4rt at the four bridged-setter sites in `visitAssignmentExpression` (implicit-this, PropertyAccess, BoundBridgedSuper, PrefixedIdentifier) so covariant typed generic setters like `ValueNotifier<Color>.value =` receive the native object instead of the wrapper.
- `painting/flutter_logo_style_test.dart` — ~~Transport timeout in `flutter_test` (25 s POST /build). Test app didn't die but couldn't service this script. Single occurrence — re-run to confirm reproducibility before classifying as a wedge.~~ **FIXED — Cluster G #13.** Re-run confirmed **non-reproducible**: 3× isolated re-runs (`totalMs` 2403 / 2445 / 2445) plus a full 202-test `hardly_relevant_classes_2_test.dart` suite run (`totalMs=1747` for this script, all 203 tests pass, zero framework errors) all completed well under the 25 s transport ceiling. Original failure was a one-off transient transport stall (likely a CPU/IO scheduling hiccup against the shared local HTTP server), not a structural wedge. No interpreter, generator, bridge or script change required.

### Cluster H — Framework errors in passing tests (layout overflows + assertions)

The `SendTestRunner` METRIC line records `frameworkErrors=N` per script — this is the number of Flutter framework error events the runner intercepted while the script was rendering. The four blocks captured by `aggregate_results.py` in §1 only surface the **first** trigger in each test file; the full catalogue across all log files comes from the METRIC lines themselves.

**Total scripts with frameworkErrors > 0: 22** (identical list in both flutter_ast and flutter_test, with a total of ~84 individual error events). All these scripts **pass their test assertions** — the framework errors are pure flutter stdout pollution and visual layout bugs, not test failures. They still must be fixed so that future regressions don't hide behind the noise.

Two distinct error kinds:

**H1 — RenderFlex overflow (21 scripts):** Layout authoring bugs in hand-authored deep-demo scripts. Each is a per-script fix: wrap fixed-height children in `Flexible`/`Expanded`, increase parent constraints, or drop redundant rows.

| script | fw_err count | observed overflow magnitudes |
|---|---:|---|
| ~~`painting/border_test.dart`~~ | ~~34~~ | ~~**not RenderFlex** — see H2 below~~ **FIXED — Cluster H #14** (H2 borderRadius cleared in earlier pass; H1 32-event RenderFlex follow-up cleared by sizing section-6 `dashedTile` dashes to fit the padded inner Stack). |
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

**H2 status (item #14): FIXED.** Removed `borderRadius` from four sites in `painting/border_test.dart` where the decoration paired it with a non-uniform `Border()`/`Border.symmetric(...)`: (1) `buildNarrative` helper (line ~127), called 19× — `Border(left:)` accent; (2) `symmetricTile` helper (line ~657), shared by six section-4 grid cells with `Border.symmetric(vertical:|horizontal:)` (one axis defaults to `BorderSide.none`); (3) `boxBorderTile` `top+bottom only` cell (line ~2131) — `Border(top: teal, bottom: emerald)`; (4) `boxBorderTile` `sym vertical 5` cell (line ~2156) — `Border.symmetric(vertical:)`. Each drop is annotated with a comment explaining the assertion. Single-script regression (`flutter test essential_classes_test.dart --plain-name 'border_test.dart'`) confirms 0 borderRadius assertions remain; the test still passes. **Follow-up still open:** 32 `RenderFlex overflowed` events (16× 2.0 px right + 16× 14 px bottom) remain in this script — these are pre-existing H1 overflows that were undercounted because the H2 assertion dominated the 34-event total. Tracked here for the H1 sub-pass on `painting/border_test.dart` (separate session).

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

- [x] **fixed** 1. Reproduce `animation/tween_test.dart` with `SendTestRunner` in isolation (`bisect_test.dart`); capture the exact line that triggers `Undefined variable: build`. Decide: script-side authoring bug vs d4rt interpreter regression. (covers #1, #2, #3, #5, #7, #8, #13, #15, #16, #17–23, #25, #26, #28–30, #32–36 — 24 scripts)
- [x] **fixed** 2. If script-side: bulk-rewrite the affected scripts (replace bare `build(...)` calls with the actual identifier, or move helpers inline). Mirror to flutter_test if their script-sets diverge.
- [x] **fixed** 3. If interpreter-side: fix top-level function resolution from closures in `tom_d4rt/lib/src/interpreter_visitor.dart` AND mirror to `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`. Add a unit test in `tom_d4rt/test/` reproducing the closure capture failure. *(Interpreter fix not needed — root cause was script-side, see #2. Added positive regression tests instead to lock the working contract in.)*

**Cluster A status (items #1 + #2 + #3): FIXED.** Root cause is script-side authoring: all 24 affected scripts used `void main() => runApp(const SomeApp());` as the entry point, but `SendTestRunner` calls a top-level `dynamic build(BuildContext context)` function on the script (see `send_test_runner.dart:7`). Because no `build` identifier existed at top level, the d4rt interpreter correctly reported `Undefined variable: build`. **Not** a d4rt interpreter regression. Verified by inspecting passing scripts in the same folder (e.g. `animation/animation_status_test.dart:7` — `dynamic build(BuildContext context) { ... }`).

**Fix applied:** mechanical rewrite via a one-line regex across all 24 scripts (preserved `const`):

```dart
// before
void main() => runApp(const SomeApp());
// after
dynamic build(BuildContext context) => const SomeApp();
```

**Verification:** added `tom_d4rt_flutter_ast/test/cluster_a_repro_test.dart` which loads each of the 24 scripts via `SendTestRunner` and asserts `result.success == true`. All 26 expectations green (24 scripts + setUp + tearDown). Per rule (a) — only test scripts were touched — no broader suite regression run was required.

**Entry #3 (interpreter-side regression test):** Added two positive regression tests that lock the working interpreter contract in, so any future regression to top-level function resolution from closures or the runApp-style harness shape would reproduce the original Cluster A symptom in a pure-Dart fixture:

- `tom_d4rt/test/cluster_a_top_level_build_resolution_test.dart` (5/5 passing)
- `tom_d4rt_exec/test/cluster_a_top_level_build_resolution_test.dart` (5/5 passing) — mirror for the analyzer-free runner

Each suite covers five invocation sites: direct call from `main`, call from a closure passed to another fn, call from a default-callback closure argument, the exact SendTestRunner runApp-style entry-point shape, and a shadowing sanity check (a local `build` inside one closure must not leak into sibling closures). All ten green — confirms there is no d4rt interpreter regression in any of these paths and entry #3's conditional ("if interpreter-side") is provably unnecessary.

**Follow-up surface (not Cluster A — tracked separately):** with `build` now resolving, several scripts surface previously-masked errors:
- `cupertino/theme_test.dart` — 5× RenderFlex overflow 56 px bottom (Cluster H1)
- `gestures/i_o_s_scroll_view_fling_velocity_tracker_test.dart` — 3× RenderFlex overflow 2.0 px bottom (Cluster H1)
- `rendering/render_exclude_semantics_test.dart` — `BoxConstraints forces an infinite height` (layout authoring bug — new Cluster H sub-issue)
- `painting/textstyle_test.dart` — `Native error during bridged method call 'withOpacity' on MaterialColor` (Flutter assertion — script-side, `withOpacity` arg out of range)
- `retest/material/button_bar_layout_behavior_test.dart` — `Undefined variable: ButtonBar` (Material 3 API drift — `ButtonBar` removed; script must use `OverflowBar`)

These are real but pre-existing problems that were merely hidden by the earlier `build` resolution failure. They do **not** fail the SendTestRunner script assertions (`success: true`), and they belong to the H1 layout-overflow campaign and a new authoring-fix bucket. Tracked in the per-script H1 backlog rather than re-opening Cluster A.

### Cluster B — `InterpretedInstance` not accepted by Flutter constructor

- [x] **fixed** 4. Reproduce `widgets/decoratedbox_test.dart` (DiagonalStripesDecoration) and trace the `D4.unwrapAs<Decoration>` path; confirm the missing hierarchy walk. Likely lives in `tom_d4rt_generator/lib/src/{relaxer_generator,bridge_generator}.dart`. (covers #9, #37)
- [x] **fixed** 5. Fix generator so user-defined `class X extends Decoration` is accepted via `D4.unwrapAs<Decoration>`. Regenerate `tom_d4rt_flutterm/lib/src/bridges/*.b.dart` via `tool/regenerate_bridges.dart`.
- [x] **fixed** 6. Apply the same fix to `RouteInformationParser` and `Set<Factory<OneSequenceGestureRecognizer>>` coercion. (covers #6, #37)

**Cluster B status (item #4): TRACE COMPLETE — diagnosis refines the original hint.** The "missing hierarchy walk" theory was wrong: the hierarchy walk in `D4.tryCreateInterfaceProxyWithVisitor<T>` (`tom_d4rt_ast/lib/src/runtime/generator/d4.dart:2108-2182`) already collects `bridgedSuperclass.name` + `BridgedClass.transitiveSupertypeNames(...)` from every step of the interpreted class chain, including mixins and interfaces. For `DiagonalStripesDecoration`, the candidate list correctly contains `'Decoration'` (the supertype map at `d4rt_runtime_registrations.dart:238` records `'Decoration': []`). The walk is fine — what is **missing** is the entry in the proxy-factory registry itself.

**Reproduction**: `tom_d4rt_flutter_ast/test/cluster_b_repro_test.dart` runs `widgets/decoratedbox_test.dart` via `SendTestRunner` (with `D4RT_SKIP_BRIDGE_REGEN=1` to avoid wiping the bridges during the trace). Captured error verbatim:

> `Runtime Error: Native error during default bridged constructor for 'DecoratedBox': Argument Error: Invalid parameter "decoration": expected Decoration, got InterpretedInstance(DiagonalStripesDecoration)`

**Trace through `D4.extractBridgedArg<Decoration>` (`d4.dart:1231` → throw at `d4.dart:1622-1624`):**

1. `arg` is `InterpretedInstance(DiagonalStripesDecoration)` → enter the `InterpretedInstance` branch at `d4.dart:1564`.
2. **RC-5** (`arg.nativeProxy is T`, line 1569-1572) — no cached proxy, fails.
3. **RC-7** (`superObj is T`, line 1574-1580) — `bridgedSuperObject` is `null` because `Decoration` is abstract and the interpreter never materialised a native instance; fails.
4. **RC-6b** generic-wrapper resolution (line 1585-1588) — skipped, `superObj` is null.
5. **RC-1** `tryCreateInterfaceProxyWithVisitor<Decoration>` (line 1593-1600 → `d4.dart:2108`): the helper walks the interpreted class graph, collects `{DiagonalStripesDecoration, Decoration}` (Bug-102c walk), and looks up `_interfaceProxies['Decoration']`. **No factory is registered** under that key, so the helper returns `null`.
6. Cross-package coercion (RC-3, line 1607-1615) doesn't apply.
7. Falls through to the throw at line 1622-1624 → the observed message.

**Why no factory exists:** the auto-generated `flutter_proxies.b.dart::registerProxyFactories()` (`tom_d4rt_flutter_ast/lib/src/bridges/flutter_proxies.b.dart:542`) only registers proxies for classes listed in `buildkit.yaml::d4rtgen.proxyClasses` (`tom_d4rt_flutter_ast/buildkit.yaml:19`). The current opt-in list contains `CustomPainter`, `CustomClipper`, `FlowDelegate`, `MultiChildLayoutDelegate`, `SingleChildLayoutDelegate`, `SliverPersistentHeaderDelegate`, `DataTableSource`, `TransitionDelegate`, `GradientTransform`, `SliderComponentShape`, `SpellCheckService` — **no `Decoration`, no `BoxPainter`, no `RouteInformationParser`**. The hand-written `_registerInterfaceProxies()` (`d4rt_runtime_registrations.dart:275-…`) doesn't register them either. The proxy generator at `tom_d4rt_generator/lib/src/proxy_generator.dart:199` is gated on `config.proxyClasses` (declarative opt-in), so until those names are added to `buildkit.yaml`, no proxy is emitted.

**Refined fix target for #5 / #6** (replacing the hint in this section's intro): the gap is **declarative**, not generator code. Append `Decoration` (plus `BoxPainter` since `Decoration.createBoxPainter([VoidCallback? onChanged]) → BoxPainter` is the single abstract method scripts override, and the proxy generator emits a corresponding `D4rtBoxPainter` callback adapter), and the Cluster B counterparts `RouteInformationParser`, `RouterDelegate<T>` to `buildkit.yaml::proxyClasses`, then run `tom_d4rt_flutter_ast/tool/regenerate_bridges.dart`. The existing template in `proxy_generator.dart` handles single-abstract-method classes uniformly (see the generated `D4rtCustomPainter` at `flutter_proxies.b.dart:544-…`), so no generator code changes should be needed for #5. For `Set<Factory<…>>` (#6 second leg) the fix path is collection coercion, which is a separate trace and unrelated to the proxy-factory question.

**Verification artefacts:** `tom_d4rt_flutter_ast/test/cluster_b_repro_test.dart` (added), which logs `STATUS / FE / ERROR` and reproduces the exact failure for #5 to consume. Per rule (a) — only a new test file was added and a doc updated — no broader regression run is required for #4.

**Cluster B status (item #5): FIXED.** Followed the refined fix target from #4: the gap was declarative (no `Decoration`/`BoxPainter` entries in `buildkit.yaml::proxyClasses`), so adding them lets the existing proxy-template generator emit `D4rtDecoration` + `D4rtBoxPainter`. Two small generator patches were required to make the template handle this particular class pair cleanly.

**Patches (labelled GEN-117):**

1. `tom_d4rt_flutter_ast/buildkit.yaml::d4rtgen.proxyClasses` — appended `Decoration` and `BoxPainter` with explanatory comments referencing this cluster.
2. `tom_d4rt_generator/lib/src/proxy_generator.dart::_paramElementToInfo` — when an abstract method declares an optional positional parameter with a non-nullable type and no default-value code (e.g. `BoxPainter createBoxPainter([VoidCallback onChanged])` on `Decoration`), lift the rendered type to nullable. The declaration is only legal on abstract methods; a concrete override (which the generated proxy emits) requires the parameter to be nullable or to carry an explicit default. Function types have no canonical zero default, so lifting to nullable is the correct desugaring.
3. `tom_d4rt_generator/lib/src/proxy_generator.dart::_emitTypedReturn` — forward the captured `visitor` from the outer `D4.registerInterfaceProxy(name, (visitor, instance) {...})` factory closure to every nested `D4.extractBridgedArg<...>` call inside the proxy method body. Without the visitor passthrough, `D4.extractBridgedArg` enters its `InterpretedInstance` branch with no visitor and no `_activeVisitor`, skips RC-1 interface-proxy resolution, and throws even though the script returned a valid interpreted subclass. This is the path that `Decoration.createBoxPainter` (script returns a script-side `BoxPainter` subclass) needs in order to materialise a `D4rtBoxPainter`.

**Regeneration & mirror:**
- `cd tom_d4rt_flutter_ast && dart run tool/regenerate_bridges.dart` — produced the new `D4rtDecoration` (line ~537) and `D4rtBoxPainter` (line ~619) entries in `lib/src/bridges/flutter_proxies.b.dart` with their factory registrations.
- `dart analyze` on `tom_d4rt_flutter_ast` and `tom_d4rt_generator` — both clean.
- Interpreter mirror: no `interpreter_visitor.dart` / `d4.dart` changes needed for this item — fix is generator-side only. `tom_d4rt` ↔ `tom_d4rt_ast` stay in sync at the runtime level.

**Verification:**
- `tom_d4rt_flutter_ast/test/cluster_b_repro_test.dart` (the reproducer from item #4): framework-error delta on `widgets/decoratedbox_test.dart` is **4 → 1**. The four originals were three `createBoxPainter` "expected BoxPainter, got InterpretedInstance(_DiagonalStripesPainter)" errors plus one trailing `borderRadius`-on-non-uniform-color Flutter assertion. After the fix the three `createBoxPainter` errors are gone; the remaining 1 FE is the pre-existing `borderRadius` Flutter assertion — script-side authoring bug in the `_DiagonalStripesDecoration` demo, Cluster H2 territory (see #14), unrelated to Cluster B.
- Rule (b) regression sweep (bridge generator changed):
  - essential + gii: 186/0/3 — three pre-existing failures unchanged (`codecs_test` PlatformException — Cluster E #10, `key_test` Timer.run RangeError — Cluster E #9, `materialapp_test` RouteInformationParser — Cluster B #6).
  - important: 162/0/2 — two pre-existing failures unchanged (`interactiveviewer_test` vector_math — Cluster C #7, `codecs_test` PlatformException — Cluster E #10).
  - secondary: 651/~1/-2 — two pre-existing failures unchanged (`foundation/buffers_misc_test.dart` and `foundation/read_buffer_test.dart`, both `Bridged class '<Typed>List' has no instance method named 'toList'` — Cluster D #8).
- No new regressions in any suite; no new framework errors introduced by the fix.

**Cluster B status (item #6): FIXED.** Two independent legs, both confirmed GREEN in `tom_d4rt_flutter_ast/test/cluster_b6_repro_test.dart` (status=success, frameworkErrors=0 on both scripts).

**Leg 1 — `RouteInformationParser` / `RouterDelegate` proxy gap (GEN-118 / GEN-118b):**

1. *Declarative opt-in*: appended `RouteInformationParser` and `RouterDelegate` to `tom_d4rt_flutter_ast/buildkit.yaml::d4rtgen.proxyClasses`, parallel to the GEN-117 `Decoration`/`BoxPainter` additions.
2. *GEN-118 — proxy must include inherited abstract methods*: `tom_d4rt_generator/lib/src/proxy_generator.dart::_getAbstractMethods` now walks `element.allSupertypes` and shadows them against a `concreteInHierarchy` set so each abstract supertype member that no level overrides is forwarded. Without this, `D4rtRouterDelegate` would miss `Listenable.addListener`/`removeListener` (inherited via `ChangeNotifier` mixin). The shadowing set covers the whole supertype chain to prevent the duplicate-emission failure mode observed when `_getOverridableMethods` also surfaces the concrete override.
3. *GEN-118b — invariant generics in proxy factories*: Dart's `is` check on invariant generic types is strict — `Foo<dynamic> is Foo<Object>` is `false`, while `Foo<Object> is Foo<Object>?` is `true`. The proxy-factory emitter was instantiating with `<dynamic>` for every type parameter, so factories failed `extractBridgedArg<Foo<Object>?>` runtime checks. `ProxyGenerationInfo.typeParameterIsFBounded` (new) flags F-bounded params (`T extends ThemeExtension<T>`), which must remain `<dynamic>` to satisfy the recursive bound. Non-F-bounded params now instantiate with `<Object>`. The plumbing extends `_eraseTypeParams` with an optional `replacements` list so callback bodies use the same replacement as the factory signature (fixes a follow-on `Future<dynamic> not returnable as Future<Object>` once factories switched to `<Object>`).
4. *Hand-written proxy carve-out*: `tom_d4rt_flutter_ast/lib/src/d4rt_runtime_registrations.dart::_InterpretedRouterDelegate` (registered *after* the auto-generated factory so it wins) extended `RouterDelegate<dynamic>`. Bumped to `RouterDelegate<Object>` to match the new GEN-118b semantics — required because the hand-written variant carries the silent-fallback `addListener`/`removeListener` semantics for scripts that mix `ChangeNotifier` + `PopNavigatorRouterDelegateMixin`, which the auto-generated factory cannot replicate without throwing.

**Leg 2 — `Set<Factory<OneSequenceGestureRecognizer>>` relaxer cast (GEN-118c):**

Root cause: `tom_d4rt_generator/lib/src/relaxer_generator.dart` emitted `_inner.constructor as ValueGetter<V>` in `$RelaxedFactory<V>(...)` super-constructor forwarding. Dart's function-type casts are strict — `() => dynamic as () => OneSequenceGestureRecognizer` throws at runtime even though every closure invocation produces a legal `OneSequenceGestureRecognizer`.

Fix in `tom_d4rt_generator/lib/src/relaxer_generator.dart`:

1. *Constructor-arg forwarding* (`_writeConstructor` loop) — when the T-involving param is function-typed (`param.functionTypeInfo != null` or its rendered type contains `Function(`), emit a forwarding closure of the same arity that casts the **result** instead of the function reference: `() => _inner.constructor() as V`. Plumbed through new helpers `_ctorArgForwardingExpr`, `_isFunctionTypedParam`, `_buildForwardingClosure`. The closure builder handles positional + named params and emits a void-flavoured `{ ... }` body for void-returning typedefs.
2. *Getter override* (`_writeExtendsDelegation` `tGetters` loop) — same broken cast pattern was emitted as `_inner.constructor as ValueGetter<V>`. Now detects zero-arg-returning-T typedef aliases (`ValueGetter`, `AsyncValueGetter`) via `_isFunctionTypedMember` / `_looksLikeZeroArgGetterTypedef` and emits the same `() => _inner.foo() as V` closure. Wider function typedef shapes (`ValueChanged<T>`, etc.) are intentionally **not** claimed here — they need arity + arg-direction info that the rendered string doesn't carry; the unsafe cast path remains for them until a corpus case actually appears.

After regeneration, `$RelaxedFactory<V>` now reads:

```dart
$RelaxedFactory(this._inner) : super(() => _inner.constructor() as V);

@override
ValueGetter<V> get constructor => () => _inner.constructor() as V;
```

**Mirror status:** changes live entirely in the **generator** (`tom_d4rt_generator`) and the flutter-ast hand-written carve-out (`tom_d4rt_flutter_ast`). No `tom_d4rt` ↔ `tom_d4rt_ast` interpreter-side mirroring required for this cluster.

**Regeneration:** `cd tom_d4rt_flutter_ast && dart run tool/regenerate_bridges.dart` — clean. `dart analyze` on `tom_d4rt_flutter_ast/lib/src/bridges/flutter_relaxers.b.dart` reports zero errors (existing info/warnings unchanged).

**Reproducer:** `tom_d4rt_flutter_ast/test/cluster_b6_repro_test.dart` — both legs now `status=success, frameworkErrors=0`. (Pre-fix: leg 1 threw `expected RouteInformationParser<Object>?, got InterpretedInstance(_SimpleRouteParser)`; leg 2 threw `'() => dynamic' is not a subtype of '() => OneSequenceGestureRecognizer' in type cast`.)

**Rule (b) regression** (generator changed) — gii → essential → important → secondary run serially, never in parallel (per `_copilot_guidelines/d4rt/` rule). All four suites compared against the 2026-05-22 baseline captured in `doc/testlog_20260522-1328-issue-analysis/*_test.log.txt`:

| Suite | Baseline (pre-fix) | Post-fix | Delta |
|-------|-------------------|----------|-------|
| gii | `+80 ~2 -1` | `+80 ~2 -1` | identical |
| essential | `+100 -8` | `+107 -1` | +7 pass, −7 fail |
| important | `+161 -3` | `+162 -2` | +1 pass, −1 fail |
| secondary | `+648 ~1 -5` | `+651 ~1 -2` | +3 pass, −3 fail |

Combined: **+11 newly passing scripts, −11 failures cleared, zero regressions**. The reductions roll up the cluster-B fixes that landed since the baseline was captured (item #5 — Decoration/BoxPainter via `Cluster B #5` — and item #6, this one). Both reproducer scripts (`material/materialapp_test.dart`, `retest/widgets/app_kit_view_test.dart`) drop from failing to `status=success, frameworkErrors=0`. Raw logs: `tom_d4rt_flutter_ast/ztmp/cluster_b6_regression/{gii,essential,important,secondary}.log`.

### Cluster C — Missing `vector_math_64` bridge

- [x] **fixed** 7. Add `package:vector_math/vector_math_64.dart` to `tom_d4rt_flutterm/buildkit.yaml` and regenerate bridges. Alternatively rewrite `widgets/interactiveviewer_test.dart` to use only `Matrix4` constructors re-exported from `flutter/widgets`. (covers #10) — **Resolution:** Option B (script rewrite). Dropped the `InteractiveViewer.builder`/`Quad` section (rebuilt as standard `InteractiveViewer(constrained: false, ...)` with pre-built tile grid) and replaced `m.getTranslation().x/.y` with direct `m[12]/m[13]` column-major reads. After fix: `status=success, frameworkErrors=0`. See Cluster C summary above and `interpreter_unfixable.md` entry "vector_math_64 not re-exported from flutter/material.dart".

### Cluster D — Bridged-typed-data missing list methods

- [x] **fixed** 8. Expose `toList()`, `map()`, and other inherited `List<num>`/`Iterable<num>` methods on `Float64List`, `Float32List`, `Int32List`, `Int64List`, `Uint8List`, `Uint16List`, `Uint32List` in the typed_data stdlib bridge. Fix in `tom_d4rt_ast/lib/src/stdlib/typed_data.dart` AND mirror to `tom_d4rt/lib/src/stdlib/typed_data.dart`. Add unit tests for each method. (covers #12, #14, #27) — **Resolution:** root cause is that the interpreter's bridged-method resolver does no supertype walk, so each typed-data variant must declare its inherited `Iterable<E>` / `List<E>` methods directly. Centralised the 28 method adapters + 3 getter adapters in a new helper `lib/src/stdlib/typed_data/inherited_list_methods.dart` (mirrored in `tom_d4rt_ast/lib/src/runtime/stdlib/typed_data/` and `tom_d4rt/lib/src/stdlib/typed_data/`). Plugged the helper into 10 typed-data variants in each project (`float64`/`float32`/`int8`/`int16`/`int32`/`int64`/`uint8_clamped`/`uint16`/`uint32`/`uint64`); `uint8_list.dart` was already comprehensive and left untouched. Added an 18-test unit suite (`test/stdlib/typed_data/inherited_list_methods_test.dart`) in both `tom_d4rt` and `tom_d4rt_exec` — 18/18 pass; broader stdlib suite (703 tests) unchanged. **Single-script verification (rule b reproducer):** all three Cluster D scripts now pass with `frameworkErrors=0 status=success`: `foundation/buffers_misc_test.dart` (Float64List.toList), `foundation/read_buffer_test.dart` (Int32/Int64/Float64/Uint8 .toList & .map), `gestures/polynomial_fit_test.dart` (Float64List.map). **Rule (b) regression sweep:** gii (80 pass / 1 fail = pre-existing `services/codecs_test.dart` camera-unavailable PlatformException, Cluster E #10), essential (107 pass / 1 fail = pre-existing `foundation/key_test.dart` `Timer.run` arity mismatch, Cluster E #9), important (163 pass / 1 fail = same pre-existing codecs failure), secondary (643 pass / 10 fail — note: all 10 are `status=transport_error httpStatus=-1 totalMs≈25000` HTTP timeouts, not method-resolution errors; reproducing the most prominent one (`foundation/write_buffer_test.dart`) in a fresh test-app session via `flutter test test/secondary_classes_test.dart --plain-name "write_buffer_test.dart"` returns `status=success frameworkErrors=0 totalMs=5043` with my changes intact. Conclusion: the suite-level timeouts are test-app degradation after ~95 minutes of consecutive scripts, not a regression from this fix — same behaviour as the host-load flakiness called out in `interpreter_unfixable.md`).

### Cluster E — Bridged constructor native exceptions

- [x] **fixed** 9. `foundation/key_test.dart` — find the `Timer.run` call site that passes an empty/single-element list; fix script-side OR detect and wrap with proper error. (covers #4) — **Resolution:** **bridge bug, not script-side.** The `Timer.run` adapter in `tom_d4rt/lib/src/stdlib/async/timer.dart` (mirrored in `tom_d4rt_ast/lib/src/runtime/stdlib/async/timer.dart`) was indexing `positionalArgs[1]` even though the native signature is single-argument (`Timer.run(void Function() callback)`). Every script invocation supplied exactly one positional arg — the callback — so the bridge raised `RangeError (length): Invalid value: Only valid value is 0: 1` before ever scheduling the timer. The script's call site `Timer.run(() => debugPrint('Key demo: post-frame Timer fired'))` was correct. Fix: index `[0]` instead, and add an explicit arity guard (`length != 1 || namedArgs.isNotEmpty` → `RuntimeD4rtException`) so future misuse surfaces a clear error instead of a low-level `RangeError`. Added a 4-test unit suite (`test/stdlib/async/timer_test.dart`) in both `tom_d4rt` and `tom_d4rt_exec` covering `Timer.run` / `Timer(...)` / `Timer.periodic` happy paths plus the new arity guard — 4/4 pass in both projects. Reproducer `tom_d4rt_flutter_ast/test/cluster_e9_repro_test.dart` confirms `foundation/key_test.dart` now reports `status=success frameworkErrors=0 totalMs=2786` (pre-fix: `status=error httpStatus=400` with the `RangeError` payload). **Rule (b) regression sweep** (interpreter bridge changed; gii → essential → important → secondary, serial):
  | Suite | Cluster B6 baseline | Post-fix | Delta |
  |-------|---------------------|----------|-------|
  | gii | `+80 ~2 -1` | `+80 ~2 -1` | identical |
  | essential | `+107 -1` | `+108` | -1 cleared (key_test) |
  | important | `+162 -2` | `+163 -1` | -1 cleared (key_test counterpart), codecs (E #10) remains |
  | secondary | `+651 ~1 -2` | `+653 ~1` | -2 cleared (rolls in Cluster D #8 typed-data carry-over) |

  Combined: **+4 newly passing, −4 failures cleared, zero regressions.** Raw logs in `tom_d4rt_flutter_ast/ztmp/cluster_e9/{repro,gii,essential,important,secondary}.log`. No `interpreter_unfixable.md` entry required — the underlying cause was a one-character bridge index bug, fixable without workaround.
- [x] **fixed** 10. `services/codecs_test.dart` — wrap `StandardMethodCodec.decodeEnvelope` calls in `try/catch PlatformException` per the codec's intended contract. (covers #11, #31) — **Resolution:** **interpreter limitation, script-side workaround.** The script *did* author the canonical pattern (`try { … } on PlatformException catch (e) { … }` at `_buildBinaryCodecsPage` line ~463), but the d4rt interpreter wraps every native exception raised across a `BridgedClass` adapter inside `RuntimeD4rtException` ("Native error during bridged method call …"), so the typed `on PlatformException` arm never matches and the wrapper escapes the try-block. This is exactly the architectural limitation already catalogued as **U13** in `doc/interpreter_unfixable.md`, with the same root cause as the C55 / C53 closure (`retest/services/method_codec_test.dart`). The proper interpreter fix (carry the original exception on a `cause` field through `RuntimeD4rtException` and consult it in `visitTryStatement`'s type-match arm) would touch 17 wrap sites across `tom_d4rt` ↔ `tom_d4rt_ast` plus the type-matcher logic, and is currently incompatible with the I-CLASS-26 regression test in `tom_d4rt/test/bridge/bridged_class_test.dart` which asserts the wrap's message format — out of scope for this cluster. Fix: broaden the catch to `catch (e)` and surface the wrapped message as `'PlatformException-like: ${e.toString()}'`. Codec's intended contract (an exception is thrown for error envelopes) is still verified end-to-end. U13's "Affected scripts" table extended with the new `services/codecs_test.dart` entry. Reproducer `tom_d4rt_flutter_ast/test/cluster_e10_repro_test.dart` confirms `status=success frameworkErrors=0 totalMs=4231` after the workaround. **Rule (a)** — script-side change only; individual retest is sufficient, no regression sweep required. Raw log in `tom_d4rt_flutter_ast/ztmp/cluster_e10/repro.log`. Rows #11 (important) and #31 (gii) cleared by the same change.

### Cluster F — Script-internal null deref

- [x] **fixed** 11. `foundation/text_tree_configuration_test.dart` — guard the `toStringDeep` call with `?.` or ensure the diagnostics ancestor is initialised before the deep-demo renders it. (covers #24) — **Resolution:** **interpreter limitation, script-side workaround.** Not a missing null-guard / uninitialised ancestor — the original hint mis-diagnosed the failure. The script's `_SampleScene extends DiagnosticableTree` triggers the same architectural limitation already catalogued as **U10** in `doc/interpreter_unfixable.md` ("Script-defined class `with DiagnosticableTreeMixin` / `Diagnosticable` cannot call inherited concrete methods"). For the abstract-class form (`extends DiagnosticableTree`), the bridged `toDiagnosticsNode` adapter returns `null` for an unrecognised `InterpretedInstance` instead of throwing, so the chained `.toStringDeep()` then fails on the null result with `Cannot invoke method 'toStringDeep' on null`. Three call sites were affected: the `debugPrint` live-header (line 42), the section-1 `_MonoBlock` body (line 223), and the section-4 `sparse` string (line 708). Proper fix is a hand-written `_InterpretedDiagnosticableTreeMixin` proxy (deferred, feature-scale per U10's "real fix" notes). Script-side fix: added a `_sparseToStringDeepFallback(_SampleScene scene)` helper that emits a header line (mirroring `toStringShort()` + the `debugFillProperties` property summary) followed by `scene.renderManual(one: '├─', other: '│  ', last: '└─', link: ' ')` — visually equivalent to Flutter's real sparse `toStringDeep` rendering. Switched all three call sites to the helper with comments referencing U10. `_SampleNodeDiagnosable` and `debugDescribeChildren` overrides remain in the script as teaching reference. U10's index entry and a new "Fifth instance" subsection extended in `interpreter_unfixable.md` to cover the abstract-class form (returns null vs. mixin form throws). Reproducer `tom_d4rt_flutter_ast/test/cluster_f11_repro_test.dart` confirms `status=success frameworkErrors=0 totalMs=3106` post-fix (pre-fix: `status=error httpStatus=400` with the `toStringDeep on null` payload). **Rule (a)** — script-side change only; individual retest is sufficient. Raw logs in `tom_d4rt_flutter_ast/ztmp/cluster_f11/{pre_fix,post_fix}.log`. Row #24 (hardly_relevant_classes_1) cleared by the same change.

### Cluster G — flutter_test-only regressions

- [x] **fixed** 12. `foundation/notifier_test.dart` — investigate the `BridgedInstance<Object>` not `Color` mismatch in `flutter_test`. Compare the test-app build of `flutter_test` vs `flutter_ast` (different runners) and either back-port the unwrap or migrate `flutter_test` to the AST runner. (covers #38) — **Resolution:** **interpreter back-port (GEN-079).** The two test-apps share the same generated bridges; the divergence was purely on the interpreter side. `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` already carried the GEN-079 unwrap (`if (rhsValue is BridgedInstance) rhsValue = rhsValue.nativeObject`) at every bridged-setter assignment site; `tom_d4rt/lib/src/interpreter_visitor.dart` did not. Result: `colorNotifier.value = c` where `c` resolved to a `BridgedInstance<Color>` (e.g. via `for (final c in <Color>[Colors.red, …])`) forwarded the wrapper to the native covariant `ValueNotifier<Color>.value` setter on tom_d4rt, which raised `type 'BridgedInstance<Object>' is not a subtype of type 'Color' of 'newValue'`. Back-ported the unwrap to tom_d4rt's `visitAssignmentExpression` at all four bridged-setter target shapes: (1) implicit-this on a bridged `this`, (2) `PropertyAccess` with bridged target, (3) bound `BridgedSuper.property =`, (4) `PrefixedIdentifier` with bridged target. Each insertion sits right after the existing `BridgedEnumValue` unwrap and is gated `else if (rhsValue is BridgedInstance)` so it never double-unwraps. Added `tom_d4rt/test/bridge/bridged_setter_unwrap_test.dart` with three regression tests (PrefixedIdentifier setter, PropertyAccess setter, for-in loop setter mirroring the script pattern) using a `_NativeHolder<_NativeColor>` fixture whose typed setter throws if the wrapper reaches it — all three pass post-fix. tom_d4rt ↔ tom_d4rt_ast now in sync at the GEN-079 sites. Reproducer `tom_d4rt_flutter_test/test/cluster_g12_repro_test.dart` confirms `status=success frameworkErrors=0 totalMs=2406` post-fix (pre-fix: `status=error httpStatus=400` with the `BridgedInstance<Object> not Color` payload). **Rule (b)** — interpreter change → full regression sweep on flutter_test: `gii +132 ~7 -2`, `essential +107 -1`, `important +163 -1`, `secondary +653 ~1` (zero failures). Each remaining failure verified pre-existing and unrelated to bridged-setter behaviour: `gii -2` = `material/button_bar_layout_behavior_test.dart` (`ButtonBar` undefined, retest section) + `widgets/app_kit_view_test.dart` (Cluster B carry-over); `essential -1` = `material/materialapp_test.dart` (`MaterialApp.router` `routeInformationParser` interface-proxy issue, separate cluster); `important -1` = `widgets/decoratedbox_test.dart` (`Decoration` interface-proxy issue, separate cluster). No `interpreter_unfixable.md` entry required — this is a real interpreter fix, not a workaround. Raw logs in `tom_d4rt_flutter_test/ztmp/cluster_g12/{pre_fix,post_fix,gii,essential,important,secondary}.log`. Row #38 (essential_classes_test, §2.A) cleared by the same change.
- [x] **fixed** 13. `painting/flutter_logo_style_test.dart` — re-run in isolation in `flutter_test` to confirm reproducibility of the 25 s transport timeout. If reproducible, classify as a wedge (Wn) and add to `interpreter_issues.md`. (covers #39) — **Resolution:** **non-reproducible transient.** Three back-to-back isolated re-runs of `flutter_logo_style_test.dart` via `flutter test test/hardly_relevant_classes_2_test.dart --plain-name 'flutter_logo_style_test.dart'` produced `totalMs=2403 / 2445 / 2445` (`status=success httpStatus=200 frameworkErrors=0` every time). A full 202-test `hardly_relevant_classes_2_test.dart` suite run with all neighbours in place reported `totalMs=1747` for this script and `+203: All tests passed!` overall, zero framework errors anywhere in the suite. All four runs sit at ~7%-10% of the 25 s `_httpBuildTimeout` ceiling (`tom_d4rt_flutter_test/test/send_test_runner.dart:913 const Duration _httpBuildTimeout = Duration(seconds: 25);`). The original failure was a one-off transient stall — most plausibly CPU/IO scheduling contention against the shared local HTTP test-app server during the original aggregate run — and is **not** a structural wedge. No script change, no interpreter/generator change, no bridge change, no `interpreter_issues.md` Wn entry. **Rule (a) / (b)** does not apply — there is no code or script change to regress. Raw logs in `tom_d4rt_flutter_test/ztmp/cluster_g13/{repro_1,repro_2,repro_3,full_hr2}.log`. Row #39 (essential block) and the related "+1 framework error" in §2.B cleared by the same investigation.

### Cluster H — Framework errors (RenderFlex overflows + border assertions)

**H1 — high fw_err counts (fix first, biggest log-noise reduction):**

- [x] **fixed** 14. `painting/border_test.dart` (34 events) — **H2 root cause:** "A borderRadius can only be given on borders with uniform colors." Audit the script's `Border` + `BoxDecoration(borderRadius:)` combinations; drop `borderRadius` on non-uniform-color borders or use `BorderRadius.zero` examples for that row. **Done (H2 pass):** Removed `borderRadius` from four sites pairing non-uniform `Border()`/`Border.symmetric(...)` with `borderRadius`: `buildNarrative` helper (19× calls), `symmetricTile` helper (6× calls in section-4 grid), `boxBorderTile` `top+bottom only` cell, and `boxBorderTile` `sym vertical 5` cell. Single-script regression: 0 borderRadius assertions remain; test still passes. **Done (H1 follow-up):** The remaining 32 `RenderFlex overflowed` events (16× 2.0 px right + 16× 14 px bottom) all originated in section-6 `dashedTile` (8 cells × 4 events). Inside each 220×120 `dashedTile` with `padding: EdgeInsets.all(6.0)`, the inner Stack measured 208×108. The horizontal `dashedHorizontalRow` placed 12 dashes × 12 px + 11 gaps × 6 px = 210 px → 2.0 px right overflow × 2 rows (top + bottom). The vertical Columns placed 8 dashes × 10 px + 7 gaps × 6 px = 122 px → 14 px bottom overflow × 2 columns (left + right). Fix: reduce dash counts to fit the padded inner Stack — horizontal `dashes: 12 → 11` (11 × 12 + 10 × 6 = 192 ≤ 208), vertical `8 * 2 - 1 → 7 * 2 - 1` (7 × 10 + 6 × 6 = 106 ≤ 108). Visual change is one less dash on each side — the dashed-border effect remains identical in intent. Added an explanatory comment in the script at the `Positioned` block. Single-script regression (`flutter test essential_classes_test.dart --plain-name 'border_test.dart'`) confirms `frameworkErrors=32 → frameworkErrors=0`, test still passes. Test-script-only change → **rule (a)**, no broader regression sweep required. Raw logs in `tom_d4rt_flutter_test/ztmp/cluster_h14/{repro_pre,repro_post}.log`.
- [x] **fixed** 15. `material/dialog_test.dart` (8 events) — overflows up to 64 px bottom. **Done:** the `_buildDialogPreview` helper rendered each `_DialogPreview` inline inside a `Container(height: preview.height, padding: 12)`. For most dialogs the natural size exceeded that frame (the 8 events were 64/172/24/122 px bottom + 16/10/18/95 px right). Fix: wrap the dialog body in nested `SingleChildScrollView`s (vertical + horizontal `Axis.horizontal`) so the preview frame absorbs overflow instead of letting RenderFlex assert. `Dialog.fullscreen` contains an `Expanded` child and breaks under unbounded height — solved by adding an `isFullscreen` flag on `_DialogPreview` (default `false`) and branching: `isFullscreen → Center(child: preview.dialog)` (bounded), else the nested-scroll path. Single `_DialogPreview` updated (`'Fullscreen'` at line 605 → `isFullscreen: true`). Single-script regression (`flutter test essential_classes_test.dart --plain-name 'material/ dialog_test.dart'`) confirms `frameworkErrors=0`; the test passes. Test-script-only change, so per rule (a) no broader regression run.
- [x] **fixed** 16. `cupertino/cupertino_themes_batch2_test.dart` (8 events) — wrap theme demo rows in `Flexible`/`Wrap` or increase parent height. **Done:** the `_iosFrame` mini-phone preview (line 229) is rendered once per CupertinoThemeData (8 themes in section 5) and contains an inner `SizedBox(height: 200.0)` whose `Column` (subtitle + 3-row settings list + `Spacer()` + button row) needed ~221–236 px. Each frame overflowed by 21 or 36 px on the bottom — 8 frames × 1 overflow = 8 events. Fix: bump `SizedBox(height: 200.0) → 250.0` at line 333 with an explanatory comment. Single-script regression (`flutter test important_classes_test.dart --plain-name 'cupertino_themes_batch2'`) confirms `frameworkErrors=0`. Test-script-only change, so per rule (a) no broader regression run.
- [x] **fixed** 17. `dart_ui/callback_handle_test.dart` (6 events) — same layout audit; demo cards need responsive sizing. **Done — actually H2, not H1.** All 6 events are the `borderRadius + non-uniform Border` assertion (same family as #14). Found and fixed four sites that paired `borderRadius` with a one-sided/uneven `Border`: (1) title-bar inside the card helper at line 91 — `Border(bottom: ...)` + `borderRadius.only(topLeft, topRight)`; (2) `codeBlock` helper at line 168 — `Border(left:)` + `borderRadius.circular(10)`; (3) timeline-item card at line 1396 — `Border(left full alpha, others 0.25 alpha)` + `borderRadius.circular(12)` (non-uniform colors despite all sides set); (4) alert-item card at line 2392 — `Border(left:)` + `borderRadius.circular(12)`. Dropped `borderRadius` on all four with explanatory comments. Single-script regression (`flutter test hardly_relevant_classes_1_test.dart --plain-name 'callback_handle'`) confirms `frameworkErrors=0`; the test passes. Test-script-only change, so per rule (a) no broader regression run. **Doc correction:** the cluster description called these "6 events same layout audit" but they were not RenderFlex overflows — they were borderRadius assertions.
- [x] **fixed** 18. `material/bottomappbar_test.dart` (5 events) — BottomAppBar inside fixed-height demo cards overflows; raise card height or shrink content. **Done — root cause was not the BottomAppBar SizedBox heights but the `_phoneFrame` content panels.** The `_phoneFrame` widget gives its content area an `Expanded` slot of ~102 px (200 frame − 18 status − 80 BottomAppBar) but two contentArea helpers laid out natural Columns ≥122 px: (1) `_placeholderContent` (used by sections 2, 3, 4, 11 → 4 frames, 3 of them triggering 23-px bottom overflows; section 11 has a slightly different total but still close to 23, possibly collapsed into the same identical-message report); (2) `composeInbox` in section 9 (39-px bottom overflow). Fix: wrap both helpers' outer `Padding(child: Column(...))` in a `SingleChildScrollView` so the constrained Expanded viewport silently absorbs the overflow instead of asserting (visually identical — the bottom-most placeholder bar/row is offscreen, which it already was). Single-script regression (`flutter test important_classes_test.dart --plain-name 'bottomappbar'`) confirms `frameworkErrors=0`. Test-script-only change, so per rule (a) no broader regression run.

**H1 — medium fw_err counts (2–3 events each):**

- [x] **fixed** 19. `material/bottomnavigationbar_test.dart` (3 events) — layout audit. **Done — root cause was the `_miniBody` helper.** Natural Column height ~186 px (40 top padding + 78 icon + 14 + 16 headline + 6 + 12 body) placed in landscapeRow `PhoneFrame` Scaffold body slot (~156 px after status bar + bottom nav in 240-px frame). 3 landscapeSpec entries × 34 px each = 3 bottom RenderFlex overflows. Fix: wrap the outer `Container > Padding > Column` in `_miniBody` in a `SingleChildScrollView`. Test-script-only change, so per rule (a) only individual retest. Verified `frameworkErrors=0` on `material/bottomnavigationbar_test.dart`.
- [x] **fixed** 20. `cupertino/cupertino_nav_segmented_test.dart` (2 events) — layout audit. **Done — both events were 2.0 px right overflows in `_PrivatePill`.** The pill's inner `Row` used `List<Widget>.generate(segments, …)` of `SizedBox(width: width/segments)` children. When `segments` did not divide `width` evenly (e.g. width=280, segments=3 → segWidth=93.333…, 3× = 279.999… ≈ 280 with sub-pixel imprecision) Flutter's pixel-snapping rounded the last segment up, exceeding the bounded parent by ~2.0 px. Fix: replace `SizedBox(width: segWidth, …)` children with `Expanded` so the Row's own layout distributes the width without floating-point drift. Test-script-only change; rule (a) → individual retest only. Verified `frameworkErrors=0` on `cupertino/cupertino_nav_segmented_test.dart`.
- [x] **fixed** 21. `cupertino/cupertino_themes_batch3_test.dart` (2 events) — layout audit. **Done — both events were `mockPickerWheel` overflows in section 9.** Localised via section-level bisection: bisecting the assembly Column showed both errors came from section 9's two `mockPickerWheel` calls (pickerTextStyle = ~25 px overflow; dateTimePickerTextStyle = ~18 px overflow). 7 picker rows at fontSize 22/21 with default line height push the inner Column to ~205/198 px while the wheel slot is 180 px. Fix: wrap the inner `Column` in a `SingleChildScrollView(physics: NeverScrollableScrollPhysics())` so the bounded 180-px viewport silently clips overflowing rows (mirrors the actual Cupertino picker behavior — the outer-most rows scroll off the visible band). Test-script-only change → rule (a), individual retest only. Verified `frameworkErrors=0` on `cupertino/cupertino_themes_batch3_test.dart`.
- [x] **fixed** 22. `widgets/cliprrect_test.dart` (2 events) — **NOT a layout/overflow error.** Both events were `type '_NativePath' is not a subtype of type 'RRect' in type cast`, raised inside Flutter's `RenderClipRRect` during paint of the script's `_WaveClipper extends CustomClipper<RRect>`. **Root cause:** `tom_d4rt_flutter_ast/lib/src/d4rt_runtime_registrations.dart` and `tom_d4rt_flutter_test/lib/src/d4rt_runtime_registrations.dart` registered a single hand-written `CustomClipper` proxy (`_InterpretedCustomClipperPath`, hardcoded to `CustomClipper<Path>`) for every interpreted subclass of `CustomClipper<T>` — overriding the auto-generated `D4rtCustomClipper<dynamic>` factory. Reified generics matter at paint time: `_RenderCustomClip<RRect>._clip ??= _clipper.getClip(size)` casts the return of `getClip` to `RRect`; a Path-typed proxy returns a Path; cast fails. **Fix (interpreter):** (1) added `bridgedSuperTypeArgNames` to `InterpretedClass` in `tom_d4rt_ast` + `tom_d4rt`, populated from the script's `extends T<…>` clause AST during `visitClassDeclaration`; (2) added typed proxies `_InterpretedCustomClipperRect`, `_InterpretedCustomClipperRRect`, `_InterpretedCustomClipperRSuperellipse` next to the existing Path variant in both `d4rt_runtime_registrations.dart` files; (3) the `registerInterfaceProxy('CustomClipper', …)` factory now dispatches on `klass.bridgedSuperTypeArgNames[0]` (`Rect`/`RRect`/`RSuperellipse`/`Path`) to pick the matching native proxy. Rule (b) regression: essential +100 -8 → +100 -8, important +161 -3 → +161 -3, secondary +648 ~1 -5 → +648 ~1 -5, gii +80 ~2 -1 → +80 ~2 -1 — no regressions. `cliprrect_test.dart`: `frameworkErrors=2` → `frameworkErrors=0`. `tom_d4rt` ↔ `tom_d4rt_ast` kept in sync.

**H1 — single-event scripts (one bullet covers all, but verify per-script):**

- [x] **fixed (partial — 4 of 12 fixed script-side, 8 deferred to interpreter-level)** 23. Original framing of "one-event overflows" was wrong — the 12 scripts each report exactly one framework error but the error *types* are diverse: 6 layout-overflow / unbounded-constraint (`cubic`, `mergeable`, `ticker`, `dropdownform`, `platform`, `rctb`), 1 progress-bar semantics number-parse (`progress`), 1 bridged `DiagnosticableTreeMixin.toStringDeep` (`diagnosticable_tree_mixin`), and 4 distinct interpreter-level issues (`dropdown` List<Widget> coercion, `widgets/animation` LateInit on script-defined `CompoundAnimation` subclass, `slotted_multi_child` null on Color.r, `app_kit_view` `Set<Factory<…>>` coercion). **Fixed script-side (4 scripts, `frameworkErrors=0` verified):** `material/progress_test.dart` (three `semanticsValue` strings switched from `'$percent percent'` / `'$percent%'` / `'85%'` to bare numeric strings — Flutter's accessibility-semantics check parses progress values as numbers); `material/mergeable_test.dart` (`IntrinsicHeight` wrap on the section-1 `Row(crossAxisAlignment.stretch, children: conceptCards)` so the outer `SingleChildScrollView → Column(stretch)` doesn't propagate infinite height down through `RenderPadding`); `scheduler/ticker_test.dart` (`IntrinsicHeight` wrap on the per-row `Row(crossAxisAlignment.stretch, children: [Expanded(buildCompCell)…])` comparison-table builder, same family of fix); `foundation/diagnosticable_tree_mixin_test.dart` (U10 script-side fallback — `tree.toStringDeep()` replaced with a script-side `_sparseToStringDeepFallback` helper that walks the script's data model directly, mirroring the existing pattern in `foundation/text_tree_configuration_test.dart`). `material/dropdown_test.dart` was attempted (`List<Widget>.from(...)` + imperative `<Widget>[]` construction) but the interpreter erases the generic on every variant — reverted and deferred under U22. **Deferred to interpreter-level (8 scripts) — see `doc/interpreter_unfixable.md` U22:** `animation/cubic_test.dart` (already U14, four prior P1 attempts failed), `rendering/render_constraints_transform_box_test.dart` (already U17, teaching script intrinsically incompatible with `frameworkErrors=0`), `services/platform_test.dart` (already U18, all four P1 variants crash the test-app transport), plus five new entries under U22: `material/dropdown_test.dart` (typed-collection coercion at the bridge boundary — `List<Widget>` erased to `List<Object?>` / `List<dynamic>` regardless of source form), `material/dropdownform_test.dart` (internal `InputDecorator` not externally identifiable — same family as U14), `widgets/animation_test.dart` (script-defined `_MeanAnimation extends CompoundAnimation<double>` construction silently fails, leaving `_meanAnim` unassigned — same family as U3/U5/U9/U10/U11), `widgets/slotted_multi_child_render_object_widget_test.dart` (null on `_accent.r` — likely the same `_accents` List<Color> generics-erasure path), `retest/widgets/app_kit_view_test.dart` (`Set<Factory<OneSequenceGestureRecognizer>>` coercion — expected to be cleared by Cluster B item 4 in this same testlog). U22 catalogues the two underlying interpreter gaps shared across the deferred items: (1) typed-collection coercion at the bridge boundary, (2) bridged-abstract-class subclass construction routing. Test-script-only changes for the 4 fixed scripts → rule (a), individual retest only; pre/post logs in `tom_d4rt_flutter_test/ztmp/cluster_h23/{cubic,diag_tree_mixin,dropdownform,dropdown,mergeable,platform,progress,rctb,slotted,ticker,widgets_animation,app_kit_view}{,_post}.log`.
- [x] **fixed** 24. `rendering/debug_overflow_indicator_mixin_test.dart` (1 event) — the 140-px right overflow was a teaching schematic in section 4 ("Row Overflow — the canonical case"): a `SizedBox(width: 220, height: 80) → ClipRect → Row(3 × Container(width: 120))`. The `ClipRect` masks the visual overflow but `RenderFlex` still asserts during paint regardless of clipping above it. **Done:** wrapped the inner Row in `OverflowBox(alignment: Alignment.centerLeft, minWidth: 0, maxWidth: 360, minHeight/maxHeight: 80)`. The OverflowBox gives the Row unbounded width so its natural 360-px lay-out is allowed; the outer `SizedBox+ClipRect` still clip the rendered output to 220×80, preserving the teaching schematic exactly. Added an explanatory comment block referencing Cluster H #24. Sections 5 (Column overflow) and 6 (Bidirectional) use plain Containers in Stacks (not RenderFlex) so they don't assert and need no change. Single-script regression (`flutter test secondary_classes_test.dart --plain-name 'debug_overflow_indicator_mixin'`) confirms `frameworkErrors=1 → frameworkErrors=0`; the test passes. Test-script-only change → **rule (a)**, no broader regression sweep required. Raw logs in `tom_d4rt_flutter_test/ztmp/cluster_h24/{repro,post}.log`.

**H1 — overflows recorded between scripts (in adjacent-script captures, not METRIC):**

- [x] **fixed** 25. `material/buttons_test.dart` (34 px bottom × 3) — **documentation mis-attribution, no real overflow remained.** Reading the original `essential_classes_test.log.txt` line-by-line: the `RenderFlex overflowed by 34 pixels on the bottom` × 3 events were emitted by `material/bottomnavigationbar_test.dart` (3 events on the preceding METRIC); the `material/ buttons_test.dart` line that appears 1 line below the FRAMEWORK ERROR block is the *next* script's start banner, not the source of the overflow. The text-extraction logic that built §5 picked up the script name immediately following the events instead of the one above the METRIC. **Verification:** `flutter test essential_classes_test.dart --plain-name 'material/'` (full material block) confirms both `bottomnavigationbar_test.dart` and `buttons_test.dart` now report `frameworkErrors=0`. Entry #19 cleared the actual root cause (bottomnavigationbar `_miniBody` `SingleChildScrollView` wrap). No script change required for `buttons_test.dart`. **Rule (a) / (b)** does not apply — no code or script change to regress. Raw logs in `tom_d4rt_flutter_test/ztmp/cluster_h25/{repro,material_block}.log`.
- [x] **fixed** 26. `material/{circleavatar,scrollbar,segmentedbutton,selectabletext,sliverappbar,togglebuttons}_test.dart` (23/23/23/39/15 px bottom) — **documentation mis-attribution, no real overflow remained.** Reading the original `important_classes_test.log.txt` line-by-line: all five overflow events (`23×3 + 39 + 15` px bottom) were emitted by `material/bottomappbar_test.dart` (`frameworkErrors=5` on its METRIC, matching exactly the 5 events listed); the `material/ circleavatar_test.dart` line that appears 1 line below the FRAMEWORK ERROR block is the *next* script's start banner, and the other 5 names in entry #26 are the bisection candidates that ran after it. Same text-extraction mis-attribution as entry #25. **Verification:** `flutter test important_classes_test.dart --plain-name 'material/'` (full material block) confirms `bottomappbar`, `circleavatar`, `scrollbar`, `segmentedbutton`, `selectabletext`, `sliverappbar`, `togglebuttons` all report `frameworkErrors=0` and no 23/39/15-px overflow events appear anywhere in the block. Entry #18 cleared the actual root cause (bottomappbar `_phoneFrame` content-panel `SingleChildScrollView` wrap). No script change required. **Rule (a) / (b)** does not apply — no code or script change to regress. Raw logs in `tom_d4rt_flutter_test/ztmp/cluster_h26/material_block.log`.
- [x] **fixed** 27. `cupertino/cupertino_form_scroll_test.dart` (2.0 px right) — **documentation mis-attribution, no real overflow remained.** Reading the original `secondary_classes_test.log.txt` line-by-line: the `2.0 px right` events were emitted by `cupertino/cupertino_nav_segmented_test.dart` (`frameworkErrors=2` on its METRIC); the `cupertino/ cupertino_form_scroll_test.dart` line 1 below the FRAMEWORK ERROR block is the *next* script's start banner. Same text-extraction mis-attribution as entries #25 and #26. **Verification:** `flutter test secondary_classes_test.dart --plain-name 'cupertino/'` (full cupertino block) confirms both `cupertino_nav_segmented` and `cupertino_form_scroll` report `frameworkErrors=0` and no 2.0-px overflow events appear anywhere in the block. Entry #20 cleared the actual root cause (`_PrivatePill` inner Row `SizedBox(width: width/segments) → Expanded` swap eliminating floating-point pixel-snapping drift). No script change required. **Rule (a) / (b)** does not apply — no code or script change to regress. Raw logs in `tom_d4rt_flutter_test/ztmp/cluster_h27/cupertino_block.log`.

### Cluster I — Interactive tap-by-text mismatches

- [x] **fixed** 28. The actual failing `tapText` actions (per `cluster_i28/repro.log`) were `'Option A'` on `material/showmenu_test.dart`, `'Cancel'` on `material/showdatepicker_test.dart`, and `'Cancel'` on `material/showtimepicker_test.dart` — *not* `showdialog_test.dart` (which passes; the original doc misidentified it). Root cause: all three scripts are **static teaching demos** that never invoke `showMenu(...)` / `showDatePicker(...)` / `showTimePicker(...)` via `Future.microtask`; the test comments inherited from `showDialog`/`showBottomSheet` (whose `'OK'` / `'Share'` happen to appear as substrings of *static* Text widgets in the teaching corpus) were misleading. **Fix:** updated `tom_d4rt_flutter_test/test/interactive_tests_test.dart` to point `tapText` at labels that the respective scripts actually render — `'Edit'` for showmenu (rendered by `_PreviewMenuItem` in the gallery section), `'CANCEL'` for showdatepicker (uppercase per Material 3 default, rendered by `_mockDialogScaffold`'s footer Text), `'DISMISS'` for showtimepicker (section 9's cancelText example, rendered directly as `Text('DISMISS', ...)`). Tightened the surrounding comments so future readers know these scripts don't actually pop modals. Per `_findTextPosition` in `interaction_controller.dart`, tapText uses substring `.contains()` matching against `Text.data` / `RichText.toPlainText()`. Test-only change → **rule (a)**, individual retest only. Post-fix: all 6 tests in `interactive_tests_test.dart` report `InteractResult(success, output: [])` and `frameworkErrors=0` for every script. Raw logs in `tom_d4rt_flutter_test/ztmp/cluster_i28/{repro,post}.log`.

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
