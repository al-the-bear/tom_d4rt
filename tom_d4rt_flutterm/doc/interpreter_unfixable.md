# Interpreter Unfixable Issues

This document catalogs interpreter-level issues that cannot be fixed within the current interpreter architecture or are not actually interpreter issues (platform limitations, etc.).

## Summary

| Index | Source | Category | Workaround |
|-------|--------|----------|------------|
| 13 | `color_space_test.dart` | Enum exhaustiveness | Add default case |
| 16 | `system_color_palette_test.dart` | Platform capability | Add platform guard |
| 25 | `button_bar_layout_behavior_test.dart` | Enum exhaustiveness | Add default case |
| 27 | `button_text_theme_test.dart` | Enum exhaustiveness | Add default case |
| 30 | `dropdown_menu_close_behavior_test.dart` | Enum exhaustiveness | Add default case |
| 32 | `gapped_range_slider_track_shape_test.dart` | Framework null errors | Not script-fixable |
| 34 | `hour_format_test.dart` | Enum exhaustiveness | Add default case |
| 36 | `material_banner_closed_reason_test.dart` | Enum exhaustiveness | Add default case |
| 38 | `navigation_destination_label_behavior_test.dart` | Enum exhaustiveness | Add default case |
| 40 | `navigation_rail_label_type_test.dart` | Enum exhaustiveness | Add default case |
| - | `popup_menu_position_test.dart` | Enum exhaustiveness | Add default case |
| - | `axis_direction_test.dart` | Enum exhaustiveness | Add default case |
| - | `hit_test_behavior_test.dart` | Enum exhaustiveness | Add default case |
| - | `render_android_view_test.dart` | Enum exhaustiveness | Add default case |
| - | `vertex_mode_test.dart` | Enum exhaustiveness | Add default case |
| - | `live_text_input_status_test.dart` | Enum exhaustiveness | Add default case |
| - | `lock_state_test.dart` | Enum exhaustiveness | Add default case |

---

## Framework-Level Null Errors

These issues produce null-related errors that originate deep within Flutter framework code paths, not in the test script itself.

### Index 32: GappedRangeSliderTrackShape null errors

- **Source:** `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/gapped_range_slider_track_shape_test.dart`
- **Symptom:** Multiple null-related errors during slider track painting operations
- **Root cause:** Framework-level code path where axis/value transformation produces null receivers that flow into subsequent method invocations. The errors occur in internal painting logic, not script-controllable code.
- **Not script-fixable:** The null values emerge from framework transformations; script workarounds cannot intercept or guard them.

---

## Enum Exhaustiveness Issues

### Background

Dart's exhaustive switch checking for sealed classes and enums is a compile-time feature that relies on static analysis. The D4rt interpreter evaluates switch expressions at runtime without the static knowledge of which enum members exist (bridged enum values lack exhaustiveness metadata).

**Why unfixable:**
- Exhaustive switch evaluation requires compile-time type system knowledge
- Bridged enum values are runtime objects without exhaustiveness contracts
- Adding complete runtime exhaustiveness checking would require significant interpreter architecture changes

**Workaround:** Add a `default:` case to all enum switches in D4rt scripts.

---

### Index 13: ColorSpace enum switch

- **Source:** `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/dart_ui/color_space_test.dart`
- **Symptom:** `Unsupported target for indexing: null` during enum-backed info rendering
- **Root cause:** Script logic assumes exhaustive enum mapping via helper function. When interpreter fails to match enum branch, returns null which causes indexing failure.
- **Workaround:** Modify `_colorSpaceInfo` to include default fallback handling for unmatched enum values.

### Index 30: DropdownMenuCloseBehavior enum switch

- **Source:** `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/dropdown_menu_close_behavior_test.dart`
- **Symptom:** Non-exhaustive enum switch at runtime (`DropdownMenuCloseBehavior.all`)
- **Root cause:** Bridged `DropdownMenuCloseBehavior` values reach switch evaluation without complete exhaustiveness mapping, causing runtime mismatch.
- **Workaround:** Add `default:` case to switch statements or use map-based lookup instead of switch.

### Index 25: ButtonBarLayoutBehavior enum switch (manifests as null `>` comparison)

- **Source:** `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/button_bar_layout_behavior_test.dart`
- **Symptom:** `'>' called on null` — error message misleading; actual cause is enum exhaustiveness
- **Root cause:** `bbMinHeight()` function uses exhaustive switch on `ButtonBarLayoutBehavior`. When interpreter fails to match bridged enum value, switch returns null. Code then performs `height > 0` comparison, which fails on null.
- **Code path:**
  ```dart
  double bbMinHeight(ButtonBarLayoutBehavior behavior) {
    switch (behavior) {
      case ButtonBarLayoutBehavior.constrained: return 52.0;
      case ButtonBarLayoutBehavior.padded: return 0.0;
    }
  }
  // Later: height > 0 fails because height is null
  ```
- **Workaround:** Add `default:` case returning a fallback value (e.g., `default: return 0.0;`).

### Index 27: ButtonTextTheme enum switch (manifests as null property access)

- **Source:** `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/button_text_theme_test.dart`
- **Symptom:** `Cannot access property 'value' on target of type null`
- **Root cause:** `btResolveColor()` function uses exhaustive switch on `ButtonTextTheme`. When interpreter fails to match, switch returns null. Code then accesses `c.value.toRadixString()` which fails because `c` is null.
- **Code path:**
  ```dart
  Color btResolveColor(ButtonTextTheme theme, Brightness brightness) {
    switch (theme) {
      case ButtonTextTheme.normal: return ...;
      case ButtonTextTheme.accent: return ...;
      case ButtonTextTheme.primary: return ...;
    }
  }
  // Later: c.value fails because c is null
  ```
- **Workaround:** Add `default:` case returning a fallback color (e.g., `default: return Colors.grey;`).

---

---

## Abstract Class Inheritance

### Background

Interpreted classes cannot directly inherit from abstract native classes because the interpreter architecture maintains `bridgedSuperObject` — a native instance of the bridged superclass. For abstract classes like `State`, `StatelessWidget`, or `StatefulWidget`, we cannot instantiate them directly.

**Why it's a limitation:**
- When a D4rt script declares `class _MyState extends State<MyWidget>`, the interpreter creates an `InterpretedClass` with `bridgedSuperclass = StateBridge`
- During constructor execution, the implicit `super()` call would normally create a native instance and store it in `bridgedSuperObject`
- For abstract classes, the constructor lookup fails (empty `constructors: {}`) 
- `bridgedSuperObject` remains null, breaking access to inherited properties like `widget`, `setState`, `context`

**Solution Architecture:**

For abstract framework classes (State, StatelessWidget, StatefulWidget), the interpreter uses **adapter proxies** instead of direct bridged super objects:

1. **Interface Proxy Factories** - Registered via `D4.registerInterfaceProxy()` for each abstract class
2. **Native Adapter Classes** - E.g., `_InterpretedState`, `_InterpretedStatelessWidget` that:
   - Extend the real abstract class
   - Hold a reference to the `InterpretedInstance`
   - Delegate abstract methods (build, createState) to the interpreted class
   - Provide access to superclass properties (widget, setState) via their native implementation
3. **nativeProxy Field** - The InterpretedInstance stores its adapter in `nativeProxy`
4. **Property Resolution** - `InterpretedInstance.get()` uses `nativeProxy` as fallback when `bridgedSuperObject` is null
5. **Property Interceptors** - Registered via `D4.registerPropertyInterceptor()` to intercept property access and return interpreted instances instead of native wrappers (e.g., `widget` property on State)

**Property Interceptor Pattern:**

For properties that need to return the original `InterpretedInstance` instead of a native wrapper object, the adapter implements an interface with a getter:

```dart
abstract class InterpretedStateProxy {
  InterpretedInstance get interpretedWidget;
}
```

Then register an interceptor:

```dart
D4.registerPropertyInterceptor('State', (instance, propertyName, nativeProxy, ...) {
  if (propertyName == 'widget' && nativeProxy is InterpretedStateProxy) {
    return InterceptedValue(nativeProxy.interpretedWidget);
  }
  return null; // Fall through to normal handling
});
```

See the [Advanced Bridging User Guide](../../tom_d4rt/doc/advanced_bridging_user_guide.md#rc-9-property-interceptors) for the complete RC-9 documentation.

**Classes requiring adapters:**
- `State<T>` - Framework state management base class
- `StatelessWidget` - Immutable widget base class  
- `StatefulWidget` - Stateful widget base class
- Similar patterns for `ChangeNotifier`, `Listenable` etc.

The adapter pattern is implemented in `d4rt_runtime_registrations.dart` (proxies and interceptors) and integrated with the `InterpretedInstance.get()` method in `runtime_types.dart`.

---

## Behavioural Deviations from Real Flutter

### C20d — `State.setState` deferral when called mid-frame

- **Source:** `rendering/render_box_container_defaults_mixin_test.dart`,
  `rendering/render_custom_paint_test.dart` (and any script that calls
  `setState` from `RenderBox.performLayout`, `paint`, or
  `hitTestChildren`).
- **Symptom (pre-fix):** Framework error
  `Native error in bridged superclass method 'State.setState': Build
  scheduled during frame.` — Flutter throws when a rebuild is requested
  while it is laying out / painting the current frame.
- **Root cause:** The driving scripts wire RenderBox lifecycle hooks
  (performLayout / paint / hitTestChildren) to `_emitSnapshot()`
  callbacks that bubble up through interpreted State and call
  `setState`. In real Flutter the same pattern would also throw — these
  scripts intentionally exercise patterns Flutter forbids.
- **Workaround in the bridge:**
  `lib/src/d4rt_user_bridges/state_user_bridge.dart` overrides the
  generated `State.setState` adapter. When
  `SchedulerBinding.instance.schedulerPhase` is
  `transientCallbacks`, `midFrameMicrotasks`, or
  `persistentCallbacks` (i.e. the framework is mid-frame), the
  callback is deferred to
  `WidgetsBinding.instance.addPostFrameCallback` instead of being
  executed synchronously. Outside those phases, behaviour is identical
  to the auto-generated bridge.
- **Behavioural deviation:** Real Flutter throws; the bridge defers.
  Scripts that rely on the synchronous throw to short-circuit will see
  the rebuild applied on the next frame instead. No tests in the
  current corpus depend on the throw, so the deviation is benign.
- **Script-level fix that removes the need for the workaround:**
  Use `LayoutBuilder` / `CustomSingleChildLayout` / `CustomMultiChildLayout`
  for layout-derived state, or call
  `WidgetsBinding.instance.addPostFrameCallback((_) => setState(...))`
  directly from the layout / paint hook. With either pattern the bridge
  takes the synchronous path and the deviation is invisible.

---

## Change Log

- 2026-04-27: Add C20d behavioural-deviation entry for the
  `StateUserBridge.overrideMethodSetState` workaround that defers
  `setState` calls made during layout / paint / transient callbacks.
- 2026-04-27: Add four script-side / engine-platform cases from `testlog_20260427-1339-post-c22` (image_sampler_slot engine cascade, layout-cascade D6, multi-ticker D8g, semantics textDirection D8h)
- 2025-04-13: Add property interceptor mechanism (RC-9) for generic externalized property handling
- 2025-04-13: Document abstract class inheritance limitation and adapter proxy solution
- 2025-01-21: Add 7 more enum exhaustiveness fixes (popup_menu_position, axis_direction, hit_test_behavior, render_android_view, vertex_mode, live_text_input_status, lock_state)
- 2025-01-21: Add index 32 (framework null errors), 34, 36, 38, 40 (enum exhaustiveness)
- 2025-01-21: Initial document with issues 13, 16, 30 documented

---

## Cases from `testlog_20260427-1339-post-c22`

The following four cases surfaced (or re-surfaced) in the post-C22 run.
They are documented here because the actual underlying trigger is in
the Flutter framework / engine or in the test script's authoring, not
in the interpreter — so a "fix" is a workaround on the consuming side,
not an interpreter change.

### `dart_ui/image_sampler_slot_test.dart` — FragmentProgram engine cascade in multi-test suites

- **Source:** `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/dart_ui/image_sampler_slot_test.dart`
- **Symptom:** When run as part of `hardly_relevant_classes_1_test`, the
  test itself completes (`status=success frameworkErrors=0`), but every
  subsequent script in the same suite (124 scripts: remaining `dart_ui/*`
  + all `gestures/*`) times out at the 30-second per-script limit. After
  ~12 minutes the runner enters a `clear_failed` cascade with
  `clearMs=735219`.
- **Underlying Dart/Flutter trigger:** `ui.FragmentProgram` /
  `ui.FragmentShader` engine pipeline initialisation on the Linux test
  harness leaves the test app process in a state where the next
  HTTP-driven test cannot start. The earlier resolved entry in
  `interpreter_issues.md` ("FragmentProgram / FragmentShader timing
  race") added `await Future<void>.delayed(Duration.zero)` so the
  *current* script finishes cleanly, but the engine destabilisation
  persists across the *suite* boundary into the next test. The bisect
  verification (`bisect_test.dart`) only exercises the one-script path
  and so missed the suite-level cascade. Reference: Flutter issue
  tracker on FragmentProgram + Linux desktop test harness; the engine
  side races between pipeline shutdown and the next platform-channel
  request.
- **Why not interpreter-fixable:** The hang is in the engine's GPU /
  Skia pipeline teardown, after the interpreter has already returned
  `status=success`. No interpreter or bridge change can reach into the
  engine's internal pipeline state.
- **Workaround:** Either (a) skip
  `dart_ui/image_sampler_slot_test.dart` from the
  `hardly_relevant_classes_1_test` script list and run it in a
  dedicated single-script suite, or (b) tear down + re-spawn the test
  app process after the script. Option (a) is the lowest-risk and is
  the recommended path: removing this one entry from the suite list
  eliminates all 124 cascading timeouts. Functional coverage is
  preserved because the script still runs, just in isolation.

### Layout cascade — `BoxConstraints forces an infinite height/width` + `RenderBox was not laid out` (D6)

- **Source:** 18 scripts in `secondary_classes_test` and
  `hardly_relevant_classes_5_test` (see D6 in
  `testlog_20260427-1339-post-c22/error_analysis.md` for the full
  list — `widget_test.dart`, `scroll_position_types_test.dart`,
  `restorable_bool_test.dart`, …).
- **Symptom:** Recurring framework errors during `build`/`layout` —
  `BoxConstraints forces an infinite height.`, `RenderBox was not laid
  out: … NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`, the
  `!childSemantics.renderObject._needsLayout` assertion at
  `rendering/object.dart` line 5737, plus negative-minimum-height and
  `RenderShrinkWrappingViewport does not support returning intrinsic
  dimensions` variants. The suite passes; the noise is cosmetic.
- **Underlying Dart/Flutter trigger:** Real Flutter layout protocol —
  the script places a `Column` containing `Expanded` children inside
  an unbounded-height parent (`SingleChildScrollView`, a `LayoutBuilder`
  returning a sliver, or a `Row` with `mainAxisSize: max`). Flutter's
  `RenderFlex` requires a bounded main-axis extent when any child is
  `Expanded`, and an unbounded parent breaks that contract. The
  interpreter is faithfully forwarding the framework's assertion. This
  is identical to the C22 root cause that was already closed for
  `box_hit_test_result_test.dart` in the prior campaign.
- **Why not interpreter-fixable:** The constraint chain is computed
  entirely inside Flutter's `RenderObject` layout protocol. The
  interpreter does not — and should not — alter
  `BoxConstraints`/`performLayout` semantics. Patching the interpreter
  to silence the assertion would mask real bugs in user widgets.
- **Workaround (C22 ListView-replacement pattern):** Drop the
  `SingleChildScrollView`, drop the outer `Column`, list the section
  widgets directly as `ListView` children, and either remove
  `Expanded` or wrap the section's content in `SizedBox(height: …)`.
  Same functional behaviour (scrollable test panel with multiple
  sections), no infinite-constraint propagation. The negative-minimum
  variant additionally needs `clamp(0.0, double.infinity)` on the
  computed height. One commit per script, single-suite retest.

### `RawTooltipState is a SingleTickerProviderStateMixin but multiple tickers were created` (D8g)

- **Source:**
  `widgets/two_dimensional_child_list_delegate_test.dart` (`hr5`).
- **Symptom:** Real Flutter assertion fired during `initState` /
  `_createTicker` of `RawTooltipState`. The script declares
  `with SingleTickerProviderStateMixin` and constructs more than one
  `AnimationController` (each controller takes a `Ticker` from the
  vsync provider).
- **Underlying Dart/Flutter trigger:**
  `SingleTickerProviderStateMixin.createTicker` asserts that the mixed-in
  `State` has produced exactly one ticker for its lifetime
  (`flutter/src/scheduler/ticker.dart`). `TickerProviderStateMixin` is
  the multi-ticker variant. This is a fundamental contract of the
  mixin family.
- **Why not interpreter-fixable:** The assertion is enforced by the
  bridged native `SingleTickerProviderStateMixin`. The interpreter
  cannot change the mixin's contract without forking the framework
  class, which would diverge from Flutter semantics.
- **Workaround:** Replace `with SingleTickerProviderStateMixin` with
  `with TickerProviderStateMixin` in the test script's State class —
  one-token edit. Alternatively, refactor the script to share a single
  `AnimationController` across the animations it drives. Same
  observable test behaviour either way.

### `SemanticsData object … had a null textDirection` (D8h)

- **Source:** `rendering/custom_painter_semantics_test.dart` (gii fail).
- **Symptom:** Flutter framework assertion thrown when a
  `SemanticsConfiguration` carrying a non-empty `label` is finalised
  without a `textDirection` set on the node or any ancestor.
- **Underlying Dart/Flutter trigger:** `SemanticsNode._sanitiseSemanticsUpdate`
  requires `textDirection != null` whenever the node carries text-bearing
  semantic fields (`label`, `value`, `hint`, `tooltip`,
  `decreasedValue`, `increasedValue`). This is a hard
  invariant of Flutter's accessibility tree and is not affected by the
  interpreter.
- **Why not interpreter-fixable:** The assertion is fired by the
  framework after `markNeedsSemanticsUpdate`; the interpreter has no
  hook into semantics-tree finalisation, and silencing the assertion
  would produce an invalid accessibility tree.
- **Workaround:** In the test script, pass
  `textDirection: TextDirection.ltr` (or `.rtl`) on the
  `Semantics`/`SemanticsConfiguration` that owns the `label`, or wrap
  the painter under a `Directionality(textDirection: TextDirection.ltr,
  child: …)` so the implicit lookup succeeds. Same observable test
  output, valid semantics tree.

### `Row(crossAxisAlignment: stretch)` + `Expanded` inside `SliverToBoxAdapter` (C3)

- **Source:** `widgets/scroll_deceleration_rate_test.dart` (8 framework
  errors, post-C22 run). Bisected to `_TelemetryRow.build()` (lines
  828–858) — the same pattern also appears in `_CoastCurves.build()`
  (lines 1083–…).
- **Symptom (cluster of 8 entries from one cascade):**
  1. `BoxConstraints forces an infinite height.` reported by
     `ChildLayoutHelper.layoutChild` with constraints
     `BoxConstraints(0.0<=w<=Infinity, h=Infinity)`.
  2. `RenderBox was not laid out: RenderFlex#…` (`hasSize` assertion at
     `box.dart:2251`).
  3. `RenderBox was not laid out: RenderPadding#…` (same assertion).
  4. Five `Null check operator used on a null value` entries from the
     framework's post-failure walk over half-laid-out boxes.
- **Underlying Dart/Flutter trigger:** The script puts a
  `Padding > Row(crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [Expanded(child: _TelemetryCard…), SizedBox(width: 14),
  Expanded(child: _TelemetryCard…)])` inside a `SliverToBoxAdapter`
  child of a `CustomScrollView`. `SliverToBoxAdapter` gives its child
  bounded width but **unbounded height**. `crossAxisAlignment: stretch`
  asks the cross-axis (vertical) extent to match the parent's — which
  is `Infinity` — so each `Expanded` child receives
  `BoxConstraints(0..w, h=Infinity)` and the layout-helper assertion
  fires before the `RenderFlex` settles a height. From there the
  half-finished render tree trips a chain of `RenderBox was not laid
  out` and null-check noise.
- **Why not interpreter-fixable in isolation:** Two script-side
  workarounds were tried in this run and both **increased** the error
  count from 8 to 11 under d4rt (logs in
  `doc/testlog_20260427-c3/c3_after_intrinsic.log.txt` and
  `…/c3_after_no_stretch.log.txt`):
  1. Wrapping each `Row` in `IntrinsicHeight` so the cross-axis stretch
     resolves to the children's intrinsic height. Under native Flutter
     this is the textbook fix; under d4rt the interpreter's intrinsic
     pass through `_InterpretedSlottedRenderBox` / proxy render-objects
     adds further null-checks rather than removing them.
  2. Dropping `crossAxisAlignment: stretch` (changing it to `.start`).
     This passes constraints with `h=Infinity` removed at the Row level,
     but the children no longer have matched heights and the
     `_TelemetryCard` decorations end up with `null` size readings in
     d4rt's post-layout walk, which produces *more* null-check entries
     than baseline.
  Both attempts were reverted; the script remains at the 8-error
  baseline cascade. The genuine fix lives in the interpreter's
  layout/intrinsics path for `Row` + `Expanded` under unbounded
  cross-axis constraints, not in the script.
- **Functional workaround (when authoring fresh scripts):** Avoid the
  `Row(crossAxisAlignment: stretch) + Expanded` pattern inside
  `SliverToBoxAdapter` (or any vertically-unbounded parent). Two
  equivalent ways to keep the visual layout:
  1. Pin a finite height on the row's parent —
     `SizedBox(height: <intrinsic>, child: Row(... Expanded ...))` —
     so cross-axis stretch resolves against a bounded value.
  2. Replace `Expanded` with explicit `SizedBox(width: …)` children
     and drop `crossAxisAlignment: stretch`; if matched heights are
     required, give each card the same `height:` constant.
  Either keeps the rendered output identical and avoids the
  `BoxConstraints forces an infinite height` cascade entirely.

## Residual `dart:ui/math.dart:14` `clampDouble` assertion in `widgets/slotted_multi_child_render_object_widget_test.dart`

**Status:** Documented residual after C21 close (2026-04-27).

**Symptom.**

```
'dart:ui/math.dart': Failed assertion: line 14 pos 10: '<optimized out>': is not true.
```

Line 14 of `dart:ui/math.dart` is:

```dart
double clampDouble(double x, double min, double max) {
  assert(min <= max && !max.isNaN && !min.isNaN);
  ...
}
```

**Where it triggers.** Deep inside the Flutter framework's paint /
layout pipeline when one of the four specimens in
`_SmcrowSpecimenAllFilled` / `_SmcrowSpecimenIconTitleOnly` /
`_SmcrowSpecimenTrendEmphasis` / `_SmcrowSpecimenActionsForward`
renders. Stack-trace optimisation hides the originating call, but
the only paths in the script that reach Flutter `clampDouble` are:

1. `_SmcrowSparkPainter.paint` — uses `math.min` / `math.max` from
   `dart:math` over `values` and produces `(values[i] - minV) / range
   * (size.height - 4) - 2`. With `values` non-empty, `minV ≤ maxV`
   holds and `range >= 1e-6` is enforced. Output is finite.
2. `_SmcrowDashboardRender.performLayout` — produces `headerH` and
   `dy` from finite components (now that null-shorting is fixed).
   Output is finite for all specimens.
3. `Color.withValues(alpha: 0.14)` — internally clamps the alpha
   channel via `clampDouble` with literal bounds. A literal call
   like `Color(...).withValues(alpha: 0.14)` cannot trip the
   assertion in the engine, but the interpreted variant routing
   through the bridged `Color.withValues` adapter could pass NaN
   if the receiver `color` is null and the script side coerces it
   through `?? const Color(0xFF000000)` after a typed-as-non-null
   field was actually carrying a null in interpreted dispatch.

**Why this isn't fixable in the interpreter directly.** The
assertion fires in the Flutter engine layer (`dart:ui`), not in
interpreter code. The interpreter's role is upstream — it produces
the values that flow into bridged `Color.withValues`,
`Canvas.drawRRect`, `RRect.fromRectAndRadius`, etc. Without an
in-bridge instrumentation pass capturing every numeric argument
crossing the bridge boundary on this script, narrowing the exact
trigger requires either adding native-side asserts inside the
generated `*.b.dart` adapters (forbidden by the "fix the
generator, not the generated code" rule) or adding a
generator-level numeric-argument logger gated by an env flag.

**Pre-existing in baseline.** The same `dart:ui/math.dart:14`
assertion is present in the post-C22 baseline test logs
(`hardly_relevant_classes_5_test.log.txt:500`,
`hardly_relevant_classes_5_test.result.json:545`,
`secondary_classes_test.result.json` etc.) — i.e., it surfaces in
multiple scripts that exercise paint of bridged `Color.withValues`
or stroked paths under interpreter dispatch, not only in this
specimen. Marking C21 fixed because the C21-specific cascade
(null-shorting through `?.` chains that cause the slotted layout
to throw "Cannot access property 'height' on null") is closed, and
the residual is a pre-existing class of downstream Flutter
assertion that needs its own targeted instrumentation pass.

**Vanilla Dart trigger.** Reproducible in vanilla Dart only by
constructing a `Color.withValues(alpha: <NaN-or-out-of-range>)`
call, e.g.:

```dart
Color(0xFF112233).withValues(alpha: double.nan); // asserts in dart:ui clampDouble
```

In the interpreted slotted test, the trigger is one of the
several `withValues(alpha: <literal>)` / canvas-clamp paths
listed above where the bridged numeric argument is produced from
an interpreted-side computation that can be NaN/Infinity in some
slot-population permutations.

**Functional workaround (when authoring scripts).** When a
`Color.withValues(alpha: …)` argument may have been computed
through a chain that could produce NaN (e.g., `0 / 0` in a
sparkline where all values are equal and the `range` guard
inherited from a stale earlier paint state is bypassed), guard at
the script call site:

```dart
double safe(double v) => v.isNaN || v.isInfinite ? 0.0 : v;
final alpha = safe(computedAlpha).clamp(0.0, 1.0);
Color(0xFF112233).withValues(alpha: alpha);
```

This keeps the script identical in behaviour for valid inputs and
avoids the engine-level assertion when a degenerate input slips
through.

## D3 — Reading `RestorableProperty.value` in `initState()` before `restoreState()` registers it

**Status.** Not an interpreter bug — script authoring contract.
This pattern fails in plain Flutter for the same reason; the
interpreter was correct to surface it (the `LateInitializationError`
that previously masked the cause was a downstream consequence, see
the matching D3 entry in
`doc/testlog_20260427-1339-post-c22/error_analysis.md`).

**The Dart/Flutter code that triggers the problem.** A
`State` with `RestorationMixin` declares one or more
`RestorableProperty` fields and constructs a controller in
`initState()` whose argument depends on the property's `.value`:

```dart
class _MyState extends State<MyWidget> with RestorationMixin {
  final RestorableString _playerName = RestorableString('Player 1');
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    // BUG: reading _playerName.value here asserts `isRegistered`
    // because registerForRestoration runs later, in restoreState().
    _nameController = TextEditingController(text: _playerName.value);
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_playerName, 'player_name');
    _nameController.text = _playerName.value; // safe — registered
  }

  @override
  String get restorationId => 'my_state';
}
```

The framework's call order is `initState()` first, then
`didChangeDependencies()` (which calls `restoreState()` from
`RestorationMixin`). At the `initState()` call site, the property has
not yet been registered; `RestorableProperty.value` calls
`assert(isRegistered)` and throws. In a script that catches the
exception (e.g., the `_callVoidMethod` lifecycle dispatcher in the
interpreter, or any `try/catch` in user code) the controller
assignment is skipped and a later `_nameController.<member>` read
surfaces as `LateInitializationError`, masking the real cause.

**Functional workaround (when authoring scripts).** Initialise
controllers in `initState()` with the same literal default the
`RestorableProperty` was constructed with. Let `restoreState()` sync
the controller to the restored value once registration has succeeded:

```dart
@override
void initState() {
  super.initState();
  // Use the default that matches RestorableString('Player 1') above.
  _nameController = TextEditingController(text: 'Player 1');
}

@override
void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
  registerForRestoration(_playerName, 'player_name');
  _nameController.text = _playerName.value; // restored value lands here
}
```

For `RestorableStringN(null)` / `RestorableValue<T?>(null)` style
defaults, the literal collapses to `''` (or whatever default the
controller accepts), e.g.:

```dart
final RestorableStringN _feedback = RestorableStringN(null);
late final TextEditingController _feedbackCtrl;

@override
void initState() {
  super.initState();
  _feedbackCtrl = TextEditingController()..addListener(_onFeedbackChanged);
}

@override
void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
  registerForRestoration(_feedback, 'feedback');
  _feedbackCtrl.removeListener(_onFeedbackChanged);
  _feedbackCtrl.text = _feedback.value ?? '';
  _feedbackCtrl.addListener(_onFeedbackChanged);
}
```

This preserves the script's observable behaviour — fresh sessions
start with the literal default, restored sessions get hydrated in
`restoreState()` — and is the pattern the Flutter SDK itself uses in
its `RestorableProperty` examples.

---

## Cases from `testlog_20260428-1333-issue-analysis`

This run produced zero true test failures across `essential`,
`important`, `secondary`, `hr1`–`hr5`, `interactive`, and `gii`
(2127 / 2128 tests passing — single skip in `secondary` is a
documented `IsolateNameServer` skip). The `gir` suite reported 24
"errors", of which 4 are real failures and 20 are W4 transport-
cascade victims.

The cases below cannot be fixed at the interpreter level, and the
documented workaround is the only reliable path forward.

### E2 — Layout-cascade FE (16 scripts) — script-side `ListView` workaround

**Why unfixable at the interpreter.** The leading exceptions
(`BoxConstraints forces an infinite height/width`, `BoxConstraints
has a negative minimum height`, `RenderShrinkWrappingViewport does
not support intrinsic dimensions`, `RenderParagraph object was
given an infinite size during layout`, `RenderFlex overflowed by N
pixels on the bottom`) are emitted by Flutter's render tree when
the deep-demo widget shape combines `SingleChildScrollView` +
`Column` + `Expanded` (or similar unbounded-height + viewport-
intrinsic patterns). The interpreter is faithfully driving the
script's widget tree; the cascade is a property of the demo
widget shape, not of the interpreter.

These scripts pass at the suite level (no `tester.takeException`
assertion). They appear as `[METRIC] frameworkErrors=N` lines and
do not block any test. We document them here as the canonical
"FE noise that is not interpreter-rooted".

**Workaround pattern (C22 — established 2026-04-26).** Replace
the unbounded-scroll-with-Column-and-Expanded shape with a
`ListView` that owns its own scroll axis and intrinsic constraints:

```dart
// Before — produces "BoxConstraints forces an infinite height"
SingleChildScrollView(
  child: Column(
    children: [
      Header(),
      Expanded(child: Body()),  // unbounded inside scroll
      Footer(),
    ],
  ),
)

// After — ListView constrains each child's main-axis extent
ListView(
  children: [
    Header(),
    Body(),
    Footer(),
  ],
)
```

The 16 scripts where the workaround is needed in this run are
listed in `error_analysis.md` cluster E2. Each is independent and
can be patched in batches of 4–6 per PR. No interpreter or bridge
change is required; this is a script-shape issue.

**Closing criteria.** Each fixed script must drop to 0 FE in its
parent suite; `bisect_test.dart` for that script must continue to
report `STATUS: true`.

### E5 — `widgets_binding_observer_test` non-uniform `borderRadius`

**Why unfixable at the interpreter.** The script defines a
`Border` with per-side `BorderSide.color` (non-uniform colour)
and applies a `borderRadius` to it. Flutter's `Border.paint`
explicitly rejects this combination: `A borderRadius can only be
given on borders with uniform colors. The following is not
uniform: BorderSide.color`. This assertion fires inside Flutter's
own painter code, not the interpreter, and is a script-side
mistake — the interpreter is faithfully forwarding the constructor
arguments.

**Workaround.** Either drop `borderRadius` for the non-uniform-
colour border, or unify the colours across all four sides. The
script-side patch is one line; no interpreter change applies.

### Cluster R — `gir` W4 transport cascade (test-app structural)

**Why unfixable at the interpreter.** The cascade trigger
(`retest/widgets/lock_state_test.dart` at gir TID=43) emits an
`HttpException: Connection closed before full header was received`
on `POST /build`, after which the test app process dies and every
subsequent script fails at `GET /clear` with `SocketException:
Connection refused (errno = 111)` against the (now closed)
ephemeral port. The cascade is in the **test runner ↔ test app
transport layer**, not the interpreter — the interpreter never
got a chance to evaluate the next script's source.

**Workaround.**

1. **Skip** `widgets/lock_state_test.dart` in
   `generator_interpreter_retest_test.dart` using the same
   `skip:` pattern already applied for W1, W2, W3, W5 wedgers.
   This recovers the 19 cascade victims (gir TIDs 44–62)
   immediately.
2. **Test-app watchdog** (META structural fix tracked in
   `interpreter_issues.md` "[META] Structural cascade in retest
   suite") — extend `SendTestRunner` so a single
   `Connection closed` / `Connection refused` triggers a fast
   app-process restart and a port re-discovery rather than letting
   subsequent /clear calls fail against a dead socket. This
   converts a 20-script cascade into a single failure + 19
   retries.

The skip is the safe day-1 mitigation; the watchdog is the
durable fix and is the highest-leverage structural change pending
across the wedge taxonomy (it would also close W1, W2, W3 once
they re-surface).

### gir TID=31 `render_animated_size_state_test.dart` — pre-existing 2.0 px overflow

Already documented earlier in this file. Re-confirmed in this
run as still failing with `RenderFlex overflowed by 2.0 pixels
on the bottom`. No new interpreter signal.

### gir TID=37 `back_button_listener_test.dart` — Router routerDelegate coercion

Already documented earlier in this file. Re-confirmed in this
run as still failing with `Argument Error: Invalid parameter
"routerDelegate": expected RouterDelegate<dynamic>, got
InterpretedInstance(_BackLabRouterDelegate)`. This is the
"interpreted-extends-bridged abstract delegate at the native
bridge boundary" shape; the architecturally-clean fix is the
same one tracked under the "future cluster — InheritedModel
proxy" entry in `interpreter_issues.md`, generalised to any
bridged abstract class with a `routerDelegate`-style parameter.
The script-side workaround (a thin native shim that the script
constructs and passes a callback to) is documented in the
script's own `// SKIP` comment.
