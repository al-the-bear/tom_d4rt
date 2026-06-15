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

## 5. Web-divergence map (where the twins legitimately differ)

The registration **API** is in lockstep. The divergence lives only in the
downstream manual registration files
(`tom_d4rt_flutter{,_ast}/lib/src/d4rt_runtime_registrations.dart`):

| Divergence | Status |
|------------|--------|
| `_InterpretedKeepAliveState` (`AutomaticKeepAliveClientMixin`) + its walk/dispatch — **non-AST only** | **accidental drift** — the web twin is missing keep-alive State support; tracked to converge under MCI item 3 (`mixinVariants:` State family) |
| `RouterDelegate<Object>` (non-AST) vs `RouterDelegate<dynamic>` (AST) | **suspected drift** — one is wrong; reconcile under MCI item 2 |
| narrow `src/runtime/...` imports (AST) vs single `package:tom_d4rt/d4rt.dart` barrel (non-AST) | **legitimate** — the AST barrel does not re-export the same internal symbols |
| `scene_builder_user_bridge.dart` — **AST only** | **legitimate web-only artifact** (VM↔web `SceneBuilder` skew) |
