## 1.18.0

### Added — the P2 `dart:async` types (SC6)

`StreamView`, `AsyncError` and `StreamTransformerBase` are now bridged and
mirrored into `tom_d4rt_ast`. Each needed a different registration shape, and
the differences are load-bearing:

- **`StreamView`** is `class StreamView<T> extends Stream<T>` — a wrapper whose
  entire value is the ~60-member `Stream` surface it inherits. Bridge dispatch
  is per-bridge rather than hierarchical, so a `StreamView` bridge declaring
  only its constructor would have left every inherited member unreachable.
  Instead of duplicating that surface, `'StreamView'` is listed on the `Stream`
  bridge's `nativeNames` (so instances dispatch there) and the
  `StreamView -> Stream` edge goes in the supertype registry. The bridge
  deliberately declares **no** `isAssignable`, which would have contested
  `Stream`'s ownership of every stream-shaped object.
- **`AsyncError`** is concrete, so it can carry an `isAssignable` without
  shadowing a more specific bridge — the one `dart:async` bridge that does. It
  accepts the SDK-idiomatic one-argument form, and `implements Error` is
  registered so `on Error catch` sees it.
- **`StreamTransformerBase`** exists purely to be extended, so it gets a
  null-returning default constructor (only so `super()` resolves) and the
  `StreamTransformerBase -> StreamTransformer` edge.

`Stream.transform` was broadened to accept a script transformer. An interpreted
transformer has no native object at all — its `bind` lives only in the
interpreter — so the adapter wraps it in `StreamTransformer.fromBind`. Both
`extends StreamTransformerBase` and `implements StreamTransformer` reach it.

### Fixed — three generic interpreter gaps surfaced by the above

None of these are `dart:async`-specific; all three affect every bridge.

- **`is BridgedX` was hard-false for any interpreted operand.**
  `visitIsExpression` short-circuited every `InterpretedInstance` to `false` and
  never consulted `InterpretedClass.isSubtypeOf`, which exists precisely to
  answer that question (RC-7). A script class failed the `is` test against its
  own declared bridged superclass — `class Doubler extends StreamTransformerBase`
  made `Doubler() is StreamTransformerBase` false.
- **`implements SomeBridge` was not a subtype edge.**
  `InterpretedClass.isSubtypeOf` walked `bridgedSuperclass` and `bridgedMixins`
  but skipped `bridgedInterfaces` entirely.
- **Method invocation never walked the bridged supertype chain.** The Cluster-12
  `lookupOnBridgedSupertypes` walk was wired into the three property-access
  paths but not into invocation, so `v.map(...)` on a bridge inheriting `map`
  from a registered supertype failed with "has no instance method named" even
  though the `v.map` tear-off resolved.

## 1.17.0

### Added — the catchable `dart:core` error types (SC5)

Seven SDK error classes had no `BridgedClass`, so their names did not resolve
at all: `on NoSuchMethodError catch (e)` fell through to the bare clause, and
`AssertionError('boom')` failed with `Undefined variable: AssertionError`.
All seven are now bridged and mirrored into `tom_d4rt_ast`:

`NoSuchMethodError`, `ConcurrentModificationError`, `IndexError`, `TypeError`,
`AssertionError`, `StackOverflowError`, `OutOfMemoryError`.

`TypeError` and `AssertionError` also claim the private VM subclasses
(`_TypeError`, `_AssertionError`) through `nativeNames` — those are what a
failing cast and a failing `assert` actually raise, so without the alias the
value would reach no bridge and `on TypeError` could never see it.

The `dart:core` error inheritance chain is declared through
`BridgedClass.registerSupertypes` (`ErrorHierarchyCore`), not by widening any
`isAssignable` closure. `isAssignable` decides which bridge *owns* a native
object and every hand-written stdlib bridge has `hierarchyDepth == 0`, so ties
break on registration order — a supertype that claimed assignability for its
subtypes could quietly steal dispatch. The registry feeds `isSubtypeOf` only,
so `indexError is RangeError` answers correctly while dispatch stays exact.

### Fixed — `on <BridgedType> catch` could not see subtypes, or its own throws

Two independent defects in `visitTryStatement`, both surfaced while building
the tests above and both affecting *every* bridge, not just these seven:

- **A script-thrown bridged error was never matched.** `throw StateError('x')`
  produces a `BridgedInstance`, but every type test in the catch matcher —
  the hardcoded fast-path switch and the bridge comparison alike — asks about
  the native type. So `on StateError` failed to catch a `StateError` the same
  script had just thrown. Matching now runs against an unwrapped native view;
  the catch variable is still bound to the `BridgedInstance`, so member access
  in the handler is unchanged.
- **Bridged matching was exact-identity only.** It compared the thrown value's
  own bridge against the catch type, which cannot see that `_TypeError` is a
  `TypeError` or that an `IndexError` is a `RangeError`. The matcher now asks
  the catch type's own `isAssignable` predicate first — a real Dart `is` — so
  the match is subtype-correct for every bridge.

### Known gaps (not addressed here, tracked separately)

The audit recorded that the interpreter already throws SDK-shaped errors and
only the bridge was missing. Probing showed that is true for
`ConcurrentModificationError` and `StackOverflowError` but not for `list[9]`,
a failing cast, a missing method on `dynamic`, or a failing `assert` — those
still surface as `RuntimeD4rtException`. Symbol literals (`#foo`) also
evaluate to `null`; use `Symbol('foo')` until that is fixed.

## 1.16.0

### Added — `StreamConsumer` bridge and working controller sinks (SC4)

`StreamConsumer` (dart:async) is now bridged, mirrored into `tom_d4rt_ast`. It
was the last P1 async gap in the SDK audit: the name did not resolve, so
`StreamConsumer` annotations and `x is StreamConsumer` tests were both unusable.

Interface only — no constructor. Scripts never build one; they receive one (a
`StreamController`, its `.sink`, or an `IOSink`) and either annotate against it
or type-test it. The bridge exposes the two members the interface declares,
`addStream(Stream)` and `close()`.

### Fixed — `StreamController.sink` was inert

Registering the interface alone would have made the type nameable while leaving
every value of it unusable. `StreamController.sink` returns a private
`_StreamSinkWrapper`, which resolved to **no bridge at all** — `add`, `addError`,
`close`, `done` and `addStream` all failed as "Undefined property or method on
`_StreamSinkWrapper<dynamic>`". The `StreamSink` bridge now claims that native
name, and gains the `addStream` it inherits from `StreamConsumer` in the SDK
(bridge dispatch is per-bridge rather than hierarchical, so an inherited member
has to be repeated on the concrete bridge or it is unreachable). Both controller
flavours — single-subscription and broadcast — hand out the same wrapper, so one
entry covers both.

### Fixed — `is` against a bridge with no `isAssignable` was always false

An `is` test against a bridged type returned a hard `false` for an unwrapped
native operand whenever the *target* bridge declared no `isAssignable` closure —
even when the operand's own bridge and the registered supertype chain both said
yes. `StreamController.sink` hit exactly that: it resolves to the `StreamSink`
bridge for member dispatch, so `sink.close()` worked while `sink is StreamSink`
was false. The `is` path now falls back to resolving the operand's bridge the
same way dispatch does and re-running the subtype walk. Purely additive — it
runs only where the answer was already a hard `false`, and adds no
`isAssignable` closure, so bridge selection is untouched.

### Why the hierarchy is declared, not claimed

The sink edges (`StreamSink`/`StreamController` -> `StreamConsumer`, and
`StreamSink` -> `EventSink`) are registered with
`BridgedClass.registerSupertypes` rather than by giving the new bridge an
`isAssignable` predicate. That closure is what `Environment.toBridgedInstance`
consults when deciding which bridge *owns* a native object, and `StreamConsumer`
is a supertype of both `StreamController` and `StreamSink`. Claiming
assignability would have entered the new bridge into that contest as an
equally-ranked match — every hand-written stdlib bridge has
`hierarchyDepth == 0`, so the tie breaks on registration order — and could have
silently stolen dispatch from the two concrete bridges. The supertype registry
feeds `isSubtypeOf` only, so `is` answers truthfully while dispatch is untouched.

## 1.15.0

### Added — `UnmodifiableMapView` and `UnmodifiableSetView` bridges (SC3)

The two read-only `dart:collection` views are now bridged, mirrored
file-for-file into `tom_d4rt_ast`. Both were P1 gaps in the SDK audit and
completed the set alongside the already-bridged `UnmodifiableListView`.

- **`UnmodifiableMapView`** — wrapping constructor plus the read-only `Map`
  surface (`[]`, `containsKey`, `containsValue`, `forEach`, `map`, `cast`,
  `length`, `isEmpty`, `isNotEmpty`, `keys`, `values`, `entries`).
- **`UnmodifiableSetView`** — wrapping constructor plus the read-only
  `Set`/`Iterable` surface, including the set algebra (`union`,
  `intersection`, `difference`, `lookup`, `containsAll`).

Both are *views*, not copies: a later change to the backing collection is
visible through the wrapper, and the tests pin that rather than only checking
the initial contents.

### Why the mutators delegate instead of throwing

`Map.unmodifiable(...)` and `Set.unmodifiable(...)` already returned these exact
runtime types, and the core `Map`/`Set` bridges claimed them by name — so reads
worked and a mutation attempt surfaced the SDK `UnsupportedError`, catchable
from script with `on UnsupportedError`. The new bridges therefore **delegate**
every mutating member to the native view rather than raising a
`RuntimeD4rtException` of their own. Intercepting would have silently broken
scripts that catch the SDK error type today.

This differs from the older `UnmodifiableListView` bridge, which does intercept
and throw `RuntimeD4rtException`. Realigning it is tracked separately, since it
is a behaviour change to a shipped bridge with its own test impact.

### Known gap (pre-existing, not introduced here)

`x is Map` is `false` for every bridged `dart:collection` map — `HashMap`,
`SplayTreeMap` and now the map view alike — and likewise `x is List` for
`UnmodifiableListView`. Supertype `is` checks only work where the core bridge's
`nativeNames` happens to enumerate the concrete runtime type, which is the case
for `Set` but not for `Map`/`List`. Characterized by `F-SC3-21` so the day it is
fixed shows up as a red test rather than going unnoticed.

## 1.14.0

### Added — `LinkedHashSet` and `SplayTreeSet` collection bridges (SC2)

The two ordered `Set` implementations from `dart:collection` are now bridged,
mirrored file-for-file into `tom_d4rt_ast`. Both were P1 gaps in the SDK audit:
scripts could already build a `Set`, but had no way to *state* which ordering
contract they depended on.

- **`LinkedHashSet`** — iteration in insertion order. Constructors `()`,
  `.from` and `.of`, plus the full `Set`/`Iterable` surface shared with the
  existing `HashSet` bridge.
- **`SplayTreeSet`** — iteration in sorted order. Same member surface; the
  constructors additionally accept the optional `compare` function
  (`SplayTreeSet(compare)`, `.from(elements, [compare])`,
  `.of(elements, [compare])`), adapted from an interpreted function into a
  native `Comparator`.

Both are registered by `CollectionStdlib`, so they resolve on
`import 'dart:collection'` like their siblings. `LinkedHashSet.isAssignable`
matches plain set literals — the same overlap the shipping `LinkedHashMap`
bridge already has with map literals — and the full suite confirms it does not
change how a bare `{...}` literal dispatches.

## 1.13.0

### Added — `Stopwatch` and `UriData` core bridges (SC1, SC10)

Two `dart:core` classes the SDK gap audit flagged as missing are now bridged,
mirrored file-for-file into `tom_d4rt_ast`:

- **`Stopwatch`** — the default constructor, `start`/`stop`/`reset`/`toString`,
  and the full getter set (`elapsed`, `elapsedTicks`, `elapsedMilliseconds`,
  `elapsedMicroseconds`, `frequency`, `isRunning`). A pure monotonic-clock read
  with no I/O, so it needs no permission gate.
- **`UriData`** — `fromString` / `fromBytes` / `fromUri`, the static `parse`,
  `contentAsBytes` / `contentAsString`, and the `uri` / `mimeType` / `charset` /
  `isBase64` / `parameters` / `contentText` getters. `contentAsString` accepts
  an `Encoding`, which `dart:convert` already supplies as `utf8` / `latin1` /
  `ascii`.

### Fixed — the `Uri.data` getter was missing

`Uri.dataFromString` and `Uri.dataFromBytes` were already bridged, but `Uri.data`
was not — so a script could *build* a `data:` URI and then had no route back to
its payload. Adding the getter closes that loop, and is what makes the new
`UriData` bridge reachable from a parsed URI at all.

### Documented — intentionally-unbridged SDK classes

`doc/d4rt_limitations.md` gains an "Intentionally-Unbridged SDK Classes" section
separating the classes that **cannot** be honoured meaningfully (`Zone`,
`Expando`, `WeakReference`, `Finalizer` — each would require a guarantee about
native identity or GC timing that an interpreter cannot make) from those merely
**deferred** pending a consumer (`Link`, `WebSocket`, `GZipCodec`/`ZLibCodec`,
`MutableRectangle`). The boundary applies to both interpreter trees, which share
one mirrored stdlib set.

## 1.12.1

### Fixed — `toString()` on a bridged enum TYPE (via `runtimeType`) (RCJ12)

- Calling `.toString()` on a bridged enum **type** — reached as a runtime value,
  typically through `enumValue.runtimeType` — no longer throws
  `"Undefined static method 'toString' on bridged enum '<Enum>'"`. The
  `BridgedEnum` method-invocation branch now mirrors the existing
  class-as-value (`InterpretedClass`) `toString` fallback: when no matching
  static method exists and the call is a no-arg `toString`, it returns the enum
  type name, matching Dart's `Type.toString()`. This unblocks the common
  metadata pattern `value.runtimeType.toString()` (e.g. Flutter's
  `DropdownMenuCloseBehavior` inspector). Calling `.toString()` on an enum
  *value* already worked (via `BridgedEnumValue.invoke`); only the *type* path
  was misrouted.

## 1.12.0

### Fixed — enum bridging for `Map<String, Enum>` args and native-stored round-trips (RCC7)

- A script `Map` whose **values** are bridged enums now coerces to a native
  `Map<String, Enum>`. `D4._coerceMapValue` unwraps `BridgedEnumValue` to its
  `.nativeValue`, mirroring the existing `_coerceMapKey` handling. Previously a
  `registerAll({...})`-style call with bridged-enum values threw
  `"BridgedEnumValue is not a subtype of type <Enum>"` while the scalar
  `register(key, enum)` path worked (it unwrapped via `extractBridgedArg`).
- `wrapNativeReturnValue` now re-wraps a native `Enum` as its `BridgedEnumValue`
  before the `toBridgedInstance` fallback, so a native-stored enum returned to a
  script round-trips to the same `BridgedEnumValue` and compares equal with `==`
  (and resolves custom getters) rather than needing a `.name`-string workaround.

## 1.11.0

### Added — static method dispatch on bridged enums (GitHub issue #2)

- `BridgedEnumDefinition` and `BridgedEnum` gained a `staticMethods` map
  (`Map<String, BridgedStaticMethodAdapter>`), wired through
  `buildBridgedEnum()`, plus `BridgedEnum.findStaticMethodAdapter(name)`.
- `visitMethodInvocation` now dispatches a static method call where the target
  is a bridged enum **type** (e.g. `PageFormat.fromString('A4')`). Previously
  only instance methods on enum *values* were reachable, so static factory
  helpers threw *"Undefined property or method '…' on BridgedEnum"*.
- Backward compatible: `staticMethods` defaults to an empty map; existing enum
  bridges are unaffected. Twin of `tom_d4rt_ast` 0.1.11.

## 1.10.1

### Fixed — native→bridge resolution: precise match must beat fuzzy prefix across scopes

- `Environment.toBridgedClass` now resolves a native runtime type in **two
  chain walks** instead of one strategy-cascade per frame:
  1. **Pass A (precise)** walks the whole enclosing-scope chain trying exact
     `Type` lookup, `_FooImpl → Foo` canonicalization, generic-base `name` /
     `nativeNames` match, suffix match, name-exact, and longest-`nativeName`
     prefix — every strategy anchored on a declared bridge identity.
  2. **Pass B (fuzzy fallback)** walks the whole chain trying the loose
     G-DCLI-05 `name`-is-a-prefix-of-the-type match (e.g. `ProgressBothImpl`
     → `Progress`).

  Previously both passes ran interleaved within a single frame and returned on
  the first hit, so a fuzzy prefix match in a **nearer** frame short-circuited a
  more-correct precise match still waiting in an **enclosing** frame.

  Concrete failure surfaced by the lazy-bridge substrate (import-optimization
  steps #17/#19): a `MappedListIterable<…>` returned by
  `List.map(...).toList()` carries its precise `nativeNames` entry on the stdlib
  `Iterable` bridge, which under the warm-parent / per-module split lives in an
  enclosing frame. A nearer module frame held the `Map` bridge but not
  `Iterable`, and `"MappedListIterable".startsWith("Map")` made the fuzzy
  fallback wrap it as `Map` — so `.toList()` failed with `Bridged class 'Map'
  has no instance method named 'toList'`. The two-pass walk now resolves it to
  `Iterable` (precise) regardless of frame distance. Mirrored in
  `tom_d4rt_ast`'s `Environment.toBridgedClass`.

## 1.10.0

### Added — lazy bridge registration (import-optimization, additive)

- `D4rt.registerBridgedClassLazy(String name, Type nativeType, BridgedClass Function() thunk, String library, {String? sourceUri})`
  — registers a bridged class by **deferred thunk**: the `BridgedClass` body
  (member maps + adapter closures) is built and memoized only when the class
  is first resolved by name or native type during interpretation. This is the
  runtime substrate the generator's lazy bridge emission targets (plan step
  #17): a script that touches N of a package's classes builds ≈N bridges
  rather than all of them.
- `D4rt.registerBridgedClass(...)` now delegates to `registerBridgedClassLazy`
  by wrapping the already-built definition as a trivial `() => definition`
  thunk — behaviour is unchanged for eager callers; the lazy path simply
  memoizes on first lookup.

This method was introduced in-tree alongside the generator's thunk emission
(commit `2d341b786`) after 1.9.0 was published, so 1.9.0 carried the
`providePackage` / `finalizeBridges` pool API but not the lazy registrar that
generated `*.b.dart` bridges call. 1.10.0 publishes the missing public method
so downstream bridge packages (e.g. `tom_d4rt_flutter`) compile against a
released `tom_d4rt`.

## 1.9.0

### Added — import-optimization API (additive, backward compatible)

- `D4rt.providePackage(String)` — process-global package pool gate: returns
  `false` the first time a package is seen (caller registers its bridges) and
  `true` once pooled (caller skips registration and reuses the pooled
  definitions). The granted set is the instance's security whitelist, exposed
  read-only via `allowedPackages`.
- `D4rt.registerExtensions(String package, void Function() callback)` /
  `finalizeBridges()` — queued bridge-package extension hooks that fire
  **exactly once per package per process** (at pool population), replacing the
  old once-per-instance firing.
- Warm-parent reuse: each execute runs in a fresh child `Environment` chained
  off a shared warm parent built at most once per allowed-set signature
  (migrated instances) or per instance (legacy) — script declarations never
  leak across executes or instances. The warm parent registers only the bridge
  *type* lookup (`registerBridgeType`); the analyzer `ModuleLoader` owns
  per-module name registration at import time for module isolation
  (GEN-100/107).
- Test/diagnostic introspection: `debugPooledPackages`, `debugPooledClassCount`,
  `debugWarmParentCacheSize`, `debugResetPool`.

## 1.8.25

- **Analyzer 10 migration (publish).** Widened the `analyzer` constraint from
  `^8.0.0` to `^10.0.0` and applied the analyzer-10 API renames
  (`NamedType`/`LibraryDirective` `.name2` → `.name`; `ErrorSeverity` →
  `DiagnosticSeverity`; `errorCode.errorSeverity` → `diagnosticCode.severity`).
  The source change itself shipped earlier but was never published — the prior
  `1.8.24` on pub.dev still carried `analyzer: ^8.0.0`. This release publishes
  the analyzer-10 build so hosted consumers (notably `tom_d4rt_generator`) can
  resolve it. No behavioural change.

## 1.8.24

### Fixes
- Same-name bridges from different libraries now resolve to the library that
  declares the requested member (B2 "MarkdownParser clash"). Previously two
  packages exporting an identically named `BridgedClass` registered last-wins by
  simple name, so the second silently shadowed the first and static/constructor
  calls to the displaced library's class failed. The `Environment` now stashes
  displaced same-name bridges and the method-invocation visitor falls back to a
  sibling bridge that declares the member; the module loader no longer errors on
  same-name/different-source class duplicates.

## 1.8.23

- Housekeeping: test artifacts now live in a gitignored `testlog/` folder; `doc/` no longer ships machine-generated baselines or last_testrun.json. No code changes.

## 1.8.22

### Fixes
- Instance members now correctly shadow bridged top-level functions of the
  same name (FIX-20260613-1038-C).
- Stop using exception-as-control-flow on implicit-`this` member reads; the
  interpreter resolves the member directly instead of throwing and catching.

### Performance
- Cache bound-method tear-offs per instance.
- Collapse the `Environment` frame for blocks that introduce no bindings.
- Stop wrapping primitive operands in binary expressions.

### Documentation
- README reframed to present the source-based interpreter as the primary,
  recommended option.
- Consolidated manual-intervention guidance into
  `doc/manual_bridge_interventions.md` and limitations into
  `doc/d4rt_limitations.md` (now the canonical limitations reference).

## 1.8.21

### Performance
- S1–S3 static lexical resolver: depth-0 slot-eligibility analysis with an
  additive, dual-write slot runtime; resolved reads served from the current
  frame's `getSlot` instead of repeated name-map chain walks.
- Lazily-allocated auxiliary `Environment` maps (S2); node-keyed inline depth
  cache for identifier resolution; single closure-free `Environment` reused
  per classic for-loop.
- `FrozenNameMap` for immutable class/mixin/enum member tables; per-class
  member-resolution cache; negative resolution cache for `toBridgedInstance`;
  canonicalized const set/map literals.
- Hot-path debug logging guarded behind `Logger.isDebug`; `ErrorReporter`
  identity `Set` with default-off tracking; memoized `Type.toString` in `D4`
  coercion helpers.

### Fixes
- Redirecting factory constructors resolve correctly.
- Static-field writes persist from sibling static methods.
- Clear native-side accumulator on reset.

## 1.8.20

### Fixes
- Cross-boundary native↔interpreted interop: `callInterpreterCallback`
  handles plain native `Function` via `Function.apply`; Expando-based
  reverse map for native↔interpreted assignment.
- Cascade setter/getter resolution unwraps `D4InterpretedProxy` targets.
- `resetScriptDeclarations` API + `/clear` REPL wiring.
- Async/timer, typed_data, and bridged-setter back-ports aligned with the
  flutter-material cluster fixes (kept in sync with `tom_d4rt_ast`).

## 1.8.19

### Fixes
- **ENV-001**: Fixed generic type matching in `environment.dart` — extract base type name before `<` for accurate BridgedClass resolution, preventing false matches like `ListMapView<int>` matching `View` bridge
- **ENV-002**: Added `endsWith` suffix match fallback for generic types — types like `CastList<T>`, `ListIterator<T>`, `CastStream<T>`, `EfficientLengthFollowedByIterable<T>` now correctly resolve to their parent bridge (`List`, `Iterator`, `Stream`, `Iterable`)
- **RT-001**: Fixed `InterpretedClass.isSubtypeOf()` — walks `InterpretedClass.superclass` chain checking `bridgedSuperclass` and `bridgedMixins` at each level instead of broken `BridgedClass.bridgedSuperclass` chain
- **BT-001**: Enum `.name`/`.index` fallback in `BridgedInstance.get()` — checks `nativeObject is Enum` before throwing on missing property
- **IV-001**: Enum property access fix in `visitPrefixedIdentifier` and `visitPropertyAccess` — properly handles `.name`, `.index` on enum values
- **IV-002**: Enum equality intercept before `toBridgedInstance` wrapping — prevents wrapping from breaking `==` comparisons
- **D4-001**: Null-safe `superObj` check in `extractBridgedArg`

### Improvements
- Added 16 list transformation iterable type names to `Iterable` bridge (`MappedListIterable`, `WhereIterable`, `CastIterable`, etc.)
- Added `ListMapView`, `_MapView` to `Map` bridge nativeNames
- Added `LinkedHashSet`, `_SetBase` to `Set` bridge nativeNames

## 1.8.18

### Features
- **GEN-079**: Added `registerFunctionTypedef` to `D4rt` base class for function typedef type resolution
  - Function typedefs (e.g., `VoidCallback`) can now be registered so the runtime resolves them as types
  - Required by bridges generated with tom_d4rt_generator 1.8.18

## 1.8.11

### Features
- **GEN-081**: Added `isAssignable` callback to `BridgedClass` for supertype bridge lookup on private subclasses
- **ENG-001**: Back-ported 3 collection handling improvements to `extractBridgedArg`:
  - List cast: try/catch fallback for non-primitive `List<T>` casts
  - Set cast: try/catch fallback for non-primitive `Set<T>` casts
  - Map unwrapping: `_unwrapElement()` for map keys/values before casting

### Bug Fixes
- Synced 4 functional gaps from tom_d4rt_ast (`extractBridgedArg` collection/enum handling)
- `toBridgedInstance` prefers most-specific `isAssignable` match
- Auto-unwrap `BridgedInstance`/`BridgedEnumValue` in callback returns
- Fixed G-DOV-8, extended I-BUG-14b records to 16 fields
- Resolved all 13 open issues (161 pass, 9 skip, 0 fail)

## 1.8.10

### Bug Fixes
- **RC-1**: Active visitor mechanism (`D4.withActiveVisitor`) for interface proxy creation inside bridge helper methods
- **RC-2**: Generic constructor dispatch in `visitMethodInvocation` + constructor override mechanism (fires even without type args, null = fallthrough)
- **RC-3**: StrutStyle constructor override creates `painting.StrutStyle` (dart:ui version is opaque)
- **RC-5**: Implicit bridged super for both Path A (`callable.dart`) and Path B (`runtime_types.dart` `InterpretedClass.call`)
- Supplementary method adapters for `@protected` methods (e.g., `notifyListeners`)
- `GenericConstructorFactory` typedef now accepts nullable `typeArgs`

## 1.8.9

### Bug Fixes
- Synced `d4.dart` with active visitor mechanism and supplementary method support
- Generic constructor registry and type coercion infrastructure

## 1.8.8

### Bug Fixes
- **GEN-075**: Fixed required nullable argument handling in generated bridge constructors
- **GEN-076**: Raised combinatorial dispatch threshold for non-wrappable default parameters

## 1.8.7

### Bug Fixes
- **GEN-078**: Runtime bridge alias resolution via `defineBridgeAlias()` in Environment
- **GEN-079**: Generic type wrapper registration for covariant generic type resolution
  - New `GenericTypeWrapperFactory` typedef and `registerGenericTypeWrapper()` in D4 class
  - `extractBridgedArg<T>` now looks up registered wrappers when `is T` check fails due to generic type argument mismatch
- **GEN-080**: Fixed named constructor resolution for unresolved AST ambiguity
  - `const ColorFilter.mode(...)` now correctly resolves the class name instead of the named constructor part
- Fixed `BridgedInstance` unwrapping in 4 setter assignment paths in `visitAssignmentExpression`

## 1.8.6

### Features
- **GEN-074**: Added support for class aliases (type alias registration)
  - New `registerClassAlias()` method in D4rt for registering type aliases
  - New `defineClassAlias()` method in Environment for alias resolution
  - Aliases are resolved lazily when looked up - if target class is registered, alias is resolved automatically

### Internal
- Added `_classAliases` field to D4rt for tracking registered aliases
- Added `_pendingClassAliases` field to Environment for lazy resolution

## 1.8.5

### Bug Fixes
- **INTER-003**: Fixed nullable double/num type promotion in `D4.extractBridgedArg`
  - `extractBridgedArg<double?>` now correctly promotes `int` to `double`
  - `extractBridgedArg<num?>` now correctly handles `int` values
  - Fixes "Invalid parameter elevation: expected double?, got int" errors in Flutter bridges
- **INTER-003c**: Fixed `D4.coerceList` to promote int elements to double in `List<double>`
  - Mixed int/double lists now correctly coerce to `List<double>`

### Internal
- Added `_isDoubleType<T>()` and `_isNumType<T>()` helpers for nullable type checking
- Added comprehensive D4 helper unit tests (`d4_helpers_test.dart`)

## 1.8.3

### Features
- Support extensible dart: library bridges - unknown dart: URIs now check for bridged content before throwing an error
- Allows external packages to register bridges for dart:ui and other dart: libraries

## 1.8.2

### Maintenance

- Added `version.versioner.dart` build-time version info file.

## 1.8.1

### Bug Fixes
- **GEN-056**: Fixed extension on-type resolution for stdlib and bridge types in the interpreter
- **G-DCLI-05/07/08/11/12/13/14**: All DCli bridge issues resolved — proper handling of DCli-specific bridged methods and types

### Tests
- **Flaky file IO tests**: Fixed race condition where all file IO tests (I-FILE-144 through I-FILE-159) shared a hardcoded `/tmp/test.txt` path. Under concurrent execution, one test's `deleteSync()` would remove the file while another was still using it. Each test now uses a unique filename (`/test_{ID}.txt`).
- 1680 tests pass (2 known I-BUG-14a/14b intentional failures excluded)

## 1.7.0

### Bug Fixes
- **G-GNRC-7**: Fixed `runtimeType` comparison with type identifiers. When comparing `runtimeType` (which returns a native `Type`) against type identifiers like `int` (which resolve to `BridgedClass`), the interpreter now correctly compares via `BridgedClass.nativeType`. This fixes F-bounded polymorphism tests involving `Comparable<T>` sort operations.

## 1.6.1

### Documentation
- **Advanced Bridging User Guide**: New comprehensive guide for the D4 helper class covering type coercion, argument extraction, target validation, and global function bridging
- **Example suite**: Added 5 runnable examples demonstrating D4 class usage patterns:
  - `d4_type_coercion_example.dart` - List and Map coercion
  - `d4_argument_extraction_example.dart` - Positional and named arguments
  - `d4_target_validation_example.dart` - Target validation and inheritance
  - `d4_globals_example.dart` - Global functions and variables
  - `d4_complete_bridge_example.dart` - Complete realistic example with enums, factories, and complex signatures

## 1.6.0

### Features
- **Comprehensive Dart language coverage**: All 20 areas of the Dart language now pass the dart_overview test suite
- **Extension types (Dart 3.3+)**: Full support for inline classes / extension types
- **sync* generators**: Fixed infinite loop issues with sync* generators (lazy evaluation now works correctly)
- **Improved extension support**: Extensions on bridged types and imported extensions now work correctly
- **Enhanced pattern matching**: Full support for logical OR patterns, when guards, record patterns with named fields and shorthand syntax

### Bug Fixes (99 total bugs tracked, 97 fixed)

#### Interpreter Core
- **Bug-93**: Int not implicitly promoted to double return type - fixed auto-promotion in return statements
- **Bug-94**: Cascade index assignment on property (`..headers['key'] = value`) now works correctly
- **Bug-96**: `super.name` constructor parameter forwarding now correctly passes values to super constructor
- **Bug-97**: `num` now recognized as satisfying `Comparable<num>` type bound
- **Bug-98**: Extension getters on bridged List resolved correctly, including accessing other extension members via implicit `this`
- **Bug-99**: `Stream.handleError` callback arity detection - callbacks with 1 or 2 parameters both work correctly
- **Bug-95**: `List.forEach` with native function tear-offs (like `print`) now works
- **Bug-79-92**: Various fixes for switch expressions, cascades, patterns, and class modifiers

#### Pattern Matching
- **Bug-81**: Pattern with `when` guard now works (`case String s when s.isNotEmpty`)
- **Bug-88**: Record pattern with `:name` shorthand syntax works
- **Bug-66, Bug-67**: Record patterns with named fields and if-case with int patterns fixed

#### Class System
- **Bug-84, Bug-85**: Mixin abstract method satisfaction and extending abstract final classes
- **Bug-72**: Bridged mixins properly resolved during class declaration
- **Bug-51**: Mixing in bridged mixins works correctly

#### Async/Stream
- **Bug-44**: Async generators completion detection
- **Bug-48**: `await for` stream iteration
- **Bug-73, Bug-74**: Async nested loops and return type handling

#### Standard Library
- **Bug-89**: `Enum.values.byName` (via List.byName extension) bridged
- **Bug-82, Bug-83**: Function.call and nullable function?.call() support
- **Bug-65**: Map.from constructor bridged

### Known Limitations (Won't Fix)
- **Lim-3**: Isolate execution with interpreted closures - fundamental limitation due to Dart's isolate serialization requirements
- **Bug-14**: Records with named fields or >9 positional fields return InterpretedRecord (Dart doesn't support dynamic record type creation)

### Test Coverage
- **1620 tests passing** (3 expected failures for "Won't Fix" limitations)
- **21 dart_overview_bugs_test** tests all passing
- All 20 Dart language areas demonstrated in dart_overview scripts

### Documentation
- Consolidated BRIDGING_GUIDE.md to single location in `doc/` folder
- Moved dart_overview and d4rt_bugs test scripts to tom_d4rt/example folder
- Updated documentation to reflect current capabilities

---

## 1.5.0

### Features
- **Script execution module**: New `ScriptExecutionResult` and file-based script execution with automatic import resolution
- **Bridge deduplication**: Complete deduplication system with `sourceUri` tracking to prevent duplicate registrations across packages
- **D4rtConfiguration enhancement**: Added library info support for better multi-package configurations
- **Unary operator fix**: Fixed unary operators (e.g., `-x`) on bridged instances

### Bug Fixes
- Fixed typedef callback wrapping in bridge registration
- Fixed type resolution for bridges with complex generics

### Internal
- Added shared script_execution module for D4rt-based CLI tools
- Improved error aggregation for bridge registration failures

## 1.4.0

### Features
- **Global getter lazy evaluation**: Added `GlobalGetter` wrapper class for lazy evaluation of top-level getters
- **registerGlobalGetter method**: New D4rt method `registerGlobalGetter(name, getter)` for registering getters that are evaluated at access time rather than registration time
- Essential for singleton patterns and values that may not be initialized at registration time

### Documentation
- Added "Global Variables and Getters" section to BRIDGING_GUIDE.md
- Documented when to use `registerGlobalVariable` vs `registerGlobalGetter`

## 1.3.1
- **Repository reorganization**: Moved to tom_module_d4rt repository as part of modular workspace structure
- Updated repository URL to https://github.com/al-the-bear/tom_module_d4rt

## 1.3.0
- **Operator bridging support**: BridgedInstance now supports all Dart operators
  - Arithmetic: +, -, *, /, ~/, %
  - Comparison: <, >, <=, >=, ==
  - Bitwise: &, |, ^, ~, <<, >>, >>>
  - Index: [], []=
  - Unary: - (negation)
- Added operator override documentation for UserBridge classes
- Added bridged_operators_test.dart with comprehensive operator tests

## 1.2.0
- Added D4 bridge helpers class for generated bridge code
  - Type coercion helpers (coerceList, coerceMap)
  - Argument extraction helpers (getRequiredArg, getOptionalArg, etc.)
  - Target validation for instance methods
  - Argument count validation
- D4 class moved from tom_dartscript_core to tom_d4rt

## 1.1.0
- Updated analyzer dependency to ^8.0.0 (from fixed 8.0.0)
- Bridge generator improvements and cleanup

## 1.0.4
- Changed dependency of analyzer to version 8.0.0

## 0.1.9
- **feat:positionalArgs and namedArgs** - Pass arguments directly to functions via execute()
  - Add `positionalArgs` parameter to D4rt.execute() for passing positional arguments
  - Add `namedArgs` parameter to D4rt.execute() for passing named arguments
  - Support complex data types (List, Map, nested structures) as arguments
  - Support function callbacks and async functions as arguments
  - Add 33 comprehensive test cases covering all argument passing patterns
  - Add parameter introspection methods: `positionalParameterNames` and `namedParameterNames` getters

- **feat: Introspection API** - Analyze code structure and get metadata at runtime
  - Add `analyze()` method to D4rt for code analysis without execution
  - Create IntrospectionResult with metadata about functions, classes, enums, variables, and extensions
  - Extract function signatures including parameter names, types, and default values
  - Extract class information: inheritance, mixins, interfaces, constructors, methods
  - Extract enum values and variants
  - Extract variable declarations and initializers
  - Extract extension definitions and extended types
  - Use AST-based analysis for accurate metadata extraction
  - Add 38 comprehensive test cases covering all declaration types and complex scenarios

- **feat: eval() method** - Dynamically execute code with current execution state
  - Add `eval()` method to D4rt for dynamic code execution
  - Preserve execution environment across eval calls
  - Support access to previously defined variables and functions
  - Support complex expressions and statements in eval
  - Support async/await in eval expressions
  - Add 39 comprehensive test cases covering expression evaluation and statement execution

- **fix: Environment import handling** - Tolerate duplicate imports with identical values
  - Allow re-importing the same symbol if the value is identical (same reference)
  - Use `identical()` comparison for duplicate detection
  - Support imports via multiple paths without conflict errors

## 0.1.8
- fix: security sandboxing with permission checks for file, process, and network operations; add platform access control

## 0.1.7
- **feat: Security sandboxing system** - Comprehensive permission-based security system to restrict dangerous operations
  - Implement modular permission system with `FilesystemPermission`, `NetworkPermission`, `ProcessRunPermission`, `IsolatePermission`
  - Block access to dangerous modules (`dart:io`, `dart:isolate`) by default unless explicitly granted
  - Add `d4rt.grant()`, `d4rt.revoke()`, `d4rt.hasPermission()` methods for permission management
  - Integrate permission checking into module loading and import directives
  - Support fine-grained permissions (specific paths, commands, network hosts)
  - Add comprehensive security tests to prevent malicious code execution
  - Enable safe execution environment for untrusted code

## 0.1.6
- fix: Nested for-in loops in async contexts now work correctly
- fix: Async nested for-in loops with await for streams works
- feat: enhance async execution state to support nested await-for loops and improve iterator management; add comprehensive tests for complex async scenarios
- **feat: Compound super operators** - Support for compound assignment operators on super properties (+=, -=, *=, /=, ~/=, %=, &=, |=, ^=, <<=, >>=, >>>=)
  - Implement proper lookup and evaluation of super properties in compound assignments
  - Support for both interpreted and bridged superclass properties
  - Add 6 comprehensive test cases covering all operator types and nested inheritance
- **feat: Bridged static methods as values** - Bridged static methods can now be treated as first-class function values
  - Support for accessing bridged static methods as callable values (e.g., `int.parse`)
  - Enable passing bridged static methods to higher-order functions
  - Store bridged static methods in collections and variables
  - Add 5 test cases for static method value usage patterns
- **feat: Complex generic type checking** - Enhanced runtime type checking for generic collections with type parameters
  - Support `is` operator with parameterized types (List<int>, Map<String, int>, etc.)
  - Runtime validation of generic type constraints
  - Proper handling of nested generic types and null safety
  - Add 10 comprehensive test cases for various generic type checking scenarios
- **feat: Complex await assignments** - Advanced await expression support in various contexts
  - Support await in conditional expressions (ternary operator)
  - Support await in list/map literals and collection operations
  - Support await in compound assignments and complex expressions
  - Support await in constructor arguments and method chains
  - Add 10 test cases covering complex async assignment patterns
- **feat: Stream transformers** - Complete implementation of StreamTransformer and stream manipulation
  - Implement `StreamTransformer.fromHandlers` with handleData, handleError, handleDone
  - Support stream transformation with custom logic
  - Implement bidirectional stream transformers
  - Support stream event handling and error propagation
  - Add 10 comprehensive test cases for stream transformation patterns
- **feat: Const expressions complexes** - Enhanced support for const expressions in various contexts
  - Support const List and Map literals with type parameters
  - Support const expressions in field initializers and default parameters
  - Support nested const collections and complex const expressions
  - Proper compile-time evaluation of const expressions
  - Add 15 test cases covering const expression usage patterns
- **feat: Feature #7 - Enhanced enums with mixins** - Enums can now use mixins to add functionality
  - Support `enum Name with Mixin` syntax
  - Mixins can add methods, getters, and properties to enum values
  - Support multiple mixins on a single enum
  - Full integration with enum values (index, name, toString)
  - Add 15 comprehensive test cases for enum-mixin combinations
- **feat: Extensions statiques** - Extensions can now declare static members (methods, getters, setters, fields)
  - Implement static member storage in `InterpretedExtension` class
  - Add static member access via `Extension.member` syntax
  - Support static method calls, property access, and assignments
  - Add support for prefix/postfix increment/decrement operators on static extension fields
  - Add 15 comprehensive test cases covering all static extension member types
- **feat: Enhance compound super assignments for bridged classes** - Full support for compound assignments on properties inherited from bridged superclasses
  - Fix `visitAssignmentExpression` to handle bridged superclass getters/setters in compound `super` assignments
  - Fix `InterpretedInstance.get()` to properly traverse bridged superclass hierarchy at each inheritance level
  - Fix `InterpretedInstance.set()` to properly handle bridged superclass setters at each inheritance level
  - Support nested inheritance chains (Interpreted → Interpreted → Bridged)
  - Add 5 comprehensive test cases for bridged super compound assignments
- **Total test count: 1269 tests passing** - All 8 planned features fully implemented with comprehensive test coverage

## 0.1.5
- feat: implement handling of factory constructors in InterpreterVisitor; add comprehensive tests for factory constructor behavior
- feat: enhance async execution state and interpreter visitor to support break/continue handling; add comprehensive tests for nested async loops
- feat: enhance async execution state and interpreter visitor to support async* generators; add comprehensive tests for generator behavior and control flow

## 0.1.4
- feat: add methods to find and retrieve bridged enum values in Environment and InterpreterVisitor; enhance handling of bridged enums in property access and binary expressions
- feat: enhance documentation across multiple files; add examples and clarify class functionalities in D4rt interpreter
## 0.1.3
- Implement complete `late` variable support with lazy initialization and proper error handling
- Add comprehensive late variable test coverage (33 test cases) including static fields, instance fields, final constraints, and error conditions
- Add LateVariable class with proper uninitialized access detection and assignment validation
- Enhance interpreter visitor to handle late variables in all contexts (local, static, instance)
- Fix nullable variable handling in interpreted class instances
- Add ComparableCore bridge to core standard library for better type comparison support
- Update documentation and project description for better clarity

## 0.1.2+1
- update project description in pubspec.yaml
- docs: minor updates to documentation in README.md

## 0.1.2
- Implement complete Isolate API with Capability, IsolateSpawnException, Isolate, SendPort, ReceivePort, RawReceivePort, RemoteError, and TransferableTypedData classes
- Add comprehensive isolate communication and message passing support
- Enhance async capabilities with Timer functionality and improved error handling
- Add UnawaitedAsync and TimeoutExceptionAsync classes for better async error management
- Implement additional HTTP methods and error handling in HttpClientIo
- Add toString method to DirectoryIo for better debugging
- Enhance FileSystemEntity with parentOf method and FileStat improvements
- Add FileSystemEvent static getters and methods
- Implement RawSocket and additional Socket classes for network programming
- Enhance Stream and Socket classes with additional utility methods
- Add IOSink, ProcessIo, and StringSink classes for improved I/O operations
- Implement Comparable interface for better type comparison support
- Add comprehensive test coverage for isolate, socket, and I/O functionality
- Update core typed data classes (Uint8List, Int16List, Float32List) with enhanced functionality
- Add list extension utilities for better collection manipulation

## 0.1.1
- Implement await for-in loop support for streams in interpreter
- Enhance pattern matching with support for rest elements in lists and maps
- Add support for await expressions in function and constructor arguments
- BREAKING CHANGE: BridgedClassDefinition has been removed and replaced with BridgedClass

## 0.1.0
- Added runtime checks for generic type constraints.
- Added support for compound bitwise assignment operators (&=, |=, etc.).
- Introduced Int16List and Float32List in typed_data.

## 0.0.9
- full support (generic classes/functions, type constraints, runtime validation)
- use BridgedClassDefinition for all Stdlib
- Support adjacent string literals in interpreter
- add operators support for InterpretedClass
- more features

## 0.0.8
- expose visitor getter
- add support for bridged mixins
- enhance async execution state with nested loop support 

## 0.0.7
- fix: support null safety

## 0.0.6
- Update docs

## 0.0.5
- minor fix

## 0.0.4
- Add 'import/export' directive support, support for 'show' and 'hide' combinators 
- Add some dart:collection & dart:typed_data
- Support for ParenthesizedExpression property access in simpleIdentifier in async state

## 0.0.3
- Fix infinite loop when using rethrow in try catch in async state

## 0.0.2
- Support web
- Fix return nativeValue for BridgedEnumValue to BridgedInstance argument

## 0.0.1

- Initial version.