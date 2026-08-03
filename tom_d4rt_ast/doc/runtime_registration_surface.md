# Runtime Registration Surface (canonical)

This is the authoritative reference for the **runtime registration surface** —
the process-global hooks a bridge package uses to extend interpreter behaviour
for native classes that the generated `*.b.dart` bridges cannot express on
their own. `tom_d4rt_ast` is the **web-capable twin** and therefore the
canonical home for this document; the analyzer-based `tom_d4rt` carries a thin
counterpart (`tom_d4rt/doc/runtime_registration_surface.md`) that points here
and lists only its VM-specific deltas.

> **Keep both twins in sync.** Every entry below exists identically in
> `tom_d4rt` and `tom_d4rt_ast`, offset only by a constant comment-block delta.
> A change to one side without the other is incomplete.

## 1. The nine `D4.register*` sinks

All sinks are static methods on `D4`
(`lib/src/runtime/generator/d4.dart`), keyed by class-name `String`, and
process-global. They are populated once at bridge-finalize time and then read
during interpretation.

| Sink | Purpose | Mechanism |
|------|---------|-----------|
| `registerInterpretedForNative` | native→interpreted back-map so a native instance can recover the script object that wraps it | — |
| `registerInterfaceProxy` | create a native proxy for an interpreted class that implements/extends a bridged interface | RC-1 |
| `registerTypeCoercion` | convert between equivalent types from different packages (e.g. VM↔web skew) | RC-3 |
| `registerGenericTypeWrapper` | re-create a generic widget/value with a script-supplied element (the "re-creator" pattern) | — |
| `registerGenericConstructor` | supply type arguments to a bridged constructor the adapter would otherwise erase | RC-2 |
| `registerSupplementaryMethod` | add a method missing from the generated bridge (e.g. `@protected` members) | RC-5 |
| `registerBridgedMethodInterceptor` | intercept an instance method call to re-dispatch with the script's type argument | — |
| `registerBridgedStaticMethodInterceptor` | same for a static method | — |
| `registerEnumStaticGetter` | expose a non-constant enum static member | RC-8 |

## 2. `BridgedClass` supertype mechanism

`BridgedClass.registerSupertypes(name, {...})`
(`lib/src/runtime/bridge/bridged_types.dart`) records the transitive supertype
set for a bridged class. `transitiveSupertypeNames(name)` walks that table.
This is what lets an interpreted subclass of, say, `StatefulWidget` be
recognised as a `Widget`/`DiagnosticableTree`/`Diagnosticable` without each
intermediate bridge re-declaring the chain.

The proxy lookup (`D4.tryCreateInterfaceProxyWithVisitor<T>` and the by-name
`tryCreateInterfaceProxyByName`) consults `transitiveSupertypeNames` and keeps
the **most specific** registered proxy (last-match-wins specificity filter).

## 3. Argument resolution leaf

`D4.extractBridgedArg<T>` is the single resolution leaf adapters call to turn a
runtime value into a native `T`. Its order is fixed:

1. generic-wrapper (`registerGenericTypeWrapper`)
2. interface-proxy (`registerInterfaceProxy` → `tryCreateInterfaceProxy*`)
3. RC-3 coercion (`registerTypeCoercion`)
4. **throw** — no silent fallback to `null`

## 4. RC-9: State-proxy field fallbacks (no registration)

There is **no** `registerPropertyInterceptor` API — it was removed. Property
access on interpreted `State` subclasses is resolved entirely inside
`runtime_types.dart` (`Instance.get`) through instance fields and a duck-typed
proxy getter:

- `interpretedStatefulWidget` field — when set, the `widget` getter returns it
  directly, short-circuiting the bridged getter (prevents `setState` looping
  through Flutter).
- `nativeProxy.interpretedWidget` (duck-typed, RC-6b) — for `widget` access
  with `bridgedSuperObject == null`, the interpreter duck-types this getter and
  returns the `InterpretedInstance` it yields.
- `nativeStateProxy` field — read-only getter fallback (`context`, `mounted`)
  and the GEN-112 method-routing target so `setState`/`initState` fire on the
  real Flutter element.

See `tom_d4rt/doc/advanced_bridging_user_guide.md` §"RC-9" for the worked
example.

## 5. Process-global package pool + warm parent (`providePackage`)

A second process-global surface, distinct from the `D4.register*` sinks
above: the **bridge-definition pool** that makes a package's registration
cost a once-per-process expense. It lives on `D4rtRunner`
(`lib/src/runtime/d4rt_runner.dart`) and is mirrored on `D4rt` in
`tom_d4rt_exec` and `tom_d4rt`. Background, root-cause analysis, and the
measured payoff are in the quest doc
`_ai/quests/d4rt/interpreter_import_optimization.md` (+ its plan /
decisions companions); this is the catalogue entry.

| Surface | Scope | Purpose |
|---------|-------|---------|
| `static Map<String, _PackageBridgeBundle> _packagePool` | process-global | the immutable per-package registration payload (bridged classes/enums/extensions, library functions/vars/getters/setters, aliases, typedefs, re-exports, type→thunk map, queued extension callbacks), built once per package per process |
| `static Map<String, Environment> _warmParentCache` | process-global | the imports-resolved warm parent `Environment` (stdlib + pooled bundles for an allowed-set), keyed by the sorted allowed-set signature; reused across instances **and** across `execute*`/`executeBundle*` calls |
| `Set<String> _allowedPackages` | per-instance | security whitelist — an instance only ever sees packages it has provided; the warm parent it gets contains only those packages |

### `providePackage` contract

```dart
/// Grants [packageName] to this instance and reports whether its bridge
/// definitions are already pooled.
///   false → not pooled; caller MUST register now (those register* calls
///           accumulate into the pool under [packageName]).
///   true  → already pooled; caller skips registration and reuses the pool.
/// Either way [packageName] is added to this instance's allowed set.
bool providePackage(String packageName);
```

Canonical guard idiom (see `FlutterD4rt._registerBridges`):

```dart
if (runner.providePackage('tom_d4rt_flutter_ast') == false) {
  registerRelaxers();
  registerD4rtRuntimeExtensions();
  FlutterMaterialBridges.register(runner);
  runner.registerExtensions('tom_d4rt_flutter_ast', registerProxyOverrides);
}
runner.finalizeBridges(); // cheap on later instances
```

Legacy callers that never call `providePackage` route their `register*`
calls into a synthetic `'<default>'` package every instance is implicitly
allowed — preserving the pre-pool "everything is exposed" behaviour.

### How it ties to the rest of the surface

- The pool holds the **definitions**; the lazy **thunks** (a class's seven
  member maps + adapter closures) are still built on first resolution and
  memoized into the warm parent — so the `D4.register*` sinks in § 1 are
  still populated exactly once, at bridge-finalize time.
- `finalizeBridges` / `registerExtensions` (see
  `extension_registration.md`) fire their queued callbacks **once per
  package per process** (at pool population), not once per instance.
- `warmup()` finalizes + builds the warm parent for the instance's
  allowed-set deliberately, so the one-time cost is paid off-frame.
- Test introspection: `debugResetPool` (clears both static maps),
  `debugPooledPackages`, `debugPooledClassCount(name)`,
  `debugWarmParentCacheSize`.

> **Residual (tracked):** the warm parent eliminates the per-execute
> bridge *rebuild*, but the per-execute import *directive* resolution
> still reassembles a package's per-import module environment each
> `executeBundle` (fresh `AstModuleLoader` per call). Follow-up: hoist the
> per-URI bridged-module environments to runner scope — see
> `_ai/quests/d4rt/deferred.d4rt.md`.

## 6. Web-divergence map (where the twins legitimately differ)

The registration **API** is in lockstep. The divergence lives only in the
downstream manual registration files
(`tom_d4rt_flutter{,_ast}/lib/src/d4rt_runtime_registrations.dart`):

| Divergence | Status |
|------------|--------|
| `_InterpretedKeepAliveState` (`AutomaticKeepAliveClientMixin`) + its walk/dispatch — **non-AST only** | **accidental drift** — the web twin is missing keep-alive State support; tracked to converge via the generator's `mixinVariants:` State family |
| `RouterDelegate<Object>` (non-AST) vs `RouterDelegate<dynamic>` (AST) | **suspected drift** — one is wrong; the two must be reconciled |
| narrow `src/runtime/...` imports (AST) vs single `package:tom_d4rt/d4rt.dart` barrel (non-AST) | **legitimate** — the AST barrel does not re-export the same internal symbols |
| `scene_builder_user_bridge.dart` — **AST only** | **legitimate web-only artifact** (VM↔web `SceneBuilder` skew) |
