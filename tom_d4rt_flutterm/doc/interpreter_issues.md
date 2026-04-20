# Interpreter / Bridge Issues

Active issue list, organised by cluster. Each cluster is a recurring
failure pattern hit by demo scripts in `tom_d4rt_flutterm_app`. The
representative scripts under each cluster are useful as starting points
for a targeted fix and as regression tests once the cluster is closed.

Last refreshed: 2026-04-19, against
`doc/testlog_20260418-1500-e22671e8/generator_interpreter_issues_test.result.json`
(rev `13a0c2f8`+`037c11b1`). At this point the file ran **27 / 0 / 56**
(was 0 / 9 / 74 on 2026-04-16). The 56 remaining failures distribute
across the clusters below.

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

### [ ] Fixed — `super.build()` call on bridged State subclass

**Symptom**

```
Runtime Error: Internal error: Cannot call super method 'build' on bridged
superclass 'State' because the native super object is missing.
```

**Root cause**

Scripts that mix in `State` and call `super.build(context)` (or
`super.didChangeDependencies()`, etc.) hit the bridged-super dispatch
path expecting a real native State instance — but only the proxy
exists. Related to the lifecycle re-entrancy guard fix in
[13a0c2f8](https://github.com/al-the-bear/tom_d4rt/commit/13a0c2f8)
but the underlying super-method dispatch still rejects the proxy as
"missing".

**Representative scripts** (5 entries)

- `widgets/shortcut_registry_entry_test.dart`
- `widgets/shortcut_serialization_test.dart`
- `widgets/single_activator_test.dart`
- `widgets/single_child_render_object_element_test.dart`
- `widgets/single_child_render_object_widget_test.dart`

**Where to look**

Bridged-super method dispatch in
`tom_d4rt_ast/lib/src/runtime/runtime_types.dart` (~ line 1273) and
mirror in `tom_d4rt/lib/src/runtime_types.dart`. For State subclasses
where `nativeProxy` is set, route `super.<lifecycle>` to the proxy's
`super.<lifecycle>` rather than refusing because `bridgedSuperObject`
is null.

---

### [ ] Fixed — `late` field accessed before initializer (false-positive)

**Symptom**

```
Runtime Error: Undefined variable: _controller (Original error:
LateInitializationError: Late variable '_controller' without initializer
is accessed before being assigned.)
```

**Root cause hypothesis**

The interpreter reports `late` fields as unassigned even when the
script's `initState()` (or constructor body) does assign them. Likely
order-of-evaluation: `build()` runs before the late assignment is
visible on the InterpretedInstance, or the field map is keyed by a
mangled name that the lookup doesn't match.

**Representative scripts** (~10 entries)

- `widgets/render_tree_root_element_test.dart`
- `widgets/autofill_group_test.dart`
- `widgets/indexed_stack_test.dart`
- `widgets/list_wheel_scroll_view_test.dart`
- `widgets/list_wheel_viewport_test.dart`
- `widgets/magnifier_decoration_test.dart`
- `widgets/navigation_toolbar_test.dart`
- `widgets/page_storage_bucket_test.dart`
- `widgets/page_storage_test.dart`
- (… more under same pattern)

**Where to look**

Late-field handling in `InterpretedInstance` and `visitFieldDeclaration`
/ `visitAssignmentExpression` in the visitor. Check whether the
`initState`-assigned value is being committed to the right field-storage
slot before `build()` reads it.

---

### [ ] Fixed — function-typed argument leaks `NativeFunction` past validation

**Symptom**

```
Runtime Error: Native error during default bridged constructor for 'Slider':
Argument Error: Invalid parameter "min": expected double, got NativeFunction
```

**Root cause**

A script-defined function (probably a getter or shorthand returning a
double) is passed where the constructor expects a literal `double`.
The bridge's `extractBridgedArg<double>` doesn't invoke the callable to
unwrap the value, so the `NativeFunction` itself is forwarded as the
argument — and `Slider(min: NativeFunction(...))` rightly fails.

Connected to the broader function-type-adaptation work tracked in #74
([33d121c2](https://github.com/al-the-bear/tom_d4rt/commit/33d121c2)) —
that fix landed for *return values*, this is the *argument-side* mirror.

**Representative scripts** (~8 entries)

- `widgets/image_filtered_test.dart`
- `widgets/indexed_stack_test.dart`
- (… also surfaces inside scripts hit by other clusters)

**Where to look**

`D4.extractBridgedArg<T>` in `tom_d4rt_*/lib/src/generator/d4.dart`. When
T is a primitive (`double`, `int`, `String`, `bool`) and the value is a
zero-arg `Callable`, invoke it and re-extract.

---

### [ ] Fixed — `Directionality.child` rejects InterpretedInstance Widget subclass

**Symptom**

```
Runtime Error: Native error during default bridged constructor for 'Directionality':
Argument Error: Invalid parameter "child": expected Widget, got
InterpretedInstance(PanelTheme)
Argument Error: Invalid parameter "child": expected Widget, got
InterpretedInstance(AppStateScope)
```

**Root cause**

User-defined `class PanelTheme extends InheritedWidget` (or similar
abstract Widget base) is not auto-wrapped into a native proxy when
passed across a bridge boundary. Same shape as the fix landed for
`LeafRenderObjectWidget` / `SingleChildRenderObjectWidget` /
`MultiChildRenderObjectWidget` in
[f6c7db8f](https://github.com/al-the-bear/tom_d4rt/commit/f6c7db8f) —
needs equivalent `_InterpretedInheritedWidget` proxy + interface-proxy
registration.

**Representative scripts** (3 entries)

- `widgets/inherited_theme_test.dart`
- `widgets/inherited_widget_test.dart`
- (one more from the cluster of `_PaneList` failures)

**Where to look**

`tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart` — add an
`_InterpretedInheritedWidget` proxy class + `D4.registerInterfaceProxy(
'InheritedWidget', ...)` registration, mirroring the existing
RenderObjectWidget family.

---

### [ ] Fixed — missing bridge entries: `setState` / `Enum` / `ByteData` / `key` / `layoutChild`

**Symptom**

```
Runtime Error: Undefined variable: setState (Original error: Undefined property 'setState' on _DefaultDemoPageState.)
Runtime Error: Undefined variable: Enum
Runtime Error: Undefined variable: ByteData
Runtime Error: Undefined variable: key (Original error: Undefined property 'key' on _PaneList.)
Runtime Error: Undefined variable: layoutChild (Original error: Undefined property 'layoutChild' on TestMultiChildLayoutDelegate.)
```

**Root cause**

Each is a different missing piece, lumped here for triage:

- `setState` on a plain `_InterpretedState` instance — narrowed-#82
  fix ([524caa13](https://github.com/al-the-bear/tom_d4rt/commit/524caa13))
  intentionally skips `nativeProxy` for plain States; that means
  `setState` is no longer routed through Flutter at all. Need a direct
  setState handler in the interpreter (mark dirty, schedule rebuild
  via the framework).
- `Enum` — bridged base class missing from stdlib registrations.
- `ByteData` — `dart:typed_data` bridge incomplete.
- `key` on user widget subclass — interpreter doesn't surface the `key`
  field declared in the bridged `Widget` super.
- `layoutChild` on `MultiChildLayoutDelegate` — proxy class missing
  for that abstract delegate.

**Representative scripts** (~5 entries)

- `widgets/restorable_enum_n_test.dart` (Enum)
- `widgets/transition_delegate_test.dart`
- `services/codecs_test.dart` (ByteData)
- `widgets/layout_builder_adv_test.dart` (layoutChild)
- `widgets/page_storage_test.dart` (key)
- `widgets/parent_data_widget_test.dart`

**Where to look**

Each sub-issue has its own location:
- `setState`: `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart`
  (add interpreter-side bridge for State.setState that calls
  `proxy.markNeedsBuild()` directly).
- `Enum`, `ByteData`: bridge module configs +
  `tom_d4rt_flutterm/lib/src/bridges/*_bridges.b.dart` regen.
- `key`: bridged Widget getter wiring.
- `layoutChild`: needs proxy class + interface registration.

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
