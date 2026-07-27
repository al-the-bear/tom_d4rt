# D4rt stdlib — SDK gap audit

**Date:** 2026-07-07
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
| `NoSuchMethodError` | dart:core | Thrown constantly; scripts want to `catch` it by type. |
| `ConcurrentModificationError` | dart:core | Thrown by collection iteration; catchable. |
| `IndexError` | dart:core | Subtype of `RangeError`; `RangeError.index` ctor. |
| `TypeError` | dart:core | Thrown on failed casts; catchable. |
| `AssertionError` | dart:core | Thrown by `assert`; catchable. |
| `StackOverflowError` | dart:core | Recursion guard; catchable. |
| `OutOfMemoryError` | dart:core | Catchable in principle. |

### P2 — useful, moderate frequency

| Type | Library | Notes |
|------|---------|-------|
| `StreamView` | dart:async | Base for stream wrappers. |
| `AsyncError` | dart:async | Error+trace pair in stream/zone plumbing. |
| `StreamTransformerBase` | dart:async | Base class for custom transformers. |
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

D4rt already **throws** the SDK-shaped errors at runtime (the
interpreter constructs real Dart error objects), so `catch (e)`
works today. What's missing is the ability to **catch by concrete
type** (`on NoSuchMethodError`) or **construct** these in script code,
because there's no `BridgedClass` registered for them. The P1 error
entries are therefore low-effort, high-payoff: register the class so
`on <Type>` clauses and constructors resolve. `IndexError` should be
registered as a subtype of `RangeError` to match the SDK hierarchy.

## Recommended next actions

1. **Batch P1 as one stdlib PR** (both trees, mirrored). Simple pure
   classes (`Stopwatch`, the collection views/sets) + the catchable
   error types. Add a round-trip test per new bridge under
   `tom_d4rt/test/stdlib/`.
2. **P2 opportunistically** when a corpus script or bridged signature
   demands it (e.g. `StreamView` surfaces in flutter-material
   signatures).
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
