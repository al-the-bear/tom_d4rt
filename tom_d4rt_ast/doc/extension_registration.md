# Extension registration: `registerExtensions` / `finalizeBridges`

Bridge packages frequently have a "must run AFTER bridges X" ordering
rule on some of their wiring. `D4rtRunner` (and `D4rt` in
`tom_d4rt_exec`, which mirrors the surface) provides a small extension
hook that turns that rule from a comment into an enforced contract.

## API

```dart
class D4rtRunner {
  /// Whether [finalizeBridges] has run on this runner.
  bool get bridgesFinalized;

  /// Register an extension callback that fires at finalize time.
  ///
  /// Throws [StateError] if called after [finalizeBridges].
  /// Re-registering with the same [packageName] overwrites the body —
  /// one extension per package.
  void registerExtensions(String packageName, void Function() body);

  /// Run every registered extension callback exactly once, in
  /// registration order. Idempotent — subsequent calls are no-ops.
  ///
  /// Called implicitly at the top of `executeBundle*`, so embedders
  /// that skip the explicit call still get the callbacks fired before
  /// the script body runs.
  void finalizeBridges();
}
```

`D4rt` (tom_d4rt_exec) forwards every method to the inner runner, so
embedders that use the analyzer-based entry point see the same
contract.

## Typed-execute API

`finalizeBridges` exists so the typed-execute surface can fire it for
you. `executeBundleAs<T>` / `executeBundleAsAsync<T>` are the
**bundle-based** typed entry points on `D4rtRunner` (and `D4` in
`tom_d4rt_exec`, which delegates to the inner runner). They run a
pre-compiled `AstBundle`'s entry function and route the raw result
through `D4.unwrapAs<T>`, so the caller gets a plain native `T` —
never a `BridgedInstance`, `BridgedEnumValue`, or `InterpretedInstance`
wrapper.

```dart
class D4rtRunner {
  /// Execute [bundle]'s entry function and unwrap the result to [T]
  /// via D4.unwrapAs. Throws [D4UnwrapException] if the result cannot
  /// be coerced to T.
  T executeBundleAs<T>(
    AstBundle bundle, {
    String? entryPoint,            // bundle entry module (default: bundle's own)
    String name = 'main',          // function to call within that module
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  });

  /// Async variant — awaits the result if it is a Future before
  /// unwrapping. Use this for `async` entry points (or when calling
  /// outside a synchronous render path). A synchronous bundle still
  /// works: the awaited value is just the raw return.
  Future<T> executeBundleAsAsync<T>(AstBundle bundle, { … });
}
```

Both methods exist **only on the AST line** (`tom_d4rt_ast` runner and
`tom_d4rt_exec`'s `D4rt`). Base `tom_d4rt` has **no** bundle typed-execute
and correctly should not — bundles are an analyzer-free, `SAstNode`
concept; the analyzer-based base executes Dart source directly. What
base `tom_d4rt` *does* share is the `registerExtensions` /
`finalizeBridges` half of this contract (documented above and in the
`tom_d4rt` user guide's "Extension Registration and Facades" section).

### How finalize ties in

`finalizeBridges` runs implicitly at the top of every `executeBundle*`
call (§API), so the two methods need no explicit setup ceremony — the
queued extension callbacks fire once, in registration order, before
the script body runs. The unwrap step is the only difference between
the raw `executeBundle` and the typed `executeBundleAs<T>`:

| Call | Returns | Notes |
|------|---------|-------|
| `executeBundle(bundle, …)` | `Object?` (raw) | caller deals with the wrapper |
| `executeBundleAs<T>(bundle, …)` | `T` | `D4.unwrapAs<T>(raw, visitor: …)` |
| `executeBundleAsAsync<T>(bundle, …)` | `Future<T>` | awaits a `Future` raw, then unwraps |

`D4.unwrapAs<T>` coercion rules (see `D4` in
`lib/src/runtime/generator/d4.dart`): `null` → `T` if `null is T`;
`BridgedInstance` → its `nativeObject`; `BridgedEnumValue` → its
`nativeValue`; a value that already `is T` → as-is; `InterpretedInstance`
→ its `bridgedSuperObject`, else an interface proxy built via the
visitor; otherwise it throws `D4UnwrapException`. Passing the runner's
visitor is what lets an `InterpretedInstance` be wrapped in a registered
interface proxy.

### Canonical consumer

`FlutterD4rt` (in `tom_d4rt_flutter_ast`) is the reference consumer: its
`build<T>` / `buildAsync<T>` / `execute<T>` / `executeAsync<T>` all route
through `executeBundleAs<T>` / `executeBundleAsAsync<T>`, then re-throw
any `D4UnwrapException` as `FlutterD4rtException` to keep its public
exception contract. See
`tom_d4rt_flutter_ast/doc/tom_d4rt_flutter_ast_user_guide.md` §2.

## User-registration facade (P&R#3)

The runner also exposes three thin delegates onto the static `D4`
registries so an embedder or bridge package can register its **own**
relaxers, interface proxies, and generic constructors without touching
the generator. They are mirrored on both facades (`D4rtRunner` in
`tom_d4rt_ast`, `D4rt` in `tom_d4rt`):

```dart
class D4rtRunner {
  /// Relaxer (generic-type-wrapper) factory for a base type name.
  /// Delegates to D4.registerGenericTypeWrapper (idempotent, chains new-first).
  void registerRelaxerFactory(
    String baseTypeName, GenericTypeWrapperFactory factory);

  /// Interface-proxy factory for a bridged abstract type.
  /// Delegates to D4.registerInterfaceProxy (idempotent).
  void registerInterfaceProxy(
    String bridgedTypeName, InterfaceProxyFactory factory);

  /// Generic-constructor factory for `ClassName.constructorName`
  /// (use '' for the unnamed constructor).
  /// Delegates to D4.registerGenericConstructor (idempotent, chains new-first).
  void registerGenericConstructor(
    String className, String constructorName, GenericConstructorFactory factory);
}
```

**Intended use — inside a `registerExtensions` body.** Queue the
registrations so they run once at finalize time, in package order,
after the standard bridges are wired up:

```dart
runner.registerExtensions('my_pkg', () {
  // A relaxer for a non-generic user type — resolved by the pre-throw
  // lookup in D4.extractBridgedArg (see below).
  runner.registerRelaxerFactory('MyWidget', (value, innerType) =>
      value is MyWidgetSpec ? value.build() : null);

  runner.registerInterfaceProxy('MyListener', (visitor, instance) =>
      _MyListenerProxy(visitor, instance));

  runner.registerGenericConstructor('MyBox', '', (visitor, pos, named, types) =>
      types?.length == 1 ? MyBox<dynamic>() : null);
});
```

They may also be called directly before the first
`execute*`/`executeBundle*` call.

### Pre-throw lookup for non-generic relaxers

`D4.extractBridgedArg<T>`'s inlined relaxer path only consults the
generic-type-wrapper registry when `T` is itself parameterized (its
string form contains `<…>`). A relaxer registered for a **non-generic**
user type — the common case here — would otherwise never be reached.
P&R#3 adds a strictly-additive last-resort lookup that runs immediately
before `extractBridgedArg` throws: it resolves the base type name
against the relaxer registry (passing an empty inner type argument) and
returns the first factory result that satisfies `T`. Because it only
runs on the about-to-throw path, it can turn a previous failure into a
success but can never change the result of an argument that already
resolved. An unrelated, unregistered miss still throws the enriched
P&R#2 diagnostic.

Contracts pinned by
`tom_d4rt_ast/test/runtime/facade_user_registration_test.dart` (and its
analyzer-based twin under `tom_d4rt/test/bridge/`):

- Each facade method writes through to its `D4` sink (observable via
  `D4.hasInterfaceProxy` / `D4.findGenericConstructor` / a resolving
  `D4.extractBridgedArg`).
- `registerGenericConstructor` engages the new-first chaining sink for a
  distinct second factory and is idempotent on factory identity.
- A registered non-generic relaxer resolves through `extractBridgedArg`;
  an unrelated unregistered miss still throws the enriched message.

## Contracts pinned by tests

The four invariants in `tom_d4rt_ast/test/runtime/extension_hook_test.dart`:

1. Callbacks fire in registration order on the first
   `finalizeBridges()` call.
2. Subsequent `finalizeBridges()` calls and subsequent
   `executeBundle` calls do **not** re-run callbacks.
3. `registerExtensions` after `finalizeBridges` throws `StateError`.
4. Re-registering with the same package name overwrites the body —
   one extension per package.

## Canonical example: `FlutterD4rt`

`tom_d4rt_flutter_ast/lib/src/flutter_d4rt.dart` uses the hook for the
post-material proxy-override wiring:

```dart
void _registerBridges() {
  // Pre-material work goes inline.
  registerRelaxers();
  registerD4rtRuntimeExtensions();
  FlutterMaterialBridges.register(_interpreter);
  // Post-material work goes in the extension callback.
  _interpreter.registerExtensions(
    'tom_d4rt_flutter_ast',
    registerD4rtInterfaceProxyOverrides,
  );
  _interpreter.finalizeBridges();
}
```

Two patterns to notice:

- **Not every "user-bridge" call belongs in the callback.** Only the
  work that genuinely depends on a prior `register*` call (here,
  material's proxy registrations) is queued. Wiring that needs to run
  *before* material — for example, generic-constructor factories that
  must sit underneath material's auto-gen factories on the
  newest-first chain — stays inline above the material call.
- **Pass the function reference, not a closure.** When the callback is
  a single function with no extra setup, write
  `registerExtensions('pkg', myRegister)` rather than
  `() => myRegister()`. The package-name overwrite semantics still
  apply — registering the same package twice replaces the previous
  body.

## When to use the hook

- The bridge package depends on registrations a downstream package
  produces, but you want the package itself to own the "register
  this after my downstream finishes" rule rather than rely on the
  embedder to call things in the right order.
- A test or embedder constructs the runner once and may not call any
  explicit setup helper; the implicit finalize on first execute keeps
  scripts working without ceremony.

## When **not** to use it

- The work is unconditional and can run inline at runner construction —
  the hook only adds value when ordering matters.
- The callback would re-register the same factories on every runner
  instance and the registries are not idempotent. Make the registries
  idempotent (see `register_idempotency_test.dart`) instead of trying
  to guard the callback.
