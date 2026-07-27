## 0.2.0

### Security — scoped `FilesystemPermission` grants are now actually enforced (DFUB11)

**This is a behavioural tightening. Scripts that relied on the previous, laxer
matching will now be denied — hence the minor bump rather than a patch.**

Two independent sandbox holes are closed (ported from upstream
kodjodevf/d4rt 861117a).

**1. No per-operation enforcement.** The `dart:io` bridges in
`stdlib/io/{file,directory,file_system_entity}.dart` carried *zero* permission
checks. The only gate was at `dart:io` IMPORT time, and it merely required that
*some* `FilesystemPermission` had been granted. A grant scoped to one directory
was therefore indistinguishable from `FilesystemPermission.any` once the import
succeeded — every bridged file and directory operation ran unchecked.

Every read/write entry point now calls
`checkFilesystemRead/WritePermission` **before** the native operation, so a
denial cannot leave a side effect behind. Operations are classified by what
they actually do: `rename` requires write on *both* the old and the new path,
`copy` requires read on the source *and* write on the target, and
`File.open`/`openSync` follow the requested `FileMode` (only `FileMode.read`
counts as a read). `FileStat.stat`/`statSync` are gated too — they take a raw
path and would otherwise sidestep every `File`/`Directory` gate.

**2. Naive scope matching.** `FilesystemPermission.allows` compared with a raw
`opPath.startsWith(_path)`. Two consequences: `..` traversal escaped the scope
(`/allowed/../etc/passwd` was "inside" `/allowed`), and a sibling directory
whose name merely shares the string prefix (`/allowed_sneaky` against a grant
on `/allowed`) was treated as inside it.

Matching is now canonical and on a path-*segment* boundary: both sides are
absolutized, normalized to `/` separators, lowercased on a Windows drive
letter, and reduced by resolving `.` and `..` away; the request must then
either equal the scope or start with `scope + '/'`. Symlinks are deliberately
**not** resolved — `realpath` would make the matcher depend on current
filesystem state and fail outright for paths that do not exist yet, such as the
target of a write.

**Pathless operations.** Some checks have no meaningful path — the `dart:io`
import gate asks only "is *any* filesystem access granted?". Those now pass
`'pathAgnostic': true`, which waives the PATH check **only**, never the
read/write/execute flags. Conversely, a scoped grant asked about an operation
with no path and no `pathAgnostic` flag now **denies**, rather than assuming the
operation is in scope. Unscoped grants (`FilesystemPermission.any`, `.read`,
`.write`) are unaffected and remain allow-all.

**Web safety.** Upstream imports `dart:io` into `permissions.dart` to
absolutize a path. This package must compile for web — it puts all of `dart:io`
behind a `dart.library.html` conditional — so the process working directory is
reached through a new `security/current_directory_{io,web}.dart` conditional
import instead.

## 0.1.16

### Fixed — circular module imports and exports blew the stack (DFUB10)

`AstModuleLoader.loadModule` only published a module to `_moduleCache` at the
very END — after recursing through every import and export directive. A cycle
`A -> B -> A` therefore re-entered the load of `A` while `A` was still in
progress, the cache guard missed, and the recursion never bottomed out.
Circular imports and circular exports are both **legal** Dart and run
correctly, so this rejected valid programs.

The loader now publishes a *partial* `LoadedModule` under an in-flight map
before walking any directive, and a cyclic re-entry receives that partial
instead of recursing. The partial carries the very `Environment` instance that
later receives the module's own declarations, so importers hold a live
reference.

Because `Environment.importEnvironment` **copies** bindings at call time rather
than aliasing the source environment, a merge taken from a still-incomplete
module would otherwise capture an empty export set and never self-heal. Each
such merge is therefore recorded and **replayed** once the in-flight module
finishes. Replays are idempotent — `importEnvironment` skips names already
bound to the identical value — so they cost nothing and cannot raise a spurious
conflict. A failed load drops its in-flight registration, so an abandoned
partial is never handed out on a later execute.

DELIBERATE DIVERGENCE FROM UPSTREAM: upstream `kodjodevf/d4rt` `f6e1257` fixes
the same crash by *detecting* the cycle and throwing "Circular module
dependency detected". That rejects valid Dart, so it is not adopted here.

## 0.1.15

Carries the analyzer-free mirror of the `tom_d4rt` fork-update fix DFUB9, so
`tom_d4rt_exec` (which consumes the hosted `tom_d4rt_ast`) can exercise it
end-to-end.

### Added — operator and `call()` dispatch on extension-type instances (DFUB9)

Operator methods declared on an `extension type` were already stored on
`InterpretedExtensionType.methods`, keyed by the operator lexeme, but no
dispatch site recognised an `InterpretedExtensionTypeInstance` receiver. Binary
operators reported `Unsupported operator (PLUS) for types
InterpretedExtensionTypeInstance…`, unary `-` reported `Operand for unary '-'
must be a number…`, and invoking an instance silently returned the instance
itself instead of running its `call` method.

Seven dispatch sites now resolve the operator on the extension type, bind
`this`, and invoke it:

- `visitBinaryExpression` — `+`, `*`, `>`, `==` and friends. The lookup runs
  *before* the native comparison/arithmetic switch, because a comparison such
  as `>` would otherwise reach `left as dynamic > right` and throw a
  `NoSuchMethodError` on the instance.
- compound assignment (`+=`, `*=`, …) — dispatches with the *wrapped* instance
  as the receiver, not the unwrapped representation value.
- `visitPrefixExpression` — unary `-` and `~`, bound with an empty argument
  list. A zero-arg `operator -()` and a one-arg binary `operator -` share the
  `-` key, so only the prefix site may bind it with no arguments.
- index get `[]` and index set `[]=`.
- both invocation paths — `visitMethodInvocation` (`calc(5)`) and function
  expression invocation (`(calc)(5)`) — route to the `call` method, forwarding
  positional, named, and type arguments.

## 0.1.14

Upstream-realignment release: carries the analyzer-free mirrors of the
`tom_d4rt` fork-update fixes DFUB2 and DFUB4–DFUB8 into the published package,
so `tom_d4rt_exec` (which consumes the hosted `tom_d4rt_ast`) can exercise them
end-to-end.

### Added — instance-method and setter dispatch on extension-type instances (DFUB4)

- `InterpretedExtensionType` gained a `setters` map; assigning to a member of an
  extension-type instance now binds and invokes the matching setter instead of
  failing, and `InterpretedExtensionTypeInstance` resolves instance **methods**
  (not just getters) through `get(name, visitor)` at the method-invocation,
  implicit-`this` identifier, and property-access sites.
- Ports upstream `kodjodevf/d4rt` `2f519cd` (Extension Type Support 0.2.2).

### Added — runtime type checks for function types and record types (DFUB5)

- New structural runtime types in `runtime_interfaces.dart`:
  `FunctionRuntimeType` (covariant return, contravariant parameters, arity and
  named-parameter shape) and `RecordRuntimeType` (arity, named keys, per-field
  compatibility), plus the shared `NamedRuntimeType` contract.
- `is` / `as` against a function type or record type annotation no longer throws
  "not implemented", and function/record **return-type validation** is now
  actually enforced. `InterpretedFunction` exposes a cached
  `callableRuntimeType`.
- Known limitation: because record type annotations arrive as opaque nodes in
  the S-AST model, the analyzer-free record resolver is arity-only.
- Ports upstream `848f03d`.

### Added — applied generic type arguments preserved at runtime (DFUB6)

- New `AppliedRuntimeType` (base type + applied arguments, element-wise
  subtyping with `dynamic` / `Object` / `void` wildcards) so `is Box<int>`
  honours the type argument.
- Generic and typed native-collection returns are validated element-wise. The
  applied return type is captured at declaration time onto
  `InterpretedFunction.declaredReturnTypeApplied` and checked in
  `visitReturnStatement`. Async and generator functions are exempt, since their
  `Future<T>` / `Stream<T>` / `Iterable<T>` return type wraps the inner value.
- Ports the applied-runtime-types half of upstream `1042fff`.

### Fixed — `BridgedClass` / `TypeParameter` subtype checks were too permissive (DFUB7)

- `BridgedClass.isSubtypeOf`: the `num` early block returned true for
  `num <: int` and `num <: double`, making `num` a subtype of its own subtypes.
  Only `num <: num` is kept; the downward `int` / `double <: num` direction is
  unaffected.
- `TypeParameter.isSubtypeOf`: replaces the unconditional `return true` with
  real rules — another `TypeParameter` is a subtype; a bounded `T extends X`
  defers to its bound (so `T extends num` is **not** a subtype of `String`); an
  unbounded `T` is a subtype only of the top types (`Object` / `dynamic` /
  `void`).
- Ports the subtype half of upstream `28ca517`.

### Fixed — omitted optional super parameters clobbered the parent's default (DFUB8)

- An optional super parameter (`[super.x]` / `{super.x}`) that the caller omits
  and that carries no default in the child constructor is no longer forwarded to
  the parent as an explicit `null`. Skipping the forward lets the parent apply
  its own declared default, e.g. `Parent(this.name, [this.value = 0])`. Required
  super parameters are unaffected.
- Ports the two failing super-parameter cases from upstream `class_test`.

### Fixed — absolute non-`dart:` / non-`package:` import URIs (DFUB2)

- `visitImportDirective` self-resolves any already-absolute URI
  (`importUri.hasScheme`) rather than only `dart:` and `package:`, so an
  absolute `file:` import reaches the module loader without a base — matching
  upstream `resolveModuleUri`.

## 0.1.13

### Fixed — `toString()` on a bridged enum TYPE (via `runtimeType`) (RCJ12)

- Keeps the analyzer-free runtime in sync with `tom_d4rt` 1.12.1. Calling
  `.toString()` on a bridged enum **type** — typically reached through
  `enumValue.runtimeType` — no longer throws
  `"Undefined static method 'toString' on bridged enum '<Enum>'"`; the
  `BridgedEnum` method-invocation branch now returns the enum type name for a
  no-arg `toString`, matching Dart's `Type.toString()`. This is the fix
  exercised by the `flutter_extended_23` retest
  (`dropdown_menu_close_behavior`), whose metadata card renders
  `v.runtimeType.toString()`.

## 0.1.12

### Fixed — enum bridging for `Map<String, Enum>` args and native-stored round-trips (RCC7)

- Keeps the analyzer-free runtime in sync with `tom_d4rt` 1.12.0. A script `Map`
  whose **values** are bridged enums now coerces to a native `Map<String, Enum>`
  (`D4._coerceMapValue` unwraps `BridgedEnumValue.nativeValue`, mirroring
  `_coerceMapKey`), and `wrapNativeReturnValue` re-wraps a native `Enum` as its
  `BridgedEnumValue` so a native-stored enum round-trips and compares equal with
  `==`.

## 0.1.11

### Added — static method dispatch on bridged enums (GitHub issue #2)

- `BridgedEnumDefinition` and `BridgedEnum` gained a `staticMethods` map
  (`Map<String, BridgedStaticMethodAdapter>`), wired through
  `buildBridgedEnum()`, plus `BridgedEnum.findStaticMethodAdapter(name)`.
- The analyzer-free `InterpreterVisitor` now dispatches a static method call
  where the target is a bridged enum **type** (e.g.
  `PageFormat.fromString('A4')`). Previously only instance methods on enum
  *values* were reachable.
- Backward compatible: `staticMethods` defaults to an empty map. Twin of
  `tom_d4rt` 1.11.0; the analyzer-free interpreter shares the fix.

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