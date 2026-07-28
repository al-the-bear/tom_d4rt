# D4rt stdlib — SDK gap audit

**Date:** 2026-07-07 (updated 2026-07-28)
**Interpreter version:** tom_d4rt (analyzer-based) + tom_d4rt_ast (mirror)
**SDK reference:** Dart 3.12.2 (package constraint `^3.5.0`)
**Scope audited:** all stdlib bridge files under
`tom_d4rt/lib/src/stdlib/` (114 files) and the mirror set under
`tom_d4rt_ast/lib/src/runtime/stdlib/` (114 files — **identical gaps**).
Class-level coverage is audited by hand; **member-level** coverage is
measured mechanically by `tom_d4rt/tool/stdlib_member_diff.dart` — see
"Member-level gaps" below.

## TL;DR

- **Gaps are member-level as well as class-level.** A mechanical member
  diff over all 180 registered classes
  (`tool/stdlib_member_diff.dart`) confirms **197 unreachable members
  spread across 39 classes** that this audit otherwise counts as
  bridged. Member-level coverage must therefore be measured, not
  spot-checked: a spot-check cannot distinguish a fully registered class
  from a **partially** registered one, because it passes as soon as it
  lands on a member that happens to be present. Shapes this actually
  takes in the stdlib:
  - **A partial constant set.** A class exposing 6 of its 16 unit
    constants answers `secondsPerMinute` and refuses
    `microsecondsPerDay`.
  - **One variant diverging from its siblings.** The nine typed lists
    that share `inheritedListMethods` behave alike; `Uint8List`
    hand-rolls its own maps, so it can silently gain or lose members
    the others don't have.
  - **A member that resolves on the supertype but not the subtype.**
    Set algebra works on a set *literal* while a `HashSet` reaches no
    adapter, because the interpreter's instance fallback is not uniform.
- **Round-trip breaks rank above missing classes.** A bridge that can
  *produce* a value it cannot then *read* is worse than an absent one,
  because the script only discovers it half-way through. The two
  mechanisms that cause this:
  - **Static members registered as instance getters.** Instance getters
    take `(visitor, target)`, static getters take `(visitor)`, and —
    unlike instance lookups — **the interpreter performs no fallback
    whatsoever for statics**. A class whose `static const` members went
    into the instance `getters` map registers, exports and analyses
    cleanly, and is inert. Put constants in `staticGetters`.
  - **A registered type with no registered producer.** If the sole
    factory that yields the type is a top-level function
    (`stdioType()`, `Uri.base`, …) and that function is never
    `define`d, the class is unreachable from *both* ends while looking
    completely bridged. When adding a class, check that something can
    hand a script an instance of it.
- `characters` (the `.characters` getter on `String`) is correctly
  absent — it comes from the `characters` package, not `dart:core`.
- The mirror stdlib in `tom_d4rt_ast` has the **same 100 files and the
  same gaps**, so any additions must land in **both** trees (per the
  "keep tom_d4rt ↔ tom_d4rt_ast in sync" quest rule).
- **A registered-but-unreachable class is its own failure mode.** Two
  `dart:convert` bridges had been written and exported but never passed
  to `defineBridge`, and `JsonUtf8Encoder` was reachable through a
  shipped `fuse` adapter with nothing registered under its name. Neither
  shows up as a missing *file* — only as a script that dies on a type it
  was legitimately handed. See the convert-hierarchy note below.

## Member-level gaps — how they are measured

`tom_d4rt/tool/stdlib_member_diff.dart` produces the member-level half of
this audit. Run it after any stdlib change:

```bash
cd tom_ai/d4rt/tom_d4rt
dart run tool/stdlib_member_diff.dart                    # markdown summary
dart run tool/stdlib_member_diff.dart --json out.json    # per-member detail
dart run tool/stdlib_member_diff.dart --no-verify         # candidates only, fast
```

It is **two-phase**, and both phases are load-bearing.

**Phase 1 — candidates.** Build a fully-registered `Environment`, then for
each `BridgedClass` compare its adapter-map keys against the SDK surface
of its `nativeType`, obtained through `dart:mirrors`.

**Phase 2 — verification.** Ask the *interpreter* whether each candidate
actually fails, using a per-class instance recipe (46 are defined) and
matching the error text against the known "unreachable" wordings
(`Undefined static member …`, `… has no instance method named …`,
`Undefined variable: …`, `… has no getter named …`). Anything else means
the member **resolved**.

**Why phase 2 cannot be skipped:** adapter-map absence does *not* imply
unreachable for *instance* members — instance lookups fall back through
the supertype chain. That fallback is **not uniform**, though
(`Uint8List.sort` resolved while `HashSet.difference` did not), so the
static diff cannot predict it either. Only the interpreter is a valid
oracle. In the current run, **156 of 618** raw candidates turn out to be
reachable via fallback — a 25 % false-positive rate that a single-phase
tool would report as gaps.

Two traps to respect when extending the tool, because either one yields
a plausible-looking wrong number:

1. **`ClassMirror.instanceMembers` omits abstract members.** It reports 6
   members for `Uri` (actual: 50) and 5 for `Map` (actual: 32) — so a
   diff built on it under-reports abstract-heavy types almost to zero.
   The tool walks `declarations` over the superclass chain plus
   superinterfaces instead.
2. **Absence from the adapter map is not evidence of unreachability** for
   instance members, and presence in the map is not evidence that the
   adapter *works*. Only executing the member through the interpreter
   settles either question.

Members with no usable instance recipe are reported in an explicit
**UNVERIFIED** bucket (265 in the current run, overwhelmingly `dart:io`
types that need a live socket or server to instantiate) rather than being
silently counted either way. Closing that bucket means adding recipes to
`_instanceRecipes`, not relaxing the classification.

### Current measured state

| Metric | Count |
|--------|-------|
| Bridged classes examined | 180 |
| Raw candidates from the map diff | 618 |
| … reachable anyway via instance fallback | 156 |
| … unverified (no instance recipe) | 265 |
| **CONFIRMED unreachable** | **197** |
| Classes with ≥ 1 confirmed gap | 39 |

| Class | Confirmed | Instance | Static | Assessment |
| --- | --- | --- | --- | --- |
| `LinkedList` | 27 | 27 | 0 | Genuine gap — the whole `Iterable` surface is missing; only 9 of 36 members bridged. Highest-value remaining item. |
| 10 × shared typed lists | 12 each | 12 | 0 | **Not a gap** — these are the length-*changing* `List` mutators (`add`, `insert`, `remove`, `clear`, …). A fixed-length list must refuse them. See the note below on the *error type*. |
| `SplayTreeMap` | 8 | 8 | 0 | Genuine gap — `update`, `updateAll`, `addEntries`, `map`, `cast`, `removeWhere`, plus the type's distinguishing `firstKeyAfter`/`lastKeyBefore`. |
| `Queue` / `ListQueue` | 4 / 2 | 3 / 2 | 1 / 0 | Genuine gap — the `removeWhere`/`retainWhere`/`remove` mutators. |
| `RangeError`, `ArgumentError`, `IndexError`, `Error` | 4, 1, 1, 1 | 0 | all | Genuine gap — the static validation helpers (`checkValidRange`, `checkNotNull`, `throwWithStackTrace`, …). |
| `Iterable`, `Queue`, `Map`, `Set`, `Converter`, `LineSplitter` | 1–3 | 0 | all | The `castFrom` family plus `iterableToShortString`/`iterableToFullString`. Low traffic. |
| `ByteBuffer` | 3 | 3 | 0 | The three SIMD views (`asFloat32x4List`, `asInt32x4List`, `asFloat64x2List`). Blocked on `Float32x4`/`Int32x4` themselves not being bridged. |
| `UnmodifiableListView` | 3 | 3 | 0 | Genuine gap — `indexWhere`, `lastIndexWhere`, `whereType`. |
| 4 × `Codec` (`Utf8`, `Ascii`, `Latin1`, `Encoding`) | 1 each | 1 | 0 | `decodeStream` — needs a `Stream<List<int>>`. |
| `Enum`, `Symbol`, `ProcessStartMode`, `String`, … | 1–2 | mixed | mixed | Long tail: `compareByIndex`/`compareByName`, `Symbol.empty`, `values`, `matchAsPrefix`. |
| `unawaited`, `FileSystemEntityType.NOT_FOUND` | 1 each | — | — | **Tool artifacts.** `unawaited` is a function, not a class, so its `Function` surface is diffed; `NOT_FOUND` is a deprecated SDK alias. |

**The typed-list residue is a wrong-error-type problem, not a gap.** The
120 entries are correct to fail — but they currently fail with
*"Bridged class 'Float32List' has no instance method named 'add'"* rather
than the SDK's `UnsupportedError`. A script that defensively writes
`try { … } on UnsupportedError { … }` therefore does not catch it. The fix
is the same one the `UnmodifiableMapView` note below describes: register
the member and let the native list raise, rather than leaving it
unregistered.

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
| ~~`DoubleLinkedQueue`~~ ✅ bridged | dart:collection | Explicit deque type. Its `DoubleLinkedQueueEntry` cursor is bridged alongside — without `firstEntry`/`lastEntry`/`forEachEntry` the type is just a slower `ListQueue` — and the cursor needs `nativeNames: ['_DoubleLinkedQueueElement']`, the private subclass those methods actually return. Registering it also pulled in a `DoubleLinkedQueue`/`ListQueue`/`Queue -> Iterable` supertype block that repaired the **already-shipped** `ListQueue` bridge, where `contains`/`join`/`where`/`map` had all failed outright and `q is Iterable` was false. |
| ~~`BytesBuilder`~~ ✅ bridged | dart:typed_data | Efficient byte accumulation. Abstract, with a factory that returns one of *two* private implementations — `_CopyingBytesBuilder` by default and `_BytesBuilder` under `copy: false` — so both names sit on `nativeNames`. It is the first bridge where a **constructor argument** selects which private class comes back; listing only the default would leave `BytesBuilder(copy: false)` constructible and broken on its first `addByte`. |
| ~~`JsonUtf8Encoder`~~ ✅ bridged | dart:convert | UTF-8 JSON in one pass. Not merely a coverage gap: the SDK **specialises** `JsonEncoder.fuse`, so `JsonEncoder().fuse(Utf8Encoder())` already returned a native `JsonUtf8Encoder` through the long-shipped `fuse` adapter — and then failed with `Undefined property or method 'convert' on JsonUtf8Encoder`. Bridging it closed a live dead end. Public and concrete, so it is the rare recent bridge that needs no `nativeNames`. |
| ~~`ClosableStringSink`~~ ✅ bridged | dart:convert | Sink variant. Abstract, so both routes to an instance return `_ClosableStringSink`. Reaching it the idiomatic way — `StringConversionSink.asStringSink()` — required registering `StringConversionSink` as well; see the convert-hierarchy note below. |
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

## Notes on the queue hierarchy

Bridging `DoubleLinkedQueue` exposed a gap that predated it. Because bridges
are registered flat and dispatch is per-bridge, a queue could not reach the
~30-member `Iterable` surface it inherits — and that was already true of the
shipped `ListQueue` bridge, where `.where`, `.map`, `.join` and even
`.contains` failed with "has no instance method named" and `q is Iterable`
was false. `contains` is the sharpest illustration: the `Queue` bridge has
always declared it, but a native `ListQueue` dispatches to the `ListQueue`
bridge, which did not.

`QueueHierarchyCollection` declares `DoubleLinkedQueue`/`ListQueue -> Queue`
and `Queue -> Iterable` to `BridgedClass.registerSupertypes`. That single
block both answers `is` correctly and lets the bridged-supertype walk find
the inherited members, instead of copying thirty adapters onto each queue
bridge.

The edges are deliberately **not** expressed by widening any `isAssignable`.
Beyond the ownership hazard described above, `Environment.toBridgedInstance`
collects *all* `isAssignable` matches and then uses
`transitiveSupertypeNames` to drop the ones that are supertypes of another
match — so feeding the registry makes dispatch strictly **more** exact. It is
what breaks the `DoubleLinkedQueue`/`Queue` tie deterministically rather than
by registration order, and it is why a deque is not mistaken for a
`ListQueue`.

The same treatment is still owed to the map and set bridges: `HashMap`,
`LinkedHashMap` and `SplayTreeMap` all answer `is Map` false, and `HashSet`
answers `is Iterable` false. Those are separate hierarchies needing their own
dispatch verification.

## Notes on the typed_data hierarchy

Bridging `BytesBuilder` surfaced the same class of gap one library over, but
in a milder form that is worth distinguishing. Every typed-data view answers
its `is` checks wrongly — `Uint8List.fromList([1,2,3]) is List` and
`is Iterable` are both **false** — and `TypedData` itself is not bridged at
all, so `d is TypedData` does not fail a type test but throws
`Undefined variable: TypedData`.

Unlike the queue case, the *members* are fine: each typed-data bridge
declares its ~40 inherited `List` members explicitly rather than relying on
a supertype walk, so `contains`, `join`, `where` and indexing all work. Only
the type tests are wrong. That is why `BytesBuilder` was bridged on its own
rather than dragging a hierarchy fix along with it — nothing is actively
broken, the explicit member lists are merely verbose. The proper repair needs
a `TypedData` bridge to exist first, since it is the shared supertype every
view would register against, and it is tracked separately.

`BytesBuilder` sits outside that hierarchy in any case: it is not a
`TypedData`, and its `toBytes`/`takeBytes` results route to the existing
`Uint8List` bridge unchanged.

## Notes on the convert hierarchy

Two findings came out of the `dart:convert` work that are worth recording
separately from the two classes the P2 row names.

**Two bridges were dead code.** `StringConversionConvert` and
`ChunkedConversionConvert` were fully written, exported from
`convert.dart`, and never passed to `defineBridge` — so no script could
name either one. That is not a cosmetic omission: `StringConversionSink`
is the argument every `Converter.startChunkedConversion` requires, so
with no way to construct one, the whole chunked-conversion surface of the
library was unreachable from interpreted code even though the adapters
for it had shipped. It is also the only idiomatic route to a
`ClosableStringSink`, via `asStringSink()`. Both are now registered.
The *class* of defect — a definition that exists and is exported but is
never registered — is worth a sweep across the other stdlib registrars.

**Registering the sink root needed hierarchy edges.** Giving
`ChunkedConversionSink` an `isAssignable` predicate makes it match
*every* sink in the library, because both `StringConversionSink` and
`ByteConversionSink` implement it. Since every one of those sinks is
handed back as a private class — `_StringCallbackSink`,
`_ByteCallbackSink`, `_ByteAdapterSink`, `_Utf8EncoderSink`,
`_Utf8StringSinkAdapter`, `_LineSplitterSink` — the direct-`Type` lookup
never fires and resolution always lands in the `isAssignable` pass, where
the root promptly swallowed its own subtypes:

    StringConversionSink.withCallback(...).asStringSink()
    // Bridged class 'ChunkedConversionSink' has no instance method
    // named 'asStringSink'.

The fix follows the `QueueHierarchyCollection` precedent: declare the
edges via `BridgedClass.registerSupertypes` (in
`convert/convert_hierarchy.dart`) so `_filterToMostSpecific` can drop the
supertype match, and give `ByteConversionSink` a predicate of its own so
the filter has a specific candidate to keep. This makes dispatch *more*
exact, not less.

**Still open — the codec/converter type tests.** `json is Codec`,
`utf8 is Codec`, `JsonEncoder() is Converter` and `utf8 is Encoding` all
answer `false`, because no edges connect the concrete codecs to their
abstract roots. Unlike the typed_data case above, the roots `Codec`,
`Converter` and `Encoding` *are* bridged, so nothing blocks the fix. It
is deferred on the same reasoning as the typed_data hierarchy: the
members all work, only the type tests are wrong, so it is filed rather
than fixed here.

## Notes on argument guards in hand-written bridges

The interpreter wraps any native failure inside an adapter into a
`RuntimeD4rtException` that names the class and the member, so a mistyped
argument already reads acceptably without the bridge doing anything:

```
Native error during static bridged method call 'parse' on UriData:
type 'int' is not a subtype of type 'String' in type cast
```

That wrapping does **not** cover two shapes, both found by probing the
`UriData` bridge's error surface rather than its happy path:

- **Too few arguments.** An adapter that opens with `positionalArgs[0]`
  throws a list `RangeError`, and the wrapped message is meaningless to a
  script author — `UriData.parse()` reports *"RangeError (length): Invalid
  value: Valid value range is empty: 0"*.
- **Too many arguments.** `UriData.parse('data:,a', 'extra')` returns the
  parsed value and silently discards the second argument, so a typo in a
  script is invisible.

The bridges written for SC5–SC9 guard both (see
[`byte_conversion.dart`](../lib/src/stdlib/convert/byte_conversion.dart)
for the style, and the `Timer` "arity guards" group for the test shape);
older ones largely do not. Nothing that works today breaks — the cost is
only a poor diagnostic on already-invalid code — and the shape is generic
to the hand-written stdlib, so the unit of work is a sweep rather than a
patch to any one bridge.

## Recommended next actions

1. **P1 is complete** — the pure classes (`Stopwatch`, the collection
   views/sets) and all seven catchable error types are bridged in both
   trees, each with tests under `tom_d4rt/test/stdlib/` and a
   registration-level mirror under `tom_d4rt_ast/test/runtime/`.
2. **P2 is complete** — the three `dart:async` entries,
   `DoubleLinkedQueue`, `BytesBuilder`, `JsonUtf8Encoder` and
   `ClosableStringSink` are all bridged in both trees, each with tests
   under `tom_d4rt/test/stdlib/` and a registration-level mirror under
   `tom_d4rt_ast/test/runtime/`.
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
