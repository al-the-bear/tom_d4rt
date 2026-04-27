# Test Log 20260427-1339 — Post-C22 Issue Analysis

**Run id:** `20260427-1339-post-c22`
**Git rev:** `86cf522c` (Fix C22: ListView replaces SingleChildScrollView in `box_hit_test_result_test`)
**Date:** Mon Apr 27 13:39 — 14:18 CEST 2026
**Total wall time:** 39 m 19 s
**Captured artefacts:** `*.result.json` per suite, `*.log.txt` per suite, `combined.log.txt` (sequential timeline), `_fe_summary.txt`, `_fe_index.txt`, `run_metadata.txt`.

This run captures the framework-error landscape *after* C22 closed in
the prior `testlog_20260426-2030-issue-analysis/` campaign. The goal is
to surface (a) genuine test failures, (b) Flutter framework errors that
do not cause test failures (overflow, late-init, layout-cascade noise),
and (c) carry-over issues that remain open from prior clusters.

The 11 test files were run **serially** in a single process (per the
`tom_d4rt_flutterm` non-obvious rule that flutter test runs in this
package must not be parallelised). `D4RT_SKIP_BRIDGE_REGEN=1` was set so
bridge regeneration was skipped and the existing `*.b.dart` files were
exercised directly.

---

## Run summary

| Suite | Pass | Skip | Fail | Scripts with FE | Notes |
|---|---|---|---|---|---|
| `essential_classes_test`             | 108 |  0 |   0 | 1  | clean — 1 carry-over FE in `widgets/form_test.dart` |
| `important_classes_test`             | 164 |  5 |   0 | 0  | fully clean |
| `secondary_classes_test`             | 649 |  5 |   0 | 15 | suite passes; FE noise on 15 widget/rendering scripts |
| `hardly_relevant_classes_1_test`     |  80 |  1 | 124 | 0  | **engine cascade** — see D1 below |
| `hardly_relevant_classes_2_test`     | 203 |  0 |   0 | 0  | clean |
| `hardly_relevant_classes_3_test`     | 199 |  2 |   0 | 0  | clean |
| `hardly_relevant_classes_4_test`     | 227 |  0 |   0 | 1  | one C20b carry-over (`fractional_translation_test`) |
| `hardly_relevant_classes_5_test`     | 230 |  0 |   0 | 38 | suite passes; FE noise concentrated in `widgets/` |
| `interactive_tests_test`             |   6 |  0 |   0 | 0  | clean |
| `generator_interpreter_issues_test`  |  78 |  1 |   4 | 4  | 4 gii fails, all FE-asserting |
| `generator_interpreter_retest_test`  |  45 | 11 |   2 | 2  | 2 gir fails (theme_extension, raw_radio) |

**Pass deltas vs prior baseline (testlog_20260426-2030):** essential
108/0/0 (=), important 164/5/0 (=), secondary 649/5/0 (=), gii 78/1/4
(was 71/1/11 at prior log close — **+7 pass / -7 fail**, mostly C22 +
plan-D/E fixes), gir 45/11/2 (= prior).

The hardly_relevant suites are new in this run. They were not part of
the prior cluster docs, so the noisy FE counts there are not regressions
but newly surfaced data.

---

## How clusters were derived

For each completed `*_test.log.txt` we grepped the `[METRIC]` lines for
`frameworkErrors=[1-9]` and the `⚠️  FRAMEWORK ERROR` blocks for the
first error message per script. Failing tests (suite-level `[E]`
markers) were extracted from the `_test.result.json` files via
`jq 'select(.type=="error")'`. Bucketing was by leading exception family
(receiver type for null-receiver methods, layout-cascade for
`BoxConstraints` chains, native-coercion family for "Invalid parameter"
errors at bridge boundaries, etc.).

The new clusters are listed first (D1–D8), followed by the still-open
carry-over clusters from the prior testlog and from
`doc/interpreter_issues.md`.

---

## D1 — `dart_ui/image_sampler_slot_test.dart` engine cascade in hardly_relevant_classes_1

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred · **Severity:** Critical · **Owner:** test runner / script-side

**Symptom.** `hardly_relevant_classes_1_test` reported 124 test failures
(every dart_ui + gestures/* script after `image_sampler_slot_test.dart`
timed out at 30 s, then a transport-failure cascade with
`clearMs=735219` and `status=clear_failed`):

```
01:02 +79: dart_ui/ image_sampler_slot_test.dart
[METRIC] script=dart_ui/image_sampler_slot_test.dart …
        clearMs=117 readMs=0 bundleMs=54 httpMs=1272 totalMs=1445
        status=success httpStatus=200 outputLines=0 frameworkErrors=0
01:03 +80: dart_ui/ isolate_name_server_test.dart
  Skip: IsolateNameServer is not supported by the d4rt interpreter
01:03 +80 ~1: dart_ui/ key_event_device_type_test.dart
01:33 +80 ~1 -1: dart_ui/ key_event_device_type_test.dart [E]
  TimeoutException after 0:00:30.000000: Test timed out after 30 seconds.
…  (124 such timeouts, then transport_error cascade)
```

Every subsequent test in the suite — both the remaining `dart_ui/`
scripts and the `gestures/` scripts — timed out. Eventually the runner
recovered after 12 minutes of `clear_failed` retries. None of the
follow-up tests have framework errors; they never ran.

**Root cause (running theory).** The `[RESOLVED 2026-04-26]
ui.FragmentProgram / ui.FragmentShader timing race` entry in
`doc/interpreter_issues.md` records that touching `ui.FragmentProgram`
synchronously in `initState` crashes the Flutter Linux test engine
asynchronously after HTTP 200. The fix applied a single-microtask yield
(`await Future<void>.delayed(Duration.zero)`) before the type probes,
verified in `bisect_test.dart`. That one-script bisect run still passes
(`status=success outputLines=0 frameworkErrors=0` here). **But when the
script runs as part of a multi-test suite, the destabilisation persists
to the next test**: `key_event_device_type_test` at 01:03 is the first
casualty. The yield is sufficient for the engine to finish the *current*
test cleanly but is not sufficient to leave the engine in a state that
the *next* test can drive.

**Suggested fix.** Either (a) move `image_sampler_slot_test.dart` into a
dedicated suite or skip it from `hardly_relevant_classes_1`, or (b)
extend the in-script delay so the FragmentProgram pipeline finishes
initialising before the script returns, or (c) tear down and re-spawn
the test app process after this script. Option (a) is the lowest-risk
short-term workaround; (c) is the most robust. The previous fix's
verification only covered the one-script bisect — it did not exercise
the suite-level path. Note that the same script is in the
`hardly_relevant_classes_1` bundle, so simply removing it from the
suite list eliminates the cascade.

**Affected scripts**

- Trigger: `dart_ui/image_sampler_slot_test.dart`
- Cascading 124 timeouts: every `dart_ui/*` script after it
  (`key_event_device_type`, `key_event_type`, `offset_engine_layer`,
  `opacity_engine_layer`, `painting_style`, `path_fill_type`,
  `path_operation`, `picture_rasterization_exception`, …) and every
  `gestures/*` script (`pointer_up_event`, `polynomial_fit`,
  `primary_pointer_gesture_recognizer`, `sampling_clock`,
  `tap_and_drag_gesture_recognizer`, `tap_gesture_recognizer`,
  `tap_move_details`, `velocity_estimate`, `velocity_tracker`).

---

## D2 — Field/getter access on bridged mixin instance reaches nowhere

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred · **Severity:** Medium · **Owner:** interpreter (mixin field/getter resolution)

**Representative error**

- `Runtime Error: Undefined property or method 'hasError' on bridged instance of 'RestorationMixin'.`
- `Runtime Error: Undefined property or method '_controller' on bridged instance of 'SingleTickerProviderStateMixin'.`
- `Runtime Error: Undefined property or method 'maxWidth' on bridged instance of 'Constraints'.`
- `Runtime Error: Undefined property or method 'progress' on bridged instance of 'CustomPainter'.`

**Affected scripts**

- `widgets/form_test.dart` (essential — only FE in essential suite)
- `widgets/scroll_position_with_single_context_test.dart` (hr5 — `_controller`)
- `widgets/shortcut_activator_test.dart` (hr5 — `maxWidth`)
- `widgets/shortcut_manager_test.dart` (hr5 — `progress`)

**Analysis.** Scripts that mix in a bridged mixin (`RestorationMixin`,
`SingleTickerProviderStateMixin`, …) declare *interpreter-side* fields
or getters (`_controller`, `_animationController`, etc.) and then
reference them later in a `build()` or `restoreState()` callback. The
interpreter's property-resolution path for an `InterpretedInstance`
walks the bridged-super chain looking for the property *before* it
checks interpreted-side instance state, so when the field is
declared in the interpreted class but the lookup arrives via the
bridged-mixin lifecycle (e.g., `restoreState` invoked by
`RestorationMixin`), it queries the bridged side first, finds nothing,
and throws "Undefined property or method on bridged instance of …".

The `hasError` / `maxWidth` / `progress` cases are different: those
are *real* getters on the bridged class that the bridge generator
didn't expose. `Form.hasError` is a getter on `FormState`/`FormFieldState`;
`BoxConstraints.maxWidth` is exposed but `Constraints.maxWidth` (the
abstract base) is not — the script likely refers to a `Constraints` typed
variable. `CustomPainter.progress` is a script-side field on a
`with`-mixed in CustomPainter subclass — same shape as the
`_controller` case.

**Suggested fix.** Two parts:

1. For interpreted-side declared fields/getters, the property-resolution
   order must consult `instance.fields` / `instance.klass.findGetter(...)`
   *before* dispatching to the bridged super. Mirror across
   `tom_d4rt/lib/src/interpreter_visitor.dart` and
   `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`.
2. For genuinely missing bridge-side getters
   (`Form.hasError`, `Constraints.maxWidth`), audit the bridge
   generator's getter emission for abstract-base classes and ensure
   the interface getter is exposed.

---

## D3 — `late` instance field on a bridged-mixin lifecycle path reads as un-assigned

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred · **Severity:** Medium · **Owner:** interpreter (field-lifecycle scope)

**Representative error**

- `Runtime Error: LateInitializationError: Late variable '_<...>Controller' without initializer is accessed before being assigned.`

**Affected scripts**

- `widgets/restorable_string_test.dart` — `_productNameController`
- `widgets/restorable_string_n_test.dart` — `_feedbackCtrl`
- `widgets/restoration_mixin_test.dart` — `_nameController`
- `widgets/text_selection_gesture_detector_builder_delegate_test.dart` — `_builder`

**Analysis.** This is a sibling of the prior C20h cluster. Scripts
declare `late <ControllerType> _ctrl;` at class level and assign in
`initState()` / `restoreState()`. The first read happens via a getter
or a build-callback that runs **before** `initState` actually executes
the assignment in the interpreter — most likely because the bridged
mixin's lifecycle (`State.didChangeDependencies` → `build`) drives
through the native `_InterpretedState` proxy and the build-callback
runs before the script's `initState` finishes.

Note that `restorable_property_test.dart` (the C20h script) is now
clean (`frameworkErrors=0`), so an earlier fix unblocked the simpler
shape. The remaining four scripts share the `with RestorationMixin` /
`with TextSelectionGestureDetectorBuilderDelegate` pattern — the late
field belongs to the interpreted class and is read by a method
inherited from the bridged mixin.

**Suggested fix.** Trace `LateVariable` setter scope binding when the
setter is invoked from an interpreted method that was reached via a
bridged-super dispatch. Likely the setter writes to a different
`InterpretedInstance` than the getter reads from (proxy double-binding).

---

## D4 — `RestorableProperty<T>` interface proxy missing for `RestorationMixin.registerForRestoration`

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred · **Severity:** Medium · **Owner:** tom_d4rt_flutterm runtime registrations

**Representative error**

- `Native error in bridged mixin method 'RestorationMixin.registerForRestoration': Argument Error: Invalid parameter "property": expected RestorableProperty<Object?>, got InterpretedInstance(_<...>)`

**Affected scripts**

- `widgets/restorable_property_test.dart`
- `widgets/restorable_value_test.dart`

**Analysis.** Same shape as C5 (`Intent`) and C6 (`Action<T>`):
interpreted subclass extends an abstract bridged base
(`RestorableProperty<T>`) but no interface proxy is registered, so the
`InterpretedInstance` reaches the bridge boundary unwrapped and is
rejected by the parameter type check.

**Suggested fix.** Register a `RestorableProperty<Object?>` interface
proxy in `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart`,
mirroring `_InterpretedIntent` / `_InterpretedAction`. The proxy needs
to forward `createDefaultValue`, `fromPrimitives`, `toPrimitives`,
`initWithValue`, `dispose` to the interpreted instance, plus the
listenable surface (`addListener` / `removeListener` /
`notifyListeners`) since `RestorableProperty` extends
`ChangeNotifier`. Cache on `instance.nativeProxy`.

---

## D5 — Section E carry-over: `PreferredSizeWidget?` and `Widget` coercion at native bridge boundary

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred · **Severity:** Medium · **Owner:** generator + tom_d4rt_flutterm registrations

**Representative errors**

- `Native error during default bridged constructor for 'Scaffold': Argument Error: Invalid parameter "appBar": expected PreferredSizeWidget?, got InterpretedInstance(_<...>AppBar)`
- `Native error during static bridged method call 'merge' on DefaultTextStyle: Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(_WbnPipeBackdrop)`

**Affected scripts** (8)

- `widgets/widgets_binding_observer_test.dart` (`_WboAppBar`)
- `widgets/sliver_multi_box_adaptor_widget_test.dart` (`_SmbawGalleryAppBar`)
- `widgets/snapshot_mode_test.dart` (`_SmodeAppBar`)
- `widgets/undo_text_intent_test.dart` (`_UtiLabAppBar`)
- `widgets/viewport_element_mixin_test.dart` (`_VemAppBar`)
- `widgets/viewport_notification_mixin_test.dart` (`_VnmAppBar`)
- `widgets/widget_inspector_service_test.dart` (`_WisvAppBar`)
- `widgets/widgets_binding_test.dart` (`_WbnPipeBackdrop` → `Widget` via `DefaultTextStyle.merge`)

**Analysis.** Same family as C4. Two separate gaps:

1. `PreferredSizeWidget` is a marker interface (`abstract class
   PreferredSizeWidget extends Widget`); no interface proxy is
   registered, so an interpreted `_<...>AppBar extends PreferredSize`
   reaches `Scaffold.appBar` as a bare `InterpretedInstance` and the
   Scaffold constructor adapter rejects it.
2. `DefaultTextStyle.merge`'s `child:` parameter is `Widget` (not
   `Widget?`), and the script's `_WbnPipeBackdrop` is a plain
   interpreted `StatelessWidget`. The `D4.coerceList<Widget>` fast-path
   handles `List<Widget>` but the single-child `Widget` parameter goes
   through a different code path that doesn't consult the registered
   `Widget` proxy.

**Suggested fix.** Register a `PreferredSizeWidget` interface proxy
that delegates `preferredSize` to the interpreted instance (returns the
`Size` from the script's `preferredSize` getter), and expose the
`Widget` interface proxy on the single-arg coercion path used by static
bridged methods like `DefaultTextStyle.merge`.

---

## D6 — Layout cascade: `BoxConstraints forces an infinite height/width` + `RenderBox was not laid out` (script-side)

- [ ] Fixed  - [x] Partial  - [ ] Reverted/Deferred · **Severity:** Low (cosmetic, script-only) · **Owner:** test scripts

**Representative errors**

- `BoxConstraints forces an infinite height.` (recurring)
- `RenderBox was not laid out: <RenderObject> NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE` (cascade)
- `'package:flutter/src/rendering/object.dart': Failed assertion: line 5737 pos 14: '!childSemantics.renderObject._needsLayout': is not true.`
- `BoxConstraints has a negative minimum height.` (separate flavour)
- `BoxConstraints forces an infinite width.` (single instance)
- `RenderParagraph object was given an infinite size during layout.`
- `RenderShrinkWrappingViewport does not support returning intrinsic dimensions.`

**Affected scripts** (16)

| Script | Suite | FE count | Flavour |
|---|---|---|---|
| `widgets/scroll_position_types_test.dart` | secondary | 19 | infinite height + needsLayout |
| `widgets/restorable_bool_test.dart` | secondary | 19 | infinite height + needsLayout |
| `widgets/text_magnifier_configuration_test.dart` | secondary | 6 | infinite height + null-check |
| `widgets/widget_test.dart` | secondary | 26 | infinite height + needsLayout |
| `widgets/scroll_increment_details_test.dart` | hr5 | 21 | infinite height |
| `widgets/scrollbar_painter_test.dart` | hr5 | 18 | infinite height |
| `widgets/select_all_text_intent_test.dart` | hr5 | 3 | negative minimum height |
| `widgets/transpose_characters_intent_test.dart` | hr5 | 2 | negative minimum height |
| `widgets/undo_history_value_test.dart` | hr5 | 3 | negative minimum height |
| `widgets/unfocus_disposition_test.dart` | hr5 | 27 | negative minimum height |
| `widgets/update_selection_intent_test.dart` | hr5 | 3 | negative minimum height |
| `widgets/weak_map_test.dart` | hr5 | 15 | infinite height |
| `widgets/widget_state_color_test.dart` | hr5 | 9 | infinite height |
| `widgets/widget_state_text_style_test.dart` | hr5 | 21 | infinite height |
| `widgets/web_browser_detection_test.dart` | hr5 | 19 | infinite width |
| `widgets/standard_component_type_test.dart` | hr5 | 13 | RenderParagraph infinite size |
| `widgets/sliver_multi_box_adaptor_element_test.dart` | hr5 | 6 | RenderShrinkWrappingViewport intrinsic |
| `widgets/restorable_double_test.dart` | secondary | 1 | overflow 17 px |

**Analysis.** Same root cause as C8 / C22 (the cluster fixed in this
campaign): the test widgets place a `Column` containing `Expanded`
children inside an unbounded-height parent — typically
`SingleChildScrollView`, `LayoutBuilder` returning a sliver, or a `Row`
with `mainAxisSize: max`. The interpreter is faithfully reporting what
Flutter says; this is an authoring oversight in the test corpus.

C22 was closed in the prior campaign by replacing
`SingleChildScrollView+Column+Expanded` with `ListView` in
`box_hit_test_result_test.dart`. The same pattern applies to all 18
scripts in this cluster: drop the `SingleChildScrollView`, drop the
outer `Column`, list the section widgets directly as `ListView`
children, and either remove `Expanded` or wrap the section's content in
a `SizedBox(height: …)`.

**Suggested fix.** Patch each script with the C22 ListView-replacement
pattern. The negative-minimum-height variant additionally needs the
script to clamp its computed height to `>= 0` (or wrap in a `SizedBox`
that won't go negative).

**Status — Partial.** No script has been patched in this run. The C22
fix demonstrated the pattern; the remaining 18 scripts need the same
treatment, one commit per script (script-only changes, single retest
sufficient per the project's regression rules).

---

## D7 — `createRenderObject` must return a `SlottedContainerRenderObjectMixin`-mixed render object

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred · **Severity:** Medium · **Owner:** generator (proxy generator) + tom_d4rt_flutterm runtime registrations

**Representative error**

- `Bad state: Interpreted _<...>.createRenderObject must return a RenderObject mixing in SlottedContainerRenderObjectMixin, got _InterpretedRenderBox`

**Affected scripts** (3)

- `widgets/slotted_multi_child_render_object_widget_test.dart` (6 errors — `_SmcrowDashboardCard`)
- `widgets/slotted_multi_child_render_object_widget_mixin_test.dart` (8 errors — `_SmcrowmBindingWidget`)
- `widgets/slotted_render_object_element_test.dart` (1 error — `_SroeSlottedFrameWidget`)

**Analysis.** The C4 "follow-up cluster" predicted in the prior
testlog. C4 closed the *Section E coercion* path
(`SlottedMultiChildRenderObjectWidget` interface proxy added) so the
interpreted widget instances now flow through the bridge boundary. But
the interpreted render object subclass — `_<...>Render extends RenderBox
with SlottedContainerRenderObjectMixin<…>` — reaches Flutter as a plain
`_InterpretedRenderBox` proxy that does **not** mix in
`SlottedContainerRenderObjectMixin`. Flutter's
`SlottedMultiChildRenderObjectElement` asserts the slot mixin is
present and throws.

**Suggested fix.** Two coordinated options:

1. Generate per-mixin native render-object proxies: a
   `_InterpretedSlottedRenderBox<S>` that mixes in
   `SlottedContainerRenderObjectMixin<S, RenderBox>`, registered as
   the `RenderBox` factory whenever the script's class chain includes
   `SlottedContainerRenderObjectMixin` (extension of the
   `_classChainHasBridgedMixin` dispatch already used for the
   container variant in C1).
2. Generate composite proxies that mix in the bridged mixins detected
   on the interpreted class, similar to how the proxy generator
   currently handles `RenderAligningShiftedBox` and the
   container-mixin variant.

Option (1) is the smallest reliable fix — adds one new factory class
per known slot-mixin. Option (2) is the right long-term answer.

---

## D8 — Misc interpreter / bridge gaps

- [ ] Fixed  - [ ] Partial  - [ ] Reverted/Deferred · **Severity:** Mixed · **Owner:** interpreter + bridge generator

**Issues bucketed here**

| Sub | Error | Affected script |
|---|---|---|
| D8a | `Unimplemented Error: Compound assignment operator += not handled for types double and null` | `widgets/restorable_double_n_test.dart` |
| D8b | `Cannot invoke method 'padLeft' on null. Use '?.' for null-aware method invocation.` | `widgets/restorable_route_future_test.dart` |
| D8c | `Cannot invoke method 'toString' on null.` | `widgets/scroll_context_test.dart` |
| D8d | `Cannot access property 'pixelsPerSecond' on null.` | `widgets/scroll_drag_controller_test.dart` |
| D8e | `Null check operator used on a null value` | `widgets/scroll_deceleration_rate_test.dart` (8) |
| D8f | `Missing required argument for 'd' in function '<anonymous>'.` | `widgets/semantics_gesture_delegate_test.dart` (3) |
| D8g | `RawTooltipState is a SingleTickerProviderStateMixin but multiple tickers were created.` | `widgets/two_dimensional_child_list_delegate_test.dart` |
| D8h | `A SemanticsData object with label "Information card" had a null textDirection.` | `rendering/custom_painter_semantics_test.dart` (gii fail) |

**Analysis.**

- **D8a** — Interpreter's compound assignment operator (`+=`) doesn't
  handle the `double + null` case (script reads a nullable double and
  adds to it). Either coerce `null` to `0.0` or surface a clearer
  type-error message.
- **D8b/c/d** — Receiver-is-null on method call. Script-side null
  guards missing; the interpreter is faithfully reporting the bug.
  Patch each script with `?.` or a non-null fallback.
- **D8e** — C3 carryover. Script-side `!` on a null receiver.
- **D8f** — `Missing required argument for 'd' in function
  '<anonymous>'.` The proxy's typedef-callback adapter doesn't supply
  the named-but-required argument when the closure is invoked through
  the bridge boundary.
- **D8g** — Real Flutter assertion: `RawTooltipState` mixes in
  `SingleTickerProviderStateMixin` but creates more than one ticker.
  Either fix the script to reuse a single ticker or change the
  interpreted class to use `TickerProviderStateMixin`.
- **D8h** — `Semantics(label: …)` requires `textDirection` when the
  parent node has none; script omits it in the script's `Semantics`
  wrapper. Patch the script.

---

# Carry-over open clusters from prior testlog and `interpreter_issues.md`

The following clusters were **not** closed in the prior campaign and
remain open or partial. They are duplicated here for cross-reference;
the authoritative status lives in
`doc/testlog_20260426-2030-issue-analysis/error_analysis.md` and
`doc/interpreter_issues.md`.

## C1 — `_InterpretedRenderBox` mixin proxy gap (Partial)

Container-mixin dispatch landed in 04-26 fix; downstream slot-mixin
gap is now D7 above. RenderBox proxy still does not propagate
arbitrary interpreted mixins. **Open follow-up:** mixin-aware composite
proxies.

## C3 — `Null check operator used on a null value` (Partial)

Broad symptom across multiple scripts. Some instances closed by
script patches. New instances surfaced in this run on
`widgets/scroll_deceleration_rate_test.dart` (8 occurrences) — folded
into D8e above.

## C4 — Section E coercion (Partial)

`SlottedMultiChildRenderObjectWidget` proxy landed; downstream is D7.
`PreferredSizeWidget` and single-arg `Widget` parameters still fail —
folded into D5 above.

## C6b — `cannot convert List to List<ThemeExtension<ThemeExtension<dynamic>>>` (Open)

Higher-kinded generic in `ThemeData.extensions`. Surfaced again here
on `retest/material/theme_extension_test.dart` (gir fail). The
generator's relaxer doesn't recognise the nested generic.

## C7 — `TwoDimensionalScrollView` / `TwoDimensionalViewport` ctor missing (Reverted/Deferred)

Surfaced again on three hr5 scripts:
`widgets/two_dimensional_child_builder_delegate_test.dart`,
`widgets/two_dimensional_child_manager_test.dart`,
`widgets/two_dimensional_scrollable_state_test.dart`. Requires
super-arg-capture in the interpreter callable layer plus multi-method
proxies in the bridge package — substantial coordinated change. See
prior cluster doc for the implementation plan.

## C19 — `'!childSemantics.renderObject._needsLayout': is not true` (recurring)

Single gii-fail script `render_aligning_shifted_box_test.dart` still
emits 2 framework errors:

```
Runtime Error: Native error in bridged superclass method 'RenderAligningShiftedBox.alignChild':
  'package:flutter/src/rendering/shifted_box.dart': Failed assertion: line 374 pos 12: 'hasSize': is not true.
```

The 04-26 Plan-D Phase-2 fix ("RenderAligningShiftedBox + ParentDataWidget
interface proxies") landed but this script still trips the `hasSize`
assertion inside `alignChild`. Likely the proxy's `performLayout`
doesn't propagate `child.layout(parentUsesSize: true)` correctly.

## C20a, C20b, C20d, C20f, C20h₂ — Interpreter operator + statement-level gaps (Partial)

| Sub | Error | Script |
|---|---|---|
| C20a | `Unsupported binary operator "&"` | `widgets/widget_states_constraint_test.dart` (hr5, 1 FE) |
| C20b | `Unsupported for-loop type in collection literal: SForEachPartsWithPattern` | `widgets/fractional_translation_test.dart` (hr4, 1 FE) |
| C20d | `Native error in bridged superclass method 'State.setState': Build scheduled during frame.` | `rendering/render_box_container_defaults_mixin_test.dart` (gii fail), `rendering/render_custom_paint_test.dart` (gii fail) |
| C20f | `Error in generic constructor factory for 'RawRadio'` | `retest/widgets/raw_radio_test.dart` (gir fail) |
| C20h₂ | `LateInitializationError: Late variable '_<...>' without initializer` | `widgets/text_selection_gesture_detector_builder_delegate_test.dart` — folded into D3 |

C20a, C20b are real Dart-feature holes in the interpreter (user `&`
operator dispatch; `SForEachPartsWithPattern` in collection literals).
C20d (`setState` during frame) needs an interpreter trampoline that
defers the rebuild via `WidgetsBinding.instance.addPostFrameCallback`.
C20f is a generic constructor-factory bug in the generator.

## C21 — Interpreted `ParentData` proxy (Partial)

Representative error eliminated by 04-27 fix. The single driving
script (`rendering/render_box_container_defaults_mixin_test.dart`)
still fails gii, but on different downstream errors that belong to
C20d (`setState` during frame) and the layout cascade — folded into
D6 above.

## Plan E2 — Null `BuildContext` in `dependOnInheritedWidgetOfExactType` (open)

Two residual gii failures from `widgets/inherited_theme_test.dart` and
`widgets/inherited_widget_test.dart` (already closed in this run; not
present in current gii output). Likely an interpreted `static` helper
accepting `BuildContext context` that loses the captured context when
called from a closure. Tracked separately in
`doc/interpreter_issues.md` (Plan-E entry).

## Future cluster — Interpreted-extends-bridged `InheritedModel` proxy gap

Logged in `doc/interpreter_issues.md` cluster 26: scripts that subclass
`InheritedModel` and call
`InheritedModel.inheritFrom<T>(context, aspect: ...)` fail because the
interpreted subclass collapses to the same native `runtimeType`. Not
observed in this run (no script in the corpus exercises it after the
window-scope rewrites), but still architecturally open.

---

# Summary table (NEW clusters only)

| Cluster | Severity | Owner | Suite Scripts | Total FE |
|---|---|---|---|---|
| D1 — image_sampler_slot cascade  | Critical | runner / script | 1 → 124 cascading | 0 (timeouts) |
| D2 — bridged-mixin field access  | Medium   | interpreter     | 4               | 6 |
| D3 — late-field uninitialised    | Medium   | interpreter     | 4               | 4 |
| D4 — RestorableProperty proxy    | Medium   | flutterm regs   | 2               | 2 |
| D5 — Section E PreferredSize/Widget | Medium | generator + regs | 8             | 8 |
| D6 — layout cascade              | Low      | scripts         | 18              | ~228 |
| D7 — Slotted RO mixin            | Medium   | generator + regs | 3              | 15 |
| D8 — misc gaps                   | Mixed    | interp + scripts | 8              | ~27 |

Carry-over clusters (C1, C3, C4, C6b, C7, C19, C20a/b/d/f, C21,
Plan E2, InheritedModel proxy) detailed above.

---

# Key takeaways

1. **D1 (`image_sampler_slot` cascade) is the only critical blocker** —
   it is responsible for 124 of the 130 test failures across the run.
   Removing the script from `hardly_relevant_classes_1` (or moving it
   to a dedicated suite) immediately recovers ~95 % of the failures.
2. **D6 (layout cascade) is the biggest noise generator** but causes
   zero test failures because the affected suites (secondary, hr5)
   don't assert on `tester.takeException`. The C22 ListView pattern
   resolves these — 18 scripts to patch, each independent.
3. **Real interpreter bugs to fix are concentrated in D2, D3, D4** —
   each has a clear shape (mixin field resolution, late lifecycle,
   missing interface proxy) and a previously-tested fix template.
4. **D5 and D7 are completion work** for clusters that were closed
   *in part* in the prior campaign — the missing pieces are
   `PreferredSizeWidget` proxy and `SlottedContainerRenderObjectMixin`
   render-object proxy.
5. **D8 is a mixed bag** of small bugs, most of which are script-side
   patches except D8a (interpreter `+=` with null) and D8f (proxy
   callback's required-arg gap) which need code changes.

The `tom_d4rt_flutterm` interpreter test corpus is **fully clean** for
the essential / important / secondary / hr2-hr3-hr4 suites at suite
level (zero true failures). The remaining failures are concentrated in
hr1 (one trigger script), gii (4 known carry-overs), and gir (2 known
carry-overs).
