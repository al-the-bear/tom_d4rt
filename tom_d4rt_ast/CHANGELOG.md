## 0.1.10

### Fixed — native→bridge resolution: precise match must beat fuzzy prefix across scopes

- `Environment.toBridgedClass` now walks the **entire** enclosing scope chain
  doing only **precise** matching (exact `Type`, `_FooImpl→Foo`
  canonicalization, generic-base name / `nativeNames`, suffix, name-exact,
  longest-`nativeNames`-prefix) before a **second** full-chain walk applies the
  G-DCLI-05 fuzzy `startsWith` fallback. Previously the fuzzy fallback ran
  *within each frame* before advancing, so under the lazy warm-parent split a
  `MappedListIterable` from `List.map(...).toList()` resolved to the nearer
  `Map` bridge (`"MappedListIterable".startsWith("Map")`) instead of the
  precise `Iterable` `nativeNames` match in the enclosing warm-parent frame,
  failing with *"Bridged class 'Map' has no instance method named 'toList'"*.
- Twin of `tom_d4rt` 1.10.1; the analyzer-free interpreter shares the fix.

## 0.1.9

### Added — import-optimization API (additive, backward compatible)

- `D4rtRunner.providePackage(String)` — process-global package pool gate:
  returns `false` the first time a package is seen (caller registers its
  bridges) and `true` once pooled (caller skips registration and reuses the
  pooled definitions). The granted set is the instance's security whitelist,
  exposed read-only via `allowedPackages`.
- `D4rtRunner.registerExtensions(String package, void Function() callback)` /
  `finalizeBridges()` — queued bridge-package extension hooks that fire
  **exactly once per package per process** (at pool population), replacing the
  old once-per-instance firing. `warmup()` finalizes and builds the warm
  parent for the instance's allowed-set.
- Warm-parent reuse: each `executeBundle*` runs in a fresh child `Environment`
  chained off a shared, immutable warm parent built at most once per
  allowed-set signature (migrated instances) or per instance (legacy) — script
  declarations never leak across executes or instances.
- `executeBundleAs<T>` / `executeBundleAsAsync<T>` route the result through
  `D4.unwrapAs<T>` so consumers get a native `T` rather than a
  `BridgedInstance`.
- Test/diagnostic introspection: `debugPooledPackages`,
  `debugPooledClassCount`, `debugWarmParentCacheSize`, `debugResetPool`.

See `doc/extension_registration.md` for the canonical registration pattern.

## 0.1.8

### Fixes
- Mirror the `tom_d4rt 1.8.24` same-name bridge fix (B2 "MarkdownParser clash"):
  the `Environment` stashes displaced same-name bridges and
  `InterpreterVisitor` falls back to a sibling bridge that declares the
  requested static/constructor member, so identically named `BridgedClass`es
  from different libraries resolve to the one that actually declares the member.

## 0.1.7

- Housekeeping: test artifacts now live in a gitignored `testlog/` folder; `doc/` no longer ships machine-generated baselines or last_testrun.json. No code changes.

## 0.1.6

- Mirror the `tom_d4rt 1.8.22` interpreter fixes: instance members shadow
  bridged top-level functions (FIX-20260613-1038-C); no exception-as-control-
  flow on implicit-`this` reads.
- Mirror the `tom_d4rt 1.8.22` performance work: per-instance bound-method
  tear-off cache, no-binding `Environment` frame collapse, no primitive-operand
  wrapping in binary expressions.
- Documentation: limitations consolidated; user guide and README updated to
  point at `tom_d4rt`'s canonical limitations reference.

## 0.1.5

- Consume `tom_ast_model ^0.1.1` for the `StaticResolver` slot-resolution
  members (`resolvedSlot` / `declSlot`); the AST-driven `InterpreterVisitor`
  now serves resolved reads from frame slots instead of name-map walks.
- Mirror the `tom_d4rt 1.8.21` interpreter fixes (redirecting factories,
  sibling static-field writes, native-side reset).

## 0.1.4

- First public release on pub.dev.
- Kept in sync with `tom_d4rt` interpreter fixes (generic type matching,
  enum handling, `isSubtypeOf` superclass-chain walk, stdlib native names).
- AST-driven `InterpreterVisitor` executes the analyzer-free mirror AST
  (`SAstNode`) with full bridging, permissions, and callable support.

## 0.1.1

- Support extensible dart: library bridges - unknown dart: URIs now check for bridged content before throwing an error
- Allows external packages (like tom_d4rt_flutterm) to register bridges for dart:ui and other dart: libraries

## 1.0.0

- Initial version.