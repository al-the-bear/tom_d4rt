# D4rt stdlib — SDK gap audit

**Date:** 2026-07-07 (updated 2026-09-03)
**Interpreter version:** tom_d4rt (analyzer-based) + tom_d4rt_ast (mirror)
**SDK reference:** Dart 3.12.2 (package constraint `^3.5.0`)
**Scope audited:** all stdlib bridge files under
`tom_d4rt/lib/src/stdlib/` (114 files) and the mirror set under
`tom_d4rt_ast/lib/src/runtime/stdlib/` (114 files — **identical gaps**).
Class-level coverage is audited by hand; **member-level** and
**hierarchy-level** coverage are both measured mechanically by
`tom_d4rt/tool/stdlib_member_diff.dart` — see "Member-level gaps" and
"Hierarchy gaps" below.

## TL;DR

- **Every gap recorded here carries a disposition, and adding a row means
  choosing one:** *Tracked* (it will be bridged — name the todo) or *Boundary*
  (it will not — move it to the
  [limitations doc](d4rt_limitations.md#intentionally-unbridged-sdk-classes)
  and pin it in `test/stdlib/intentionally_unbridged_test.dart`). A row with
  neither is a defect, because it leaves a script author unable to tell
  "deliberately out of scope" from "nobody has got to it yet". Read
  [the rule](#the-disposition-rule--read-this-before-adding-a-row) before
  adding to any table below.
- **Gaps come at three levels: class, member, and hierarchy.** A missing
  supertype *edge* is its own defect, distinct from a missing member and
  invisible to the member diff. It costs the entire inherited surface at
  once, makes `is` and `on` answer wrongly, and is one line to fix rather
  than N adapters — `LinkedList` fell from 27 unreachable members to 2 when
  its `-> Iterable` edge was declared, and those last two (`addAll`,
  `addFirst`, the only members that are LinkedList's own) were then written by
  hand, so the class now measures complete. A mechanical cross-reference over all
  180 classes (`--hierarchy`) opened at **35 missing edges across 23
  classes**, concentrated in `dart:convert`; the `dart:typed_data` and
  `dart:convert` blocks are now declared and the count stands at **4 edges
  across 3 classes** (`String`, `Duration`, `StreamController`). Read the
  hierarchy audit before treating any member-gap count as a work estimate.
- **Gaps are member-level as well as class-level.** A mechanical member
  diff over all 181 registered classes
  (`tool/stdlib_member_diff.dart`) confirms **36 unreachable members
  spread across 22 classes** that this audit otherwise counts as
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
oracle. In the current run, **315 of 616** raw candidates turn out to be
reachable via fallback — a 51 % false-positive rate that a single-phase
tool would report as gaps. That share has grown as edges were declared,
which is the point: every edge added moves candidates from "confirmed
gap" to "reachable anyway" without a line of adapter code being written.

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

Measured 2026-09-04.

| Metric | Count |
|--------|-------|
| Bridged classes examined | 181 |
| Raw candidates from the map diff | 616 |
| … reachable anyway via instance fallback | 315 |
| … unverified (no instance recipe) | 265 |
| **CONFIRMED unreachable** | **36** |
| Classes with ≥ 1 confirmed gap | 22 |

The **Disposition** column is not decoration — see
[the disposition rule](#recommended-next-actions). Every row must name where
its resolution lives, so that a row can never sit in the audit as an
unattributed observation.

| Class | Confirmed | Instance | Static | Assessment | Disposition |
| --- | --- | --- | --- | --- | --- |
| `Queue` / `ListQueue` | 4 / 2 | 3 / 2 | 1 / 0 | Genuine gap — the `remove`/`removeWhere`/`retainWhere` mutators, plus `Queue.castFrom`. | SCC10 |
| `RangeError`, `ArgumentError`, `IndexError`, `Error` | 4, 1, 1, 1 | 0 | all | Genuine gap — the static validation helpers (`checkValidRange`/`checkValidIndex`/`checkNotNegative`/`checkValueInInterval`, `checkNotNull`, `check`, `throwWithStackTrace`). | SCC11 |
| `Iterable`, `Map`, `Set`, `Converter`, `LineSplitter` | 3, 1, 1, 1, 1 | 0 | all | The `castFrom` family plus `iterableToShortString`/`iterableToFullString` and `LineSplitter.split`. Low traffic. | SCC10 / SCC11 |
| `ByteBuffer` | 3 | 3 | 0 | The three SIMD views (`asFloat32x4List`, `asInt32x4List`, `asFloat64x2List`). This row **understates the finding** — see [Notes on the SIMD block](#notes-on-the-simd-block); it is nine names, not three. | **Boundary** — [limitations doc](d4rt_limitations.md#intentionally-unbridged-sdk-classes) + `F-SCB29-1..4` |
| `SplayTreeMap` | 2 | 2 | 0 | `firstKeyAfter`, `lastKeyBefore` — the type's distinguishing ordered-navigation pair. | SCC50 |
| `Enum`, `Symbol`, `ProcessStartMode` | 2, 2, 1 | 0 | all | Statics: `compareByIndex`/`compareByName`, `Symbol.empty`/`unaryMinus`, `values`. | SCC11 |
| `String`, `StreamSubscription`, `ProcessSignal`, `InternetAddressType` | 1 each | 1 | 0 | Instance long tail: `matchAsPrefix`, `asFuture`, `signalNumber`, `name`. | SCC11 (`String.matchAsPrefix`: SCC56) |
| `unawaited`, `FileSystemEntityType.NOT_FOUND` | 1 each | — | — | **Tool artifacts.** `unawaited` is a function, not a class, so its `Function` surface is diffed; `NOT_FOUND` is a deprecated SDK alias. | SCC11 (suppress in the tool) |

**A supertype edge is worth ~25 adapters.** The largest en-bloc entries earlier
revisions of this table carried are gone, and almost none of them was fixed by
writing adapters. `LinkedList` fell from 27 confirmed gaps to 2, and
`SplayTreeMap` from 8 to 2, when `CollectionHierarchyCollection` gained their
`-> Iterable` and `-> Map` edges; `UnmodifiableListView` fell from 3 to 0 the
same way. That is the quantified case for auditing the hierarchy *before*
reading a member-gap count as a work estimate — a missing edge inflates the
member table by the whole inherited surface, and reading those rows as
"members to write" would have prescribed roughly 38 adapters where three
lines of registry were the actual fix.

The corollary is that a class the edges reduce to a small residue is usually
worth finishing by hand, because what survives an edge is exactly the set of
members the class does **not** inherit — its own. `LinkedList`'s residue was
`addAll` and `addFirst`, both of which `LinkedList` declares itself, and both
now bridged; the class measures complete and is no longer in the table.

**The typed-list mutators no longer appear here, and are no longer a
wrong-error-type problem either.** The 120 length-changing `List` mutators
(`add`, `insert`, `remove`, `clear`, …) on the ten shared typed lists are
correct to fail, and they now fail correctly: they resolve through the `-> List`
edge to the native fixed-length list, which raises the SDK's `UnsupportedError`,
so a script's `on UnsupportedError` catches it. Re-probed 2026-09-04 with
`Float32List(2).add(1.0)`. That is the resolution the `UnmodifiableMapView` note
below prescribes — register (or inherit) the member and let the native raise —
arrived at through the hierarchy edge rather than through 120 adapters.

### The other half of the diff: `extraBridged`

The tool also reports the opposite direction — members the *bridge* offers that
the mirror of the native type does not declare. **This is not a defect list**,
and reading it as one would delete correct bridges. Measured 2026-09-04, its 32
entries across 16 classes fall into three groups, and only the third is wrong:

| Group | Count | Entries | Verdict |
| --- | --- | --- | --- |
| Real Dart **extension** members | 15 | `firstOrNull`/`lastOrNull`/`singleOrNull`/`elementAtOrNull`/`indexed` on `Iterable` and `List`, `List.byName`, `Enum.name`, `Future.ignore`/`onError`, `Function.call` | **Correct** — the bridge is right and the oracle is blind |
| Declared conveniences | 13 | `FileSystemEvent.isCreate`/`isModify`/`isDelete`/`isMove`; `asUint8ListView` on the nine non-`Uint8List` typed lists | **Correct** — each is commented as deliberate at its definition |
| Fabricated members | 4 | `InternetAddressType.host`/`address`/`type`/`lookup` | **Defect** — see below |

**The oracle cannot see extension members**, because `dart:mirrors` reports
declarations on the type and an extension declares nothing on it. So every
extension member a bridge correctly offers arrives in `extraBridged`. Verify
before acting on an entry: `dart analyze` a one-liner using the member on the
native type. That is how the 15 above were cleared.

**`InternetAddressType` is the one real finding.** Its four extra members are
not merely absent from the SDK, they are wired to unrelated `Object` members —
`host` returns `.name`, `address` returns `.hashCode`, `type` returns
`.runtimeType`, `lookup` returns `toString()`. A script reading
`type.address` gets a hash code and no error. See
`lib/src/stdlib/io/socket.dart`.

**A member the SDK lacks is the one bridge defect no test can catch by
itself.** It makes every script that uses it pass here and fail to compile as
Dart, and nothing notices until the script moves. `LinkedList.removeFirst` was
such an entry — `Queue` has it, `LinkedList` does not — and removing it is why
the class no longer appears in `extraBridged`. Because deletion cannot be
protected by a passing assertion, the absence is pinned by a case that asserts
the `NoSuchMethodError`: `F-SCC8-5` in
`test/stdlib/collection/linked_list_test.dart`. Do the same for any convenience
removed from this list, or it will be reinstated by the next reader who assumes
the omission was an oversight.

## Hierarchy gaps — the supertype-edge audit

A missing supertype edge is a different defect from a missing member, and the
member diff cannot see it. It costs the *whole* inherited surface at once, it
makes `is` and `on` answer wrongly, and it is one line to fix rather than N
adapters. It also hides from the member diff entirely whenever the class has
no instance recipe. So it is asked directly:

```bash
dart run tool/stdlib_member_diff.dart --hierarchy
dart run tool/stdlib_member_diff.dart --hierarchy --no-verify   # static only, ~8 s
```

**Method.** For every bridged class, `dart:mirrors` walks the native type's
superclass chain and superinterfaces; each supertype that is *itself bridged*
is cross-referenced against `BridgedClass.transitiveSupertypeNames`. Anything
the SDK declares and the registry does not know is a candidate. Supertypes
with no bridge are skipped — the registry keys on a bridge name, so such an
edge would be unrepresentable, and a missing bridge is a different finding.
Comparison is by `originalDeclaration` mirror, not by raw `Type`: bridges
carry instantiated natives (`Queue<dynamic>`) while `superinterfaces` yields
whatever the declaration site wrote, and matching raw types would miss nearly
every edge.

**Candidates are then verified**, for the same reason the member diff
verifies its own: a static cross-reference over-reports badly. Each candidate
is driven through the interpreter as `o is Supertype` and kept only if the
answer is actually `false`. Measured 2026-07-28, after the convert
codec/converter edges were declared:

| Metric | Count |
|--------|-------|
| Bridged classes examined | 181 |
| … declaring `isAssignable` | 155 |
| … with ≥ 1 registered edge | 69 |
| Candidate edges from the cross-reference | 66 |
| … satisfied anyway via `isAssignable` | 0 |
| … unverified (no instance recipe) | 62 |
| **CONFIRMED missing edges** | **4** |
| Classes with ≥ 1 confirmed gap | 3 |

This table has now been measured three times, and the movement is worth
keeping because each step separates a *repair* from a change in what the audit
can see:

| Measurement | Candidates | Satisfied anyway | Unverified | Confirmed | Classes |
| --- | --- | --- | --- | --- | --- |
| Before the typed_data edges | 137 | 11 | 91 | 35 | 23 |
| After typed_data (SCB20 / SCC55) | 115 | 0 | 91 | 24 | 12 |
| After convert codecs (SCB23) | 66 | 0 | 62 | **4** | 3 |

- **35 → 24 confirmed** was the eleven typed-data `-> Iterable` edges;
  **24 → 4** is the twenty convert codec/converter edges. Those are the repairs.
- **Candidates fall faster than confirmed gaps** at each step, because the
  cross-reference only proposes an edge that is not already registered — so
  declaring an edge that was *already true by fallback*, or one that was merely
  *unverified*, also removes it from the candidate set. The 115 → 66 drop is 20
  confirmed plus 29 previously-unverified encoder/decoder edges that the same
  block covered.
- **11 → 0 satisfied-anyway.** Those eleven were exactly the typed lists'
  `-> List`: true via the `isAssignable` fallback, with no edge behind them.
  They are now backed by a declared edge, so they leave the candidate set by
  the previous bullet rather than by being counted here.

That satisfied-anyway bucket was the argument for running a verification pass
at all: published unverified, those eleven would have sent someone to fix
behaviour that already worked. It is empty now only because the edges were
declared for readability — the fallback that made them true is untouched.

### Confirmed gaps, by hierarchy

| Hierarchy | Classes | Missing edges | Members also lost? | Disposition |
| --- | --- | --- | --- | --- |
| `dart:core` comparables | `String`, `Duration` | `-> Comparable`, `-> Pattern` | Yes — `String.matchAsPrefix` | SCC56 |
| `dart:async` sinks | `StreamController` | `-> Sink` | No | SCC58 |

`StreamController` is the instructive row: it already carries
`-> EventSink`, `-> StreamConsumer` and `-> StreamSink`, and is missing only
`-> Sink`. Partial edge sets are the normal failure mode — whoever adds a
hierarchy declares the edges the failing test needed, and the rest stay
missing until something else trips over them.

The three `dart:convert` rows this table used to carry — codecs, converters
and the `Encoding` root — were closed by SCB23; see *Notes on the convert
hierarchy* below for what the fix had to get right beyond declaring the edges.

### The 62 unverified edges are the audit's own blind spot

Further classes carry candidate edges that could not be tested because
`_instanceRecipes` has no entry for them — most of `dart:io` (`Socket`,
`Stdout`, `IOSink`, `File`, `Directory`, the `FileSystemException` family)
and the numeric tower (`int`/`double`/`num`/`BigInt` `-> Comparable`). They
are reported as their own bucket rather than folded into either answer,
because both readings would be a guess.

The `dart:convert` encoder/decoder pairs used to be the largest group here,
and their fate is the argument for keeping the bucket separate rather than
resolving it by guess. SCB23 probed all eleven directly (they construct with
a no-argument constructor, which the audit's recipe table simply did not
know) and every one was missing its `-> Converter` edge, exactly as the same
shape suggested. But `LineSplitter` — in the same group, the same shape,
listed alongside them — is `extends StreamTransformerBase`, not a `Converter`
at all. Folding the bucket into "confirmed" would have declared one wrong
edge in twelve, which is a worse outcome than the gap: a false `is` answer
that becomes a confidently wrong `true`.

Closing that bucket means extending the recipe table, not writing probes —
the same rule the member diff follows. Some entries are deliberately hard:
the `dart:io` sockets and servers are omitted on purpose rather than have the
audit open listening ports, so those need a recipe that constructs without
binding, or an explicit "not auditable" marker.

**Disposition:** Tracked — SCC57 for these 62 edges, SCC12 for the 265
unverified members. Both buckets are measurement debt, not bridging decisions:
until they close, "confirmed" is a lower bound and no entry inside them can be
given a Boundary disposition, because nobody has established it is a gap.

### Why these are filed rather than fixed here

Each hierarchy needs its own dispatch verification — the SC7 queue case
showed that adding edges changes which bridge *owns* a native, and
`_filterToMostSpecific` can newly drop a match that used to win. Six
hierarchies across four libraries is not one change, and the edges must land
in both trees (`CollectionHierarchyCollection` and `ConvertHierarchyConvert`
are byte-identical between `tom_d4rt` and `tom_d4rt_ast` today; any new
registrar must stay that way). The audit's job is to make the list complete
and repeatable; the fixes are tracked in the **Disposition** column of the
confirmed-gaps table above — SCC56 for the `dart:core` singletons, SCC58 for
`StreamController -> Sink`. "Tracked separately" without naming the tracker is
what [the disposition rule](#the-disposition-rule--read-this-before-adding-a-row)
now forbids.

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
appears (`Link`, `WebSocket`, `GZipCodec`/`ZLibCodec`, `MutableRectangle`, the
SIMD block). Each row is pinned by a case in
[`intentionally_unbridged_test.dart`](../test/stdlib/intentionally_unbridged_test.dart),
so the table cannot silently go stale in the "someone bridged it" direction.

| Type | Library | Reason to defer | Disposition |
|------|---------|-----------------|-------------|
| `Expando` | dart:core | Identity side-tables; rare in scripts. | Boundary — cannot be honoured |
| `WeakReference` | dart:core | GC semantics; unclear value in interpreter. | Boundary — cannot be honoured |
| `Finalizer` | dart:core | GC callbacks; sandbox-hostile. | Boundary — cannot be honoured |
| `Zone` | dart:async | Full zone API is large and cross-cutting. | Boundary — cannot be honoured |
| `Link` | dart:io | Symlinks — behind `FilesystemPermission`. | Deferred |
| `WebSocket` (+ `WebSocketTransformer`, `WebSocketException`, `WebSocketStatus`, `CompressionOptions`) | dart:io | Behind `NetworkPermission`; larger surface. | Deferred **and** scoped as SCC63 — see below |
| `GZipCodec` / `ZLibCodec` | dart:io | Compression; add if a consumer needs it. | Deferred |
| `MutableRectangle` | dart:math | `Rectangle` present; mutable variant rarely typed. | Deferred |
| The SIMD block (9 names) | dart:typed_data | Correct but pointless through an interpreter — see [Notes on the SIMD block](#notes-on-the-simd-block). | Deferred |

**`WebSocket` is the one name that legitimately carries two records, and that
is deliberate rather than an oversight.** It sits in the limitations table
*and* has scoped work in SCC63, because the two serve different readers: a
script author who hits `Undefined variable: WebSocket` needs to know the
absence is known, and a developer needs the block's scope and its permission
posture. The rule below permits this — what it forbids is a name with
*neither* record. The 2026-09-03 reconciliation also widened the limitations
row from `WebSocket` alone to all five names in the block, since the other
four failed identically and pointed the reader nowhere.

## Notes on the error-type gap

The seven error types above are bridged as of `tom_d4rt` 1.17.0 /
`tom_d4rt_ast` 0.9.0, so `on <Type> catch (e)` clauses resolve and the
constructors the SDK exposes publicly work.

Several things the audit assumed turned out to be wrong, and all are worth
recording because they shape what "bridged" buys you:

**The interpreter did not throw SDK-shaped errors as broadly as assumed.**
Only `ConcurrentModificationError` and `StackOverflowError` arrived as native SDK
errors from the bridges alone (the native collection and the host stack do the
throwing). `list[9]`, a failing cast, a missing method on `dynamic` and a failing
`assert` surfaced as `RuntimeD4rtException`, so `on TypeError` /
`on NoSuchMethodError` / `on AssertionError` could not catch the *natural*
occurrence of those errors — only an explicit `throw`. That was an
interpreter-side gap, not a stdlib one, and it is closed as of `tom_d4rt` 1.23.0
/ `tom_d4rt_ast` 0.15.0: the raise sites now produce `TypeError` (a failing `as`,
and `!` on null), `NoSuchMethodError` (a final member-lookup failure),
`AssertionError` (a failing `assert`, statement or constructor initializer) and
`RangeError` (a list index out of range).

**A list index raises `RangeError`, not `IndexError`** — measured against the
platform while closing the gap above, and it contradicts the obvious reading of
the P1 table. `IndexError` is a `RangeError` subtype and looks like the better
fit, but the VM's `List.[]` does not use it and `on IndexError` does **not**
catch an out-of-range list access. Raising `IndexError` would make d4rt strictly
*more* catchable than Dart, so a script written against d4rt with `on IndexError`
would break once compiled. The `IndexError` bridge is still needed — a script can
name the type and `IndexError.withLength(...)` works — but it is not what an
interpreted `list[9]` produces, and the `IndexError -> RangeError` supertype
registration is what makes `on RangeError` catch what the index sites raise.

**Errors thrown by a native callee were already fine.** `'abc'[9]`, `[].first`,
`int.parse('zz')` and `sublist(0, 9)` were catchable by `on RangeError` /
`on StateError` / `on FormatException` inside a script before any of this work —
the interpreter does not wrap what a native callee throws. The wrapping is
confined to the *host* boundary, where `execute()`'s catch-all still relabels a
native SDK exception as `Unexpected error: ...`; that remaining asymmetry is
tracked as SCC27.

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

`CollectionHierarchyCollection` declares `DoubleLinkedQueue`/`ListQueue ->
Queue` and `Queue -> Iterable` to `BridgedClass.registerSupertypes`. That
single block both answers `is` correctly and lets the bridged-supertype walk
find the inherited members, instead of copying thirty adapters onto each
queue bridge.

The edges are deliberately **not** expressed by widening any `isAssignable`.
Beyond the ownership hazard described above, `Environment.toBridgedInstance`
collects *all* `isAssignable` matches and then uses
`transitiveSupertypeNames` to drop the ones that are supertypes of another
match — so feeding the registry makes dispatch strictly **more** exact. It is
what breaks the `DoubleLinkedQueue`/`Queue` tie deterministically rather than
by registration order, and it is why a deque is not mistaken for a
`ListQueue`.

The same treatment was subsequently extended to the rest of `dart:collection`,
which is why the registrar is named for the library rather than for queues:
the maps (`-> Map`), the four set types (`-> Set, Iterable`),
`UnmodifiableListView` (`-> List, Iterable`), `Set`/`List`/`Queue`
(`-> Iterable`) and `LinkedList` (`-> Iterable`) all carry edges now. The
mechanical hierarchy audit below finds no remaining `dart:collection` gap.

## Notes on the typed_data hierarchy

**Closed in `tom_d4rt` 1.25.0 / `tom_d4rt_ast` 0.17.0.** The section is kept
because the three symptoms behaved differently from one another, and the
reason they did is the clearest worked example of how `isSubtypeOf` actually
resolves.

Bridging `BytesBuilder` surfaced the same class of gap one library over.
Measured before the fix, across all eleven views:

| Type test | Answer before | Why |
| --- | --- | --- |
| `d is TypedData` | **threw** | `TypedData` was not bridged at all — `Undefined variable: TypedData` |
| `d is Iterable` | **false** | no registered edge, and `Iterable`'s bridge carries no predicate |
| `d is List` | **true** | no edge either, but the `isAssignable` fallback answered it |

The third row is the instructive one. `BridgedClass.isSubtypeOf` falls back to
asking the *target's* `isAssignable` about the native value (GEN-075), and a
`Uint8List` genuinely satisfies the `List` bridge's `(v) => v is List`
(GEN-C3c). `Iterable` carries no predicate at all, which is the entire reason
the two answers differed.

The first row is worse than a wrong answer. `is` is total in Dart, so a script
may reasonably assume the question cannot fail; a throw from a type test is a
different failure mode from `false`, and it is why the root had to be bridged
before any edge could be declared.

An earlier revision of this section reported `is List` as false too. That was
not the code moving underneath the document: the fallback shipped in GEN-081
(2026-03-02) and the `List` predicate in GEN-C3c (2026-05-04), both well
before the reading was recorded, in both trees. It was simply wrong when
written — which is the argument for the mechanical audit above over a hand
spot-check.

**The repair.** `TypedDataTypedData` bridges the root, and
`TypedDataHierarchyTypedData` declares `-> TypedData, List, Iterable` on the
eleven views and `-> TypedData` on `ByteData`. Two decisions in it are worth
carrying forward:

- **The root deliberately has no `isAssignable`.** That predicate decides
  which bridge *owns* a native in `Environment.toBridgedInstance`, and every
  hand-written stdlib bridge sits at `hierarchyDepth == 0` — a root claiming
  `(v) => v is TypedData` would compete with the eleven views and `ByteData`
  for every typed buffer in the system. The registry walk answers
  `is TypedData` without it. `Iterable` is bridged the same way and for the
  same reason; `Queue` carries a predicate only because it is also directly
  constructible.
- **`-> List` is declared even though it already answered true.** It changes
  no behaviour. It means the hierarchy reads correctly on its own terms
  instead of depending on the `List` bridge keeping a predicate it is under
  no obligation to keep.

The *members* were never affected: each typed-data bridge declares its ~40
inherited `List` members explicitly rather than relying on a supertype walk,
so `contains`, `join`, `where` and indexing all worked throughout. Only the
type tests were wrong. That is why `BytesBuilder` was bridged on its own
rather than dragging a hierarchy fix along with it. Now that the edges exist
those explicit lists are redundant, but pruning them is a separate change with
its own dispatch verification — they are what makes the surface work today.

`BytesBuilder` sits outside the hierarchy in any case: it is not a
`TypedData`, and its `toBytes`/`takeBytes` results route to the existing
`Uint8List` bridge unchanged. `ByteBuffer` is likewise absent — both look like
they belong, and neither implements the interface.

## Notes on the SIMD block

The `ByteBuffer` member row above reads "3 confirmed gaps", and read on its own
it suggests three missing methods on an otherwise complete class. It is nine
names, and they are one decision rather than nine oversights.

Measured 2026-09-03, `tom_d4rt` working tree:

| Written by a script | What it reports |
| --- | --- |
| `Float32x4(1, 2, 3, 4)` | `Undefined variable: Float32x4` |
| `Int32x4(1, 2, 3, 4)` | `Undefined variable: Int32x4` |
| `Float64x2(1, 2)` | `Undefined variable: Float64x2` |
| `Float32x4List(2)` | `Undefined variable: Float32x4List` |
| `Int32x4List(2)` | `Undefined variable: Int32x4List` |
| `Float64x2List(2)` | `Undefined variable: Float64x2List` |
| `buf.asFloat32x4List()` | `Bridged class 'ByteBuffer' has no instance method named 'asFloat32x4List'.` |
| `buf.asInt32x4List()` | `Bridged class 'ByteBuffer' has no instance method named 'asInt32x4List'.` |
| `buf.asFloat64x2List()` | `Bridged class 'ByteBuffer' has no instance method named 'asFloat64x2List'.` |

**Two failure modes, and the split is not arbitrary.** The six classes are not
registered at all, so they fail in the environment lookup with the same
`Undefined variable` every unbridged class produces. `ByteBuffer` *is* bridged
— only these three of its members are absent — so they fail one layer further
in, as a `D4rtNoSuchMethodError`. A reader who arrives from the second message
would find nothing by grepping the limitations doc for `Undefined variable`,
which is why that doc's preamble now names the exception explicitly.

SCB30 widened that split rather than closing it. The lookup half now carries its
reason inline — `Undefined variable: Float32x4 (not bridged: …; see
doc/d4rt_limitations.md)` — so those six names no longer need the reader to
suspect a limitations doc exists. The member half still reports the bare
`has no instance method named 'asFloat32x4List'`: that failure is keyed on a
class and a member rather than on a bare identifier, so it cannot consult the
same map. SCC91 tracks giving it the equivalent.

**Why the three lists matter to the count.** The audit previously recorded only
the scalars, and that is the harder half to notice: `Float32x4List`,
`Int32x4List` and `Float64x2List` are typed-data views, structurally identical
to the eleven views that *are* bridged and that the hierarchy section above
goes to some length to get right. Their absence therefore reads as a hole in
that set rather than as this decision — the exact ambiguity the disposition
rule exists to remove.

**Why bridging them is correct and pointless.** SIMD's entire reason to exist
is throughput: four lanes through one machine instruction. Through the
interpreter every lane operation is a bridge crossing, so a bridged
`Float32x4` multiply costs strictly more than the four scalar `double`
multiplies it would replace. The API would be faithful and every script using
it would be slower than the code it was written to improve.

**Deferred, not refused.** Nothing in the semantics resists bridging — no
identity, no GC timing, no sandbox concern, unlike the `Expando`/`Finalizer`
group. A consumer that wants the *API* (porting existing code that names these
types) rather than the *throughput* can have it; there is simply no such
consumer today. The eleven non-SIMD typed lists cover the buffer work scripts
actually do, which `F-SCB29-4` anchors so the block above reads as a decision
rather than as `dart:typed_data` being broken.

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

The fix follows the `CollectionHierarchyCollection` precedent: declare
the edges via `BridgedClass.registerSupertypes` (in
`convert/convert_hierarchy.dart`) so `_filterToMostSpecific` can drop the
supertype match, and give `ByteConversionSink` a predicate of its own so
the filter has a specific candidate to keep. This makes dispatch *more*
exact, not less.

**The codec/converter half is now declared too.** `convert_hierarchy.dart`
originally covered only the **sink** half of the library, so `utf8 is Codec`,
`utf8 is Encoding` and `JsonEncoder() is Converter` all answered `false` —
20 confirmed edges across nine classes, plus 29 unverified across eleven
encoder/decoder/codec classes, the largest single block the hierarchy audit
found. All 49 are declared; the audit's confirmed count fell 24 → 4 and the
`dart:convert` rows left the by-hierarchy table. Three things about that fix
are not obvious from the diff.

**The edge alone did not restore `decodeStream`.** This was the block's one
real member loss — unlike the typed_data hierarchy, which was purely cosmetic
because every view declares its inherited `List` surface explicitly. But
`Encoding` is declared on `Encoding` in the SDK *and the `Encoding` bridge did
not declare an adapter for it either*, so giving `Utf8Codec` its `-> Encoding`
edge would have made the supertype walk find nothing. The edge and the new
`EncodingConvert` adapter are one change, and each is useless alone.

That adapter also has to cast per chunk. `Stream.cast<List<int>>()` looks like
the obvious conversion and is wrong: the interpreter hands over a `Stream`
whose elements are `List<Object?>`, and casting the *element* to `List<int>`
throws on the first chunk. Each chunk needs its own `cast<int>()`, which is
what the single-shot `decode` adapter beside it already does to its one list.

**The edges are written as a flattened closure, and that is load-bearing.**
`BridgedClass.isSubtypeOf` consults the registry for a class's direct
supertypes and **one further hop**, not the full transitive closure. So
`JsonEncoder -> Converter`, `Converter -> StreamTransformerBase` and
`StreamTransformerBase -> StreamTransformer` (the last already declared by
`dart:async`) would still answer `JsonEncoder() is StreamTransformer` =>
`false` at three hops. The member walk, `transitiveSupertypeNames`, *is* fully
transitive. The two mechanisms therefore disagree about depth, and a minimal
edge set gives correct member resolution with wrong type tests — the failure
mode hardest to spot by reading the registry, since the block looks complete.
Every existing hierarchy block flattens for this reason; unifying `isSubtypeOf`
on `transitiveSupertypeNames` would remove the requirement and is tracked
separately.

**`LineSplitter` is not a `Converter`.** The SDK declares
`final class LineSplitter extends StreamTransformerBase<String, String>`. It
carries `convert` and `startChunkedConversion` of its own, which is what makes
the wrong edge tempting, and the todo that commissioned this work listed it
among the classes needing `-> Converter`. The mechanical `--hierarchy` audit
had it right and the hand-written list did not — a standing argument for
letting the tool, not a reading of the library, decide the edge set.

**Dispatch was checked and could not have moved here.** Each hierarchy needs
its own verification because adding edges changes which bridge *owns* a native
(the SC7 queue case). For this block the answer is structural rather than
empirical: `Codec`, `Converter` and `Encoding` declare no `isAssignable`, so
they never enter `_filterToMostSpecific`'s match list in the first place and
cannot lose or steal a dispatch. The full `dart:convert` suite and the SC9
sink-routing cases are green regardless.

## Notes on the `dart:io` re-export surface

`dart:io` is unusual among the bridged libraries: it does not only declare
its own classes, it **re-exports 32 names** it does not own —
30 from `dart:_http`, plus `BytesBuilder` and `HttpStatus` from
`dart:_internal` (SDK `sdk/lib/io/io.dart`). Those names are part of what
`import 'dart:io'` promises a script, so they belong in this audit even
though no `dart:io` class declares them.

**How name visibility actually works here**, because it is easy to assume
otherwise: bridges live in **one flat environment**. An `import` decides
whether a *registrar runs* — it does not scope which names a script may
then see. So there is no per-library aliasing step in which a re-export
could be lost, and no re-export table to build. Once `TypedDataStdlib` has
run, `Uint8List` is visible whether the script imported `dart:typed_data`,
`dart:io`, or nothing at all. Imports still gate the **lazy** registrars
(collection, convert, math, io, isolate), which is why
`import 'dart:io'; LineSplitter()` correctly fails — matching real Dart,
which imports but does not re-export `dart:convert`. `CoreStdlib`,
`AsyncStdlib` and `TypedDataStdlib` are eager (see GEN-106), so their names
need no import.

Measured against a live environment, the 32 names split three ways:

| Shape | Count | Names |
| ----- | ----- | ----- |
| Bridged as a real type | 9 | `HttpClient`, `HttpClientRequest`, `HttpClientResponse`, `HttpServer`, `HttpHeaders`, `HeaderValue`, `ContentType`, `Cookie`, `BytesBuilder` |
| Resolves as a callable, not a type | 4 | `HttpClientCredentials`, `HttpClientBasicCredentials`, `HttpClientBearerCredentials`, `HttpClientDigestCredentials` |
| Not reachable at all | 19 | `HttpDate`, `BadCertificateCallback`, `HttpOverrides`, `WebSocketStatus`, `CompressionOptions`, `WebSocketTransformer`, `WebSocket`, `WebSocketException`, `HttpConnectionsInfo`, `HttpSession`, `SameSite`, `HttpRequest`, `HttpResponse`, `HttpClientResponseCompressionState`, `HttpConnectionInfo`, `RedirectInfo`, `HttpException`, `RedirectException`, `HttpStatus` |

The 19 are a **bridging** gap, not a re-export gap — those classes are
bridged nowhere in either tree. Two consequences are worth naming because
they are worse than a plain missing name:

- **`HttpServer` yields values a script cannot name.** The server is
  bridged; `HttpRequest` and `HttpResponse` are not. A script can start a
  server but has no type for what it hands back.
- **`on HttpException catch` fails silently.** An unresolved type in a
  catch clause does not raise — the clause simply never matches, so the
  handler is dead code that looks correct.

The four callable-shaped credentials are registered with
`environment.define(..., NativeFunction(...))` rather than `defineBridge`.
Calling them works, which is the common script use (hand credentials to an
`HttpClient`). Using them as *types* does not: `x is
HttpClientBasicCredentials` **invokes** the callable and throws *"requires
username and password arguments"*, while the zero-arity
`HttpClientCredentials` answers a silent, always-wrong `false`. An audit
that probes reachability with `.toString()` cannot see any of this — every
name in scope answers `toString()` — which is why the counts above are
taken from registration shape and `is`, not from name resolution.

**Disposition: all 23 names are Tracked**, and the four todos partition the 19
exactly — no name is in two, none is in none:

| Names | Count | Tracked as |
| ----- | ----- | ---------- |
| `HttpException`, `RedirectException`, `HttpStatus` | 3 | SCC61 — the silent-catch failure, so highest priority |
| `HttpRequest`, `HttpResponse`, `HttpSession`, `HttpConnectionInfo`, `HttpConnectionsInfo`, `SameSite` | 6 | SCC62 — makes the already-bridged `HttpServer` usable |
| `WebSocket`, `WebSocketTransformer`, `WebSocketException`, `WebSocketStatus`, `CompressionOptions` | 5 | SCC63 — **also** has a limitations row; see the note under [P3](#p3--niche-or-questionable-sandbox-fit-audit-only-likely-skip) |
| `HttpDate`, `HttpOverrides`, `BadCertificateCallback`, `RedirectInfo`, `HttpClientResponseCompressionState` | 5 | SCC65 — the client-side leftovers |
| The four credentials names | 4 | SCC64 — registered, but as callables rather than types |

Pinned by [`io_reexport_visibility_test.dart`](../test/stdlib/io/io_reexport_visibility_test.dart)
and its registration-level mirror
`tom_d4rt_ast/test/runtime/stdlib_io_reexport_visibility_test.dart`. Both
deliberately pin only the working surface: asserting today's behaviour for
the 19 missing names or the broken `is` would create assertions to delete
rather than repair once they are fixed.

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
older ones largely do not.

**The two halves resolved differently, and the reason is worth carrying
forward.** The too-few half is *recognisable at the dispatch site*: a list
`RangeError` whose reported range is exactly `0..positional.length - 1` can
only have come from an adapter indexing its own argument list past the end.
`D4.describeArityError` tests that shape and returns a real message —
*"UriData.parse expects at least 1 positional argument, but was called with
0."* — which the interpreter's catch-all substitutes for the "Native error
during …" wrapping. One check covers all ~601 unguarded adapters in each
tree, rather than 1202 copies of the same three lines.

The too-many half has no such signature. Extra arguments produce no error at
all — the adapter simply never reads them — so nothing reaches a catch-all to
be recognised, and the only fix is a per-adapter length check. That half
remains a sweep (tracked as SCC85) and is genuinely a patch to every bridge.
Nothing that works today breaks in either case; the cost is a poor diagnostic
on already-invalid code, and for the too-many half, silence.

## Recommended next actions

### The disposition rule — read this before adding a row

**Every gap this audit records must name where its resolution lives.** A row
is allowed exactly two kinds of record, and adding a row means choosing one:

- **Tracked** — it will be bridged. Name the todo id in the row's
  **Disposition** column. The audit's job for that row is done; the todo owns
  it from there.
- **Boundary** — it will not be bridged. Move it into the
  [limitations doc's intentionally-unbridged tables](d4rt_limitations.md#intentionally-unbridged-sdk-classes)
  with its justification, add a case to
  `tom_d4rt/test/stdlib/intentionally_unbridged_test.dart`, and cite that case
  id in the Disposition column.

**A row with neither record is the defect this rule exists to remove**, and it
is not a hypothetical one. Prose alone cannot catch it: the limitations tests
pin the list in one direction only — bridge `Expando` and `F-SC11-2` fails,
forcing the row out of the doc — but nothing fires when a class is examined,
declined, and simply never written down. The reader who then hits
`Undefined variable: <it>` cannot tell *deliberately out of scope* from
*nobody has got to it yet*, which is the entire distinction the limitations
section exists to draw.

The honest pin would be a test asserting that the unbridged set equals the
doc's table. There is no enumerable "set of SDK classes" to compare against
without an analyzer pass over the SDK, and hard-coding the expected set is
this document again in Dart syntax — it rots identically, and now in two
places. So the guarantee is procedural: it holds because filling in a
Disposition is part of adding a row, not because a test catches the omission.

**The rule forbids the empty case, not the double one.** A name may legitimately
carry both records — see `WebSocket` under P3, which needs a limitations row
for the script author who hits the error *and* a tracked todo for the developer
who will build the block. Requiring strict exclusivity would delete the row the
script author needs the moment work is scheduled, which is exactly backwards.

**Worked example of the failure.** The `dart:typed_data` SIMD block sat
unbridged, untracked and undocumented — nine names in the "neither" state,
reachable from no document. It went unmissed because the audit's own
`ByteBuffer` row recorded three missing *members* and never connected them to
the six missing *classes* that produced them. It is now Boundary, with
[its own section](#notes-on-the-simd-block) and `F-SCB29-1..4`.

### Status by tier

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
4. **The hierarchy gaps are nearly closed** — 4 confirmed missing edges
   remain, none of them in `dart:convert`. The blocks were filed per
   hierarchy rather than as one change, because each alters bridge
   *ownership* and needs its own dispatch verification; `dart:typed_data`
   (11 edges) and `dart:convert` (20 edges, plus the `Encoding.decodeStream`
   adapter) are both closed. What is left is three unrelated singletons:
   `String -> Comparable, Pattern`, `Duration -> Comparable`, and
   `StreamController -> Sink`. Small enough to take as one change, but the
   dispatch check still applies per class.
5. **Close the audit's blind spot** — 62 candidate edges and 265 candidate
   members sit UNVERIFIED for want of an instance recipe, most of
   `dart:io` among them. Until that table is extended, "confirmed" is a
   lower bound on both audits, not a total. `dart:convert` is the worked
   example of why this matters in both directions: SCB23 probed eleven
   unverified encoder/decoder pairs by hand and every one was a real gap —
   but the twelfth candidate of the same shape, `LineSplitter`, was not.
6. **`dart:io`'s re-export surface is 19 names short** — the whole
   `dart:_http` server/WebSocket block plus `HttpStatus`, none of them
   bridged anywhere. Highest value per unit of work is `HttpException` +
   `HttpStatus` (small, and `on HttpException catch` currently fails
   *silently*); the `HttpRequest`/`HttpResponse`/`HttpSession` block is
   what makes the already-bridged `HttpServer` usable. Separately, the
   four credentials names need converting from `NativeFunction` to real
   bridges so they work as types.

## Method / reproducibility

Both audits are mechanical and share one entry point. Neither reads the
bridge *sources*: they read a live `Environment` after every
`*Stdlib.register()`, so lazily-built and aliased registrations are counted
exactly as a script would see them.

```bash
# Member-level gaps — which members can no script reach? (~2 min)
dart run tool/stdlib_member_diff.dart [--json out.json] [--no-verify]

# Hierarchy gaps — which bridged supertype has nobody declared? (~2 min)
dart run tool/stdlib_member_diff.dart --hierarchy [--json out.json] [--no-verify]
```

`--no-verify` skips the interpreter pass and prints raw candidates. It is
fast (~8 s) and useful while iterating, but its numbers are **not** gap
counts — 115 candidate edges verify down to 24, and 620 candidate members to
163. Never publish a `--no-verify` figure.

Coverage is bounded by `_instanceRecipes` in the tool: a class with no recipe
is reported UNVERIFIED, never as a gap. Extend that table rather than writing
one-off probes — that is what makes the next bridge covered automatically.

**The measurement is repeatable; the transcription into this document is not.**
Every figure above was produced by a run and then typed here by hand, so a
bridging fix silently invalidates whichever figures it touched — the four
`Codec` `decodeStream` rows described a gap that SCB23 had already closed, and
nothing would have said so. Re-run both modes before trusting a number for
planning, and treat a row's figures as "true when written" rather than
"true now". SCC89 tracks giving this a trigger instead of a convention.

- **Class inventory**, if a source-level list is wanted rather than the live
  registry: `grep -rhoE "name: '[A-Za-z]+'"` across `stdlib/`.
- **Mirror parity**: the tool is `tom_d4rt`-only, since it needs
  `dart:mirrors` and `tom_d4rt_ast` must stay dependency-free. Parity is
  checked by diffing the registrars directly — `collection_hierarchy.dart`,
  `convert_hierarchy.dart` and `typed_data_hierarchy.dart` are byte-identical
  between the trees apart from the import line, so the findings transfer.
