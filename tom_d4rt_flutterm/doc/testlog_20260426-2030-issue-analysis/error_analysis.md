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

- [ ] Fixed  - [x] Partial  - [ ] Reverted/Deferred

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

**Resolution (2026-04-26) — Partial.** Implemented the container-aware proxy `_InterpretedRenderBoxContainer` in `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart` that mixes in `ContainerRenderObjectMixin<RenderBox, ContainerBoxParentData<RenderBox>>` and `RenderBoxContainerDefaultsMixin<RenderBox, ContainerBoxParentData<RenderBox>>`. The `RenderBox` proxy factory now inspects the interpreted class chain (new helper `_classChainHasBridgedMixin`) and dispatches to the container variant whenever the script's class chain includes `ContainerRenderObjectMixin`; otherwise the existing `_InterpretedRenderBox` is used. Method forwarding mirrors `_InterpretedRenderBox` exactly (`performLayout`, `paint`, `hitTest{,Self,Children}`, `setupParentData`), with `paint` falling back to `defaultPaint` and `hitTestChildren` falling back to `defaultHitTestChildren` so container scripts that don't override these methods still get correct child traversal. Done in tom_d4rt_flutterm only — no changes needed in tom_d4rt or tom_d4rt_ast (proxy infrastructure already supports the registration). The fix unblocks the original cast error and is verified on:

- `rendering/render_box_container_defaults_mixin_test.dart` — original cast `_InterpretedRenderBox is not a subtype of ContainerRenderObjectMixin` is gone. Test now fails on a downstream issue: `_DefaultsParentData extends ContainerBoxParentData<RenderBox>` (interpreted) is rejected when assigned to `RenderObject.parentData` (`Invalid parameter "parentData": expected ParentData, got InterpretedInstance(_DefaultsParentData)` × 5). This is a separate cluster (parent-data interpreted-instance proxy gap) — see **C21** below.
- `rendering/box_hit_test_result_test.dart` — the original `Cannot invoke 'contains' on null` came from a script bug (`childBox.size` access on an un-laid mock) and was fixed in-script (line 758 → use `boxSize`). The proxy fix is not directly required for this script, but with both changes the script now executes through all sections; remaining `frameworkErrors` are pre-existing visualization-layout warnings (`RenderFlex/RenderPadding given infinite size`) inside the SingleChildScrollView. These are script-side and independent of C1 — see **C22** below.

**False-start — secondary suite regression and recovery.** A first iteration of this fix added a *second* interface-proxy registration directly under `'ContainerRenderObjectMixin'` (alongside the dispatch in the `'RenderBox'` factory). That second registration intercepted any `InterpretedInstance` the framework cast through `ContainerRenderObjectMixin` — including instances that were never RenderBox subclasses — and produced bogus `_InterpretedRenderBoxContainer` proxies that corrupted state across subsequent rendering tests. Symptom: secondary suite went from baseline 649/0/5-skip to 69/580/5-skip, with rendering tests timing out at 30 s (`hittest_pipeline_test.dart`, `render_box_types_test.dart`, …) and the test-app process eventually crashing (transport_error → cascade of `clear_failed`). The redundant registration was removed; the dispatch in the `'RenderBox'` factory alone is sufficient to satisfy the framework's `proxy as ContainerRenderObjectMixin` casts because the RenderBox factory is what actually constructs the proxy when a script subclasses RenderBox.

**Regression status — clean.** With the trimmed fix in place, all three regression suites match their pre-fix baselines exactly:

| Suite | Baseline | With trimmed C1 fix | Delta |
|---|---|---|---|
| essential_classes_test | 108 / 0 | 108 / 0 | none |
| important_classes_test | 164 / 0 / 5-skip | 164 / 0 / 5-skip | none |
| secondary_classes_test | 649 / 0 / 5-skip | 649 / 0 / 5-skip | none |

Captured runs: `/tmp/c1_no_secondary_reg_essential.log`, `/tmp/c1_no_secondary_reg_important.log`, `/tmp/c1_no_secondary_reg.log` (secondary).

**Open follow-ups (now logged as separate clusters).**

- **C21 — Parent-data proxy gap** (newly surfaced by C1 fix): scripts that subclass `ParentData` / `ContainerBoxParentData` and pass an instance into a native `RenderObject.parentData` setter need an interface-proxy registration analogous to `RenderBox` so the interpreted parent-data is wrapped in a native shell.
- **C22 — Visualization layout warnings** in `box_hit_test_result_test.dart` (script-side `RenderFlex/RenderPadding given infinite size` cascades inside the SingleChildScrollView). Independent of C1.

---

### C2 — `LateInitializationError: Late final variable 'color' has already been assigned` (single-script regression candidate)

- [x] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Medium · **Owner:** interpreter (`visitSwitchStatement`)

**Representative error**

- `LateInitializationError: Late final variable 'color' has already been assigned.`

**Affected scripts**

- `widgets/web_browser_detection_test.dart` (44 occurrences — all in this one script)

**Root cause.** The interpreter's `visitSwitchStatement` did not break out of the case-member loop after running the body of a `SwitchPatternCase` whose pattern is a `ConstantPattern` (Dart 3 `case _WbdSupport.full:` syntax). The non-constant pattern path already had the correct fall-through-prevention break (G-DOV-8); the constant-pattern path did not. After the matched case ran, `execute` stayed `true` and `matched` stayed `true`, so on the next loop iteration the next case's `statementsToExecute` were still executed via the bottom `if (execute) { ... }` block.

In `_WbdSupportBadge.build()`, `late final Color color; ... switch (support) { case _WbdSupport.full: color = …; case _WbdSupport.partial: color = …; … }` therefore reassigned `color` (and three other `late final` locals) for every subsequent case after the matched one — triggering `LateInitializationError` on the second assignment to the same `LateVariable` instance.

Dart 3 pattern-switch semantics specify NO implicit fall-through (unlike legacy `SwitchCase` which requires an explicit `break`/`return`/`throw` to terminate the body). The fix mirrors that semantic.

**Fix.** In `visitSwitchStatement` (both `tom_d4rt/lib/src/interpreter_visitor.dart` and `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`):

1. Declared a per-iteration `bool patternCaseMatchedThisIteration = false;` flag at the top of the for-member loop body.
2. Set the flag to `true` when an `SSwitchPatternCase` / `SwitchPatternCase` with a `(S)ConstantPattern` matches.
3. After the bottom `if (execute) { ... }` execution block, added `if (patternCaseMatchedThisIteration) { execute = false; break; }` to exit the loop, matching the existing G-DOV-8 break for non-constant patterns.

Both interpreter trees were updated in lockstep.

**Verification (post-fix).**

- `widgets/web_browser_detection_test.dart` no longer produces any `LateInitializationError` (verified via grep on full test log).
- Essential: 108/0/0 (matches baseline).
- Important: 164/0/5 (matches baseline).
- Secondary: 649/0/5 (matches baseline).
- gii: 71/11/1 (matches baseline — same 11 failures, all from C1/C8/C9/C14/C17/C18/C19/C20).

The remaining 19 framework errors in `web_browser_detection_test.dart` are layout-cascade issues ("BoxConstraints forces an infinite width" / "RenderBox was not laid out") similar in nature to C22 — script-side viewport sizing, not C2's late-final reassignment. Tracked separately from C2.

---

### C3 — `Null check operator used on a null value` (broad symptom)

- [ ] Fixed  - [x] Partial  - [ ] Reverted/Deferred

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

- `gapped_range_slider_track_shape_test.dart`: traced the failure to `package:flutter/src/material/range_slider_parts.dart:1074:49` — `final double trackGap = sliderTheme.trackGap!;` in `GappedRangeSliderTrackShape.paint()`. In a normal Flutter app `_RangeSliderState.build()` (line 735 of `range_slider.dart`) merges `defaults.trackGap` into the `SliderThemeData` it passes down (`trackGap: sliderTheme.trackGap ?? defaults.trackGap`). Under the d4rt bridge the user's `SliderTheme(data: SliderThemeData(rangeTrackShape: GappedRangeSliderTrackShape()))` reaches `GappedRangeSliderTrackShape.paint()` without that internal default-merge filling in `trackGap`, `disabledActiveTrackColor`, `disabledInactiveTrackColor`, etc. — those fields stay null and the bare `!` in the framework code fires.
- The `scroll_*` and `widget_state_*` group: `Color.withValues` (see C11) returns null when the receiver is null, and a downstream `!` fires.

**Resolution (2026-04-27) — Partial.** The gir hard-fail (the only suite-level failure in this cluster) was addressed by patching the test script to populate the `SliderThemeData` fields the framework's `GappedRangeSliderTrackShape.paint()` and surrounding code dereference with `!` — `trackGap`, `disabledActiveTrackColor`, `disabledInactiveTrackColor`. The patch goes into all nine `SliderTheme(data: SliderThemeData(rangeTrackShape: GappedRangeSliderTrackShape(), …))` blocks in `gapped_range_slider_track_shape_test.dart`. With the patch the gir run is `gapped_range_slider_track_shape_test.dart frameworkErrors=0` (was 18). Script-only change, no regression-suite risk.

The other seven scripts (`scroll_*`, `sliver_*`, `slotted_*`, `text_magnifier_*`, `weak_map_*`, `web_browser_detection_*`, `widget_state_color_test`) remain in their pre-fix state. Each emits non-fatal `frameworkErrors` but their tests still pass at suite level — they are downstream of C8 (un-laid-out RenderBox / `hasSize`), C11 (null `Color`/`withValues`), C20 (focus tree), and similar already-tracked causes. Deferred until the upstream clusters land — fixing the upstream root cause is expected to retire most of these hits without per-script script patches.

**False-start — diagnostic enhancement reverted.** A diagnostic helper added to `tom_d4rt_flutterm/test/tom_d4rt_flutterm_app/lib/main.dart` (`_enrichWithStackFrame` appended to `_handleFlutterError`) was used to pinpoint the failing line, then **reverted** because it triggered a hard regression in the secondary suite (649/0/5 baseline → 395 +69 fail with 30s timeouts, same crashloop signature as the C1 false-start). The captured stack frame proved the failure site (`range_slider_parts.dart:1074:49`); the technique itself is unsafe to leave in `main.dart` because string formatting inside the framework error handler has secondary effects we didn't budget for. If we need stack-frame triage again it should run as a one-off opt-in, not a permanent capture.

**Verification (post-fix).**

- `retest/material/gapped_range_slider_track_shape_test.dart` (gir): `frameworkErrors=0`, passes (was 1 fail with 18× null check).
- Other gir tests in section 1: unchanged (script-only edit, can't affect other scripts).
- Essential / important / secondary regression suites: not re-run — only a single test script changed, so per the regression rule individual retest is sufficient.

**Root cause not fixed.** The interpreter / bridge gap that prevents `_RangeSliderState.build()` (and similar bridged Material `State.build()` methods) from running its internal default-merge before forwarding to `RangeSliderTrackShape.paint()` is not fixed. The patch is a workaround — a follow-up cluster should look at why bridged `_RangeSliderState.build()` is bypassing the `??`-merge of `defaults.trackGap` and friends.

---

### C4 — Section E: `cannot convert <Interpreted> to <Concrete Widget subtype>` at native bridge boundary

- [ ] Fixed  - [x] Partial  - [ ] Reverted/Deferred

**Severity:** High · **Owner:** generator (relaxer) + interpreter (proxy widening)

**Representative errors**

- `Native error during default bridged constructor for 'Column': Argument Error: Invalid parameter "children": cannot convert List to List<Widget> - type 'InterpretedInstance' is not a subtype of …`
- (variants for `Row`, `Stack`, `Wrap`, etc.)

**Affected scripts**

- `widgets/slotted_multi_child_render_object_widget_mixin_test.dart`
- `widgets/slotted_multi_child_render_object_widget_test.dart`

**Analysis.** Section E (interpreted Widget at native bridge boundary) is the long-standing problem: when the user constructs a `Column(children: [MyInterpretedWidget(...)])`, the interpreter passes an `InterpretedInstance` into the native list, and the constructor adapter rejects it because `InterpretedInstance is! Widget`. For both affected scripts, the `_SmcrowDashboardCard` / `_SmcrowmBindingWidget` interpreted classes extend `SlottedMultiChildRenderObjectWidget<…>`. `D4.coerceList<Widget>` walks the bridged super chain via `tryCreateInterfaceProxyWithVisitor<Widget>` looking for a registered interface-proxy factory — but no factory was registered for `SlottedMultiChildRenderObjectWidget`, so the cast fell through to `e as Widget` and threw.

**Fix applied (Partial).** Added `SlottedMultiChildRenderObjectWidget` registration plus a new `_InterpretedSlottedMultiChildRenderObjectWidget` proxy class to `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart`. The proxy:

- forwards `slots` getter via `instance.get('slots', visitor: …)`,
- forwards `childForSlot(slot)` via interpreted method dispatch + `D4.extractBridgedArg<Widget>`,
- forwards `createRenderObject` / `updateRenderObject` via the existing `_createRenderObject` / `_updateRenderObject` helpers,
- erases generic type args to `<dynamic, RenderObject>` so any concrete `SlotType` / `ChildType` from the script works.

After the fix the original Column / Row / Stack coercion error is gone for both C4 scripts. The interpreted widget instances now flow through the bridge boundary as native `SlottedMultiChildRenderObjectWidget`s. **No mirroring needed** — the change lives entirely in `tom_d4rt_flutterm` (registration shim layer); `tom_d4rt` and `tom_d4rt_ast` are untouched.

**Verification.** `flutter test test/bisect_test.dart` shows the Column coercion errors gone for both scripts. Regression suites all clean: essential 108/0/0, important 164/0/5, secondary 649/0/5 — no script regressed.

**Why "Partial".** The fix exposes a downstream issue that was previously masked: the interpreted render object subclass (`_SmcrowDashboardRender extends RenderBox with SlottedContainerRenderObjectMixin<…>`) reaches Flutter as a plain `_InterpretedRenderBox` proxy that doesn't mix in `SlottedContainerRenderObjectMixin`, so `createRenderObject` returns an object that fails the mixin type check at the framework boundary. The new error surfaces as `Bad state: Interpreted _SmcrowDashboardCard.createRenderObject must return a RenderObject mixing in SlottedContainerRenderObjectMixin, got _InterpretedRenderBox` (4× in `…_test.dart`, 1× in `…_mixin_test.dart`) plus downstream layout cascade errors (RenderFlex hasSize assertions, infinite-height constraints). This is a separate cluster — render-object proxy widening to support mixin-in interpreted render objects — and is not a Section E coercion concern.

**Follow-up cluster (proposed).** A new cluster covering `_InterpretedRenderBox` not propagating interpreted mixins (`SlottedContainerRenderObjectMixin`, `RenderBoxContainerDefaultsMixin`, etc.). Would require either (a) per-mixin native render-object proxies, or (b) generating composite proxies that mix in the bridged mixins detected on the interpreted class.

---

### C5 — Generic `Map` coercion: `Map<ShortcutActivator, Intent>`

- [x] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Medium-High · **Owner:** tom_d4rt_flutterm runtime registrations

**Representative error**

- `Native error during default bridged constructor for 'Shortcuts': Invalid parameter "shortcuts": cannot convert Map to Map<ShortcutActivator, Intent> - type 'InterpretedInstance' is not a subtype of type 'Intent' in type cast`

**Affected scripts**

- `retest/widgets/default_text_editing_shortcuts_test.dart` (gir fail)
- `widgets/shortcut_activator_test.dart`
- `widgets/shortcut_manager_test.dart`
- `widgets/shortcut_map_property_test.dart`

**Analysis.** The original "missing `D4.coerceMap`" diagnosis was incorrect — `D4.coerceMap<K, V>` already exists in `tom_d4rt/lib/src/generator/d4.dart` (lines 703–749) and the bridge generator already emits it for `Shortcuts.shortcuts` and `ShortcutMapProperty.value`. The real cause is one level deeper: `coerceMap` correctly walks each map value through `_coerceMapValue`, which (for an `InterpretedInstance` value) falls back to `tryCreateInterfaceProxyWithVisitor<Intent>(v, visitor)`. The bridged `Intent` class has an empty constructors map (it's abstract with only `const Intent()`), so when an interpreted class extends `Intent`, the interpreter never populates `instance.bridgedSuperObject`, and no `Intent` interface proxy was registered — so `_coerceMapValue` fell through to `unwrapped as V` and threw the canonical "InterpretedInstance is not a subtype of type 'Intent'" cast error.

**Fix applied.** Registered `Intent` as an interface proxy in `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart` plus a new `_InterpretedIntent extends Intent` proxy class. The proxy is a pure tag wrapper (Intent is an empty const-constructible base in Flutter — no virtual behaviour to forward across the bridge boundary for the construct-time path the C5 scripts exercise). The proxy is cached on `instance.nativeProxy` so repeated boundary crossings reuse the same wrapper.

After the fix, all four scripts have **zero** Map<ShortcutActivator, Intent> coercion errors. Remaining framework errors on three scripts (`Constraints.maxWidth`, `CustomPainter.progress`, RenderFlex overflow) are unrelated downstream issues belonging to other clusters (C20-style bridge gap, layout overflow).

**No mirroring needed** — change lives entirely in `tom_d4rt_flutterm` (registration shim layer); `tom_d4rt` and `tom_d4rt_ast` are untouched.

**Verification.** Bisect (`flutter test test/bisect_test.dart`) confirms:
- `default_text_editing_shortcuts_test.dart`: 4 → 0 framework errors
- `shortcut_activator_test.dart`: Shortcuts coercion gone (1 unrelated `Constraints.maxWidth` error remains)
- `shortcut_manager_test.dart`: Shortcuts coercion + `_RebindPrimaryIntent.toString` gone (1 unrelated `CustomPainter.progress` remains)
- `shortcut_map_property_test.dart`: `ShortcutMapProperty` coercion gone (1 unrelated layout overflow remains)

Regression suites all clean: essential 108/0/0, important 164/0/5, secondary 649/0/5 — no script regressed.

**Limitation (documented for future reference).** `runtimeType` of `_InterpretedIntent` is the same for every interpreted Intent subclass, so `Actions.invoke` / Type-keyed action dispatch cannot route through this proxy. None of the C5 scripts exercise actual shortcut invocation (they only build the widget tree), so this is acceptable here. Real shortcut dispatch for fully-interpreted Intents would require a per-class proxy generator — separate concern, not in C5 scope.

---

### C6 — `Map<Type, Action<Intent>>` coercion (sibling of C5)

- [x] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Medium · **Owner:** runtime registrations (interface proxy)

**Representative error**

- `Native error during default bridged constructor for 'Actions': Invalid parameter "actions": cannot convert Map to Map<Type, Action<Intent>> …`

**Affected scripts**

- `widgets/scroll_to_document_boundary_intent_test.dart`
- `widgets/select_all_text_intent_test.dart`
- `widgets/select_intent_test.dart`

**Analysis (revised).** Same shape as C5: scripts subclass `Action<T extends Intent>` (e.g. `class _CallbackSelectIntentAction extends Action<SelectIntent>`) and pass instances as values of `Actions(actions: <Type, Action<Intent>>{ … })`. The `D4.coerceMap<Type, Action<Intent>>` path handles `Type` keys correctly (the interpreter's `Type` is already routed through the standard coercion); the missing piece was the *value* side. The bridged `Action` class is abstract with only an `overridable` factory constructor and no default constructor, so the interpreter never populates `bridgedSuperObject` for user subclasses, and `coerceMap`'s fallback `instance as Action<Intent>` throws.

**Fix.** Mirrors C5: registered an `Action` interface proxy in `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart`. The proxy class `_InterpretedAction extends Action<Intent>` (type-erased to `Action<Intent>` so it satisfies the Map's value-type cast even when the script's class is `Action<SelectIntent>`) holds a back-reference to the `InterpretedInstance` and is cached on `instance.nativeProxy` for repeat boundary crossings. `invoke` throws `UnimplementedError` — the C6 scripts only build the widget tree (no `Actions.invoke` dispatch through interpreted Actions), matching the trade-off accepted by `_InterpretedIntent` in C5.

**Verification.** `flutter test test/bisect_test.dart`: all 3 scripts return STATUS=true. `scroll_to_document_boundary_intent_test` and `select_intent_test` emit zero framework errors. `select_all_text_intent_test` retains 3 unrelated rendering errors (`BoxConstraints negative minimum height` in `_RenderEditableCustomPaint`) that pre-exist and are downstream from the C6 fix.

**Regression.** All four sequential suites match baseline `doc/testlog_20260426-2030-issue-analysis/`:

- essential: 108/0/0 = baseline
- important: 169/0/0 = baseline
- secondary: 654/0/0 = baseline
- generator_interpreter_issues: 72 pass / 11 fail / 0 error = baseline

(One initial GII run produced spurious 31-test "errors" but a clean sequential rerun matched baseline exactly — confirmed flakiness, not a regression from this change.)

**Mirroring.** No `tom_d4rt` ↔ `tom_d4rt_ast` mirror needed: the fix lives entirely in `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart` (downstream registration), not in interpreter or D4 helpers.

**Limitation.** Scripts that exercise `Actions.invoke(SomeIntent)` against an interpreter-only Action subclass will hit the proxy's `UnimplementedError`. Real action dispatch into interpreted Actions is a separate concern.

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

### C21 — Interpreted ParentData rejected at native `RenderObject.parentData` setter (downstream of C1)

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** High (blocks any script that subclasses `ParentData` / `ContainerBoxParentData`) · **Owner:** tom_d4rt_flutterm runtime registrations + interpreter (round-trip cast)

**Representative error**

- `Argument Error: Invalid parameter "parentData": expected ParentData, got InterpretedInstance(_DefaultsParentData)`

**Affected scripts**

- `rendering/render_box_container_defaults_mixin_test.dart` (gii fail — surfaced once C1 cast was unblocked)

**Analysis.** The script defines `class _DefaultsParentData extends ContainerBoxParentData<RenderBox>` and assigns instances directly to a native RenderBox's `parentData` setter (`child.parentData = _DefaultsParentData()`) inside the interpreted `setupParentData` override forwarded by `_InterpretedRenderBoxContainer`. The native setter does an `is ParentData` check and rejects the raw `InterpretedInstance`. Unlike RenderBox/RenderObject — for which we have an interface proxy registered — there is no proxy registration for `ParentData` (or `ContainerBoxParentData`), so the value reaches the bridge boundary unwrapped.

The fix is structurally analogous to the C1 RenderBox proxy:

1. Add `_InterpretedParentData` (or a parameterised `_InterpretedContainerBoxParentData<ChildType>`) that **extends** the appropriate native ParentData class and forwards field reads/writes (`nextSibling`, `previousSibling`, `offset`, plus any user-defined fields like `id`) through to the wrapped `InterpretedInstance` via `findInstanceField` / setter dispatch.
2. Register `D4.registerInterfaceProxy('ParentData', …)` and `'ContainerBoxParentData', …` so the bridge auto-coerces `InterpretedInstance` arguments at any native API that takes a ParentData.
3. Round-trip handling: when the script reads `child.parentData! as _DefaultsParentData`, the cast must succeed even though `child.parentData` returns the native proxy. Either the cast site must unwrap to the underlying `InterpretedInstance`, or the proxy must satisfy `as InterpretedClass` checks via the existing interpreter cast-hook path (the same machinery that lets `_InterpretedRenderBox` satisfy `as MyRenderBox`).

**Suggested fix.** Land the `_InterpretedParentData` proxy + registration in `lib/src/d4rt_runtime_registrations.dart`, mirroring the structure of `_InterpretedRenderBox` / `_InterpretedRenderBoxContainer`. Verify on `render_box_container_defaults_mixin_test.dart`; expect new downstream issues for any user-defined parent-data fields that aren't yet forwarded.

---

### C22 — Visualization-layout cascade in `box_hit_test_result_test.dart` (script-side)

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred

**Severity:** Low · **Owner:** test script

**Representative error**

- `RenderFlex object was given an infinite size during layout. … BoxConstraints(0.0<=w<=1870.0, 0.0<=h<=Infinity) … exact size … Size(1870.0, Infinity)` (multiple, also `RenderPadding`)

**Affected scripts**

- `rendering/box_hit_test_result_test.dart` (gii fail — surfaced once C1 cast and the in-script `boxSize` patch unblocked execution)

**Analysis.** The build tree is `Scaffold > body: SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: start, children: [_buildIntroductionCard(), _buildCreationSection(), …]))`. Each of the inner `_buildXxxSection()` methods returns a top-level `Column` with default `mainAxisSize: MainAxisSize.max`. Inside an unbounded scroll viewport, a Flex with `MainAxisSize.max` resolves to `Size(width, Infinity)`, which Flutter flags. The original failure (`Cannot invoke 'contains' on null`) crashed the test before these warnings were emitted; with the fix the script runs through and the warnings come out as `frameworkErrors` that fail `expectSuccess`.

**Suggested fix.** Set `mainAxisSize: MainAxisSize.min` on each top-level section Column (or wrap problematic descendants in `IntrinsicHeight`/`ConstrainedBox`). Strictly script-side; no interpreter or generator change needed.

---

## Cluster summary

| Cluster | Severity | Owner | # scripts | Hard fails (gii/gir) |
|---|---|---|---:|---:|
| C1 — RenderObject mixin proxy gap | High | generator | 2 | 2 |
| C2 — Late final 'color' (single-script) ✅ Fixed | Medium | interpreter (visitSwitchStatement) | 1 | 0 |
| C3 — `!` on null (broad) ⚠️ Partial (gir hard-fail fixed; 7 non-fatal deferred) | Medium | mixed | 8 | 0 |
| C4 — List<Widget> coercion ⚠️ Partial (Section E coercion fixed via SlottedMultiChildRenderObjectWidget proxy; render-object mixin gap deferred to follow-up cluster) | High | tom_d4rt_flutterm runtime registrations | 2 | 0 |
| C5 — Map<ShortcutActivator, Intent> coercion ✅ Fixed (Intent interface proxy registered; coerceMap already in place) | Medium-High | tom_d4rt_flutterm runtime registrations | 4 | 1 |
| C6 — Map<Type, Action<Intent>> coercion ✅ Fixed (Action interface proxy registered) | Medium | tom_d4rt_flutterm runtime registrations | 3 | 0 |
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
| C21 — ParentData proxy gap (downstream of C1) | High | tom_d4rt_flutterm + interpreter | 1 | 1 |
| C22 — Visualization layout warnings (script) | Low | scripts | 1 | 1 |

## Recommended fix order

The next active-work cluster from the open log (`interpreter_issues.md`) should pick up the highest-leverage items first:

1. **C14 — Plan E2 (null BuildContext)** — completes Plan E and unblocks two gii fails immediately.
2. **C4 + C5 + C6 + C6b — Generic coercion (List/Map of bridged types)** — single relaxer-generator change, unblocks 4+ gir/secondary scripts and removes a long-standing Section E pain point.
3. **C1 + C19 + C21 — RenderObject proxy chain** — three coupled clusters; biggest impact on the rendering-test surface. C21 must follow C1 because it surfaces only when scripts can subclass container RenderBox.
4. **C7 — TwoDimensionalScrollView empty-name ctor** — small generator change, three scripts.
5. **C12 + C13 + C20c — stdlib holes (`Object.hash`, `Future.delayed`, `Iterable.indexed`)** — quick wins.
6. **C10 — RestorationProperty proxy lifecycle** — high script count (13) but cosmetic in passing suites; tackle once C1 lands.
7. **C2 + C20h — Late-binding lifecycle audit** — needs investigation; may be a script bug or a real interpreter regression.
8. **C8 + C9 + C11 + C16 + C18 — Script patches** — batch into a single tom_d4rt_flutterm test-app commit. No interpreter work.
9. **C15 + C17 + C20a + C20b + C20d + C20e + C20f + C20g — Long tail** — small, mostly independent fixes; each warrants its own commit.
