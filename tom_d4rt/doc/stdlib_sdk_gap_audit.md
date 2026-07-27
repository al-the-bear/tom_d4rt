# D4rt stdlib — SDK gap audit

**Date:** 2026-07-07 (updated 2026-07-27)
**Interpreter version:** tom_d4rt (analyzer-based) + tom_d4rt_ast (mirror)
**SDK reference:** Dart 3.12.2 (package constraint `^3.5.0`)
**Scope audited:** all stdlib bridge files under
`tom_d4rt/lib/src/stdlib/` (100 files) and the mirror set under
`tom_d4rt_ast/lib/src/runtime/stdlib/` (100 files — **identical gaps**).

## TL;DR

- **Member-level coverage on the high-traffic core types is strong.**
  Spot-checks on `String`, `Iterable`/`List`, `int`/`num`, plus
  `dart:math` constants (`pi`, `e`, `sqrt2`, `sqrt1_2`, `log2e`,
  `log10e`, `ln2`, `ln10`) and functions (`sin cos tan asin acos atan
  atan2 sqrt exp log pow max min`) all pass. The gaps are **whole
  missing classes**, not missing members on existing bridges.
- `characters` (the `.characters` getter on `String`) is correctly
  absent — it comes from the `characters` package, not `dart:core`.
- The mirror stdlib in `tom_d4rt_ast` has the **same 100 files and the
  same gaps**, so any additions must land in **both** trees (per the
  "keep tom_d4rt ↔ tom_d4rt_ast in sync" quest rule).

## Not a gap: relaxer false-alarms (already fixed)

The GEN-079 generator warnings (`No ClassInfo for generic base type
"FutureOr"/"StreamSubscription"/"StreamConsumer"/"StreamTransformer"/
"EventSink"`) were **relaxer** false-alarms, not stdlib gaps. Those
types are already bridged (`stdlib/async/stream.dart`), except
`FutureOr` which is a union type and can never be wrapped. Silenced in
`tom_d4rt_generator` 1.12.4 by extending the relaxer skip-set — see
`relaxer_sdk_generic_skip_test.dart`.

## Confirmed-missing classes (prioritized)

Priority reflects (a) how commonly scripts reach for the type and
(b) whether it fits the sandbox model. "Present" reference types listed
for contrast: error/exception bridges already shipped are
`Error`, `Exception`, `ArgumentError`, `RangeError`, `StateError`,
`FormatException`, `TimeoutException`, `UnimplementedError`,
`UnsupportedError` (+ dart:io/isolate: `FileSystemException`,
`SocketException`, `PathAccessException`, `PathExistsException`,
`PathNotFoundException`, `IsolateSpawnException`, `RemoteError`).

### P1 — high value, common, clear sandbox fit

| Type | Library | Why it matters |
|------|---------|----------------|
| ~~`Stopwatch`~~ ✅ bridged | dart:core | Ubiquitous for timing; pure, no I/O, trivial bridge. |
| ~~`LinkedHashSet`~~ ✅ bridged | dart:collection | Insertion-order set; common explicit type. |
| ~~`SplayTreeSet`~~ ✅ bridged | dart:collection | Sorted set; common explicit type. Its constructors take the optional `compare` function. |
| ~~`UnmodifiableMapView`~~ ✅ bridged | dart:collection | Returned by many APIs; scripts type against it. `Map.unmodifiable()` already produced this runtime type, so the mutating members delegate to the native view rather than intercepting — otherwise `on UnsupportedError` would stop catching. |
| ~~`UnmodifiableSetView`~~ ✅ bridged | dart:collection | Same, including the set algebra (`union`, `intersection`, `difference`). |
| ~~`StreamConsumer`~~ ✅ bridged | dart:async | Appears in bridged signatures (drove GEN-079). Interface only — no constructor. Registration alone was **not** enough: `StreamController.sink` hands out a `_StreamSinkWrapper` that reached no bridge at all, so the `StreamSink` bridge also had to claim that native name and gain the `addStream` it inherits from `StreamConsumer`. The hierarchy is declared through `BridgedClass.registerSupertypes` rather than an `isAssignable` closure, so `is` learns it without disturbing bridge dispatch. |
| ~~`NoSuchMethodError`~~ ✅ bridged | dart:core | Only `withInvocation` is bridged — the unnamed constructor is deprecated and throws. No `invocation` getter: the SDK keeps the captured Invocation private. |
| ~~`ConcurrentModificationError`~~ ✅ bridged | dart:core | One of only two entries the interpreter really did already throw SDK-shaped (the native list does the throwing), so registration alone made it catchable. |
| ~~`IndexError`~~ ✅ bridged | dart:core | The `RangeError` edge is declared via `BridgedClass.registerSupertypes`, not by widening any `isAssignable` — see the note below. |
| ~~`TypeError`~~ ✅ bridged | dart:core | `nativeNames: ['_TypeError']` — the private class the VM actually raises. The interpreter still reports failed casts as `RuntimeD4rtException`, so the bridge is currently reachable only for explicitly-thrown `TypeError`s. |
| ~~`AssertionError`~~ ✅ bridged | dart:core | `nativeNames: ['_AssertionError']`. As with `TypeError`, a failing interpreted `assert` still raises `RuntimeD4rtException`. |
| ~~`StackOverflowError`~~ ✅ bridged | dart:core | Arrives SDK-shaped today — runaway interpreted recursion blows the *host* stack, so the native error escapes. |
| ~~`OutOfMemoryError`~~ ✅ bridged | dart:core | Construct/catch only; nothing in the interpreter raises it. |

### P2 — useful, moderate frequency

| Type | Library | Notes |
|------|---------|-------|
| ~~`StreamView`~~ ✅ bridged | dart:async | Base for stream wrappers. Declares **no** `isAssignable`; `'StreamView'` is listed on the `Stream` bridge's `nativeNames` so instances keep the ~60-member `Stream` surface they inherit, with the `StreamView -> Stream` edge in the supertype registry. |
| ~~`AsyncError`~~ ✅ bridged | dart:async | Error+trace pair in stream/zone plumbing. Concrete, so it *can* carry an `isAssignable` without shadowing a more specific bridge — the one dart:async bridge that does. `implements Error` is registered so `on Error catch` sees it. |
| ~~`StreamTransformerBase`~~ ✅ bridged | dart:async | Base class for custom transformers. Registering it required broadening `Stream.transform` to wrap an interpreted `bind` in `StreamTransformer.fromBind`, and fixing two generic interpreter gaps: `is BridgedX` was hard-false for every interpreted operand, and `implements SomeBridge` was not a subtype edge at all. |
| `DoubleLinkedQueue` | dart:collection | Explicit deque type. |
| `BytesBuilder` | dart:typed_data | Efficient byte accumulation. |
| `JsonUtf8Encoder` | dart:convert | UTF-8 JSON in one pass. |
| `ClosableStringSink` | dart:convert | Sink variant. |
| ~~`UriData`~~ ✅ bridged | dart:core | `data:` URI parsing (`Uri.dataFromString`). Bridging it also surfaced a missing `Uri.data` getter, without which a parsed `data:` URI had no route to its payload. |

### P3 — niche or questionable sandbox fit (audit only, likely skip)

These are recorded as **intentional limitations** with a per-class rationale in
[d4rt_limitations.md § Intentionally-Unbridged SDK Classes](d4rt_limitations.md#intentionally-unbridged-sdk-classes),
which distinguishes the ones that *cannot* be honoured (`Zone`, `Expando`,
`WeakReference`, `Finalizer`) from the ones merely deferred until a consumer
appears (`Link`, `WebSocket`, `GZipCodec`/`ZLibCodec`, `MutableRectangle`).

| Type | Library | Reason to defer |
|------|---------|-----------------|
| `Expando` | dart:core | Identity side-tables; rare in scripts. |
| `WeakReference` | dart:core | GC semantics; unclear value in interpreter. |
| `Finalizer` | dart:core | GC callbacks; sandbox-hostile. |
| `Zone` | dart:async | Full zone API is large and cross-cutting. |
| `Link` | dart:io | Symlinks — behind `FilesystemPermission`. |
| `WebSocket` | dart:io | Behind `NetworkPermission`; larger surface. |
| `GZipCodec` / `ZLibCodec` | dart:io | Compression; add if a consumer needs it. |
| `MutableRectangle` | dart:math | `Rectangle` present; mutable variant rarely typed. |

## Notes on the error-type gap

The seven error types above are bridged as of `tom_d4rt` 1.17.0 /
`tom_d4rt_ast` 0.9.0, so `on <Type> catch (e)` clauses resolve and the
constructors the SDK exposes publicly work.

Two things the audit assumed turned out to be wrong, and both are worth
recording because they shape what "bridged" buys you:

**The interpreter does not throw SDK-shaped errors as broadly as assumed.**
Only `ConcurrentModificationError` and `StackOverflowError` really arrive as
native SDK errors (the native collection and the host stack do the throwing).
`list[9]`, a failing cast, a missing method on `dynamic` and a failing `assert`
all still surface as `RuntimeD4rtException`, so `on IndexError` / `on TypeError`
/ `on NoSuchMethodError` / `on AssertionError` cannot catch the *natural*
occurrence of those errors yet — only an explicit `throw`. Closing that is an
interpreter-side change, not a stdlib one.

**Catch-clause matching had two independent defects.** Both were fixed with the
bridges and both applied to every bridge, not just the error types:

- A bridged error constructed in script code (`throw StateError('x')`) arrives
  at the catch matcher as a `BridgedInstance`, while every type test there asks
  about the *native* type — so `on StateError` failed to catch a `StateError`
  the same script had just thrown. Matching now runs against an unwrapped
  native view; the catch variable is still bound to the `BridgedInstance`.
- Bridged matching compared the thrown value's own bridge against the catch
  type, an exact-identity test that cannot see that `_TypeError` is a
  `TypeError` or that an `IndexError` is a `RangeError`. The matcher now asks
  the catch type's `isAssignable` predicate first.

**Hierarchy is declared, not inferred.** Bridges are registered flat, so
`ErrorHierarchyCore` feeds the full `dart:core` error chain to
`BridgedClass.registerSupertypes`. That registry backs `isSubtypeOf` only —
deliberately not `isAssignable`, which is what `Environment.toBridgedInstance`
consults to decide which bridge *owns* a native object. Every hand-written
stdlib bridge carries `hierarchyDepth == 0`, so ties there break on
registration order, and a supertype claiming assignability for its subtypes
could quietly steal dispatch from the more specific bridge.

## Recommended next actions

1. **P1 is complete** — the pure classes (`Stopwatch`, the collection
   views/sets) and all seven catchable error types are bridged in both
   trees, each with tests under `tom_d4rt/test/stdlib/` and a
   registration-level mirror under `tom_d4rt_ast/test/runtime/`.
2. **P2 opportunistically** when a corpus script or bridged signature
   demands it. The three `dart:async` entries are now done; the four
   remaining (`DoubleLinkedQueue`, `BytesBuilder`, `JsonUtf8Encoder`,
   `ClosableStringSink`) still wait for a concrete consumer.
3. **P3: documented but unbuilt** — done; the rationale now lives in
   [d4rt_limitations.md](d4rt_limitations.md#intentionally-unbridged-sdk-classes).
   Several are sandbox-hostile by design and will stay out; the rest wait
   for a concrete consumer.

## Method / reproducibility

- Class inventory: `grep -rhoE "name: '[A-Za-z]+'"` across
  `stdlib/` gives every bridged class name.
- Gap probe: for each candidate SDK type `T`,
  `grep -rl "name: 'T'" stdlib/` — no hit ⇒ missing.
- Mirror parity: same probe under
  `tom_d4rt_ast/lib/src/runtime/stdlib/` returned identical results.
