# Issue Analysis — Run 20260424-1838-issue-analysis

**Run ID:** `20260424-1838-issue-analysis`
**Started:** 2026-04-24 18:39:20 CEST
**Finished:** 2026-04-24 19:02:20 CEST
**Duration:** 23 min 00 s
**Git rev (HEAD at start of run):** `208f4e83c889362ce6cc3e91f4eaa237bd3091ba`
**Branch:** `main`
**Package:** `tom_d4rt_flutterm`
**Runner:** `flutter test` per file, JSON reporter + tee'd text log, strictly serial
**Log folder:** `doc/testlog_20260424-1838-issue-analysis/`

Every suite was run with the JSON reporter (`--file-reporter json:…`) and the
combined text output was tee'd both to a per-suite `*.log.txt` and to a single
`combined.log.txt`. The per-suite JSON files are the source of truth for pass /
skip / fail / error counts; the text logs carry the interpreter stack traces
and the "silent" framework-errors that never fail a test but are emitted to
stderr.

---

## Per-suite metrics

Counts are from the JSON reporter (hidden loader tests excluded). "Error"
means `type: "error"` with no accompanying `testDone result:"failure"` — i.e.
the test crashed or the transport failed.

| # | Suite | Pass | Skip | Fail | Error | Notes |
|---|---|---:|---:|---:|---:|---|
| 1 | essential_classes | 108 | 0 | 0 | 0 | clean |
| 2 | important_classes | 163 | 5 | 1 | 0 | `codecs_test.dart` (ByteData) |
| 3 | secondary_classes | 611 | 40 | 3 | 0 | `gesture_detector_adv`, `widgets_binding`, `widgets_binding_observer` |
| 4 | hardly_relevant_classes_1 | 79 | 0 | 0 | 126 | **test-app server crash** mid-suite; all subsequent scripts cascaded to "Transport failure" |
| 5 | hardly_relevant_classes_2 | 203 | 0 | 0 | 0 | clean |
| 6 | hardly_relevant_classes_3 | 199 | 2 | 0 | 0 | clean |
| 7 | hardly_relevant_classes_4 | 225 | 0 | 2 | 0 | both `ValueNotifier<T>` generic-factory null-cast |
| 8 | hardly_relevant_classes_5 | 222 | 0 | 8 | 0 | 5× `ValueNotifier<T>`, 1× mixin, 2× map-literal operator (new cluster) |
| 9 | interactive_tests | 6 | 0 | 0 | 0 | clean |
| 10 | generator_interpreter_issues | 53 | 1 | 29 | 0 | tracker suite — all failures are known tracked issues |
| 11 | generator_interpreter_retest | 34 | 11 | 13 | 0 | workaround-reverted retest — expected to surface regressions |
| | **TOTAL** | **1903** | **59** | **56** | **126** | |

Expansion of "Error" (hardly_relevant_1): 1 original timeout + 10 timeouts
inside the same suite + 115 "Transport failure" cascade entries. Root cause is
a single test-app process crash — see the **Server-crash incident** section.

---

## Failure catalog by root cause

Each bucket lists the interpreter/bridge symptom, the scripts that hit it, and
the recommended fix site. Bucket names mirror the language used in
`doc/interpreter_issues.md` so new clusters can be slotted into that tracker.

### A. Bridge registration — `WidgetsBindingObserver` not a mixin

```
Runtime Error: Bridged class 'WidgetsBindingObserver' cannot be used as a
mixin. Set canBeUsedAsMixin=true when registering the bridge.
```

**Affected scripts (3):**

- `widgets/widgets_binding_observer_test.dart` (secondary_classes)
- `widgets/widgets_binding_test.dart` (secondary_classes)
- `widgets/root_element_mixin_test.dart` (hardly_relevant_classes_5)

**Fix site:** `tom_d4rt_flutterm/lib/src/bridges/flutter_widgets.b.dart`
(generated) — regenerate after adding `canBeUsedAsMixin: true` to the
`WidgetsBindingObserver` registration in
`tom_d4rt_generator/lib/src/bridge_generator.dart`
(`UserBridgeScanner` / abstract-class path). Bridge is an abstract pure-
observer interface — exactly the shape that needs the flag.

### B. Generic constructor factory — `ValueNotifier<T>` null-cast (8 scripts)

```
Runtime Error: Error in generic constructor factory for 'ValueNotifier':
type 'Null' is not a subtype of type 'T' in type cast
```

Seen with T ∈ `{int, String, LogicalKeyboardKey, Offset, ChildVicinity, bool}`.

**Affected scripts:**

- `widgets/gesture_detector_adv_test.dart` (secondary_classes) — `<int>`
- `widgets/keyboard_listener_test.dart` (hardly_relevant_4) — `<LogicalKeyboardKey>`
- `widgets/overlay_state_test.dart` (hardly_relevant_4) — `<String>`
- `widgets/raw_dialog_route_test.dart` (hardly_relevant_5) — `<Offset>`
- `widgets/raw_radio_test.dart` (hardly_relevant_5) — `<String>`
- `widgets/render_tap_region_surface_test.dart` (hardly_relevant_5) — `<int>`
- `widgets/render_two_dimensional_viewport_test.dart` (hardly_relevant_5) — `<ChildVicinity>`
- `widgets/restorable_bool_n_test.dart` (hardly_relevant_5) — `<bool>`

**Pattern:** the RC-2 generic-constructor factory emitted by the generator for
`ValueNotifier<T>` appears to pass `null` as the seed when T is non-nullable,
and the downstream cast blows up. This is the same class of bug as the
cluster-closed GEN-0xx generic factory fixes — this batch just widens the
affected T set.

**Fix site:** `tom_d4rt_generator/lib/src/relaxer_generator.dart` (the
generic-constructor factory emission) — when the generated factory runs with
an absent first positional, construct with the T-zero value or surface a
clearer error; the fix must land in both
`tom_d4rt/lib/src/generator/d4.dart` and
`tom_d4rt_ast/lib/src/runtime/generator/d4.dart` if the resolution touches
the D4 helper.

### C. Operator `==` declared `Object` instead of `Object?` (3 classes)

```
Runtime Error: Native error during bridged operator '==' on X:
Argument Error: Invalid parameter "other": expected Object, got Null
```

**Affected classes & scripts:**

- `Color` — `widgets/glowing_overscroll_indicator_test.dart`,
  `widgets/spell_check_configuration_test.dart`
- `RootElement` — `widgets/root_element_test.dart`
- `BoxConstraints` — `material/toggle_buttons_theme_test.dart`,
  `material/toggle_buttons_theme_data_test.dart` (both in retest)

**Fix site:** generator emission for `operator ==`. The Dart spec is `bool
operator ==(Object other)` with an implicit nullable `other` at runtime; the
bridge adapter currently declares `other: Object` (non-nullable). Either make
the parameter `Object?` in every generated equality adapter or pre-check for
`null` and short-circuit to `false` before entering the native call. Mirror
the fix in `tom_d4rt` and `tom_d4rt_ast`.

### D. Stdlib gap — `ByteData` undefined (2 scripts)

```
Runtime Error: Undefined variable: ByteData
```

**Affected scripts:**

- `services/codecs_test.dart` (important_classes, generator_interpreter_issues)

**Fix site:** `tom_d4rt_ast/lib/src/runtime/stdlib/typed_data.dart` (and mirror
in `tom_d4rt/lib/src/stdlib/typed_data.dart`). The `ByteData` class from
`dart:typed_data` is missing from the registered bridge set — add the
`BridgedClass` and its constructors (`ByteData(length)`,
`ByteData.sublistView(...)`) plus the getters / setters used by the codec
demo.

### E. Widget coercion — `InterpretedInstance` passed where `Widget` expected

```
Runtime Error: Native error during default bridged constructor for 'Container':
Argument Error: Invalid parameter "children": expected Widget,
got InterpretedInstance(_DemoPriorityParentDataWidget)
```

**Affected scripts:**

- `widgets/render_object_element_test.dart`
- `widgets/render_object_widget_test.dart`

**Pattern:** both hit the same `_DemoPriorityParentDataWidget` symbol — a
user-defined ParentDataWidget whose class-to-Widget coercion is not finding
the bridge. Likely the generator needs to recognize that a class `extends
ParentDataWidget` (or the user bridge path) and emit the auto-wrap.

**Fix site:** `tom_d4rt_generator/lib/src/bridge_generator.dart` coercion
emission for Widget children, and the interpreter-side coercion helper in
`tom_d4rt_ast/lib/src/runtime/callable.dart` / `tom_d4rt` mirror.

### F. RenderObject subclass coercion — `BoxHitTestEntry.target`

```
Runtime Error: Native error during default bridged constructor for
'BoxHitTestEntry': Argument Error: Invalid parameter "target":
expected RenderBox, got InterpretedInstance(_MockRenderBox)
```

**Affected scripts:**

- `rendering/box_hit_test_result_test.dart`

Same family as E — a user-defined `extends RenderBox` instance cannot satisfy
the native `target: RenderBox` parameter. Fix belongs in the same coercion
path as E.

### G. Bridged mixin getter — `RestorationMixin.context`

```
Runtime Error: Undefined variable: context
(Original error: Native error in bridged mixin getter 'context':
Argument Error: Invalid target: expected RestorationMixin,
got InterpretedInstance)
```

**Affected scripts:**

- `widgets/restorable_value_test.dart`

The getter adapter for a mixin property is invoked with an
`InterpretedInstance` whose mixin attachment is not unwrapping to the mixin
carrier. Fix site: the mixin-getter path in `callable.dart` (both variants)
plus the generator's `BridgedInstanceGetterAdapter` emission for mixin
getters.

### H. Late-init template defects — **CLOSED (cluster 18)**

```
Runtime Error: Undefined variable: _value (Original error:
LateInitializationError: Late variable '_value' without initializer is
accessed before being assigned.)
```

**Affected scripts:**

- `widgets/restorable_property_test.dart` — already passing pre-fix
- `widgets/shader_mask_test.dart`
- `widgets/single_child_render_object_element_test.dart` — already passing pre-fix
- `widgets/single_child_render_object_widget_test.dart` — already passing pre-fix

**Original diagnosis (kept for trail completeness):**

> For `_animController`, the demo author placed the `late final` field
> outside `State.initState` — the interpreter walks the class body at
> declaration time and evaluates the accessor. Either the demo template
> needs to stay strict (late only in `State.initState`, never as a
> class-body field), or the interpreter should defer accessor
> evaluation until first use. The latter is the real fix because plain
> Dart handles this fine.
>
> **Fix site:** `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`
> (declaration-pass handling of `late` fields) + mirror in `tom_d4rt`.

**Actual root cause and resolution** — late-init was a *secondary*
symptom. In `shader_mask_test.dart` the cascade
`_animController = AnimationController(vsync: this, …)..repeat();`
threw inside `AnimationController(vsync: this, …)` because
`vsync: this` resolution to a `TickerProvider` proxy failed; the
assignment never happened, and the framework's subsequent `dispose()`
read the still-uninitialised `_animController`.

The proxy lookup failed because the script uses an interpreted mixin
that `implements TickerProvider`:

```dart
mixin _TickerProviderShim<T extends StatefulWidget> on State<T>
    implements TickerProvider { … }
class _ShaderMaskDemoState extends State<ShaderMaskDemo>
    with _TickerProviderShim { … }
```

Two interpreter gaps were responsible:

1. `visitMixinDeclaration` did not process the mixin's `implements`
   clause, so `_TickerProviderShim.bridgedInterfaces` was empty.
2. `D4.tryCreateInterfaceProxyWithVisitor` walked only the
   *interpreted superclass chain*, never recursing into a class's
   *interpreted mixins or interfaces* to collect their bridged
   contributions.

After fixing both gaps, a separate latent issue surfaced: the script
also defines `class _SlideGradientTransform extends GradientTransform`
and passes it as `LinearGradient(transform: …)`. `GradientTransform`
was not in `buildkit.yaml` `proxyClasses:`, so the proxy generator
never emitted a `D4rtGradientTransform` adapter or its
`registerInterfaceProxy` factory.

**Fixes (cluster 18):**

- `visitMixinDeclaration` now processes `implementsClause` (both
  `tom_d4rt_ast` and `tom_d4rt`).
- `tryCreateInterfaceProxyWithVisitor` now recursively visits every
  reachable interpreted ancestor — superclass, mixins, interfaces —
  collecting their bridged super/interfaces/mixins (both
  interpreters).
- `tom_d4rt_flutterm/buildkit.yaml` adds `GradientTransform` to
  `proxyClasses:`; bridges regenerated.

See cluster 18 in `tom_d4rt_flutterm/doc/interpreter_issues.md`
for the full closure write-up and regression numbers.

### I. Bridged field access on child instance — `_rootRuntimeType`, `_children` — RESOLVED (2026-04-25)

```
Runtime Error: Undefined variable: _rootRuntimeType (Original error:
Native error during bridged operator '==' on RootElement:
Argument Error: Invalid parameter "other": expected Object, got Null)

Runtime Error: Native error during bridged method call 'visitAncestorElements'
on StatelessElement:
LateInitializationError: Field '_children@28042623' has not been initialized.
```

**Affected scripts:**

- `widgets/root_element_test.dart`
- `widgets/render_tree_root_element_test.dart`

The first is a compound of C (operator `==` null) and the accessor fallback
path; fixing C should unblock it. The second is a native-layer late field not
being initialized through the bridged call sequence — points at
`visitAncestorElements` needing a stricter pre-check when the element is
still attaching.

**Root cause (bucket #9):** Eager Dart string interpolation inside
`Logger.debug("...$initValue...")` in `interpreter_visitor.dart` (variable
declaration init) and `environment.dart` (`Environment.assign`) called
`toString()` on the interpolated value *before* the logger decided whether
debug was enabled. When `initValue` was a Flutter `Element` mid-mount (e.g.
the ancestor visited by `visitAncestorElements` while a
`MultiChildRenderObjectElement` was still inflating its children), the
diagnostic-tree walk hit the not-yet-initialized
`MultiChildRenderObjectElement._children` late field and raised
`LateInitializationError`, surfaced through the bridged call wrapper.

**Fix:** Added `Logger.debugLazy / infoLazy / warnLazy / errorLazy` in both
`tom_d4rt/lib/src/utils/logger/logger.dart` and
`tom_d4rt_ast/lib/src/runtime/utils/logger/logger.dart`. The lazy variants
take a `String Function()` builder and only invoke it when the level is
actually enabled. Switched the two hot interpolation sites
(`interpreter_visitor.dart` variable decl init and `environment.dart`
`Environment.assign`) to `debugLazy`, mirrored across both interpreters.
Bridge regeneration was not required.

**Regression battery delta (vs. baseline):** +16 passes, 0 regressions
(gii +6, important +1, secondary +3, hr5 +6; essential unchanged). See
cluster 19 in `tom_d4rt_flutterm/doc/interpreter_issues.md` for full
numbers.

### J. `CustomPainter.preset` undefined — RESOLVED by bucket #9 fix (2026-04-25)

```
Runtime Error: Undefined property or method 'preset' on bridged instance of
'CustomPainter'.
```

**Affected scripts:**

- `material/range_slider_tick_mark_shape_test.dart`

**Original (incorrect) diagnosis:** "demo bug — author uses a non-existent
`preset` member on `CustomPainter`."

**Actual root cause:** `preset` is a real field on the user-defined
`_TickDiagnosticsPainter extends CustomPainter` (line 1322 of the script),
accessed via `oldDelegate.preset` inside the
`shouldRepaint(covariant _TickDiagnosticsPainter oldDelegate)` override. The
access itself works correctly in the interpreter — the failure surfaced only
because an earlier eager `Logger.debug("...$value...")` interpolation along
the same dispatch chain (bucket #9) was raising and the framework's recovery
path then re-entered the painter through the `CustomPainter` view, where the
mid-error context lost the covariant downcast.

**Resolution:** No additional fix needed. Bucket #9's lazy-Logger fix
(`Logger.debugLazy / infoLazy / warnLazy / errorLazy`) cleared the eager
interpolation site; the script now runs with `frameworkErrors=0` in the
secondary suite. Verified post-bucket-#9: full secondary suite reports
614 / 40 / 0 (vs. 611 / 40 / 3 baseline).

### K. Iterable.toList wrapping sub-errors — RESOLVED (2026-04-25, cluster 20)

```
Runtime Error: Native error during bridged method call 'toList' on Iterable:
Runtime Error: Undefined property or method 'first' on bridged instance of 'String'.

Runtime Error: Native error during bridged method call 'toList' on Iterable:
Runtime Error: Error in generic constructor factory for 'RawRadio':
'package:flutter/src/widgets/raw_radio.dart': Failed assertion: line 58 pos 15:
'!enabled || groupRegistr[...]
```

**Affected scripts (all four now passing):**

- `rendering/render_proxy_sliver_test.dart` — inner: `.first` on String
- `widgets/glowing_overscroll_indicator_test.dart` — inner: operator `==` Color null
- `rendering/render_aligning_shifted_box_test.dart` — inner: `.first` on String
- `widgets/raw_radio_test.dart` (retest) — inner: RawRadio factory assertion

**Root cause:** Not actually error-wrapping — these scripts use
`label.characters.first`, `colorIterable.first`, etc. on a String /
collection. The native call returns a `StringCharacters` (subtype of
`Characters`), and `Environment.toBridgedInstance` was wrapping it as
the `String` bridge because the G-DCLI-05 name-prefix fallback in
`toBridgedClass` matched `'StringCharacters'.startsWith('String')` and
ran *before* `BridgedClass.isAssignable` was consulted. Result: every
`Characters` method/getter (`.first`, `.toList`, etc.) failed with
"Undefined property or method 'X' on bridged instance of 'String'".

**Fix (cluster 20):** Re-ordered `toBridgedInstance` resolution to
1) direct type lookup → 2) `isAssignable` iteration → 3) name-based
fallbacks. `isAssignable` now correctly identifies `StringCharacters`
as `Characters`. Mirrored in `tom_d4rt` and `tom_d4rt_ast`. See
`tom_d4rt_flutterm/doc/interpreter_issues.md` cluster 20 for details.

### L. Constructor-parameter validation — `ImageFilter.matrix` — RESOLVED (2026-04-25, cluster 21)

```
Runtime Error: Native error during bridged constructor 'matrix' for class
'ImageFilter': Invalid argument(s): "matrix4" must have 16 entries.
```

**Affected scripts:**

- `widgets/backdrop_filter_test.dart`

**Root cause:** Section 3 of the demo ("Color Matrix Filters") wrapped a
20-element 5×4 color matrix in `BackdropFilter(filter: ui.ImageFilter.matrix(...))`.
`ImageFilter.matrix` is for **geometric** transforms — its parameter is
`Float64List` of 16 entries (a 4×4 transform). Color matrix transforms in
Flutter are `ColorFilter.matrix(List<double> matrix)` (5×4 = 20) wrapped in
`ColorFiltered`, not `BackdropFilter`. The demo author conflated the two.

A latent bug was hiding behind this crash: section 6 used
`Tween(begin: 0, end: _animatedBlur)` inside a `TweenAnimationBuilder<double>`.
The int literal `0` doesn't auto-widen to `double` in d4rt's typed-list
coercion, so once section 3 stopped throwing the framework hit
`type 'int' is not a subtype of type 'double?' in type cast` instead.

**Fix (cluster 21):** Demo-only changes in
`tom_d4rt_flutterm/test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/backdrop_filter_test.dart`:

- Section 3: replace `BackdropFilter` + `ui.ImageFilter.matrix(...)` with
  `ColorFiltered` + `ColorFilter.matrix(...)` wrapping the colorful
  background. The 20-element matrices are now passed to the right factory.
- Section 6: change `Tween(begin: 0, end: _animatedBlur)` to
  `Tween<double>(begin: 0.0, end: _animatedBlur)`.
- Drop the now-unused `dart:typed_data` import; correct the API-reference
  text to clarify `ImageFilter.matrix` is a 4×4 geometric transform and
  point at `ColorFilter.matrix` for color matrices.

No interpreter or bridge changes. `backdrop_filter_test` now reports
`frameworkErrors=0`. See `tom_d4rt_flutterm/doc/interpreter_issues.md`
cluster 21 for details.

### M. Inactive-element `findRenderObject` — RESOLVED (2026-04-25, cluster 22)

```
Runtime Error: Native error during bridged method call 'findRenderObject' on
X: Cannot get renderObject of inactive element.
```

**Affected scripts:**

- `rendering/render_aligning_shifted_box_test.dart`
- `rendering/render_absorb_pointer_test.dart`

The demo calls `findRenderObject` on an element that has been removed from
the tree. In plain Dart this also throws — this is correct behavior reached
via the bridge. The fix is in the demo (guard with `element.mounted` or pull
the RO from the live widget). Not an interpreter bug.

**Resolution:** Closed as cluster 22 in
`doc/interpreter_issues.md`. Both scripts now guard `findRenderObject`
calls with explicit `BuildContext.mounted` checks. The bucket #13
error no longer appears; the remaining `createRenderObject`
coercion errors that surface in these scripts are a separate
cluster (interpreted RenderObject subclass not unwrapped at
bridge boundary) and will be addressed independently.

### N. Map-literal bitwise operators on `WidgetState` / `BridgedEnumValue` — RESOLVED (2026-04-25, cluster 23)

```
Runtime Error: Operand for unary '~' must be an int or have an operator
defined, but was BridgedEnumValue. (in Map literal)

Runtime Error: Unsupported binary operator "|" (in Map literal)
```

**Affected scripts (now passing):**

- `widgets/widget_state_mapper_test.dart`
- `widgets/widget_state_test.dart`

Resolved by cluster 23 — see
`doc/interpreter_issues.md` → "[X] Fixed (23) — extension binary
operators on `WidgetState` / `BridgedEnumValue` (bucket #14)" for
the full diagnosis. Two interacting bugs were addressed: (1) the
generator's `_generateOperatorCall` emitted `(t as dynamic) | x`,
which cannot reach extension methods because Dart resolves
extensions statically; (2) `SBinaryExpression`'s early-extension
check in both `tom_d4rt` and `tom_d4rt_ast` swallowed re-thrown
call-site exceptions, masking the underlying `NoSuchMethodError`
behind the generic `Unsupported binary operator "|"` message.

**Fix sites:**

- `tom_d4rt_generator/lib/src/bridge_generator.dart` —
  `_generateOperatorCall` now takes an optional `extensionOnType`
  and emits static dispatch (`t op (positional[0] as $onType)`)
  for the extension call site.
- `tom_d4rt/lib/src/interpreter_visitor.dart` and
  `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` —
  `SBinaryExpression`'s outer `try` now wraps only
  `findExtensionMember`; the call invocation has its own narrow
  `on RuntimeD4rtException { rethrow; }` so call-site errors
  propagate to the user.

### O. `List.generate` `?.` / null-safety in bridged factory

```
Runtime Error: Error during bridged constructor 'generate' for class 'List':
Cannot invoke method 'withValues' on null. Use '?.' for null-aware method
invocation.
```

**Affected scripts:**

- `widgets/shortcut_registry_entry_test.dart`

Demo calls `someColor.withValues(alpha: x)` inside a `List.generate` callback
where `someColor` is nullable. This is **demo code**, but the error message
quality is what makes it hard to diagnose; the interpreter already emits the
right message — just needs a fix in the demo.

### P. Transition / type-generic coercion — `TransitionDelegate<T>`, `Shortcuts`, `ThemeData.extensions`

```
Runtime Error: Native error during default bridged constructor for 'Navigator':
Argument Error: Invalid parameter "transitionDelegate":
expected TransitionDelegate<dynamic>, got InterpretedInstance(_InstantTransitionDelegate)

Runtime Error: Native error during default bridged constructor for 'Shortcuts':
Argument Error: Invalid parameter "shortcuts": cannot convert Map to
Map<ShortcutActivator, Intent> - type 'InterpretedInstance' is not a subtype
of type 'Intent'

Runtime Error: Native error during bridged method call 'copyWith' on
ThemeData: Argument Error: Invalid parameter "extensions": cannot convert
List to List<ThemeExtension<ThemeExtension<dynamic>>>
```

**Affected scripts:**

- `widgets/transition_delegate_test.dart`
- `widgets/default_text_editing_shortcuts_test.dart`
- `material/theme_extension_test.dart`

Same family as E / F but through generic type parameters. The coercion helper
needs a path that maps a user-subclass `InterpretedInstance` to its native
bridge when the parameter is declared `T` with a bound we know about.

### Q. Other single-script failures

| Script | Message | Kind |
|---|---|---|
| `widgets/window_scope_test.dart` | `Assertion failed: No _DemoWindowScope found in context` | demo harness bug — missing `_DemoWindowScope` wrapper |
| `widgets/render_custom_multi_child_layout_box_test.dart` | `Unsupported operator (*) for types null and int; childSemantics.renderObject._needsLayout is not true` | layout-phase ordering |
| `widgets/render_custom_paint_test.dart` | `Build scheduled during frame` in `State.setState` | demo: `setState` called inside `build` / frame |
| `widgets/route_information_reporting_type_test.dart` | `Switch expression was not exhaustive for value: RouteInformationReportingType.navigate` | interpreter exhaustiveness check on enum |
| `widgets/render_object_element_test.dart` | see E above | — |
| `dart_ui/key_event_type_test.dart` | `Undefined property or method 'label' on bridged instance of 'Key'.` | bridge gap on `KeyEvent.label` |
| `material/button_bar_theme_test.dart` | (same error as toggle_buttons — C) | C |
| `material/gapped_range_slider_track_shape_test.dart` | (retest, C-family) | C |
| `material/popup_menu_position_test.dart` | `You can only pass [child] or [icon], not both` | demo bug |
| `painting/axis_direction_test.dart` | retest — surfaces bucket C/B | re-classify in follow-up |
| `widgets/object_key_test.dart` | `Undefined variable: identityHashCode` | stdlib gap |
| `widgets/raw_keyboard_listener_test.dart` | `Undefined variable: RawKeyboardListener` | bridge gap (deprecated API; needs registration) |
| `widgets/raw_radio_test.dart` (retest) | nested factory assertion | B + assertion in RawRadio ctor |

---

## Silent framework errors (pass-through warnings)

These are emitted to stderr inside the test-app process but the test itself
still passes. The user explicitly asked for these to be surfaced.

### RenderFlex overflow / RenderConstrainedOverflowBox

Counted 98 occurrences of `A RenderFlex overflowed…` and 2 of
`RenderConstrainedOverflowBox object was given an infinite size during
layout` across the combined log.

Top emitters (best-effort attribution — nearest preceding nav line in
combined.log.txt; see `combined.log.txt` for exact sequence):

| Count | Script (attributed) |
|---:|---|
| 69 | `widgets/navigation_toolbar_test.dart` (83 per nav-line attribution — overlap with the next script's setup) |
| 13 | `widgets/standard_component_type_test.dart` |
| 6 | `widgets/html_element_view_test.dart` |
| 6 | `widgets/inherited_theme_test.dart` |
| 6 | `widgets/inherited_widget_test.dart` |
| 6 | `widgets/text_magnifier_configuration_test.dart` |
| 5 | `widgets/spell_check_configuration_test.dart` |
| 4 | `widgets/layout_builder_adv_test.dart` |
| 4 | `widgets/magnifier_decoration_test.dart` |

Action: these are demo-layout issues (widgets intentionally forced into a
too-narrow constraint in the showcase). Low priority but worth a follow-up
pass through the top emitters to tighten the layout.

### Other silent signals

- `VSync` — 504 matches, all benign (script text like `vsyncStart` in demo
  narration), not real warnings.
- `Navigator.pop` — 2 demo guards where an empty-stack pop was logged; demo
  behavior, not a bug.
- **No** `setState after dispose`, `Timer still pending`,
  `StackOverflowError`, or focus-assertion hits in the combined log.

---

## Server-crash incident: `image_sampler_slot_test.dart`

Inside `hardly_relevant_classes_1_test.dart` the per-file `flutter test`
harness lost contact with the local test-app HTTP server on port 4247 while
running `dart_ui/image_sampler_slot_test.dart`. The first symptom is a 30 s
timeout on that script, followed by 10 more timeouts, and then every
subsequent script surfaces:

```
Bad state: Transport failure while running "dart_ui/…_test.dart"
```

Counts in this suite: 11 × TimeoutException, 115 × Transport failure, 126 total
errors — **all in the same suite**.

### Why it did not corrupt the other suites

The `flutter test` binary forks a fresh test-app process per top-level test
file (i.e. per `*_test.dart` file in `test/`). When
`hardly_relevant_classes_1_test.dart` exited, the next suite
(`hardly_relevant_classes_2_test.dart`) got a brand-new server and ran
cleanly. The 126 errors are therefore a single-suite crash, not a run-wide
contamination. Run was strictly serial — parallelism was **not** the cause.

### Root cause (hypothesis, to be confirmed)

The script `image_sampler_slot_test.dart` is a tiny stub (~1KB per METRIC
line). The test-app server accepted the bundle, then stopped responding —
most likely the D4rt interpreter is hanging inside an `ImageSampler` /
`ImageFilter` bridge call. Worth manually re-running just that script:

```
flutter test test/hardly_relevant_classes_1_test.dart \
  --name 'image_sampler_slot_test.dart'
```

and watching the test-app logs.

### Action items for the incident

1. Re-run `hardly_relevant_classes_1` after the other clusters land — the
   failure count should drop back to 0 without code changes as long as
   `image_sampler_slot` doesn't re-hang.
2. Add a test-app health-check before each script-send (ping the /ready
   endpoint, relaunch if dead). Tracked as an infrastructure TODO — not a
   D4rt bug.
3. If `image_sampler_slot_test.dart` hangs again, bisect into the script to
   find the exact bridge call that blocks.

---

## Recommended cluster ordering (for `doc/interpreter_issues.md`)

In decreasing order of impact (scripts closed per fix):

| Priority | Cluster | Bucket | Scripts closed |
|---|---|---|---:|
| 1 | Generic `ValueNotifier<T>` null-cast | B | 8 |
| 2 | `operator ==` `Object?` nullable | C | 5 |
| 3 | Widget / RenderObject subclass coercion | E, F, P | 6 |
| 4 | `WidgetState` enum operators (`|`, `~`) in map literals | N | 2 |
| 5 | `canBeUsedAsMixin=true` for observer mixins | A | 3 |
| 6 | `ByteData` stdlib bridge | D | 2 |
| 7 | Bridged mixin getter target unwrap | G | 1 |
| 8 | Late-field declaration-pass defer | H | 4 |
| 9 | Server-crash incident investigation | infra | 126 errors (one suite) |

---

## Links and artifacts

- Combined log: `doc/testlog_20260424-1838-issue-analysis/combined.log.txt`
- Per-suite JSON reporter: `doc/testlog_20260424-1838-issue-analysis/*_test.result.json`
- Per-suite text log: `doc/testlog_20260424-1838-issue-analysis/*_test.log.txt`
- Live cluster tracker: `doc/interpreter_issues.md`
- Quest overview: `_ai/quests/d4rt/overview.d4rt.md`
