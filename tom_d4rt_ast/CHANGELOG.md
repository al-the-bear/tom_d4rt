## 0.52.0

### Added — the last three `dart:io` re-exports a script could reach but not name (scc65)

### Documented — `BadCertificateCallback` and `HttpOverrides` are unbridged by decision (scc65)

Mirrors `tom_d4rt` 1.63.0.

## 0.51.0

### Fixed — a type test no longer runs the function it is asked about (scc64)

Mirrors `tom_d4rt` 1.62.0.

`x is Foo`, where `Foo` resolved to a callable, was answered by **calling it**
— twice, because the guard and the body each invoked it — to see whether it
returned a `Type`. A type test, which a reader takes to be a pure question
about a value, therefore executed arbitrary host code with whatever side
effects that code has. `1 is print` surfaced a raw `RangeError` from inside
`print`'s own body; `1 is identical` reported *"identical requires two
arguments"* as though the type test had arguments.

The interpreter now diagnoses a callable on the right-hand side of `is`
without invoking anything, and says it the same way for a host function and
for a script one — an `InterpretedFunction` previously missed the branch
entirely and fell through to *"Type 'f' not found or is not a int"*, which
names the *operand's* type and so reads as though the operand were at fault.

### Fixed — the four `HttpClient*Credentials` names are types (scc64)

`IoHttpStdlib` registered all four with `environment.define(...,
NativeFunction(...))` rather than `defineBridge`. Construction worked — the
common script use — but the names were callable values that merely shared a
class name, so `c is HttpClientBasicCredentials` threw rather than answering,
and the zero-arity `HttpClientCredentials` answered a silent, always-wrong
`false` even for a genuine credentials instance. `HttpClientCredentials()`
also *succeeded*, handing the script a `Type` object, though the SDK declares
it as a bare `abstract interface class` with no factory.

All four are now real bridges. The marker is abstract with no constructors;
the three concrete forms keep their constructors and declare the marker as a
supertype, so `c is HttpClientCredentials` — the type `addCredentials` accepts,
and the only check a script wrapping that call can make — answers true.

## 0.50.0

### Added — WebSockets (scc63)

Mirrors `tom_d4rt` 1.61.0. `WebSocket` and the four names around it were bridged nowhere, so a script had
no way to open one — `import 'dart:io'; WebSocket.connect(...)` failed with
`Undefined variable: WebSocket`. Unlike most of the `dart:io` gaps closed
recently, this one failed *loudly*: the block was absent in its entirety rather
than half-built, so a script either had no WebSocket support or knew it. It is
bridged for the capability, not to repair a lie.

Five types are now bridged:

- **`WebSocket`** — `connect` and the `fromUpgradedSocket` constructor; the
  `Stream` side (`listen`) and the `StreamSink` side (`add`, `addUtf8Text`,
  `addError`, `addStream`, `close`); the getters `readyState`, `extensions`,
  `protocol`, `closeCode`, `closeReason`, `done` and a read/write
  `pingInterval`; the four state constants and the static `userAgent`
  property. The deprecated zero-argument constructor is deliberately omitted.
- **`WebSocketTransformer`** — the `upgrade` and `isUpgradeRequest` statics that
  turn a bridged `HttpRequest` into a socket, plus the factory and `bind` for
  the stream-transformer form.
- **`WebSocketException`** — `message` and `httpStatusCode`, with a supertype
  edge to `IOException`. It is declared a *sibling* of `HttpException`, not a
  child: a failed upgrade is not an HTTP error, and the extra hop would make
  `on HttpException` swallow it.
- **`WebSocketStatus`** — the thirteen close-code constants.
- **`CompressionOptions`** — the per-message-deflate configuration, its
  `compressionDefault` / `compressionOff` presets and five getters.

`WebSocket` also gains supertype edges to `Stream` and `StreamSink`. It is the
one class in `dart:io` that is both shapes without going through `IOSink`,
because its sink element type is `String|List<int>` rather than bytes.

Two things are worth knowing about the result:

- **There is no permission gate**, matching the posture of the HTTP server half.
  A `NetworkPermission` check on `WebSocket.connect` would look like a sandbox
  and not be one — the same handshake is reachable through `Socket` plus
  `WebSocket.fromUpgradedSocket`. Coherent network gating across `dart:io` is
  tracked as its own work rather than approximated five names at a time.
- **`extensions` always returns `''`.** The SDK hardcodes it
  (`websocket_impl.dart`), so the getter cannot report whether
  per-message-deflate was negotiated. The bridge reports what the SDK reports;
  proving `CompressionOptions` reached the wire requires reading the
  `sec-websocket-extensions` request header from the server side.

`WebSocket.connect`'s `headers` argument is coerced rather than cast. A map
literal written in a script is a `_Map<Object?, Object?>` whatever its entries
hold, so an `as Map<String, dynamic>?` would have thrown a raw cast error before
`connect` was reached — the one shape on this surface where a plain cast is
wrong.


## 0.49.0

### Fixed — a script could start an HTTP server but not answer a request (scc62)

Mirrors `tom_d4rt` 1.60.0. `HttpServer` was bridged; `HttpRequest` and
`HttpResponse` were not. So `HttpServer.bind` succeeded, `server.listen`
delivered a connection, and the value the handler was handed had no bridge —
every member on it failed with `Cannot access property 'method' on target of
type _HttpRequest`. The one path by which a request can be answered ran through
a name that did not resolve.

Six types are now bridged, closing the server half of `dart:io`:

- **`HttpRequest`** — the twelve declared getters (`response`, `method`, `uri`,
  `requestedUri`, `headers`, `cookies`, `contentLength`, `protocolVersion`,
  `persistentConnection`, `certificate`, `session`, `connectionInfo`), plus
  `listen` for the request body, which is a `Stream<Uint8List>`.
- **`HttpResponse`** — the `IOSink` surface (`write`, `writeln`, `writeAll`,
  `writeCharCode`, `add`, `addStream`, `addError`, `flush`, `close`) plus
  `redirect`, `detachSocket`, and getters and setters for the seven mutable
  fields (`statusCode`, `reasonPhrase`, `contentLength`,
  `persistentConnection`, `bufferOutput`, `deadline`, `encoding`).
- **`HttpSession`** — the full `Map` surface plus `id`, `isNew`, `destroy` and
  the `onTimeout` callback. The `Map` adapters are spread in from `MapCore`
  rather than inherited: bridge member lookup is flat and does not walk the
  supertype registry, and name canonicalization resolves `_HttpSession` to this
  bridge before any assignability scan, so a bridge that wins selection has to
  carry every member it needs.
- **`HttpConnectionInfo`** and **`HttpConnectionsInfo`** — the peer identity and
  the live connection counters.
- **`SameSite`** — the value type of `Cookie.sameSite`, which was bridged as
  both getter and setter while the getter returned something no bridge claimed
  and the setter accepted nothing but null. It is not an enum despite reading
  like one: a final class with a private constructor and three static const
  instances, so it is bridged as a class with static getters.

Three supertype edges are registered alongside them — `HttpResponse -> IOSink`,
`HttpRequest -> Stream` and `HttpSession -> Map`. These are load-bearing for
dispatch and not only for `is`: an `HttpResponse` satisfies both its own
predicate and `IOSink`'s, and without an ordering `_filterToMostSpecific` has no
ground on which to drop the base.

Script-level behaviour is pinned in `tom_d4rt`
(`test/stdlib/io/http_server_test.dart`), which runs a real loopback round trip;
this tree cannot execute scripts, so its coverage is the registration-level
mirror in `test/runtime/stdlib_io_reexport_visibility_test.dart` plus the SCC24
getter sweep, which was widened to cover the new bridges rather than have its
blind-spot baseline raised by four.

## 0.48.0

### Fixed — `on HttpException catch` and `on IOException catch` never matched (scc61)

`HttpException`, `RedirectException` and `IOException` were not bridged at all,
so a script writing `on HttpException catch (e)` got a handler that silently
never ran. That is worse than an error: the clause resolves to nothing, the
match is read as "does not apply", and the exception continues to the next
clause — so a script's error handling appears to be in place while doing
nothing. `on Exception catch` caught the same throw, which is what made the
gap look like correct behaviour.

All four are now bridged. `IOException` lives in its own
`lib/src/stdlib/io/io_exception.dart` because it is the root of the `dart:io`
error hierarchy rather than an HTTP type; the other three are in
`io/http.dart`. The two exceptions carry `isAssignable`, which is what lets a
natively-thrown instance reach the clause.

The supertype edges (`IOException → Exception`, `FileSystemException`,
`SocketException`, `HttpException → IOException`, `RedirectException →
HttpException`, and the three `PathXException` leaves) are declared in
`ExceptionHierarchyCore` alongside the rest of the chain, each edge once, with
the closure computed by the registry walk. Bridging a base type is normally
the hazard `isAssignable` documents — a root predicate can steal member
dispatch from its own subtypes — and it is safe here precisely because every
leaf declares its hop up, so `_filterToMostSpecific` still prefers the leaf.
`http_exception_test.dart` pins both halves (F-SCC61-9, F-SCC61-10), and both
passed before the change as well as after: they are the guard, not the fix.

### Added — `HttpStatus` constants

`HttpStatus` is bridged as an abstract class carrying its 64 non-deprecated
`static const int` members, so `HttpStatus.notFound` resolves. The
screaming-caps `@Deprecated` aliases (`NOT_FOUND` and friends) are
deliberately absent — bridging a name the SDK is retiring would make it harder
to remove later, and scripts that need it can write the integer.

## 0.47.0

### Fixed — `asUint8ListView()` was missing on `Uint8List` and `Float64List` (scc60)

`Uint8List.asUint8ListView()` failed with "Bridged class 'Uint8List' has no
instance method named 'asUint8ListView'" on both interpreter lines, and
`Float64List.asUint8ListView()` failed on the analyzer line only. The other
nine typed-data variants had it. Both gaps came from the same place: the
member is declared per variant rather than shared, so a variant that skips it
is invisible until someone calls it on that exact type. `Uint8List` hand-rolls
its whole adapter map, and `Float64List` had simply drifted from its ten
siblings on one side of the `tom_d4rt` / `tom_d4rt_ast` mirror.

Both variants now declare `asUint8ListView` and `buffer` as methods, matching
the other nine. `test/stdlib/typed_data/typed_list_inherited_members_test.dart`
covers the member on all eleven variants (F-SCC60-3), which is what makes a
future one-off omission fail rather than hide — a spot check on `Uint8List` or
`Float32List` passes either way.

### Documentation — why the typed-data member lists are not redundant

`inherited_list_methods.dart` justified its existence with the claim that the
interpreter "does not walk the supertype chain". That has not been true since
the supertype registry gained `Int8List -> List -> Iterable` edges: those
members now resolve through the generic `List` bridge as well, which makes the
explicit lists look like dead weight.

Deleting them would be wrong, and the doc comment now says why, measured rather
than asserted. The `List` bridge is generic over `Object?`; a typed-data list is
a `List<E>` whose element type is reified at the native boundary. Removing the
shared spread from `Int8List` changes three members: `followedBy([9])` throws
`_TypeError` (a `List<Object?>` where `Iterable<int>` is required), `reduce`
throws (a `(dynamic, dynamic) => Object?` closure where `(int, int) => int` is
required), and `firstWhere(…, orElse: () => 's')` returns the `String` instead
of rejecting it. F-SCC60-1 and F-SCC60-2 pin the last two across all eleven
variants; F-SCB3-20 already pinned the first.

## 0.46.0

### Fixed — `dart:io` and `dart:isolate` now declare their supertypes (scc57)

`stdout is StringSink`, `socket is Stream`, `stdin is Stream`,
`ReceivePort() is Stream` and `OSError('x', 1) is Exception` all answered
`false`. `dart:collection`, `dart:convert`, `dart:typed_data`, `dart:async` and
(since 1.56.0) `dart:core` each had a hierarchy block; `dart:io` and
`dart:isolate` never did, so every type test a script writes about the two
shapes those libraries are built out of — the byte sink and the stream source —
was answered wrongly.

**One of those answers was already right, and that is why the gap survived.**
`socket is IOSink` was true before this change: the `IOSink` bridge declares an
`isAssignable` predicate and a connected socket satisfies it. But a predicate is
consulted for the pair being asked about and then stops — it does not continue up
the target's own supertypes. So `socket is IOSink` was true while
`socket is StringSink` was false, and the one answer anybody spot-checked was the
true one. Only a registered edge walks.

Two new registrars, `IoHierarchyIo` (15 edges) and `IsolateHierarchyIsolate`
(3), close 25 confirmed missing edges, because the registry composes what they
declare rather than requiring the closure to be spelled out. `Socket -> IOSink`
plus `IOSink -> {StreamSink, StringSink}` plus the `StreamSink -> {EventSink,
StreamConsumer}` and `EventSink -> Sink` edges `dart:async` already carried
answer six questions from two declarations.

**The member surface came back with them.** Declaring the edges moved 218
members from confirmed-unreachable to reachable without a single adapter being
written — the `Stream` combinators (`asBroadcastStream`, `asyncExpand`,
`asyncMap`, `cast`, `distinct`, `drain`, `handleError`, `pipe`, `reduce`,
`timeout`) on `RawSocket`, `Stdin`, `HttpServer`, `RawDatagramSocket`,
`RawServerSocket`, `ReceivePort` and `ServerSocket`, and the `StringSink`
surface on `Socket` and `Stdout`. `await for` had always worked on those
classes, because each bridged `listen` directly; everything built on top of it
had not.

Also in this change: the stdlib gap audit (`tool/stdlib_member_diff.dart`) gains
six instance recipes and reports its not-auditable set with reasons in
`--hierarchy` mode as it has in `--members` mode since 1.30.0. Both audits now
report zero candidates whose reason is "no recipe written yet". `Stdin` is
explicitly marked not-auditable: it has no constructor, the only instance is the
process's own standard input, and a bare read of an inherited `Stream` getter
subscribes to fd 0 and destroys it for every later suite in the same `dart test`
process.

Covered by `F-SCC57-1..3`, `F-SCC57-11..15`, `F-SCC57-21..23`, `F-SCC57-31..33`
and `F-SCC57-41..44`.

## 0.45.0

### Fixed — the non-error half of `dart:core` now declares its supertypes (scc56)

`'abc' is Comparable`, `1 is Comparable`, `'abc' is Pattern`,
`RegExp('a+') is Pattern`, `'abc'.runes is Iterable` and
`StringBuffer() is StringSink` all answered `false`. Every other library that
needed supertype edges had been given a hierarchy block — `dart:collection`,
`dart:convert`, `dart:typed_data`, and the `Error`/`Exception` chain inside
`dart:core` itself — but the rest of `dart:core` had none at all, so the type
tests a generic-bounded script writes could not be answered. A
`T extends Comparable<T>` bound, an `on Pattern` extension and an
`is StringSink` guard were each unusable against the SDK types that satisfy
them.

The new `CoreHierarchyCore` declares them the way the SDK does: single-hop
edges only, one per `implements`/`extends` clause, with the closure computed by
the registry walk. `1 is Comparable` is therefore answered by following
`int -> num -> Comparable` rather than by restating it.

**No member was ever missing.** `compareTo` is declared directly on each of
the six comparable bridges, and `matchAsPrefix`/`allMatches` directly on
`String` — so the edges buy type tests only. That is pinned rather than
asserted, because the obvious reading of a false `is Pattern` is that the
`Pattern` surface is gone.

**`int -> num` and `double -> num` are the only edges here that were already
true**, answered by `num`'s own assignability predicate with nothing declared
behind them. Declaring them lets the most-specific filter DROP the `num` match
in favour of `int` or `double`, which makes dispatch more exact; the primitives
are on every hot path, so the mirrored suite in `tom_d4rt` reads subtype-only
members off both to prove nothing moved.

### Fixed — `first`, `last` and `single` on the dart:collection bridges now throw the SDK's `StateError` (scc51)

`HashSet().single`, `ListQueue().last`, `LinkedList().first` and thirteen
further combinations threw a `RuntimeD4rtException` carrying a hand-written
message ("Cannot get first from an empty queue."), where native Dart throws
`StateError`. A script written by a Dart author — `try { … } on StateError
catch (e) { … }` — therefore caught nothing, and the difference was invisible
from inside the collection bridges because they all agreed with each other.
Only `List` was correct, and only because its bridge never had a hand-written
copy.

The cause is a migration that was never finished. Each concrete collection
bridge carried its own `first`/`last`/`single`, written before the
`HashSet -> Set -> Iterable` supertype edges existed and correct at the time.
Once the edges landed, those copies stopped being the only implementation and
became *shadows* over `Iterable`'s — which delegates, and so reports the SDK's
own error. Eighteen such adapters across nine files are deleted; the inherited
copies answer now.

`UnmodifiableMapView` had a nineteenth, an `addEntries` that called
`.cast()` on its argument and so could not unwrap a
`BridgedInstance<MapEntry>` — byte for byte the shape removed from `HashMap`
and `LinkedHashMap` earlier. `Map`'s copy, which unwraps correctly, answers
now.

**Behavioural change.** Scripts that caught `RuntimeD4rtException` around an
empty-collection access must catch `StateError` instead. That is the point of
the change rather than a side effect of it: the previous family was
unreachable from correctly written Dart.

### Added — a regression test that measures shadowing behaviourally, not by name

Bridge adapters sharing a *name* with a supertype's costs nothing; only their
*behaving differently* does. `test/scc51_shadowed_adapter_test.dart` invokes
both members of every such pair on the same native object with the same
arguments and compares outcomes. Name intersection alone reports 315 pairs —
a number no reviewer reads. The differential reports the real ones, and after
these deletions it reports none, so the test asserts an empty difference set
with no allowlist at all.

The set-algebra trio (`union`, `intersection`, `difference`) is deliberately
*not* collapsed onto `Set`, and `set_algebra_methods.dart` now records why:
`coerce` hands back the same native object, so the leaf's own override runs
and `SplayTreeSet.union` stays sorted. The per-class copies survive for their
diagnostics — the class name in an argument-type error — which is the only
respect in which they differ.

### Added — `test/bridge_reachability.dart`, so registration-level tests stop pinning the layout

This package cannot run scripts, so its stdlib tests assert against bridge
objects directly — and reaching for `findBridgedClassByName('HashSet')!
.getters['first']!` asserts two things at once: that a script can read the
member, and that *this particular* bridge is the one carrying it. Only the
first is a contract. The second broke five tests when the shadow adapters
were deleted, even though nothing a script can observe had changed.

The new helper resolves a member the way the interpreter does — across the
registered supertype chain, nearest first — mirroring
`InterpreterVisitor.lookupOnBridgedSupertypes` one layer down. A test using it
fails exactly when a script would: when the member becomes unreachable, or
when a leaf re-adds a divergent copy.
## 0.43.0

### Fixed — a native type no bridge claims by name resolves structurally instead of going inert (scc49)

Calling a member on a native object whose type appears in no bridge's
`nativeNames` failed with `Undefined property or method 'moveNext' on
_CompactIterator` — not with a resolution error, because the failure is
absorbed upstream and the object surfaces as a raw native with no members.
Every private SDK implementation type therefore had to be enumerated by hand;
the `Iterator` bridge alone carries seventeen entries, and the eighteenth an
SDK release introduces is a new bug report. User libraries with their own
private iterators were never covered at all.

Measuring the premise narrowed it. Public *generic* implementation types
already resolved for free — `WhereIterator`, `MappedListIterable`,
`ReversedListIterable` appear in no allowlist and work today, because
`toBridgedClass` has a suffix rule that matches them. That rule sits in the
`else if (name.contains('<'))` arm of an `if (name starts with '_') … else if`
chain, so it is unreachable for two shapes and only those two: private names
(`_CompactIterator`, `_SplayTreeKeyIterator`) and non-generic public names
(`Runes`, `RuneIterator`). Those two shapes are the entire reason the
allowlists exist.

So the fix makes the existing rule reachable rather than adding an `is` test.
`toBridgedInstance` gains a final step that resolves an otherwise-unclaimed
native object by the **longest** bridge name that is a suffix of its type
name, and the pre-existing public suffix rule is switched to the same
longest-wins helper. That second half is a fix in its own right: it used
`firstWhereOrNull`, so it returned whichever bridge was registered first and
reordering two `registerBridgedClass` calls could silently change dispatch —
`_BodyBoxConstraints` suffix-matches both `Constraints` and `BoxConstraints`.

The step lives in `toBridgedInstance`, not as a fourth pass inside
`toBridgedClass`, and the difference is load-bearing. Implemented in
`toBridgedClass` first, on the reasoning that a pass firing only where an
exception is already thrown cannot regress a working case; the suite
disagreed with 43 failures, all enum dispatch. That throw is not a failure
report — callers *use* it as a control-flow signal, catching it to fall
through to the bridged-enum registry, and a bridged enum named `SimpleEnum`
suffix-matches the `Enum` bridge. Interpreter-owned names (`Enum`,
`RuntimeType`, `RuntimeValue`, `Callable`) are excluded for the same reason.

`nativeNames` stays, as the fast path and as the explicit-ownership override.
It is still required: the SDK abbreviates often enough
(`_StreamSinkWrapper` for `StreamSink`) that the naming convention alone does
not cover everything.

This package's tests for the change are registration-level rather than
script-level — it has no parser — which lets them ask the resolver *which*
bridge answered instead of merely whether it threw.

### Fixed — `EventSink` is registered as a subtype of `Sink` (scc49)

One line, independent of the above. SC4 registered the sink hierarchy as far
as `EventSink` because `Sink` was not what it was auditing, so `c.sink is
Sink` answered `false` for a value that plainly is one — worse than an
unresolvable name, because it looks like an answer. The hierarchy registry
closes transitively, so `StreamSink` and `StreamController` inherit the edge.

## 0.42.0

### Fixed — a native enum value resolves to its bridged enum, not to a bridged class whose name is a prefix of it (scc46)

`Environment.getRuntimeType` handled `BridgedEnumValue` — the wrapped form —
but had no branch for a raw native `Enum` arriving from a bridge return or a
call argument. Such a value fell through to `toBridgedClass`, whose PASS B
fuzzy fallback claims any registered bridge whose name is a >=3-character
prefix of the native type name. A bridge package for a large API surface is
dense with such pairs, and Flutter's is the worst case:

| native enum           | bridged class it was captured by |
| --------------------- | -------------------------------- |
| `TextDirection`       | `Text`                           |
| `ThemeMode`           | `Theme`                          |
| `BorderStyle`         | `Border`                         |
| `WidgetState`         | `Widget`                         |
| `CupertinoButtonSize` | `CupertinoButton`                |

A single bridge captures as many enums as happen to extend its name: the
`Text` bridge alone swallowed eleven, `Semantics` four, `Tab` three. Across
the flutter-material corpus the defect accounted for 131 failures spanning 61
distinct pairs — and for nothing else, which is how it was identified.

The damage surfaced in `callable.dart`'s declared-parameter check, which
rejected a perfectly correct call with `type 'Text' is not a subtype of type
'TextDirection' of 'dir'`. `getRuntimeType` now consults the bridged-enum
registry for any native `Enum` before falling through.

This is a narrow fix at the caller, not a repair of PASS B. The prefix
fallback still claims *unregistered* native types whose names collide with a
bridge name; narrowing it is tracked separately, since doing so needs
`nativeNames` declared on the bridges that currently rely on the loose match.

## 0.41.0

### Fixed — every `await` in a statement resumes with its own value (scc40)

Resuming a suspended statement re-evaluates it from the top, and every `await`
in it consulted the same per-frame `lastAwaitResult` slot. So the second and
later awaits replayed the *first* future's result: `(await a) + (await b)`
evaluated to `'AA'`. A silent wrong answer, not a crash, which is why the
suites stayed green around it for so long.

The slot is replaced by `AsyncExecutionState.resolvedAwaitResults`, a map from
await site to the value that site resolved to, filed via the new
`AsyncSuspensionRequest.awaitNode`. An already-resolved site replays its own
value; a site not yet reached falls through and suspends properly. The map is
scoped to one evaluation of one statement — `resumingStatementHasMoreAwaits`
says whether that evaluation is still running, and the state machine clears the
map as soon as it is not, because a loop body re-enters the identical AST node
on every iteration and would otherwise replay the previous iteration's value.

**A second defect fell out of the first (scc41).** While a not-yet-reached
await short-circuited to `lastAwaitResult`, nothing actually read its operand.
Once it began evaluating that operand for real, the resumption path's failure to
restore the frame's environment became reachable: `return a + await b` raised
`Undefined variable: b`. The re-evaluation branches now restore
`visitor.environment` alongside `currentAsyncState`.

**Known limitation, not fixed here.** The variable-declaration resumption route
still binds the first awaited value straight to the variable instead of
re-evaluating the initializer, so `var s = (await a) + (await b);` yields `1`
rather than `3`. The return-statement route is correct. Tracked separately.

The per-site map is keyed by identity. In the mirror tree that is load-bearing:
`SAstNode` overrides `==` with a `toJson()` deep diff, which would run on every
lookup on a hot path and would fuse two await sites whose entire subtrees
serialize identically.

## 0.40.0

### Fixed — an unhandled AST node announces itself instead of answering null (scc33)

`InterpreterVisitor` never overrode `visitNode`, so a node type with no handler
fell through to `SAstVisitor`'s default and the expression evaluated to `null`.
A gap in an *evaluating* visitor therefore produced a value rather than a
failure, and the program carried that value until something several frames away
could not take it.

**The cost is the diagnosis, not the null.** `#foo` was silently `null` for the
life of the project (fixed in 0.15.0 / SCB11), and the eventual error —
`type 'Null' is not a subtype of type 'Symbol' in type cast` — was raised inside
a *bridge*, which is the one place the defect was not. Every such gap accuses
the wrong component.

`visitNode` now raises a diagnostic naming the node's runtime type and source
offset. The sequencing was deliberate and is the reason this is safe to ship:
instrument the default to log rather than raise, run the suite, add handlers for
everything that legitimately arrived, and only then flip to raising.

**The mirror's symptom was narrower than the analyzer tree's, and quieter.**
`GeneralizingAstVisitor.visitNode` *recurses* into the node's children;
`SAstVisitor.visitNode` does not — it simply returns `null`. So where the
analyzer tree mis-resolved a named argument's label as a variable (a wrong
value, sometimes right by accident), this tree just produced nothing: a
redirecting `A() : this.named(a: 5)` passed `null`, not `5`. One site was
affected rather than several, because only that site *dispatches* a named
argument instead of reading it field-wise.

`callable.dart` now **unwraps** a named argument rather than dispatching it.
Dispatching and then re-reading `arg.expression` would evaluate the argument
twice and run its side effects twice.

Measured, not assumed: zero unhandled nodes fire across this package's 518
tests, nor across `tom_d4rt_exec`'s 2745 driven against these sources. Covered
by `test/runtime/scc33_unhandled_node_test.dart`.

**Note for consumers.** A script that previously ran and produced a wrong value
may now raise. That is the point of the change, but it is a behavioural break in
the strict sense — if a script depended on an unhandled node yielding `null`, it
will now fail loudly. No such node fires in any suite.

### Changed — the `tom_ast_model` constraint is upper-bounded

`tom_ast_model: ">=0.2.0"` becomes `^0.2.0`. This package *interprets*
`SAstNode` trees, so a breaking change to the model is a breaking change here;
the open constraint promised support for every future model version and would
have let pub pair an interpreter with a model it cannot read.

## 0.39.0

### Fixed — a bridged value is now a value key, not an identity key (scc32)

Every value produced by a bridged *constructor* is a `BridgedInstance` wrapper,
and that wrapper overrode only `toString()`. So it compared and hashed by
identity, and two separately constructed wrappers around equal natives were
different keys: `{Duration(seconds: 1): 1}[Duration(seconds: 1)]` was `null` and
`{Symbol('a')}.contains(Symbol('a'))` was `false`.

**The shape is what made it dangerous.** `a == b` on two such values answered
`true`. A script therefore got the right answer from `==` and the wrong answer
from every hash-based collection, with nothing raised on either path.

**`==` was never routed to the native.** It had been assumed that only
`hashCode` was missing. It was not: the `true` came from
`visitBinaryExpression`, which unwraps *both operands* to their natives before
comparing — the wrapper's own `==` was never consulted. So the fix needs `==` as
much as `hashCode`, and the symptoms were wider than hashing:
`[Duration(seconds: 1)].contains(Duration(seconds: 1))` was `false` and
`indexOf` was `-1`, neither of which hashes at all.

**Wrapper equality alone was not sufficient, and would have made things worse.**
D4rt reaches a map by two different routes. `m[k]` passes `k` through untouched,
so the lookup key arrives as a *wrapper*; `m.containsKey(k)` is a bridge method
call whose arguments are unwrapped on the way in, so the same key arrives as a
bare *native*. Dart's hash lookup asks `lookupKey == storedKey` — the lookup key
is the receiver — so a wrapper looking up a stored native resolves through the
new `operator ==`, while a bare native looking up a stored wrapper is rejected by
the native's own `==`, which no code in this package can override. Fixing only
the wrapper made `[]` work while `containsKey` stayed broken, leaving the two
spellings in disagreement rather than uniformly wrong.

The fix therefore has two halves, and both are required:

1. `BridgedInstance` delegates `==` and `hashCode` to its wrapped native,
   including across the wrapper/native boundary. This is the same choice
   `BridgedEnumValue` already made, for the same reason.
2. Hash keys are normalized to the native **at storage** — map-literal keys and
   set-literal elements, including the null-aware spelling — so a stored key is
   never a wrapper and the unfixable direction cannot arise.

The second half generalizes RC-7, which already did exactly this for
`BridgedEnumValue`; it **replaces** that enum-only special case rather than
sitting beside it.

**Cross-boundary equality is required, not speculative.** D4rt is inconsistent
about wrapping: a constructor yields a wrapper, but every bridged *method* return
yields a bare native. `DateTime(2021).difference(x)` and `Duration(seconds: 1)`
are the same value in two representations and routinely meet in one collection.
That inconsistency is itself a defect and is tracked separately as SCD98.

**Unchanged on purpose.** Interpreted classes keep Dart's own semantics — a
plain one still keys by identity, one that defines `==`/`hashCode` still
collapses. List elements keep their representation, because a list is not
hash-keyed and the wrapper's `==` now answers correctly on its own. Map *values*
are untouched; only keys have a bucketing role.

Covered by `scc32_bridged_value_key_test.dart` (21 cases), two of which are
source scans pinning both halves of the fix into both mirrored trees.

## 0.38.0

### Fixed — an undefined name can no longer be swallowed by script code (scc31)

Reading a name that resolved to nothing raised a plain `RuntimeD4rtException`,
and a bare `catch (e)` in the interpreted program caught it like any ordinary
runtime condition. Real Dart never gets that far: an undefined identifier is a
*compile-time* error, so the program does not run and there is no frame in which
a handler could execute. D4rt was therefore more permissive than Dart in the one
direction that hides bugs — a typo did not fail the script, it took whichever
branch the handler wrote, and execution continued on a value the author never
intended.

**A type, not a resolver.** The complete fix is to resolve names before
execution and reject the program, which is a project rather than a release; it
is recorded as SCD95 and is still the target. What lands here is the half that
removes the bug-swallowing: `undefinedNameError(name)` raises
`UndefinedNameD4rtException`, and both catch-dispatch sites decline to match any
clause against it, so the failure unwinds past every handler to the host.

**Both dispatch sites, and the second one is the surprise.**
`visitTryStatement` performs real `on T` matching, so a guard there is the
obvious half. But an `async` body unwinds through `_handleAsyncError` in
`callable.dart`, which takes `catchClauses.first` with *no type matching at
all* — measured before the fix, an undefined name inside an `async` function was
swallowed even by a clause as narrow as `on FormatException`. A guard in only
the first site would have left the async path broken and looked correct.

**`finally` still runs.** The guard empties the clause list rather than
short-circuiting the block, so cleanup executes on the way out and the error
still propagates. The property wanted is "no *catch clause* can claim it", not
"no cleanup happens".

**A subtype of `RuntimeD4rtException`, deliberately** — the same reasoning as
`UndefinedMemberD4rtException` (SCC28). `Environment.get` throws on every miss
and is called *speculatively* throughout the interpreter and the module loader,
each caller catching `RuntimeD4rtException` to try the next lookup strategy. A
sibling type would have stopped all of those from catching, turning ordinary
resolution fallbacks into hard failures.

Host code is unaffected: the change makes *interpreted* clauses skip and says
nothing about catching around `execute()` / `eval()`, so the REPLs still report
a typo at the prompt.

The extension-resolution path also stops branching on
`e.message.contains("Undefined variable: …")` and asks
`e is UndefinedNameD4rtException && e.name == onTypeName` instead — the last
variable-side instance of the message-as-branch-condition pattern SCC28 removed
for members. Besides making a formatted diagnostic load-bearing, the old check
fired whenever the type name merely *appeared* in an unrelated failure's
message.

F-SCB10-16 is rewritten rather than deleted: it is the only test pinning what
happens to an undefined name, and it now asserts the escape it used to assert
the swallowing of.

## 0.37.0

### Fixed — division by zero now produces the SDK's own outcome (scc30)

`1 ~/ 0` raised `RuntimeD4rtException('Integer division by zero.')`. Real Dart
raises `IntegerDivisionByZeroException`, which is an `UnsupportedError`, so a
script could catch it by neither name nor supertype — the same defect SCB10
fixed for four other operations, at a site outside the four it named.

**The guards were the bug, so they are gone rather than corrected.** Each arm
tested `right == 0` and threw a hand-written message. But both operands are
already native `num`s at that point, so `left ~/ right` dispatches straight to
the SDK operator, which raises exactly the right exception on its own. The
guards were not translating the SDK's behaviour, they were pre-empting it, and
every way they differed from it was a divergence. Deleting them is a smaller
implementation that cannot drift again, because there is no longer a second
implementation to drift from.

**The audit that came with it found four more divergences**, all from the same
root cause. `right == 0` is also true of `0.0`, so the guards fired on doubles,
where Dart does not throw at all — `1.0 % 0.0` is `NaN`, and `1.0 ~/ 0.0` is a
different SDK error about converting Infinity to an int. And the compound
operators carried their own copy of the guards, so `x /= 0` threw while `x / 0`
twenty lines away correctly returned `Infinity`: one operator disagreeing with
itself depending on which form was written. All now match the SDK.

`IntegerDivisionByZeroException` is registered as a bridged class so
`on IntegerDivisionByZeroException` resolves. Without it the clause would not
error — it would simply never match, and the script would silently take a
branch it never meant to take.

**The message is a genuine loss, and matching the SDK is why.** The SDK
exception carries no message, so `toString()` degrades from
`Integer division by zero.` to the bare `IntegerDivisionByZeroException`.
Preserving the friendlier text would mean inventing a subclass the SDK does not
have, leaving scripts catching a type that exists nowhere else. The type is
deprecated but is still what the VM throws; d4rt no longer names it in
production code, so if a future SDK narrows it to a plain `UnsupportedError`,
d4rt follows automatically.

Also fixed at the premise: `eval_method_test`'s `I-MISC-31` asserted
`throwsA(anything)` under a comment naming `IntegerDivisionByZeroException` —
vacuous, and it passed equally before and after this change.

## 0.36.0

### Fixed — a declared parameter type is now checked when the caller binds it (scc29)

`String f(String s) => s;` invoked as `f(42)` returned `42`. Real Dart raises
`TypeError: type 'int' is not a subtype of type 'String' of 's'`. The
interpreter checked *return* types and nothing else, so the one direction that
catches a **caller's** mistake was the missing one — and it failed silently: the
wrong-typed value flowed into the body and misbehaved somewhere further in, so
the reported symptom pointed at the callee rather than at the call. Measured
before the fix, positional, optional, named, method and constructor parameters
all passed the wrong value through; this was never limited to dynamic dispatch.

The check runs in `InterpretedFunction._prepareExecutionEnvironment`, on the
value the binding loop is about to define. That is the single point every call
shape funnels through — direct, dynamic, method, constructor, closure, tear-off
— so one site covers all of them. The predicate is `RuntimeType.isSubtypeOf`,
the same one the return-type check uses; only the presentation differs. The
error is `D4rtTypeError` with the SDK's **runtime** wording, because that is the
shape a real program's `on TypeError` clause matches — deliberately not the
return path's `RuntimeD4rtException` quoting the analyzer's compile-time
diagnostic.

**Scope is caller-provided arguments only.** A value the *declaration* produced
— an omitted optional's implicit `null`, an evaluated default — is not checked.
Real Dart rejects those at compile time, so a runtime check could only ever fire
on programs the analyzer already refuses, while breaking the interpreted scripts
that rely on `[String s]` meaning "may be absent".

**Permissive wherever it cannot be sure**, because a false positive rejects a
correct program and that is worse than the silent pass it replaces: `dynamic`
and unannotated parameters, annotations that fail to resolve, function- and
record-typed annotations, and type parameters the call site left unbound. That
last one has two halves the obvious reading collapses into one — an *inferred*
`T` and a raw `Box()` resolve to a placeholder and are waved through, but an
explicitly bound `f<String>(...)` or `Box<String>()` resolves to a real type and
**is** checked, matching real Dart.

Also fixed at the same site: an `int` bound to a `double` parameter is now
widened, as Dart widens it. Without it the body received an `int` where its own
annotation promised a `double` — the same silent-wrong-value shape, one step
further in. The return path already applied the identical conversion at the
other end of the call.

Two existing tests had encoded the defect as expected behaviour and were fixed
at the premise rather than by loosening their assertions: `I-MISC-29` in
`eval_method_test.dart` was named "Should throw error for type mismatches" while
asserting that `int add(int a, int b)` called with two Strings returns
`'helloworld'`; and `F-SCC27-5` passed a bare `'rethrow'` where main's argv list
belonged, reaching its intended branch only because `String` also has `isEmpty`.

## 0.35.0

### Changed — "member absent" is a type, not a sentence (scc28)

Mirrors `tom_d4rt` 1.46.0, site for site. `UndefinedMemberD4rtException` (a
`RuntimeD4rtException` subtype carrying `memberName`) replaces the
`e.message.contains("Undefined property '$name'")` test at the eight sites that
chose between extension-method resolution and propagating an inner failure.
Eleven raise sites across `interpreter_visitor.dart`, `runtime_types.dart` and
`bridge/bridged_types.dart` now throw it; `rewrapPreservingMemberSignal` carries
the signal through the five sites that add context by concatenating the original
message.

Not breaking: the new type is a subtype of what was thrown before and inherits
`toString()`, so every `on RuntimeD4rtException` clause and every printed
diagnostic is unchanged.

`test/runtime/scc28_typed_undefined_member_test.dart` is unit-level rather than
script-level, for the DGUC6 reason the SC5 and SCB10 mirror suites give:
`tom_d4rt_exec` resolves this package from pub.dev, so no script-level runner
can see unpublished local edits. What it pins is the half the reference tree's
source scan cannot — that the signal **survives being re-wrapped**, and that
re-wrapping an ordinary runtime failure does not *invent* it. Inventing it would
send a genuine error down the extension-lookup branch, where a same-named
extension member answers in its place.

## 0.34.0

### Changed — an error keeps its type when it leaves the runner (scc27)

Mirrors `tom_d4rt` 1.45.0, and the defect on this side had a different shape
worth recording. `D4rtRunner._executeInEnvironment` had no catch-all to relabel
anything, so nothing here ever read "Unexpected error:" — but its one `on
InternalInterpreterD4rtException` clause unwrapped an *interpreted* `throw` and
left a *native* callee's error inside the `RuntimeD4rtException('Native error
during …')` wrapper the bridged call site builds. Different cause, same
observable consequence: `on FormatException` worked inside a script and not at
the call site that ran it.

That clause is now `catch (e, s) => throwAsHostFacingError(e, s)`, the same
rule the reference tree states: an `Error` or an `Exception` leaves as itself
with its original stack trace; a value in neither hierarchy and the four
control-flow carriers do not. The async path gets it too, via `onError` on the
future an `async main` reports through.

New in `exceptions.dart`: `throwAsHostFacingError` and
`isInterpreterControlFlowSignal`. **Removed: `isSdkShapedError`** — SCB10's
four-type carve-out, which the general rule subsumes.

**Breaking for a caller that matched on the wrapper.** `on
RuntimeD4rtException` around `executeBundle` no longer catches a failure a
script or a native callee produced; name the type. `F-SCB10-AST-4` now asserts
the rule instead of the deleted predicate — the coverage is unit-level because
this package cannot parse source, and the script-level equivalent
(`scc27_host_error_fidelity_test.dart`) lives in `tom_d4rt` with a
publish-pinned entry in exec's SCC6 drift guard.

## 0.33.1

### Changed — formatted the tree once, at the aligned language version (scc26)

Mirrors `tom_d4rt` 1.44.1. This half of the mirror was already tall-styled in
places and not in others — the drift `dart format` leaves behind when it is run
on one file at a time. Formatting the whole tree settles it.

The reformat landed as its own commit, containing the formatter's output and
nothing else. That it was inert was not assumed — `git diff -w` cannot establish
it, because the tall style *splits* lines and a whitespace-insensitive diff
still counts a moved line boundary as a change. What was checked instead is the
token stream: strip all whitespace and the two revisions of every changed file
are either identical (153 files) or identical once trailing commas are also
stripped (893 files), commas being pure formatting punctuation in Dart. Zero
files carried an edit that survived both passes.

### Added — a guard so the style divergence cannot silently return

`test/scc26_format_alignment_test.dart` pins the three facts the alignment rests
on: every mirrored package declares an SDK floor at or above 3.7 (so the
formatter cannot pick different styles for them), this package's tree is
formatted, and the sibling `tom_d4rt` tree is formatted. The sibling check skips
when the sibling is not checked out beside this package, since a copy resolved
from pub.dev genuinely cannot answer that question and a red test there would be
noise rather than a finding.

The prohibition this replaces had already been written down once, informally,
after the previous encounter with the problem — and it did not hold. That
revert missed `stdlib/io/socket.dart`, and 1926 lines of divergence sat in the
tree undetected until they were measured. A rule that must be remembered by
everyone who edits one of 119 mirrored files, at the moment they reach for a
reflex command, is not a control.

## 0.33.0

### Changed — braced the long single-line `if`s ahead of the format alignment (scc26)

Mirrors `tom_d4rt` 1.44.0. This package's SDK floor was already honest at
`^3.10.4`, so nothing moved there; what changed is the seven braceless
single-line `if` statements that exceed the column limit. The tall-style
formatter splits such a line in two, and the split is what makes
`curly_braces_in_flow_control_structures` fire — so bracing them now keeps the
following format pass provably free of semantic hunks.

No behaviour changes.

## 0.32.0

### Fixed — `listen(null)` now works on every bridge, not two of nine

Mirrors `tom_d4rt` 1.43.0. `Stream.listen` declares its first parameter as
`void Function(T)?`, so subscribing for `onDone` / `onError` alone is ordinary
Dart — but of the nine bridges implementing `listen`, only `Stream` and `Socket`
accepted it. The four socket-family bridges cast to a non-nullable function and
died with `type 'Null' is not a subtype of type 'InterpretedFunction'`, an
internal crash rather than a diagnosable script fault; `Stdin`, `HttpServer` and
`HttpClientResponse` threw `listen requires an onData callback.`, a restriction
d4rt invented and the platform does not have. All nine now share one
`bridgedStreamListen` that keeps the SDK's contract, which also fixes
`socket.listen()` with no arguments (previously a `RangeError` from an unguarded
`positionalArgs[0]`) and routes every `onError` through `errorHandlerArgs` once.

### Changed — one `runAction`, replacing four private copies

`_runAction` existed in four private copies in two incompatible shapes (`T?` and
`FutureOr<T>`), differing only for a null function with a non-nullable `T`. None
of the 84 call sites awaits the result, so the merged helper takes the nullable
form. The `try { … } catch (e) { rethrow; }` the copies carried is a no-op and
is not reproduced.

The behavioural cases live in `tom_d4rt`, which has the parser to run them; the
two structural guards that keep the duplication from growing back sweep **both**
trees, so a copy reappearing on this side fails there.

## 0.31.0

### Fixed — bridge coverage gaps found by a mechanical sweep, not by accident

Mirrors `tom_d4rt` 1.42.0. A `BridgedClass` claims the SDK's private
implementation types by listing them in `nativeNames`; a type that is not listed
resolves to no bridge, so the value comes back successfully and is then
completely inert — every member on it fails with "Undefined property or method
'x' on _Whatever". Worse, the gap hides itself: if `Codec.inverted` cannot be
used, nobody writes a test that uses it, so the code behind the missing name
goes untested too.

`test/scc24_native_name_coverage_test.dart` replaces four accidental discoveries
with a check. It invokes every instance getter on every registered bridge
against a real native instance and asks the resolver what claims each result —
no return types, no argument construction, and no private type name written down
anywhere, so an SDK rename keeps the test working rather than breaking it.

The file is a byte-for-byte copy of the `tom_d4rt` original apart from its
import prefix. It was written script-free specifically so this package could
carry it: there is no parser here, so a script-driven probe could not have been
mirrored at all.

Eight unclaimed types were found and fixed across five bridges:

- `Iterator` — `_LinkedListIterator`, `_AllMatchesIterator`,
  `_TypedListIterator`. The last covers every typed list, so `.iterator` was a
  dead end on `Uint8List` and friends.
- `Converter` — `_FusedConverter`, `_JsonUtf8Decoder` (the bridge had no
  `nativeNames` at all).
- `Codec` — `_InvertedCodec`.
- `Stream` — `_FileStream`, what `File.openRead()` returns.
- `OSError` — a missing *bridge*, not a missing name: four `dart:io` exception
  bridges return one from `osError`, but the class was never registered, so
  `e.osError.errorCode` was unreachable.

## 0.30.0

### Added — `D4rtRunner.onUncaughtError`, for errors that escape a callback

Mirrors `tom_d4rt` 1.41.0. Some interpreted code is invoked by the *platform*
rather than by the script: the body of a `Stream.listen`, a `handleError`
handler, a `Timer` callback. When one of those throws, native Dart sends the
error to the current `Zone` and lets the enclosing `main()` return normally —
and d4rt matched that, correctly.

The hole it left is that `Zone`, `runZoned` and `runZonedGuarded` are
deliberately unbridged, so an interpreted script had no way at all to observe
its own callback failing, and a host that only inspected the execution result
had none either.

```dart
final runner = D4rtRunner();
runner.onUncaughtError = (error, stackTrace) {
  log.warning('script callback failed', error, stackTrace);
};
```

The contract:

* **Only escapes reach the hook.** Anything that propagates through the
  execution's return value or thrown exception stays on that path and is not
  also reported here.
* **The error is the value the script actually threw.** The interpreter's
  internal `InternalInterpreterD4rtException` wrapper is removed first, and a
  bridged exception is unwrapped to its native object, so this path agrees with
  the synchronous one.
* **A hook contains the error** — reported to the hook, not forwarded to the
  enclosing zone, which is what makes it usable as a sandbox boundary by a host
  running untrusted script. A hook that itself throws is not swallowed.
* **It is opt-in.** With no hook set, nothing changes.

Setting the hook makes the runner own the *error zone* for the execution, which
is a real change to an embedder's error routing — hence opt-in, and hence no
zone fork otherwise. A zone specifying `handleUncaughtError` *is* a new error
zone, and Dart refuses to carry an error across an error-zone boundary; forking
unconditionally would stop an ordinary script failure from ever reaching the
caller.

The fix sits at the one execution chokepoint rather than in each stdlib adapter,
so it covers every interpreted callback the platform invokes.

## 0.29.0

### Fixed — an empty `catch` block abandoned the rest of an `async` function

`try { ... } catch (e) {}` — swallow the error and carry on — is an ordinary
idiom, and inside an `async` function it silently discarded everything after the
try. The function did not throw and did not hang; it resolved to whatever
happened to be in the state machine's `lastResult` at the moment the error was
caught. So this returned `null` rather than `['after']`:

```dart
main() async {
  final seen = [];
  try { throw 'x'; } catch (e) {}
  seen.add('after');
  return seen;
}
```

and if the `try` had awaited before throwing, it returned `1` — the value of the
last `await`, presented as the function's result. That is the worst shape a bug
can take: no error, no stall, just a plausible wrong answer.

The cause is one line in `_handleAsyncError`. Resuming into a catch block means
setting `nextStateIdentifier` to the block's first statement, and an empty block
has none — a `null` identifier is the state machine's stop signal. The empty
*try* and empty *finally* analogues were already handled in `_runStateMachine`;
the catch case was the one that had been missed. It now resumes exactly where a
non-empty catch resumes after its last statement: the `finally` block if there
is a non-empty one, otherwise the statement following the whole `try`.

Only the empty-body case changes. Sync functions were never affected (they do
not go through the state machine), and a catch containing so much as one
statement always worked.

Mirrored from `tom_d4rt` 1.40.0, where it is pinned by F-SCC22-13..17. The
`tom_d4rt` release also adds the io error-handler arity coverage those tests
accompany; F-SCC22-11/12 assert this tree's 15-site map alongside the reference
tree's, so the two cannot drift apart.

## 0.28.0

### Fixed — `on T` in a catch clause answered a smaller question than `x is T`

The catch clause carried its own type test: a flat switch over sixteen hardcoded
type names plus a bridge-identity probe. It was never a copy of the `is`
operator's predicate — it was a *smaller* one, and four of the differences were
user-visible bugs, two of them in the dangerous direction:

- `on Exception` and `on Error` did not catch a script class declared
  `implements Exception` / `implements Error`.
- **`on List<int>` caught a `List<String>`**, and `on Box<int>` caught a
  `Box<String>` — type arguments on the catch type were discarded, so the
  handler ran with a value of the wrong type bound to its parameter.
- `on int Function(int)` and `on (int, String)` were rejected as "unsupported
  type nodes" and never matched.

`on T` now asks exactly the question `x is T` asks, through the same
`_valueHasType` predicate `is`, declared-type checks and typed patterns use.
One deliberate asymmetry is kept and commented: an unresolvable `on T` MISSES
rather than throwing, so a failed type lookup cannot replace the exception being
dispatched.

This also **re-converges the two trees**. The prefixed-`on` case had drifted:
the analyzer's `NamedType.name` drops the import prefix while this tree's
`SNamedType.name` keeps it, so `on c.HashSet` fell through in `tom_d4rt` and
caught here. The shared predicate reassembles the prefix in both.

### Fixed — no bridged exception was an `Exception`

`FormatException('x') is Exception` answered `false`, and so did the same
question about `TimeoutException`, `SocketException`, `FileSystemException` and
every other bridged exception: the error side of `dart:core` has declared its
supertype edges since RC-7, the exception side had none. It went unnoticed
because `on Exception catch (e)` used to read the native object directly instead
of consulting the type test. `ExceptionHierarchyCore` now declares the chain,
each edge once as the SDK declares it — registry edges only, with no
`isAssignable` on `Exception`, which would make the root steal member dispatch
from its own subtypes.

## 0.27.0

### Fixed — a type test stopped two levels up the supertype chain

`BridgedClass.isSubtypeOf` consulted the supertype registry for a class's direct
supertypes and ONE further hop, then gave up — so a bridge three levels deep
answered `false` to an `is` against its own root, while the MEMBER walk, reading
the same registry through `transitiveSupertypeNames`, went all the way down. A
class could resolve its inherited methods correctly and deny being a subtype of
the interface it inherited them from. The predicate now delegates to
`transitiveSupertypeNames`, keeping the direct hit as a short circuit.

The `dart:collection` and `dart:convert` hierarchy blocks spelled their
transitive closures out by hand to work around this; each edge is now declared
once, as the SDK declares it. The change is closure-preserving and unobservable
outside `bridged_types.dart`.

`transitiveSupertypeNames` is memoised and the cache dropped on
`registerSupertypes`, so consulting the closure on the `is`/`catch` hot path
costs 0.056us rather than the 0.379us an uncached walk measured.

## 0.26.0

### Fixed — a typed pattern never checked its type, so the first arm of every switch won

`case int _` accepted a String, and so did `case Map m`, `int _ =>` in a switch
expression and `if (x case int _)` — so the first arm of any switch statement,
switch expression or if-case was selected regardless of the scrutinee.
`_matchAndBind`'s `SDeclaredVariablePattern` and `SWildcardPattern` branches read
only the pattern's name and never `pattern.type`, so neither had a code path
that could report a mismatch. Both now call `_requireDeclaredType`, a no-op for
an untyped `var x` / `_`.

### Fixed — object patterns matched anything whose type name merely resolved

`case int()` matched the String `'s'` and `int(isEven: true)` called `2` odd:
the object-pattern branch ended in "the name resolves to some `RuntimeType`, so
call it a match". It now asks the `is` predicate. Field extraction reached
neither the `InterpretedInstance` nor the `Map` branch for a native operand and
failed outright; it now reads the member through the value's bridge.

### Changed — one type-test predicate instead of four

`visitIsExpression`'s body is now `_valueHasType(STypeAnnotation?, Object?)`,
called by the `is` operator, typed patterns and object patterns alike. The
catch-clause copy is deliberately left for SCC20. `is!` against a `Type`-valued
native previously returned early and answered un-negated; the caller now applies
the negation.

**The test lives in `tom_d4rt` only for now.** `tom_d4rt_exec` resolves this
package from pub.dev, so the twelve-case matrix cannot be ported until this
version is published — it is pinned in that package's conformance-drift
baseline, to be ported and unpinned in the same commit as the publish.

Mirrors `tom_d4rt` 1.37.0.

## 0.25.0

Mirrors `tom_d4rt` 1.35.0 — see that CHANGELOG for the full reasoning on each
member. The differences worth knowing on this side are noted below.

### Fixed — `await` inside a `finally`, and the exception that a `finally` swallowed

Three defects in the try/finally region, two of them in the async state machine
(`lib/src/runtime/callable.dart`) rather than in `visitTryStatement`: an async
function decomposes a try into statements so any of them may suspend, and does
not run the visitor's try handling at all.

1. `visitTryStatement` swallowed a suspension raised in a finally block, so an
   `await` there never completed — and it ran the finally on a pass where the
   protected region had itself suspended, so a teardown ran twice.
2. The state machine's resumption callback acted on behalf of a state the
   visitor could no longer see, because the loop's own `finally` had already
   restored `currentAsyncState`. A finally whose last statement was an `await`
   never un-marked its enclosing try and looped for ever.
3. An error passing through a finally with no catch was left in `currentError`,
   which the main loop clears after every statement that completes normally —
   so the finally's first statement erased it and the enclosing `catch` never
   ran. It is now held in `AsyncExecutionState.errorAfterFinally` and re-raised
   from outside the try. The handler search also walks outward past every try
   that has neither a catch nor a non-empty finally, instead of stopping at the
   first one it finds.

**This side has no script-level test for the three.** `tom_d4rt_ast` cannot
parse source, so the regression pin lives in `tom_d4rt`
(`test/scc12_await_in_finally_test.dart`, 11 cases) and is ported to
`tom_d4rt_exec` once this version is published — that suite consumes the
*published* interpreter, so the port cannot precede the release.

### Fixed — `ServerSocket.bind` rejecting an `InternetAddress`

The adapter `toString()`-ed its host argument, so the `InternetAddress` the SDK
signature also accepts arrived as `InternetAddress('127.0.0.1')` and the bind
failed. It is now passed through unchanged.

## 0.24.0

Mirrors `tom_d4rt` 1.34.0 — see that CHANGELOG for the full reasoning on each
member. The differences worth knowing on this side are noted below.

### Added — the seven static argument-validation helpers

`RangeError.checkNotNegative` / `checkValidIndex` / `checkValidRange` /
`checkValueInInterval`, `ArgumentError.checkNotNull`, `IndexError.check` and
`Error.throwWithStackTrace`. Statics get no fallback from the interpreter, so
each was a hard failure rather than a degraded behaviour.

### Fixed — a bridged throw no longer loses its stack trace

`RuntimeD4rtException` gained `originalStackTrace`; 28 wrap sites across
`interpreter_visitor.dart`, `callable.dart` and `runtime_types.dart` pass it,
`visitTryStatement` prefers it over its own, and `wrapDirectiveError` forwards it
when reconstructing. Three sites bind only `catch (e)` and are unchanged.

The wrap-site inventory is now identical on both sides, which it was not when the
mirror started: this tree binds `s` at the bridged instance-method call site
where `tom_d4rt` did not, and reconciling the counts is what surfaced that the
most-travelled wrap site of all had been missed upstream. Aligning the two counts
is the check that found it — a per-file mirror review would not have.

### Added — the `castFrom` family and the long tail

`Iterable.castFrom`, `Map.castFrom`, `Set.castFrom`, `Converter.castFrom`;
`Enum.compareByIndex` / `compareByName`, `Symbol.empty` / `unaryMinus`,
`ProcessStartMode.values`, `String.matchAsPrefix`, `LineSplitter.split`,
`Iterable.iterableToShortString` / `iterableToFullString`,
`StreamSubscription.asFuture`, `ProcessSignal.signalNumber` and
`InternetAddressType.name`. `IterableCore.nativeNames` also claims
`_EfficientLengthCastIterable` and `_LineSplitIterable`, the SDK return types
that made two otherwise-correct statics fail at the first member access.

The enum comparators read the `index` / `name` common to all three enum
representations (native `Enum`, `BridgedEnumValue`, `InterpretedEnumValue`)
rather than casting to `Enum`, which would reject exactly the enums a script
declares itself. `bridged_enum.dart` is already exported from `runtime.dart`
here, so unlike the `tom_d4rt` twin this side needed no extra import.

### Testing note (DGUC6)

The 46 script-level tests for these members live in `tom_d4rt/test/` only. They
cannot run in this tree (no parser) and were deliberately **not** ported to
`tom_d4rt_exec`, which resolves `tom_d4rt_ast` from pub.dev: every member they
assert exists only in the working tree, so all 46 would fail against the
published interpreter for a reason no reader could act on. They are recorded in
`tom_d4rt_exec/test/conformance_drift_test.dart`'s `_uncoveredBaseline` with this
publish as their flip condition — port them and delete the entries in the same
commit that consumes 0.24.0.

## 0.23.0

Mirrors `tom_d4rt` 1.33.0.

### Added — `bool` implements `&`, `|`, `^` and their compound forms

Dart declares `& | ^` on `bool` as well as on `int` — the non-short-circuiting
siblings of `&& ||`, and the only form that expresses "evaluate both operands
regardless". Neither was implemented, at either dispatch site: `a & b` threw
`Unsupported binary operator "AMPERSAND"` and `a &= b` threw the distinct
`Compound assignment operator &=`. Both sites now handle `bool` operands.

Note that this interpreter keys compound operators by **string** (`'&='`) where
`tom_d4rt` keys them by `TokenType` — searching for `AMPERSAND_EQ` here finds
nothing, which is worth knowing before mirroring a compound-operator fix.

Only `bool`-`bool` is accepted: `true & 1` is a type error in Dart and remains
one here. Non-short-circuit evaluation is inherent — both operands are evaluated
before the binary switch is reached — and is now pinned by a test.

### Added — `Queue`'s own surface, and with it `ListQueue`'s

`Queue.remove`, `removeWhere`, `retainWhere` and the static `Queue.castFrom`.
These are the members `Queue` declares itself; the rest of its surface arrives
through the `-> Iterable` supertype edge. Registering the three mutators on
`Queue` also closed the same gaps on `ListQueue`, which declares a `-> Queue`
edge — `list_queue.dart` is unchanged. `castFrom` needed writing on `Queue`
directly, because statics are never inherited.

### Fixed — `SplayTreeMap.firstKey()` on an empty map returns `null`

`firstKey()` and `lastKey()` are declared `K?` and return `null` when there is no
such key. Both bridges hand-threw `"Map is empty"`, so `if (m.firstKey() ==
null)` worked as Dart and died here. The invented guards are removed.

### Added — `SplayTreeMap.firstKeyAfter` and `lastKeyBefore`

Both return `null` when there is no greater/lesser key, matching the SDK.

### Fixed — a list literal is now a valid argument to a typed-data list member

The typed-data adapters narrowed their element argument with a bare
`positionalArgs[n] as Iterable<E>`, and d4rt evaluates a list literal to
`List<Object?>`. The cast is about the list's type argument rather than its
contents, so `Float32List.setAll(0, [7.0, 8.0])` failed while the same call with
a `Float32List` argument passed. A `coerceElements<E>` helper in
`inherited_list_methods.dart` now unwraps the container and any
`BridgedInstance` elements at all 28 call sites, widening nothing: an element
whose type genuinely does not match still fails.

Affected on all eleven variants: `followedBy`, `setAll`, `setRange`,
`operator+`; additionally on `Uint8List` (which hand-rolls its own adapter map)
`addAll`, `insertAll`, `replaceRange`. `operator+` also needed the interpreter's
`List + List` fast path to concatenate element-wise, because `List.+` demands
`List<E>` for the receiver's element type.

### Fixed — fixed-length typed lists raise a *catchable* `UnsupportedError`

On `Uint8List`, the failed cast threw before the native call, so
`try { list.addAll(more); } on UnsupportedError { … }` never caught and the
script died instead of recovering. The other ten variants reach the native list
through the `-> List` supertype edge and were already correct.

## 0.21.0

Mirrors `tom_d4rt` 1.31.0.

### Added — `LinkedList.addAll` and `LinkedList.addFirst`

The last two unreachable members of `LinkedList`, and the only two that had to be
written by hand — the other 25 arrive through the `LinkedList -> Iterable` edge.
`addAll` validates and materialises its argument before linking any entry, so a
lazy iterable derived from the same list cannot mutate what it is iterating and a
bad element cannot leave a half-applied `addAll`.

### Removed — `LinkedList.removeFirst`, which Dart's `LinkedList` does not have

**Script-visible break.** `list.removeFirst()` now raises a `NoSuchMethodError`.
The member does not exist on Dart's `LinkedList` (`Queue` has it), so scripts
using it ran here and would not compile as Dart. Replace it with
`list.first.unlink()`, which was already bridged.

## 0.20.1

Mirrors `tom_d4rt` 1.30.1.

### Fixed — a `dart:*` declaration no longer makes a package declaration's bare name ambiguous

0.19.0 (tcca19) made two same-named bridged classes reject the bare name instead
of silently picking whichever registered last. That rule was too broad: it
treated a platform (`dart:*`) declaration and a package declaration as peers,
when Dart does not.

Dart applies **platform-library precedence** — a name from a `dart:*` library is
shadowed by one from a non-platform library, silently and with no ambiguity. So
this is legal Dart, and means painting's `TextStyle`:

```dart
import 'dart:ui';
import 'package:flutter/widgets.dart';

const TextStyle(fontSize: 24.0).copyWith(fontSize: 2.0);
```

`copyWith` exists only on painting's `TextStyle`, and `dart analyze` accepts the
snippet — while reporting the `dart:ui` import as *unnecessary*. `dart:ui` also
declares a `TextStyle`, so under the 0.19.0 rule d4rt rejected the reference:

```
Ambiguous Name Error: The name 'TextStyle' is declared by more than one library
in scope, so it cannot be used unqualified. Candidates:
  ui.TextStyle       (dart:ui)
  flutter.TextStyle  (package:flutter/src/painting/text_style.dart)
```

Any script naming a type that `dart:ui` also declares failed, which is most
Flutter scripts — `TextStyle` alone accounted for every such failure observed in
the flutter-material corpus.

The rule is now platform-vs-non-platform aware. When the candidates for a name
split into platform and non-platform declarations, the non-platform one takes the
bare name and no ambiguity is recorded. Precedence does not depend on
registration order: a `dart:*` bridge registering *after* a package bridge no
longer steals the name, and one registering *before* is displaced as it already
was.

Unchanged, deliberately:

- **Two package declarations are still ambiguous.** The `MarkdownParser` clash
  that tcca19 was written for is untouched — peers with no winner still reject
  the bare name.
- **Two `dart:*` declarations are still ambiguous with each other.** The rule is
  platform *versus* non-platform, not `dart:` being unimportant.
- **The shadowed platform class stays reachable** as `ui.TextStyle`, exactly as a
  prefixed import addresses it in real Dart. Nothing is lost by preferring the
  package declaration. Qualifier aliases are now bound whether or not the bare
  name ends up rejected, which is what makes that guarantee hold in the
  shadowing case too.

`AMBIG-P1`–`AMBIG-P5` pin the five cases: package-wins-when-second,
package-wins-when-first, the qualifier escape hatch, two-platform-still-ambiguous,
and survival across an `importEnvironment`. As everywhere in this tree, the
assertions are registration-level rather than script-level: a script-level run
needs `tom_d4rt_exec`, which resolves this package from pub.dev rather than by
path, so it can only certify a published version.

## 0.20.0

Mirrors `tom_d4rt` 1.30.0 — four stdlib findings from the SDK gap audit. The
`interpreter_visitor.dart` and stdlib diffs are identical to the analyzer tree's;
the tests differ, because this tree has no source parser (see the note at the
end).

### Added — `JsonEncoder.withIndent` and `JsonCodec.withReviver` (SCB25)

Pretty-printed JSON was only reachable through `JsonUtf8Encoder` plus a byte
decode, because the ordinary way to ask for it — the SDK's
`JsonEncoder.withIndent` — was never declared on the bridge. The class itself
was registered, so no audit that counts classes could flag it; only the member
list was short.

Both constructors read their arguments by position rather than by presence,
because null carries meaning in one of them: a null indent selects compact
output, so a missing argument and an explicit null are different cases and only
the first is an error. `JsonCodec.withReviver` is the opposite — its single
positional is genuinely required — so it rejects both absence and null.
`JsonEncoder.indent` is now exposed too.

### Fixed — `dart:io` silently narrowed `StringSink` (SCB26)

`StringSink` was registered twice: `StringSinkCore` from the core registrar and
`StringSinkIo` from the io registrar. Core registers eagerly at construction
while io registers lazily on a `dart:io` import, so the io copy always landed
second and displaced the core one under last-wins — and the io copy had drifted
into a strict subset. **Importing `dart:io` therefore removed `toString`,
`hashCode` and `runtimeType` from `StringSink`.** Both definitions declared
`nativeType: StringSink`, so the collision machinery read it as a benign
re-export and never marked the name ambiguous; the loss surfaced only as a
`Logger.warn`.

`dart:io` re-exports the `dart:core` `StringSink` rather than declaring its own,
so the io definition is deleted rather than re-pointed at core's. `StringSinkIo`
had one consumer (the io barrel, not re-exported from the public surface), so
this is not a public API break.

### Fixed — wrong-arity bridge calls report the member, not a `RangeError` (SCB28)

Calling a hand-written stdlib bridge with too few arguments surfaced a bare list
`RangeError` naming neither the class nor the member. A scanner measured **601 of
the 1203 adapters that index `positionalArgs` doing so with no leading length
check**, over 53 files, with the two trees agreeing to the adapter — so the
too-few half is recognised generically rather than guarded ~1200 times by hand.
`D4.describeArityError` matches the exact field layout Dart's `List.[]` produces
for an out-of-range read on a list of the argument count's length and restates it
as:

```
DateTime.parse expects at least 1 positional argument, but was called with 0.
```

It is consulted from the nine dispatch catch-alls that receive a
script-controlled argument list. A native `RangeError` from *inside* the call
passes through untouched. **Too many arguments cannot be caught generically** —
the dispatcher holds no arity metadata, so the call succeeds and the extra
argument is discarded; that stays a per-adapter guard. `UriData` is guarded in
full; the remaining 52 files are filed with the measurement.

### Changed — an unbridged name says why it is unbridged (SCB30)

A lookup miss on one of the 25 names documented as intentionally unbridged now
appends the reason:

```
Undefined variable: Zone (not bridged: zones intercept the control flow,
scheduling and error handling the interpreter owns, so a bridged Zone would be
a no-op shell; see doc/d4rt_limitations.md)
```

**The `Undefined variable: <name>` prefix is unchanged**, so existing matchers
are unaffected, and an ordinary typo still gets the bare message. This reaches
lookup failures only — a missing *member* on a class that IS bridged fails one
layer deeper as `D4rtNoSuchMethodError` and still carries no reason. (The
referenced document lives in `tom_d4rt`, which is where it is canon; this tree
pins the same list at registration level.)

### Note on how this tree is tested

The assertions added here are registration-level rather than script-level:
driving a script needs the analyzer-based front end in `tom_d4rt_exec`, and that
package resolves `tom_d4rt_ast` **from pub.dev rather than by path**, so no
script-level runner can reach unpublished local edits (DGUC6). The
script-level contract for all four items is pinned by the analyzer twin; here the
adapters and the recogniser are invoked directly.

## 0.19.0

### Fixed — two packages declaring the same class name resolved to whichever registered last (tcca19)

Mirrors `tom_d4rt` 1.27.0.

- Bridged-class registration now carries the declaring library's source URI
  (`Environment.defineBridge` / `defineBridgeLazy`, `AstModuleLoader`,
  `D4rtRunner._registerDefsInto`).
- Two *different* native classes under one simple name make the bare name an
  error: `AmbiguousBridgedNameException`, raised at the reference from
  `Environment.lookup`, naming both declaring URIs. The same class arriving
  twice through two barrels is still not an ambiguity.
- `<package>.Name` reaches each declaring library, with no import prefix
  directive needed.
- A collision that cannot be told apart by package qualifier keeps the legacy
  last-wins behaviour with a warning, so no script is left without a remedy.
- The same-name scavenging fallback in `visitMethodInvocation` is removed: it
  bound the name to whichever same-name bridge happened to declare the requested
  member.

## 0.18.0

### Fixed — the `dart:convert` codec/converter half had no hierarchy, and `Encoding.decodeStream` was unreachable (SCB23)

Mirrors `tom_d4rt` 1.26.0.

- Twenty supertype edges declared for the codec/converter half of
  `dart:convert`. Previously `utf8 is Codec`, `utf8 is Encoding`,
  `JsonEncoder() is Converter` and `LineSplitter() is StreamTransformer` all
  answered `false`.
- `Encoding.decodeStream` is now reachable. It is declared on `Encoding` alone,
  and the `Encoding` bridge had no adapter for it — so the edge and the adapter
  are one change. The adapter casts each chunk with `cast<int>()` rather than
  casting the stream element, since the interpreter supplies `List<Object?>`
  chunks.
- `LineSplitter` gets `-> StreamTransformerBase, StreamTransformer` and
  deliberately **no** `-> Converter`: the SDK declares it
  `extends StreamTransformerBase<String, String>`. `JsonCodec` and
  `Base64Codec` extend `Codec` directly and are not `Encoding`s. Both negatives
  are pinned by tests.
- The edge lists are flattened deliberately: `isSubtypeOf` walks two hops while
  the member lookup is fully transitive, so a minimal set would give correct
  members and wrong type tests.

Dispatch is unchanged — `Codec`, `Converter` and `Encoding` declare no
`isAssignable`, so they never compete for ownership of a native value.

## 0.17.0

### Fixed — `is TypedData` threw, and the typed_data views had no hierarchy (SCB20)

Mirrors `tom_d4rt` 1.25.0.

- `TypedData` was not bridged at all, so `d is TypedData` raised
  `Undefined variable: TypedData` rather than answering. It is now the bridged
  root of the hierarchy, carrying the four interface getters (`buffer`,
  `lengthInBytes`, `offsetInBytes`, `elementSizeInBytes`) and — deliberately —
  no `isAssignable`, since that predicate decides bridge *ownership* and a root
  claiming it would compete with the twelve implementors for every typed buffer.
- Supertype edges declared for the eleven list views (`-> TypedData`, `-> List`,
  `-> Iterable`) and for `ByteData` (`-> TypedData` only; it is not a `List`).
  `is Iterable` previously answered false on every view.
- `is List` already worked, via the `isAssignable` fallback plus the `List`
  bridge's predicate, and is unchanged. The `-> List` edge is declared anyway so
  the hierarchy no longer depends on `List` keeping that predicate.

No member was lost or gained — the views declare their inherited `List` surface
explicitly — so this corrects type tests only.

## 0.16.0

### Fixed — `.iterator`, `SplayTreeMap.entries`, and `Map.addEntries` (SCB17)

Mirrors `tom_d4rt` 1.24.0. Three defects on the map/set surface:

- The `Iterator` bridge's `nativeNames` listed three implementations, so
  `.iterator` was claimed by no bridge for anything but a `List` — including a
  bare `<int>{}` literal and every map key/value/entry view. Eleven names
  added, enumerated from the SDK rather than guessed.
- `_SplayTreeMapEntryIterable` was missing from the `Iterable` bridge, making
  `SplayTreeMap.entries` unusable while every other map's view worked.
- `HashMap` and `LinkedHashMap` each carried a local `addEntries` doing
  `newEntries.cast()`, which cannot unwrap a `BridgedInstance<MapEntry>`.
  `MapCore`'s copy does; `SplayTreeMap`, with no local copy, already worked by
  inheriting it. The two duplicates are deleted rather than a third correct
  copy added. Because a `<String, int>{}` literal *is* a `LinkedHashMap`, this
  broke `addEntries` on ordinary map literals too.

The map/set *hierarchy* — SCB17's stated subject — was already correct;
`CollectionHierarchyCollection` registers those edges and SCB7 closed that
gap. Verifying the premise is what redirected the work.

Coverage here is **registration-level**
(`test/runtime/stdlib_map_set_inherited_surface_test.dart`) rather than
script-level, for the reason the SC5/SC6/SC7 mirrors give: `tom_d4rt_exec`,
the only runner that could execute a script against this tree, resolves
`tom_d4rt_ast` from pub.dev and so cannot see unpublished local edits. The
script-level equivalent is
`tom_d4rt/test/scb17_map_set_inherited_surface_test.dart`.

## 0.15.0

### Fixed — `await` in receiver position, e.g. `(await f).join(',')` (SCB14)

Mirrors `tom_d4rt` 1.23.0. `visitMethodInvocation` evaluated its target without
checking for the `AsyncSuspensionRequest` sentinel, so when the receiver itself
suspended, the sentinel was treated as an ordinary object and surfaced as
`Undefined property or method '<x>' on AsyncSuspensionRequest`. Every argument
list in the same method already propagated the sentinel; only the receiver slot
did not. The fix is the one-line propagation `visitIndexExpression` has always
had.

Scope is narrower than it looks, and the tests are what established that:
`(await f)[0]` and `(await f).length` were **already correct** — the index and
property-access paths carried the check. `visitMethodInvocation` was the sole
gap.

Two pre-existing async bugs sit adjacent to this one and are *not* fixed here;
the reproductions live in `tom_d4rt/test/scb14_await_receiver_position_test.dart`
as skipped tests naming their todos. (1) A frame has a single
`lastAwaitResult` slot, so the second and later `await`s in one statement all
resolve to the first future's value — `(await a) + (await b)` yields `'AA'`,
with no receiver involved at all. (2) Resumption of an `await` in argument
position whose invocation target is a local re-enters without the enclosing
block scope, so the local reads as undefined.

### Fixed — symbol literals (`#foo`) evaluate to a `Symbol` (SCB11)

Mirrors `tom_d4rt` 1.23.0. `SSymbolLiteral` had no handler, so `#foo` fell
through `GeneralizingSAstVisitor`'s default and evaluated to `null` — silently,
which is why it surfaced as `type 'Null' is not a subtype of type 'Symbol' in
type cast` inside a bridge rather than at the literal.

The two trees reach the same answer by different routes, which is the one thing
to know when keeping them in sync: `tom_ast_generator` already joins the
analyzer's component tokens with `.` when it builds `SSymbolLiteral.value`, so
this side reads the finished name, where `tom_d4rt` joins `node.components`
itself. `#foo.bar.baz` is one library-qualified symbol named `'foo.bar.baz'`,
not a member access on `#foo`, and the equality is by name — a non-const
`Symbol` built here is `==` and hash-equal to the SDK's canonicalised literal.

Verified end to end against `tom_d4rt_exec` over the in-tree sources (the two
implementations agree on all of: plain, dotted, operator, equality, `Map` key,
`toString`, `Invocation.method`, round-trip and const-context cases). The
permanent script-level port into `tom_d4rt_exec/test/` is blocked until this
version publishes, since `tom_d4rt_exec` resolves `tom_d4rt_ast` from pub.dev —
tracked as SCC34, the same shape as SCB12.

### Fixed — the interpreter raises the SDK's own error types (SCB10)

Mirrors `tom_d4rt` 1.23.0. Four raise sites stop producing a
`RuntimeD4rtException` and produce the type real Dart produces, so an `on`
clause in interpreted code can match the operation that failed: `TypeError` for
a failing `as` cast and for `!` on null, `NoSuchMethodError` for a final
member-lookup failure, `AssertionError` for a failing `assert` (statement or
constructor initializer), and `RangeError` for a list index out of range.

`list[9]` raises a plain `RangeError`, **not** `IndexError` — measured against
the platform, whose `List.[]` does not use `IndexError`, so `on IndexError` does
not catch an out-of-range list access. Raising it here would make d4rt strictly
more catchable than Dart.

New `src/runtime/sdk_errors.dart` (exported from `runtime.dart`) holds
`D4rtTypeError`, `D4rtNoSuchMethodError`, `indexRangeError` and
`isSdkShapedError`. The two error classes `implement` rather than `extend` their
SDK counterparts: neither SDK type accepts a message, so using them directly
would discard the diagnostics that name the receiver and the member.
`implements` keeps `value is TypeError` true — which is what the SC5 bridges'
`isAssignable` predicates consult — while `toString()` still returns d4rt's own
text. No message assertion changed as a result; the only retargeted test is the
DGUB8 record cast, now asserting `TypeError`.

The interpreter's *intermediate* member-lookup failures deliberately stay
`RuntimeD4rtException`: nine sites branch on the `"Undefined property '<name>'"`
substring to decide whether to attempt extension lookup, so that text is control
flow. `isSdkShapedError` has no call site in this package — `D4rtRunner` never
had `tom_d4rt`'s `Unexpected error:` catch-all — and is present so the two trees'
copies of the file stay diffable.

### Fixed — error handlers are called with the arity they declare (SCB9)

The SDK accepts an error handler in either arity — `void Function(Object error)`
or `void Function(Object error, StackTrace stackTrace)` — and inspects the
callback to decide which to use. Every d4rt adapter hardcoded the two-argument
call, so the unary form died with `Too many positional arguments. Expected at
most 1, got 2.`

Fourteen copy-pasted sites now route through one `errorHandlerArgs` helper:
`Stream.listen`, the `StreamSubscription.onError` setter, `Future.then`'s
`onError`, `Future.catchError`, `FutureExtensions.onError`, and nine more across
`dart:io`. The selection uses the new public
`InterpretedFunction.maxPositionalArity` rather than `arity`, which counts only
*required* positional parameters and so reports 1 for `(e, [st])` — a signature
native Dart passes both arguments to. `Stream.handleError` had selected on
`arity` and dropped the stack trace for that form.

`StreamTransformer.fromHandlers`' `handleError` is deliberately excluded: its
SDK signature is a fixed `(error, stackTrace, sink)` with no arity variance.

Also fixed: `_HandleErrorStream` was missing from the `Stream` bridge's
`nativeNames`, so every member of a `handleError()` result failed with
"Undefined property or method 'toList' on `_HandleErrorStream`".

### Fixed — `is` and `on` see a bridged collection's supertypes (SCB7)

`x is Map` was `false` for every bridged `dart:collection` map, `x is List`
likewise for `UnmodifiableListView`, and `x is Iterable` for most bridged sets.
Two independent defects were responsible:

- **The type-test switch tested the wrapper, not the value.**
  `visitIsExpression` special-cases the shape types (`int`, `double`, `num`,
  `String`, `bool`, `List`, `Map`) and answered them with a native `is` on the
  operand as it arrived. A bridged value arrives as a `BridgedInstance`, which
  is neither a `List` nor a `Map`. The shape cases now test the underlying
  native object. `Set` and `Iterable` are not in that switch and already went
  down the bridged-subtype path, which is why the `Set` side looked healthy.

- **Nothing declared the `dart:collection` supertype graph.** The new
  `CollectionHierarchyCollection` registers the map, set, list-view, queue and
  `LinkedList` edges with `BridgedClass.registerSupertypes`. It absorbs the
  queue-only block that previously lived in the `DoubleLinkedQueue` bridge —
  one declaration of the library's hierarchy rather than one per file.

Also fixed: catch-clause type matching is a separate implementation with its
own type switch, and it consulted only exact tests, so `on Iterable` missed a
thrown bridged collection that `x is Iterable` matched. It now falls back to
the thrown value's own bridge and the supertype walk.

Registry edges rather than a widened `isAssignable`: that predicate decides
which bridge *owns* a native object in `Environment.toBridgedInstance`, so a
supertype claiming assignability could steal dispatch. The generic-argument
checks (`is List<int>`, `is Map<String, int>`) are preserved.

Mirrors `tom_d4rt` 1.23.0.

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

### Added — the member-level gaps a class-granularity audit cannot see (`ccf041f8`)

Each of these is a member missing from a class the audit already counted as
bridged, so a spot-check that lands on a registered member reports the whole
class as covered. Enumerating the SDK type's members is the only way to see a
partial set.

- `Duration` exposed 6 of its 16 unit constants — `secondsPerMinute` resolved,
  `microsecondsPerDay` did not. All 16 are registered.
- `Uri.base` was absent, so a script could build URIs but not resolve one
  against the process's working directory.
- `UriData` had none of the `isMimeType` / `isCharset` / `isEncoding`
  predicates.
- `ByteBuffer.asUint8ClampedList` and `ByteData.asUnmodifiableView` were the two
  omissions in an otherwise complete reinterpretation surface.
- Set algebra (`difference` / `intersection` / `union`) resolved on a set
  literal but on none of `HashSet` / `LinkedHashSet` / `SplayTreeSet`: the
  interpreter's instance-member fallback through the supertype chain is not
  uniform, so declaring the trio on the `Set` bridge does not reach a concrete
  set. All three now carry it through a shared `setAlgebraMethods` helper, onto
  which the two pre-existing hand-rolled copies (`Set`, `UnmodifiableSetView`)
  were converged so they cannot drift.

The only non-additive part is one diagnostic: `Set.difference(notASet)` used to
fail with a raw `type '…' is not a subtype of type 'Set'` cast error and now
raises `Argument to Set.difference must be a Set.`

Mirrors `tom_d4rt` 1.23.0.

### Added — `sort`, `shuffle`, `asUnmodifiableView` and `bytesPerElement` on every typed list (`9fca5be3`)

Nine of the ten typed-data lists sharing `inheritedListMethods()` could not
sort, shuffle or take an unmodifiable view; `Uint8List` could, because it
hand-rolls its own adapter map — and being the most-used variant, it is the one
a spot-check reaches. `bytesPerElement` was missing on all eleven.

The exclusion had been justified by typed-data lists being fixed-length, which
conflated fixed-*length* with immutable: `sort` and `shuffle` preserve length
and the SDK supports them on every variant. The doc comment now scopes the
exclusion to length-changing operations, with a test asserting `add` still
refuses so the correction cannot overreach. `asUnmodifiableView` arrives through
a **required** `unmodifiableView` callback, since it is declared per concrete
variant rather than on `List<E>` — required, so a new variant cannot silently
omit it. `bytesPerElement` is a static, unreachable by any supertype fallback,
and is fed from the SDK constant itself rather than a literal.

Mirrors `tom_d4rt` 1.23.0.

### Fixed — `StdioType` and `HtmlEscapeMode` constants were registered but unreachable (`9bb876f3`)

Both classes were bridged but inert: their `static const` constants sat in the
bridge's *instance* `getters` map, so `StdioType.terminal` and
`HtmlEscapeMode.element` could not resolve. That is worse than an absent bridge —
`HtmlEscape`'s constructor advertised a `mode` parameter no script could supply
a value for, and a `StdioType` could not be compared against anything.
`stdioType()` was never registered either, so nothing could produce the value
the class exists to describe. Also added: `HtmlEscape.mode`, the four
`HtmlEscapeMode` escape flags, `StdioType.name`, and the missing `sqAttribute`
constant.

Found mechanically, by `tom_d4rt`'s `tool/stdlib_member_diff.dart`, which diffs
each bridged class's adapter-map keys against the SDK type's real member set and
uses the interpreter as the oracle for whether a candidate is genuinely
unreachable. The tool needs `dart:mirrors` and therefore lives in `tom_d4rt`
only; this tree is measured by running it against its twin.

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