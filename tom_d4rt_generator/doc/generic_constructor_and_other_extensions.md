# Generic Constructor and Other Runtime Extensions

## Overview

The file `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart` (456 lines) and `tom_d4rt_flutterm/lib/src/generic_type_relaxers.dart` (231 lines) contain hand-written runtime extensions that complement the auto-generated bridge code. These cover five distinct categories of functionality:

1. **RC-1: Interface Proxy Registrations** — Native proxy objects for interpreted classes
2. **RC-2: Generic Constructor Factories** — Type-aware constructor dispatch
3. **RC-3: Type Coercions** — Cross-package type conversions
4. **RC-5: Supplementary Methods** — Access to @protected members
5. **GEN-079: Type Relaxers** — Generic type wrapper classes (separate file)

This document analyzes each category: what it does, whether it can be auto-generated, and whether it *should* be auto-generated.

---

## Category 1: RC-1 Interface Proxy Registrations

### What It Covers

Four `D4.registerInterfaceProxy()` calls and three supporting proxy classes:

| Registration | Proxy Class | Members Delegated |
|-------------|-------------|-------------------|
| `TickerProvider` | `_InterpretedTickerProvider` | `createTicker(onTick)` |
| `CustomClipper` | `_InterpretedCustomClipper` | `getClip(size)`, `shouldReclip(oldClipper)` |
| `StatelessWidget` | `_InterpretedStatelessWidget` | `build(context)` |
| `StatefulWidget` | `_InterpretedStatefulWidget` + `_InterpretedState` | `createState()`, lifecycle methods (`initState`, `didChangeDependencies`, `build`, `didUpdateWidget`, `deactivate`, `dispose`) |

**Purpose:** When a D4rt script class extends/implements a bridged abstract class (e.g., `class MyWidget extends StatelessWidget`), the interpreter produces an `InterpretedInstance`. But Flutter's framework expects a *real* `StatelessWidget` object that it can call `build()` on. These proxies wrap the `InterpretedInstance` in a native class that delegates method calls back to the interpreter.

### Can It Be Auto-Generated?

**Partially.** The proxy generator (`GEN-083`) in `proxy_generator.dart` already generates delegation classes for abstract classes listed in `buildkit.yaml` under `proxyClasses`. It could be extended to also emit `D4.registerInterfaceProxy()` calls.

However, special cases exist:
- **StatefulWidget/State lifecycle:** The `_InterpretedState` class has nuanced lifecycle delegation (super calls, error handling, `setState` bridging). The proxy generator would need specific logic for State lifecycle patterns.
- **Key extraction:** Both widget proxies extract `key` from the interpreted instance with try/catch. This is a Flutter-specific pattern not generalizable.
- **CustomClipper type parameter:** `_InterpretedCustomClipper` extends `CustomClipper<ui.Path>` — the type argument is hard-coded because D4rt scripts typically only use `CustomClipper<Path>`.

### Should It Be Auto-Generated?

**Yes, with caveats.** The proxy generator should handle the common cases (TickerProvider, CustomClipper). The widget proxies (StatelessWidget, StatefulWidget, State) are Flutter-specific and deeply tied to Flutter's widget lifecycle — they may be better left as hand-written "known patterns" that the proxy generator references but doesn't try to derive from first principles.

**Recommendation:** Add a `interfaceProxies` config to `buildkit.yaml` listing classes that need proxy registration. The generator generates the proxy class and registration call. For StatelessWidget/StatefulWidget, keep them as hand-written "blessed proxies" or as templates the generator embeds.

### Auto-Generation Approach

If auto-generated, the generator would:

1. For each class in `proxyClasses` config, generate a proxy class that extends the base class
2. Introspect abstract methods from `ClassInfo.members`
3. Generate delegation code: call `_instance.klass.findInstanceMethod(name)` → `method.bind(_instance).call(visitor, args, namedArgs)`
4. Emit `D4.registerInterfaceProxy('ClassName', (visitor, instance) => _ProxyClassName(visitor, instance))` in the registration function

---

## Category 2: RC-2 Generic Constructor Factories

### What It Covers

Four `D4.registerGenericConstructor()` calls:

| Class | Constructor | Type Args Dispatched | Fallback |
|-------|-------------|---------------------|----------|
| `GlobalKey<T>` | default | `NavigatorState`, `FormState`, `ScaffoldState` | `GlobalKey()` (untyped) |
| `ValueKey<T>` | default | `String`, `int` (with nullable handling) | `ValueKey(value)` (inferred) |
| `ValueNotifier<T>` | default | `dynamic`, `Object`, `String`, `int`, `double`, `bool` | `null` (fall through to regular bridge) |
| `StrutStyle` | default | (none — not generic) | Always returns `painting.StrutStyle(...)` |

Note: `StrutStyle` is **not actually a generic class** — it's using the `registerGenericConstructor` mechanism as a constructor override to redirect `dart:ui.StrutStyle` creation to `painting.StrutStyle` (which has getter support). This is an RC-3 concern piggybacking on the RC-2 API.

**Purpose:** When a D4rt script calls `GlobalKey<NavigatorState>()`, the interpreter evaluates the type arguments and passes them to the constructor. Without RC-2, the bridge constructor creates `GlobalKey()` (without type args) — which is `GlobalKey<State<StatefulWidget>>` by default, not `GlobalKey<NavigatorState>`. The RC-2 factory intercepts the constructor call and dispatches based on the script's type arguments to create the correctly-typed instance.

### Runtime Flow

```
Script: var key = GlobalKey<NavigatorState>();
  ↓
Interpreter: evaluateTypeArguments → [RuntimeType('NavigatorState')]
  ↓
Interpreter: D4.findGenericConstructor('GlobalKey', '') → factory found
  ↓
Factory: typeArgs.first.name == 'NavigatorState'
  → return GlobalKey<NavigatorState>()
  ↓
Interpreter: wraps in BridgedInstance, returns to script
```

### Can It Be Auto-Generated?

**Yes.** The generator already knows:
- Which classes have type parameters (from `ClassInfo.typeParameters`)
- Which constructors exist (from `ClassInfo.constructors`)
- Which concrete types are used as type arguments across all modules (from the global class lookup and extraction site analysis)
- The GEN-075 constructor switch pattern already does runtime value-based type dispatch — RC-2 would do script-declared type argument dispatch

The auto-generation pattern for each generic class with constructors:

```dart
// Auto-generated for GlobalKey<T extends State>
D4.registerGenericConstructor('GlobalKey', '', (visitor, positional, named, typeArgs) {
  final typeName = typeArgs?.isNotEmpty == true ? typeArgs!.first.name : null;
  if (typeName == null) return null; // No type args → fall through to regular ctor
  
  final debugLabel = D4.extractBridgedArgOrNull<String>(named['debugLabel'], 'debugLabel');
  
  return switch (typeName) {
    'NavigatorState' => GlobalKey<NavigatorState>(debugLabel: debugLabel),
    'FormState' => GlobalKey<FormState>(debugLabel: debugLabel),
    'ScaffoldState' => GlobalKey<ScaffoldState>(debugLabel: debugLabel),
    // ... all State subtypes found across all bridged modules ...
    _ => GlobalKey(debugLabel: debugLabel), // fallback: untyped
  };
});
```

The generator would:
1. Identify all generic classes that have constructors
2. For each, collect all concrete types that satisfy the type bounds from the global class lookup
3. Generate a `registerGenericConstructor` call with a switch on `typeArgs.first.name`
4. Each case creates the constructor with the proper type argument

### Should It Be Auto-Generated?

**Yes, absolutely.** This is the highest-value auto-generation target in this file:

- **Scale:** Every bridged generic class with a constructor needs this. Currently only 4 are covered, but there are ~28 generic base types in the Flutter bridges alone.
- **Correctness:** The switch cases must cover all types that satisfy the type bound. Missing a case means scripts can't create that type combination. The generator already has the full type graph.
- **Maintenance:** Each new bridged type that satisfies a type bound needs a new case in every generic constructor that could use it. This is O(n×m) manual work.
- **Consistency:** The pattern is completely mechanical — no domain knowledge required beyond "which types satisfy this bound?"

### Auto-Generation Approach

The generator would add a new phase after bridge generation:

1. **Collect generic constructor targets:** Classes with `typeParameters.isNotEmpty && constructors.isNotEmpty`
2. **For each target class:**
   a. Get the type bounds (e.g., `T extends State` → only `State` subtypes)
   b. From the global class lookup, find all concrete classes satisfying the bound
   c. Generate a `registerGenericConstructor` call with type dispatch
3. **Constructor parameter forwarding:** The generator already knows constructor parameters from `ClassInfo.constructors`. Generate the `D4.extractBridgedArg*` calls for named/positional params.
4. **Multi-type-parameter classes:** For classes like `Pair<K, V>`, generate nested switches or compound key matching.
5. **Emit in the relaxer output file** (or a new `generic_constructors.b.dart` file) alongside the wrapper classes and factory functions.

### Special Case: StrutStyle Constructor Override

`StrutStyle` is NOT generic — it uses `registerGenericConstructor` as a constructor override mechanism. This should be split into a separate `registerConstructorOverride` API, or the generator should handle it via a different mechanism (e.g., `UserBridge` constructor overrides). It should not be conflated with generic constructor dispatch.

---

## Category 3: RC-3 Type Coercions

### What It Covers

Two `D4.registerTypeCoercion()` calls:

| Source Type | Target Type | Conversion Method |
|------------|-------------|-------------------|
| `painting.TextStyle` | `dart:ui.TextStyle` | `paintingTextStyle.getTextStyle()` |
| `painting.StrutStyle` | `dart:ui.StrutStyle` | Field-by-field constructor call |

**Purpose:** Flutter has two parallel type hierarchies (`dart:ui` and `painting`) where `painting.TextStyle` wraps `dart:ui.TextStyle` with additional features. When a D4rt script creates a `TextStyle` (which resolves to `painting.TextStyle`), then passes it to a `dart:ui` API expecting `dart:ui.TextStyle`, the types don't match. The coercion transparently converts.

### Can It Be Auto-Generated?

**Partially.** The generator could detect "same-named classes in different packages" and generate coercion registrations. However:

- The conversion method is package-specific (`.getTextStyle()` is a Flutter API convention, not a universal pattern)
- The `StrutStyle` coercion is a field-by-field construction — the generator would need to know which fields to copy
- These coercions are specific to Flutter's split SDK architecture; a generic Dart package usually doesn't have this problem

### Should It Be Auto-Generated?

**No — keep hand-written.** Type coercions are rare (only 2 in the entire Flutter bridge), highly package-specific, and require knowledge of conversion APIs that the generator can't discover from type signatures alone. The cost of hand-writing 2 coercions is negligible compared to the complexity of building a coercion discovery system.

**Recommendation:** Keep as hand-written code. If more coercions are needed in the future, consider a `typeCoercions` config in `buildkit.yaml` with explicit source→target→method specifications.

---

## Category 4: RC-5 Supplementary Methods

### What It Covers

Two `D4.registerSupplementaryMethod()` calls:

| Class | Method | Why Needed |
|-------|--------|-----------|
| `ChangeNotifier` | `notifyListeners` | @protected — bridge generator skips it |
| `ChangeNotifier` | `hasListeners` | @protected — bridge generator skips it |

**Purpose:** The bridge generator deliberately excludes `@protected` members from the generated bridge API (they're not part of the public API). But interpreted subclasses of `ChangeNotifier` need to call `notifyListeners()` — it's the core mechanism for reactive state updates. Supplementary methods register these manually.

### Can It Be Auto-Generated?

**Yes.** The generator already knows which methods are `@protected` from the analyzer metadata. It could:

1. Identify bridged classes that are commonly subclassed (those with interface proxies, or classes listed in `proxyClasses`)
2. For each, find `@protected` members that subclasses would need
3. Generate `D4.registerSupplementaryMethod()` calls

### Should It Be Auto-Generated?

**Partially.** Auto-generating all `@protected` methods would be over-broad — most `@protected` methods are internal implementation details not needed by script subclasses. But a targeted approach would work:

**Recommendation:** Add a `supplementaryMethods` config in `buildkit.yaml`:

```yaml
supplementaryMethods:
  ChangeNotifier:
    - notifyListeners
    - hasListeners
  State:
    - setState
```

The generator then produces `registerSupplementaryMethod` calls for the listed methods. This keeps the declaration explicit (the developer knows which protected methods scripts need) while removing the hand-written delegation code.

---

## Category 5: GEN-079 Type Relaxers (Separate File)

### What It Covers

File: `generic_type_relaxers.dart` — 3 wrapper classes and 3 factory functions:

| Wrapper Class | Base Type | Strategy | Type Args Covered |
|--------------|-----------|----------|-------------------|
| `_RelaxedWSP<V>` | `WidgetStateProperty<V>` | Implements (delegates `resolve()`) | ~12 types |
| `_RelaxedAnimation<V>` | `Animation<V>` | Extends (delegates `value`, `status`, listeners) | 7 types |
| `_RelaxedValueNotifier<V>` | `ValueNotifier<V>` | Extends (bidirectional sync) | 10 types |

### Can It Be Auto-Generated?

**Already is.** The relaxer generator (`relaxer_generator.dart`) already auto-generates equivalent `$Relaxed*` classes and per-module factory functions in `flutter_relaxers.b.dart`. The generated output covers **124** `registerGenericTypeWrapper` calls across all bridged generic types, not just the 3 hand-written ones.

### Should It Be Auto-Generated?

**Yes — and it already is.** The hand-written file exists only because it predates the generator. It must be deleted once the generated relaxers are verified to cover all the same type argument cases.

**Status:** The generated `flutter_relaxers.b.dart` is already in production. The hand-written `generic_type_relaxers.dart` should be removed as part of Phase 3 cleanup.

---

## Summary: Auto-Generation Recommendations

| Category | Hand-Written Items | Auto-Generate? | Priority | Complexity |
|----------|-------------------|----------------|----------|------------|
| **RC-1: Interface Proxies** | 4 registrations + 3 proxy classes | Partially (common cases yes, widget lifecycle no) | Medium | High |
| **RC-2: Generic Constructors** | 4 registrations (3 truly generic + 1 override) | **Yes** | **High** | Medium |
| **RC-3: Type Coercions** | 2 registrations | No — keep hand-written | Low | N/A |
| **RC-5: Supplementary Methods** | 2 registrations | Config-driven (not fully auto) | Low | Low |
| **GEN-079: Type Relaxers** | 3 wrappers + factories | **Already auto-generated** — delete hand-written | **High** | Done |

### Implementation Priority

1. **Delete hand-written relaxers** (`generic_type_relaxers.dart`) — the auto-generated equivalent already exists
2. **Implement RC-2 generic constructor generation** — highest impact, covers all ~28 generic base types
3. **Extend proxy generator for RC-1** — emit `registerInterfaceProxy` calls for `proxyClasses` entries
4. **Add `supplementaryMethods` config** — low effort, removes 2 hand-written methods
5. **Keep RC-3 type coercions hand-written** — too rare and package-specific to justify automation

### Relationship to Other Documents

- **Relaxer strategy:** See [generics_wrapper_and_type_relaxation_strategy.md](generics_wrapper_and_type_relaxation_strategy.md) for the full relaxer auto-generation design (GEN-079, wrapper classes, per-module factories, additive registration)
- **Proxy generation:** See [proxy_class_generation.md](proxy_class_generation.md) for abstract class proxy delegation (GEN-083)
- **UserBridge overrides:** See [userbridge_override_design.md](userbridge_override_design.md) for per-member bridge customization
