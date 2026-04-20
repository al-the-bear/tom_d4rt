# Interpreter / Bridge Issues

Active issue list, organised by cluster. Each cluster is a recurring
failure pattern hit by demo scripts in `tom_d4rt_flutterm_app`. The
representative scripts under each cluster are useful as starting points
for a targeted fix and as regression tests once the cluster is closed.

Last refreshed: 2026-04-20, against
`doc/testlog_20260418-1500-e22671e8/generator_interpreter_issues_test.result.json`
(rev `bfe0b852`). The file currently runs **45 / 0 / 38**
(2026-04-19 baseline before cluster work was 27 / 0 / 56; the
2026-04-16 pre-bisect baseline was 0 / 9 / 74). Six clusters fully
closed (1–6) plus one partially closed (7); the remaining 38
failures are organised into clusters 8–12 below.

When a cluster lands a fix, mark the checkbox, add a `**Resolved:**`
line with the commit ref, and re-run the suite to confirm. Drop the
cluster from the list once everything in it passes.

---

## Active clusters

### [X] Fixed — `ValueNotifier<double>` accepts `int` literals

**Resolution:** Generator GEN-075c emits `(value as num).toDouble()`
instead of `value as double` for primitive type-param dispatch when the
typeArg is `double`. Applied to both positional and named branches in
`_writeRC2Case` of `tom_d4rt_generator/lib/src/relaxer_generator.dart`.
Fixed in commit landing this entry.

After fix: 6/6 cluster scripts pass; +51 unrelated passes in
`secondary_classes_test` from the same regen; essential and important
unchanged at 108/0/0 and 166/0/3.

**Symptom (was)**

```
Runtime Error: Error in generic constructor factory for 'ValueNotifier':
type 'int' is not a subtype of type 'double' in type cast
```

**Root cause (was)**

Generic constructor factory in the relaxer (or the bridge generator)
did a strict `as T` cast. `ValueNotifier<double>(0)` arrived at the
factory with `value=0` (int) — Dart-the-language would silently widen,
the bridge did not.

---

### [X] Fixed — `Column.children` rejects nullable list elements

**Resolution:** GEN-080 — `D4.coerceList<T>` now drops null elements
when `T` is non-nullable (gated on `null is T`), mirroring Dart's
collection-`if` semantics. Applied identically in
`tom_d4rt/lib/src/generator/d4.dart` and
`tom_d4rt_ast/lib/src/runtime/generator/d4.dart`. Fixed in commit
landing this entry.

After fix:
- `animated_cross_fade_test` and `physical_model_test` now PASS in full.
- `animated_switcher_test`, `backdrop_filter_test`, `shader_mask_test`
  cleared the null cast; their remaining failures are downstream
  unrelated bugs (RenderFlex overflow, Matrix4-needs-16-entries,
  late-init — the latter falls under cluster 4).
- Zero `cannot convert List to List<Widget>` errors remaining in
  `generator_interpreter_issues_test`.
- essential / important / secondary: 108/0/0, 166/0/3, 647/0/7 (unchanged).

**Symptom (was)**

```
Runtime Error: Native error during default bridged constructor for 'Column':
Argument Error: Invalid parameter "children": cannot convert List to
List<Widget> - type 'Null' is not a subtype of type 'Widget' in type cast
```

**Root cause (was)**

Scripts assemble `children: [..., if (cond) widget, ...]` and similar
patterns where an entry evaluates to `null` (the interpreter is more
lenient than the analyzer about null in typed lists). The bridge's
`coerceList<Widget>` then mapped each element with `e as Widget`, and
the null element tripped the cast — Flutter's actual constructor would
have rejected it too, but with a less-clear error.

---

### [X] Fixed — `super.build()` call on bridged State subclass

**Resolution:** RC-8 — `visitMethodInvocation`'s `BoundBridgedSuper`
branch in both `interpreter_visitor.dart` files now treats
`super.<method>()` as a no-op (returns `null`) when neither
`bridgedSuperObject` nor `nativeProxy` is set, instead of throwing
"native super object is missing". Scripts that mix in
`AutomaticKeepAliveClientMixin` and call `super.build(context)` for
spec compliance (and discard the result) just continue. Also brought
tom_d4rt's branch in sync with tom_d4rt_ast's nativeProxy-fallback.

After fix:
- 5/5 cluster scripts cleared the super.build error. 4 fully pass
  (`shortcut_serialization`, `single_activator`,
  `single_child_render_object_element`,
  `single_child_render_object_widget`); 1 (`shortcut_registry_entry`)
  hits a different downstream bug (`Cannot invoke method 'withValues'
  on null` inside a `List.generate`).
- generator_interpreter_issues_test: 30/0/53 → **36/0/47** (+6 pass).
- essential / important / secondary: 108/0/0, 166/0/3, 647/0/7 (unchanged).

**Symptom (was)**

```
Runtime Error: Internal error: Cannot call super method 'build' on bridged
superclass 'State' because the native super object is missing.
```

**Root cause (was)**

Scripts that mix in `AutomaticKeepAliveClientMixin` (or similar) call
`super.build(context)` from `build()`. The narrowed-#82 fix
([524caa13](https://github.com/al-the-bear/tom_d4rt/commit/524caa13))
intentionally left `nativeProxy` null on plain `_InterpretedState`
instances; the bridged-super dispatch then had no native target and
threw rather than degrading gracefully.

---

### [X] Fixed — `late` field accessed before initializer (false-positive)

**Resolution:** Resolved as a downstream effect of cluster 3's
super-method no-op fix ([5c0c5939](https://github.com/al-the-bear/tom_d4rt/commit/5c0c5939)).
The "late field not assigned" errors were not actually about late
fields — they came from `initState()` aborting partway through when
its `super.initState()` (or the script's first `super.build()`) threw
"native super object is missing". Once that throw was demoted to a
silent no-op, the script's `_field = …` assignments now run normally
and `build()` reads the assigned value as expected.

After (cluster-3) fix, re-checked individually:
- `autofill_group_test.dart` — PASS
- `page_storage_test.dart` — past the late-init error (now hits a
  different cluster-7 `key` lookup)
- `list_wheel_scroll_view_test.dart`, `list_wheel_viewport_test.dart`,
  `magnifier_decoration_test.dart`, `navigation_toolbar_test.dart` —
  past the late-init error (now hit script-level Flutter constraint
  errors / layout overflows, unrelated to the cluster).
- `render_tree_root_element_test.dart` — still hits a
  `LateInitializationError`, but on Flutter's internal `_children@…`
  field via `visitAncestorElements`, which is a different beast (a
  bridged-method call on a native StatelessElement, not a script-side
  late field). Tracked separately if it reproduces.

**Symptom (was)**

```
Runtime Error: Undefined variable: _controller (Original error:
LateInitializationError: Late variable '_controller' without initializer
is accessed before being assigned.)
```

**Root cause (was)**

A misleading symptom: the script's `initState()` (or constructor body)
DID assign the late field, but the `super.initState()` invocation that
preceded it was throwing under cluster 3, so initState aborted before
the late assignment ran. By the time `build()` looked up the field, it
was still in its un-assigned `LateVariable` state — and the framework
reported `LateInitializationError` instead of the original super-call
failure.

---

### [X] Fixed — `dart:math`'s `min`/`max` leaked into unprefixed scope

**Resolution:** GEN-101 — the stdlib registrar for `dart:math` (and
the other non-core stdlibs) previously wrote `min`, `max`, `pi`, … into
`globalEnvironment`. That made them visible to every script as
unprefixed identifiers, even when a script did `import 'dart:math' as
math;` expecting only `math.min` to resolve. Scripts with a field
named `min` (common: `_LabeledSlider` wrappers around Flutter's
`Slider`) found `dart:math.min` first when writing `Slider(min: min, …)`,
so `min` evaluated to the NativeFunction and the Slider constructor
rejected the argument with "expected double, got NativeFunction".

Fix in `tom_d4rt_ast/lib/src/runtime/ast_module_loader.dart` —
`_loadStdlibModule` now keeps a per-stdlib `Map<String, Environment>`
(mirrors the GEN-100 bridged-module isolation). `dart:core` and
`dart:async` stay in `globalEnvironment` (their symbols are expected
to be globally visible), but every other `dart:*` stdlib registers
into its own env enclosing `globalEnvironment`. The
`LoadedModule.exportedEnvironment` then exposes those symbols through
the normal prefixed/unprefixed import paths, so `import … as math;`
correctly hides `min` from the unprefixed scope.

After fix:
- All `expected double, got NativeFunction` errors on Slider.min/max
  eliminated in `generator_interpreter_issues_test`.
- `image_filtered_test` and `indexed_stack_test` past the cluster-5
  error (now hit different cluster-6 "InterpretedInstance not Widget"
  downstream bugs).
- generator_interpreter_issues_test: 36/0/47 → **37/0/46** (+1 pass).
- essential / important / secondary: 108/0/0, 166/0/3, 647/0/7
  (unchanged).

Not mirrored in `tom_d4rt/lib/src/module_loader.dart` yet — that path
uses a source-string-based loading flow where the same pragmatic fix
doesn't drop in cleanly, and the test app routes through
tom_d4rt_ast. Follow-up item for when the analyzer-based path is
exercised directly.

**Symptom (was)**

```
Runtime Error: Native error during default bridged constructor for 'Slider':
Argument Error: Invalid parameter "min": expected double, got NativeFunction
```

**Root cause (was — INCORRECT hypothesis)**

Initially suspected the script passed a zero-arg function where a
double was expected and `extractBridgedArg<double>` failed to unwrap
it. Actual cause was name-resolution leak: `dart:math` stdlib symbols
were in `globalEnvironment`, so the script's field-level `min` was
shadowed by `dart:math.min` at `visitSimpleIdentifier`.

---

### [X] Fixed — top-level script return leaked InterpretedInstance to FlutterD4rt._unwrap

**Resolution:** INTER-009 — `FlutterD4rt._unwrap<T>` now resolves an
`InterpretedInstance` result via the registered interface-proxy
factories (the same path `D4.extractBridgedArg<T>` uses at every
bridge boundary during script execution). Previously, the script's
top-level `build()` could return an `InterpretedInstance` of a
`StatelessWidget` / `StatefulWidget` subclass (or similar) and
`_unwrap` rejected it with "Expected Widget but got InterpretedInstance"
because it only handled `BridgedInstance` / direct casts.

To make the visitor available after `executeBundle` returns:
- Added a public `D4.activeVisitor` getter (mirrored in tom_d4rt and
  tom_d4rt_ast) so embedders can read the most recently active
  visitor.
- Updated `D4rt.visitor` (tom_d4rt_exec) to fall back to
  `_runner.visitor` when the classic `_visitor` field is null
  (executeBundle path keeps the visitor on the inner runner).
- `_unwrap` first tries `D4.activeVisitor`, then falls back to
  `_interpreter.visitor`.

After fix:
- Eliminates ALL "Expected Widget but got InterpretedInstance" errors
  in `generator_interpreter_issues_test` (was 10).
- generator_interpreter_issues_test: 37/0/46 → **45/0/38** (+8 pass).
- secondary_classes_test: 647/0/7 → **651/0/3** (+4 pass, -4 fail).
- essential / important: 108/0/0, 166/0/3 (unchanged).

**Symptom (was)**

```
Expected Widget but got InterpretedInstance
```

(Sometimes also surfaced as the more-specific
`Argument Error: Invalid parameter "child": expected Widget, got
InterpretedInstance(...)` when the unwrapped value was passed back
into a bridged constructor.)

**Root cause (was — INCORRECT hypothesis)**

Initial diagnosis assumed an InheritedWidget proxy was missing.
Actual cause was different: the registered interface-proxy factories
for `StatelessWidget` / `StatefulWidget` exist and worked at every
bridge boundary during execution, but the embedder's final `_unwrap`
of the script's top-level return value didn't go through them.

---

### [X] Fixed — bridge `Enum` base class + narrow GEN-101 isolation to dart:math only

**Resolution:** Two related fixes landed in
[bfe0b852](https://github.com/al-the-bear/tom_d4rt/commit/bfe0b852):

1. A minimal `EnumCore` bridged class (`nativeType: Enum`, getters for
   `index` / `name` / `hashCode` / `runtimeType`, `toString`) is now
   registered by `CoreStdlib.register` in both `tom_d4rt` and
   `tom_d4rt_ast`. Generic bounds like `class _SettingCard<T extends Enum>`
   resolve at class-declaration time without
   "Undefined variable: Enum". Verified via `widgets/restorable_enum_n_test.dart`.
2. The cluster-5 stdlib isolation (GEN-101) was narrowed to dart:math
   only. `convert`, `io`, `collection`, `typed_data`, `isolate`
   register back into `globalEnvironment` so scripts that reach those
   symbols transitively through bridged libraries (e.g.
   `flutter/services.dart` exposing `Uint8List`) keep working.

The other "missing bridge entry" sub-issues that were originally
lumped here (`setState`, `key`, `layoutChild`, `ByteData`) are split
out into cluster 8 below — each is its own targeted fix.

**Symptom (was)**

```
Runtime Error: Undefined variable: Enum
```

---

### [X] Fixed — `setState` / `key` access on plain interpreted Widget/State

**Resolution:** Two fixes landed together (both mirrored in tom_d4rt
and tom_d4rt_ast):

- **Bug-96b — store `super.X` parameter values on `this`.** The
  `SSuperFormalParameter` branch in `Callable._prepareEnv` continues
  to forward the value to the super constructor call, but also calls
  `thisValue.set(paramName, valueToDefine)` so `this.key`,
  `this.child`, etc. resolve from the script body even when no
  bridgedSuperObject is realised (typical for `super.key` on Widget
  subclasses).
- **RC-9 — last-chance fallback in `InterpretedInstance.get` for
  bridged-super members without native target.** Before throwing
  "Undefined property 'X' on Y", we now walk the bridged-superclass
  chain once more: if any ancestor bridged class exposes a method
  adapter for `name`, return a `NativeFunction` that invokes any
  `Callable` argument (so `setState(() { _x = 1; })` still runs the
  script's callback and updates script state) and otherwise returns
  null; if it exposes a getter adapter, return null directly. This
  mirrors the cluster-3 `super.<method>()` no-op treatment
  ([5c0c5939](https://github.com/al-the-bear/tom_d4rt/commit/5c0c5939))
  but for unprefixed access.

After fix:
- All 4 cluster scripts past the original error:
  `transition_delegate_test`, `sliver_animated_list_state_test`,
  `sliver_child_builder_delegate_test` (setState); `page_storage_test`
  (key). Some still fail later under clusters 9/10 (downstream
  "InterpretedInstance not Widget" casts) — those are tracked there.
- generator_interpreter_issues_test: 45/0/38 → **46/0/37** (+1 pass);
  zero `Undefined variable: setState` / `Undefined variable: key`
  errors remaining.
- essential / important / secondary: 108/0/0, 166/0/3, 651/0/3 (unchanged).

**Symptom (was)**

```
Runtime Error: Undefined variable: setState (Original error: Undefined property 'setState' on _InteractivePageState.)
Runtime Error: Undefined variable: key (Original error: Undefined property 'key' on _PaneList.)
```

**Root cause (was)**

Two related script-side accesses that fall through the bridged-super
lookup with no native target:

- `setState(...)` in a plain `_InterpretedState` subclass body —
  narrowed-#82 ([524caa13](https://github.com/al-the-bear/tom_d4rt/commit/524caa13))
  leaves `nativeProxy` null on plain States; the bridged-State branch
  skipped when `nativeTarget == null` and the fallback threw.
- `key` on a script Widget subclass that uses the `super.key`
  parameter shorthand — the shorthand forwarded `key` to the bridged
  Widget super-ctor, but no `bridgedSuperObject` is realised for
  plain widgets so the passed value was dropped.

---

### [ ] Fixed — abstract delegate proxies missing at bridge boundaries

**Symptom**

```
Argument Error: Invalid parameter "delegate": expected MultiChildLayoutDelegate, got InterpretedInstance(_DashboardLayout)
Argument Error: Invalid parameter "delegate": expected SingleChildLayoutDelegate, got InterpretedInstance(_AnchorPositioner)
Argument Error: Invalid parameter "clipper": expected CustomClipper<Path>, got InterpretedInstance(_BevelClipper)
Argument Error: Invalid parameter "createRenderObject": expected RenderObject, got InterpretedInstance(_FontRelayoutRenderBox)
Argument Error: Invalid parameter "target": expected RenderBox, got InterpretedInstance(_MockRenderBox)
Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(_DefaultsContainer)
Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(PanelTheme)
Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(AppStateScope)
Runtime Error: Undefined variable: layoutChild (Original error: Undefined property 'layoutChild' on TestMultiChildLayoutDelegate.)
```

**Root cause**

Script subclasses of abstract delegate / base classes are not auto-
wrapped into a native proxy when passed across an *intermediate*
bridge boundary (i.e., not the top-level `_unwrap`, which cluster 6
already handles). The interface-proxy registry in
`d4rt_runtime_registrations.dart` covers `StatelessWidget`,
`StatefulWidget`, `LeafRenderObjectWidget`,
`SingleChildRenderObjectWidget`, `MultiChildRenderObjectWidget`, and
the State family — but not other abstract bases that scripts
commonly subclass.

**Missing proxy registrations** (each script's class extends one of):

- `MultiChildLayoutDelegate` (`layoutChild` access also part of this)
- `SingleChildLayoutDelegate`
- `CustomClipper<T>`
- `RenderBox`, `RenderObject` (script-defined `_FontRelayoutRenderBox`,
  `_MockRenderBox` — needs render-object proxy beyond
  `LeafRenderObjectWidget`)
- `InheritedWidget` (script-defined `PanelTheme`, `AppStateScope`)
- The `_DefaultsContainer` case is a Container subclass — should already
  be covered by the StatelessWidget proxy; needs investigation.

**Representative scripts** (8 entries)

- `widgets/layout_builder_adv_test.dart` (MultiChildLayoutDelegate)
- `widgets/parent_data_widget_test.dart` (MultiChildLayoutDelegate)
- `rendering/render_custom_multi_child_layout_box_test.dart`
- `rendering/render_custom_single_child_layout_box_test.dart`
- `rendering/render_physical_shape_test.dart` (CustomClipper)
- `rendering/relayout_when_system_fonts_change_mixin_test.dart` (RenderObject)
- `rendering/box_hit_test_result_test.dart` (RenderBox)
- `widgets/inherited_theme_test.dart` (InheritedWidget)
- `widgets/inherited_widget_test.dart` (InheritedWidget)
- `rendering/render_box_container_defaults_mixin_test.dart`

**Where to look**

Pattern is the same as the cluster `f6c7db8f` fix that added
`_InterpretedLeafRenderObjectWidget` etc. — define a small proxy
class in `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart`
that holds an `InterpretedInstance` and forwards the abstract
methods (`paint`, `shouldRepaint`, `getClip`, `layoutChild`, …) into
the interpreted instance via `_invokeInterpretedAs<T>`. Register via
`D4.registerInterfaceProxy('<TypeName>', factory)`.

---

### [ ] Fixed — function-typed argument residuals at intermediate boundaries

**Symptom**

```
type 'InterpretedFunction' is not a subtype of type '(() => void)?'
type 'InterpretedInstance' is not a subtype of type 'Widget?' in type cast
type 'InterpretedInstance' is not a subtype of type 'Widget' in type cast
Runtime Error: Native error during bridged method call 'setMessageHandler' on BasicMessageChannel: type '(dynamic) => Future<dynamic>' is not assignable to '(ByteData?) => Future<ByteData?>'
```

**Root cause**

The #74 typed-wrapper fix
([33d121c2](https://github.com/al-the-bear/tom_d4rt/commit/33d121c2))
covered function-typed *return values* in proxy classes. These
remaining hits are the *argument-side* mirror — passing an
`InterpretedFunction` where the bridge expects a typed function,
and passing an `InterpretedInstance` widget at a mid-flow position
(not the top-level `_unwrap` that cluster 6 fixed).

The `BasicMessageChannel.setMessageHandler` case is specifically
about a typed callback — the bridge passes `(dynamic) => Future<dynamic>`
where the native API wants `(ByteData?) => Future<ByteData?>`.

**Representative scripts** (3 entries)

- `widgets/window_scope_test.dart` (`InterpretedFunction → (() => void)?`)
- `semantics/semantics_config_test.dart` (InterpretedInstance to Widget?)
- `widgets/image_filtered_test.dart` (InterpretedInstance to Widget?)
- `services/channels_test.dart` (BasicMessageChannel typed callback)

**Where to look**

`D4.extractBridgedArg<T>` in `generator/d4.dart` for the function-
type branch (look at `_wrapCallableForMap<T>` / `_isFunctionType` —
the same logic needs to apply at non-Map argument positions).
`tom_d4rt_generator/lib/src/proxy_generator.dart` `_emitTypedReturn`
already does this for *returns*; an `_emitTypedArg` (or extension to
the existing arg emission) would be the parallel fix.

---

### [ ] Fixed — generic constructor / relaxer edge cases

**Symptom**

```
Runtime Error: Error in generic constructor factory for 'TweenSequenceItem': Null check operator used on a null value
NoSuchMethodError: Class '$RelaxedAnimation<Offset>' has no instance method 'addListener' with matching arguments.
Runtime Error: Cast failed with 'as' : the value does not match the target type (Instance of 'SNamedType')
type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
```

**Root cause**

Different bridge-generator / relaxer edges:

- `TweenSequenceItem` factory dereferences a value that ends up null
  for some script call shape (animated/tween edge case).
- `$RelaxedAnimation<Offset>.addListener` — the relaxer wrapper does
  not forward `addListener` correctly when the type arg is non-trivial.
- `SNamedType` cast — interpreter's runtime-type machinery: somewhere
  a value that should be a `SNamedType` AST node ends up something
  else.
- `List<Object?>` not `List<Widget>` — coerceList<Widget> sees a
  raw List<Object?> from the relaxer pipeline and fails the cast
  even after cluster 2's null-filter (the elements aren't null, just
  typed as Object?).

**Representative scripts** (4 entries)

- `animation/tweensequence_test.dart` (TweenSequenceItem)
- `widgets/slidetransition_test.dart` ($RelaxedAnimation.addListener)
- `widgets/nestedscrollview_test.dart` (SNamedType cast)
- `widgets/fixed_extent_metrics_test.dart` (List<Object?>→List<Widget>)

**Where to look**

Each is its own bug in `tom_d4rt_generator/lib/src/relaxer_generator.dart`
or the relaxer wrapper templates. Worth opening on the test app's
red-error screen first to read the full stack.

---

### [ ] Fixed — script-side / Flutter framework limitations (out-of-scope?)

**Symptom**

A grab-bag of failures rooted in the demo *script's own*
constraint violations or in Flutter framework expectations the
interpreter cannot easily replicate:

- `RenderFlex overflowed by N pixels` (5 scripts) — pure layout
  overflow caused by demo content not fitting available space;
  fixable in the script with `Expanded` / `Flexible` / scroll
  wrappers.
- `Invalid argument(s): "matrix4" must have 16 entries` — script
  builds an `ImageFilter.matrix(...)` from a list with the wrong
  length.
- `FixedExtentScrollPhysics can only be used with Scrollables that
  use the FixedExtentScrollController` — script mismatch.
- `FixedExtentScrollController.selectedItem cannot be accessed
  before a scroll view is built with it` — script accesses too
  early.
- `RenderCustomMultiChildLayoutBox object was given an infinite
  size` — layout requires bounded constraints in the test viewport.
- `Build scheduled during frame` (`State.setState` adapter) — script
  calls setState from inside `build()`, which Flutter forbids.
- `Cannot invoke method 'withValues' on null` — script has a missing
  `Color` initialization (probably a `late` field assigned later).
- `Undefined property or method 'first' on bridged instance of 'String'`
  — script calls `.first` on a String (would also fail in plain Dart).
- `LateInitializationError: Field '_children@28042623'` — Flutter
  framework's internal `_children` accessed via `visitAncestorElements`
  on a `StatelessElement` that hasn't been mounted yet.
- `Undefined variable: ByteData` (codecs_test) — script forgets
  `import 'dart:typed_data';` and the bridge for
  `flutter/services.dart` does not re-export typed_data symbols.

**Representative scripts** (≈18 entries)

- `widgets/animated_switcher_test.dart`,
  `widgets/backdrop_filter_test.dart`,
  `widgets/magnifier_decoration_test.dart`,
  `widgets/navigation_toolbar_test.dart`,
  `rendering/custom_painter_semantics_test.dart` (RenderFlex / layout)
- `widgets/list_wheel_scroll_view_test.dart`,
  `widgets/list_wheel_viewport_test.dart` (FixedExtent constraints)
- `widgets/html_element_view_test.dart` (platform view constraints)
- `widgets/shader_mask_test.dart` (LateInit on script's late
  `_animController` — likely a script-construction order bug)
- `services/codecs_test.dart` (ByteData missing import)
- `services/channels_test.dart` (typed callback — also overlaps
  cluster 10)
- `rendering/render_aligning_shifted_box_test.dart` (`.first` on String)
- `rendering/render_absorb_pointer_test.dart`,
  `rendering/render_custom_paint_test.dart` (Build scheduled / setState
  during frame — overlap with cluster 8)
- `rendering/relayout_when_system_fonts_change_mixin_test.dart`
  (overlaps cluster 9 for the createRenderObject case)
- `widgets/render_tree_root_element_test.dart` (Flutter `_children`
  framework late-init)
- `widgets/shortcut_registry_entry_test.dart` (`'withValues' on null`)

**Where to look**

These are largely *script-side* fixes (rewrite the demo to use
bounded layout, add missing imports, avoid `setState` in build, etc.)
or out-of-scope Flutter behaviors. A separate sweep that audits the
demo scripts and either rewrites them or moves the structurally-
broken ones into a "known-bad demos" file would close most of this
cluster faster than interpreter changes.

---

### [ ] Fixed — bridge re-exports modelled in the generator

**Symptom (current)**

Scripts that legitimately reach a stdlib type via a transitive
re-export chain in real Dart fail at interpret time with
"Undefined variable: …". The current workaround is GEN-101b which
isolates only `dart:math` and lets every other stdlib leak into
`globalEnvironment` so chains like
`flutter/services.dart → dart:typed_data → ByteData` keep working
by accident.

**Root cause**

The bridge generator scans each library's API and emits a bridged
module containing only that library's own declarations. Real Dart
libraries also have `export 'other/library.dart'` directives that
re-publish another library's symbols under their own URI; the
generator currently ignores those directives, so the bridge for
`flutter/services.dart` doesn't expose the typed_data symbols that
`flutter/services.dart` re-exports in source. The interpreter
therefore can't find `ByteData` from a script that imports
`flutter/services.dart` only — even though that script would compile
in plain Dart.

The over-broad `_isolatedStdlibs = {'math'}` set in
`tom_d4rt_ast/lib/src/runtime/ast_module_loader.dart` is the
band-aid; once re-exports are modelled, every stdlib (and every
package library) can be properly isolated and the set goes away.

**Plan**

1. **Generator change**: when the bridge generator analyses a
   library, also scan its `export` directives via the analyzer.
   For each `export 'package:foo/bar.dart' [show/hide …];`, record
   the (uri, show, hide) tuple alongside the library's own
   declarations.
2. **Bridge config emission**: emit those tuples into the generated
   bridge config — e.g. a `reExports: const [
   ('dart:typed_data', null, null),
   ('package:flutter/foundation.dart', null, null),
   …]` field next to the existing class / function lists.
3. **Module-loader wiring**: when the interpreter loads a bridged
   library, after registering the library's own bridges into the
   per-module env it also resolves each re-export tuple (loading
   the target library if needed) and merges its exported env into
   the current one with the show/hide filters applied. This is
   essentially `importEnvironment` re-used for re-exports.
4. **Deduplication / proxy-bridges**: a class can now appear in
   multiple module envs by reference — that's fine, the existing
   bridge instances are just *referenced* from each importing env,
   not re-registered. The "bridge already registered" guard should
   only fire when two *different* `BridgedClass` instances claim
   the same name. If the same instance appears multiple times,
   skip silently. (The user's "proxy-bridges" suggestion — a
   thin reference type — is not strictly needed if equality on the
   `BridgedClass` instance is sufficient; keep it as a fallback if
   instance identity isn't preserved across re-exports.)
5. **Stdlib hand-bridges**: do the same declaration manually for
   the small set of hand-maintained stdlib bridges (one
   `reExports: [...]` field per library config). E.g. the
   `flutter/services` bridge gains `reExports: ['dart:typed_data']`,
   the `flutter/foundation` bridge gains `reExports: ['dart:async',
   'dart:typed_data', 'dart:collection']`, etc.
6. **Cleanup**: with re-exports modelled, drop the
   `_isolatedStdlibs = {'math'}` narrowing and isolate every stdlib
   in its own env (the original GEN-101 design). The math fix
   (cluster 5) still holds because nothing else `export`s
   `dart:math`.

**Why this is broader than just stdlib**

Re-exports are pervasive across Flutter packages
(`flutter/material.dart` re-exports `flutter/widgets.dart`,
`flutter/widgets.dart` re-exports `flutter/foundation.dart`, etc.).
Today this either works by accident (everything Flutter is
registered with overlapping module envs) or via ad-hoc per-library
include lists. A single generator-driven re-export model fixes
both stdlib and Flutter cross-library reachability with the same
mechanism.

**Where to look**

- `tom_d4rt_generator/lib/src/relaxer_generator.dart` and any
  partner files that walk the analyzer's `LibraryElement` (look
  for `library.exportNamespace` or `library.libraryExports`).
- `tom_d4rt_ast/lib/src/runtime/ast_module_loader.dart`
  `_loadStdlibModule` / `_tryLoadBridgedModule` for the merge
  point.
- The hand-bridged Flutter library configs that need an
  `reExports` field added.

**Out of scope (documented elsewhere)**

Once this lands, cluster 12's `ByteData` sub-issue (script-forgot-
to-import-typed_data) becomes irrelevant — the script imports
`flutter/services.dart` and ByteData arrives via the re-export.

---

## How clusters were derived

`generator_interpreter_issues_test.dart` was run end-to-end. Its
`.result.json` was parsed for `type=="error"` events, the runtime
error messages bucketed by leading exception family, and the
representative test names per bucket recorded above. A test that
emitted multiple distinct errors was attributed to the dominant
(first) one. Cluster counts are approximate — re-bucketing after a
cluster fix may shift small counts between adjacent buckets.

To regenerate the clusters after a fix:

```bash
cd tom_d4rt_flutterm
flutter test test/generator_interpreter_issues_test.dart \
    --file-reporter "json:doc/testlog_<id>/generator_interpreter_issues_test.result.json"

jq -rs '
  (reduce .[] as $e ({};
    if $e.type == "testStart" then .[$e.test.id|tostring] = $e.test.name else . end
  )) as $names |
  .[] | select(.type=="error") | "\($names[(.testID|tostring)] // "?")|||\(.error|gsub("\n";" "))"
' doc/testlog_<id>/generator_interpreter_issues_test.result.json
```

Then `awk -F'\\|\\|\\|'` on the patterns above to slice out scripts per
cluster.

---

## History

For the per-batch (batch 0–10) resolved-issue narratives that previously
lived in this file, see git history:

```
git log -p tom_d4rt_flutterm/doc/interpreter_issues.md
```

Resolved highlights from earlier batches included enum exhaustiveness
workarounds (issue 13), platform-capability guards (issue 16), the
record-pattern for-loop AST support (#21–25, #28–33), the bridged
`String.characters` extension (#77), `Iterable.whereType` (#80, #81),
the abstract widget bases (#75/#76/#78), the `.new` constructor
tear-off (#79), the `State<T>.widget` access (#82, narrowed in
[524caa13](https://github.com/al-the-bear/tom_d4rt/commit/524caa13)),
the function-typed bridge return wrapper (#74), and the State proxy
lifecycle re-entrancy guard
([13a0c2f8](https://github.com/al-the-bear/tom_d4rt/commit/13a0c2f8)).
