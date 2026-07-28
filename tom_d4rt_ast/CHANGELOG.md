## 0.15.0

### Changed — `UnmodifiableListView` mutators raise the SDK's `UnsupportedError` (SCB6)

**This is a behaviour change to a shipped bridge.** A mutation attempt on
an `UnmodifiableListView` used to be intercepted by the bridge, which
raised `RuntimeD4rtException("Unsupported operation: Cannot modify an
unmodifiable list")`. All 18 mutating methods and the `length` / `first` /
`last` setters now delegate to the native view, so the failure a script
sees is the SDK's own `UnsupportedError` — catchable with
`on UnsupportedError`, as the `dart:collection` contract says it should
be, and matching the `UnmodifiableMapView` / `UnmodifiableSetView` bridges
which have delegated since they were added.

Arguments are still validated before delegating, so a malformed call
reports the argument problem rather than the equally-true-but-less-useful
unsupported-operation error.

**Migration:** a script that catches `RuntimeD4rtException` around a
mutation of an unmodifiable list will no longer see it — catch
`UnsupportedError` instead. Read-only members, and scripts that do not
attempt mutation, are unaffected.

Mirrors `tom_d4rt` 1.23.0.

## 0.14.0

### Fixed — record type annotations resolve to their real shape (DGUB8)

The record branch of the type resolver rebuilt the annotation from its
ARITY alone: every field type became `dynamic`, and every named key became
a synthetic `$named0`, `$named1`, … That was not a cosmetic placeholder.
The record VALUE side derives its `RecordRuntimeType` from the actual
`InterpretedRecord`, so it carries the REAL key — and a real key never
equals a synthetic one. Three consequences, all measured:

- a record with ANY named field matched nothing in either direction, so
  `(42, label: 'answer') is (int, {String label})` answered false;
- a positional-only record matched on arity while IGNORING field types, so
  `(1, 'a') is (String, int)` answered true — unsound;
- `as` accepted casts it should have rejected.

`SRecordTypeField` (`tom_ast_model` 0.2.0) makes the field types and named
keys reachable, and both resolvers (`interpreter_visitor.dart`,
`callable.dart`) now read them, recursing into nested field types. An
absent field type — malformed source, or a bundle serialised before the
field node existed — resolves to `dynamic`, which widens the record type
rather than making the whole annotation unresolvable.

Requires `tom_ast_model >=0.2.0`.

### Changed — filesystem permission scopes are symlink-aware (DGUB5)

`FilesystemPermission` now compares the grant and the requested path on
their REAL paths, with symlinks resolved, instead of on their literal
spellings. Both halves of the old behaviour are corrected:

- **A grant on a resolved path now admits an unresolved spelling of the
  same location.** This was a routine annoyance on macOS, where
  `Directory.systemTemp` hands back `/var/folders/...` — itself a symlink
  to `/private/var/folders/...` — so granting a resolved path and then
  reading through the unresolved one was denied for no visible reason.

- **A symlink inside a granted directory no longer reaches outside it.**
  This is the security-relevant half: `<sandbox>/link_to_elsewhere/x`
  used to satisfy a `<sandbox>` grant because it was lexically in scope,
  while actually reading from wherever the link pointed.

**This is a tightening, so it can deny operations that previously
succeeded** — specifically, any access that relied on a symlink to leave
its granted directory. Grants that name the same location the operation
really touches are unaffected, whichever way either side is spelled.

Paths that do not exist yet are still matched: resolution walks up to the
deepest existing ancestor and re-appends the remainder, so a `writePath`
grant consulted before the file is created behaves as it always did — and
still notices a symlinked ancestor. Resolution failures (broken links,
racing deletions) fall back to the literal spelling rather than throwing.

## 0.13.0

### Added — `JsonUtf8Encoder` and `ClosableStringSink` (SC9)

Completes the P2 row of the stdlib SDK gap audit.

- **`JsonUtf8Encoder`** (`dart:convert`) — object to UTF-8 JSON bytes in
  one pass, with `convert`, `startChunkedConversion`, `fuse`, `bind` and
  `cast`, and all three optional constructor arguments (`indent`,
  `toEncodable`, `bufferSize`) read by position so that a `null` indent
  keeps its meaning.

  This **repairs a live dead end** rather than merely widening coverage.
  The SDK specialises `JsonEncoder.fuse`, so `JsonEncoder().fuse(
  Utf8Encoder())` has always returned a native `JsonUtf8Encoder` through
  the long-shipped `fuse` adapter — and every call on the result then
  failed with `Undefined property or method 'convert' on
  JsonUtf8Encoder`.

- **`ClosableStringSink`** (`dart:convert`) — `fromStringSink`, `close`,
  and the full `StringSink` surface (`write`, `writeln`, `writeCharCode`,
  `writeAll`) declared explicitly, since bridge dispatch is per-bridge.

### Fixed — two `dart:convert` bridges were unreachable

`StringConversionConvert` and `ChunkedConversionConvert` were fully
written and exported from `convert.dart` but never passed to
`defineBridge`, so no script could name either. That left
`Converter.startChunkedConversion` uncallable across the whole library —
nothing could construct the sink argument it requires — and made
`asStringSink()`, the idiomatic route to a `ClosableStringSink`,
unreachable. Both are now registered, and `StringConversionSink` gains an
`asStringSink` adapter.

### Fixed — sink dispatch after registering the hierarchy root

Giving `ChunkedConversionSink` an `isAssignable` predicate makes it match
every sink in the library, and because each is handed back as a private
class the resolver always lands in the `isAssignable` pass. The root
therefore swallowed its own subtypes. Following the
`QueueHierarchyCollection` precedent, the edges are now declared via
`BridgedClass.registerSupertypes` in `convert/convert_hierarchy.dart`, and
`ByteConversionSink` carries its own predicate and `nativeNames` so the
most-specific filter has a candidate to keep.

### Tests

15 registration-level tests (`F-SC9-AST-1` … `F-SC9-AST-15`) in
`test/runtime/stdlib_convert_p2_test.dart`. They are registration-level
rather than script-level because `tom_d4rt_exec` resolves `tom_d4rt_ast`
from pub.dev, so it cannot execute a script against unpublished local
edits; the script-level equivalents live in `tom_d4rt/test/stdlib/convert/`.

## 0.12.0

### Added — `BytesBuilder` (SC8)

Mirrors `tom_d4rt` 1.20.0 file-for-file — the two trees share one stdlib bridge
set, so a class present in only one of them is a silent capability difference.

`BytesBuilder` from `dart:typed_data` is bridged, exposing the constructor with
its `copy:` flag, `addByte`, `add`, `takeBytes`, `toBytes`, `clear`, `length`,
`isEmpty` and `isNotEmpty`.

Both of the type's private implementations are on `nativeNames`:
`_CopyingBytesBuilder` for the default and `_BytesBuilder` for `copy: false`.
The `copy:` argument is what selects between them, so listing only the default
would leave the non-copying flavour constructible and broken on its first
member call.

## 0.11.0

### Added — `DoubleLinkedQueue` and its entry cursor (SC7)

Mirrors `tom_d4rt` 1.19.0 file-for-file — the two trees share one stdlib bridge
set, so a class present in only one of them is a silent capability difference.

`DoubleLinkedQueue` and `DoubleLinkedQueueEntry` are bridged. The entry bridge
carries `nativeNames: ['_DoubleLinkedQueueElement']` because `firstEntry()`
returns that private SDK subclass; without the routing every accessor on the
result would reach no bridge at all.

### Fixed — queues could not reach their inherited `Iterable` surface

`QueueHierarchyCollection` declares `DoubleLinkedQueue`/`ListQueue -> Queue`
and `Queue -> Iterable` to `BridgedClass.registerSupertypes`. This repairs the
already-shipped `ListQueue` bridge, on which `contains`/`join`/`where`/`map`
failed outright and `q is Iterable` was false, and it is what makes the new
deque usable without duplicating thirty `Iterable` adapters onto it.

The edges go through the registry rather than a widened `isAssignable` on
purpose: `Environment.toBridgedInstance` uses `transitiveSupertypeNames` to
drop supertype matches, so registering the hierarchy makes dispatch strictly
more exact — a deque is not mistaken for a `ListQueue`.

15 registration-level tests in
`test/runtime/stdlib_double_linked_queue_test.dart`, mirroring the 17
script-level tests on the `tom_d4rt` side.

## 0.10.0

### Added — the P2 `dart:async` types (SC6)

Mirrors `tom_d4rt` 1.18.0 file-for-file — the two trees share one stdlib bridge
set, so a class present in only one of them is a silent capability difference.

`StreamView`, `AsyncError` and `StreamTransformerBase` are bridged.
`StreamView` declares no `isAssignable` and is routed to the `Stream` bridge
through `nativeNames` so it keeps the ~60-member surface it inherits;
`AsyncError` is concrete and therefore the one `dart:async` bridge that *does*
carry an `isAssignable`; `StreamTransformerBase` gets a null-returning default
constructor so `super()` resolves in an interpreted subclass. The
`StreamView -> Stream`, `AsyncError -> Error` and
`StreamTransformerBase -> StreamTransformer` edges are registered through
`BridgedClass.registerSupertypes`.

`Stream.transform` now accepts a script transformer by wrapping its interpreted
`bind` in `StreamTransformer.fromBind`.

### Fixed — three generic interpreter gaps

Mirrors the `tom_d4rt` 1.18.0 fixes; none is `dart:async`-specific.

- `visitIsExpression` short-circuited every `InterpretedInstance` operand of
  `is BridgedX` to `false`, so a script class failed the `is` test against its
  own declared bridged superclass. It now consults
  `InterpretedClass.isSubtypeOf`.
- `InterpretedClass.isSubtypeOf` walked `bridgedSuperclass` and `bridgedMixins`
  but not `bridgedInterfaces`, so `implements SomeBridge` was not a subtype edge.
- `visitMethodInvocation` never ran the Cluster-12 `lookupOnBridgedSupertypes`
  walk, so a method inherited from a registered supertype was unreachable as a
  call even though its tear-off resolved.

## 0.9.0

### Added — the catchable `dart:core` error types (SC5)

Mirrors `tom_d4rt` 1.17.0 file-for-file — the two trees share one stdlib bridge
set, so a class present in only one of them is a silent capability difference.

`NoSuchMethodError`, `ConcurrentModificationError`, `IndexError`, `TypeError`,
`AssertionError`, `StackOverflowError` and `OutOfMemoryError` are bridged, with
`_TypeError` / `_AssertionError` routed to their public bridge via
`nativeNames`, and the `dart:core` error inheritance chain declared through
`BridgedClass.registerSupertypes` (`ErrorHierarchyCore`) so `isSubtypeOf` can
answer `indexError is RangeError` without any bridge claiming assignability for
its subtypes.

### Fixed — `on <BridgedType> catch` could not see subtypes, or its own throws

Mirrors the `visitTryStatement` fixes in `tom_d4rt` 1.17.0: catch-clause type
matching now runs against an unwrapped native view of the thrown value (a
script-thrown bridged error arrives as a `BridgedInstance`, so `on StateError`
used to miss a `StateError` the script had just thrown), and consults the catch
type's own `isAssignable` predicate before falling back to the exact
bridge-identity comparison.

## 0.8.0

### Added — `StreamConsumer` bridge and working controller sinks (SC4)

Mirrors `tom_d4rt` 1.16.0 file-for-file — the two trees share one stdlib bridge
set, so a class present in only one of them is a silent capability difference.

- **`StreamConsumer`** — the dart:async interface, with `addStream(Stream)` and
  `close()`. No constructor; scripts receive one rather than building it.
- **`StreamSink`** now claims the private `_StreamSinkWrapper` that
  `StreamController.sink` hands out (it previously reached no bridge, so every
  member on a controller sink failed) and gains the inherited `addStream`.
- The sink supertype edges are registered via `BridgedClass.registerSupertypes`
  so `isSubtypeOf` knows the hierarchy without an `isAssignable` closure that
  would have competed for bridge dispatch.

### Fixed — `is` against a bridge with no `isAssignable` was always false

Mirrors the `tom_d4rt` 1.16.0 interpreter fix: an `is` test against a bridged
target with no `isAssignable` closure returned a hard `false` for an unwrapped
native operand, even when the operand's own bridge and the supertype chain both
said yes. The `is` path now resolves the operand's bridge the way dispatch does
and re-runs the subtype walk. See the `tom_d4rt` 1.16.0 entry for the full
rationale.

Coverage here is registration-level: `tom_d4rt_exec` — the runner that could
execute a script against this tree — resolves `tom_d4rt_ast` from pub.dev, so
it cannot see unpublished local edits. The script-level round trips live in
`tom_d4rt/test/stdlib/async/stream_consumer_test.dart`.

## 0.7.0

### Added — `UnmodifiableMapView` and `UnmodifiableSetView` bridges (SC3)

Mirrors `tom_d4rt` 1.15.0 file-for-file — the two trees share one stdlib bridge
set, so a class present in only one of them is a silent capability difference.

- **`UnmodifiableMapView`** — wrapping constructor plus the read-only `Map`
  surface; mutating members delegate to the native view so the SDK
  `UnsupportedError` reaches the script.
- **`UnmodifiableSetView`** — wrapping constructor plus the read-only
  `Set`/`Iterable` surface, including the set algebra.

See the `tom_d4rt` 1.15.0 entry for why the mutators delegate rather than
raising a `RuntimeD4rtException`.

Coverage here is registration-level: `tom_d4rt_exec` — the runner that could
execute a script against this tree — resolves `tom_d4rt_ast` from pub.dev, so
it cannot see unpublished local edits. The script-level round trips live in
`tom_d4rt/test/stdlib/collection/`.

## 0.6.0

### Added — `LinkedHashSet` and `SplayTreeSet` collection bridges (SC2)

Mirrors `tom_d4rt` 1.14.0 file-for-file — the two trees share one stdlib bridge
set, so a class present in only one of them is a silent capability difference.

- **`LinkedHashSet`** — insertion-order `Set`. Constructors `()`, `.from`,
  `.of`, plus the `Set`/`Iterable` surface shared with the `HashSet` bridge.
- **`SplayTreeSet`** — sorted `Set`. Same member surface, with the optional
  `compare` function accepted by all three constructors and adapted from an
  interpreted function into a native `Comparator`.

Registered by `CollectionStdlib`, i.e. resolved lazily on a script's
`import 'dart:collection'`.

Coverage in this tree is registration-level (`test/runtime/
stdlib_ordered_sorted_sets_test.dart`); the script-level round-trips that prove
the iteration-order contracts live in `tom_d4rt`, because `tom_d4rt_exec`
resolves this package from pub.dev and so cannot execute against unpublished
local edits.

## 0.5.0

### Added — `Stopwatch` and `UriData` core bridges, plus the `Uri.data` getter (SC1, SC10)

Mirrors `tom_d4rt` 1.13.0 file-for-file — the two trees share one stdlib bridge
set, so a class present in only one of them is a silent capability difference.

- **`Stopwatch`** — default constructor, `start`/`stop`/`reset`/`toString`, and
  the `elapsed*` / `frequency` / `isRunning` getters. No I/O, no permission gate.
- **`UriData`** — `fromString` / `fromBytes` / `fromUri`, static `parse`,
  `contentAsBytes` / `contentAsString`, and the full getter set.
- **`Uri.data`** — previously missing, which left a script able to build a
  `data:` URI but unable to read it back.

Covered by `test/runtime/stdlib_stopwatch_uri_data_test.dart`, which pins the
registration and drives the instance getters against real native objects.
Script-level round-trip coverage for the analyzer-free line lands in
`tom_d4rt_exec` once this version is published — exec consumes this package from
pub.dev, not by path.

## 0.4.1

### Directive context for the entry library's own imports (DFUB13)

0.4.0 attached owner context inside `AstModuleLoader`, which covers every import
reached *through* another module but not the one written directly in the entry
library — the visitor loads that one itself. `visitImportDirective` now applies
the same wrap, so all three interpreter trees behave identically.

The owner is captured *before* the load: `loadModule` advances `currentLibrary`
to the module it is loading, so reading it in the catch would report owner ==
target. For a bare `source:` script there is no enclosing library and the wrap is
skipped rather than filled with a synthetic URI, which would only restate the
target.

## 0.4.0

### A failed import/export now says which file to edit (DFUB13)

A missing module used to be reported as `Module "package:x/y.dart" not found in
bundle` — the target, and only the target. In a barrel chain that is the wrong
half of the information: the missing URI is the symptom, the file holding the
bad directive is the thing you have to open. That file is now named.

- **Directive context.** `AstModuleLoader` wraps a failure while processing an
  `import`/`export` as `Failed to load import "<target>" from module "<owner>":
  <original message>`. `loadModule` recurses, so the wrap is applied **once**,
  at the innermost frame — the one that knows the file actually containing the
  directive — rather than once per frame on the way out.
- **A `package:` URI that is not in the bundle gets actionable guidance.**
  "Not found in bundle" has two quite different causes with two different fixes:
  the package library was never compiled into the bundle, or it is meant to be
  supplied natively by a bridge. Both are now named.

**New public API in `exceptions.dart`:**

- `wrapDirectiveError(directiveType, ownerUri, targetUri, error)` — attaches the
  owner/target context. It **preserves the concrete exception type** (only the
  message gains a prefix), so existing `on SourceCodeD4rtException` /
  `on RuntimeD4rtException` clauses keep matching. A type it cannot reconstruct
  is returned unchanged rather than downgraded to a base type.
- `D4rtException.hasDirectiveContext` — the once-only flag consulted by the
  above. It lives on the base class because the two module loaders report a
  missing module with *different* types: the filesystem loader in `tom_d4rt`
  raises `SourceCodeD4rtException`, this package's bundle loader raises
  `RuntimeD4rtException`, and both need the same suppression rule.

No behaviour changes for code that loads successfully, and no bundle format
change.

## 0.3.0

### Web support — the public barrels no longer pull in `dart:io` (DFUB12)

`d4rt.dart`'s header has always promised that "any consumer that only needs to
run pre-compiled `AstBundle`s (e.g. a Flutter app, including on web) can depend
on it without pulling in `dart:io`". That was not true: two libraries the
barrel re-exports imported `dart:io` unconditionally, so `import
'package:tom_d4rt_ast/d4rt.dart'` could not build for web. It is true now, and a
test enforces it.

**Nothing changes on native.** No API was added, removed or renamed, and the
bundle byte format is unchanged.

- **GZIP now goes through `package:archive` instead of `dart:io`.** This was the
  larger half of the problem: `dart:io`'s `gzip` codec was used by `toBytes`,
  `fromBytes`, `toZip` and the per-module decoder — the core bundle paths a web
  consumer needs — not just by the file helpers. `archive`'s `GZipEncoder` /
  `GZipDecoder` delegate to the native `GZipCodec` on native and to a pure-Dart
  ZLib on web, so there is no performance cost off the web and the container is
  the same gzip either way. Bundles written by earlier versions still load, and
  bundles written by this version still load in earlier versions — both
  directions are covered by tests.
- **File access moved behind a conditional import**
  (`utils/file_access/{io,web}.dart`, the shape already used by
  `security/current_directory_io.dart` and the logger). `AstBundle.saveToFile` /
  `fromFile` and `D4rtRunner.parseJsonFile` / `executeFromJsonFile` keep their
  signatures and their native behaviour; on web they throw `UnsupportedError`
  pointing at the byte-level entry points (`AstBundle.fromBytes` / `fromZip`,
  `D4rtRunner.parseJson`) that a web consumer should use instead.
- **New regression guard** (`test/web_safety_test.dart`): it walks the
  transitive import graph of every public library with conditional imports
  resolved down their `dart.library.html` branch, and fails if `dart:io` is
  reachable. This is deliberately a static graph walk rather than a web compile
  — neither `dart compile js` nor `dart compile wasm` rejects a `dart:io`
  import at compile time on the current SDK, so a compile-based check cannot
  fail and would be a guard in name only.

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