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
| `hardly_relevant_classes_4_test`     | 227 |  0 |   0 | 1  | ~~one C20b carry-over (`fractional_translation_test`)~~ — closed 2026-04-27 |
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

- [x] Fixed  - [ ] Partial  - [ ] Reverted/Deferred · **Severity:** Medium · **Owner:** generator + tom_d4rt_flutterm registrations

**Fix (2026-04-27).** Two-part landing:

1. **`PreferredSizeWidget` interface proxy** — added a new
   `_InterpretedPreferredSizeWidget extends StatelessWidget implements
   PreferredSizeWidget` adapter in
   `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart`, plus its
   `D4.registerInterfaceProxy('PreferredSizeWidget', …)` registration.
   `preferredSize` reads the script's getter via
   `instance.get('preferredSize', visitor: _visitor)` and unwraps native
   / bridged `Size`. `build` delegates to the interpreted instance's
   `build` method. Because the registered interface-proxy walk extends
   along `bridgedSuperclass` and `bridgedInterfaces` (with transitive
   supertypes), the existing `class _Foo extends StatelessWidget
   implements PreferredSizeWidget` pattern resolves correctly.
2. **Static-method dispatch wraps `withActiveVisitor`** — in
   `tom_d4rt/lib/src/interpreter_visitor.dart` (and mirrored in
   `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`) the
   `staticMethodAdapter` invocation is now wrapped in
   `D4.withActiveVisitor(this, …)`. `D4.getRequiredNamedArg<T>` and
   `extractBridgedArg<T>` no longer receive an explicit visitor on this
   path, so without the wrap they could not consult registered
   interface proxies; static bridges like `DefaultTextStyle.merge`
   therefore rejected interpreted `Widget` arguments. Constructor
   dispatch already had this wrap.

**Verification.**

- Bisect run on the 8 affected scripts (`doc/testlog_20260427-c4/c4_after_fix.log.txt`):
  - 6/8 scripts: framework errors 1→0 (clean fix).
  - `widgets_binding_observer_test.dart`: original
    `PreferredSizeWidget` rejection is gone; 3 new follow-ups surfaced
    that were previously masked by the early Scaffold-gate rejection
    (1× borderRadius non-uniform, 2× `RenderFlex` overflow 4.5 px).
    All cosmetic / script-authoring; not interpreter issues.
  - `snapshot_mode_test.dart`: original rejection gone; 1 follow-up
    (`RenderFlex` overflow 14 px). Cosmetic.
- Regression suites (with `D4RT_SKIP_BRIDGE_REGEN=1`):
  - Essential 108/0/0 — identical to baseline.
  - Important 164/0 with 5 skips (= 169) — identical to baseline.
  - Secondary 649/0 with 5 skips (= 654) — identical to baseline,
    minus one improvement: `widgets_binding_test.dart` no longer emits
    framework errors. No regressions.

**Files touched.**

- `tom_ai/d4rt/tom_d4rt/lib/src/interpreter_visitor.dart` — wrap static method dispatch in `D4.withActiveVisitor`.
- `tom_ai/d4rt/tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` — mirror of the above.
- `tom_ai/d4rt/tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart` — `PreferredSizeWidget` import + proxy registration + `_InterpretedPreferredSizeWidget` adapter class.

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

- [ ] Fixed  - [x] Partial  - [ ] Reverted/Deferred · **Severity:** Medium · **Owner:** generator (proxy generator) + tom_d4rt_flutterm runtime registrations
- **Resolution (2026-04-27):** Option (1) landed — see C1 above for
  the per-script results (createRenderObject assertion gone in all
  3 scripts; element_test fully clean; widget_test surfaces a new
  layout cascade rooted in slot-mixin private member access from
  interpreted scripts).

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

## C1 — `_InterpretedRenderBox` mixin proxy gap (Partial — slot-mixin variant landed 04-27)

**Status (2026-04-27):** Slot-mixin variant of the proxy landed.

**What changed.** `lib/src/d4rt_runtime_registrations.dart` now adds a
third proxy class `_InterpretedSlottedRenderBox extends RenderBox with
SlottedContainerRenderObjectMixin<dynamic, RenderBox>` and extends the
`'RenderBox'` interface-proxy dispatch to pick it when the interpreted
class chain contains a bridged `SlottedContainerRenderObjectMixin`
(checked via the existing `_classChainHasBridgedMixin` walker). The
container variant `_InterpretedRenderBoxContainer` (04-26) still
applies for `ContainerRenderObjectMixin`, with the plain
`_InterpretedRenderBox` as fallback.

The proxy implements `performLayout`, `paint`, `hitTest*`,
`setupParentData` (defaults to `BoxParentData`) and the four intrinsic
sizing methods, all routed through `_maybeInvoke` so script-side
overrides take precedence over native defaults. Type parameters are
erased to `<dynamic, RenderBox>` to satisfy element-side casts.

**Per-script effect** (bisect harness):

- `widgets/slotted_render_object_element_test.dart`: 1 → 0 FE (clean)
- `widgets/slotted_multi_child_render_object_widget_mixin_test.dart`:
  8 → 7 FE — the createRenderObject "must return a RenderObject mixing
  in SlottedContainerRenderObjectMixin" assertion is gone; the
  remaining 7 errors (1× `BoxConstraints forces an infinite height`,
  3× `RenderBox was not laid out`, 3× null-check) are the same
  upstream cascade already present in baseline.
- `widgets/slotted_multi_child_render_object_widget_test.dart`:
  6 → 12 FE — 5× createRenderObject + 1× `dart:ui/math.dart` assertion
  are gone; with `performLayout` now executing, a previously-masked
  cascade surfaces: 1× script-side null receiver on `child.size.height`,
  1× `_InterpretedSlottedRenderBox` NEEDS-PAINT, 7× downstream
  NEEDS-PAINT/`hasSize`, 3× null-check. Same shape as the C1 container
  variant exposing C21 in 04-26.

**Regression suites** (essential / important / secondary, run serial,
`D4RT_SKIP_BRIDGE_REGEN=1`): 108/0/0, 164/0/5, 649/0/5 — match the
post-C22 baseline. No regression.

**Why Partial.** The slot-mixin proxy variant (the planned C1 follow-up)
landed cleanly. The newly surfaced `widget_test` cascade is rooted
either in a script-side null in `_childFor(slot)?.size.height` access
or in the bridge not exposing the private `_childFor`/`_slotToChild`
to interpreted code. Capture artifacts:
`doc/testlog_20260427-c1-followup/{baseline,c1_after}_bisect.log.txt`,
`{essential,important,secondary}.log.txt`. Open follow-ups: the
private slotted-mixin member access in interpreted scripts, and
mixin-aware composite proxies for the general case.

## C3 — `Null check operator used on a null value` (Reverted/Deferred)

Broad symptom across multiple scripts. Some instances closed by
script patches in earlier runs. The post-C22 instance on
`widgets/scroll_deceleration_rate_test.dart` (8 occurrences, folded
into D8e above) was investigated this round — bisect log + attempted
fix logs in `doc/testlog_20260427-c3/`.

**Bisect finding.** The 8 errors are a single layout cascade
originating from `_TelemetryRow.build()` (Section 3 of the
`CustomScrollView`, lines 828–858), with the same pattern present in
`_CoastCurves.build()` (lines 1083–…). Both wrap a
`Row(crossAxisAlignment: CrossAxisAlignment.stretch, [Expanded(card),
SizedBox, Expanded(card)])` inside a `SliverToBoxAdapter`. The sliver
adapter passes bounded width but **unbounded height** down; the
cross-axis stretch propagates `h=Infinity` into each `Expanded` and
`ChildLayoutHelper.layoutChild` fires the `BoxConstraints forces an
infinite height` assertion. The downstream `RenderBox was not laid
out` and `Null check operator used on a null value` entries are the
framework's post-failure walk over half-laid-out boxes.

Bisect proof:

| Sections present | frameworkErrors | log |
| ---------------- | --------------- | --- |
| 1+2 only         | 0               | `c3_bisect_no_sections3_5.log.txt` (then no 6–11) |
| 3 only           | 8               | `c3_bisect_section3_only.log.txt` |
| 6–11 removed     | 8               | `c3_bisect_no_sections6_11.log.txt` |

**Why the obvious script-side fixes don't help.** Two textbook
workarounds were tried; both made it *worse* (8 → 11 errors):

| Attempt                                     | Errors | Log |
| ------------------------------------------- | ------ | --- |
| Wrap each Row in `IntrinsicHeight(...)`     | 11     | `c3_after_intrinsic.log.txt` |
| Drop `stretch` → `CrossAxisAlignment.start` | 11     | `c3_after_no_stretch.log.txt` |

Under native Flutter `IntrinsicHeight` is the canonical resolution;
under d4rt it routes intrinsic queries through proxy
render-objects (`_InterpretedSlottedRenderBox`, the slot-mixin
proxies) and adds further null-checks instead of removing them.
Removing `stretch` lets the children self-size but leaves
`_TelemetryCard`'s decoration walk reading `null` heights from the
mismatched child boxes.

**Status.** Both attempted patches reverted. Script back at the
8-error baseline (`c3_after_revert.log.txt`). The cluster is
**Reverted/Deferred** — the genuine fix lives in the d4rt
intrinsics/layout path for `Row + Expanded` under unbounded
cross-axis constraints (proxy/slot-mixin layout pipeline), not in
the script. The underlying trigger and a functional script-authoring
workaround are documented at the end of `doc/interpreter_unfixable.md`
("`Row(crossAxisAlignment: stretch)` + `Expanded` inside
`SliverToBoxAdapter` (C3)").

## C4 — Section E coercion (Fixed)

`SlottedMultiChildRenderObjectWidget` proxy landed earlier (downstream
is D7). The remaining `PreferredSizeWidget` + single-arg `Widget`
gap was folded into D5 and closed on 2026-04-27 — see the D5 section
above for the fix details and verification.

## C6b — `cannot convert List to List<ThemeExtension<ThemeExtension<dynamic>>>` (Fixed 2026-04-27)

Higher-kinded generic in `ThemeData.extensions`. Surfaced again here
on `retest/material/theme_extension_test.dart` (gir fail). The
generator's relaxer didn't recognise the nested generic, and the
follow-up `theme.extension<T>()` call dropped its type-argument at
the bridge boundary.

**Fix (multi-part):**

1. **Interface proxy for `ThemeExtension`** — Added
   `_InterpretedThemeExtension extends ThemeExtension<_InterpretedThemeExtension>`
   in `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart` and
   registered it via `D4.registerInterfaceProxy('ThemeExtension', …)`.
   By F-bounded covariance, `_InterpretedThemeExtension` is also a
   `ThemeExtension<ThemeExtension<dynamic>>`, satisfying the cast
   inside `D4.coerceList<…>`. `type` is overridden to return the
   `InterpretedClass` so each script-side subclass occupies its own
   slot in `ThemeData.extensions`.
2. **Active-visitor wrap** — `D4.coerceList` only consults registered
   interface proxies when `D4._activeVisitor` is set. Two call sites
   were dispatching adapters without a `withActiveVisitor` wrap:
   `BridgedMethodCallable.call` (callable.dart) and the
   bridged-instance method dispatch in `visitMethodInvocation`
   (interpreter_visitor.dart line ~2995 in `tom_d4rt`, ~3470 in
   `tom_d4rt_ast`). Both wrapped now; mirrored across `tom_d4rt`
   ↔ `tom_d4rt_ast`.
3. **`ThemeData.extension<T>()` interceptor** — Added `'extension':
   'ThemeData'` to `_bridgedMethodInterceptHooks` in
   `tom_d4rt_generator/lib/src/bridge_generator.dart` so the generated
   bridge consults `D4.findBridgedMethodInterceptor('ThemeData',
   'extension')` before falling through to the type-erased
   `t.extension()` call. Bridges regenerated. Registered the
   matching interceptor in `d4rt_runtime_registrations.dart`: walks
   `theme.extensions.values`, matching `_InterpretedThemeExtension`
   proxies by `_instance.klass.name == typeArgs[0].name` and
   returning the underlying `InterpretedInstance` so script field
   dispatch goes through the `InterpretedClass`. Native ThemeExtensions
   match by `runtimeType.toString()`.

**Verification (2026-04-27):**
- bisect on `retest/material/theme_extension_test.dart`: STATUS true,
  FRAMEWORK_ERRORS [], OUTPUT_COUNT 0
  (`doc/testlog_20260427-c6b/c6b_after_fix3.log.txt`)
- gii: +78 ~1 -4 (matches baseline)
- essential: +108 (matches baseline)
- important: +164 ~5 (matches baseline)
- secondary: +649 ~5 (matches baseline)

## C7 — `TwoDimensionalScrollView` / `TwoDimensionalViewport` ctor missing (Fixed Partial 2026-04-27)

Surfaced again on three hr5 scripts:
`widgets/two_dimensional_child_builder_delegate_test.dart`,
`widgets/two_dimensional_child_manager_test.dart`,
`widgets/two_dimensional_scrollable_state_test.dart`. Required
super-arg-capture in the interpreter callable layer plus multi-method
proxies in the bridge package — landed as four coordinated changes:

1. **InterpretedInstance super-arg storage** — added
   `superCallPositionalArgs` / `superCallNamedArgs` fields on
   `InterpretedInstance` in both `tom_d4rt/lib/src/runtime_types.dart`
   and `tom_d4rt_ast/lib/src/runtime/runtime_types.dart`.

2. **Opt-in super-arg capture in the proxy-no-op branch** — in
   `callable.dart` of both packages, when the bridged super has no
   constructor adapter but does have a registered interface proxy, the
   `super(...)` argument list is evaluated and stashed on the
   InterpretedInstance — but **only** when the bridged super name is
   in `D4._superArgCapturingProxies`. Capturing for *every* registered
   proxy was unsafe: the captured `child` / `children` references
   leaked across the secondary rendering test stream and produced 30 s
   HTTP timeouts on `render_error_box_test.dart` onward (verified by
   bisect). The opt-in mechanism (`D4.markProxyCapturesSuperArgs(name)`
   / `D4.proxyCapturesSuperArgs(name)`) was added to D4 in both
   packages. Both explicit `super(...)` args and super-formal forwards
   (`super.foo` parameters) are merged into the captured map so that
   either declaration style works.

3. **Three native proxies in `tom_d4rt_flutterm`** — added
   `_InterpretedTwoDimensionalScrollView`,
   `_InterpretedTwoDimensionalViewport`, and
   `_InterpretedRenderTwoDimensionalViewport` in
   `lib/src/d4rt_runtime_registrations.dart`. Each:

   - reads the captured super-args from `instance.superCallNamedArgs`
     via `_readSuperArg<T>(...)`, which goes through
     `D4.extractBridgedArgOrNull<T>` so InterpretedInstance delegates
     (e.g. a script-defined `_TwoDMgrCountingDelegate extends
     TwoDimensionalChildBuilderDelegate`) are unwrapped to their native
     `bridgedSuperObject`;
   - forwards them to the native super-constructor with sensible
     defaults for optional super-args;
   - sets `instance.nativeProxy` so the interpreter resolves inherited
     getters/methods (e.g. `delegate`, `horizontalOffset`,
     `viewportDimension`, `buildOrObtainChildFor`, `parentDataOf`)
     through the proxy's bridged super class via the RC-6 fallback in
     `InterpretedInstance.get`;
   - dispatches the abstract overrides (`buildViewport`,
     `createRenderObject` / `updateRenderObject`,
     `layoutChildSequence`) into the interpreted method via
     `_invokeInterpretedAs<T>`.

4. **Opt-in registrations** — the three proxies call
   `D4.markProxyCapturesSuperArgs(name)` to enable the capture branch.

**Verification.**

- `flutter test test/bisect_test.dart` (the three C7 scripts):
  - Script 1 `two_dimensional_child_builder_delegate_test.dart`:
    `STATUS=true`, `FRAMEWORK_ERRORS=[]` (was 4 errors at baseline).
  - Script 2 `two_dimensional_child_manager_test.dart`:
    `STATUS=true`, `FRAMEWORK_ERRORS=[]` (was 3 errors at baseline).
  - Script 3 `two_dimensional_scrollable_state_test.dart`:
    `STATUS=true`, `FRAMEWORK_ERRORS=[BoxConstraints forces an
    infinite height ...]` — independently implicated by **C8** (see
    `testlog_20260426-2030-issue-analysis/error_analysis.md` line
    347). Script 3 closure is therefore deferred to the C8 fix.

- Regression suites (all serial, `D4RT_SKIP_BRIDGE_REGEN=1`):
  - `essential_classes_test`: **108 passed / 0 failed**, same as
    baseline (`testlog_20260427-1339-post-c22`).
  - `important_classes_test`: **164 passed / 5 skipped / 0 failed**,
    same as baseline.
  - `generator_interpreter_issues_test`: **78 passed / 1 skipped /
    4 failed**, same as baseline (no new failures introduced — the 4
    failures are pre-existing rendering/* and semantics issues
    unrelated to C7).
  - `secondary_classes_test`: **649 passed / 5 skipped / 0 failed**,
    same as baseline.

**Status: Partial Fix.** Scripts 1 and 2 are fully closed; script 3
is deferred to C8 (BoxConstraints/layout cascade). The C7 mechanism
(super-arg capture + multi-method proxies + opt-in gate) is now
available for any future cluster that needs the same shape — for
example, abstract bridged super classes whose constructors are
stripped by GEN-051 and whose subclasses need to forward to the
native super-constructor.

## C19 — `'hasSize': is not true` inside `RenderAligningShiftedBox.alignChild` (FIXED 2026-04-27)

Single gii-fail script `render_aligning_shifted_box_test.dart`
emitted 2 framework errors:

```
Runtime Error: Native error in bridged superclass method 'RenderAligningShiftedBox.alignChild':
  'package:flutter/src/rendering/shifted_box.dart': Failed assertion: line 374 pos 12: 'hasSize': is not true.
  ... line 373 pos 12: 'child!.hasSize': is not true.
```

**Root cause** — `InterpretedInstance.set()` in the analyzer-free
runtime (and its analyzer-based mirror) only routed through a bridged
superclass setter when `bridgedSuperObject != null`. For interface-proxy
factories like `_InterpretedRenderAligningShiftedBox`, the abstract
bridged superclass has no constructor adapter, so `bridgedSuperObject`
stays null and the proxy is installed on `nativeProxy` instead. As a
result the script's `size = constraints.constrain(...)` inside
`performLayout` landed in the InterpretedInstance's `_fields` map
instead of routing to the bridged `size` setter. The proxy's real
`_size` was never populated, leaving `hasSize=false` when the script
subsequently called `alignChild()`. Diagnostic capture confirmed:
`childHasSize=true` (child layout ran) but `hasSize=false` (proxy
size unset) at the moment alignChild threw.

**Fix** — Mirror the read-path pattern (`Instance.get`, RC-6) in
`Instance.set`: when `bridgedSuperObject` is null, fall back to
`nativeProxy` as the native target before consulting
`bridgedSuperclass.findInstanceSetterAdapter(name)`. Applied
identically to:

- `tom_d4rt_ast/lib/src/runtime/runtime_types.dart`
- `tom_d4rt/lib/src/runtime_types.dart`

No bridge regen needed (interpreter-only change). The previous
`_InterpretedRenderAligningShiftedBox.performLayout` reflected-size
fallback (read `size` from the instance field map after the
interpreted call) is now dead code on the happy path but kept as
defensive infrastructure, matching the long-standing
`_InterpretedRenderBox` pattern.

**Verification (2026-04-27 post-fix run):**

- `bisect_test` for `rendering/render_aligning_shifted_box_test.dart`
  → status=success, FE=0
- essential 108/0/0 (matches baseline)
- important 164/5/0 (matches baseline)
- secondary 649/5/0 (matches baseline)
- gii 79/1/3 (was 78/1/4 — `render_aligning_shifted_box_test`
  flipped from FAIL→PASS; remaining 3 gii failures belong to other
  clusters: `custom_painter_semantics`, `render_box_container_defaults_mixin`,
  `render_custom_paint`).

## C20a, C20b, C20d, C20f, C20h₂ — Interpreter operator + statement-level gaps (Partial)

| Sub | Error | Script |
|---|---|---|
| ~~C20a~~ | ~~`Unsupported binary operator "&"`~~ | ~~`widgets/widget_states_constraint_test.dart` (hr5, 1 FE)~~ — **closed 2026-04-27** |
| ~~C20b~~ | ~~`Unsupported for-loop type in collection literal: SForEachPartsWithPattern`~~ | ~~`widgets/fractional_translation_test.dart` (hr4, 1 FE)~~ — **closed 2026-04-27** |
| ~~C20d~~ | ~~`Native error in bridged superclass method 'State.setState': Build scheduled during frame.`~~ | ~~`rendering/render_box_container_defaults_mixin_test.dart` (gii fail), `rendering/render_custom_paint_test.dart` (gii fail)~~ — **closed 2026-04-27 (workaround)** |
| ~~C20f~~ | ~~`Error in generic constructor factory for 'RawRadio'`~~ | ~~`retest/widgets/raw_radio_test.dart` (gir fail)~~ — **closed 2026-04-27** |
| C20h₂ | `LateInitializationError: Late variable '_<...>' without initializer` | `widgets/text_selection_gesture_detector_builder_delegate_test.dart` — folded into D3 |

C20a closed 2026-04-27 — the `&` was a red herring. The actual
failure was a `Set.contains` `RangeError: Invalid value` raised when
`states.contains` was passed as a callback (`_kAllStates.where(states.contains)`).
Three coordinated fixes, mirrored across `tom_d4rt` and
`tom_d4rt_ast`:

1. **Method tear-off in `visitSPrefixedIdentifier`** —
   `prefix.method` (without an immediate invocation) was being
   *invoked* with empty arguments instead of returning a callable.
   On bridges that index `positionalArgs[0]` (e.g. Set.contains) this
   surfaced as `RangeError`. Now returns a `BridgedMethodCallable`.
2. **`D4._coerceMapKey<K>` helper** — added to handle
   `InterpretedInstance` keys via `bridgedSuperObject` and
   `tryCreateInterfaceProxyWithVisitor`, so user-defined
   `WidgetStatesConstraint` subclasses can be coerced into native
   map keys.
3. **`WidgetStatesConstraint` interface proxy registration** in
   `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart` with a
   `_InterpretedWidgetStatesConstraint` delegating
   `isSatisfiedBy(Set<WidgetState>)` to the interpreter.

C20b closed 2026-04-27 — `SForEachPartsWithPattern` (Dart 3 record-
pattern destructuring inside collection-literal `for` loops, e.g.
`for (final (IconData icon, String label) in entries) ...`) was
unhandled in the collection-literal visitor's `SForElement` branch,
even though the statement-level for-in already supported it via
`_executeForInWithPattern`. Mirrored the same logic into
`_processCollectionElement`: per-iteration scope with
`_matchAndBind(pattern, item, env)`, then dispatch to the body.
Implemented in both `tom_d4rt/lib/src/interpreter_visitor.dart` and
`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`.

C20d closed 2026-04-27 (workaround) — added a
`StateUserBridge.overrideMethodSetState` user-bridge override in
`tom_d4rt_flutterm/lib/src/d4rt_user_bridges/state_user_bridge.dart`
that wraps the auto-generated `State.setState` adapter with a
scheduler-phase guard. When
`SchedulerBinding.instance.schedulerPhase` is
`transientCallbacks`, `midFrameMicrotasks`, or
`persistentCallbacks` (i.e. the framework is mid-frame), the
callback is deferred via
`WidgetsBinding.instance.addPostFrameCallback`; otherwise it runs
synchronously as before. The supplementary registration in
`d4rt_runtime_registrations.dart` was kept as the unbridged
fallback. After regenerating the bridges, gii went from 79/1/3 →
80/1/2 (`render_box_container_defaults_mixin_test.dart` flipped
FAIL → PASS). The second driving script,
`rendering/render_custom_paint_test.dart`, still fails gii on the
unrelated downstream error `Bad state: No element` (from a
`path.computeMetrics().first` call where the path has no metrics)
— that is a separate cluster, not C20d. Behavioural deviation from
real Flutter (real Flutter throws; the bridge defers) documented in
`doc/interpreter_unfixable.md` (C20d). Regression: essential 108/0/0,
important 164/5/0, secondary 649/5/0 — all matching baseline.

C20f closed 2026-04-27 — the cluster description was misleading.
The "Error in generic constructor factory for 'RawRadio'" was a
*symptom*; the actual root cause was that
`RadioGroup.maybeOf<T>(context)` drops `<T>` at the bridge boundary.
Native `maybeOf<T>` uses
`context.dependOnInheritedWidgetOfExactType<_RadioGroupStateScope<T>>()`,
which is keyed by the exact reified type argument. The generated
static-method bridge ignored `typeArgs` and called
`RadioGroup.maybeOf(context)` (i.e. `<dynamic>`), so the lookup
never matched the concrete `_RadioGroupStateScope<String>` in the
tree and returned null. The script's `RawRadio<String>(groupRegistry:
registry, enabled: true)` then asserted on
`!enabled || groupRegistry != null`. The RC-2 factory was a
red herring — it received and forwarded `null` correctly.

Two coordinated changes:

1. **Bridge generator** (`tom_d4rt_generator/lib/src/bridge_generator.dart`):
   the `_bridgedStaticMethodInterceptHooks` map was keyed by method
   name alone, which would route every `*.maybeOf` static (many
   widgets define one) through the same registry slot. Re-keyed
   to `'ClassName.methodName'` so unrelated classes don't share a
   hook. Added `'RadioGroup.maybeOf': 'RadioGroup'`.
2. **Runtime registration**
   (`tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart`):
   registered a `RadioGroup.maybeOf` static interceptor that
   dispatches to the native `RadioGroup.maybeOf<T>(context)` for
   the common builtin type-arg names (`String`, `int`, `double`,
   `num`, `bool`, `Object`); for unknown `<T>` it falls back to a
   type-agnostic ancestor walk that returns the first
   `StatefulElement.state` implementing `RadioGroupRegistry`.

After regenerating bridges: raw_radio_test went from 1 framework
error to 0. Regression: gir 47/0/11, essential 108/0/0, important
164/0/5, secondary 649/0/5 — all matching baseline.

## C21 — Interpreted `ParentData` proxy (Fixed 2026-04-27)

**Status:** Fixed. Driving script (`rendering/render_box_container_defaults_mixin_test.dart`)
remains at 0 FE. The C1-followup `widget_test` cascade surfaced at
12 FE in the prior turn dropped to **1 FE** after this fix; the 1
residual is a downstream `dart:ui/math.dart:14` `clampDouble`
assertion that already existed in the pre-C21 baseline (it was
masked by the createRenderObject failures, then re-surfaced once
the cascade resolved). Documented under interpreter_unfixable.md
as a downstream Flutter framework assertion not rooted in the
interpreter.

**Root cause of the residual cascade** (12 FE on the slotted widget
test): the AST-driven interpreter (`tom_d4rt_ast`) was missing
Dart's **null-shorting** semantics. For an expression chain such
as `box?.size.height` where `box == null`, the inner `?.` correctly
short-circuits, but the outer `.size.height` would re-evaluate and
throw "Cannot access property 'height' on null". Per Dart spec
§16.27.1, when any inner selector in a chain uses `?.`/`?[…]`,
every subsequent selector up to the chain's termination point
(parentheses or non-selector expression) must yield null instead
of throwing.

**Fix.** Added a structural helper `_chainHasNullAwareSelector`
that walks the syntactic target chain and returns true if any
inner `PropertyAccess`/`MethodInvocation`/`IndexExpression` uses
`?.`/`?[…]`. The helper terminates at `ParenthesizedExpression`,
`SimpleIdentifier`, literals, etc. Applied at three call sites
in both interpreters:

- `visitPropertyAccess` — was the throw site for the failing scripts.
- `visitMethodInvocation` — for chains ending in a method call.
- `visitIndexExpression` — for chains ending in `[…]`.

Mirrored fix in:
- `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` (helper
  at line ~144; call sites at 1825, 3222, 4344).
- `tom_d4rt/lib/src/interpreter_visitor.dart` (helper after
  `executeBlock`; call sites in `visitMethodInvocation`,
  `visitPropertyAccess`, `visitIndexExpression`).

**Verification.**

- Unit tests in `tom_d4rt_exec/test/_c21_null_short_test.dart`
  (`a?.size.height ?? -1.0` and method-returned-null variant): both
  PASS post-fix; both FAILED pre-fix.
- Bisect:
  - `rendering/render_box_container_defaults_mixin_test.dart`: 0 FE
    (unchanged).
  - `widgets/slotted_multi_child_render_object_widget_test.dart`:
    **12 FE → 1 FE** (the residual is the pre-existing `clampDouble`
    assertion).
- Regression suites (serial, `D4RT_SKIP_BRIDGE_REGEN=1`):
  - gii: 80/1/2 (matches baseline; the 2 failures
    `rendering/custom_painter_semantics_test.dart` and
    `rendering/render_custom_paint_test.dart` are pre-existing
    per `testlog_20260427-1339-post-c22/generator_interpreter_issues_test.result.json`).
  - essential: 108/0/0 — match baseline.
  - important: 164/0/5 — match baseline.
  - secondary: 649/0/5 — match baseline.

**Logs.** `ztmp/c21_logs/{bisect_post_fix,post_fix_gii,post_fix_essential,post_fix_important,post_fix_secondary}.log`.

## Plan E2 — Null `BuildContext` in `dependOnInheritedWidgetOfExactType` (Fixed 2026-04-27)

**Status:** Fixed. The two scripts that originally exhibited the
`Cannot invoke method 'dependOnInheritedWidgetOfExactType' on null`
shape (`widgets/inherited_theme_test.dart` —
`PanelTheme.of(context)`, and `widgets/inherited_widget_test.dart` —
`AppStateScope.watch(context)`) both pass at 0 FE in the current
post-C22/post-C21 state. The closure-call shape that used to lose
the receiver binding for an interpreted static helper has been
closed by the cumulative interpreter improvements landed in C20a
(tear-off + extension dispatch), C20d (StateUserBridge scheduler-
phase deferral), C20f (RadioGroup.maybeOf static interceptor) and
C21 (Dart null-shorting for chained `?.`).

**Verification.**

- Bisect (`widgets/inherited_theme_test.dart`,
  `widgets/inherited_widget_test.dart`): both 0 FE
  (`ztmp/plan_e2_logs/baseline_bisect.log`).
- gii section showing both scripts at 0 FE
  (`ztmp/c21_logs/post_fix_gii.log`, lines for `inherited_theme_test`
  and `inherited_widget_test`).
- Focused regression tests added in
  `tom_d4rt/test/_plan_e2_static_in_closure_test.dart` and
  `tom_d4rt_exec/test/_plan_e2_static_in_closure_test.dart`. These
  reproduce the exact dispatch shape (interpreted `static` helper
  accepting a receiver argument, called from inside a closure that
  either receives the receiver as a parameter or captures it from the
  enclosing scope). All three patterns pass on both the analyzer-
  based interpreter (`tom_d4rt`) and the AST-based runner
  (`tom_d4rt_exec`/`tom_d4rt_ast`).
- Regression suites unchanged from C21-fix baseline: gii 80/1/2,
  essential 108/0/0, important 164/0/5, secondary 649/0/5.

**Why now closed without a code change.** The original Plan E2
trigger was a side-effect of broken closure parameter binding under
specific dispatch paths (extension dispatch on bridged operands,
tear-off shape, scheduler-phase context resolution). The C20-series
fixes restored those paths, and the C21 null-shorting fix covered
the residual `?.` chain pattern that surfaced as "context is null"
where it was actually "an inner `?.` in the chain went to null and
the outer `.x.y` rethrew". With both classes of bug closed, the
Plan E2 symptom no longer reproduces. The new regression tests
prevent silent re-introduction.

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

Carry-over clusters (C1, C3, C4, C7,
InheritedModel proxy) detailed above.
C20a closed 2026-04-27 (tear-off + map-key + WidgetStatesConstraint proxy).
C20b closed 2026-04-27 (SForEachPartsWithPattern in collection literals).
C20d closed 2026-04-27 (StateUserBridge scheduler-phase deferral workaround).
C20f closed 2026-04-27 (RadioGroup.maybeOf static interceptor for typed lookup).
C21 closed 2026-04-27 (null-shorting through `.` after `?.` in selector chain).
Plan E2 closed 2026-04-27 (de facto — closed cumulatively by C20-series + C21;
regression tests added).

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
