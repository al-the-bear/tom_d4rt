# Cases to rewrite scripts

This document lists test scripts whose failures or framework errors
are **caused by the script's own authoring** (or an engine /
platform contract the script is on the wrong side of), not by an
interpreter bug. Each entry explains the underlying trigger, why
no interpreter or generator change can resolve it, and the
script-side rewrite that makes the test pass cleanly.

> **Companion doc.** Genuinely unfixable cases (framework null
> paths, test-app transport cascades) and interpreter
> architectural limitations (abstract-class proxies, intrinsic-pass
> rounding, abstract bridged delegate coercion) live in
> `interpreter_unfixable.md`.

## Index

| Section | Source script(s) | Trigger family |
|---|---|---|
| [Enum exhaustiveness — `switch` over bridged enum](#enum-exhaustiveness--switch-over-bridged-enum) | 15 scripts (Index 13, 25, 27, 30, 34, 36, 38, 40 + 7 follow-ups) | Bridged-enum runtime metadata |
| [Platform capability guard — `SystemColor` on Linux](#platform-capability-guard--systemcolor-on-linux) | `dart_ui/system_color_palette_test.dart` | Engine platform capability |
| [`State.setState` during scheduler frame phases](#statesetstate-during-scheduler-frame-phases-c20d) | C20d affected scripts | Flutter scheduler contract |
| [`RestorableProperty.value` accessed in `initState`](#restorablepropertyvalue-accessed-in-initstate-d3) | D3 affected scripts | Flutter restoration contract |
| [Layout cascade — `Column`+`Expanded` in unbounded parent](#layout-cascade--columnexpanded-in-unbounded-parent-d6e2) | 18 scripts (D6 / E2) | Flutter `RenderFlex` constraint contract |
| [`Row(crossAxisAlignment: stretch)` + `Expanded` in `SliverToBoxAdapter`](#rowcrossaxisalignment-stretch--expanded-in-slivertoboxadapter-c3) | `widgets/scroll_deceleration_rate_test.dart` | Flutter `RenderFlex` cross-axis contract |
| [`BorderRadius` shorthand vs uniform-corner constraint](#borderradius-shorthand-vs-uniform-corner-constraint-e5) | `widgets/widgets_binding_observer_test.dart` | Flutter `BorderRadius` contract |
| [`whereType<T>()` does not filter nulls in d4rt stdlib](#wheretypet-does-not-filter-nulls-in-d4rt-stdlib-e7) | `widgets/restorable_double_n_test.dart` | d4rt stdlib generic-erasure limitation |
| [`RangeSlider` with `onChanged: null` + default M3 gapped track shape](#rangeslider-with-onchanged-null--default-m3-gapped-track-shape-index-32) | `material/gapped_range_slider_track_shape_test.dart` | Flutter `RangeSliderTrackShape.paint` disabled-state contract |
| [`FragmentProgram` engine cascade in multi-test suites](#fragmentprogram-engine-cascade-in-multi-test-suites) | `dart_ui/image_sampler_slot_test.dart` | Engine pipeline teardown |

---

## Enum exhaustiveness — `switch` over bridged enum

- **Sources (15 scripts):**
  - `dart_ui/color_space_test.dart` (Index 13)
  - `material/button_bar_layout_behavior_test.dart` (Index 25)
  - `material/button_text_theme_test.dart` (Index 27)
  - `material/dropdown_menu_close_behavior_test.dart` (Index 30)
  - `material/hour_format_test.dart` (Index 34)
  - `material/material_banner_closed_reason_test.dart` (Index 36)
  - `material/navigation_destination_label_behavior_test.dart` (Index 38)
  - `material/navigation_rail_label_type_test.dart` (Index 40)
  - `material/popup_menu_position_test.dart`
  - `painting/axis_direction_test.dart`
  - `rendering/hit_test_behavior_test.dart`
  - `rendering/render_android_view_test.dart`
  - `dart_ui/vertex_mode_test.dart`
  - `services/live_text_input_status_test.dart`
  - `services/lock_state_test.dart`
- **Symptom.** Compile-time error of the shape `Compile-time
  Error: The type 'BridgedEnumValue' is not exhaustively matched
  by the switch cases since it doesn't match
  'BridgedEnumValue(<missing>)'`. The script declares an
  exhaustive `switch` over a bridged enum and the analyzer cannot
  prove exhaustiveness because, at parse time, the bridged enum's
  full value set is not yet known to the host analyzer — the
  metadata is registered at runtime.
- **Underlying Dart/Flutter trigger.** Bridged enums attach their
  value list dynamically through `BridgedEnum`/`BridgedEnumDefinition`.
  Dart's exhaustiveness checker, by contrast, runs at compile
  time. The two layers don't meet: an exhaustive `switch
  (someBridgedEnum) { case … }` looks under-matched to the
  compiler even when every runtime value is covered.
- **Why not interpreter-fixable.** Closing the gap would require
  the host analyzer to consult the runtime registry during
  exhaustiveness inference — a cross-layer change that touches
  the analyzer and the bridge generator at the same time, with
  no clean place to land. The interpreter has no hook in the
  exhaustiveness pass at all.
- **Workaround.** Add a `default:` arm to the `switch`. Where the
  test's intent is "verify all values are handled", supplement the
  default with explicit `expect(values.length, equals(N))` so the
  test still asserts the enum's cardinality without relying on
  exhaustiveness inference.

---

## Platform capability guard — `SystemColor` on Linux

- **Source:** `retest/dart_ui/system_color_palette_test.dart`
  (Index 16).
- **Symptom.** `SystemColor.*` lookups return null on the Linux
  desktop test harness; downstream painting fails because the
  bridged engine does not expose system-palette colours on this
  platform. Already gated in
  `generator_interpreter_retest_test.dart:74` with
  `skip: Platform.isLinux ? 'SystemColor not supported on Linux'`.
- **Underlying trigger.** Flutter's `SystemColor` API is a thin
  wrapper around the host platform's accessibility colour
  service. Linux desktop harnesses ship without this service in
  CI.
- **Why not interpreter-fixable.** The interpreter is faithfully
  forwarding `null` from the bridged platform channel. Returning
  fabricated colours would make the test green on a lie.
- **Workaround.** Keep the platform skip. When authoring fresh
  scripts that touch `SystemColor`, gate on `Platform.isLinux`
  (and other platforms without the service) and assert the
  fallback path the production code takes.

---

## `State.setState` during scheduler frame phases (C20d)

- **Sources.** Multiple deep-demo scripts that drive animation
  controllers from inside `paint`, `performLayout`, or transient
  callbacks (catalogued under C20d in
  `doc/testlog_20260427-1339-post-c22/error_analysis.md`).
- **Symptom.** `setState() or markNeedsBuild() called when widget
  tree was locked.` The script invokes `setState` from a paint /
  layout / transient callback site, which Flutter's scheduler
  prohibits.
- **Underlying Dart/Flutter trigger.** Flutter's scheduler keeps
  the widget tree locked during build, layout, paint, and
  transient frame phases. `State.setState`'s assertion fires when
  any of those phases is active. This is a hard contract.
- **Why not interpreter-fixable.** Although the interpreter ships
  a behavioural workaround in `StateUserBridge.overrideMethodSetState`
  that defers `setState` to the next post-frame callback when
  invoked mid-frame, the deferral is an interpreter-side mitigation
  for *runtime safety*, not a contract-level fix. The script is
  still violating the framework contract; the deferral merely
  prevents the assertion from corrupting the rest of the test.
- **Workaround.** Schedule the state change with
  `WidgetsBinding.instance.addPostFrameCallback((_) =>
  setState(...))`, or refactor the trigger to a gesture / timer
  callback that runs outside frame phases. Same observable test
  output, no scheduler violation.

---

## `RestorableProperty.value` accessed in `initState` (D3)

- **Sources.** D3-affected scripts in
  `doc/testlog_20260427-1339-post-c22/error_analysis.md` that
  read `restorableController.value` before `restoreState` has
  run.
- **Symptom.** `RestorableProperty has no value yet. Did you
  forget to call registerForRestoration?` thrown from the
  property's getter on the first build path.
- **Underlying Dart/Flutter trigger.** Flutter's restoration
  framework requires `registerForRestoration(this, 'id')` to run
  before any `value` read, and that registration happens inside
  `restoreState`, which runs *after* `initState`. Reading the
  value during `initState` (e.g., to seed a `TextEditingController`)
  hits a deliberately empty container.
- **Why not interpreter-fixable.** The "no value yet" guard is
  enforced inside the bridged native `RestorableProperty`. The
  interpreter cannot pre-populate it without lying about the
  restoration phase.
- **Workaround.** Initialise the controller with the literal
  default the property would carry (e.g.,
  `TextEditingController(text: '')`), and update it from the
  restored value inside `restoreState` once registration has
  succeeded. Same observable test output, contract-clean.

---

## Layout cascade — `Column`+`Expanded` in unbounded parent (D6/E2)

- **Sources (18 scripts).** D6 and E2 in
  `doc/testlog_20260427-1339-post-c22/error_analysis.md`, e.g.
  `widget_test.dart`, `scroll_position_types_test.dart`,
  `restorable_bool_test.dart`, …
- **Symptom.** Recurring framework errors during `build`/`layout`
  — `BoxConstraints forces an infinite height.`, `RenderBox was
  not laid out: … NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`, the
  `!childSemantics.renderObject._needsLayout` assertion at
  `rendering/object.dart` line 5737, plus negative-minimum-height
  and `RenderShrinkWrappingViewport does not support returning
  intrinsic dimensions` variants. The suites pass; the noise is
  cosmetic.
- **Underlying Dart/Flutter trigger.** Real Flutter layout
  protocol — the script places a `Column` containing `Expanded`
  children inside an unbounded-height parent
  (`SingleChildScrollView`, a `LayoutBuilder` returning a sliver,
  or a `Row` with `mainAxisSize: max`). Flutter's `RenderFlex`
  requires a bounded main-axis extent when any child is
  `Expanded`, and an unbounded parent breaks that contract. The
  interpreter is faithfully forwarding the framework's
  assertion.
- **Why not interpreter-fixable.** The constraint chain is
  computed entirely inside Flutter's `RenderObject` layout
  protocol. Patching the interpreter to silence the assertion
  would mask real bugs in user widgets.
- **Workaround (C22 ListView-replacement pattern).** Drop the
  `SingleChildScrollView`, drop the outer `Column`, list the
  section widgets directly as `ListView` children, and either
  remove `Expanded` or wrap the section's content in
  `SizedBox(height: …)`. Same functional behaviour (scrollable
  test panel with multiple sections), no infinite-constraint
  propagation. The negative-minimum variant additionally needs
  `clamp(0.0, double.infinity)` on the computed height. One
  commit per script, single-suite retest.

---

## `Row(crossAxisAlignment: stretch)` + `Expanded` in `SliverToBoxAdapter` (C3)

- **Source:** `widgets/scroll_deceleration_rate_test.dart` (8
  framework errors; bisected to `_TelemetryRow.build()` lines
  828–858 and `_CoastCurves.build()` lines 1083–…).
- **Symptom (cluster of 8 entries from one cascade):**
  1. `BoxConstraints forces an infinite height.` reported by
     `ChildLayoutHelper.layoutChild` with constraints
     `BoxConstraints(0.0<=w<=Infinity, h=Infinity)`.
  2. `RenderBox was not laid out: RenderFlex#…` (`hasSize`
     assertion at `box.dart:2251`).
  3. `RenderBox was not laid out: RenderPadding#…` (same
     assertion).
  4. Five `Null check operator used on a null value` entries
     from the framework's post-failure walk over half-laid-out
     boxes.
- **Underlying Dart/Flutter trigger.** The script puts a
  `Padding > Row(crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [Expanded(...), SizedBox(width: 14), Expanded(...)])`
  inside a `SliverToBoxAdapter` child of a `CustomScrollView`.
  `SliverToBoxAdapter` gives its child bounded width but
  **unbounded height**. `crossAxisAlignment: stretch` asks the
  cross-axis (vertical) extent to match the parent's — which is
  `Infinity` — so each `Expanded` child receives
  `BoxConstraints(0..w, h=Infinity)` and the layout-helper
  assertion fires before the `RenderFlex` settles a height. From
  there the half-finished render tree trips a chain of
  `RenderBox was not laid out` and null-check noise.
- **Why not interpreter-fixable in isolation.** Two script-side
  workarounds were tried in
  `doc/testlog_20260427-c3/c3_after_intrinsic.log.txt` and
  `…/c3_after_no_stretch.log.txt`; both **increased** the error
  count from 8 to 11. Both attempts were reverted; the script
  remains at the 8-error baseline cascade. A durable interpreter
  fix exists in the layout/intrinsics path for `Row` + `Expanded`
  under unbounded cross-axis constraints — see
  `interpreter_unfixable.md` "render_animated_size_state 2.0 px
  overflow" for the related interpreter-side intrinsic-pass
  audit. Until that lands, the layout cascade is best avoided by
  authoring the script differently.
- **Functional workaround (when authoring fresh scripts).** Avoid
  the `Row(crossAxisAlignment: stretch) + Expanded` pattern
  inside `SliverToBoxAdapter` (or any vertically-unbounded
  parent). Two equivalent ways to keep the visual layout:
  1. Pin a finite height on the row's parent —
     `SizedBox(height: <intrinsic>, child: Row(... Expanded ...))`
     — so cross-axis stretch resolves against a bounded value.
  2. Replace `Expanded` with explicit `SizedBox(width: …)`
     children and drop `crossAxisAlignment: stretch`; if matched
     heights are required, give each card the same `height:`
     constant. Either keeps the rendered output identical.

---

## `BorderRadius` shorthand vs uniform-corner constraint (E5)

- **Source:** `widgets/widgets_binding_observer_test.dart` (3
  framework errors, post-c22 baseline; re-confirmed in
  `testlog_20260428-1333-issue-analysis`).
- **Symptom.** `A borderRadius can only be given for a uniform
  Border.` thrown during `BoxDecoration.paint` when the script
  combines a non-uniform `Border` (different sides) with a
  non-zero `BorderRadius`.
- **Underlying Dart/Flutter trigger.** Flutter's `BoxDecoration`
  paint path asserts that a `borderRadius` is only meaningful
  when every side of the `Border` has the same width and style.
  Mixing per-side `Border` declarations with a `borderRadius` is
  a contract violation.
- **Why not interpreter-fixable.** The assertion is enforced
  inside `BoxDecoration.paint`. The interpreter cannot relax it
  without producing a visually incorrect frame.
- **Workaround.** Either drop the per-side `Border` and use
  `Border.all(color, width)` so the radius applies uniformly, or
  drop the `borderRadius` and keep the per-side border. If the
  test specifically wants both, switch to `ShapeDecoration` with
  a `RoundedRectangleBorder` whose `side` is uniform. Same
  rendered output, no contract violation.

---

## `whereType<T>()` does not filter nulls in d4rt stdlib (E7)

- **Source:** `widgets/restorable_double_n_test.dart` (1 framework
  error, only reproducible inside the `hr5` suite chain
  `restorable_bool_n` → `restorable_change_notifier` →
  `restorable_date_time_n` → `restorable_double_n`; standalone the
  script is FE-free, see
  `doc/testlog_20260428-e7-fix/e7_bisect_pre.log.txt` vs
  `e7_bisect_pre_chain.log.txt`).
- **Symptom.** `Unimplemented Error: Compound assignment operator
  += not handled for types double and null` raised inside the
  `_averageLogged` getter on the `+= v` site, where `v` originates
  from `_allDays.map((d) => d.value).whereType<double>().toList()`
  with `RestorableDoubleN(null)` entries in `_allDays`.
- **Underlying d4rt limitation.** The stdlib bridge for
  `Iterable.whereType` discards the generic type argument:

  ```dart
  // tom_d4rt/lib/src/stdlib/core/iterable.dart:177
  'whereType': (visitor, target, positionalArgs, namedArgs, _) {
    return (target as Iterable).whereType();
  },
  ```

  The same shape is repeated for `List`, `Set`, `HashSet`, `Runes`,
  and `Uint8List`. Because `whereType()` (no type argument) is
  equivalent to `whereType<dynamic>()`, it never filters anything
  out — every element of the source iterable, including `null`, is
  passed through. The receiving `for (final double v in logged)`
  loop in d4rt does not statically refuse the null assignment, so
  the null reaches `sum += v` as the right-hand side and the
  compound-assignment dispatcher hits its unimplemented arm
  (`double += null`).
- **Why this is interpreter-architectural, not a quick fix.**
  Propagating the generic argument from the call site to the
  stdlib adapter would require generic type tracking in
  `BridgedClass` method dispatch — a cross-cutting change that
  touches every bridged generic method (`whereType`, `cast`,
  `whereType` variants on every collection, plus `cast`
  equivalents). It also overlaps with the broader limitation
  documented in `interpreter_unfixable.md` for generic stdlib
  methods. The case is tracked there as a wider follow-up.
- **Why the chain matters.** Standalone, the script's first
  `_averageLogged` evaluation runs in a freshly-cleared
  interpreter and the `_allDays` `RestorableDoubleN(null)`
  entries' `value` getter happens to return a non-null sentinel
  (engine default) before restoration completes, so the loop
  computes against numeric values only. After the chain warm-up,
  the prior `restorable_*` scripts leave the interpreter in a
  state where `RestorableDoubleN(null).value` returns `null`
  promptly, exposing the unfiltered `whereType` path.
- **Workaround.** Replace the chained `.map(...).whereType<T>().toList()`
  with explicit null-guarded accumulation:

  ```dart
  final List<double> logged = <double>[];
  for (final RestorableDoubleN d in _allDays) {
    final double? v = d.value;
    if (v != null) {
      logged.add(v);
    }
  }
  ```

  Same semantics, no reliance on the d4rt-eroded
  `whereType<double>()` filter.

---

## `RangeSlider` with `onChanged: null` + default M3 gapped track shape (Index 32)

- **Source:** `material/gapped_range_slider_track_shape_test.dart`
  (41 lines).
- **Symptom.** Multiple null-related errors (`Null check operator
  used on a null value`, null-receiver method invocations) thrown
  during the slider track painting code path. Stack frames land
  inside Flutter's `RangeSlider` / `RangeSliderTrackShape.paint`,
  not in script-controlled code, which originally led the issue
  to be classified as a framework null path in
  `interpreter_unfixable.md`.
- **Underlying Dart/Flutter trigger.** The script renders a
  `RangeSlider(values: range, min: 0, max: 1, onChanged: null)`
  inside the default Material 3 `SliderTheme`. Material 3
  resolves the default `rangeTrackShape` to
  `GappedRangeSliderTrackShape`, whose `paint` method walks the
  active / inactive segment colours via the slider's enabled
  state. With `onChanged: null` the slider is disabled, and the
  gapped shape's paint path follows a branch that — in the
  combination of theme defaults the script picks up — reads a
  `MaterialStateProperty` value that resolves to `null`. The
  null then propagates into the painter and surfaces as the
  observed null-deref cluster.
- **Why this is script-side, not interpreter-side or framework-bug.**
  The contract that `RangeSlider`'s gapped track shape paints
  cleanly is satisfied for *enabled* sliders with a fully
  populated theme; passing `onChanged: null` is the
  documented-but-edge-case "disabled slider" path. The native
  Flutter behaviour for this exact shape (disabled +
  gapped-default + minimal theme) hasn't been bisected against a
  vanilla `flutter test` run; until that bisect proves a genuine
  framework bug (which would then go upstream as a
  `flutter/flutter` issue), the symptom is best treated as a
  script contract violation: the script writer chose a
  combination that Flutter doesn't fully support in M3 defaults.
- **Workaround.** Three low-cost rewrites that preserve the
  script's intent (rendering a `GappedRangeSliderTrackShape`
  preview):
  1. **No-op `onChanged`** — pass
     `onChanged: (RangeValues _) {}` so the slider stays enabled.
     The test app doesn't drive interactions; the no-op handler
     keeps the contract intact.
  2. **Wrap in `IgnorePointer`** — keep `onChanged` non-null but
     wrap the `RangeSlider` in `IgnorePointer` to disable input
     while leaving the painter on the enabled code path.
  3. **Override the track shape explicitly** —
     `SliderTheme(data: SliderTheme.of(context).copyWith(
     rangeTrackShape: const GappedRangeSliderTrackShape()), …)`
     — which forces the gapped shape regardless of M3 defaults
     and ensures the surrounding theme tokens the painter needs
     are populated.
  Option 1 is the smallest edit and the recommended path.
- **Open verification step.** Before declaring this fully
  closed, the script should be reproduced under vanilla
  `flutter test` (no interpreter) with `onChanged: null` to
  confirm the same null-deref fires natively. If it does not,
  the entry returns to interpreter-side investigation. If it
  does, file the case upstream (Flutter GitHub) and apply
  workaround 1.

---

## `FragmentProgram` engine cascade in multi-test suites

- **Source:**
  `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/dart_ui/image_sampler_slot_test.dart`
- **Symptom.** When run as part of `hardly_relevant_classes_1_test`,
  the test itself completes (`status=success frameworkErrors=0`),
  but every subsequent script in the same suite (124 scripts:
  remaining `dart_ui/*` + all `gestures/*`) times out at the
  30-second per-script limit. After ~12 minutes the runner enters
  a `clear_failed` cascade with `clearMs=735219`.
- **Underlying Dart/Flutter trigger.** `ui.FragmentProgram` /
  `ui.FragmentShader` engine pipeline initialisation on the Linux
  test harness leaves the test app process in a state where the
  next HTTP-driven test cannot start. The earlier resolved entry
  in `interpreter_issues.md` ("FragmentProgram / FragmentShader
  timing race") added `await Future<void>.delayed(Duration.zero)`
  so the *current* script finishes cleanly, but the engine
  destabilisation persists across the *suite* boundary into the
  next test. The bisect verification (`bisect_test.dart`) only
  exercises the one-script path and so missed the suite-level
  cascade. Reference: Flutter issue tracker on FragmentProgram +
  Linux desktop test harness.
- **Why not interpreter-fixable.** The hang is in the engine's
  GPU / Skia pipeline teardown, after the interpreter has already
  returned `status=success`. No interpreter or bridge change can
  reach into the engine's internal pipeline state.
- **Workaround.** Either (a) skip
  `dart_ui/image_sampler_slot_test.dart` from the
  `hardly_relevant_classes_1_test` script list and run it in a
  dedicated single-script suite, or (b) tear down + re-spawn the
  test app process after the script. Option (a) is the
  lowest-risk and is the recommended path: removing this one
  entry from the suite list eliminates all 124 cascading
  timeouts. Functional coverage is preserved because the script
  still runs, just in isolation.

---

## Resolved entries (kept for history)

The following entries were once tracked here and have been
**resolved by interpreter improvements** between post-c22 and
`testlog_20260428-1333-issue-analysis` without any script edit.
Their bytes did not change between runs; the framework-error
count went from non-zero to zero. They are removed from the
active list above and recorded here for traceability.

| Former entry | Source | Status as of 2026-04-28 |
|---|---|---|
| D8g `RawTooltipState` is a `SingleTickerProviderStateMixin` but multiple tickers were created | `widgets/two_dimensional_child_list_delegate_test.dart` | Resolved — `frameworkErrors=0` (was 2) |
| D8h `SemanticsData` object had a null `textDirection` | `rendering/custom_painter_semantics_test.dart` | Resolved — `frameworkErrors=0` (was 1) |

If either symptom resurfaces, restore the corresponding section
from the git history (commit before 2026-04-28 evening) and
treat as an active script-rewrite case again.

---

## Change Log

- **2026-04-28 (latest):** Added Index 32
  `gapped_range_slider_track_shape_test.dart`, migrated from
  `interpreter_unfixable.md` per user assessment that the
  null-deref pattern is most consistent with a script-side
  contract violation (`onChanged: null` with the M3 default
  gapped track shape) rather than a true framework null path.
  Workaround 1 (no-op `onChanged`) is the recommended edit. Open
  verification step: reproduce under vanilla `flutter test` to
  confirm.
- **2026-04-28 (evening):** Restructured into a single index of
  active script-rewrite cases. **Added** the script-rewriteable
  cases moved out of `interpreter_unfixable.md` (enum
  exhaustiveness × 15, `SystemColor` Linux platform guard, C20d
  `State.setState` mid-frame, D3 `RestorableProperty.value` in
  `initState`, D6/E2 layout cascade, E5 non-uniform border-radius).
  **Removed** D8g `RawTooltipState` multi-ticker
  (`two_dimensional_child_list_delegate_test.dart`) and D8h
  `SemanticsData` null `textDirection`
  (`custom_painter_semantics_test.dart`) — both verified at
  `frameworkErrors=0` in `testlog_20260428-1333-issue-analysis`
  with no script edits, so they belong in the resolved-history
  appendix rather than the active list.
- **2026-04-27:** Initial post-c22 set added — `image_sampler_slot`
  engine cascade, D6 layout cascade, D8g multi-ticker, D8h
  semantics textDirection, C3 `Row(stretch)` + `Expanded` inside
  `SliverToBoxAdapter`.
