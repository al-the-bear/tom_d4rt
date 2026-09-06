# D4rt stdlib — SDK gap audit

**Date:** 2026-07-07 (updated 2026-09-04)
**Interpreter version:** tom_d4rt (analyzer-based) + tom_d4rt_ast (mirror)
**SDK reference:** Dart 3.12.2 (package constraint `^3.5.0`)
**Scope audited:** all stdlib bridge files under
`tom_d4rt/lib/src/stdlib/` (117 files). The mirror set under
`tom_d4rt_ast/lib/src/runtime/stdlib/` holds the same 117 files with none
missing either way, but only **88 of them are verified identical** once the
import line is normalised — 29 diverge and have not been reviewed, so
"the findings transfer" is an assumption about those 29 rather than a
measurement (scd49).
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
  183 classes (`--hierarchy`) opened at **35 missing edges across 23
  classes**, concentrated in `dart:convert`; every block — `dart:typed_data`,
  `dart:convert`, `dart:core`, `dart:io` and `dart:isolate` — is now declared,
  and the count stands at **0 confirmed edges and 0 unverified**. That count
  went *up* before it came down — adding instance recipes let the audit measure
  classes it had been reporting as unverified — so read
  [the movement table](#hierarchy-gaps--the-supertype-edge-audit) rather than
  the number, and read the hierarchy audit before treating any member-gap count
  as a work estimate.
- **Member-level gaps stand at 13 across 7 classes, and the fall from 231 is
  what closing the last hierarchy block bought.** A mechanical member diff over
  all 183 registered classes (`tool/stdlib_member_diff.dart`) once confirmed
  only 3 — `ByteBuffer`'s SIMD views, *Boundary* by decision — because every
  `dart:io` and `dart:isolate` class lacked an instance recipe and so was
  reported UNVERIFIED rather than counted. Adding those recipes moved 228
  members from "never executed" to "measured, and unreachable"; declaring the
  `dart:io` supertype edges then moved 218 of those to *reachable*, because they
  were `Stream` and `IOSink` members on stream- and sink-shaped classes that
  simply had no edge to inherit through. **The count rose without a single
  member being un-bridged, and fell without a single adapter being written** —
  which is the clearest statement this audit can make about why an unverified
  bucket must never be counted as either outcome, and about why an edge is worth
  more than an adapter.
- **The audit is a test now, not a chore.** `test/stdlib/member_coverage_baseline_test.dart`
  runs the full verified diff on every suite and fails when the per-class gap
  set moves — in either direction, with the members named. The gaps above had
  accumulated for months for one reason: nothing failed when they appeared. See
  [the standing guard](#the-audit-runs-on-every-suite-not-on-request).
- Member-level coverage must be **measured, not
  spot-checked**: a spot-check cannot distinguish a fully registered class
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
- **The mirror stdlib is measured by proxy, and the proxy is only 75 %
  verified.** `tom_d4rt_ast` carries the same 117 files, of which 88 are
  identical modulo the import line and 29 diverge unreviewed — so every count
  in this document is measured on `tom_d4rt` and *assumed* to hold for the
  analyzer-free tree. The oracle cannot be pointed at the twin directly (it
  needs `dart:mirrors` and must execute source, neither of which
  `tom_d4rt_ast` can do), which makes the assumption load-bearing rather than
  incidental: the twin is what ships inside Flutter apps. scd49 tracks turning
  it into a check. Additions must land in **both** trees regardless (per the
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
actually fails, using a per-class instance recipe (51 are defined) and
matching the error text against the known "unreachable" wordings
(`Undefined static member …`, `… has no instance method named …`,
`Undefined variable: …`, `… has no getter named …`, `Unsupported binary
operator …`, `Compound assignment operator …`). Anything else means
the member **resolved**.

**Operators need their own probe shape, not their own exemption.** A member
named `+` or `[]` cannot be read as `o.+`, so it is driven through an
expression instead (`o + o`, `o[0]`, `~o`, `-o`, `o << 1`) from
`_operatorProbes`. `==` is both a universal `Object` member and an operator,
and the universal branch is tested first, so it is explicitly routed to the
operator probe — otherwise its `o.==` read would fail to *parse*, a parse
failure is not one of the unreachable wordings, and the tool would call it
reachable whatever the truth. The self-operand shortcut (`o * o` rather than
`o * 2`) costs precision in the conservative direction: on `String`,
`'a' * 'a'` is a type error rather than a resolution failure, so the column
can under-report but cannot invent a gap.

**The probe body must assign and return afterwards, never `return` from
inside the try.** The generated program is

```dart
try { probed = o.member; } finally { <teardown> }
return probed;
```

and the obvious simplification — `try { return o.member; } finally { … }` —
**silently measures the wrong thing**. In an async function, a `return` whose
expression throws inside a `try` with a non-empty `finally` and no `catch` loses
the error and returns *the finally block's last evaluated value* instead.
Measured on the shape above: the correct form throws `Undefined property or
method 'nonsenseXyz' on bridged instance of 'ServerSocket'`, while the
`return`-inside-try form completes normally and yields the socket. Every missing
member on every class with a teardown would have been recorded as present.

This is an interpreter defect, not merely a probe-writing rule — the same
program written by hand is equally wrong, and it is silent. It is tracked as
scd40; the guard here is that the shape stays as written, and
`_recipeSource` is the single place that decides it.

**Why phase 2 cannot be skipped:** adapter-map absence does *not* imply
unreachable for *instance* members — instance lookups fall back through
the supertype chain. That fallback is **not uniform**, though
(`Uint8List.sort` resolved while `HashSet.difference` did not), so the
static diff cannot predict it either. Only the interpreter is a valid
oracle. In the current run, **378 of 583** raw candidates turn out to be
reachable via fallback — a 65 % false-positive rate that a single-phase
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
3. **A column that is reported but not verified will be read as verified.**
   Operators and universal `Object` members used to be split out of the
   candidate list *before* phase 2 and excluded from `gapCount`, so those two
   columns carried raw map-diff output that nothing had checked and no
   published number could ever move. They are now verified and counted like
   the rest. See [the unverified-column note](#the-unverified-column-hazard).

Members with no usable instance recipe are reported in an explicit
**UNVERIFIED** bucket rather than being silently counted either way, and that
bucket is split in two: entries carrying a **stated reason** (they cannot be
measured, and the report says why) and entries with **no recipe yet** (nobody
got to them). The second half is the one that hides gaps, and it is now empty.
Closing it means adding recipes to `_instanceRecipes`, never relaxing the
classification.

### The audit runs on every suite, not on request

`test/stdlib/member_coverage_baseline_test.dart` performs the full two-phase
audit — the tool's own `collectMemberDiffs` and `verifyAll`, not a
reimplementation of them — and compares the result against the checked-in
baseline `test/stdlib/member_coverage_baseline.dart`. Regenerate that baseline
with:

```bash
dart run tool/stdlib_member_diff.dart --baseline
```

**A tool that has to be remembered measures the past, not the present.** The
gaps this audit found had accumulated for months for exactly one reason: nothing
failed when they appeared. The verified run costs ~7 seconds standalone and ~1
second under `dart test` (the runner reuses compiled kernel), which is what makes
a *verified* standing baseline affordable — phase 1 alone would not do, because
removing a supertype edge flips members `reachable → confirmed`, an event phase 2
catches and a candidate-only baseline cannot see at all.

**The baseline pins four things and deliberately omits a fifth:** the confirmed
gaps per class, the members unreachable *by decision*, the members that cannot
be measured, and the classes whose recipe yields an instance. (The counts are
not quoted here — they move whenever a gap closes, and the baseline file's own
header carries the live figures.) The ~378 members reachable only via the
supertype fallback are **not** pinned — one of them going bad presents as
"confirmed and absent from the baseline" either way, so pinning them adds no
guard power while tripling the file with names that carry no finding. That is the
same failure as a count-only assertion, in the other direction.

**Four tests, split by remedy — not one "matches the baseline" assertion.** A
single assertion cannot distinguish a regression from an improvement, so it
teaches people to regenerate reflexively, and once that reflex exists the guard
is decorative. The split makes the reflex safe, because only one of the four is
ever answered by regenerating:

| Test | Finding | Remedy |
|------|---------|--------|
| `F-SCC13-0` | the audit measured almost nothing | fix the environment; trust no other result |
| `F-SCC13-1` | a member that was reachable is not any more | fix the bridge |
| `F-SCC13-2` | a recipe stopped producing an instance, or a bridged class vanished | fix the recipe, or record a platform reason |
| `F-SCC13-3` | the baseline no longer describes reality | regenerate it |

`F-SCC13-3` can only be provoked by *good news* — a gap closing, or a blind spot
becoming measurable. A regression always presents as `F-SCC13-1` or `F-SCC13-2`,
which regenerating does not silence.

Pinning the unmeasurable set is what makes the guard tolerant of recipe work:
without it, `unverified → confirmed` is indistinguishable from
`reachable → confirmed`, so the 243 members that became measurable in one commit
would have read as 243 fresh regressions.

**An empty measurement agrees with any baseline.** Every probe runs in a spawned
isolate and a probe that cannot answer is scored "not measured", so a run in
which isolate spawning failed finds zero gaps and passes. Measured with the probe
timeout set to 1 µs: `F-SCC13-1` and `F-SCC13-3` **passed on a run that learned
nothing**. `F-SCC13-0` exists for that, and its two floors (≥ 100 classes
examined, ≥ 40 measured) live in the test rather than the generated file so a bad
regeneration cannot lower them. `F-SCC13-2` is the per-class version of the same
check: wholesale failure trips `F-SCC13-0`, one class quietly dropping out trips
`F-SCC13-2`.

**Each of the four has been watched fail.** A guard nobody has seen fail is a
guess about a guard, so each row was produced by breaking the thing named:

| Injected fault | Fires |
|----------------|-------|
| every probe unable to answer (1 µs timeout) | 0 and 2 |
| `DateTime.year` adapter deleted | 1 |
| `DateTime` instance recipe broken | 2 |
| a baselined class no longer bridged | 2 |
| baseline claims a gap that is bridged now | 3 |

The third row corrected a real defect in the guard: `F-SCC13-3` originally
checked only for `reachable`, but adding the missing adapter removes the member
from the candidate set altogether, so the *ordinary* way a gap closes was absent
from the observation rather than present-and-reachable — and went unreported. The
same control run showed a vanished bridge being announced as good news; that
finding now belongs to `F-SCC13-2`, where it reads as the large regression it is.

**A false regression is unreachable, by construction.** Classification is about
*resolution*, not values, so a loaded machine can only push
`confirmed → reachable` (a probe that never answers is scored reachable, because
a missing member throws instantly) — which surfaces as `F-SCC13-3`, a
bookkeeping failure. Nothing about load makes a resolving member report
"undefined". The one failure that means "you broke something" is the one that
timing cannot fake. The same asymmetry makes the guard portable: a `dart:io`
recipe that cannot run on some platform maps to `unverified`, which
`F-SCC13-2`'s message asks you to record as a reason rather than shrink the
baseline.

### Current measured state

Measured 2026-09-06.

| Metric | Count |
|--------|-------|
| Bridged classes examined | 205 |
| Raw candidates from the map diff | 668 |
| … reachable anyway via instance fallback | 652 |
| … unverified — cannot be measured, reason stated | 73 in 4 classes |
| … unverified — no recipe yet | **0** |
| **MEASURED unreachable** | **5** |
| … of those, unreachable **by decision** | 5 in 2 classes |
| **CONFIRMED unreachable** (i.e. defects) | **0** |

**The confirmed count went 3 → 231 → 13 → 0, and only the last move touched
adapters.** The rise was the unverified bucket closing: 228 members that no run
had ever executed were measured for the first time, and they were already
unreachable. The first fall was the `dart:io` supertype block being declared:
218 of those 228 were `Stream` and `IOSink` members on stream- and sink-shaped
classes, and an inherited member becomes reachable the moment there is an edge
to inherit through. Between those two figures nothing about the interpreter's
*behaviour* changed twice — what changed was first what the audit could see,
then what the registry could walk.

The last move, 13 → 0, is the one that was ordinary engineering: SCC74 bridged
eight of the thirteen and reclassified the other five as decisions rather than
defects. Those five had always been decisions — three `ByteBuffer` SIMD views
already had a limitations-table row and a pinning test — but the tool had no
way to say so, so a settled boundary and an open backlog shared one number. The
`_declined` table is that missing distinction.

**A caution about the 0.** It means no *measured* member is unreachable, and
the instrument's reach is the other half of that claim: 73 members on four
classes still cannot be measured at all, each with a stated reason. `0
confirmed` and `73 unmeasurable` have to be read together, which is why they sit
in the same table.

Read that as the standing warning it is: a headline number from this tool is a
statement about the interpreter **and** about the instrument, and the two move
independently.

The four classes still unverified each carry their reason in the report.
`HttpClientRequest` (1) and `HttpHeaders` (1) are hidden by the value
`HttpClient.getUrl` yields being bridged as its supertype `IOSink`, so a recipe
would measure the wrong bridge; `HttpClientResponse` (35) needs a completed
round trip, which does not finish inside the interpreter. `Stdin` (37) is the
odd one out and the only entry that is not a bridge defect — see
[the `Stdin` exemption](#the-stdin-exemption-a-probe-that-destroys-the-process).
UNVERIFIED here means "cannot be measured, here is why", not "nobody got to
it".

Of the 13, **zero** are operators and **one** is a universal `Object` member
(`noSuchMethod`) — a statement this audit could not make before those two
columns were verified rather than merely printed.

**Those two columns are now measured to completion, not sampled.**
`unverifiedUniversal` is **0**, and `unverifiedOperators` is **1** — `HttpHeaders
[]`, which carries a stated reason above rather than an absent recipe. So "zero
confirmed operators" describes the whole operator surface, not the part of it
that happened to have an instance to probe. That distinction is the entire
reason the unverified columns exist: the same sentence, printed while nineteen
entries were still unmeasured, would have been true of the measurement and false
about the interpreter.

**The 231 were overwhelmingly one shape, and that shape is now gone.** Seven
`dart:io` / `dart:isolate` types that *are* streams accounted for 219 of them —
`RawSocket` 38, `Stdin` 37, `HttpServer` 36, `RawDatagramSocket` 36,
`RawServerSocket` 36, `ReceivePort` 26, `ServerSocket` 10. Each bridged `listen`
and its own members, so `await for` worked while the `Stream` combinators did
not. Declaring the edges closed all of them at once; what survives on those
classes is `RawSocket.readMessage` / `sendMessage`, which are the class's own
members and never had anything to do with streams.

The per-class counts were the clue to why one table could do it. Exactly ten
members were confirmed missing on *all seven*:

```text
asBroadcastStream  asyncExpand  asyncMap  cast     distinct
drain              handleError  pipe      reduce   timeout
```

`ServerSocket` was missing **only** those ten — its bridge already carried
`map`, `where`, `fold`, `toList`, `first` and the rest directly. The other six
were missing that same ten *plus* the combinators `ServerSocket` chose to spell
out. So the reading was never "the `Stream` surface is absent everywhere"; it
was **one bridge had been filled in by hand further than the others, and ten
members defeated even that**.

**The mechanism is the cheap one.** `BridgedClass` keeps a supertype registry,
and `lookupOnBridgedSupertypes` — called from four dispatch sites in
`InterpreterVisitor` — already walks it for both getters and methods.
Registering the edge is therefore sufficient; measured directly, before and
after:

| Probe on a bound `ServerSocket` | No `→ Stream` edge | Edge registered |
| --- | --- | --- |
| `s.asBroadcastStream()` | throws `Undefined property or method` | `_AsBroadcastStream<Socket>` |
| `s.timeout(Duration(seconds: 1))` | throws `Undefined property or method` | `_ControllerStream<Socket>` |

The `Stream` adapters unwrap with `(target as Stream)`, and all seven native
types genuinely implement `Stream`, so the cast holds. **The fix was one
registration table, not 219 adapters.**

#### The `Stdin` exemption — a probe that destroys the process

`Stdin` is the one class in `_notAuditable` that is not blocked by a bridge
defect, and the reason is worth stating because it generalises.

`Stdin` has no constructor. The only instance in existence is the process's own
standard input, so — unlike `IOSink`, which the audit probes through a scratch
file under `ztmp/` — there is no sandboxed substitute to build. That was
survivable for as long as `Stdin` exposed nothing but `readLineSync` and
`hasTerminal`. It stopped being survivable the moment `Stdin` gained its
`-> Stream` edge, because the audit probes a member by *bare-reading* it, and a
bare read of a `Stream` getter — `stdin.length`, `stdin.first`, `stdin.last` —
**subscribes**.

Subscribing to fd 0 does not fail one probe. It destroys the descriptor for the
whole process, and because `dart test` runs VM suites as isolates in a single
process, every suite that registers `dart:io` afterwards dies in
`IoStdioStdlib.register` with `Failed to get type of stdio handle (fd 0)`.
Measured while closing this block: **82 failures in `test/stdlib` alone**, none
of them anywhere near the audit, all of them in suites that had nothing to do
with the change. The probe timeout does not help — the damage is done by the
subscription, not by the hang it causes.

The general rule this leaves: **a recipe must yield an object the audit owns.**
A recipe that hands back a process-global, single-consumer resource is not a
measurement, it is a side effect on everything that runs later.

The candidate total once fell from 610 to 583 without 27 members being
registered one-for-one, and the mechanism is worth keeping even though later
bridge work has moved the number since: registering a static removes it from
the diff, and the tool also
stopped emitting two categories of phantom gap (a bridged top-level function
has no class surface to diff, and a `@Deprecated` SDK alias is not a gap).
Both suppressions are category-level and annotation-driven, so the next alias
the SDK retires drops out on its own.

The **Disposition** column is not decoration — see
[the disposition rule](#recommended-next-actions). Every row must name where
its resolution lives, so that a row can never sit in the audit as an
unattributed observation.

| Class | Confirmed | Instance | Static | Assessment | Disposition |
| --- | --- | --- | --- | --- | --- |
| `ByteBuffer` | 3 | 3 | 0 | The three SIMD views (`asFloat32x4List`, `asInt32x4List`, `asFloat64x2List`). This row **understates the finding** — see [Notes on the SIMD block](#notes-on-the-simd-block); it is nine names, not three. | **Boundary** — [limitations doc](d4rt_limitations.md#intentionally-unbridged-sdk-classes) + `F-SCB29-1..4` |
| `HttpClient` | 2 | 2 | 0 | `authenticateProxy`, `connectionFactory` — callback-typed setters, so each needs an interpreted closure handed back across the sandbox boundary rather than a value. | Tracked — scd161 |
| `LinkedListEntry` | 2 | 2 | 0 | `insertAfter`, `insertBefore`. The entry bridge exists and its read surface is complete; the two mutators reach into the owning `LinkedList` and were never adapted. | Tracked — scd161 |
| `Object` | 1 | 1 | 0 | `noSuchMethod`. Adapting it means synthesising an `Invocation` — which is itself unbridged — and re-entering the interpreter from inside dispatch. | Tracked — scd161 |
| `RawSocket` | 2 | 2 | 0 | `readMessage`, `sendMessage` — file-descriptor passing over Unix domain sockets. The one residual pair on a class whose whole `Stream` surface SCC57 closed. | Tracked — scd161 |
| `Stdout` | 2 | 2 | 0 | `lineTerminator`, `nonBlocking`. The second hands out a second `Stdout` bound to the same descriptor, which is the shape the `Stdin` exemption above says to be careful with. | Tracked — scd161 |
| `StringConversionSink` | 1 | 1 | 0 | `asUtf8Sink`, the one member of the convert-sink block SCB23 did not reach. | Tracked — scd161 |

Seven rows and thirteen members, six of the rows added when SCC57's supertype
edges stripped 218 inherited members off the total and left the classes' *own*
gaps visible underneath. That is the useful property of the fall: the residue is
no longer dominated by one shape, so each row now has to be read on its own
terms rather than dismissed as more of the same.

The `ByteBuffer` row is the one that was never going to be closed by
registering a member. Earlier revisions of this table carried five more — the
static validation helpers, the `castFrom` family, the enum/symbol statics, a
four-member instance long tail, and a row of tool artifacts. All are gone: the
first four were registered, and the last was never a gap at all.

**Two of those rows were the tool, not the bridge**, and that is the reading
worth carrying forward. `unawaited` was reported because it is a top-level
*function* whose bridge carries `nativeType: Function`, so the diff compared
it against `Function`'s class surface; `FileSystemEntityType.NOT_FOUND` was
reported because it is a deprecated SDK alias for the live `notFound`.
Registering either would have produced a member that exports and analyses
cleanly and is wrong — a synthesised `Function` surface in the first case, a
retired spelling promoted back into the API in the second. Both are now
suppressed at the category level in `tool/stdlib_member_diff.dart`; the
deprecation filter reads the annotation rather than a name list, so it was
verified by negative control (it removes exactly `NOT_FOUND` from
`FileSystemEntityType` and keeps the live `notFound`).

**The oracle is structurally blind to one class of gap**, and it cost two
debugging rounds to learn: a *correctly registered* static whose SDK **return
type** reaches no bridge still fails at the first member access on the result.
`Iterable.castFrom` returns `_EfficientLengthCastIterable` whenever the source
reports its length cheaply — the common case — and `LineSplitter.split`
returns `_LineSplitIterable`; neither was in `IterableCore.nativeNames`, so
`.length` and `.toList()` raised on a value the adapter had produced
correctly. The member-diff cannot see this: the member *is* in the map. Only
an end-to-end test that uses the returned value can. A sweep for other
bridged members with unbridged return types is tracked separately.

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

**`Queue` and `ListQueue` are the cleanest demonstration of both halves.**
Their combined residue was `remove`, `removeWhere`, `retainWhere` and the
static `castFrom` — precisely the members `Queue` declares itself, everything
else arriving through its `-> Iterable` edge. Six hand-written adapters closed
eight measured gaps across *two* classes, because `ListQueue` already declared
a `-> Queue` edge and so inherited the three mutators the moment they existed
on `Queue`. **`list_queue.dart` was deliberately left untouched**, and the
guard that matters there is the *absence* of duplicate adapters: the tests
prove the members reachable on `ListQueue` with nothing registered on it.
`castFrom` had to go on `Queue` by hand regardless — **statics are never
inherited, so no edge can ever deliver one**, which is why every remaining row
in the table above is static-heavy.

**The typed-list mutators no longer appear here, and are no longer a
wrong-error-type problem either.** The 120 length-changing `List` mutators
(`add`, `insert`, `remove`, `clear`, …) on the ten shared typed lists are
correct to fail, and they fail correctly: they resolve through the `-> List`
edge to the native fixed-length list, which raises the SDK's `UnsupportedError`,
so a script's `on UnsupportedError` catches it. That is the resolution the
`UnmodifiableMapView` note below prescribes — register (or inherit) the member
and let the native raise — arrived at through the hierarchy edge rather than
through 120 adapters.

**Measuring one variant would have got that answer wrong.** A single probe
(`Float32List(2).add(1.0)`) says the whole class of problem is resolved. The full
matrix — 11 variants × 12 length-changing operations, measured 2026-09-04 — says
129 of 132 raise a catchable `UnsupportedError` and three do not: `addAll`,
`insertAll` and `replaceRange`, all on `Uint8List`. `Uint8List` is the variant
that hand-rolls its whole adapter map instead of sharing
`inheritedListMethods`, so it was the only one whose adapters ran at all, and its
adapters narrowed the element argument with `positionalArgs[n] as Iterable<int>`.
An interpreted list literal is a `List<Object?>`, so that cast threw `_TypeError`
*before* the native call — pre-empting the `UnsupportedError` the fixed-length
list was about to raise. All 28 such cast sites now go through
`coerceElements<E>`, and `F-SCB3-18` covers the whole matrix rather than one
cell. The general lesson is the same one that produced SCB3 in the first place:
**`Uint8List` is the variant most likely to be probed and the variant least
representative of the others.**

### The unverified-column hazard

**An unverified column published beside verified ones will be read as
verified.** The tool used to divert operators and universal `Object` members
out of the candidate list *before* phase-2 verification, and exclude them from
`gapCount`. Two consequences, and the second is the worse one: those columns
carried raw map-diff output nothing had checked, and *no published number could
ever move* when one of them held a real defect. The column was also
**uncheckable**, not merely unchecked — the unreachable-wording matcher did not
know `Unsupported binary operator` or `Compound assignment operator`, so even a
verification pass would have misclassified every operator failure as a success.

The one real entry hiding there was `bool`. Dart declares `& | ^` on `bool` as
well as on `int` — the non-short-circuiting siblings of `&& ||`, and the only
form that can express "evaluate both operands" — and neither interpreter
implemented them, at either dispatch site (`a & b` and `a &= b` are separate
sites with separate error messages). Both interpreters now do.

Two things had to change together for the column to become trustworthy. The
matcher had to learn the operator wordings, **and** `_instanceRecipes` had to
gain entries for the primitives (`bool`, `int`, `double`, `num`, `BigInt`) —
they had none, so the column was UNVERIFIED for exactly the classes whose
operators matter most. A literal is the whole recipe; nothing but the absence of
an operator probe had ever made them look unnecessary. Unverified operators fell
from 19 to 2 as a result.

**The fix was proven by negative control, not by a green run.** Reporting "0
confirmed operators" is what the *broken* tool did too. So the `bool` fix was
reverted and the tool re-run: it reported `bool` with 3 confirmed operators and
the total rising 28 → 31, where the same interpreter state had reported 0 before.
Verify a measurement change by making it detect a defect you have deliberately
reintroduced; a clean run proves nothing about an instrument.

**This is the third instance of the same failure mode in this audit.** SCC8
found it on `extraBridged` — a column reported as a defect list that was mostly
correct bridges. SCC9 found it on the typed-list matrix — a one-cell probe
standing in for 132 cells. Here it was two whole columns excluded from the
count. The pattern to distrust is any number in this document that is *derived*
from something other than a run of the interpreter, and any column whose value
cannot change the headline total.

### A bridge that throws where the SDK returns null

`SplayTreeMap.firstKey()` and `lastKey()` are declared `K?` and return `null`
on an empty map. Both bridges hand-threw `RuntimeD4rtException("Map is
empty")`, so the idiomatic `if (m.firstKey() == null)` worked as Dart and died
under d4rt. **The bridge must not refuse what Dart accepts, and must not accept
what Dart refuses** — a guard invented at the bridge is as much a defect as a
missing adapter, and a harder one to see, because the class measures complete.

**A test can enshrine it.** `I-COLL-78` asserted the empty-map throw, which is
why the guard survived every green run for as long as it existed. Its premise
was wrong about Dart, so the case was rewritten to assert `null`; that is a
different act from loosening an assertion and belongs in the commit message as
such. The invented-guard shape has no general detector yet — this instance was
found while measuring something else — and sweeping the stdlib for its
siblings is tracked as its own item.

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
answer is actually `false`. Measured 2026-09-06, after the `dart:io` and
`dart:isolate` edges were declared:

| Metric | Count |
|--------|-------|
| Bridged classes examined | 183 |
| … declaring `isAssignable` | 157 |
| … with ≥ 1 registered edge | 108 |
| Candidate edges from the cross-reference | 0 |
| … satisfied anyway via `isAssignable` | 0 |
| … unverified (no instance recipe) | 0 |
| **CONFIRMED missing edges** | **0** |
| Classes with ≥ 1 confirmed gap | 0 |

**The cross-reference proposes nothing.** That is a stronger statement than
"zero confirmed": a candidate is any SDK supertype relation the registry has not
been told about, so an empty candidate set means the registry now knows every
relation the mirror can see across all 183 classes. It does not mean the
registry is *complete* — the cross-reference is bounded by what `dart:mirrors`
reports on the bridged native types — but there is no longer any measurement
debt hiding behind the number.

This table has now been measured seven times, and the movement is worth keeping
because each step separates a *repair* from a change in what the audit can see
— the two are indistinguishable from the confirmed count alone, and reading
them as the same thing is the standing hazard of this section.

| Measurement | Candidates | Satisfied anyway | Unverified | Confirmed | Classes |
| --- | --- | --- | --- | --- | --- |
| Before the typed_data edges | 137 | 11 | 91 | 35 | 23 |
| After typed_data (SCB20 / SCC55) | 115 | 0 | 91 | 24 | 12 |
| After convert codecs (SCB23) | 66 | 0 | 62 | 4 | 3 |
| Re-measured with the SCC12 io recipes | 52 | 5 | 21 | 26 | 16 |
| After four dart:core recipes (SCC56) | 52 | 6 | 17 | 29 | 19 |
| After the dart:core edges (SCC56) | 38 | 3 | 17 | **18** | 9 |
| After six dart:io recipes (SCC57) | 38 | 6 | 7 | 25 | 13 |
| After the dart:io / dart:isolate edges (SCC57) | **0** | 0 | 0 | **0** | 0 |

- **35 → 24 confirmed** was the eleven typed-data `-> Iterable` edges;
  **24 → 4** is the twenty convert codec/converter edges. Those are repairs.
- **4 → 26 is NOT a regression, and this is the row to read carefully.** No
  bridge changed. SCC12 added sandboxed recipes so the *member* audit could
  measure `dart:io`, the hierarchy audit shares that recipe table, and edges
  that had been silently sitting in "unverified" became measurable — and
  measured false. The confirmed count rises when the audit's eyesight improves
  and falls when a bridge is fixed.
- **26 → 29 is the same effect at small scale**, and it is why the row is kept
  separate rather than merged into the one below it. SCC56 added four recipes
  (`RegExp`, `RegExpMatch`, `Runes`, `StringBuffer`) before declaring anything:
  three of their edges confirmed as gaps and one (`RegExpMatch -> Match`) turned
  out already true. Had the recipes and the declarations landed in one
  measurement, that step would have read as 26 → 18 and hidden both facts.
- **29 → 18 is the repair.** `CoreHierarchyCore` declares **twelve** edges and
  removes **fourteen** candidates, because the registry walk composes them:
  `int -> num` and `num -> Comparable` together answer `int is Comparable`,
  which the cross-reference had proposed as its own candidate. Declaring the
  closure by hand would have produced the same table while never exercising the
  walk.
- **Candidates fall faster than confirmed gaps** at each step, because the
  cross-reference only proposes an edge that is not already registered — so
  declaring an edge that was *already true by fallback*, or one that was merely
  *unverified*, also removes it from the candidate set.
- **18 → 25 is the eyesight effect a third time**, and the last time it can
  happen: the six `dart:io` recipes (`OSError`, `ContentType`, `RemoteError`,
  `File`, `Directory`, and the sandboxed `IOSink`) moved ten edges out of
  unverified, seven of which measured false. Nothing was un-bridged to produce
  that rise.
- **25 → 0 is the repair, and it is the largest single one in the table.**
  `IoHierarchyIo` declares fifteen edges and `IsolateHierarchyIsolate` three;
  between them they remove all 38 remaining candidates, because the walk
  composes what they declare. `Socket -> IOSink` plus `IOSink -> {StreamSink,
  StringSink}` plus the `dart:async` edges SCC49 had already put in place answer
  six questions from two declarations.
- **Satisfied-anyway went 11 → 0 → 6 → 3 → 6 → 0.** The eleven were the typed
  lists' `-> List`. Three of the six were `int -> num`, `double -> num` and
  `RegExpMatch -> Match`. The 3 → 6 step is the six `dart:io` recipes making
  visible what was already true: `File`/`Directory -> FileSystemEntity` and
  `ContentType -> HeaderValue` had been answered by predicates all along, and
  simply could not be seen before there was an instance to ask. All six are now
  declared, which is why the bucket empties rather than merely shrinking.

That satisfied-anyway bucket is the argument for running a verification pass at
all: published as unverified, those entries would send someone to fix behaviour
that already works. Every entry that ever entered it was eventually declared
anyway — not because the answer was wrong, but because an answer that lives in a
predicate three files away cannot be read as a hierarchy, and because a
predicate answers one hop and then stops.

### Confirmed gaps, by hierarchy: none left

The table that stood here is empty. Every hierarchy it ever listed has been
closed: the eleven typed-data `-> Iterable` edges by SCB20/SCC55, the twenty
`dart:convert` codec and converter edges by SCB23 (see *Notes on the convert
hierarchy* below), the `dart:core` comparables and patterns by SCC56,
`StreamController -> Sink` by SCC49, and the `dart:io` byte sinks and
`dart:io` / `dart:isolate` stream sources by SCC57.

The last two are worth keeping the reasoning for, because they are the clearest
demonstration of what a registered edge buys that a predicate does not.

`Socket` is `implements Stream<Uint8List>, IOSink` — the one class in `dart:io`
that is both shapes at once. Before SCC57 the audit reported `Socket -> IOSink`
as *satisfied anyway*, because the `IOSink` bridge's own `isAssignable` answers
it, and reported the five edges `IOSink` itself carries as **missing**. Both
readings were correct at once: **a fallback answers the pair it is asked about
and then stops; only a registered edge continues up the target's own
supertypes.** So `socket is IOSink` was true while `socket is StringSink` was
false, and the one answer anybody spot-checked was the true one. That is why the
gap survived inspection for as long as it did, and it is pinned as an assertion
about the mechanism — not about `dart:io` — in `F-SCC57-3`.

The repair is correspondingly cheap. `Socket -> IOSink`, plus `IOSink ->
{StreamSink, StringSink}`, plus the `StreamSink -> {EventSink, StreamConsumer}`
and `EventSink -> Sink` edges `dart:async` already carried from SCC49, answer
six questions from two new declarations. Nothing in that chain is restated; the
registry walks it.

### The audit's blind spot is closed in both modes

The hierarchy audit's unverified bucket — candidate edges that could not be
tested because `_instanceRecipes` had no usable entry for the class — stood at
17 across eight classes before SCC57 and is now **zero**. Six recipes closed
ten of them (`OSError`, `ContentType`, `RemoteError`, `File`, `Directory`, and a
sandboxed `IOSink` obtained from `File.openWrite()` under `ztmp` and closed in a
`finally`); declaring the edges removed the rest from the candidate set
entirely.

Keeping that bucket separate rather than resolving it by guess is what made the
closure safe, and the `dart:convert` group is the standing argument for it.
SCB23 probed all eleven encoder/decoder pairs directly — they construct with a
no-argument constructor the recipe table simply did not know about — and every
one was missing its `-> Converter` edge, exactly as the shared shape suggested.
But `LineSplitter`, in the same group with the same shape and listed alongside
them, is `extends StreamTransformerBase` and not a `Converter` at all. Folding
the bucket into "confirmed" would have declared one wrong edge in twelve: a
false `is` answer turned into a confidently wrong `true`, which is worse than
the gap it replaced.

The member audit's own bucket is closed the same way, at 74 members across four
classes, each carrying a stated reason. Both audits now report zero entries
whose reason is "no recipe written yet" — the distinction that matters, since
an unmeasurable class with a reason is a documented boundary while one without
is unfinished work.

Not every class can be given a recipe, and SCC57 established the rule for when
one must be refused: **a recipe must yield an object the audit owns.** See
*The `Stdin` exemption* above for the case that produced it.

### Why the fixes land in registrars, not in probes

Each hierarchy needs its own dispatch verification — the SC7 queue case showed
that adding edges changes which bridge *owns* a native, and
`_filterToMostSpecific` can newly drop a match that used to win. Every
hierarchy block therefore ships with a "dispatch is unchanged" group alongside
its edge cases, reading members that exist on the subtype only.

The edges must also land in both trees: `CollectionHierarchyCollection`,
`ConvertHierarchyConvert`, `CoreHierarchyCore`, `IoHierarchyIo` and
`IsolateHierarchyIsolate` are byte-identical between `tom_d4rt` and
`tom_d4rt_ast` today, and any new registrar must stay that way. A registrar
runs **last** in its library's `register`, because the registry keys on name and
every bridge an edge refers to must already be defined — including the ones that
point out of the library, which is why the block lives beside the library rather
than beside any one bridge.

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
appears (`Link`, `GZipCodec`/`ZLibCodec`, `MutableRectangle`, the SIMD block).
Each row is pinned by a case in
[`intentionally_unbridged_test.dart`](../test/stdlib/intentionally_unbridged_test.dart),
so the table cannot silently go stale in the "someone bridged it" direction.

| Type | Library | Reason to defer | Disposition |
|------|---------|-----------------|-------------|
| `Expando` | dart:core | Identity side-tables; rare in scripts. | Boundary — cannot be honoured |
| `WeakReference` | dart:core | GC semantics; unclear value in interpreter. | Boundary — cannot be honoured |
| `Finalizer` | dart:core | GC callbacks; sandbox-hostile. | Boundary — cannot be honoured |
| `Zone` | dart:async | Full zone API is large and cross-cutting. | Boundary — cannot be honoured |
| `Link` | dart:io | Symlinks — behind `FilesystemPermission`. | Deferred |
| ~~`WebSocket`~~ ✅ bridged (+ `WebSocketTransformer`, `WebSocketException`, `WebSocketStatus`, `CompressionOptions`) | dart:io | Was deferred as a larger stateful surface. | Bridged — see below |
| `GZipCodec` / `ZLibCodec` | dart:io | Compression; add if a consumer needs it. | Deferred |
| `MutableRectangle` | dart:math | `Rectangle` present; mutable variant rarely typed. | Deferred |
| The SIMD block (9 names) | dart:typed_data | Correct but pointless through an interpreter — see [Notes on the SIMD block](#notes-on-the-simd-block). | Deferred |

**Two things about the WebSocket block are worth carrying forward.**

*It is ungated, and that is the coherent choice rather than a shortcut.* A
`NetworkPermission` check on `WebSocket.connect` would look like a sandbox and
not be one: the same handshake is reachable through `Socket` plus
`WebSocket.fromUpgradedSocket`, and the server half through `ServerSocket` plus
`HttpServer.listenOn`. Gating the front door while the side door stands open is
worse than gating neither, because it invites the reader to trust it. The block
therefore inherits the posture the HTTP server half settled on, and coherent
network gating across all of `dart:io` is tracked as its own work rather than
being approximated five names at a time.

*`WebSocket.extensions` cannot report what was negotiated.* The SDK hardcodes
`String get extensions => "";` in `websocket_impl.dart`, so the getter answers
`''` whether or not per-message-deflate is in use. The bridge reports what the
SDK reports; a test that wants to prove `CompressionOptions` reached the wire
has to inspect the `sec-websocket-extensions` request header from the server
side, which is what
[`websocket_test.dart`](../test/stdlib/io/websocket_test.dart) does. This is an
SDK limitation faithfully passed through, not a bridging gap to close.

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

Measured against a live environment, the 32 names split two ways:

| Shape | Count | Names |
| ----- | ----- | ----- |
| Bridged as a real type | 30 | `HttpClient`, `HttpClientRequest`, `HttpClientResponse`, `HttpServer`, `HttpRequest`, `HttpResponse`, `HttpSession`, `HttpConnectionInfo`, `HttpConnectionsInfo`, `HttpHeaders`, `HeaderValue`, `ContentType`, `Cookie`, `SameSite`, `HttpException`, `RedirectException`, `HttpStatus`, `WebSocket`, `WebSocketTransformer`, `WebSocketException`, `WebSocketStatus`, `CompressionOptions`, `HttpClientCredentials`, `HttpClientBasicCredentials`, `HttpClientBearerCredentials`, `HttpClientDigestCredentials`, `HttpDate`, `RedirectInfo`, `HttpClientResponseCompressionState`, `BytesBuilder` |
| Unbridged by decision | 2 | `BadCertificateCallback`, `HttpOverrides` |

The two that remain are the only names on this surface whose absence is a
**decision** rather than a gap, and they are unbridged for unrelated reasons:
`BadCertificateCallback` is a `typedef` and not a class at all, so there is
nothing a `BridgedClass` could model; `HttpOverrides` is a process-wide,
script-outliving hook for swapping the `HttpClient` implementation, which is
precisely the host access the sandbox exists to prevent. Both are argued in
full in the [limitations doc](d4rt_limitations.md#intentionally-unbridged-sdk-classes),
which means this re-export surface now has **no untracked gap left** — every
one of the 32 names is either bridged or on that page.

The gaps this section used to carry that were worse than a plain missing name
are now all closed. Each shared a shape: a name a script never *writes* but is
*handed*, so its absence did not read as an error at the point it mattered.

The server was the largest. `HttpServer` was bridged while `HttpRequest` and
`HttpResponse` were not, so a script could start a server, accept a connection,
and have no type for what it was handed — the one path by which a request can be
answered ran through a name that did not resolve. `SameSite` was the same defect
in miniature: `Cookie.sameSite` was bridged as both getter and setter, so the
property looked complete while the getter returned an unnameable value and the
setter accepted nothing but null.

The exception surface carried the sharpest version of it — an
unresolved type in a catch clause does not raise, so `on HttpException
catch` was a handler that silently never matched. `HttpException`,
`RedirectException` and `HttpStatus` are now bridged, and so is
`IOException`, which had the same defect one level up: its supertype edge
to `Exception` was registered but no class stood under the name, so `on
IOException catch` missed every `dart:io` exception while the less specific
`on Exception catch` caught them.

The credentials family was the subtlest of them. All four were registered
with `environment.define(..., NativeFunction(...))` rather than
`defineBridge`, which made construction work — the common script use, hand
credentials to an `HttpClient` — while leaving the names as callable values
that merely shared a class name. Using them as *types* therefore did not
ask a type question at all: `x is HttpClientBasicCredentials` **invoked**
the callable and threw *"requires username and password arguments"*, while
the zero-arity `HttpClientCredentials` really did return a `Type` and so
answered a silent, always-wrong `false` even for a genuine credentials
value. They are now real bridges, with the three concrete forms declaring
the marker interface as a supertype so `c is HttpClientCredentials` — the
type `addCredentials` accepts, and the only check a script wrapping it can
make — answers true.

An audit that probes reachability with `.toString()` cannot see any of this:
every name in scope answers `toString()`, callable or not, which is why the
counts above are taken from registration shape and `is` rather than from
name resolution.

The WebSocket block is the one group that was unreachable in its *entirety*
rather than partly, so unlike the shapes above it never misled anyone — a
script either had no WebSocket support or knew it. Its five names are now
bridged; the two facts worth knowing about them (the absent permission gate and
the SDK's hardcoded `extensions` getter) are under
[P3](#p3--niche-or-questionable-sandbox-fit-audit-only-likely-skip).

The last three to be bridged — `HttpDate`, `RedirectInfo` and
`HttpClientResponseCompressionState` — split between the two shapes above.
`RedirectInfo` and `HttpClientResponseCompressionState` were the handed-not-
written kind: `HttpClientResponse.redirects` and `.compressionState` had been
bridged all along, so a script could reach a value and then be unable to name,
test or read it — a failure surfacing one call after the one that caused it.
`RedirectInfo` needed `nativeNames: ['_RedirectInfo']` for that, since what the
SDK hands back is the private implementation type; without the claim the value
resolves to no bridge and is inert even once the name exists.
`HttpDate` had no such excuse — nothing had registered it, and it is two static
methods and no instances.

**Disposition: every name on this surface now carries one.** The 30 bridged
names are pinned by
[`io_reexport_visibility_test.dart`](../test/stdlib/io/io_reexport_visibility_test.dart)
and its registration-level mirror
`tom_d4rt_ast/test/runtime/stdlib_io_reexport_visibility_test.dart`, with
behaviour pinned per family: the exception surface in
[`http_exception_test.dart`](../test/stdlib/io/http_exception_test.dart), the
server's round trip in
[`http_server_test.dart`](../test/stdlib/io/http_server_test.dart), the
credentials family's type questions in
[`http_credentials_test.dart`](../test/stdlib/io/http_credentials_test.dart),
and the last three in
[`http_date_test.dart`](../test/stdlib/io/http_date_test.dart) and
[`http_response_details_test.dart`](../test/stdlib/io/http_response_details_test.dart).
The two unbridged names are held by the limitations doc with cases in
[`intentionally_unbridged_test.dart`](../test/stdlib/intentionally_unbridged_test.dart),
which asserts both that the names are absent and — for
`BadCertificateCallback` — that everything a script would use the alias for
works without it, since that is the whole justification for the row.

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

### The third shape: a *valid* argument rejected by an over-narrow cast

Both shapes above are about invalid calls getting a poor diagnostic. There is a
third, which is worse because it rejects a **correct** call:
`positionalArgs[n] as Iterable<int>` (or `as List<Widget>`, `as Map<String,
Object>`, …) on an argument the script wrote as a **collection literal**.

d4rt evaluates a collection literal to `List<Object?>` / `Map<Object?, Object?>`
— the element types are erased regardless of what the elements actually are —
and elements that came from bridged code arrive as `BridgedInstance` wrappers.
So the cast is testing the container's *type argument*, which is never going to
match, rather than its contents, which usually do.

The failure mode is nastier than a wrong message:

- **It looks like a per-member bug, not a class of bug**, because the same
  member works when given a native collection. `l.followedBy(Uint8List.fromList
  ([9]))` passes and `l.followedBy([9])` does not, so a spot-check clears the
  member.
- **It can substitute a different error for the right one.** If the native call
  was going to throw — a fixed-length list refusing `addAll`, say — the cast
  throws first, and a script's `on UnsupportedError` no longer catches. The
  member's *error contract* changes, silently, and a test that only asserts
  "something was thrown" stays green.

The remedy is to coerce rather than cast: unwrap the container and any
`BridgedInstance` elements, then let a genuinely wrong element type fail.
`D4.coerceList<T>` does this for generated bridges;
[`coerceElements<E>`](../lib/src/stdlib/typed_data/inherited_list_methods.dart)
is the typed-data equivalent. Coercing must not *widen*: accepting an argument
the SDK would reject makes a script green here that cannot compile as Dart,
which is the one bridge defect no passing test can catch.

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
carry both records: a limitations row serves the script author who hits
`Undefined variable: <it>` and needs to know the absence is known, while a
tracked todo serves the developer who will build the thing. Requiring strict
exclusivity would delete the row the script author needs the moment work is
scheduled, which is exactly backwards.

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
4. **The hierarchy audit is closed** — zero candidates, zero confirmed, across
   183 classes. The blocks were filed per hierarchy rather than as one change,
   because each alters bridge *ownership* and needs its own dispatch
   verification: `dart:typed_data` (11 edges), `dart:convert` (20 edges, plus
   the `Encoding.decodeStream` adapter), `dart:core` (12 edges), `dart:async`'s
   `StreamController -> Sink`, and finally `dart:io` (15 edges) and
   `dart:isolate` (3). The last block is the one to remember: its fifteen
   declarations closed 25 confirmed edges, because the walk composes them and
   because `dart:async` had already declared the three hops behind `IOSink`.
5. **Both audits' blind spots are closed** — no candidate edge and no candidate
   member now sits UNVERIFIED for want of a recipe. What remains unmeasurable
   carries a stated reason: 74 members on 4 classes, and no edges at all.
   Only a recipe may empty this bucket, never a guess, and `dart:convert` is
   the worked example of why in both directions: SCB23 probed eleven unverified
   encoder/decoder pairs by hand and every one was a real gap — but the twelfth
   candidate of the same shape, `LineSplitter`, was not. SCC57 added the
   converse rule after a recipe for `Stdin` destroyed fd 0 for every later suite
   in the process: **a recipe must yield an object the audit owns.**
6. **`dart:io`'s re-export surface is closed** — 30 of its 32 names are bridged
   and the remaining two are decisions on the limitations page, so nothing on it
   is an unrecorded gap. Most of those blocks were worth more than their name
   count suggests, for one reason: a name that is only ever *reached* rather
   than *written* fails silently. Bridging `HttpException`, `RedirectException`,
   `HttpStatus` and `IOException` turned catch clauses that read as correct but
   were dead code into working handlers; bridging
   `HttpRequest`/`HttpResponse`/`HttpSession`/`HttpConnectionInfo`/
   `HttpConnectionsInfo`/`SameSite` turned the already-bridged `HttpServer` from
   a name into something that can answer a request; converting the four
   credentials names from callables into real bridges turned `x is
   HttpClientCredentials` from a throw or a silent `false` into an answer; and
   `RedirectInfo`/`HttpClientResponseCompressionState` were the same shape one
   last time, on getters that had been bridged all along. The WebSocket block is
   the exception that proves the point — it was absent in its entirety, so it
   failed loudly, and it was bridged for the capability rather than to repair a
   lie.

## Method / reproducibility

Both audits are mechanical and share one entry point. Neither reads the
bridge *sources*: they read a live `Environment` after every
`*Stdlib.register()`, so lazily-built and aliased registrations are counted
exactly as a script would see them.

```bash
# Member-level gaps — which members can no script reach? (~7 s)
dart run tool/stdlib_member_diff.dart [--json out.json] [--no-verify]

# Hierarchy gaps — which bridged supertype has nobody declared?
dart run tool/stdlib_member_diff.dart --hierarchy [--json out.json] [--no-verify]

# Rewrite the standing baseline the suite asserts against
dart run tool/stdlib_member_diff.dart --baseline [--baseline-out path.dart]
```

A clean verified run is ~600 probes in about 7 seconds. It stretches badly when
probes wedge, because each one then costs the full idle timeout — which is why
the run prints a progress line per class.

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

The member-level half now has that trigger *for the facts*, though not for this
prose: `test/stdlib/member_coverage_baseline_test.dart` fails when the per-class
gap set moves, so a bridging fix can no longer pass unnoticed — it fails the
suite and asks for a regenerated baseline. The hierarchy half has no equivalent
guard yet.

- **Class inventory**, if a source-level list is wanted rather than the live
  registry: `grep -rhoE "name: '[A-Za-z]+'"` across `stdlib/`.
- **Mirror parity**: the tool is `tom_d4rt`-only, since it needs
  `dart:mirrors` and `tom_d4rt_ast` must stay dependency-free. Parity is
  checked by diffing files directly, and the check is currently partial:
  `collection_hierarchy.dart`, `convert_hierarchy.dart` and
  `typed_data_hierarchy.dart` are identical between the trees apart from the
  import line, so the *hierarchy* findings transfer. Across the whole stdlib
  it is 88 of 117 files identical and 29 unreviewed, so the member findings
  transfer for the 88 and are assumed for the rest. Nothing enforces this —
  it is a hand diff, re-run when someone thinks of it. scd49 tracks making it
  a test.
