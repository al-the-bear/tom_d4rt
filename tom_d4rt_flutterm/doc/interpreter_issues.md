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

### [X] Fixed — abstract delegate proxies missing at bridge boundaries

**Resolution:** Three coordinated fixes:

1. **Bug-102a — hand-written proxies for `InheritedWidget`,
   `MultiChildLayoutDelegate`, `SingleChildLayoutDelegate`,
   `CustomClipper<Path>`** in
   `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart`.
   Pattern mirrors the existing LeafRenderObjectWidget family: a
   native proxy holds a back-reference to the interpreted instance
   and forwards the abstract members (`updateShouldNotify`,
   `performLayout`, `shouldRelayout`, `getConstraintsForChild`,
   `getSize`, `getPositionForChild`, `getClip`, `shouldReclip`) into
   the interpreter. For layout/clip delegates the proxy factory also
   stores itself as `instance.nativeProxy` so bridged-super members
   (`layoutChild`, `positionChild`, `hasChild`,
   `getApproximateClipRect`) dispatch through the RC-6 `nativeProxy`
   fallback when the script calls them on `this`.

2. **Bug-103a — override generator-emitted delegate proxies.** The
   auto-generated `registerProxyFactories()` emits proxies for these
   delegate classes with `<dynamic>` type arguments. Because Dart
   generics are invariant, a `D4rtCustomClipper<dynamic>` does NOT
   satisfy `CustomClipper<Path>`, so the factory's return was
   rejected at the proxy-is-T check. A new
   `registerD4rtInterfaceProxyOverrides()` runs after
   `FlutterMaterialBridges.register(...)` in the `FlutterD4rt`
   constructor and re-registers the factories with concrete type
   arguments that satisfy the native-side checks.

3. **Bug-102b/c — transitive + cross-level hierarchy walk.**
   `D4.tryCreateInterfaceProxyWithVisitor<T>` now walks the
   interpreted-superclass chain (so `_DashboardDelegate extends
   _BaseDelegate extends MultiChildLayoutDelegate` is handled even
   though `_DashboardDelegate.bridgedSuperclass` is null at the
   outermost class) and at each level pulls in transitively-
   registered supertypes via the new
   `BridgedClass.transitiveSupertypeNames(name)` helper. This is
   how `PanelTheme extends InheritedTheme` now finds the
   `InheritedWidget` proxy up the chain. `InheritedTheme` was also
   added to the `BridgedClass.registerSupertypes({…})` table in
   `_registerBridgedSupertypes`.

After fix:
- `render_physical_shape_test` (CustomClipper<Path>) — PASS.
- `render_custom_single_child_layout_box_test` — PASS.
- `layout_builder_adv_test`, `parent_data_widget_test`,
  `render_custom_multi_child_layout_box_test` — past the
  cluster-9 error; now fail on downstream script-side bugs
  (null being multiplied by int, `Cannot access property 'height'
  on target of type null`). Tracked under cluster 12 once triaged.
- `inherited_theme_test`, `inherited_widget_test` — past the
  "expected Widget, got InterpretedInstance(PanelTheme)" error;
  now fail on `PanelTheme.of called with no PanelTheme in context`
  (Flutter's `dependOnInheritedWidgetOfExactType<PanelTheme>()`
  returns null because the native tree only sees
  `_InterpretedInheritedWidget`, not the script's `PanelTheme`
  type). That's a type-identity mismatch that needs a deeper
  fix (e.g. a per-script-class proxy generated on the fly); tracked
  for later.
- `rendering/relayout_when_system_fonts_change_mixin_test`,
  `render_absorb_pointer_test` — scripts subclass `RenderObject` /
  `RenderBox` directly. Proxying those abstract bases has dozens of
  abstract methods and is out of scope here.
- generator_interpreter_issues_test: 46/0/37 → **49/0/34** (+3 pass).
  All `expected Widget/delegate/clipper, got InterpretedInstance`
  errors on cluster-9-covered base classes are eliminated.
- essential / important / secondary: 108/0/0, 166/0/3, 651/0/3
  unchanged.

**Symptom (was)**

```
Argument Error: Invalid parameter "delegate": expected MultiChildLayoutDelegate, got InterpretedInstance(_DashboardLayout)
Argument Error: Invalid parameter "delegate": expected SingleChildLayoutDelegate, got InterpretedInstance(_AnchorPositioner)
Argument Error: Invalid parameter "clipper": expected CustomClipper<Path>, got InterpretedInstance(_BevelClipper)
Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(PanelTheme)
Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(AppStateScope)
Runtime Error: Undefined variable: layoutChild (Original error: Undefined property 'layoutChild' on TestMultiChildLayoutDelegate.)
```

Still open (separate scope, tracked elsewhere):

- `RenderObject` / `RenderBox` subclass proxies (deep abstract base
  with many required overrides) — affects a small number of demos.
- Per-script-class inherited-widget proxying for scripts that use
  `MyInheritedWidget.of(context)` patterns.

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

### [~] Partially fixed — function-typed argument residuals at intermediate boundaries

**Resolution:** GEN-081/081b covers the **return-side** half of this
cluster (callback result routed through `extractBridgedArg<T>` rather
than a direct `as T` cast, plus rc2-factory reference-type args use
extractBridgedArg when the base type is non-primitive). Both emission
sites live in `tom_d4rt_generator/lib/src/`:

- `relaxer_generator.dart` — the `_rc2IsPrimitiveCastable` gate on
  named / positional rc2 factory args (non-primitives go through
  extractBridgedArg so an InterpretedInstance gets wrapped by the
  registered interface-proxy factory).
- `bridge_generator.dart` and `relaxer_generator.dart` — callback
  wrapper bodies now emit
  `D4.extractBridgedArg<ReturnT>(callExpr, 'callback', visitor)`
  instead of `callExpr as ReturnT`. Passing `visitor` explicitly
  matters because `D4.activeVisitor` is typically null when Flutter
  fires the callback from its widget machinery — without it the
  proxy-resolver can't walk the hierarchy.

Extra supertype registry entries (`InheritedModel`,
`InheritedNotifier`) added so scripts subclassing those also match
the InheritedWidget proxy.

After fix:
- `image_filtered_test` — PASS (was
  "type 'InterpretedInstance' is not a subtype of type 'Widget?' in
  type cast" on the ListView itemBuilder).
- `window_scope_test` — past the original "InterpretedInstance not
  Widget" error; now fails with "No _DemoWindowScope found in
  context" (same Flutter-side type-identity mismatch as cluster 9
  InheritedWidget scripts — tracked separately).
- `semantics_config_test`, `channels_test` — still fail with the
  **argument-side** function-type mismatch
  (`InterpretedFunction not a subtype of (() => void)?`,
  `(dynamic) => Future<dynamic>` not a subtype of
  `((String?) => Future<String>)?`). That is the mirror of GEN-081b
  for the *arg* side of bridged method invocations and needs a
  separate pass in the generator's argument emission. Sub-issue
  tracked within this cluster for a follow-up commit.
- generator_interpreter_issues_test: 49/0/34 → **50/0/33** (+1 pass).
- essential / important / secondary: 108/0/0, 166/0/3, 651/0/3
  unchanged.

**Still open (argument-side function-type wrapping):**

When a script passes an `InterpretedFunction` to a bridged method
whose parameter is a typed function (e.g.
`SemanticsConfiguration.onTap = () { ... }` or
`BasicMessageChannel.setMessageHandler((msg) async { ... })`), the
bridge's method adapter forwards the `InterpretedFunction` directly
and Flutter's `as (() => void)` / `as (String?) => Future<String>`
cast fails. Need per-call-site typed closure emission at the arg
side of bridge generation, similar to the `_emitTypedReturn` work in
`proxy_generator.dart` for the #74 return-side fix. Affects:

- `semantics/semantics_config_test.dart`
- `services/channels_test.dart`

**Symptom (was)**

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

### [X] Fixed (10a) — argument-side function-type wrapping

Follow-up split out from cluster 10 after GEN-081b closed the
return-side half. **Setter-side wrapping landed in GEN-083**, and
the generic-class method-arg path (BasicMessageChannel.setMessageHandler)
was closed in GEN-083b via a `D4UserBridge` that bypasses the
typed `setMessageHandler` with a binary-messenger-level adapter.

**Symptom**

```
type 'InterpretedFunction' is not a subtype of type '(() => void)?'
Runtime Error: Native error during bridged method call 'setMessageHandler' on BasicMessageChannel: type '(dynamic) => Future<dynamic>' is not a subtype of type '((String?) => Future<String>)?' of 'handler'
```

**Root cause**

A script passes its own function (an `InterpretedFunction` or similar
`Callable`) to a bridged method or setter whose parameter is a
strictly typed function. The bridge's method adapter forwards the
callable directly into the native call, and Dart's reified function-
type subtyping rejects `(dynamic) => dynamic` where a typed signature
like `(() => void)?` or `((String?) => Future<String>)?` is
required. This is the mirror of the #74 / GEN-081b *return-side*
typed-wrapper work — the generator needs to wrap the incoming
callable into a concrete typed closure that forwards through
`D4.callInterpreterCallback` instead of just casting.

GEN-075 already does the equivalent for Map-valued parameters via
`_wrapCallableForMap<T>`; what's missing is the scalar-parameter
variant (`void Function()`, `(String?) => Future<String>`, …) at
method-invocation argument positions.

**Fix (GEN-083, setter half)**

- `tom_d4rt_generator/lib/src/bridge_generator.dart` — instance and
  static setter emission now consult `_knownFunctionTypeAliasInfo`
  (`VoidCallback`, `ValueChanged`, `ValueGetter`, `ValueSetter`, …)
  when the analyzer's `functionTypeInfo` is null, so typed wrappers
  are emitted for setters whose type is a typedef alias.
- `tom_d4rt{,_ast}/lib/src/…/interpreter_visitor.dart` —
  `visitFunctionExpressionInvocation` now falls back to
  `Function.apply` when the callee is a native Dart `Function` value.
  Scripts can read back a callback they assigned through a
  typed-wrapper setter (e.g. `configActions.onTap!()`) and invoke it.

After this fix `semantics/semantics_config_test.dart` passes. The
`sliver_child_builder_delegate_test.dart` script also flipped to
green as a side-effect of the same setter wrapping.

**Fix (GEN-083b, generic-class method-arg half)**

- `tom_d4rt_flutterm/lib/src/d4rt_user_bridges/basic_message_channel_user_bridge.dart` —
  new `BasicMessageChannelUserBridge` extending `D4UserBridge`.
  Overrides `setMessageHandler` by bypassing the typed
  `BasicMessageChannel<T>.setMessageHandler` entirely and installing
  the handler at the `BinaryMessenger` layer, using the channel's
  own `MessageCodec` to encode/decode `T`. This is the same pattern
  Flutter's native `setMessageHandler` uses internally, but the
  `MessageHandler` it hands to `binaryMessenger` is non-generic
  (`(ByteData?) => Future<ByteData?>`) so Dart's runtime function-
  type check never sees a `T`-parameterised closure.
- `tom_d4rt_generator/lib/src/bridge_api.dart` — `generateBridges`
  now pre-scans the build project's `d4rt_user_bridges/` directory
  before processing modules (`_preScanUserBridges`), mirroring the
  behaviour of `v2/d4rtgen_executor._scanUserBridges`. Previously
  only `v2` populated the scanner from the build project, so any
  `D4UserBridge` living outside Flutter source files was invisible
  to the `BridgeGenerator` instances created per module (including
  the long-standing `StrutStyleUserBridge`, which was silently
  inert).

The wrapper/adapter pattern here is the right shape for every
class where a bridged method's parameter references the class-
level type parameter: instead of asking the generator to produce
a `T`-specialised closure (impossible without reflection on
runtime type arguments), install a hand-written `D4UserBridge`
that performs the type-specific dispatch via codecs, runtime
checks, or an explicit adapter class.

---

### [X] Fixed (11, GEN-094) — generic constructor / relaxer edge cases

**Symptom** (now resolved; original diagnostic messages)

```
Runtime Error: Error in generic constructor factory for 'TweenSequenceItem': Null check operator used on a null value
NoSuchMethodError: Class '$RelaxedAnimation<Offset>' has no instance method 'addListener' with matching arguments.
Runtime Error: Cast failed with 'as' : the value does not match the target type (Instance of 'SNamedType')
type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
```

**Root cause** (four independent generator/runtime edges, diagnosed in sequence)

1. **Relaxer `rc2` scope was empty.** The Step 2c expansion in
   `relaxer_generator.dart` iterated only `gen075Classes`, but
   `TweenSequenceItem` is RC-2-eligible (not gen075). Worse,
   `_isTypeInScope` compared absolute filesystem paths (e.g.
   `/srv/flutter/flutter/bin/cache/pkg/sky_engine/lib/ui/ui.dart`)
   against `package:` URI prefixes, so *every* Flutter class was
   "out of scope" — `allConcreteBridgedTypes` came out empty and the
   generated `_relaxAnimatable$rc2` factory only had primitive cases
   (String, int, double, bool, num). Result: `TweenSequenceItem<Color?>
   (tween: ColorTween(...))` had no way to bridge `Animatable<Color?>`
   → `Animatable<Color>` through the relaxer.
2. **`extractBridgedArg<T?>` silently returned null for relaxable
   generics.** The emitted `_rc2TweenSequenceItem` factory used
   `extractBridgedArg<Animatable<Color>?>(..)!` — the "extract as
   nullable then bang" pattern. For a nullable `T?`, the ENG-007
   path `return unwrapped as T` caught the `TypeError` from the
   invariant mismatch and fell through, but on some shapes the
   function then returned null via an earlier nullable-friendly
   branch *without ever hitting the GEN-079 wrapper resolution*.
   `!` on that null fired "Null check operator used on a null value"
   inside the factory.
3. **`$Relaxed<V>` wrappers exposed only T-involving members.** The
   `_writeImplementsDelegation` helper emitted `noSuchMethod` that
   just re-throws, and only overrode methods/getters that referenced
   T. Every non-T-typed method on the underlying interface
   (`addListener`, `removeListener`, `status`, …) fell into
   `noSuchMethod` and threw `NoSuchMethodError` on the relaxer proxy.
4. **Typed-List callback returns weren't coerced.** `bridge_generator.dart`
   emitted `D4.extractBridgedArg<List<Widget>>(...)` for function-
   wrapper return types like `headerSliverBuilder: (ctx, scrolled)
   => <Widget>[…]`. The interpreter hands back a `List<Object?>`
   (collection literals don't retain their type arg through the
   bundle), and extractBridgedArg's list path has no case that casts
   `List<Object?>` to `List<Widget>`.

A fifth, smaller edge fell out of the same diagnostic session:
`as double` on an `int` value (from script-side `<double>[0, 25, 50,
...]` literals that stay int in D4rt) threw instead of promoting.

**Fix (GEN-094)**

- `tom_d4rt_generator/lib/src/relaxer_generator.dart`
  - Step 2c now iterates every RC-2-eligible class (single-param,
    non-abstract, non-sealed, has non-factory ctor) in addition to
    gen075Classes. Respects the nested target's type parameter
    bound when expanding the `rc2` type-arg set — primitives and
    concrete types are only added when they satisfy the bound (avoids
    e.g. `$RelaxedRenderObjectWithChildMixin<num>`).
  - `_isTypeInScope` maps absolute file paths that land under
    `/sky_engine/lib/ui/`, `/flutter/packages/flutter/lib/`,
    `/flutter/packages/flutter_web_plugins/lib/`, and
    `/flutter/packages/flutter_test/lib/` to their corresponding
    package URIs and rechecks against `inScopePackagePrefixes`.
  - RC-2 factory emission for non-nullable required params now uses
    `extractBridgedArg<T>` (non-nullable T) directly instead of the
    `<T?>(..)!` pattern. Non-nullable T forces the GEN-079 wrapper
    resolution path to run; `extractBridgedArg<T>` already throws
    on null / wrong-type values, so no `!` is needed.
  - `_writeImplementsDelegation` emits transparent forwarders
    (`void foo(args) => _inner.foo(args);`) for every non-T method
    and non-T getter on the interface (skipping Object defaults and
    operators). The relaxer wrapper now acts as a true proxy.
  - `_buildMethodParamSignature` emits default values for named
    optional params that carry them, and falls back to a nullable
    type when a default is unavailable — otherwise the forwarder for
    e.g. `toStringShallow({String joiner = ', '})` fails to compile.

- `tom_d4rt_generator/lib/src/bridge_generator.dart`
  - Function-wrapper emission routes `List<X>` return types through
    `D4.coerceList<X>(…, 'callback')` instead of
    `extractBridgedArg<List<X>>`. `coerceList` already handles the
    per-element unwrap + typed cast that the list-path in
    extractBridgedArg can't do generically.

- Interpreter (tom_d4rt + tom_d4rt_ast, kept in sync)
  - `visitAsExpression` `case 'double'` now promotes `int` values to
    `double` (INTER-003 parity).
  - Cast-failure diagnostic now includes the actual value type rather
    than `Instance of 'SNamedType'` — `typeNode.toString()` was
    useless because SNamedType doesn't override `toString`.

**Representative scripts** (all 4 now green)

- `animation/tweensequence_test.dart`
- `widgets/slidetransition_test.dart`
- `widgets/nestedscrollview_test.dart`
- `widgets/fixed_extent_metrics_test.dart`

**Regression check** (post-fix)

- gii:       56-57/26-27 (was 52-53/30-31 — +4, pre-existing
  shader_mask + sliver_child_builder flakes)
- essential: 108/0/0 (no regression)
- important: 168/1/0 (was 167/2 — +1, tweensequence now passes)
- secondary: 653/1/0 (was 652/2 — +1, fixed_extent_metrics now passes)

---

### [X] Fixed (12, GEN-102) — `ValueNotifier<T?>(null)` crashes generic-ctor factory

**Symptom** (8 scripts in the 20260424-1838 run)

```
Runtime Error: Error in generic constructor factory for 'ValueNotifier':
  type 'Null' is not a subtype of type 'int' in type cast
```

…with T ∈ {`int`, `String`, `bool`, `LogicalKeyboardKey`, `Offset`,
`ChildVicinity`}. Every failure was triggered by script-side
`ValueNotifier<T?>(null)` top-level declarations.

**Root cause**

The interpreter's `_resolveTypeAnnotation` strips the nullable `?`
marker when it resolves a type argument to a `RuntimeType`. The
flag lives on `SNamedType.isNullable` at the AST level but is lost
once the symbol is looked up in the environment — `.name` on the
returned `RuntimeType` (`BridgedClass`) returns just `'int'`.

Downstream, the generated RC-2 factory (`_rc2ValueNotifier` in
`flutter_relaxers.b.dart`) reads the type arg via
`typeArgs!.first.name as String?` and switches on the bare class
name. `ValueNotifier<int>` and `ValueNotifier<int?>` both surface
as `typeName = 'int'`, so the `'int' => ValueNotifier<int>(_value
as int)` case fires even when the script wrote
`ValueNotifier<int?>(null)` — `null as int` crashes.

The regular non-generic bridge constructor doesn't have this
problem: it switches on `value.runtimeType` and routes `null`
values to the `default:` branch, which produces
`ValueNotifier<dynamic>(null)`. The `$Relaxed<V>` wrapper at
bridge-method boundaries then adapts the untyped notifier to any
typed contract a consumer expects.

**Fix (GEN-102)**

Generator-only change in
`tom_d4rt_generator/lib/src/relaxer_generator.dart`
(`_writeGenericConstructorFactory`). After the parameter
extraction block and before the `switch (typeName)`, emit a
null-guard for every required non-nullable exact-T positional /
named param. When the guard fires, the factory returns `null` to
fall through to the default bridge constructor:

```dart
// GEN-102: Fall through to default bridge constructor when a required
// non-nullable T-typed value is null. The interpreter strips `?` from
// resolved type arguments, so typeName cannot distinguish `<T>` from `<T?>`.
if (_value == null) return null;
```

Applies uniformly to every RC-2 generic class that has one or
more required non-nullable T-typed params (118 factories; the
guard emits only where at least one qualifying param exists).

**Representative scripts** (all 8 now green)

- `widgets/render_tap_region_surface_test.dart`
- `widgets/keyboard_listener_test.dart`
- `widgets/overlay_state_test.dart`
- `widgets/raw_dialog_route_test.dart`
- `widgets/raw_radio_test.dart`
- `widgets/render_two_dimensional_viewport_test.dart`
- `widgets/restorable_bool_n_test.dart`
- `widgets/gesture_detector_adv_test.dart`

**Regression check** (post-fix)

- essential:          108/0/0    (baseline 108/0/0   — unchanged)
- important:          163/5/1    (baseline 163/5/1   — unchanged)
- secondary:          612/40/2   (baseline 611/40/3  — +1 pass, -1 fail: gesture_detector_adv)
- hardly_relevant_4:  227/0/0    (baseline 225/0/2   — +2 pass, -2 fail: keyboard_listener, overlay_state)
- hardly_relevant_5:  227/0/3    (baseline 222/0/8   — +5 pass, -5 fail: raw_dialog_route, raw_radio, render_tap_region_surface, render_two_dimensional_viewport, restorable_bool_n)

Net: **+8 passes, -8 fails, 0 regressions.** Exactly matches the
bucket-1 scope from the 20260424-1838 issue-analysis run.

---

### [X] Fixed (13, GEN-103) — `operator ==` rejects null argument

**Symptom** (5 scripts in the 20260426-1838 run)

```
Runtime Error: Native error during bridged operator '==' on X:
  Argument Error: Invalid parameter "other": expected Object, got Null
```

…with X ∈ {`Color`, `RootElement`, `BoxConstraints`}, triggered
whenever interpreted code evaluated `bridgedInstance == null` (or
compared a bridged instance with a nullable that happened to be
null).

**Root cause**

The Dart spec defines `bool operator ==(Object other)` but at
runtime `other` is implicitly nullable — the compiler rewrites
`a == b` to `identical(a, b) || (a != null && a == b)`. For a
non-null `a`, comparing with `null` short-circuits to `false`
*before* `operator ==` is called.

The bridge generator was emitting equality adapters without that
short-circuit:

```dart
'==': (visitor, target, positional, named, typeArgs) {
  final t = D4.validateTarget<Color>(target, 'Color');
  final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
  return t == other;
},
```

`D4.getRequiredArg<Object>` rejects `null` with an
`ArgumentError`. The interpreter (both `tom_d4rt` and
`tom_d4rt_ast`) feeds `null` into `positional[0]` for a
`bridgedInstance == null` comparison, so the adapter threw before
the native operator could run.

**Fix (GEN-103)**

Generator-only change in
`tom_d4rt_generator/lib/src/bridge_generator.dart`, in both
`_generateOperatorBody` and `_generateCombinedOperatorBody`. Emit
a null short-circuit for `==` adapters before the
`getRequiredArg` call:

```dart
// GEN-103: Dart spec — non-null == null is always false.
if (positional.isEmpty || positional[0] == null) return false;
```

`D4.validateTarget` already guarantees `t` is non-null, so
returning `false` when `other` is null matches Dart semantics
exactly. No interpreter change needed — bug is purely in the
generated adapter shape, so `tom_d4rt` ↔ `tom_d4rt_ast` stay in
sync without edits.

**Representative scripts** (all 5 now green)

- `widgets/glowing_overscroll_indicator_test.dart`
- `widgets/root_element_test.dart`
- `widgets/spell_check_configuration_test.dart`
- `material/toggle_buttons_theme_test.dart`
- `material/toggle_buttons_theme_data_test.dart`

**Regression check** (post-fix)

- gii:                 56/1/26    (baseline range 56-57/26-27 — unchanged)
- essential:           108/0/0    (baseline 108/0/0   — unchanged)
- important:           163/5/1    (baseline 163/5/1   — unchanged)
- secondary:           612/40/2   (baseline 612/40/2  — unchanged in aggregate; affected scripts verified individually)
- hardly_relevant_2:   203/0/0    (all pass)
- hardly_relevant_4:   227/0/0    (baseline 227/0/0   — unchanged)
- hardly_relevant_5:   227/0/3    (baseline 227/0/3   — unchanged)

All 5 target scripts pass individually via
`flutter test --plain-name`. No regressions across any suite.

---

### [X] Fixed (14, GEN-104) — `TransitionDelegate` subclass coercion at native bridge boundary

**Symptom** (1 script in the 20260426-1838 run, present in both
`gii` and `hardly_relevant_5` suites)

```
Argument Error: Invalid parameter "transitionDelegate":
  expected TransitionDelegate<dynamic>, got
  InterpretedInstance(_InstantTransitionDelegate)
```

The script declared
`class _InstantTransitionDelegate extends TransitionDelegate<dynamic>`
and overrode the single abstract `resolve()` method. When that
instance was passed into a Flutter API that demanded a real
`TransitionDelegate`, the bridge's argument coercion couldn't
unwrap it — there was no native-proxy factory registered for
`TransitionDelegate`, so the `extractBridgedArg` chain fell
through to the generic wrapper which the native side rejected.

**Root cause**

`TransitionDelegate` is an abstract base used as a strategy
object by the Flutter `Navigator` machinery. Like the other
abstract delegate classes already covered in cluster 9 (e.g.
`CustomPainter`, `FlowDelegate`), it needs an auto-generated
proxy emitted into `flutter_proxies.b.dart` so
`D4.registerInterfaceProxy('TransitionDelegate', …)` can wrap
an `InterpretedInstance` as a real subclass. Bucket #3 of the
failure analysis flagged the missing entry; without it, every
user subclass tripped the bridge boundary check.

A second, smaller issue surfaced when extending the proxy
allowlist: the proxy generator was emitting

```dart
return D4rtTransitionDelegate(onResolve: …);
```

without explicit type arguments. For a non-bounded type
parameter Dart's inference falls back to `Object?`, which is
fine here, but the same code path would fail on F-bounded
generics like `ThemeExtension<T extends ThemeExtension<T>>`
because `Object?` doesn't satisfy the recursive bound. The
generator should always emit `<dynamic, …>` at factory call
sites.

**Fix (GEN-104)**

Two scoped, generator-only changes:

1. `tom_d4rt_flutterm/buildkit.yaml` — add `TransitionDelegate`
   to `proxyClasses:`, alongside `CustomPainter`,
   `FlowDelegate`, `MultiChildLayoutDelegate`,
   `SingleChildLayoutDelegate`,
   `SliverPersistentHeaderDelegate`, `DataTableSource`. Comment
   above the new entry records the deferred siblings:
   `ParentDataWidget` (needs a super-constructor `child`
   pass-through that the auto-proxy template doesn't emit) and
   `ThemeExtension` (F-bounded generic that doesn't accept
   `dynamic` as a type argument). Both are tracked for a
   follow-up cluster.

2. `tom_d4rt_generator/lib/src/proxy_generator.dart` —
   in `_generateProxyFactoryRegistration`, emit explicit
   `<dynamic, …>` type arguments at the proxy factory call
   site:

   ```dart
   final typeArgList = proxy.typeParameterNames.isEmpty
       ? ''
       : '<${proxy.typeParameterNames.map((_) => 'dynamic').join(', ')}>';
   buffer.writeln('    return ${proxy.proxyName}$typeArgList(');
   ```

   For `TransitionDelegate<T>` this becomes
   `return D4rtTransitionDelegate<dynamic>(...)`. The change is
   no-op for already-passing non-generic proxies, and unblocks
   the F-bound case once the deferred items above are
   generalised.

Both edits are pure generator changes; the `tom_d4rt` ↔
`tom_d4rt_ast` interpreter mirror is unaffected.

**Representative script**

- `widgets/transition_delegate_test.dart` (gii idx 19, also
  present in `hardly_relevant_5`)

**Regression check** (post-fix)

- gii:                 57/1/25    (+1 vs cluster-13 baseline 56/1/26)
- essential:           108/0/0    (unchanged)
- important:           163/5/1    (unchanged)
- secondary:           612/40/2   (unchanged)
- hardly_relevant_2:   203/0/0    (unchanged)
- hardly_relevant_4:   227/0/0    (unchanged)
- hardly_relevant_5:   227/0/3    (+1 pass for transition_delegate_test; the 3 remaining failures are pre-existing — `root_element_mixin_test`, `widget_state_mapper_test`, `widget_state_test` — unrelated to this cluster)

`transition_delegate_test` passes individually via
`flutter test --plain-name`. No regressions in any suite.

**Deferred follow-ups (still in bucket #3)**

- `ParentDataWidget` — auto-proxy template needs a
  super-constructor pass-through for the required `child`
  argument.
- `ThemeExtension<T extends ThemeExtension<T>>` — F-bound
  rejects `dynamic`; needs a concrete-type-arg strategy or a
  reified-parameter proxy.
- `RenderBox` — surface area too large for the auto-proxy
  template; needs a hand-written `D4UserBridge` or a curated
  abstract-method subset.
- `Intent` (zero abstract methods) — proxy generator skips
  classes without abstract methods; needs a marker-class proxy
  path so any subclass can pass the bridge boundary by identity.

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
