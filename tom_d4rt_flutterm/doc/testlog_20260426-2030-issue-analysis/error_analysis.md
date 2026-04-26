# Error Analysis — testlog_20260426-2030-issue-analysis

**Run ID:** `20260426-2030-issue-analysis`
**Date:** 2026-04-26 20:30 (local)
**tom_d4rt rev:** post-Plan-E (commits `194c2f04`, `c1e68a69`, `1bfb8f14` on `main`)
**Source data:** `run_summary.tsv` and `all_framework_errors.txt` in this folder; per-suite `*.log.txt` and `*.result.json` for details.

## Suite-level summary

| Suite | Status | Pass | Fail | Skip | Framework errors in log |
|---|---|---:|---:|---:|---:|
| essential_classes_test | PASS | 108 | 0 | 0 | 1 |
| important_classes_test | PASS | 164 | 0 | 5 | 0 |
| secondary_classes_test | PASS | 649 | 0 | 5 | 24 |
| hardly_relevant_classes_1_test | PASS | 204 | 0 | 1 | 1 |
| hardly_relevant_classes_2_test | PASS | 203 | 0 | 0 | 0 |
| hardly_relevant_classes_3_test | PASS | 199 | 0 | 2 | 0 |
| hardly_relevant_classes_4_test | PASS | 227 | 0 | 0 | 1 |
| hardly_relevant_classes_5_test | PASS | 230 | 0 | 0 | 47 |
| interactive_tests_test | PASS | 6 | 0 | 0 | 0 |
| generator_interpreter_issues_test (gii) | FAIL | 71 | 11 | 1 | 11 |
| generator_interpreter_retest_test (gir) | FAIL | 40 | 7 | 11 | 6 |
| **Totals** | — | **2101** | **18** | **30** | **806** lines (multi-line errors counted by line) |

> Framework errors are non-fatal but indicate either interpreter/bridge gaps or genuine script bugs. The "all errors" pile is in `all_framework_errors.txt` (one row per `<logfile>|<script>|<message>`).

## Hard-failure roll-up (gii + gir)

| Suite | Script | Cluster |
|---|---|---|
| gii | rendering/box_hit_test_result_test.dart | C1 |
| gii | rendering/custom_painter_semantics_test.dart | C18 |
| gii | rendering/relayout_when_system_fonts_change_mixin_test.dart | C9 |
| gii | rendering/render_absorb_pointer_test.dart | C9 |
| gii | rendering/render_aligning_shifted_box_test.dart | C8 |
| gii | rendering/render_box_container_defaults_mixin_test.dart | C1 |
| gii | rendering/render_custom_multi_child_layout_box_test.dart | C19 |
| gii | rendering/render_custom_paint_test.dart | C20 |
| gii | widgets/inherited_theme_test.dart | C14 |
| gii | widgets/inherited_widget_test.dart | C14 |
| gii | widgets/sliver_child_builder_delegate_test.dart | C17 |
| gir | retest/material/gapped_range_slider_track_shape_test.dart | C3 |
| gir | retest/material/theme_extension_test.dart | C6b |
| gir | retest/painting/axis_direction_test.dart | C9 |
| gir | retest/widgets/default_text_editing_shortcuts_test.dart | C6 |
| gir | retest/widgets/next_focus_intent_test.dart | C20 |
| gir | retest/widgets/raw_keyboard_listener_test.dart | C20 |
| gir | retest/widgets/raw_radio_test.dart | C20 |

Cluster IDs reference the sections below.

---

## Clusters

Each cluster lists: representative pattern → affected scripts → analysis → suggested fix path. **Cluster severity** is rated by impact on user code; **owner** identifies whether the fix lives in the bridge generator, the interpreter (mirrored in tom_d4rt + tom_d4rt_ast), the bridge package (tom_d4rt_flutterm), or the test script itself.

---

### C1 — RenderObject mixin proxy gap (`_InterpretedRenderBox` not a `ContainerRenderObjectMixin`)

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** High · **Owner:** generator (proxy generator) + tom_d4rt_flutterm user-bridge

**Representative errors**

- `type '_InterpretedRenderBox' is not a subtype of type 'ContainerRenderObjectMixin<RenderObject, ContainerParentDataMixin<RenderObject>>' in type cast`
- `Native error during bridged method call 'addWithPaintOffset' on BoxHitTestResult: Cannot invoke method 'contains' on null. Use '?.' for null-aware method invocation.`

**Affected scripts**

- `rendering/box_hit_test_result_test.dart` (gii fail)
- `rendering/render_box_container_defaults_mixin_test.dart` (gii fail)

**Analysis.** When user code subclasses `RenderBox` (or any `RenderObject`), the proxy generator creates a `_InterpretedRenderBox` that forwards method calls to the interpreted instance. The proxy does not implement the mixin chain Flutter uses for parented children (`ContainerRenderObjectMixin`, `ContainerParentDataMixin`, `RenderObjectWithChildMixin`). Two consequences observed:

1. `box_hit_test_result.addWithPaintOffset` reads `child.size` on a `RenderBox` whose `size` getter is never satisfied because the proxy's `performLayout` runs in interpreter-land and never assigns `_size` on the native side → `Cannot invoke 'contains' on null`.
2. `RenderBoxContainerDefaultsMixin` direct-casts the parent to the container mixin — the proxy is rejected at runtime.

**Suggested fix.** Generate proxy variants for the mixin combinations the rendering layer actually demands: a `_InterpretedRenderBoxContainer<ChildType, ParentDataType>` that mixes in `ContainerRenderObjectMixin` + `ContainerParentDataMixin` + `RenderBoxContainerDefaultsMixin`. The proxy must propagate `size` to the native side at the end of every `performLayout`. Mirror the proxy_generator change between `tom_d4rt_generator` and the consuming user bridges in `tom_d4rt_flutterm/lib/src/d4rt_user_bridges/rendering/`.

---

### C2 — `LateInitializationError: Late final variable 'color' has already been assigned` (single-script regression candidate)

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Medium · **Owner:** interpreter (late-final reassignment guard) **and/or** test script

**Representative error**

- `LateInitializationError: Late final variable 'color' has already been assigned.`

**Affected scripts**

- `widgets/web_browser_detection_test.dart` (44 occurrences — all in this one script)

**Analysis.** All 44 hits come from one script. A `late final` field declared on a `StatefulWidget`'s `State` is being assigned more than once across rebuilds — the test exercises a custom widget with a `late final Color color;` initialised in `initState` or `build`. In native Dart, `late final` survives one assignment per object; if the proxy/state is reused across builds and the assignment runs on every `build`, you get this exact error.

Two candidate root causes:

- Interpreter bug: the `late final` field is associated with the wrong storage scope (e.g., per-build instead of per-`State`), so each rebuild looks like a fresh object on which the assignment is "first" — but the underlying native field has already been written to.
- Script bug: the test really does assign on each build (genuine bug in user code that we should expose).

**Suggested fix.** Read `widgets/web_browser_detection_test.dart` in the test app and verify whether `late final color` is assigned once or per-build. If once → interpreter-side: late-final binding lifecycle in `Environment`/`InterpreterVisitor` field initialisation needs to be tied to the State, not the build closure. If per-build → fix the test (use plain `final` initialiser, or `late` without `final`).

---

### C3 — `Null check operator used on a null value` (broad symptom)

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Medium · **Owner:** mixed (interpreter + bridge package + scripts)

**Representative error**

- `Null check operator used on a null value` (43 occurrences; 18 of them concentrated in one gir test)

**Affected scripts**

- `retest/material/gapped_range_slider_track_shape_test.dart` (gir fail — 18× `!`)
- `widgets/scroll_deceleration_rate_test.dart`
- `widgets/sliver_multi_box_adaptor_element_test.dart`
- `widgets/slotted_multi_child_render_object_widget_mixin_test.dart`
- `widgets/text_magnifier_configuration_test.dart`
- `widgets/weak_map_test.dart`
- `widgets/web_browser_detection_test.dart`
- `widgets/widget_state_color_test.dart`

**Analysis.** The `!` operator at a bridge boundary trips when an interpreted value reaches a Flutter API that asserts a non-null. The cluster has multiple sub-causes:

- `gapped_range_slider_track_shape_test.dart`: the script likely accesses `Theme.of(context)!.sliderTheme.activeTrackColor!` chain on a context where `Theme` resolves to a default with `null` tracks. Either the script presumes a non-null theme that our `D4MaterialApp.theme` does not supply, or the bridge for `SliderThemeData` returns null where it shouldn't.
- The `scroll_*` and `widget_state_*` group: `Color.withValues` (see C11) returns null when the receiver is null, and a downstream `!` fires.

**Suggested fix.** Triage by script. Add `Theme.of(context)?.…` defaults in the gapped-range-slider script, then chase the remaining hits — most of which feed off C11 (null `Color`) and C8 (`hasSize` on un-laid-out RenderBox).

---

### C4 — Section E: `cannot convert <Interpreted> to <Concrete Widget subtype>` at native bridge boundary

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** High · **Owner:** generator (relaxer) + interpreter (proxy widening)

**Representative errors**

- `Native error during default bridged constructor for 'Column': Argument Error: Invalid parameter "children": cannot convert List to List<Widget> - type 'InterpretedInstance' is not a subtype of …`
- (variants for `Row`, `Stack`, `Wrap`, etc.)

**Affected scripts**

- `widgets/slotted_multi_child_render_object_widget_mixin_test.dart`
- `widgets/slotted_multi_child_render_object_widget_test.dart`

**Analysis.** Section E (interpreted Widget at native bridge boundary) is the long-standing problem: when the user constructs a `Column(children: [MyInterpretedWidget(...)])`, the interpreter passes an `InterpretedInstance` into the native list, and the constructor adapter rejects it because `InterpretedInstance is! Widget`. The current generator emits a relaxer for List<Widget> but only when the static type is exactly `List<Widget>`; here the script declares `List<MyWidget>` or relies on inference and the relaxer fires too late.

**Suggested fix.** Extend `relaxer_generator.dart` to recognise any `List<T>` where `T` is `Widget` or a subtype and to wrap each element through `D4.coerceWidget(...)` (which already exists for the singular case). Mirror the `D4` helper in `tom_d4rt_ast` per the "fix in lockstep" rule. Verify with the slotted mixin scripts.

---

### C5 — Generic `Map` coercion: `Map<ShortcutActivator, Intent>`

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Medium-High · **Owner:** generator (relaxer for typed maps)

**Representative error**

- `Native error during default bridged constructor for 'Shortcuts': Invalid parameter "shortcuts": cannot convert Map to Map<ShortcutActivator, Intent> - type 'InterpretedInstance' …`

**Affected scripts**

- `retest/widgets/default_text_editing_shortcuts_test.dart` (gir fail)
- `widgets/shortcut_activator_test.dart`
- `widgets/shortcut_manager_test.dart`
- `widgets/shortcut_map_property_test.dart`

**Analysis.** Map literals built in interpreted code reach `Shortcuts(shortcuts: …)` as `InterpretedInstance` (the d4rt-side Map class), not a `Map<ShortcutActivator, Intent>`. The relaxer wraps `List<T>` and singular Widget args but does not yet wrap `Map<K, V>` for typed maps where K/V are bridged classes.

**Suggested fix.** Add `D4.coerceMap<K, V>(value)` and emit a relaxer call for any `Map<K, V>` parameter where K or V is a bridged class. Cover both directions (interpreter → native, and native → interpreter for callbacks returning maps).

---

### C6 — `Map<Type, Action<Intent>>` coercion (sibling of C5)

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Medium · **Owner:** generator (relaxer)

**Representative error**

- `Native error during default bridged constructor for 'Actions': Invalid parameter "actions": cannot convert Map to Map<Type, Action<Intent>> …`

**Affected scripts**

- `widgets/scroll_to_document_boundary_intent_test.dart`
- `widgets/select_all_text_intent_test.dart`
- `widgets/select_intent_test.dart`

**Analysis.** Same problem as C5 but with `Type` keys. The interpreter has its own `Type` representation; the relaxer needs to unwrap the interpreted `Type` token to a native `Type` literal before populating the map. Fix is the same `D4.coerceMap<K, V>` extension as C5, with `Type` key support.

---

### C6b — `cannot convert List to List<ThemeExtension<ThemeExtension<dynamic>>>`

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Low (one script) · **Owner:** generator (relaxer)

**Representative error**

- `Native error during bridged method call 'copyWith' on ThemeData: Argument Error: Invalid parameter "extensions": cannot convert List to List<ThemeExtension<ThemeExtension<dynamic>>>`

**Affected scripts**

- `retest/material/theme_extension_test.dart` (gir fail)

**Analysis.** Higher-kinded generic in `ThemeData.extensions` (`Iterable<ThemeExtension<ThemeExtension<dynamic>>>`). Same story as C4 — the relaxer doesn't recognise the nested generic. Will be solved by the same C4/C5 generalised coercion path; left as its own row because it needs an explicit test.

---

### C7 — `TwoDimensionalScrollView` / `TwoDimensionalViewport` default constructor missing

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Medium · **Owner:** generator (constructor emission for abstract classes with named-only constructors)

**Representative error**

- `Error during constructor execution for class '_TwoDBuildGridView': Bridged superclass 'TwoDimensionalScrollView' does not have a constructor named ''. Check bridge definition.`

**Affected scripts**

- `widgets/two_dimensional_child_builder_delegate_test.dart`
- `widgets/two_dimensional_child_manager_test.dart`
- `widgets/two_dimensional_scrollable_state_test.dart` (also implicated in C8 layout fallout)

**Analysis.** `TwoDimensionalScrollView` / `TwoDimensionalViewport` (Flutter's two-axis scroll APIs) declare only named constructors (`super.someName(...)`). When a user widget extends them with `class MyView extends TwoDimensionalScrollView { MyView() : super(...); }`, the interpreter's constructor dispatch looks up the empty-named (`''`) constructor on the bridged superclass and fails.

**Suggested fix.** Bridge generator should emit a `''` (empty-name) constructor adapter that forwards to the canonical named constructor when the source class has only named constructors. Alternatively, the interpreter's super-call resolution should fall back to "single available constructor" when the empty name is requested on an abstract bridged class. Pick one and apply consistently.

---

### C8 — `BoxConstraints has a negative minimum height` and `BoxConstraints forces an infinite height/width` (script-side layout)

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Low (cosmetic, script-only) · **Owner:** test scripts

**Representative errors**

- `BoxConstraints has a negative minimum height.` (15)
- `BoxConstraints forces an infinite height.` (11)
- `BoxConstraints forces an infinite width.` (1)

**Affected scripts**

- Negative minimum height: `widgets/transpose_characters_intent_test.dart`, `widgets/undo_history_value_test.dart`, `widgets/unfocus_disposition_test.dart`
- Infinite height: `widgets/scroll_deceleration_rate_test.dart`, `widgets/scroll_increment_details_test.dart`, `widgets/scroll_position_types_test.dart`, `widgets/scrollbar_painter_test.dart`, `widgets/slotted_multi_child_render_object_widget_mixin_test.dart`, `widgets/text_magnifier_configuration_test.dart`, `widgets/two_dimensional_scrollable_state_test.dart`, `widgets/weak_map_test.dart`, `widgets/widget_state_color_test.dart`, `widgets/widget_state_text_style_test.dart`, `widgets/widget_test.dart`
- Infinite width: `widgets/web_browser_detection_test.dart`

**Analysis.** Genuine script bugs: the test widgets use `Column` with `Expanded` inside an unbounded-height parent (e.g., `SingleChildScrollView`), or a `ListView` not wrapped in a sized box. This is an authoring oversight in the test corpus — the interpreter is faithfully reporting what Flutter says.

**Suggested fix.** Patch each script in the test app to wrap unbounded layouts in `SizedBox(height: 600, child: …)` (or equivalent). Lowest-priority cluster — these are noise, not regressions.

---

### C9 — `RenderFlex overflowed by N pixels` (script-side cosmetic)

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Low (cosmetic) · **Owner:** test scripts

**Representative error**

- `A RenderFlex overflowed by N pixels on the right.` / bottom.

**Affected scripts**

- `rendering/relayout_when_system_fonts_change_mixin_test.dart` (gii fail — should be a soft warning, but the test asserts no errors)
- `rendering/render_absorb_pointer_test.dart` (gii fail — same reason)
- `retest/painting/axis_direction_test.dart` (gir fail)
- `widgets/scroll_position_with_single_context_test.dart`
- `widgets/shortcut_map_property_test.dart`
- `widgets/single_ticker_provider_state_mixin_test.dart`
- `widgets/undo_history_state_test.dart`

**Analysis.** Same nature as C8 — test viewports are too small for the rendered content. The gii/gir failures here are because `tester.takeException()` flushes the overflow exception and the test asserts the exception list is empty. These are test-harness contract violations rather than interpreter bugs.

**Suggested fix.** Either size each test's viewport (`tester.view.physicalSize = const Size(800, 600); tester.view.devicePixelRatio = 1;`) or wrap the offending widget in a `MediaQuery` with sufficient size. This is purely test-script work.

---

### C10 — `RestorationProperties: 'isRegistered': is not true` assertion

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Medium · **Owner:** interpreter (mixin lifecycle dispatch) + tom_d4rt_flutterm user-bridge

**Representative error**

- `'package:flutter/src/widgets/restoration_properties.dart': Failed assertion: line 85 pos 12: 'isRegistered': is not true.`

**Affected scripts** (all 13 occurrences from this group)

- `widgets/restorable_bool_test.dart`
- `widgets/restorable_date_time_test.dart`
- `widgets/restorable_double_test.dart`
- `widgets/restorable_double_n_test.dart`
- `widgets/restorable_int_test.dart`
- `widgets/restorable_int_n_test.dart`
- `widgets/restorable_listenable_test.dart`
- `widgets/restorable_num_test.dart`
- `widgets/restorable_num_n_test.dart`
- `widgets/restorable_route_future_test.dart`
- `widgets/restorable_string_test.dart`
- `widgets/restorable_string_n_test.dart`
- `widgets/restoration_mixin_test.dart`

**Analysis.** `RestorationProperty.value` setter asserts `isRegistered`. The mixin's `restoreState`/`registerForRestoration` flow runs when the `State` is mounted with a `RestorationMixin` parent. The test scripts use `RestorationMixin` via interpreted subclasses; the interpreter is not driving `_register` on the mixin — likely because mixin initialisation in the proxy doesn't invoke the mixin's lifecycle hooks.

Related: `widgets/form_test.dart` raises `Undefined property or method 'hasError' on bridged instance of 'RestorationMixin'` (essential suite framework error), pointing at the same `RestorationMixin` proxy gap.

**Suggested fix.** Audit the proxy generator's mixin-dispatch (`proxy_generator.dart`) — when the user class mixes in `RestorationMixin`, the proxy must call `restoreState`/`didToggleBucket` on the native mixin during the `State.didChangeDependencies` lifecycle. Mirror the fix in tom_d4rt_ast.

---

### C11 — `Cannot invoke method 'withValues' on null` (Color.withValues feeding off null)

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Low · **Owner:** test scripts (mostly) and tom_d4rt_flutterm user-bridge

**Representative error**

- `Cannot invoke method 'withValues' on null. Use '?.' for null-aware method invocation.`

**Affected scripts**

- `widgets/sliver_multi_box_adaptor_element_test.dart`
- `widgets/slotted_multi_child_render_object_widget_test.dart`
- `widgets/update_selection_intent_test.dart`
- `widgets/weak_map_test.dart`

**Analysis.** Code calls `someColor.withValues(alpha: …)` where `someColor` came back null (likely from `Theme.of(context).colorScheme.x` when the theme isn't set or the field is intentionally optional). The interpreter is correct to surface this — same family as C3.

**Suggested fix.** Patch the scripts to use `?.withValues(...) ?? defaultColor`. No interpreter work.

---

### C12 — `Object.hash` static method missing on bridged `Object`

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Low (one script, but it's a real interpreter gap) · **Owner:** tom_d4rt stdlib bridge for `dart:core`

**Representative error**

- `Bridged class 'Object' has no constructor or static method named 'hash'.`

**Affected scripts**

- `widgets/undo_history_value_test.dart` (5×)

**Analysis.** `Object.hash(a, b, c)` was added in Dart 2.14. Our `dart:core` bridge for `Object` exposes constructors, `==`, `hashCode`, but not the static varargs `hash` family.

**Suggested fix.** Add `Object.hash`, `Object.hashAll`, `Object.hashAllUnordered` to the `Object` bridge in `tom_d4rt/lib/src/stdlib/object.dart` (and mirror in `tom_d4rt_ast/lib/src/stdlib/object.dart`).

---

### C13 — `Future.delayed` constructor missing

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Low · **Owner:** tom_d4rt stdlib bridge for `dart:async`

**Representative error**

- `Bridged class 'Future' does not have a registered constructor named 'delayed'. Check bridge definition.`

**Affected scripts**

- `widgets/semantics_gesture_delegate_test.dart`

**Analysis.** The `Future` bridge declares the default factory and `Future.value`/`Future.error` but not `Future.delayed`. Standard library hole.

**Suggested fix.** Add `Future.delayed` (and review `Future.microtask`, `Future.sync`, `Future.wait`) to the async stdlib bridge. Mirror tom_d4rt ↔ tom_d4rt_ast.

---

### C14 — Null `BuildContext` in `dependOnInheritedWidgetOfExactType` (Plan E2 residual)

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** High · **Owner:** interpreter (BuildContext propagation)

**Representative error**

- `Cannot invoke method 'dependOnInheritedWidgetOfExactType' on null. Use '?.' for null-aware method invocation.`

**Affected scripts**

- `widgets/inherited_theme_test.dart` (gii fail)
- `widgets/inherited_widget_test.dart` (gii fail)

**Analysis.** Plan E (commit `194c2f04`) fixed the *exact-type lookup* path but left a residual null-context case: when an interpreted `Stateless`/`Stateful` Widget calls `Theme.of(context)` from inside its `build` and the `context` is the proxy's *outer* context (held in a closure), the interpreter is passing `null` to `dependOnInheritedWidgetOfExactType`. Two scripts hit this; both call `InheritedTheme.of` / `InheritedWidget.of` from inside a builder closure.

**Suggested fix.** Trace the BuildContext capture in `proxy_generator.dart`'s `_InterpretedWidget.build` wrapper — confirm that when a closure inside `build` is invoked at framework-callback time, the captured `context` is the live proxy `Element`'s context, not a stale snapshot. If the proxy stores `_lastContext` per build, ensure builders get it via `Function.apply` rather than a let-binding at construction time. This is "Plan E2".

---

### C15 — `WidgetStateMapper` `merge` field access (Symbol("merge"))

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Low · **Owner:** generator (bridge for `WidgetStateProperty.merge`)

**Representative error**

- `There was an attempt to access the "Symbol("merge")" field of a WidgetStateMapper<TextStyle> object.`

**Affected scripts**

- `widgets/widget_state_text_style_test.dart` (5+ occurrences, contributes the bulk of the script's 70 errors)

**Analysis.** `WidgetStateMapper.merge` (or `WidgetStateProperty.merge`) was renamed/added in a recent Flutter version. The generated bridge for `WidgetStateMapper` doesn't declare the `merge` static method. A `Symbol("merge")` access typically indicates the bridge tried `noSuchMethod` after a missing instance member.

**Suggested fix.** Re-check the generated `widget_state.b.dart` — verify `WidgetStateMapper.merge`, `WidgetStateProperty.merge`, and `WidgetStateMapper.of` are emitted. If the source signature has changed, regenerate from the current Flutter SDK. The fix is in the generator + regen, not in the script.

---

### C16 — `Bridged class 'Map' has no instance method named 'contains'`

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Low · **Owner:** tom_d4rt stdlib bridge for `dart:core` (Map)

**Representative error**

- `Bridged class 'Map' has no instance method named 'contains'. Error during extension lookup: Bridged class 'Map' has no instance method named 'contains'.`

**Affected scripts**

- `widgets/sliver_child_builder_delegate_test.dart` (gii fail)

**Analysis.** Pure standard-library hole. `Map` exposes `containsKey` / `containsValue`; `contains` is *not* a `Map` member. The user code is calling `someMap.contains(x)` — likely on a value the interpreter has typed as `Map` but that the script author intended to use as `Set` (or vice versa). Could be a script bug or a type inference mismatch in the interpreter.

**Suggested fix.** Read `sliver_child_builder_delegate_test.dart`: if the script really uses `someSet.contains(x)`, then the interpreter is mis-typing the receiver as `Map` — fix the inference. If the script intended `containsKey` → patch the script.

---

### C17 — `semanticsBuilder` typed function-callback coercion

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Medium · **Owner:** generator (callback wrapping)

**Representative error**

- `Argument Error: Invalid parameter "semanticsBuilder": expected ((Size) => List<CustomPainterSemantics>)?, got InterpretedFunction`

**Affected scripts**

- `rendering/custom_painter_semantics_test.dart` (gii fail)

**Analysis.** A typed function-callback parameter (`SemanticsBuilderCallback?`) in the bridged `CustomPainter` constructor isn't being wrapped by the relaxer when the value is an `InterpretedFunction`. Standard relaxer territory, except this overload uses a typedef alias (`SemanticsBuilderCallback`) rather than the inline function type — likely the generator's typedef-resolution doesn't unwrap to `Function(Size) -> List<CustomPainterSemantics>` and so doesn't emit a wrapper.

**Suggested fix.** Extend `bridge_generator.dart` typedef resolution to follow function-typedef aliases when generating callback wrappers. Verify by regenerating the `painting/custom_painter.b.dart` (or wherever `CustomPainter` is bridged) and confirming the `SemanticsBuilderCallback` parameter gets a `D4.wrapCallback(...)` call.

---

### C18 — `Offset(dx: null)` constructor null coercion (Plan G2)

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Low · **Owner:** interpreter (positional → named null guard) or test scripts

**Representative error**

- `Native error during default bridged constructor for 'Offset': Argument Error: Invalid parameter "dx": expected double, got Null`

**Affected scripts**

- `rendering/render_custom_multi_child_layout_box_test.dart` (gii fail; also implicated in C19)

**Analysis.** Already tracked as Plan G2. The script computes `Offset(someChild.size?.width, someChild.size?.height)` and one of the values is null because the child wasn't laid out. The interpreter passes null straight through. Could be solved either by clearer error messages (saying *which call site* fed in null) or by a Plan G2 fix in the interpreter that converts a null positional double into a friendlier error before reaching the bridge.

**Suggested fix.** Combine with C19: the script bug is that `RenderCustomMultiChildLayoutBox` performs the `Offset` calculation before `child.layout()` finished. Fix the script to add `?? 0` defaults; the interpreter behaviour is correct.

---

### C19 — `'!childSemantics.renderObject._needsLayout': is not true` (semantics during layout)

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Medium · **Owner:** interpreter (frame scheduling) + scripts

**Representative error**

- `'package:flutter/src/rendering/object.dart': Failed assertion: line 5737 pos 14: '!childSemantics.renderObject._needsLayout': is not true.`

**Affected scripts** (11 occurrences)

- `rendering/render_custom_multi_child_layout_box_test.dart` (gii fail)
- `widgets/scrollbar_painter_test.dart`
- `widgets/scroll_increment_details_test.dart`
- `widgets/scroll_position_types_test.dart`
- `widgets/transpose_characters_intent_test.dart`
- `widgets/two_dimensional_scrollable_state_test.dart`
- `widgets/undo_history_value_test.dart`
- `widgets/unfocus_disposition_test.dart`
- `widgets/widget_state_text_style_test.dart`
- `widgets/widget_test.dart`

**Analysis.** Flutter asserts that all `RenderObject`s have completed layout before the semantics walk runs. The cluster fires in scripts where the proxy `RenderBox` schedules a relayout from inside `performLayout` (or where layout drives a side-effecting `setState` mid-frame — see C20). The interpreter is calling back into framework-scheduled work after the frame's layout phase has closed.

**Suggested fix.** This needs a careful trace, likely a sub-cluster of C1: the proxy's `performLayout` should *not* invoke any callback that issues a new `markNeedsLayout()` on a child during the same phase. Add a re-entrancy guard in `_InterpretedRenderBox.performLayout` that defers child mutations to the next frame.

---

### C20 — Interpreter operator + statement-level gaps (catch-all)

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Medium (each is a real Dart-feature hole) · **Owner:** interpreter (multiple visit methods)

**Representative errors and affected scripts**

| Sub-issue | Error | Scripts |
|---|---|---|
| C20a | `Unsupported binary operator "&"` | `widgets/widget_states_constraint_test.dart` |
| C20b | `Unsupported for-loop type in collection literal: SForEachPartsWithPattern` | `widgets/fractional_translation_test.dart` |
| C20c | `Undefined property or method 'indexed' on bridged instance of 'List'` | `dart_ui/point_mode_test.dart` |
| C20d | `Native error in bridged superclass method 'State.setState': Build scheduled during frame.` | `rendering/render_custom_paint_test.dart` (gii fail) |
| C20e | `Actions.maybeFind: type passed to assertion failed` | `retest/widgets/next_focus_intent_test.dart` (gir fail) |
| C20f | `Error in generic constructor factory for 'RawRadio'` | `retest/widgets/raw_radio_test.dart` (gir fail) |
| C20g | `RawKeyboardListener` deprecated/missing | `retest/widgets/raw_keyboard_listener_test.dart` (gir fail) |
| C20h | `LateInitializationError: Late variable '_value' / '_builder' without initializer accessed before being assigned.` | `widgets/restorable_property_test.dart`, `widgets/text_selection_gesture_detector_builder_delegate_test.dart` |

**Analysis.** A catch-all of small Dart-language and bridge gaps:

- C20a — `&` on `WidgetStatesConstraint` is a custom operator overload; the interpreter doesn't dispatch user-defined `&` operators yet.
- C20b — `for (var x in y) ...` *with pattern destructuring* in collection literals (Dart 3) is unimplemented; the AST node is `SForEachPartsWithPattern`.
- C20c — `Iterable.indexed` is a Dart 3 extension; missing from the iterable bridge.
- C20d — Calling `setState` from inside `performLayout` (script bug) or from inside an interpreted callback that fires while the framework holds the build lock; needs interpreter to defer the callback.
- C20e — `Actions.maybeFind` asserts `type != Intent`; the script likely passes `Intent` directly because of a `Type` token misresolution.
- C20f — RC-2 generic constructor factories on `RawRadio<T>` fail an internal assertion; the bridge factory needs the same generic-resolution path the rest of the generator uses.
- C20g — `RawKeyboardListener` is deprecated in Flutter; the bridge probably no longer registers it. Either re-bridge against the current Flutter SDK or remove the test.
- C20h — A different flavour of C2: this time it's `late <var>` (not `late final`) without an initialiser, accessed before assignment. Likely interpreter bug — the field is assigned through a setter on a different scope path (script's `set value`) than the getter reads. Worth tracing.

**Suggested fix.** Each sub-issue needs its own small fix:

- a → add `&`/`|`/`^`/`<<`/`>>` to user-operator dispatch in `InterpreterVisitor.visitBinaryExpression`.
- b → implement `SForEachPartsWithPattern` in the collection-literal visitor.
- c → bridge `Iterable.indexed` getter (returns `Iterable<(int, E)>`).
- d → wrap `State.setState` interpreter trampoline with a `WidgetsBinding.instance.addPostFrameCallback` deferral when called during a frame.
- e → fix the script (don't pass `Intent` to `Actions.maybeFind`) **or** translate to a friendlier error.
- f → trace generic-constructor factory for `RawRadio`; likely a generator gap in proxy generation for generic abstract classes.
- g → re-bridge or skip.
- h → trace `late` field setter/getter scope binding.

---

## Cluster summary

| Cluster | Severity | Owner | # scripts | Hard fails (gii/gir) |
|---|---|---|---:|---:|
| C1 — RenderObject mixin proxy gap | High | generator | 2 | 2 |
| C2 — Late final 'color' (single-script) | Medium | interpreter or script | 1 | 0 |
| C3 — `!` on null (broad) | Medium | mixed | 8 | 1 |
| C4 — List<Widget> coercion | High | generator | 2 | 0 |
| C5 — Map<ShortcutActivator, Intent> coercion | Medium-High | generator | 4 | 1 |
| C6 — Map<Type, Action<Intent>> coercion | Medium | generator | 3 | 0 |
| C6b — ThemeExtension nested generic coercion | Low | generator | 1 | 1 |
| C7 — TwoDimensionalScrollView ctor | Medium | generator | 3 | 0 |
| C8 — BoxConstraints layout (script) | Low | scripts | ~14 | 0 |
| C9 — RenderFlex overflow (script) | Low | scripts | 7 | 3 |
| C10 — RestorationProperty.isRegistered | Medium | interpreter+bridge | 13 | 0 |
| C11 — `withValues` on null (script) | Low | scripts | 4 | 0 |
| C12 — `Object.hash` missing | Low | stdlib | 1 | 0 |
| C13 — `Future.delayed` missing | Low | stdlib | 1 | 0 |
| C14 — Null BuildContext (Plan E2) | High | interpreter | 2 | 2 |
| C15 — WidgetStateMapper.merge | Low | generator | 1 | 0 |
| C16 — Map.contains | Low | stdlib or script | 1 | 1 |
| C17 — semanticsBuilder typedef callback | Medium | generator | 1 | 1 |
| C18 — Offset(dx: null) | Low | script | 1 | 0 |
| C19 — !childSemantics._needsLayout | Medium | interpreter | 11 | 1 |
| C20 — Misc operator + bridge gaps | Medium | interpreter | ≥8 | 4 |

## Recommended fix order

The next active-work cluster from the open log (`interpreter_issues.md`) should pick up the highest-leverage items first:

1. **C14 — Plan E2 (null BuildContext)** — completes Plan E and unblocks two gii fails immediately.
2. **C4 + C5 + C6 + C6b — Generic coercion (List/Map of bridged types)** — single relaxer-generator change, unblocks 4+ gir/secondary scripts and removes a long-standing Section E pain point.
3. **C1 + C19 — RenderObject proxy** — two coupled clusters; biggest impact on the rendering-test surface.
4. **C7 — TwoDimensionalScrollView empty-name ctor** — small generator change, three scripts.
5. **C12 + C13 + C20c — stdlib holes (`Object.hash`, `Future.delayed`, `Iterable.indexed`)** — quick wins.
6. **C10 — RestorationProperty proxy lifecycle** — high script count (13) but cosmetic in passing suites; tackle once C1 lands.
7. **C2 + C20h — Late-binding lifecycle audit** — needs investigation; may be a script bug or a real interpreter regression.
8. **C8 + C9 + C11 + C16 + C18 — Script patches** — batch into a single tom_d4rt_flutterm test-app commit. No interpreter work.
9. **C15 + C17 + C20a + C20b + C20d + C20e + C20f + C20g — Long tail** — small, mostly independent fixes; each warrants its own commit.
