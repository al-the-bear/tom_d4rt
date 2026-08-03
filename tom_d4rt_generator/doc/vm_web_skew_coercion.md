# VM↔web signature-skew coercion (`enableVmWebSkewCoercion`)

Some Flutter `dart:ui` members declare a named parameter **nullable on the VM
SDK but non-nullable on web** (dart2js). The bridge generator reads the VM
analyzer summaries, so its standard extraction emits a nullable local
(`getNamedArgWithDefault<T?>(…)`) and forwards it directly to the call. That
compiles on the VM but fails dart2js with:

```
The argument type 'Offset?' can't be assigned to the parameter type 'Offset'.
```

A single skewed member can keep an entire bridge set from building for the web.
This doc describes the generator-side registry that records such parameters and
emits a `?? default` coercion to bridge the gap, and how to extend it when a new
skew is found.

> **One-line summary:** add a `'<class>.<method>.<param>'` key to
> `_vmWebSkewNonNullParams` in `bridge_generator.dart` and regenerate with
> `enableVmWebSkewCoercion: true`. The coercion reuses the parameter's own
> default, so the runtime behaviour is unchanged.

---

## The mechanism

### 1. The registry — `_vmWebSkewNonNullParams`

`bridge_generator.dart` holds a `static const Set<String>` keyed
`'<className>.<methodName>.<paramName>'`:

```dart
static const Set<String> _vmWebSkewNonNullParams = {
  // SceneBuilder.pushOpacity: VM `{Offset? offset = Offset.zero}` vs web
  // `{Offset offset = Offset.zero}`.
  'SceneBuilder.pushOpacity.offset',
};
```

Only the *identity* of the skewed parameter is recorded. The coercion default is
the parameter's own (already package-prefixed) default value, so the set never
needs to carry a literal.

### 2. The gate — `enableVmWebSkewCoercion`

A constructor flag on `BridgeGenerator`, **default `false`**:

```dart
BridgeGenerator(
  …,
  enableVmWebSkewCoercion: false, // default — committed *.b.dart stays byte-identical
);
```

While the gate is off, `_isVmWebSkewParam(...)` always returns `false`, so the
generator emits exactly the same output it always has. This is the
**byte-identical guarantee**: shipping the registry dormant changes no committed
bridge file until a consumer deliberately flips the gate and regenerates.

### 3. The integration site — `_generateNamedParamExtraction`

When a named parameter has a wrappable default, the generator emits a
`getNamedArgWithDefault` extraction. For a registered skew parameter whose
VM-derived type is nullable (`T?`), it appends `?? <prefixedDefault>` so the
local infers the non-null `T`:

```dart
final skewSuffix =
    isNullable && _isVmWebSkewParam(skewClassName, contextName, param.name)
        ? ' ?? $prefixedDefault'
        : '';
buffer.writeln(
  "        final $localName = $helperMethod<$typeArg>"
  "(named, '${param.name}', $prefixedDefault)$skewSuffix;",
);
```

The non-null local then assigns cleanly to the web's non-nullable parameter
*and* to the VM's nullable parameter (nullable accepts non-null). With the gate
on, the emitted line for `SceneBuilder.pushOpacity` becomes:

```dart
final offset = D4.getNamedArgWithDefault<ui.Offset?>(named, 'offset', ui.Offset.zero) ?? ui.Offset.zero;
```

`skewClassName` is threaded in from the **method** extraction call sites
(instance and static methods) — not the constructor site, since the known skews
are all methods. If a future skew lands on a constructor parameter, the
constructor call site (`_generateNamedParamExtraction` at the constructor loop)
must also pass `skewClassName: cls.name`.

---

## How to extend the registry

When dart2js reports a `T?`-can't-assign-to-`T` error on a generated bridge:

1. **Identify the skewed parameter.** Note the bridged class, the method, and
   the named parameter — e.g. `Foo.bar.baz`.
2. **Confirm the skew is real**, not a generator bug: the parameter must be
   nullable in the VM `dart:ui`/Flutter summary but non-nullable in the web
   summary, *and* it must have a default value (the coercion reuses that
   default). If the parameter has no default, the `?? default` strategy does not
   apply — use a `@D4rtUserBridge` override instead (see below).
3. **Add the key** to `_vmWebSkewNonNullParams`:

   ```dart
   static const Set<String> _vmWebSkewNonNullParams = {
     'SceneBuilder.pushOpacity.offset',
     'Foo.bar.baz', // new skew
   };
   ```

4. **Add a unit-test case** in `test/vm_web_skew_test.dart` (or extend the
   fixture `test/fixtures/vm_web_skew_source.dart`) asserting that the gate-on
   output coerces the new parameter and the gate-off output leaves it plain.
5. **Regenerate the affected bridge twins with the gate on** and run the
   web/dart2js smoke compile to confirm the error is gone. (This regen is the
   heavyweight tail — see *Status* below.)

### When `?? default` does not fit

The registry strategy only works for parameters that (a) are nullable on the VM,
(b) are non-nullable on web, and (c) carry a default whose semantics make
"explicit `null` → default" a behaviour-preserving mapping. For skews outside
that shape (no default, or a different web type entirely), write a
`@D4rtUserBridge` override that hand-codes the web-safe adapter. See
[user_bridge_user_guide.md](user_bridge_user_guide.md).

---

## The interim user-bridge override and its retirement

Before the registry shipped, the single known skew was patched with a
hand-written override in the **AST twin only**
(`tom_d4rt_flutter_ast/lib/src/d4rt_user_bridges/scene_builder_user_bridge.dart`):

```dart
@D4rtUserBridge('dart:ui', 'SceneBuilder')
class SceneBuilderUserBridge extends D4UserBridge {
  static Object? overrideMethodPushOpacity(…) {
    …
    final ui.Offset offset =
        D4.getNamedArgWithDefault<ui.Offset?>(named, 'offset', ui.Offset.zero) ??
            ui.Offset.zero;
    …
  }
}
```

This override is **functionally identical** to what the registry now emits — it
is the same `?? Offset.zero` coercion, just written by hand. Once both flutter
twins are regenerated with `enableVmWebSkewCoercion: true`, this override becomes
redundant and should be deleted (the generated `SceneBuilder.pushOpacity` adapter
will already be web-safe). It exists in the AST twin only because that is the
twin exercised by the web smoke path; there is no `tom_d4rt_flutter`
counterpart.

---

## Tests

`test/vm_web_skew_test.dart` pins both gate states against the
`test/fixtures/vm_web_skew_source.dart` fixture:

| Test | Asserts |
|------|---------|
| `G-ISS-38a` | gate **ON** → the skewed `offset` extraction is coerced (`getNamedArgWithDefault<…Offset?>(…) ?? …`). |
| `G-ISS-38b` | gate **OFF** (default) → no coercion is emitted (committed bridges stay byte-identical); the plain nullable extraction is still present. |

Both pass under `dart test test/vm_web_skew_test.dart`.

---

## Status — shipped core vs. deferred regeneration tail

| Part | State |
|------|-------|
| Registry + flag + integration site in `bridge_generator.dart` | **Shipped** (gate off → byte-identical). |
| Unit tests (gate ON/OFF) | **Shipped, green.** |
| This documentation | **Shipped.** |
| Both-twin regen with the gate **ON** | **Deferred** — blocked by the stale committed `.b.dart` baseline: a no-op regen of `tom_d4rt_flutter_ast` already churns ~16 files (incl. a 985-line `vector_math` `_createMatrix4Bridge()` deletion), so a gate-on regen cannot be committed as a clean scoped diff until that baseline is reconciled under the serial base-test gate. |
| Deleting `SceneBuilderUserBridge.overrideMethodPushOpacity` | **Deferred** — depends on the gate-on regen landing first (removing it before the generated adapter is web-safe would regress `SceneBuilder.pushOpacity`). |
| Serial base-test gate + dart2js/web smoke | **Deferred** — `flutter test` in the twins must run serially (shared HTTP companion app); the full 14-file corpus across both twins is a multi-hour sweep, run via `tom_d4rt_flutter_ast/tool/sweep_both_projects.sh`. |

The deferred tail is tracked in `_ai/quests/d4rt/todo_impossible.md` (#7) and,
as a live entry, in `_ai/quests/d4rt/todos.d4rt.todo.yaml`.
