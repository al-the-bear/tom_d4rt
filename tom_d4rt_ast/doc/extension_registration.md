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

`tom_d4rt_flutterm/lib/src/flutter_d4rt.dart` uses the hook for the
post-material proxy-override wiring:

```dart
void _registerBridges() {
  // Pre-material work goes inline.
  registerRelaxers();
  registerD4rtRuntimeExtensions();
  FlutterMaterialBridges.register(_interpreter);
  // Post-material work goes in the extension callback.
  _interpreter.registerExtensions(
    'tom_d4rt_flutterm',
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
