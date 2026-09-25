## 0.171.0

### Removed — `ServerSocket`'s 28 copies of `Stream` members (sce195)

`ServerSocket`'s bridge spelled out 21 methods (`listen`, `map`, `where`,
`fold`, `toList`, `transform`, …) and 7 getters (`first`, `length`,
`isEmpty`, …) that `Stream`'s bridge also declares. Since SCD38 registered
`ServerSocket -> Stream`, each shadowed an inherited adapter that would answer
if it were gone, and two implementations of one member on one type drift. They
were deleted only after the SCC51 shadow differential could see them (sce185)
and every pair agreed; `listen` — a server socket's primary use — is covered
by a new case driving a real accepted connection through the inherited
adapter.

### Fixed — arity diagnostics that named the wrong class

`ServerSocket`, `RawSocket` and `RawDatagramSocket` adapters reported arity
errors as `Socket.<member>`, copied from the `Socket` bridge: twelve
diagnostics across the three now name the class the script used.

## 0.170.0

### Fixed — ten stdlib adapters that disagreed with the adapter they shadow (sce185)

The SCC51 differential compares every adapter a bridge redeclares from a
registered supertype against the one it hides. It walked only the fourteen
collection bridges — 537 of 2 076 shadowed pairs. Widened to every bridge that
shadows anything, it found 128 divergences in seven families, each a defect in
one of the two adapters:

- `Runes`: thirteen callback members (`where`, `map`, `any`, `every`, `fold`,
  `reduce`, `expand`, `forEach`, `firstWhere`, `lastWhere`, `singleWhere`,
  `skipWhile`, `takeWhile`) cast the script's callback to a Dart function type,
  which a `Callable` never is, so each threw `_TypeError` on every call.
  Deleted; the inherited `Iterable` adapters serve them.
- `Iterable.reduce`, `Iterable.followedBy`, `List.reduce`, `List.followedBy`,
  `List.setRange`, `Stream.reduce` and `Stream.transform` rejected a script's
  untyped callback, list literal or `fromHandlers` transformer on any natively
  typed receiver (`'ab'.codeUnits.toList()`, `Stream<Socket>`), where the typed
  leaves had coerced all along. They now go through a `cast<Object?>()` view,
  an element-wise copy, or `transformer.bind(source)`.
- `List.shuffle` dropped its `Random`, so a seeded shuffle was not
  reproducible.
- `Sink.close` and `EventSink.close` discarded the `Future` the sink returns.
- `LinkedList.contains` threw on a non-entry instead of answering `false`.
- `WebSocketTransformer.cast` hard-coded `<HttpRequest, WebSocket>`; deleted,
  so `cast()` is `cast<dynamic, dynamic>()` as in Dart.
- The eleven typed lists' `[]=` returned the stored value; the operator is
  `void` (unobservable to a script, which evaluates an index assignment to the
  assigned value itself).

`F-SCE185-1` now holds the differential's fixture table to the registry, so
the walk cannot shrink back to a subset without failing.

## 0.169.0

### Changed — the interpreter/native boundary is stated once, at the entry (sce179)

`Environment._isInterpreterOwned` (is this value the interpreter's own
representation, such as a `RuntimeType`, `RuntimeValue`, `Callable`, native
`Enum` or record?) was consulted at one branch: step 4 of `toBridgedInstance`.
Everywhere else, the name-shaped passes were kept off the interpreter's own
values only by SCD132's corroboration requirement in PASS B, which was
written about bridge-to-bridge false positives. Measured: with that
requirement ablated, `TypeParameter` resolved to the `Type` bridge through
BOTH `toBridgedInstance` and `getRuntimeType`, because the claim came from
PASS B before step 4 could run.

There is now one value-level entry, `_toBridgedClassForValue`, which both
paths go through and which asks the predicate once. An interpreter-owned
value still gets a bridge registered for its exact runtime type, since that
is a declaration, but never one found by name. The step-4 check is gone,
and SCC49's structural fallback now runs inside the entry. With SCD132
ablated, both value paths reject `TypeParameter`: the boundary no longer
depends on it.

`toBridgedClass(Type)` itself cannot ask, because it is given a `Type`, not a
value. Its boundary is still SCD132's, and scd147's guard pins both.

Name resolution: yes — bridge resolution for a value is routed through a new entry; no resolution measured today changes (sce179).

## 0.168.0

### Fixed — the Stream bridge claimed two types that are not Streams (sce178)

scd146's census found two override entries on the `Stream` bridge's
`nativeNames`, both there since the first commit. Measured with the SDK and
the live registry of both interpreters:

- `_StreamIterator` (what `StreamIterator(...)` returns) was inert: its name
  reaches the `StreamIterator` bridge first.
- `_HandlerEventSink`, which implements `EventSink`, was on BOTH the Stream
  and EventSink lists, and registration order made **Stream** win. The live
  registry answered `Stream` for a type that is not one.

Both entries are gone from Stream. With the duplicate resolved, EventSink's
own entry was redundant, since its name reaches `EventSink` by suffix, so it
went too. The type is never handed to script code, so no script changes
behaviour; the registry simply stops giving a wrong answer.
`sce178_stream_override_resolution_test` pins both resolutions in each tree's
live registry.

Name resolution: yes — `_HandlerEventSink` now resolves to EventSink rather than Stream (sce178).

## 0.167.0

### Changed — 85 redundant stdlib `nativeNames` entries removed (sce177)

Since SCC49 the structural pass reaches a private SDK type by the bridge name
it ends with, so most allowlist entries were redundant: 85 of 109, including
all 17 on `Iterator`. They are gone, and both interpreter suites pass. The
analyzer-free line's routing tests now ask `toBridgedClass` which bridge a
REAL SDK object reaches, not whether a name sits in a list.

24 entries remain across 10 bridges: 19 the SDK abbreviates (no suffix rule
reaches them), 2 overrides left to sce178, and 3 kept deliberately. Two of
those are `BytesBuilder`'s: the suffix pass walks the nearest scope frame
first, and in a Flutter app `Builder` (a widget) is a nearer suffix of
`_CopyingBytesBuilder`. Measured with the entries removed, `BytesBuilder()`
resolved to the Builder widget. The census now fails if a redundant entry
survives without a stated reason.

Name resolution: yes — stdlib private types now reach their bridge by suffix rather than by a precise entry (sce177).

## 0.166.0

### Fixed — a `StreamTransformer` was dispatched as a `Stream` on the analyzer-free line (sce160)

`StreamTransformer.fromHandlers(...)` returns a `_StreamHandlerTransformer`,
and that name sat on the **Stream** bridge's `nativeNames`, where it had been
since the repository's first commit. The analyzer-free line resolves a bare
native by its runtime name alone, so

    final t = StreamTransformer<num, num>.fromHandlers(handleData: ...);
    t.cast<int, int>();   // type '_StreamHandlerTransformer<...>' is not a
                          // subtype of type 'Stream<dynamic>' in type cast

The reference line escaped through static types. It surfaced once scd98 made a
bridged constructor return the bare native, and the pre-publish pass found it.

Measured against the SDK, none of the four transformer implementations is a
`Stream`: `fromHandlers` -> `_StreamHandlerTransformer`, the unnamed
constructor -> `_StreamSubscriptionTransformer`, `fromBind` ->
`_StreamBindTransformer`, `cast` / `castFrom` -> `CastStreamTransformer`. All
four are now claimed by the `StreamTransformer` bridge, and the wrong entry is
gone from `Stream`'s list. The last three previously had no bridge at all.

Name resolution: yes — it changes which bridge four native StreamTransformer types resolve to (sce160).

## 0.165.0

### Fixed — calling a value that is not a function returned the value (sce176)

A call through a variable fell through to `return calleeValue` whenever the
value was non-null and not a function, so

    var n = 3;
    n();        // returned 3

and the same for any object. Dart rejects the call; the interpreter now throws
`'n' (type: int) is not callable ...`. The fallthrough had already hidden two
defects (DFUB9, GEN-110), and it was hiding a third, below.

### Added — Dart's callable-object rule for interpreted classes (sce176)

`a(3)` means `a.call(3)` when `a`'s class, a superclass or a mixin declares an
instance method named `call`. Through a variable this used to return the
instance (the fallthrough above); through an expression (`fns[0](3)`) it threw
"not a function". Both call paths now resolve the bound `call` method first.
Bridged objects with a `call` adapter and `call` extensions already worked and
are unchanged.

### Changed — four more failing operations on an unbridged native name the missing bridge (sce176)

scd145 made a member access or method call on a native object that no bridge
claims say so. Indexing, a binary operator, both assignment forms (through a
prefixed identifier and through a property access) and a call now append the
same clause, e.g.

    Unsupported target for indexing: Zqwx. No bridge claims this type: no
    bridged class is registered for the native type Zqwx, ...

Message only, on paths that were already throwing, with the exception types
unchanged. `toString()` on such an object still does not throw: every Dart
object has one, and string interpolation of an unbridged value is exactly how
a script author finds out what it is.

## 0.164.0

### Fixed — SECURITY: the sandbox declared two permissions and enforced neither (sce166)

`AstModuleLoader` had no counterpart to `ModuleLoader._checkModulePermissions`.
A bundle could

    import 'dart:isolate';   // ReceivePort, SendPort, Isolate.spawn
    import 'dart:io';        // the whole filesystem surface

with the embedder granting nothing, on the tree that ships inside Flutter apps
executing bundles downloaded at runtime. `IsolatePermission` and
`FilesystemPermission` were both declared in this package's public API and
consulted nowhere.

THE PERMISSION CLASS BEING PRESENT MADE IT WORSE, not better: an embedder
reading `IsolatePermission` in the API reasonably concludes the capability is
gated. The quest's own constraint is that the interpreter stays fully
sandboxed, and this was the line without the gate.

The reference tree's check is mirrored in, message for message, and called from
`_loadModule` BEFORE the module cache is consulted — as the reference does, so
a second import of an already-loaded library is gated too rather than riding in
on the first grant.

`dart:io` was not in the todo that filed this. It was found by the test written
to reproduce the `dart:isolate` gap, which asked the same question of the other
library the reference gates.

F-SCE166-1..5 in `test/runtime/sce166_module_permission_gate_test.dart` execute
bundles for both refusals, both grants, and an ungated `dart:math` control — a
blanket refusal would pass the four and break every script in the corpus.
`tom_d4rt/test/sce166_permission_enforcement_parity_test.dart` then holds the
general property the single instance implies: every permission either tree
DECLARES is referenced by an enforcement site in BOTH, and the two trees
declare the same set. Measured across all six: they now agree file for file.

Two pre-existing tests asserted the ABSENCE of these gates — they loaded
`dart:io` and `dart:isolate` with nothing granted and expected success. They
now grant first, which is the change rather than a workaround; what they are
about, that the stdlib module loads, is unchanged.

Name resolution: no — an import is refused or admitted; which names bind to
what is untouched.

## 0.163.0

### Fixed — a fuzzy SUFFIX match in a near frame beat a declared `nativeNames` match in an enclosing one (sce162 / scf26)

`toBridgedClass`'s PASS A walked the scope chain once, trying every strategy in
each frame before moving outward. One of those strategies is not precise:
`_longestNameSuffixMatch` is anchored on the BRIDGE's name appearing inside the
native type's name, not on any declared relationship. Running it frame-locally
meant proximity beat precision.

Under the lazy-bridge substrate the Flutter bridges sit in the child frame and
the stdlib bridges in the warm parent, so:

    const <String>{'shiftLeft'}   // an UnmodifiableSetView at runtime
    Widget keyRow(String label, Set<String> mods, String hint) { ... }
    // type 'View<String>' is not a subtype of type 'Set<String>' of 'mods'

`UnmodifiableSetView` is named outright in the stdlib `Set` bridge's
`nativeNames`. It resolved to Flutter's `View` WIDGET because `View` is the
longest bridge name that is a suffix of `UnmodifiableSetView`, and that frame
was reached one sooner.

THE SAME LESSON AS THE PREFIX CASE, at the strategy it missed.
`MappedListIterable` → `Map` was fixed by splitting resolution into a precise
chain walk and a fuzzy one. The suffix match is equally fuzzy and stayed inside
the precise walk, so it alone kept resolving by proximity. It is now PASS A2: a
second chain walk, after every precise strategy has been tried in every frame.
The change can only move a resolution from a fuzzy answer to a precise one —
every candidate the new walk finds was already reachable, just later.

MEASURED. Reproduced in two seconds in process against the working tree, and
ABSENT at the published interpreter, so it is one of the regressions that
accumulated in the unpublished delta rather than a long-standing defect. The
empty `const <String>{}` case passes either way, which is why the corpus showed
it as one failure in one file rather than everywhere.

Name resolution: yes — it changes which bridge a native type resolves to when a
fuzzy suffix match and a declared `nativeNames` match sit in different frames.

## 0.162.0

### Fixed — a LIST of interpreted proxies was refused where each element was accepted (sce161)

SCD119 taught the binding check to look behind a `D4InterpretedProxy`: a script
class extending a bridged one is handed to Flutter as a proxy, `getRuntimeType`
answers with the BRIDGE's name, and binding it back to a parameter declared as
the script's own class was rejected. That repair reads ONE value.

A COLLECTION of them was still refused, and this is where the corpus actually
is — a script that builds widgets builds LISTS of them:

    type 'List<StatelessWidget>' is not a subtype of type 'List<_A11yNote>'

with every element individually bindable. The rejection came from the applied
type-argument check (SCD92), which derives the collection's arguments from
elements that each still answer with the bridge's name. So SCD119 moved the
rejection one level down instead of removing it, and down is the commoner level.

MEASURED, AND THE DISCRIMINATOR IS `const`. Reproduced in process against the
published interpreter: a script subclass constructed with `const` and bound to a
declared parameter fails; the same subclass constructed WITHOUT `const` passes.
It is base-independent — `StatelessWidget`, `StatefulWidget` and `Intent` all
fail under `const` and all pass without it — which is one mechanism rather than
the four-shape symptom list GEN-126 was written around. A declared LOCAL takes
the scalar value fine; only the declared-parameter and declared-collection sites
refuse it.

The retry keeps SCD119's discipline exactly. It runs only after the argument
check has already failed, so it can remove a rejection this check added and
never add one. It asks the SAME subtype question with the interpreted instances
substituted in rather than waving the collection through, so an element standing
for an unrelated class is still refused. And it returns the ORIGINAL collection,
because the proxies are what native code downstream expects to receive.

Witnesses and rails in both trees: F-SCE161-1/-2 (parameter and declared local)
with F-SCE161-3 as the control in `tom_d4rt`, and F-SCE161-AST-1 with
F-SCE161-AST-2 in `tom_d4rt_ast`. Ablated: every witness goes red with the retry
removed and both controls stay green either way.

Name resolution: no — a subtype verdict on a binding; which names bind to what
is untouched.

## 0.161.0

### Added — `@D4rtUserProxy` / `@D4rtUserRelaxer` on the analyzer-free line (sce154)

`generator/d4.dart` has always told consumers, in the doc comment on
`D4UserProxy`, to "extend this class (and apply `@D4rtUserProxy`)". The
annotations were declared only in `tom_d4rt`, so an AST-line bridge package
could not follow the instruction its own dependency gave it — the marker bases
`D4UserProxy` / `D4UserRelaxer` were here, the annotations that carry the
directive were not.

`d4rt_user_proxy_annotation.dart` is now mirrored into
`lib/src/runtime/generator/` byte-identically and exported from `runtime.dart`,
so it reaches `package:tom_d4rt_ast/d4rt.dart` — the import shape a generated
bridge package already uses. Nothing about the analyzer-free design required
the absence: an annotation is a marker class and has no analyzer dependency.

THE GENERATOR SIDE WAS MEASURED FIRST, because mirroring the class while the
scanner rejected it would have left the doc comment just as unfollowable and
less obviously so. `UserProxyRelaxerScanner` matches on `type.element.name` and
`supertype?.element.name` and asks nothing about the declaring library, so it
needed no change — and `tom_d4rt_generator`'s new
`sce154_annotation_uri_independence_test.dart` pins that, against a fixture
whose annotations are declared in a library unrelated to either interpreter.
Its existing scanner suite could not: every directive it had ever been tested
against carried a `package:tom_d4rt` annotation, so it passes identically
whether the scanner is URI-blind or hard-coded to that one URI.

Found by `scd134_barrel_surface_parity_test.dart`, which recorded both names as
reference-only GAPS rather than structural differences. Both entries are gone.

Name resolution: no — two annotation classes with no runtime behaviour; nothing
resolves a name differently.

## 0.160.0

### Recorded — the PASS B narrowing removes the wrong answer, not just most of it (sce153)

SCD132 made PASS B's prefix fallback require corroboration. SCE149 established
that no Flutter-corpus resolution had been relying on the old rule. What
neither measured is what the narrowed rule now does with the names it no longer
claims — reduce the wrong answers, or end them.

F-SCD133-4 in both Flutter twins answers that over a registry rather than an
example: it ablates `getRuntimeType`'s enum branch and asks what the class path
alone returns for every bridged enum the live Flutter environment holds.

| line   | enums | mistyped, published | mistyped, narrowed |
| ------ | ----: | ------------------: | -----------------: |
| AST    |   213 |                 104 |                  0 |
| source |   151 |                  82 |                  0 |

Every one of the 213 and 151 now throws. The comment beside the fallthrough
claimed a throw is "more honest than returning a wrong bridge"; this is that
claim priced. Measured 2026-09-22 through SCD66's pre-publish path resolution —
both twins resolve the interpreter from pub.dev (DGUC6), so the published
column is what an ordinary run of that guard still reports until this ships.

Comment-only in `lib/`. Both twins' `scd133_registry_enum_resolution_test.dart`
headers carry the full table, and now `print` every number in it on a green run
so the next refresh needs no edit — which is how the AST twin's recorded split
was caught stating 103/110 against a measured 104/109 under an interpreter that
had not moved.

Name resolution: no — comment-only. The narrowing itself shipped in 1.108.0 /
0.95.0; this records what it was measured to do.

## 0.159.0

### Fixed — a second interpreter reported empty bridge registries (sce150)

Bridge registration is pooled per process, so the second `providePackage` for a
package returns true and its caller skips the `register*` block — and with it
the dual-write into the instance maps. The interpreter went on resolving
everything, because it reads the pool. The public getters did not:

    final second = FlutterD4rt();          // same process as the first
    second.interpreter.bridgedLibraryUris  // {} — and everything still worked

THE FAILURE SURFACED LAYERS FROM ITS CAUSE, which is what made it worth fixing
rather than documenting. `AstBundler(bridgedLibraries: ...bridgedLibraryUris)`
stopped skipping bridged imports and the compile died with `Package import
"package:flutter/material.dart" is not bridged and not in the same package` — a
message about a missing bridge, for a bridge that was present and working.
Nothing in the getters' names or doc comments hinted at a dependence on
construction order.

`bridgedEnumDefinitions`, `bridgedClasses`, `bridgedExtensions`,
`libraryFunctions`, `libraryVariables`, `libraryGetters`, `librarySetters` and
`bridgedLibraryUris` now read THROUGH the pool, merged across the packages this
instance was GRANTED and no others — the same whitelist the warm parent uses.
The merge is cached against a pool revision bumped at `_bundleFor`, the choke
point every `register*` passes through, so a later registration is visible
without re-walking the pool on every read.

They are read views: the returned map may be a fresh merge, so writing to one
was never a registration and still is not. Every `register*` writes the
instance field and the pooled bundle directly.

Not mirrored into `tom_d4rt`: measured, it exposes no read-side registry getter
at all and its one consumer already reads the merged view, so there is nothing
there that can report empty.

Name resolution: no — which bridge a name resolves to is untouched; this is
what the instance REPORTS about its own registrations.

## 0.158.0

### Verified — the PASS B narrowing measured against the Flutter corpus (sce149)

SCD132 narrowed `Environment.toBridgedClass`'s prefix fallback to require
corroboration — `nativeNames` or a supertype-registry edge — instead of claiming
any bridge whose name prefixes the native type name. Both trees' full suites
established that the old rule had no legitimate user; what they could not speak
for is the Flutter corpus, which is the rule's heaviest consumer and which
resolves the interpreter from pub.dev (DGUC6).

Both twins' base corpus, run serially through SCD66's pre-publish path
resolution: **926 / 1 / 1 each**, against the 927/1/0 hosted baseline. The
single failure is the same script in both — scf26's `const <String>{}`
resolving to Flutter's `View` widget — which is the SUFFIX pass, not this one.

THE EXPECTED FINDING DID NOT MATERIALISE. The work predicted Flutter bridges
would need `nativeNames` entries once the prefix coincidence stopped covering
for them. None did: no corpus resolution was reaching PASS B uncorroborated.

Name resolution: no — this release changes only the comment recording that
measurement. The narrowing itself shipped in 1.108.0 / 0.95.0.

## 0.157.0

### Fixed — a `return` or an invocation with several awaits evaluated each of them twice (sce139)

    Future<int> f() async => (await next()) + (await next());   // was: 4, not 3

`next()` increments a counter, so the wrong answer and the wrong call count are
the same defect seen twice. The resumption branches for a return statement and
for an invocation with awaits in its arguments both re-evaluated the node inside
`_determineNextNodeAfterAwait`. That evaluation's suspension CANNOT be
registered with the state machine — the machine only ever attaches to a
suspension raised by executing a node — so it was discarded and the node was
executed again anyway. Every await site the machine had not yet resolved
therefore ran twice per pass, and the discarded pass consumed the value its site
should have received: two awaits answered 4 and cost three calls, three awaits
answered 9 and cost five.

SCD121 had already repaired the declaration route, by evaluating NOTHING in the
resumption branch: hand the statement back to the state machine, let the
resolved sites replay from `resolvedAwaitResults`, let the first site not yet
reached suspend for real, and let the pass on which nothing suspends do the
work. Its own comment recorded that the return route still carried the double
evaluation and that it was invisible there only because its cases awaited
side-effect-free futures. This is that route, and the invocation route, given
the same shape.

THE SECOND DEFECT, which falls out of WHO completes the function. Completing
inside `_determineNextNodeAfterAwait` — set `lastAwaitResult`, return null —
bypasses the state machine's `ReturnException` handler, and with it the jump
into an enclosing `finally`:

    try { return "${await f()}"; } finally { cleanup(); }   // cleanup never ran

One await is enough for that one, so it was never a counting problem. Re-running
the statement makes `visitReturnStatement` throw for real, and the handler
routes the return through the finally. The return's declared type is checked on
that pass too, which it previously was not.

Only the statement kinds the machine can safely re-enter are handed back — a
variable declaration, an expression statement, a return. Re-running an `if` or a
loop would restart the construct, so those keep the local re-evaluation.

Name resolution: no — which names bind to what is untouched; the change is
which party evaluates an already-parsed statement, and how many times.


## 0.156.0

### Fixed — a generic bound written through a type alias threw (sce130)

    typedef N = num;
    T pick<T extends N>(T v) => v;
    main() => pick(3);          // was: Undefined variable: N

A legal program that did not run. The direct form, `T pick<T extends num>`,
always worked, so the fault was alias-specific: type-parameter bounds are
resolved in PASS 1, by `DeclarationVisitor`, and type aliases are registered in
PASS 2 — they must be, because an alias may name a class whose placeholder pass
1 is still creating. `_extractTypeParameterBounds` rethrew on a bound it could
not resolve, with a comment saying the rethrow was deliberate, so the miss
became a hard failure instead of a deferral.

THE MEASUREMENT CHANGED THE FIX, which is the part worth recording. SCD100 left
this as a limit and predicted the repair would be a pass-1 reorder — "its own
change with its own blast radius". Probing fourteen shapes first showed
something cheaper and better founded: **pass 1 is the PLACEHOLDER pass, and it
is already lenient about an unresolvable RETURN type on the very same
declaration**, substituting a placeholder and logging that it did. The bound
was the one strict thing in an otherwise lenient pass.

So pass 1 is lenient now and pass 2 is not. Nothing is lost by that, because
pass 2 REBUILDS the function from its declaration after the alias fixpoint has
run, and that build is authoritative:

  - an alias bound resolves and IS ENFORCED — `pick<String>('a')` still reports
    `does not satisfy bound 'num'` (F-SCD100-12);
  - a genuinely undefined bound still stops the program before `main` runs
    (F-SCD100-15).

That second point is why leniency alone would have been a retreat rather than a
fix, and it is checked rather than asserted.

A CLASS NEEDED TWO MORE TOUCHES, because a class is populated in place and its
bounds are never re-extracted:

  - the alias fixpoint now runs BEFORE the class pass as well as before the
    function pass — in `d4rt_base.dart` AND in `module_loader.dart`, which are
    separate entry points into the same ordering, a trap that file already
    warned about and that the test suite caught;
  - `InterpretedClass.resolveDeferredTypeParameterBounds` repairs a bound pass
    1 had to skip, and throws there if it still does not resolve.

AND A THIRD ENTRY POINT HAD NO ALIAS PHASE AT ALL. `AstModuleLoader` — the
analyzer-free line's module loader — was never given one when SCD100 added the
phase to the runner and to the reference tree's `module_loader.dart`, so a
`typedef` declared in a non-entry MODULE bound nothing there and `1 is N` in
that module threw `Undefined variable: N`. Found by writing this fix down
rather than by a failure, because the reference's own comment about separate
entry points is what prompted the check. F-SCE130-LOADER-1 pins it, and fails
with that exact message when the phase is removed.

MEASURED: every alias target reaches a bound — a core type, a script class, a
bridged type, another alias, a generic target — on a function, a class and a
method, in any declaration order. `class Box<T extends N>` now behaves exactly
like `class Box<T extends num>`, including the pre-existing defect they share:
neither infers a type argument, so both reject `Box(3)` with `Type argument
'dynamic' ... does not satisfy bound 'num'`. That is scf27, not this.

ABLATED, both halves: removing pass-1 leniency fails F-SCD100-11/-12/-13/-14/-16
and leaves -15 green; removing the early alias fixpoint fails -14 alone.

Name resolution: no — an alias was already bound to its target by SCD100; this
changes WHEN a bound consults the environment, not what a name resolves to.

## 0.155.0

### Fixed — an all-null collection was refused by the binding check it was written for (sce129)

SCD92 made a declared parameter's TYPE ARGUMENTS a real check, deriving the
argument's own arguments from its CONTENTS because a native collection carries
no element type d4rt can read back. Its own entry lists where it therefore
stays permissive — an empty collection, a heterogeneous one, a top type, an
unbound type parameter, a raw generic, every bridged instance.

ALL-NULL WAS MISSING FROM THAT LIST, and it is the same case as empty. `null`
inhabits every nullable type, so a collection of nothing but nulls constrains
its element type exactly as little as a collection of nothing does — but it
derives `Null` rather than nothing, and `Null` was then compared literally:

    int f(List<String?> xs) => xs.length;
    f(List<String?>.filled(3, null));
    // was: type 'List<Null>' is not a subtype of type 'List<String>' of 'xs'

The annotation that produced the value refused it. Six sites: a parameter bind
and a local variable declaration, over a list, a set, and either half of a map.
A return and a for-in were unaffected — they reach the derivation by a
different route.

IT IS A WIDENING, NOT A SUBTYPE RULE, and the distinction is the whole of it.
`Null` is not a subtype of `String`, only of `String?`; and
`_appliedDeclaredType` resolves an argument node by NAME, so a declared
`List<String?>` arrives with its nullability already gone — which is why the
message above says `List<String>` for an annotation that was written
`List<String?>`. No subtype rule could recover what was never carried. The
comparison is relaxed instead, in the same shape and the same place as SCD92's
existing int→double widening, and it widens the type used for the COMPARISON
only.

HOW IT WAS FOUND, because the route matters more than the fix. It is three of
the base bridge corpus's failures — `widgets/table_test.dart`,
`foundation/stack_filter_test.dart`, `gestures/tap_drag_start_details_test.dart`
— which have blocked the interpreter publish since 2026-09-15 with every unit
suite in three packages green. sce129 reproduced two of the three in ten lines
of plain Dart with no Flutter, then bisected 103 commits in seven steps to
`a31d6ff88` / 1.99.0. Both numbers are the point: the corpus found a defect no
unit test could, and the defect was unit-testable all along.

New: F-SCD92-23..26 (the four shapes) and F-SCD92-27 (anti-vacuity — a wrong
non-null element type is still refused); F-SCD92-AST-5 and -6 in the twin.
Ablated: without the fix, -23..-26 fail and -27 passes, which is what says -27
is a control rather than a second copy of the claim.

Name resolution: no — the binding check decides subtyping, not which
declaration a name reaches.

## 0.154.0

### Changed — an `on` clause naming an unresolvable type now fails (sce127)

Real Dart refuses to compile it (`non_type_in_catch_clause`). d4rt logged a
warning nobody sees and answered `false`, so the divergence ran in the most
dangerous direction available — Dart rejects the program, d4rt silently runs a
DIFFERENT BRANCH of it. With a later clause, that clause took the branch and
the script returned a value from a handler its author never meant to reach;
with no later clause, the exception escaped the `try` as if the handler were
not written. A script author could only discover a dead clause by testing that
it fires, which is exactly the test people skip.

THE OLD CODE'S CONCERN IS ANSWERED RATHER THAN DISCARDED. Its comment read
"letting the lookup failure escape would replace the exception being dispatched
and lose the original" — true, and the reason it returned `false`. So the
failure does not escape: the diagnostic names BOTH the unresolved type and the
exception that was in flight, and points at the remedy.

MEASURED BEFORE CHANGING IT, because a legitimate unresolvable `on` type would
make working scripts start throwing. A class declared after `main`, a class
from another module, a prefixed `p.Other`, a generic `List<int>` and a
`typedef` alias all resolve. The only shape that does not is a type from a
library the script did not import — which Dart also rejects, so it is this same
defect rather than an exception to it. The other candidate, a bridge not
finalized when the clause is reached, does not arise: `finalizeBridges` runs
implicitly on first execute.

The check fires when the clause is REACHED, which is later than Dart and leaves
a dead clause nothing ever reaches silent. That is recorded in the test rather
than hidden; closing it needs a whole-program pass, which this change does not
add.

SCD94's F-SCD94-1, -2, -3 and F-SCD94-AST-2 pinned the silent fall-through as
observed behaviour and are flipped in the same commit, as that todo's successor
required.

Name resolution: no. How a name RESOLVES is unchanged — only the reaction to a
resolution that fails, inside a catch clause.

## 0.153.0

### Fixed — `String.fromCharCodes` accepts any `Iterable`, as the SDK declares (sce126)

SCD93 swept `interpreter_visitor.dart` for guards that pre-empt a native
operator; SCE126 swept the STDLIB BRIDGES with the same method, where 165 lines
carry a matching shape. 63 expressions were compared against real Dart, error
type for error type.

THE YIELD IS ONE. `String.fromCharCodes` cast its argument to `List` where the
SDK declares `Iterable<int>`, so a `Set`, a `.map(…)` or a `.where(…)` raised
`_TypeError` for input real Dart accepts. The cast is now to `Iterable`, which
is the SDK's own domain; a non-Iterable still raises the same `_TypeError`.

TYPE AGREEMENT OVER BAD INPUT WAS NOT ENOUGH TO FIND IT, and that is the method
worth recording: all 37 bad-input cases agreed, so a sweep that asks only "does
the wrong argument raise the right error" reports nothing. The divergence is
visible only over GOOD input — a value the SDK accepts and the bridge rejects —
so a second pass fed twenty-six Iterable- and Pattern-taking members something
legal. Twenty-three of the twenty-six already agreed.

The agreements are pinned as well as the fix, because they are what stops the
guards being reinstated.

Name resolution: no.

## 0.152.0

### Fixed — a bare write to a static field from an instance method updates the static (sce125)

```dart
class Box { static int v = 1; void go() { v += 1; } }
main() { Box().go(); return Box.v; }   // real Dart 2, d4rt 1
```

THE READ PATH WAS ALWAYS RIGHT, which is what made the two halves disagree
rather than both being wrong. `InterpretedInstance.get` walks the class chain
and finds the static when no instance field shadows it. The WRITE path reached
`thisInstance.set(name, …)`, which CREATES a field when none exists — so the
write minted a per-instance shadow, and the next bare read found that shadow.

IT WAS SILENT BECAUSE THE METHOD COULD READ ITS OWN WRITE BACK. `v += 1;
return v;` answered 2, so any test that checks the value inside the method
passed; only a reader outside the instance saw the static unchanged. Two
instances did not even agree with each other — `a` saw 2 and `b` saw 1, of a
field the class declares `static`.

The write now mirrors the read's walk. In Dart a class cannot declare a static
and an instance member of the same name, so finding a static means there is no
instance member to prefer and the check can come first; a local, a parameter
and an instance setter still take precedence as they always did.

Name resolution: no — this is assignment target resolution inside a class body,
not the `Environment`/bridge lookup the corpus rule is about.

## 0.151.0

### Fixed — `is Function` answers for every value the interpreter can call (sce121)

It answered `true` for a script function or a closure and `false` for every
native one. The damning measurement is not the `false`, it is the pair:
`var f = 'abc'.substring; f(1)` returns `'bc'`, and `f is Function` was false.
So the guard rejected a value the interpreter was perfectly able to call, and a
script written the Dart way — a plugin registry, a callback table,
`if (x is Function) x()` — silently took the else-branch for every native
callable. That reads as "d4rt cannot do that" rather than "the type test is
wrong", which is why it survived.

The population was enumerated before anything changed, as the todo asks:
measured false were a bridged instance-method tear-off, a bridged static
(`int.parse`), a constructor tear-off (`Object.new`) and a bridged top-level
(`json.decode`).

The fix is in the `Function` bridge rather than in the interpreter's type-test
path: `Callable` is the interpreter's own "can be invoked" interface and every
tear-off shape implements it, so `isAssignable` answers with it and the type
test agrees with what invocation already does.

A class that merely declares `call` is still NOT a `Function`, which is real
Dart and the case a fix aimed at "anything callable" gets wrong.

TWO HALVES STAY AND ARE WRITTEN DOWN: `'abc'.substring is String Function(int)`
is false and `runtimeType` reports `BridgedMethodCallable`. Both are the same
fact — there is no function TYPE for a native callable, only the knowledge that
it can be invoked — and `doc/d4rt_limitations.md` Lim-11 records it, including
why a half-right function type would be worse than an honest class name.

Name resolution: no.

## 0.150.0

### Fixed — a read-back `LinkedListEntry` renders the script's own `toString` (sce120)

`class E extends LinkedListEntry<E>` — the idiom the SDK documents — works end
to end: the implicit `super()` constructs, `add` accepts the interpreted
instance, and the list round-trips it, so `l.first.v`, `identical(l.first, e)`
and `for (final e in l)` all reach the script's own class. That was closed by
SCD75's follow-through; SCE120 found the one place it still leaked.

The proxy unwrap is a FALLBACK: the interpreter tries the bridge's own members
first and only reaches `D4InterpretedProxy.d4rtInstance` when they fail.
`myField` fails and unwraps; `toString` SUCCEEDED, on the wrapper — so a script
declaring `String toString() => 'E:' + v.toString()` read back
`LinkedListEntry(E:1)`, its own rendering wrapped in the name of a class it
never wrote, and the same object printed two different ways depending on
whether it had been through a list.

Fixed where the substitution is manufactured, in
`_OwnedLinkedListEntry.toString`, rather than by reordering the general unwrap:
the proxy exists to speak for the instance, so it answers with the instance's
own `toString` — which dispatches to the script's override and degrades to the
diagnostic form when there is none (SCD72, shared since SCE116).

Two wider gaps are pinned rather than fixed, both measured: `l.first.runtimeType`
reports the proxy type, which is a question about every `D4InterpretedProxy`;
and an interpreted class declaring no `toString` cannot have one called at all,
which is the universal-member path for every class.

Name resolution: no.

## 0.149.0

### Fixed — the last route that handed an embedder the interpreter's wrapper (sce117)

SCD73 made the unwrapping of `InternalInterpreterD4rtException` unconditional
for every callback the zone REGISTERS, and pinned the one shape it could not
reach: a handler passed to `Stream.handleError`. The SDK invokes that handler
with no zone registration at all, so there was no `register*Callback` seam to
wrap — adding `runUnary` and `runBinary` was tried and changed nothing except
double-wrapping the `Stream.listen` case.

`Zone.errorCallback` fires for that shape and — this is why it is the right
seam rather than merely an available one — IS NOT AN ERROR-ZONE HOOK.
Specifying it leaves `Zone.errorZone` resolving to the parent's, so the
property that ruled `handleUncaughtError` out does not arise: an awaiting
caller outside the zone still receives an ordinary script failure rather than
hanging.

THE BLAST RADIUS WAS MEASURED, NOT REASONED. `errorCallback` is consulted for
errors entering futures generally, so the question was whether an interpreted
`catch` would start seeing a different value. A thirteen-row matrix of
in-script shapes is byte-identical with and without the seam, and is a
standing test now rather than a hand measurement nobody could re-run.

`unwrapScriptError` stays public and stays correct on a value that no longer
needs it, so an embedder's defensive call has not become a bug.

Name resolution: no.

## 0.148.0

### Fixed — an enum value and an extension-type instance dispatch to their `toString` override (sce116)

SCD72 taught `InterpretedInstance.toString()` to dispatch to a script's own
override and left two siblings in the same file behind.
`InterpretedEnumValue` got the DEFAULT right and the override wrong — which is
why it was easy to miss, since `P.a` is what a host wants and what Dart prints
— and `InterpretedExtensionTypeInstance` got both wrong.

THE MECHANISM IS SHARED, NOT COPIED. SCD72's body — find the override, get a
visitor, guard re-entry, dispatch, degrade on anything recoverable, rethrow
`StackOverflowError` and `OutOfMemoryError` — is now
`renderInterpretedToString`, called by all three. Every line of it was there
for a measured reason and the reasons apply unchanged; a third and fourth copy
would have been three and four places for the next correction to land in.

The re-entry guard is ONE identity set for all three types, because a cycle can
run through them and three separate guards would each see a first visit.

`InterpretedEnum` and `InterpretedExtensionType` gained the
`declaringVisitor` wiring `InterpretedClass` already had, assigned once per
declaration — `toString()` is a plain `Object` override with nowhere to receive
a visitor, and the ambient one is null by the time a host reads it.

An enum's override may come from a mixin, so the lookup walks them in the same
order `InterpretedEnumValue.get` does.

THE CONTRACT STILL SPLITS BY CALLER. `stringify` — interpolation inside a
script — keeps Dart's semantics and propagates; `toString()`, which host code
reaches, degrades. Sharing a call between them is how that could have been
lost, so `stringify` gained explicit branches for the two new types and calls
the strict form.

Name resolution: no.

## 0.147.0

### Fixed — an extension-type instance renders as the thing it wraps (sce116)

`extension type Y(int v) {}` declares no `toString`, so the call erases to
`Object.toString()` on the value `Y` wraps and real Dart prints `7`. d4rt
printed `<instance of Y>`.

AN EXTENSION TYPE IS ITS REPRESENTATION AT RUN TIME, which is the whole
reason: the wrapper is a static fiction with no runtime existence to describe.
`<instance of Y>` was not an imprecise rendering of the right object, it was a
rendering of the wrong one.

This is the half of SCE116 that has nothing to do with overrides, and it lands
on its own because it is a different defect that happens to live in the same
method.

Name resolution: no.

## 0.146.0

### Fixed — every `transform` adapter resolves its argument the same way (sce114)

There are four `transform` adapters and only one resolved its argument
properly. `Stream.transform` went through `_asStreamTransformer`, which accepts
a native transformer, a bridged one, and — the case `StreamTransformerBase`
exists to enable — an interpreted class with a `bind` method. Both socket
adapters wrote

```dart
final separator = positionalArgs[0] as StreamTransformer;
```

A cast admits the first two shapes and rejects the third with a host
`_TypeError` naming `InterpretedInstance`. So the same script class worked on
a stream and failed on a socket, and the failure named an interpreter-internal
type rather than the argument.

The resolver moved out of `async/stream.dart` into
`stdlib/stream_transformer_arg.dart`, beside `run_action.dart` and
`stream_listen.dart` — which were extracted from the same kind of duplication
— and all four adapters now ask one function. A non-transformer argument, or
a missing one, reaches one sentence naming the member the script called.

`ServerSocket.transform` also reported itself as `Socket.transform`, copied
along with the body it was copied from.

THE `.cast()` IN THE SOCKET ADAPTERS STAYS. SCE83's `_bindTransformer` coerces
the SOURCE instead, and the two sites differ for the reason its doc gives: a
socket's element type is known statically so the cast is computed against it,
while a bare `Stream` has the cast inverted on it. Only the argument
resolution was shared.

The two halves this was filed for had already been closed, by SCE83 and
SCD187, and neither had a test — `response.transform(utf8.decoder)`, the line
every Dart HTTP example contains, now has one.

Name resolution: no.

## 0.145.0

### Fixed — `Function.apply` takes Symbol keys, as the SDK declares (sce113)

`Function.apply(Function, List?, [Map<Symbol, dynamic>?])` is the SDK
signature. The adapter read `Map<String, Object?>`, because that is what
d4rt's own `Callable.call` takes — so `{#b: 2}`, the only spelling the
analyzer accepts, threw, and `{'b': 2}`, which no Dart program can contain,
was the one that worked. The named-argument half of `Function.apply` had
therefore never worked for any legal program.

That matters more than a wrong key type would suggest: `Function.apply` is how
a script calls a function whose parameters it does not know statically, and
there is no other route to it.

Symbol keys are now translated to names in the adapter — `MirrorSystem.getName`
is unavailable in the analyzer-free twin, so the name is read off
`Symbol.toString()`, which is exact because every Symbol a script can produce
is built at run time from a literal or through the `Symbol` bridge.

String keys are REJECTED rather than accepted alongside Symbols, and the
message names the legal spelling. d4rt matches the SDK per construct, so that
a script ported from Dart behaves the same and a script written against d4rt
still compiles as Dart. The loose spelling was one commit old and unpublished.

Two smaller defects in the same adapter, found while measuring: both argument
lists are nullable in the SDK and `null` was an error for each, and the
adapter forwarded its own (always-empty) named arguments when the caller gave
no map.

SCD70 made the original visible rather than causing it — before that sweep the
adapter cast and every call died with an opaque `_TypeError`.

The neighbours were measured and are the counter-example: `Invocation.method`
and `.genericMethod` take the same `Map<Symbol, …>` and keep it Symbol-keyed
all the way through, which is correct, so the translation is scoped to this one
adapter.

Name resolution: no.

## 0.144.0

### Fixed — seventeen adapters read an optional positional parameter as named (sce110)

SCD68 checked that every `namedArgs['x']` in a bridged CONSTRUCTOR is a claim
the SDK signature supports, and scoped itself there on a stated hypothesis:
a method adapter "is often a hand-written convenience over several SDK members
and the one-to-one mapping this check relies on does not hold".

Nobody had counted. Counted now, over 279 claims:

| section        | claims | resolved one-to-one |
| -------------- | -----: | ------------------: |
| methods        |    145 |                 145 |
| constructors   |     71 |                  70 |
| staticMethods  |     63 |                  63 |

The hypothesis was wrong by 278 to 1 — the single exception is `BytesBuilder`'s
unnamed constructor, a factory on an abstract class mirrors does not expose.

TWO LOOKUP FIXES WERE NEEDED TO SEE THAT, and both were the checker's fault
rather than the bridges'. Resolving only through `superclass` reported 47
unresolvable, because `HashSet` IMPLEMENTS `Set` and reaches `firstWhere`
through no superclass at all; adding `superinterfaces` took it to 14. The
remaining 13 were factory constructors exposed as statics — `List.filled`,
`Map.fromIterable`, `int.fromEnvironment` — an ordinary bridge shape whose
signature mirrors can read, so the static lookup now falls back to the
constructor of the same name.

The widening found 17 mismatches, all the same shape as SCD68's:
`Uri.parse` / `tryParse` / `parseIPv6Address`, `RandomAccessFile.lock` /
`lockSync` / `unlock` / `unlockSync`, and `HttpClientResponse.redirect` each
read an optional POSITIONAL parameter out of `namedArgs`. Read that way they
were unreachable — the only spelling that fills them is one Dart refuses to
compile — so `Uri.parse(s, 5)` ignored its offset and every `lock()` took an
exclusive whole-file lock whatever it asked for. All read positionally now,
length-guarded, and the guard covers all three sections with its anti-vacuity
floor raised from 55 to 210 so the two new thirds cannot stop being walked
quietly.

Name resolution: no.

## 0.143.0

### Fixed — a runtime condition raises the SDK's Error, so `on RangeError` catches (sce109)

Two adapters reported a runtime condition of the SCRIPT — an index out of
range, no element matching a test — with an interpreter exception instead of
the SDK's Error. `RuntimeD4rtException` is not an `Error` at all, so the
idiomatic handler was skipped and the script fell through to a bare `catch`, or
to nothing:

    try { [1].elementAt(5); } on RangeError { … }   // did not catch

THE TWO HAD DIFFERENT CAUSES, and only one was the hand-written guard the
defect looked like from outside.

`firstWhere` was a hand-rolled loop whose no-match branch threw
`RuntimeD4rtException('No element found matching the test condition')` — an
invented contract. Its neighbours `lastWhere` and `singleWhere` delegate to the
native call and were already correct, which is what made the loop's stated
reason ("éviter les problèmes de types génériques") checkable: all three wrap
the callback identically. It delegates now.

`elementAt` had no guard at all. SCB28 added a heuristic at the DISPATCH
boundary: a bridged call that throws `RangeError` is assumed to be an adapter
that read past the end of `positionalArgs`, and is restated as an arity
failure. `[1].elementAt(5)` is one positional argument on a one-element list,
so the reported range 0..0 matches the argument list's 0..0 and the heuristic
fires on the script's own error.

THE HEURISTIC CANNOT BE MADE EXACT, which is measured rather than assumed:
`[1].elementAt(5)` and an adapter's `positionalArgs[5]` produce byte-identical
`RangeError`s — same `name`, `start`, `end`, `invalidValue`, and neither is an
`IndexError`, so there is no `indexable` back-reference to compare. Its own doc
had judged the misattribution acceptable because it "only ever changes the
wording of an error that was already being thrown". The wording was not the
only thing that changed.

So the fix makes being wrong cheap rather than pretending to be right: the
detection and the arity message stay, the original error text leads, the arity
reading follows as a hypothesis, and the TYPE is preserved at all nine throw
sites. `on RangeError` now catches under either reading.

Name resolution: no.

## 0.142.0

### Fixed — a failing cast pattern throws, and there is only one cast (sce104)

`case var x as T` raised `PatternMatchD4rtException` when the cast failed, and
every arm-selection site catches exactly that and reads it as "this arm did not
match". So the failure was converted into arm selection: a program that should
stop ran on down `default`, into a branch its author wrote for a different case.
`as` in a pattern exists to assert; a cast pattern that cannot fail is a cast
pattern that does nothing.

THE FIX IS NOT "THROW INSTEAD". `v as T` and `case var x as T` are the same
operation, and they were implemented twice — an eleven-name ladder in
`visitAsExpression` and a nine-name ladder in the `CastPattern` branch, each
with a permissive `default`. Measured before the merge they disagreed on eight
inputs, and each knew something the other did not:

| input             | expression  | pattern | Dart   |
| ----------------- | ----------- | ------- | ------ |
| `'s' as int`      | throws      | MISS    | throws |
| `1 as double`     | 1.0         | MISS    | 1.0    |
| `1 as Null`       | throws      | HIT     | throws |
| `'s' as I` (=int) | throws      | HIT     | throws |
| `'s' as Map`      | RETURNS 's' | miss    | throws |
| `'s' as Set`      | RETURNS 's' | miss    | throws |

The pattern lacked `Null`, alias resolution (SCD100) and the `int`→`double`
promotion (GEN-094); the expression lacked `Map` and `Set` entirely, so a
failing cast to either RETURNED ITS OPERAND. Turning the pattern's ladder into
a throw without merging would have shipped four of those rows wrong. One body,
`_tryCast`, ends both.

It returns a sentinel rather than throwing, so each construct keeps its own
message: the SDK words a failed `as` and a failed cast PATTERN differently, and
matching it per construct is the point of `D4rtTypeError`.

THE CAST'S RESULT IS WHAT BINDS, not the operand — `1 as double` binds 1.0, and
a proxy cast to the class it wraps binds the interpreted instance (C21).

DELIBERATELY UNCHANGED: the shared ladder's `default` stays permissive, so
`A() as B` between unrelated script classes still succeeds, in the pattern and
the expression alike. That is a separate decision with its own blast radius, and
it is pinned as a case so the limit is recorded rather than discovered.

Blast radius, measured because this change CAN break a green test: zero across
the reference suite.

Name resolution: no.

## 0.141.0

### Fixed — a typed local is checked, at its declaration and at every write (sce103)

The fourth and last site that asks "does this value fit this written type", and
the widest: every typed local in every script passes through it.

| site                    | closed by |
| ----------------------- | --------- |
| parameter binding       | SCC29     |
| typed patterns          | SCC18     |
| for-each loop variable  | SCD63     |
| **typed local**         | **SCE103** |

`int x = 'two';` bound the String. So did every later `x = 'two';`, and so did
`for (x in ['two'])` — the for-each IDENTIFIER form, which SCD63 pinned as a
known gap precisely because it belongs here: the loop carries no annotation, the
type was written at `x`'s own declaration, and checking it is the same job as
checking any other write to `x`.

WHY THIS SITE NEEDED MORE THAN A NEW CALL. The other three check at a single
moment and remember nothing. A declaration and a later assignment are two
moments, and only the first carries the annotation — so the resolved binding is
recorded per name in the environment that declares it, and `assign` consults it.
A frame with no typed local pays one null probe.

`late` is out of scope and fields and top-level variables are not reached; both
limits are pinned as cases rather than left to be discovered.

THE BLAST RADIUS WAS MEASURED, NOT ASSUMED. Across the reference suite: ONE
behavioural failure, and it was not a false positive. `Set<int> numbers = {};`
evaluated to a **Map** — `{}` is a Map unless the context type says Set, Dart's
rule, and the interpreter has no context type — and the test that failed had
only ever passed because it asked `isEmpty`, which a Map answers too. Everything
else about such a variable was already broken: `s.add(1)` threw "Bridged class
'Map' has no instance method named 'add'", and `f(Set<int> s)` called with `{}`
threw this very type error through SCC29's parameter check. So the new check did
not break a working program; it found the fourth site of a defect three sites
already had.

The disambiguation now lives in `ResolvedBinding.bind`, beside the `int`→`double`
widening that is there for the same reason. EMPTY ONLY — a non-empty Map bound
to a `Set` is a real error and still fails.

Name resolution: no.

## 0.140.0

### Fixed — an empty loop body inside `async` no longer ends the function (sce102)

The async state machine enters a loop body by taking the body's first
statement:

    currentNode = (node.body as Block).statements.firstOrNull;
    currentState.nextStateIdentifier = currentNode;
    continue;

For `{}` that is null, and the machine's own loop is `while (currentNode !=
null)` — so the FUNCTION ended there. Not the loop. Every statement after it
was skipped and the declared return value never happened. Measured in an
`async` function:

| loop                                | returned | expected |
| ----------------------------------- | -------- | -------- |
| `for (final x in [1, 2]) {}`        | null     | `'ran'`  |
| `for (var i = 0; i < 2; i++) {}`    | **true** | `'ran'`  |
| `await for (final x in s) {}`       | **true** | `'ran'`  |
| `while (i++ < 2) {}`                | null     | `'ran'`  |

Three different wrong answers from one cause: the value is whatever
`lastResult` held, which is null after a for-in and the CONDITION after the two
forms that had just evaluated one. A reader who met only the `true` would go
looking for a condition bug.

THE RETURN VALUE IS THE SERIOUS PART. A loop that does nothing, doing nothing,
is invisible. A function that silently returns the wrong thing is not: the
caller gets it, and the failure surfaces wherever that value is finally used,
with nothing pointing back at the empty body.

THE FIX WAS ALREADY IN THE FILE. SCE19 met this at the do-while entry and
solved it there — `currentNode ??= doNode`, fall back to the loop node and let
the loop decide what comes next. The remaining five dispatch sites did not have
it. The C-style `for` is the instructive one: it had the INTENT, under a
comment explaining the empty-body case and setting `nextStateIdentifier =
forNode`, but never assigned `currentNode` — so `continue` re-tested the
machine's `while` against a null that was still null. Half a fix reads exactly
like a whole one at the call site, and that site had read like a whole one
since it was written.

The synchronous path was never affected; it does not use the state machine.

Name resolution: no.

## 0.139.0

### Fixed — a generic element is asked the same question as `is` (sce101)

`interpreter_visitor.dart` carries two predicates for "does this value have
this type". `_valueHasType` answers the `is` operator, typed patterns, the
declared-type check and `on` clauses. `_checkValueMatchesType` answers the
ELEMENT and KEY/VALUE types of a generic collection, and it answered five
questions differently:

| question                                       | `x is T` | `[x] is List<T>` |
| ---------------------------------------------- | -------- | ---------------- |
| null against `Null`                            | true     | FALSE            |
| null against `dynamic`                         | true     | FALSE            |
| a class against `Type`                         | true     | FALSE            |
| a NATIVE bridged value against its own class   | true     | FALSE            |
| a WRAPPED bridged value against `List`         | true     | FALSE            |

`Null`, `dynamic` and `Type` had no arm at all — `dynamic` shared `Object`'s
"non-null", which is wrong for exactly the value `dynamic` exists to accept.

THE LAST TWO ROWS ARE MIRROR IMAGES, and that is the part worth reading. The
shape arms (`int`, `List`, `Map`, …) answer with the host's own `is`, so they
needed a native and got the WRAPPED form wrong; the user-type arm required a
`BridgedInstance` and got the NATIVE form wrong. A bridged value reaches the
interpreter in both forms — `dart:collection`'s bridges hand back natives, a
bridge whose constructor returns a `BridgedInstance` hands back a wrapper — so
each arm was broken for the input the other one handled.

That symmetry is also why the defect survived being looked for. The obvious
probe is `UnmodifiableListView` and `HashMap`, as SCB7 used; measured, those
now evaluate to native objects, so the probe comes back green and the missing
unwrap looks like dead code. It is not — it needs a bridge that still wraps.

The five arms are added in place, and `_nativeOrBridgedMatches` is extracted
from `_valueHasType`'s bridged branch so both predicates share the reasoning
about operand form rather than carrying a third copy of it. This is NOT a
delegation of one predicate to the other: `_checkValueMatchesType` is
deliberately lenient where `_valueHasType` is strict — an unresolvable type
name returns true there and false here — so collapsing them changes answers on
the hot path of every `is`, and is separate work.

`void` stays divergent, deliberately: `x is void` does not parse, so the other
predicate's `void` arm is unreachable from the operator and its own comment
hedges about the right answer. Agreeing would mean choosing between two
unreachable answers with no case to appeal to.

Name resolution: no. `environment.get(typeName)` is unchanged and no lookup
rule moves; what changed is what the resolved `BridgedClass` is compared
against.

## 0.138.0

### Fixed (BREAKING for scripts using the old entry form) — `LinkedListEntry` can be subclassed (sce84)

`LinkedList` is only usable through a subclass of `LinkedListEntry` — the SDK
declares it `abstract base mixin class LinkedListEntry<E extends
LinkedListEntry<E>>`, so there is no other way in. Interpreted code could not
write one:

    class E extends LinkedListEntry<E> { final int v; E(this.v); }
    final l = LinkedList<E>(); l.add(E(1));

    -> Error during implicit bridged super constructor:
       Constructor LinkedListEntry(value) expects one positional argument.

The bridge wrapped d4rt's own concrete stand-in, whose constructor carried the
entry's value, so the implicit `super()` every subclass makes could never
match. It now takes no arguments, as the SDK's does, and a script carries its
payload on its own class where Dart carries it.

**Two non-SDK members went with it, and this is breaking for any script that
used them**: the `LinkedListEntry(value)` constructor and the `value` getter.
The SDK's entry has `list`, `next`, `previous`, `insertAfter`, `insertBefore`,
`unlink` and nothing else, so a script using either ran here and did not
compile as Dart — the same judgement `removeFirst` got in SCC8, applied to a
constructor and a getter. The diagnostic says what to write instead.

**The list hands back the script's own objects.** A native `LinkedList` can
only hold native entries, so `first`, `last`, iteration and `map` produce the
entry the bridge minted; it carries the interpreted instance as a
`D4InterpretedProxy`, and the interpreter's existing unwrapping makes
`list.first.myField` reach the script's class.

Identity follows, because two carriers of one object must not answer `false`
to "is this the entry I added". `identical`, `identityHashCode` and the `==` /
`!=` operators now see through a native proxy to the instance behind it, and
`LinkedList.contains` — the one inherited member whose argument is an element —
unwraps its argument. This is the first consumer of `D4.interpretedBehind`,
promoted from a private helper in the binding checker.

## 0.137.0

### Fixed — `stream.transform(utf8.decoder)` failed for every stream a script made (sce83)

    final s = Stream<List<int>>.fromIterable([[104, 105]]);
    await s.transform(utf8.decoder).join();

raised `type '_MultiStream<dynamic>' is not a subtype of type
'Stream<List<int>>' of 'stream'` — a host `TypeError` naming an interpreter
internal, uncatchable as a `RuntimeD4rtException` and telling a script author
nothing to do. SCD187 fixed the `dart:io` half of this by deleting a stub; the
stream in that case comes from the SDK and really is a `Stream<List<int>>`.
A stream the SCRIPT built is not.

The cause is the interpreter's value model rather than this member. A script's
values are dynamically typed natively — `Stream<List<int>>.fromIterable` is a
`Stream<dynamic>` carrying `List<Object?>` chunks — and every bridge coerces at
its own boundary instead. `utf8.decoder.bind(s)` worked on the same stream
throughout, because `Utf8Decoder.bind` does exactly that coercion. So Dart's
two spellings for one operation disagreed, and the broken one was the one every
tutorial uses.

`Stream.transform` now coerces the source the same way: element-wise to
`List<int>` for a byte transformer, to `String` for a text one, and untouched
for anything else — which includes script-defined transformers, whose input
type the interpreter's own values already satisfy.

Casting the TRANSFORMER instead, which is what the two `Socket.transform`
adapters do, was tried first and inverts the defect: a `File.openRead()` stream
then rejects the `CastConverter` it is handed. Those adapters are right for
themselves because they know their element type statically; a bare `Stream`
does not. Both directions were measured before either was written.

## 0.136.0

### Added — the last 51 confirmed member gaps are bridged (sce82)

SCD44 widened the audit and took its confirmed-unreachable count from 0 to 51
without touching `lib/`: every one was a member a script could never call, and
the audit simply could not see them. They are now bridged, and the count is
back to 0.

| class | members |
| ----- | ------- |
| `HttpHeaders` | the 45 remaining static header-name constants |
| `RawSocketOption` | `levelIPv4`, `levelIPv6`, `IPv4MulticastInterface`, `IPv6MulticastInterface` |
| `ConnectionTask` | `fromSocket` |
| `Platform` | `lineTerminator` |

`HttpHeaders` was the bulk of it, and the half-bridged state was the worst one
to be in: seventeen constants resolved and forty-five did not, so
`headers.set(HttpHeaders.acceptRangesHeader, …)` failed while
`HttpHeaders.acceptHeader` beside it worked — the ones that resolve teach the
author to expect the rest.

Each constant DELEGATES to the SDK's own (`(visitor) => HttpHeaders.teHeader`)
rather than repeating its value, so a wrong name is a compile error rather than
a bridge that resolves and quietly returns the wrong header. The cases assert
against `dart:io` directly for the other half of that: that each bridge is
wired to the constant it claims.

`Platform.lineTerminator` goes through the same dangerous-permission gate as
every other `Platform` getter. It is a pure value, but it is a host property,
and bridging it ungated would have made it the one `Platform` member a script
can read without a grant.

What remains measured-unreachable is the five `ByteBuffer` and `RawSocket`
members that are unreachable BY DECISION, each with its reason recorded.

## 0.135.0

### Fixed — a cascade section could not take an awaited argument (sce81)

    sb..write(await Future.value('a'))..write('b');

failed with `type 'AsyncSuspensionRequest' is not a subtype of type
'(List<Object?>, Map<String, Object?>)'` — an interpreter internal, surfaced to
the script author. The same code without the cascade always worked.

Two of the four `_executeCascade*` helpers returned `void`, because a cascade
section's VALUE is deliberately discarded: the cascade evaluates to its target.
But a discarded value and an unfinished one are not the same thing, and
`_evaluateArguments` signals the second by returning the suspension sentinel,
so the record destructuring failed.

THE SECTIONS ARE NOW MEMOISED, which is what makes this a fix rather than a
refusal. Dart evaluates a cascade's target once and runs its sections in order
for their side effects, and the interpreter drives `await` by REPLAY — so a bare
propagation would re-evaluate the target and re-run every earlier section:
`sb..write('a')..write(await f())` would write `'a'` twice. The target and the
completed sections are recorded on `AsyncExecutionState`, keyed by node, and
dropped when the cascade finishes so a cascade inside a loop starts fresh each
iteration.

The resumption side needed two changes of its own. A cascade SECTION cannot be
re-executed standalone — its target is implicit, so accepting it resolved the
method name as a bare identifier — so the await context is lifted to the
enclosing `CascadeExpression`, which then had to be admitted to the
re-execution branch. Lifting without admitting left nothing to re-execute, and
the machine completed the function with `lastAwaitResult`, skipping every
statement after the cascade.

Ten cases. One puts an observable side effect on both sides of the awaiting
section and asserts each happened exactly once — without it a propagate-and-
replay fix that silently doubles work passes everything else.

## 0.134.0

### Fixed — `await` in a collection literal stored the suspension sentinel (sce80)

    [await Future.value(1)]        // was: [Instance of 'AsyncSuspensionRequest']

Every collection-literal position had this, silently: list elements, map keys,
map values, set elements, `if` elements, null-aware elements. Only the spread
case reported anything, and only because a sentinel is not an `Iterable`.

The cause was visible in the signature. The interpreter drives `await` by
replay — `visitAwaitExpression` returns an `AsyncSuspensionRequest` and every
visitor propagates it upward — but `_processCollectionElement` returned `void`,
so it had no way to say "the element I was evaluating has not finished". It
stored the sentinel instead, and the two literal visitors could not propagate
either. It now returns `Object?`: the suspension, or null when the element
completed.

ONE SHAPE IS REFUSED RATHER THAN FIXED, and that is deliberate. An `await` in
the BODY of a collection-literal `for` element cannot propagate: replay
re-evaluates the whole literal, so the loop would run its earlier iterations
again, and `resolvedAwaitResults` is keyed by the `AwaitExpression` NODE — which
every iteration shares — so the second iteration would replay the first one's
value. A list of duplicates is the same class of silent defect this change
exists to remove, so the construct is diagnosed and the message names the
statement form that does work:

    var out = []; for (var x in xs) { out.add(await f(x)); }

The `for` element's ITERABLE is evaluated once and propagates normally; only
the body is refused, and only when it actually suspends.

Fifteen cases. Every one compares the collection's CONTENTS: a sentinel counts
as an element perfectly well, so a first probe of the map and set shapes checked
`.length` and reported them healthy.

## 0.133.0

### Fixed — the async catch variable leaked out of its block (sce79)

    Future<dynamic> f() async {
      var e = 'outer';
      try { throw StateError('x'); } catch (e) { }
      return e;                       // returned the exception, not 'outer'
    }

`_handleAsyncError` defined the exception variable in the FUNCTION's
environment — its own comment said "can cause collisions" — while
`visitTryStatement` has always given the synchronous path a child environment,
which is what Dart requires. So the variable outlived its block, and in an
async function any caught exception silently overwrote a caller's local of the
same name. `e` is one of the most common names there is; nothing threw and
nothing logged, and the wrong value surfaced wherever the variable was next
read.

The catch block now runs in its own environment, recorded against its clause on
`AsyncExecutionState` and SELECTED from the node's position rather than pushed
and popped. That choice is the substance of the fix: the state machine resumes
at a node rather than executing a block, so a stack would have to be popped on
every exit — fallthrough, return, rethrow, break, an error — and one missed
exit would leak the scope again in a way nothing notices. Selecting
structurally, there is no exit to instrument because there is nothing to undo,
and the scope survives suspension for free.

The environment's parent is whatever was selected when the error was handled,
so a catch inside a loop still reaches the loop's variables; and the loop
environment keeps winning inside a catch, because a loop opened there built its
own as a child of the catch's. That one condition — prefer the catch
environment only when the already-selected one does not already reach it — is
what makes both nestings come out right with no ordering bookkeeping.

Ten cases in `test/scc12_await_in_finally_test.dart`. The clobber is pinned
beside the leak deliberately: the leak alone could be "fixed" by clearing the
variable after the block, which would leave the clobber untouched and look
green.

## 0.132.0

### Fixed — a `return` inside an async `finally` hung the interpreter (sce78)

    Future<int> f() async {
      try { throw StateError('x'); } finally { return 5; }
    }

Real Dart returns 5, and d4rt's synchronous path already did. The async state
machine never completed the function's Future.

CAUSE. When a `ReturnException` reached the state machine it asked whether
`activeTryStatement` has a finally block, and if so stored the value and jumped
to that block's first statement so the finally would run first. With the
`return` written INSIDE that same finally, `activeTryStatement` was still that
try — so the jump went back to the top of the block that had just issued the
return, and did it again. The symptom is a HANG rather than an unresolved
future, and no Dart-level timeout contains it: the machine reschedules through
`Future.microtask`, so a starved event loop never runs the Timer.

scd43 closed the other half of this shape — a throw inside a finally is offered
to the try ENCLOSING that try — but a `return` is not an error and never enters
`_handleAsyncError`, so it needed its own fix on the ReturnException path.

FIXED STRUCTURALLY, per scd41's recorded preference and the way scd43 did its
half: `_isInsideFinallyBlockOf` asks whether the return sits inside this try's
own finally, which is a property of the AST rather than of what has run, so no
new field on `AsyncExecutionState` was needed.

The return does not complete the function on the spot. It discards the pending
exception — Dart's rule is that the finally's abrupt completion replaces
whatever the try body was doing — and then leaves through any ENCLOSING try's
finally, whose own return replaces it in turn. Completing immediately answered
1 for `try { try { throw X } finally { return 1; } } finally { return 2; }`
where Dart answers 2.

Eight cases in `test/scc12_await_in_finally_test.dart`, including two controls:
the finally must still RUN (not be skipped), and a finally WITHOUT a return must
still propagate the exception.

## 0.131.0

### Changed — resolution failures are now marked at the throw site (sce77)

`RuntimeD4rtException.resolutionFailure` is a new named constructor setting a
new `isResolutionFailure` flag. 52 throw sites across `interpreter_visitor`,
`callable`, `environment` and `runtime_types` use it: the ones that mean A NAME
DID NOT RESOLVE — an absent member, constructor, enum value or variable.

Nothing about the hierarchy changed, and that is deliberate. Every `catch`
clause and every `is RuntimeD4rtException` test keeps working unchanged, which
sce67 established is load-bearing — the supertype there was ADDED rather than
swapped precisely because the hierarchy is consulted for control flow in eight
places per visitor. A new subtype would have changed what those sites see. The
messages are untouched too.

WHY. The gap audit decides whether a member exists by classifying the error the
interpreter produced, and it did that by matching the TEXT against a
hand-written list of wordings. Nothing connected that list to the places the
interpreter throws from, so a wording the list did not know made a whole audit
column silently unfalsifiable: the probe ran, the error arrived, and it was
scored as *reachable*. That happened twice in consecutive todos — scd36's
`Cannot access property 'x' on target of type _Foo` left the return-type pass
reporting 0 of 411 while blind to every gap it existed to find, and scd39's
operator wording did the same to the operator column. Both were found by
planting a defect; no passing test could have found either.

The flag ties the two together structurally, so a reworded message can no
longer leave the set silently.

Sites whose wording READS like a resolution failure but is not one are recorded
rather than tagged — `Unsupported operator (...)` fires both when an operator
does not resolve and when the operand types are wrong, and tagging it would make
the audit report gaps it invented.

## 0.130.0

### Changed (BREAKING for TLS scripts) — installing key material now needs CertificatePermission (sce74h)

`SecurityContext`'s eight certificate- and key-loading members are gated by a
new `CertificatePermission`. The four path variants (`usePrivateKey`,
`useCertificateChain`, `setTrustedCertificates`, `setClientAuthorities`) keep
their existing `FilesystemPermission` check as well; the four `*Bytes` variants
were previously ungated entirely and are now gated too.

WHY A CAPABILITY OF ITS OWN when `FilesystemPermission` already covered the
read. It covered it as an ORDINARY read, and a private key is not an ordinary
read: a script scoped to a directory that happens to hold one could hand it to
a `SecurityContext` and serve traffic under the host's identity, with nothing
in the grant list saying that was possible. Naming the capability separately is
what lets an embedder allow a script to read its own data directory without
also allowing it to impersonate the host.

WHY THE BYTES VARIANTS ARE GATED, though they read nothing. The capability is
"install key material into a TLS context", not "open a file" — scd171 left them
ungated on the reasoning that a script holding the bytes had already passed a
gated read, which is true of the FILE but not of the installation. Gating only
the path forms leaves the shorter route to the same end wide open.

A script that loads certificates needs one more grant:

    d4rt.grant(CertificatePermission.load);

The gate lives in `stdlib/io/certificate_permission_helper.dart` rather than
inline, following scd170's precedent: the permission idiom differs between the
twins, so confining it to a helper keeps `io/tls.dart` code-identical and
leaves scd49 one small recorded divergence instead of a large one.

## 0.129.0

### Fixed — an SDK range error could not be caught across a bridged method (sce74)

`BridgedMethodCallable` caught `ArgumentError` to improve the message for
adapter arity problems. `RangeError extends ArgumentError` and `IndexError
implements RangeError`, so that one clause swallowed every SDK RANGE failure
raised by any bridged method and reissued it as an uncatchable
`RuntimeD4rtException`. A script written the idiomatic way —

    try { q.elementAt(0); } on RangeError { ... }

did not catch, and the recovery path its author wrote never ran. Measured on
empty `Queue`, `ListQueue` and `DoubleLinkedQueue`, `elementAt(0)` answered
`RuntimeD4rtException: Invalid arguments for bridged method
'ListQueue.elementAt'` where Dart answers `IndexError`.

The arm is narrowed, not deleted: a preceding `on RangeError { rethrow; }` in
both the instance and static call paths. The clause below still earns its keep
for a plain `ArgumentError`, which adapters raise for arity and argument-shape
problems that have no SDK counterpart. Nothing in `stdlib` throws a bare
`RangeError` or `IndexError` — zero sites, measured — and the interpreter's own
range failures use `Ranged4rtException`, so no interpreter error leaks into a
script's `on RangeError`.

The same clause exists a third time, on the bridged-SUPERCLASS call path in
`runtime_types.dart`, and is narrowed identically. No test reaches that one:
measured, a `super.` call resolves only members the bridged superclass DECLARES,
not ones it inherits, so `super.removeFirst()` works and answers `StateError`
while `super.elementAt(0)` answers "Method 'elementAt' not found in bridged
superclass 'ListQueue'" — and every RangeError-raising member is an inherited
one. The arm is kept because fixing two of three call paths is the
incompleteness the mirror rule exists to prevent, and rethrowing rather than
rewrapping cannot break anything. That resolution gap is a separate defect.

This is scd31's shape (2) — throws the WRONG TYPE where the SDK also throws —
which until now had no detector: the sweep and the standing nullable test both
read a returned value, which is what shape (1) changes and shape (2) leaves
alone. `test/stdlib/sce74_sdk_error_type_parity_test.dart` drives 60 cases over
twelve empty collection receivers, computing the expected type by running the
same operation on a native collection rather than from a written-down table.

## 0.128.0

### Documentation — the must-not-widen exception, and why the bundle cannot lift it (sce72)

`coerceElements` accepts an `int` where a `double` is wanted, which reads as the
widening the audit's rule forbids. It is a measured exception, and the rule now
says so beside itself rather than only in a comment here.

Dart separates `Float32List.fromList([1, 2])` (compiles — an int literal in a
double context IS a double) from a `List<int>` variable (does not) by the STATIC
TYPE of the argument expression. d4rt erases element types, so both arrive
indistinguishable and no rule written at that point can separate them. Accepting
admits the common valid script; rejecting breaks it.

SCE72 then measured the only thing that could lift the limit — could the mirror
carry the static type? No, and not for want of effort:

| parse mode | `[1, 2]` | `ints` |
| --- | --- | --- |
| `parseString` — what both interpreters AND the bundler use | `null` | `null` |
| `AnalysisContextCollection` — resolved | `List<double>` | `List<int>` |

The analyzer knows it only under RESOLUTION, which nothing in this repo
performs. So the mirror is not failing to carry something it was given; the
information is never computed. At interpret time it cannot be: `execute(source:)`
takes a string with no file, and the Flutter line runs a bundle on a device with
no analyzer.

The bundler could resolve — it has a path — and it still would not help.
`coerceElements` is one shared, mirrored helper serving both lines and cannot
know whether its caller came from a resolved bundle, so a bundle-only type would
make the Flutter line stricter than the source line for the same script. That
divergence is what the mirror rule exists to prevent.

Comment and documentation only; no behaviour changes.

## 0.127.0

### Changed — a re-wrapped exception keeps what the first wrap preserved (sce70)

A clause shaped

```dart
} on RuntimeD4rtException catch (e) {
  throw RuntimeD4rtException("...: ${e.message}");
}
```

re-wraps a wrapper that already carries `originalException` and
`originalStackTrace`, and builds the new one from the MESSAGE ALONE. Everything
SCC11 preserved one frame below is discarded at the re-wrap — which is why two
of SCD34's three trace widenings were still invisible to a script after being
applied.

All such sites now forward both fields: 22 in `tom_d4rt`, 23 in `tom_d4rt_ast`.

**THIS IS A SEMANTIC CORRECTION, NOT A NEW RULE.** `visitTryStatement` already
prefers `originalException` over the wrapper when one survives (OPEN B.5), so a
script's `catch (e)` receives the real native exception and `on <NativeType>`
dispatch matches. The defect was that whether a script saw the real exception
depended on HOW MANY WRAP LAYERS it had crossed. Where a payload survives, a
script now catches the native exception rather than the `RuntimeD4rtException`
wrapper, and a trace points at the native throw rather than at the interpreter.
Where no payload was preserved, nothing changes.

The message prefixes are kept rather than replaced by `rethrow`. They are the
only thing the re-wrap contributes, and the payload outcome is identical either
way: an inner wrapper carrying a native exception reaches the script as that
exception whether it is rethrown or re-wrapped with the payload forwarded. The
prefix is the difference, and it is worth keeping.

Two sites were decided individually rather than by pattern. The type-check
clause re-wraps inside an `InternalInterpreterD4rtException` and was invisible
to a scan keyed on the outer throw. The extension `on`-type clause holds two
throws, and only one is a re-wrap: its sibling fires when the caught error is an
`UndefinedNameD4rtException`, a name that resolved to nothing, which scc31 keeps
deliberately uncatchable and which carries no payload to forward.

## 0.126.0

### Changed — `io/socket.dart` is diffable against its twin again (sce69)

The two copies differed by thirteen lines where they should differ by one. The
prose was identical; only the comment WRAP WIDTH differed, which no formatter
normalises and no guard reports, and which defeats the `diff` the mirror rule
exists to make readable.

Rebuilt from `tom_d4rt`'s copy with only the canonical import changed —
`package:tom_d4rt_ast/runtime.dart`, not `d4rt.dart`, which is the rewrite a
blanket package-name substitution gets wrong and F-SCC92-3 rejects.

Comment only; no behaviour changes.

## 0.125.0

### Changed — a missing member is catchable as `NoSuchMethodError` (sce67)

Asking a receiver for something it does not have reported two ways, decided by
the member KIND rather than by anything a script can see:

```
InternetAddressType.IPv4.host     -> UndefinedMemberD4rtException
InternetAddressType.IPv4.lookup() -> D4rtNoSuchMethodError
```

Only the second `implements NoSuchMethodError`, so a script writing
`try { ... } on NoSuchMethodError catch (_)` handled the method half of the
same failure and missed the getter half. F-SCC8-5's reasoning — "a missing
member is the same failure real Dart reports at runtime, and asserting the SDK
supertype means a script can catch it the way it would catch the real one" —
does not stop applying at getters.

`UndefinedMemberD4rtException` now implements `NoSuchMethodError` as well.

**The supertype is ADDED, not swapped.** It is still a
`RuntimeD4rtException`, so every existing `on RuntimeD4rtException` clause
keeps working, and every internal `is UndefinedMemberD4rtException` test — the
typed signal several call sites read to decide whether to attempt extension
lookup — is unaffected. Those sites select on the exact type, never on the SDK
supertype.

**STATIC member absence and undefined NAMES are deliberately left out.** Real
Dart rejects `Klass.missing` and a bare undefined name at COMPILE time, so
there is no runtime `NoSuchMethodError` for a script to catch; giving them the
supertype would make d4rt strictly *more* catchable than the platform — the
mistake `D4rtRangeError` records for `IndexError`, and the reason scc31 keeps
the undefined-name case uncatchable. A control case pins that they stay out.

Measured across the seven ways the interpreter reports an absence: five were
uncatchable as `NoSuchMethodError` before this, and the two instance-getter
rows are the ones real Dart says should not have been.

## 0.124.0

### Documentation — `asUint8ListView` records why it exists (sce65)

The eleven typed-list `asUint8ListView` adapters sat under a bare
`// Typed methods` heading, which says what they are and nothing about why
they exist beyond the SDK. No typed list declares the member: `dart analyze`
on a native one answers "The method 'asUint8ListView' isn't defined".

That makes it the WIDENING SHAPE — a script using it is green in the
interpreter and does not compile as real Dart, so the error surfaces only when
the script leaves here. The acceptance had been recorded, but in
`doc/stdlib_sdk_gap_audit.md` rather than where a reader meets the member.

Each definition now carries the reason, and the KEEP decision rather than
inheriting it. The removal precedent — scd24's four `InternetAddressType`
members — does not apply: those were wired to unrelated `Object` members and
returned wrong answers, while this returns what its name says. Nothing in the
workspace calls it, so removing it would be a breaking interpreter change
bought for no reader, and all eleven variants are pinned present by
`F-SCC60-3-*`.

Comment only; no behaviour changes. Identical in both mirrored trees.

## 0.123.0

### Changed — doc comments that name a library are marked as prose (sce56)

The mirror of the `tom_d4rt` change: `d4rt_user_bridge_annotation.dart` shows
annotation targets in packages this one does not depend on, now marked
`doc-ref: ok` with the reason. Both copies stay identical under the import
rewrite, as the mirror rule requires.

## 0.122.0

Name resolution: yes — a name narrowed by import scope is retrieved by kind, not as a class only (sce25).

### Fixed — an ambiguous name narrowed by import scope was only retrieved as a class

Mirror of the `tom_d4rt` fix of the same name: a name narrowed to a single
imported package was retrieved as a bridged class only, so a narrowed enum or
top-level value fell through to the ambiguity throw. Retrieval now consults the
alias environment by kind.

## 0.121.0

Name resolution: yes — same-name bridged enums and top-level values are ambiguous rather than last-wins (sce25).

### Fixed — same-name bridged enums and top-level values are ambiguous, not last-wins

The ambiguity machinery — source URIs per name, `qualifier.Name` aliases,
`AmbiguousBridgedNameException`, platform precedence, import-scope narrowing —
existed for bridged CLASSES only. Two packages that each bridged an enum `Mode`
or a top-level `parse()` left the bare name silently bound to whichever
registered LAST, and the displaced declaration had no qualifier to be reached
by: it was simply gone. Measured before the fix — bare `Mode` returned the
second enum, and `pkg_b.Mode` threw `UndefinedNameD4rtException`.

Generalised rather than copied per kind, which is what the class path already
made possible: the ambiguity map was always `name → (qualifier → source URI)`
and carries no kind. `_collectAmbiguityCandidate`, `_bindQualifierAlias`,
`_markAmbiguousBridgeName` and `_peersAfterPlatformPrecedence` now take
`Object?`, the alias environment binds whichever kind the name designates, and
`define` / `defineBridgedEnum` take an optional `sourceUri` and record it.

The lookup needed two checks rather than one. The class branch had its own,
because it must run before the class is returned; a value is found in the FIRST
branch of the walk, so a check further down never runs for it.

**The rule is gated on the source URI, deliberately**, exactly as it is for
classes: two candidates that yield no qualifier — an embedder registering
directly, a script rebinding its own variable — keep the legacy overwrite. An
error whose remedy does not exist is worse than the arbitrary pick it replaces.

**The import-scope narrowing needed one more fix than expected.** It reduced an
ambiguous enum to a single candidate correctly, then failed to RETRIEVE it: the
retrieval read `_bridgedClasses[name]` only, so the null fell through and the
name stayed ambiguous however the script imported. It now reads the alias
environment by kind. The narrowing was never the missing piece; the lookup was.

`module_loader` and the AST runner's warm parent now pass the declaring URI
through, which is what makes the rule reachable rather than theoretical.

## 0.120.0

### Fixed — a braceless `then` branch with an `else` no longer ends an async function

    var x = 0; var c = true;
    if (c) x = 1; else x = 2;
    return x + 10;                // answered 1, not 11

`_findNextSequentialNode` returned null for the end of a single-statement
`then` branch whenever an `else` was present, on the reasoning that *"there is
no next sequential node after the then if there is an else"*. There is: the
`else` is the branch NOT taken, and control resumes after the `if` — which is
exactly what the neighbouring `else` case had always returned. Null stopped the
state machine, so the function completed with whatever value it had last
evaluated.

The two branches of that decision are now one; the distinction was the bug.

**Braced branches were never affected**, because a `{ … }` then-branch ends at
the block-end case instead. Almost all Dart is braced, which is why this
survived.

**In a loop body a wrong value became no value**: the loop never advanced and
the function answered `null`. That is the DONE WHEN's second clause and the
case worth knowing about — it is also the one that HANGS rather than fails if
it ever regresses, since the loop condition is never re-evaluated.

## 0.119.0

### Fixed — a `do` loop in an async body ran its condition before its body

`do { n++; } while (false);` answered `0`. A `do` body always runs once, so
Dart — and this interpreter's own synchronous visitor — answer `1`.

The state machine re-enters a `DoStatement` node for two different reasons:
arriving at the loop from the statement before it, and coming back from the end
of its body. It assumed the second every time. The comment that stood there
said so, and named the cost: *"if we entered the loop in a non-standard way,
this could fail"*. Arriving from the statement before the loop is the standard
way.

A loop whose condition is true on entry was unaffected — `do { n++; } while
(n < 3)` counts to 3 either way — which is why nothing caught it.

`AsyncExecutionState.doBodiesStarted` now tells the two arrivals apart: absent
means the body has not run and must, present means the body finished and the
condition decides. The mark is forgotten when the loop is left, by a false
condition or by `break` / a labelled break (`_leaveLoopsFor`), because a `do`
nested in another loop runs again on the outer loop's next iteration and would
otherwise check its condition first — the same defect one level in, where it is
much harder to see.

`continue` deliberately keeps the mark: it returns to the loop from inside, and
Dart evaluates the condition for it (F-SCD4-13 pins the same rule from the jump
side).

An empty body (`do {} while (c);`) has no first statement to jump to; it falls
back to the loop node so the condition decides, which would otherwise stop the
machine and never return.

## 0.118.0

### Fixed — a `return` that unwinds through a `finally` in an async body

`try { return 'r'; } finally { l.add(1); } return 'end';` answered `'end'`. The
return was recorded, the finally ran, and then the machine carried on with the
statement after the try, whose value won.

It looked like the mechanism was present, because it worked whenever the try
was the LAST thing in the function: there is no next node, the machine stops,
and the exit at the bottom of the loop completes with the stored value. With
anything after the try it did not.

Worse than a lost value: an ordinary statement between an inner try and an
outer finally RAN. The nested case answered `end:A,MID,B` where Dart — and this
interpreter's own SYNCHRONOUS visitor — answer `x`. A function that is
unwinding must execute nothing but the finally blocks between the return and
the function boundary.

`_findNextSequentialNode`'s "End of a Finally block" case now consults
`returnAfterFinally`: with a return pending it walks to the next enclosing
`try` with a non-empty `finally` and runs that, or stops so the loop's exit
completes with the value. The walk skips a try reached from its OWN finally
(already running) and one whose finally is empty (nothing to run).

STILL BROKEN, and deliberately not fixed here: `break` and `continue` out of a
try in an async body skip its finally. That needs a pending-jump mechanism
rather than this one — see scf6. The tests record today's wrong answers for
both, beside the synchronous visitor's correct ones, so the next change to this
machinery cannot move them silently.

## 0.117.0

### Fixed — an `await` inside an expression-bodied async function no longer swallows its expression

`Future<int> a() async => 2; main() async => "x${await a()}y";` returned `2`,
not `"x2y"`. A silent wrong answer, in one of the commonest shapes of async
Dart.

**It was not a string-interpolation bug**, which is how it presented. Measured:
`=> (await a()) + 10` returned `2` rather than `12`, and
`=> "x" + (await a()).toString()` returned `2` rather than `"x2"`.
Interpolation was one instance of "any composite expression".

The discriminator is the BODY. A block body never had this — `return
"x${await a()}y";` is a ReturnStatement, and SCC40 already re-runs a suspended
statement with per-site replay from `resolvedAwaitResults`. An expression body
has no statement, so nothing re-ran: `_determineNextNodeAfterAwait` recognised
no case, returned null, the machine stopped, and the function completed with
`lastAwaitResult` — the awaited value standing in for the whole expression.

The repair re-uses SCC40 rather than adding a case per expression kind: an
expression body is the only other unit the machine executes, so it is handed
back and evaluated again. Resolved await sites replay, the first one not yet
reached suspends for real, and the pass where nothing suspends produces the
value.

`=> await a()` used to arrive at the same dead end and be right by accident —
the machine stopped, and the awaited value *was* the whole expression. It now
takes the same route on purpose.

KNOWN, NOT FIXED HERE: an `await` inside a collection literal
(`[await a(), 9]`) still puts the interpreter's own `AsyncSuspensionRequest`
into the collection. That one fails in block bodies too, so it is a different
defect — see scf5.

## 0.116.0

### Changed — `await for` is lazy: one element at a time, and the stream is cancelled when the loop is left

`await for` suspended ONCE on `stream.toList()` and then walked the resulting
list. Three consequences, one of them total:

* a loop over an **infinite** stream never ran its body at all — `toList()`
  never completes, and a `break` cannot help because the break is in the body;
* every element was produced before the body ran once, so a producer's side
  effects all landed up front;
* `break` meant nothing to the producer: nothing was ever cancelled.

The loop is now driven by a `StreamIterator` — one suspension per element on
`moveNext()`, `current` bound on resumption — and every loop-exit path cancels
the iterator, because `truncateLoopStacks` (SCD4's centralised exit) is the one
place that cannot be forgotten.

The cancel is deliberately not awaited: every caller is a synchronous exit path
in the state machine. It happens promptly; what is not guaranteed is its
ORDERING against code after the loop, which is why a test observing a
generator's `finally` has to await a turn first.

**Half of SCE16, not all of it.** An `async*` generator still ignores its
listener, so cancelling a subscription does not yet stop the body — see scf4.
`F-SCD4-10` stays skipped, but its failure has changed shape: it returned
`resumed,v1,v2` and now returns `v1,v2,resumed`, so the interleaving is right
and only the cancellation is missing.

## 0.115.0

### Added — a bundle can record what produced it

`AstBundle` and `AstBundleManifest` gain an optional `generator` field, written
and read under the new `AstBundleFormat.keyGenerator` (`"generator"`), for a
producer identity such as `tom_ast_generator 0.1.6`. It is carried through all
three serialization paths — the JSON map, the gzip byte form, and the ZIP
manifest — because a bundle is diagnosed in whichever form it arrived in.

`AstBundleFormat.version` identifies the FORMAT and says nothing about the
producer. For this artefact that gap is worse than for a generated `*.b.dart`:
a bundle is built on a server and shipped to an app that cannot re-derive it,
so a bundle that failed to interpret on device could not say whether it had
been written by a generator older than the app's AST model.

**The format version does NOT bump.** The key is additive and every reader here
takes known keys only, so an older reader ignores it and a bundle written
before the key existed still loads with `generator == null`. A format stamp
bumps for a change that is not backwards compatible; bumping it here would
strand readers over a field they are free to ignore.

Omitting the generator writes no key at all rather than a null-valued one — a
present-but-null key would make every bundle claim provenance and supply none,
which a reader cannot tell from a producer that tried and failed.

This is the read side. Nothing in this package can populate the field: the
value belongs to whatever built the bundle, and `AstBundler` lives in
`tom_ast_generator`, which resolves this package from pub.dev. Bundles start
carrying provenance once that side ships.

## 0.114.0

### Fixed - 49 stdlib adapters no longer discard a surplus argument in silence (scd204)

`socket.add(data, extra)`, `list.skip(2, 3)` and 47 others read the arguments
they wanted and returned, dropping the rest without a word. SCC85 closed 443
adapters this way and left a residue of 23 in three files it could not label:
two of them are helpers shared by several bridged classes — `inheritedListMethods`
by thirteen typed-data lists, `setAlgebraMethods` by five sets — and the
diagnostic takes a `Class.member` string that a shared helper has no way to
name where its adapters are written.

`inheritedListMethods` now takes the class name as a required parameter, threaded
from the thirteen call sites that each already declare it two lines above. It is
required rather than optional so a new typed-data variant cannot omit it and
report the wrong class.

**The residue was larger than recorded, and the reason is a definition.** SCC85's
sweep skipped an adapter whose body held a length test that could REJECT. That is
the right question for a too-FEW guard and the wrong one for this: `if
(positionalArgs.length < 2) throw …` cannot fire on a surplus, and neither can
`positionalArgs.length > 1 ? positionalArgs[1] : null`, which yields a value
rather than rejecting. Measured with that corrected, the three files held 49
unguarded adapters rather than 23.

Every guard is `atMost`, never `exactly`, so the generic `describeArityError`
diagnostic keeps the too-few half — the property F-SCC85-4 pins.

`tom_d4rt/test/stdlib/scd204_surplus_arity_guard_test.dart` keeps the three files
closed in both trees and ratchets the rest.

## 0.113.0

### Fixed - a class name used as a value now compares, hashes and tests like a `Type` (scd198)

`x.runtimeType == Foo` had already been reconciled, so `==` answered correctly.
`hashCode` had not. Equal objects with different hash codes is an `Object`
contract violation, and it explains the symptom set exactly: the comparison
looked fine and every hash-based collection missed —
`<Type, T>{String: v}[x.runtimeType]` was null, `Set<Type>.contains` false,
`List<Type>.indexOf` -1.

This is SCC32's shape on the class-name value, and it takes SCC32's fix in both
halves, because either alone leaves the two map spellings disagreeing:

1. `BridgedClass` delegates `==` and `hashCode` to its `nativeType`.
2. A class name used as a hash key is normalised to that native at storage, in
   `_unwrapHashKey` — Dart's hash lookup asks `lookupKey == storedKey` with the
   lookup key as receiver, and a native `Type` looking up a stored
   `BridgedClass` is rejected by `Type.==`, which no code here can override.

Two bridges for one native type now compare equal. That is deliberate and is
what a re-export is; identity is untouched, which is what the shadow machinery
relies on.

`SomeClass is Type` was false for every class in the language while
`x.runtimeType is Type` was true — the `is` predicate had no arm for a class
name. It has one now, for bridged and interpreted classes alike.

## 0.112.0

### Fixed - `MapEntry.hashCode` was not readable as a value (scd196)

`hashCode` was registered in `MapEntry`'s `methods` map with no getter beside
it, so `e.hashCode` — the spelling every Dart program uses — returned the bound
callable and only the uncompilable `e.hashCode()` produced an int. Nothing
masked it: `map.entries.first.hashCode` silently was not a hash. That is SCC73's
`Runes.iterator` failure, unmasked. It is a getter now.

`IOSink.toString` was registered as a getter; `toString` is a method, so
`f.toString` yielded a String where Dart yields a tear-off. Deleted.

### Fixed - five members declared in two maps at once (scd196)

`hashCode` appeared in both `methods` and `getters` on `Match`, `Pattern` and
`Sink`; `toString` in both on `IsolateSpawnException` and `RemoteError`. The
interpreter reads getters first so the duplicates were inert on the paths a
script takes, but `BridgedInstance.get` is methods-first and would hand back the
bound callable. The wrong entry is deleted in each case — `hashCode` is a
getter, `toString` is a method.

`scd196_member_map_disjointness_test.dart` (both trees) now fails if any bridge
declares one member in two maps. A getter/setter pair is ordinary Dart and is
not reported.

SCD189's SDK-kind guard also gained the implicit `Object` supertype in its walk.
A class declaring no supertype stopped the walk dead, so every inherited member
read as unspeakable — which is a pass. That gap is what hid both defects above.

## 0.111.0

Name resolution: yes — the enum registry records what it displaces, so a displaced enum is reachable (scd194).

### Added - the enum registry records what it displaces (scd194)

`defineBridgedEnum` warned about a name collision and then overwrote. The
displaced enum was gone, and the only trace was a log line that is off in a
normal run — the same condition that let SCB26's missing `StringSink` members
live for that bridge's whole lifetime.

The class registry has recorded every displaced bridge unconditionally since
SCC76, which is what makes `findAllBridgedClassesByName` and the collision
guard possible. The enum namespace now has the same bookkeeping:
`_recordShadowedEnum` at both displacement sites (`defineBridgedEnum` and
`importEnvironment`'s import-wins branch) and `findAllBridgedEnumsByName`
mirroring the class version across the scope chain.

A colliding enum is RECORDED AND REPORTED, not rejected. The class rule — same
`nativeType` is a re-export, a different one is Dart's ambiguous-import case —
transfers in principle, but the enum path has no qualifier machinery, so making
a name ambiguous would leave a script no way to say which one it meant.

`scc76_bridge_name_collision_test.dart` gains the enum axis and the
cross-namespace case (a name must not be both a bridged class and a bridged
enum), in both trees.

## 0.110.0

### Fixed - six bridged members registered under the wrong kind (scd189)

The member audit asks whether a member RESOLVES; the coverage baseline asks
whether it is REACHABLE. Both are satisfied by an adapter that resolves and then
does the wrong thing — SCC73 found `Runes.iterator` registered as a METHOD, so
it handed back the bound callable instead of the iterator and nothing noticed.

`scd189_member_kind_parity_test.dart` asks the cheapest useful form of the next
question: is each member registered as the same KIND the SDK declares? It
compares 1 487 members against the SDK source and found six.

BLOCKING: `StreamSubscription.onData`, `onDone` and `onError` were registered as
SETTERS. Dart declares them as methods, so `sub.onData(h)` — the correct
spelling — failed with "has no instance method named 'onData'" and only the
uncompilable `sub.onData = h` worked. They are methods now; the one test that
exercised this was itself written in the invalid form and is corrected.

FABRICATIONS: `Encoding.inverted`, `Function.hashCode` and
`UnmodifiableListView.reversed` were registered as methods beside a correct
getter, so `utf8.inverted()`, `f.hashCode()` and `view.reversed()` were
accepted — green in the interpreter, rejected by the Dart analyser. Deleted.
`Function.hashCode`'s method was additionally dead: the universal Object getter
shadowed it.

## 0.109.0

### Fixed - `HttpClientResponse.transform` works, by deleting the stub that broke it (scd187)

Reading an HTTP body the way every Dart tutorial shows —
`await response.transform(utf8.decoder).join()` — reported `transform not yet
implemented in interpreted environment`, leaving the hand-folded read
(`toList()`, concatenate, `utf8.decode`) as the only way to get a body out.

There was nothing to implement. The `HttpClientResponse` bridge carried a local
`transform` adapter whose entire body was that throw, under the comment
"Implementation for transform would be complex, placeholder". But an
`HttpClientResponse` IS a `Stream<List<int>>`, and the `Stream` bridge's
`transform` already coerces the transformer and delegates. Deleting the local
adapter is the whole fix — verified by deleting it and re-running the
reproduction before the change was written.

This is SCC51's shape one library over: a leaf bridge redeclaring a member its
supertype supplies, and supplying a worse version. SCC51 deleted seventeen of
these in `dart:collection` for the same reason — the inherited one was already
right. `HttpServer.transform` worked throughout, because nothing shadowed it
there.

The message was also wider than the defect. "not yet implemented in interpreted
environment" reads as a statement about the interpreter; it was one adapter on
one class, one site per tree. A new repo-wide guard
(`scd187_no_unimplemented_stubs_test.dart`) asserts that neither stdlib tree
ships a message of that shape — the set is now empty, which is when a ratchet
costs nothing and is worth having.

## 0.108.0

### Added - `Future.syncValue`, and the SDK floor that was hiding it (scd186)

`scc73_sdk_member_completeness_test.dart` skips any SDK member annotated
`@Since` a version above the package's own floor, so that an SDK upgrade cannot
turn it red demanding members the package may not legally compile against.
`tom_d4rt` declared `^3.9.0` while `Future.syncValue` is `@Since("3.10")`, so it
sat knowingly unbridged.

The floor is now `^3.10.4` — the version `tom_d4rt_ast` and every other package
in the d4rt repo already declared. The two mirrored packages had been
straddling, which SCC26 asks them not to do, and no consumer could use the lower
floor anyway. Raising it made the completeness guard name the member on its own,
with no list to consult; measured across all eight bridged `dart:` libraries it
was the only one hidden, even against an installed 3.12.2 SDK.

`Future.syncValue` is not `Future.value` under another name. Both complete with
the argument, but `value` ADOPTS a future argument — waiting for it and taking
its result, error included — while `syncValue` completes with the argument
as-is. That is what the SDK's "guaranteed to not have an error" rests on, and
the tests pin both sides of the difference against real Dart.

Registered as both a constructor and a static, like every other named `Future`
factory: `Future<T>.syncValue(v)` routes through constructor lookup and
`Future.syncValue(v)` through the static path.

## 0.107.0

### Fixed - `startChunkedConversion` accepts a sink a script can build (scd181)

Every `startChunkedConversion` adapter in `dart:convert` guarded on
`positionalArgs[0] is! Sink<T>` and then cast to `Sink<T>`. The interpreter
erases type arguments, so `ChunkedConversionSink.withCallback(cb)` evaluates to
a `ChunkedConversionSink<Object?>` — and `Sink<Object?>` is not a
`Sink<String>`. Fourteen guards across nine files therefore rejected every sink
a script could construct, which made the whole chunked-conversion surface
unreachable. `ByteConversionSink.from` carried the same guard.

This is the contravariant twin of the `Converter.bind` defect SCC68 fixed, and
it needs a different remedy. A `Stream<T>` is a producer, so `D4.coerceStream`
has elements in hand and maps them; a `Sink<T>` is a consumer, and nothing has
been produced yet. The new `D4.adaptSink<T>` returns a forwarding `Sink<T>`
that delegates `add` and `close` to the erased sink underneath, and passes an
already-correctly-typed sink through untouched so a receiver testing for a
concrete subtype still sees it.

The guards stay, narrowed to `is! Sink`. `ArgumentD4rtException` (what the
`D4.*` helpers throw) and `RuntimeD4rtException` (what stdlib adapters throw)
are siblings under `D4rtException`, not parent and child, so routing the whole
check through the helper would silently change what a script's `catch`
dispatches on.

## 0.106.0

### Fixed - `x is Enum` answers what Dart answers (scd176)

`Enum` was bridged but declared no `isAssignable`, and `_valueHasType`'s
bridged branch only reaches its native-predicate fallback when the bridge has
one. So `is Enum` was FALSE for every bridged value, including genuine SDK
enums — false by omission rather than by any decision.

A PREDICATE, NOT SUPERTYPE EDGES, and the distinction is load-bearing. The
obvious repair is to declare an `-> Enum` edge on every "enum-shaped" bridge.
Measured against Dart, four of the five usual candidates are not enums at all:
`StdioType` and `InternetAddressType` are `final class`, `ProcessSignal` is an
`interface class`, and `FileMode` is a class — all with static const instances
that look like enum values from a script. Only
`HttpClientResponseCompressionState` is a real `enum`. Hand-declared edges
would have turned four correct answers into wrong ones; asking the native
value classifies each correctly with no list to maintain.

`is Comparable` is deliberately untouched. Dart answers FALSE for all five,
including the genuine enum — `Enum` does not extend `Comparable` — and the
bridge declares no `compareTo`, so the interpreter's existing `false` is
already right.

The hierarchy audit's one `_declinedEdges` entry is removed: it held this
question open, and the audit now reports the edge as satisfied via
`isAssignable` rather than missing by decision.

## 0.105.0

### Added - the TLS pair: `X509Certificate` and `SecurityContext` (scd171)

Both were consumed by adapters and registered nowhere. `SecurityContext` is
what `HttpServer.bindSecure` and `HttpClient(context:)` cast their argument to,
so a script had no way to build the value they demand and both entry points
were unreachable. `X509Certificate` is what the bridged `HttpRequest.certificate`
and `HttpClientResponse.certificate` getters return — with no bridge claiming
it, every member call on the result died with `Undefined property or method
... on _X509CertificateImpl`.

That one failed SILENTLY, and outlived the sweep built to catch it: SCC24 skips
null getters, and `certificate` is null on a plain-HTTP request. Both trees'
sweeps now capture a real certificate from a loopback TLS handshake, so the
blind spot is closed for this type.

`SecurityContext`'s four file-reading members — `usePrivateKey`,
`useCertificateChain`, `setTrustedCertificates`, `setClientAuthorities` — go
through the same `FilesystemPermission` gate as `File` and `Directory`. Handing
the path straight to the SDK would let a script scoped to one directory read a
private key anywhere on the host through a TLS API. The `*Bytes` variants read
nothing and are ungated.

`alpnSupported` is deliberately not bridged: the SDK deprecates it.

## 0.104.0

### Fixed - `NetworkPermission` now gates every socket-acquiring bridge (scd170)

`NetworkPermission` was declared, documented and threaded through the
permission system, and in the whole of `lib` it gated exactly ONE call site:
`InternetAddress.lookup`. Everything that opens a socket ran unchecked —
`Socket.connect` / `startConnect`, `ServerSocket.bind`, `RawSocket.connect` /
`startConnect`, `RawServerSocket.bind`, `RawDatagramSocket.bind`,
`HttpServer.bind` / `bindSecure` / `listenOn`, `WebSocket.connect`, and all
fourteen `HttpClient` request methods.

What stood in for a gate was the IMPORT gate on `dart:io`, which is keyed on
`FilesystemPermission`. A script granted filesystem access therefore received
unrestricted inbound and outbound network access. The quest's standing
constraint is that the interpreter "must remain fully sandboxed".

It is one sweep rather than a gate per class because a partial gate reads as a
working sandbox: `HttpServer.bind` alone is bypassable with
`ServerSocket.bind` + `HttpServer.listenOn`, `HttpClient.getUrl` alone with
`HttpClient.open`, and all of HTTP with `Socket.connect`.

The host and port are passed through, so `NetworkPermission.connectTo` now
means something. The one gate that existed took a `host` argument and dropped
it, asking only `{'type': 'network', 'connect': true}`.

Each operation asks for exactly one flag — connects ask `connect`, binds ask
`bind`, serving an already-bound socket asks `listen` — because
`NetworkPermission.allows` requires every requested flag to be granted, so a
combination would make the single-capability grants unusable.

The `dart:io` import gate's key is deliberately unchanged; decoupling it is a
breaking change to how every existing permission set is read.

## 0.103.0

### Fixed - a throw inside an `async` catch block no longer spins the machine (scd169)

`_handleAsyncError` found the enclosing try with `_findEnclosingTryStatement`,
which for an error raised in a catch block returns the try that catch belongs
to. `selectCatchClause` then matched a clause of that same try, the clause ran
and threw again, and the error was re-offered to the same try. The script did
not fail and did not complete: it looped. Measured before the fix, the catch
block of a four-line script ran **135,239 times in six seconds**.

The symptom reported was "the returned future is never completed", which is
true but misleading — the isolate is spinning, so no Timer runs and neither
`dart test`'s per-test timeout nor a host-side `Future.timeout` fires. The
process has to be killed with a signal.

Dart's rule is that an exception raised in a catch block of `T` is not
catchable by `T`: the handler that would claim it is the one already running.
`_isInsideCatchClauseOf` answers that from the AST, and it is applied in two
places because they cover different cases — the outward search now treats a try
whose clauses are all ineligible as no handler at all, and clause selection
refuses to match on a try that stays in the search because it has a `finally`.

That `finally` still runs before the error carries on outward, as the
synchronous path and the language both require; skipping the try outright would
stop the spin and silently drop it.

It was not limited to interpreter-level errors. An ordinary
`throw ArgumentError(...)` from a catch block did the same, so this was plain
correct Dart hanging, not an edge case of error reporting.

## 0.102.0

### Changed - `Uint8List` shares the inherited getters with its ten siblings (scd166)

SCD28 folded this variant's methods and setters onto `inheritedListMethods` /
`inheritedListSetters` and left its `getters` map hand-rolled. That kept
`Uint8List` the one typed-data variant of eleven that would not receive the
next getter added to `inheritedListGetters`, which is the exposure that
produced SCB3 (`sort`/`shuffle`/`asUnmodifiableView` resolving here and
nowhere else) and SCC9 (a `_TypeError` where the family raised a catchable
`UnsupportedError`).

The three getters it declared — `single`, `iterator`, `reversed` — were
equivalent to the helper's, so the effective member set is unchanged and no
behaviour moves: all eleven variants exposed the same fourteen getters before
this change and after it. What changes is that they now do so from one source.

The comment claiming `Uint8List` "hand-rolls its instance maps rather than
sharing inheritedListMethods" is removed; it had been false since SCD28, three
lines below the spread it denied.

## 0.101.0

### Changed - the `ServerSocket` bridge records why it shadows 28 `Stream` members (scd162)

SCD38 registered `ServerSocket -> Stream`, which made every `Stream` adapter
reachable through the walk. The 21 methods and 7 getters this bridge spells out
by hand have shadowed an inherited copy ever since, and nothing said whether
that was a decision or an oversight.

It is now written at the bridge: DELETE THEM, once the shadow differential can
see them. `F-SCC51-8` is the only thing that can say 28 copies are redundant
rather than subtly different, and its fixture table covers the collection
bridges alone. SCD152 is why that gate matters — driving the previously-skipped
half of that differential found `HashMap.map` rebuilding its result wrongly, a
leaf copy that had looked like pure redundancy for as long as nobody invoked it.

Also recorded, because it is wrong today and waits on nothing: the arity
diagnostics in `ServerSocketIo` say `Socket.map`, `Socket.where`, `Socket.fold`
— copied from the `Socket` bridge above, naming the wrong class.

Comment only; no adapter changed.

## 0.100.0

### Fixed - `HashMap.map` / `LinkedHashMap.map` ignored the entry the callback returns (scd152)

Both bridges carried a local `map` adapter that rebuilt the result as
`MapEntry(key, callbackResult)` — keeping the ORIGINAL key and storing whatever
the callback returned as the value. `Map.map`'s contract is that the callback
returns a `MapEntry` supplying BOTH halves. So

```dart
HashMap.from({'a': 1}).map((k, v) => MapEntry(v, k))
```

produced `{'a': MapEntry(1, 'a')}` where Dart gives `{1: 'a'}`. The shared
`Map.map` adapter has always been right, including unwrapping a
`BridgedInstance<MapEntry>` an interpreted `MapEntry(...)` produces, so the fix
is to delete the two local copies and let it answer. `SplayTreeMap` never had a
copy and was already correct — byte-for-byte the SCB17 `addEntries` asymmetry,
where two of three map siblings carried the same divergent duplicate.

### Changed - the `[]=` adapters on three map bridges no longer diverge

`HashMap`, `LinkedHashMap` and `SplayTreeMap` each declared a local `[]=`
returning the assigned value, while `Map.[]=` returns null. Not observable from
a script — the interpreter discards the adapter's result and yields the assigned
value itself — but a shadowed adapter whose body differs from the one it hides is
what SCC51 exists to remove, so the local copies are gone.

### Changed - the SCC51 shadow differential drives every pair (scd152)

`F-SCC51-8` compared 281 of 542 shadowed pairs and SKIPPED 261, because its
harness invokes adapters directly and a callback argument needs an
interpreter-side `Callable` it did not build. The skipped half is where SCC51
predicted divergence would hide, and both defects above were in it.

Seven native callables and a per-member argument recipe remove the skip
category entirely: the walk now compares **537** pairs with **no** skips. Two
new counters make the ways it could stop measuring visible instead of silent —
`undrivable` for a shadowed member with no recipe, and `vacuous` for a pair
where both adapters rejected the arguments, which is agreement about nothing
rather than a passing comparison. Both are asserted zero; the old skip set
reached 261 precisely because nothing objected to it growing.

The skip set was never only about callables, incidentally: of its 38 names, some
twenty — `clear`, `removeLast`, `insert`, `setRange`, `asMap`, `[]=` and the rest
— take no callback at all and were simply missing an argument recipe.

## 0.99.0

### Changed - `_isInterpreterOwned` now covers `InterpretedRecord` (scd147)

The predicate SCC49 added to keep its structural pass from guessing a bridge for
the interpreter's own representation tested `Enum`, `RuntimeType`, `RuntimeValue`
and `Callable`. `InterpretedRecord` implements none of them, so the predicate
could not see it - harmless only because no bridge is named `Record`, which Dart
3 records make an entirely plausible addition. The predicate's contract is "is
this the interpreter's own representation"; a record is, so leaving it out made
the answer depend on the registry.

### The boundary is held by SCD132, not by the predicate - measured

Measured over the live registry (84 bridges): **eight** interpreter-owned type
names match a bridge name today, not the one the 43-failure incident found.
`BridgedEnum` and `InterpretedEnum` end with `Enum`; `InterpretedFunction` with
`Function`; the four `*RuntimeType` types with `Type`; and `TypeParameter` matches
`Type` as a >=3-character PREFIX.

All eight are `RuntimeType` or `Callable`, so the predicate covers them - but only
at step 4 of `toBridgedInstance`, the single site that consults it. `toBridgedClass`
and its PASS B prefix fallback do not ask, and no interpreter-owned type is claimed
there today for a different reason: ablate SCD132's corroboration requirement and
`TypeParameter` is immediately claimed by the `Type` bridge.

That protection is incidental - SCD132 was written about bridge-to-bridge false
positives (`TextDirection` claimed by `Text`) and knows nothing about this
distinction - and nothing recorded it, so widening PASS B again, or a bridge
declaring one of these in its `nativeNames`, would reopen the hazard silently.
`tom_d4rt/test/scd147_interpreter_owned_boundary_test.dart` now pins it, asserting
the property at `toBridgedClass` precisely because no predicate guards it there.

No behaviour change for any value that resolves today: the predicate addition is
inert while no `Record` bridge exists, and the guard is a test.

## 0.98.0

### Changed - a native object no bridge claims now says so (scd145)

A member call on a native object the interpreter never bridged reported

```
Undefined property or method 'moveNext' on _TallyIterator
```

The real cause - `Cannot bridge native object: No registered bridged class found
for native type ...` - is thrown at the end of `Environment.toBridgedClass` and
then absorbed: `InterpreterVisitorExtension.toBridgedInstance` catches it,
revokes it and returns `(null, false)`. That catch is correct and load-bearing,
because its callers use the `false` as a control-flow signal and fall through to
other registries - an interpreter-internal value legitimately has no bridge. The
cost was that the cause was gone by the time the fallthrough chain gave up, and
the reader was pointed at the member: they went looking for a missing method on a
bridge that does not exist.

The two member-error sites for a raw native receiver now append the cause:

```
Undefined property or method 'tally' on Zqwx. No bridge claims this type: no
bridged class is registered for the native type Zqwx, so the object was never
bridged and has no members at all - the missing member is a consequence.
Register a bridge for Zqwx, or add 'Zqwx' to an existing bridge's `nativeNames`.
```

**Only the message changes** - not the exception type, not `memberName`, not
`receiver`, and not the control flow. `environment.dart` already records why
widening resolution instead broke 43 enum-dispatch tests: callers use the throw
as a signal. A message change on a path that is already failing cannot regress a
passing one.

Two exclusions, and they are the interesting part. Interpreter-internal values
are tested against the abstractions the interpreter owns - `RuntimeValue`,
`RuntimeType`, `Callable`, `InterpretedRecord` - rather than a list of concrete
types, because a list is what rots when a new value shape appears; a
script-declared class has no bridge and is not supposed to, so the clause would
be noise on every script typo. And a type a bridge DOES claim earns nothing,
because there the member really is the problem.

This matters more after SCC49, not less: that change made implementation types
named after their interface resolve structurally, so what still reaches this path
is the hard residue - types the SDK abbreviates (`_StreamSinkWrapper`,
`_ControllerSubscription`) and types with no naming relationship to any bridge.
Those are exactly the cases where the reader most needs the diagnostic to name
the cause.

## 0.97.0

### Added - a bridged function typedef can carry its positional arity (scd137)

scd136 made a bridged function typedef accept any callable, arity-blind,
because `BridgedClass(nativeType: Function, name: typedef.name)` was all that
survived generation: the signature was discarded, so `VoidCallback` and
`ValueChanged` were indistinguishable at runtime. A zero-argument closure
passed where a one-argument callback is required bound happily, then threw at
the call with a message naming neither the parameter nor the typedef.

`BridgedClass` now carries `typedefRequiredPositional` /
`typedefMaxPositional`, and `FunctionRuntimeType.isSubtypeOf` uses them to
refuse a callable that PROVABLY cannot be invoked - moving the failure to the
binding, where the parameter and the typedef can be named.

The rule is deliberately narrow, because the prize is a better error rather
than a caught bug: the program is broken either way, so a false rejection -
refusing a callback that works, across every Flutter widget - costs far more
than the diagnostic gains.

- **Arity only; return types are never consulted.** An interpreted closure
  always resolves to `dynamic Function(...)`, so checking returns would refuse
  working callbacks wholesale.
- **Only the typedef's REQUIRED positional count is checked**, never its
  maximum. That is the one invocation shape a typedef guarantees; rejecting on
  a possibility is how a working callback gets refused.
- **Optional positionals on the callable side count toward what it accepts**,
  so a closure taking one required and one optional argument serves a
  one-argument typedef.
- **No arity, no opinion.** A bridge registered without it behaves exactly as
  scd136 left it.

`registerFunctionTypedef` gains two optional named parameters, and the
`functionTypedefs` record gains two nullable fields - both additive.

**This is inert until a generator that emits the arity ships.** Every
generated bridge in existence registers typedefs without it, so nothing
changes for any current consumer. The generator half is tracked separately
(sce163): generated output has to compile against the PUBLISHED interpreter,
and it cannot emit a call to an API that does not exist yet - which the
GEN-121 analyse gate demonstrated by going red the moment it tried.

## 0.96.0

### Fixed — an interpreted closure is accepted against a bridged function typedef (scd136 / GEN-125)

Passing a script closure to any Flutter callback parameter was rejected:

```
type 'dynamic Function()'        is not a subtype of type 'VoidCallback?' of 'onPressed'
type 'dynamic Function(dynamic)' is not a subtype of type 'ValueChanged'  of 'onChanged'
```

A function typedef has no bridgeable class, so it is registered as
`BridgedClass(nativeType: Function, name: typedef.name)` — and
`FunctionRuntimeType.isSubtypeOf` ended by identifying `Function` **by name**.
The bridge's name is `VoidCallback`, which is the one property of that
registration deliberately not `Function`, so the nominal test could never match
one. A bridged typedef is a structural type wearing a nominal name, which is
also why the two escape hatches in `_checkArgumentType` (skip structural
annotations, exempt a declared `Function` by name) both miss it.

`isSubtypeOf` now asks what the bridge IS rather than what it is called:

```dart
if (other is BridgedClass && other.nativeType == Function) return true;
```

This subsumes the nominal test — `dart:core`'s own `Function` bridge carries
`nativeType: Function` too — and because the argument check, the return check
and `is`/`as` all route through the same method, one rule repairs all three.

Deliberately arity-blind, exactly as the nominal test it subsumes was: the
bridge carries `nativeType: Function` and nothing else, so there is no signature
to check a closure against. Making it carry one is a generator change, tracked
as scd137. The rule therefore does not widen what is accepted for typedefs that
already matched — it stops rejecting the ones that never could.

The rule was always wrong; nothing consulted it for arguments until
`_checkArgumentType` began routing declared parameter types through
`isSubtypeOf`, at which point a second reader of an already-wrong answer turned
it into 15 corpus failures and ~276 framework errors across 109 scripts.

## 0.95.0

Name resolution: yes — `Environment.toBridgedClass` no longer claims a bridge on a bare-name prefix (scd132).

### Changed — a bare name prefix no longer claims a bridge (scd132)

`Environment.toBridgedClass` ends in a prefix fallback: if nothing else matched
anywhere in the scope chain, it claimed any registered bridge whose name was a
>=3-character prefix of the native type name, with no other corroboration. Two
of the three false positives that method's own header documents are that rule
firing — `MappedListIterable` claimed by `Map`, `TextDirection` claimed by
`Text` — and each was repaired by routing ONE caller around the fallback, so the
rule survived every fix and the next name-shaped coincidence was going to be
claimed just as silently. A bridge named `Set` claims `Settings`.

The prefix now only finds a CANDIDATE. The bridge must also declare the
connection: `nativeNames` naming the type, or a supertype-registry edge between
the two names. Both are things somebody wrote down. When nothing corroborates,
the method throws — which every caller already handles, and which is more honest
than a silently wrong dispatch.

`isAssignable` is the obvious third corroboration and is deliberately absent: it
takes a VALUE and this method is given only a `Type`. Callers that hold the
value already consult it.

**Measured before narrowing.** A probe on every fallback match across both
trees' full suites fired 12 times: 11 for one test's deliberately prefix-named
proxy, and once for `TextDirection` → `Text`, the known false positive.
G-DCLI-05's `ProgressBothImpl` → `Progress` — the case the fallback was ADDED
for — never reached it; an earlier pass resolves it today. So the rule had no
measured legitimate user. The one test that relied on it now declares
`nativeNames`, which is the relationship becoming declared instead of guessed.

## 0.94.1

### Documentation — two cross-tree facts recorded at the code they constrain (scd125)

No behaviour change; comments only. Both facts were held in a `tom_d4rt` TEST
header, which is the one place a reader changing this package's interpreter has
no reason to look.

- At the applied-return-type capture in `interpreter_visitor.dart`: the two
  interpreters reach the same answer by different routes. `tom_d4rt` walks up
  from a return statement to its enclosing declaration and reads the annotation
  there; an `SAstNode` carries no parent pointer, so this tree captures at
  declaration time and checks the stored type at return time. A regression in
  either route is invisible to the other, which is why both DFUB6 suites are
  worth running.
- At the record-type-annotation resolution: the field types used not to arrive
  at all. `tom_ast_generator` flattened every `RecordTypeAnnotationField` into
  an opaque node, so an annotation reached the resolver carrying only its arity,
  and the record cases were pinned to that degraded answer until DGUB8
  (`tom_d4rt_ast >=0.14.0` / `tom_ast_generator >=0.1.5`). The general shape is
  worth having at the site: a node the copier flattens yields a mirror tree that
  interprets consistently and wrongly, so the only instrument is a difference
  between the two interpreters on the same source.

## 0.94.0

### Fixed — a declaration keeps every `await` in its initializer (scd121)

`var s = (await a) + (await b);` bound `s = 1`, not 3. The resumption branch for
a variable declaration bound `futureResult` — the value of ONE await — straight
to the variable and moved on, so everything else in the initializer was
discarded. `var s = '${await a},${await b}';` was the same defect wearing a
different symptom: `s` held the raw int, and the next line failed its own
declared type with an error about a value the script never wrote. SCC40 had
fixed this family on the RETURN route; this branch never got the treatment.

**It was never a missing-evaluation bug.** The discarded operands WERE
evaluated — visible by counting calls — so a repair that produces the right sum
by evaluating an operand twice would pass a value-only test and still be wrong.
The first attempt did exactly that, giving 5 instead of 3: an evaluation started
inside the resumption branch cannot register its suspension with the state
machine (the machine only ever attaches to a suspension raised by executing a
node), so it is discarded and the statement re-executed anyway.

So the branch now evaluates **nothing**. It hands the statement back to the
machine, which executes the declaration again: sites already resolved replay
from `resolvedAwaitResults`, the first one not yet reached suspends for real,
and the variable is bound on the pass where nothing suspends — one evaluation
per pass. The per-site cache is cleared when that statement completes, which for
a declaration can only be seen where it is executed; the `return` route clears
via its own completion path.

### Fixed — `a + b` does not evaluate `b` while `a` is suspended (scd121)

`visitBinaryExpression` evaluated BOTH operands before checking either for a
suspension, so a suspending left operand still cost a full evaluation of the
right, whose value was then thrown away. Invisible for pure operands, and
invisible while a declaration never re-ran; once it did, `(await next()) +
(await next())` against a counter cost three calls for two awaits and six for
three. Dart evaluates `a + b` left to right and never reaches `b` while `a` is
outstanding.

## 0.93.0

### Fixed — a native proxy now binds to a parameter declared as the script class it stands for (scd119)

A script class that extends a bridged class crosses into native code as a
registered `D4InterpretedProxy` — `_InterpretedThemeExtension` for
`class BrandColors extends ThemeExtension<BrandColors>`, and the same for
widgets, painters and states. Ask such a value for its runtime type and the
answer is the BRIDGE's name, so binding it back to a parameter declared as the
script's own class was rejected:

    type 'ThemeExtension' is not a subtype of type 'BrandColors' of 'brand'

Every member access on the same value worked, because the property and method
paths already unwrap a proxy. The type check was the only place that did not —
measured by changing the script's parameter to `dynamic`, which took the
script's framework errors from 1 to 0 with nothing else touched.

`ResolvedBinding.bind` now retries against the interpreted instance behind a
proxy. The retry runs only AFTER the base check has already failed, so it can
remove a rejection but never add one, and the PROXY is still what gets bound —
the value stays whatever native code downstream expects, only the verdict on it
changes. Teaching `Environment.getRuntimeType` to see through every proxy is
the more correct model and was deliberately not done: it would change what
`is`, `as` and `runtimeType` answer for every proxied widget in a live tree.

## 0.92.0

### Fixed — a type alias now resolves to its target (scd100)

SCC33 gave both interpreters an explicit handler for type aliases that returned
null without recursing. That stopped seven further node types reaching the
dispatch backstop, and it made explicit a gap that had been hidden: a typedef
had no runtime representation at all. Both handlers' doc comments said "making
aliases actually resolve is separate work (SCD100)".

**Measured before choosing a fix.** Nineteen shapes were probed; nine were
already fine by leniency, and the rest split two ways — the first group being
the one worth leading with:

- **Seven legal programs THREW.** `1 is I` through `typedef I = int` did not
  answer "no", it raised `Type check failed: Undefined variable: I`. So did a
  generic bound and a RETURN TYPE written through an alias: `typedef I = int;
  I f() => 5;` reported `Type 'I' not found.` and the program never ran.
- **Three accepted silently what Dart rejects** — an `as`, a parameter bind and
  a local, all of which stay lenient when an annotation cannot be resolved.

The handler was never even REACHED: the ordered declaration walk had phases for
enums, classes, extensions, extension types, functions and variables, and none
for type aliases. That is why the gap was total rather than partial.

**The fix is one registration.** Every type-resolution path already funnels
through `environment.get(typeName)` — `is`/`as`, parameter binding, the return
check, generic bounds and a collection literal's type argument — so binding the
alias name to the RuntimeType its target resolves to makes each behave exactly
as if the script had written the target. A new phase runs it to a FIXPOINT so
declaration order does not matter, placed after classes so an alias can name one
and before functions so their annotations can name an alias.

**It had to land in TWO places**, which is worth recording because a fix in
either alone looks complete: the `source:` form is ordered by `d4rt_base.dart`
and the `sources:`/`library:` form by `module_loader.dart`. Patching only the
first passed every hand-written probe while the test suite — which uses the
second — still failed on the return-type case.

**`as` needed a separate touch.** It does not resolve types at all; it switches
on the WRITTEN name, so an alias fell to its permissive `default:` and cast
anything to anything. The written name is now resolved through the alias first,
which is a no-op for every non-alias since those resolve to their own name.

**The handler still does not recurse**, which is the constraint SCC33 left: the
target is read off the annotation by `_resolveTypeAnnotationWithEnvironment`,
never by `accept`ing a child, so no type-level syntax reaches the backstop.

**Two limits measured and left, each with its reason.** A generic bound written
through an alias still throws — bounds are extracted in PASS 1, before any phase
of pass 2 can have registered an alias, and fixing it means reordering pass 1
(sce130). A local declared through an alias still accepts a mismatch, which is
NOT alias-specific: `int x = 'a'` is equally lenient, because local variable
declarations are not type-checked at all (sce131). A GENERIC alias
(`typedef L<T> = List<T>`) is skipped on purpose — binding it here would bind
`T` to nothing and answer confidently wrong.

## 0.91.0

### Fixed — `x.runtimeType == SomeType` was false for every type (scd99)

The todo reported that `Duration(seconds: 1).runtimeType.toString()` is
`'BridgedInstance<Object>'`. Measured, it is `Duration`: the member-access sites
already answer `bridgedInstance.nativeObject.runtimeType`, and SCD98 then
stopped the constructor producing a wrapper at all. The one-line fix the todo
recommends was already in place at every site an audit finds.

**What the todo was about survived that.** Its stated harm is "a script that
branches on `x.runtimeType` takes the wrong branch with no error", and that was
true — for a different reason, and not only for bridged values:

```dart
Duration(seconds: 1).runtimeType == Duration   // was false
1.runtimeType == int                           // was false
'a'.runtimeType == String                      // was false
DateTime(2020).runtimeType == DateTime         // was false
Duration == Duration(seconds: 1).runtimeType   // was TRUE
```

Asymmetric by operand order, and false in the order everybody writes. A correct
`runtimeType` whose result cannot be compared against a type literal is not
worth much.

**The reconciliation existed and never ran.** `visitBinaryExpression` carried
the Type-vs-`BridgedClass` comparison twice, in the `==` and `!=` arms of its
operator switch. Neither was reachable for this shape:
`Environment.toBridgedInstance` succeeds on a `Type` object, so the
bridged-operator dispatch twenty lines ABOVE the switch found an `==` adapter
and invoked it on the WRAPPER — comparing a wrapped `Type` against a
`BridgedClass` and answering false.

That is the wrapper substituting itself for the value it wraps, which is the
shape SCD98 removed from the constructor; it survived here because a dispatch
site reached it first. The reconciliation is now hoisted above that dispatch,
and the two copies in the arms are deleted rather than left unreachable — a
second implementation of one rule is what let this diverge unnoticed.

A generic type argument still distinguishes: `[1].runtimeType == List` stays
false, as real Dart has it, so the fix does not simply make every
Type-versus-name comparison true.

**The neighbours were audited, as the todo asked.** `toString`, `hashCode`,
`is`, `is!`, `as` and cross-route `==` all already delegate to the native on
both production routes. They are pinned anyway, alongside equality on enum,
String, null, bridged and script-defined receivers — the hoist runs before the
bridged dispatch, so those are the cases that say it intercepts nothing it
should not.

## 0.90.0

### Fixed — one representation for a bridged value: the bare native (scd98)

D4rt had two representations for the same bridged value and no rule about which
one you got. A bridged CONSTRUCTOR call yielded a `BridgedInstance<T>` wrapper;
every method return, getter return, operator return and static call yielded the
bare native. The same conceptual value arrived in two shapes depending only on
how the script happened to produce it, and the two routinely met in one
collection.

**The wrapping table, measured before choosing a direction** (the todo made
writing it down a precondition, because the two candidate directions have very
different blast radii and only the table says which one the codebase is already
closer to):

| site                                 | before      | after   |
| ------------------------------------ | ----------- | ------- |
| bridged constructor, default         | **wrapper** | native  |
| bridged constructor, named           | **wrapper** | native  |
| bridged constructor, generic factory | **wrapper** | native  |
| redirecting factory target           | **wrapper** | native  |
| bridged method / getter / operator   | native      | native  |
| bridged static method, const         | native      | native  |
| argument marshalled INTO a bridge    | native      | native  |
| `Environment.toBridgedInstance`      | wrapper     | wrapper |

The constructor was the lone outlier, so converging on the native was a
four-site change at the introduction point rather than a refactor of the value
representation. `toBridgedInstance` stays a wrapper on purpose — it IS the
bridge-dispatch boundary the wrapper is meant to be confined to.

**Why it was nearly invisible.** Every observation route a script has already
unwraps: the host boundary, the `runtimeType` getter, argument marshalling, and
`visitBinaryExpression`, which unwraps both operands before `==`. So
`runtimeType`, `is`, `==` and simple membership all agreed beforehand. It bites
where a NATIVE container compares its own stored elements, because then the
interpreter is not in the loop:

```dart
[Duration(seconds: 86400),                          // constructed -> wrapper
 DateTime(2020,1,2).difference(DateTime(2020,1,1))  // method      -> native
].toSet().length   // was 2, is 1
```

and it was ORDER-DEPENDENT, which is the fingerprint: `[ctor, method]` failed
while `[method, ctor]` passed. SCC32 gave `BridgedInstance` cross-boundary
`==`/`hashCode`, so `wrapper == raw` is true — but `raw == wrapper` cannot be,
because a native's `==` rejects a foreign type. A stored wrapper probed by a
bare native runs the direction that cannot work.

**A second defect, already live and unrelated to the wrapper.** Chasing the
first surfaced it: `_bridgeInterpreterValueToNative` rebuilt every `List` with
`.map(...).toList()`, which retypes unconditionally, so a `Uint8List` reaching
the host from a METHOD or GETTER arrived as `List<Object?>` and an
`as Uint8List` threw. The CONSTRUCTOR route survived only because its wrapper
took the `BridgedInstance` branch and never reached the list branch — the same
split, showing up as a type loss rather than a duplicate. The boundary now
rebuilds a list or map only when an element actually changed, and returns the
original instance otherwise.

**SCC32 is not removed, and its doc comment now says why.** Its cross-boundary
equality and hash-key normalisation are no longer load-bearing for values this
interpreter produces — nothing it produces is a wrapper any more. But
`toBridgedInstance` still hands one to bridge dispatch and an embedder can put
one into a collection itself, so they stop being a workaround for an internal
inconsistency and become what they read as: a courtesy to a wrapper that
arrives from outside. F-SCC32-10/11/12 keep passing unchanged.

## 0.89.0

### Fixed — the host receives the error the script raised, not a bridged shell (scd96)

A script doing `throw FormatException('boom')` handed its caller a
`BridgedInstance<Object>`. An `on FormatException` written around `execute()` or
`executeBundle()` did not match it, and a bare `catch (e)` saw a d4rt-internal
type the host has no reason to know about.

**The todo this came from was written against a stale premise, and re-measuring
found a different leak at the same boundary.** It expected
`InternalInterpreterD4rtException` to reach callers; that carrier has been
peeled since SCC27. The leak is one peel further in: a *bridged* exception holds
its native object inside the carrier, and `throwAsHostFacingError` peeled the
carrier and stopped.

`unwrapScriptError` has documented the pair since SCD73 — "Two peels, not one …
a host that peeled only the first would get a `BridgedInstance` it cannot
`catch` on". The zone-callback route already did both, which is why the
behaviour was SPLIT rather than uniformly wrong:

| entry point                       | before            | after             |
| --------------------------------- | ----------------- | ----------------- |
| `tom_d4rt.execute()`              | `BridgedInstance` | `FormatException` |
| `D4rtRunner.executeBundle`        | `BridgedInstance` | `FormatException` |
| `D4rtRunner.executeBundleAs<T>`   | `BridgedInstance` | `FormatException` |
| `executeBundleAsAsync<T>`         | `FormatException` | `FormatException` |

The async variant was right because it runs through the zone callbacks SCD73
wrapped. So the todo's instruction to check the typed variants was pointing at a
split that already existed between the synchronous and asynchronous halves of
one boundary — the shape SCC27 was written to remove.

The todo offered two fixes and said to prefer teaching the shared helper "if the
sweep is clean, because the asymmetry is the defect and [the narrow fix] only
relocates it". It is clean — both full suites pass unchanged — so the fix is one
line in `throwAsHostFacingError`, mirrored, and every present and future caller
of that boundary gets it.

**Not peeled, deliberately**: a script-declared exception class arrives as
`InterpretedInstance` (there is no native object, and the host cannot name a
type the script invented); a thrown non-error value arrives as itself, because
real Dart lets a script `throw 'plain'`; and `UndefinedNameD4rtException`
arrives as itself, because SCC31 exists to make it reach the host and peeling it
would undo that.

This matters most on the analyzer-free line: `executeBundle` is what a Flutter
app calls to run a downloaded bundle, and it is the one API whose caller cannot
fall back to a different runner.

## 0.88.0

### Fixed — guards that pre-empted a native operator now hand it to the SDK (scd93)

SCC30 removed six divergences from `~/` and `%` with one deletion, and only two
of the six were the ones it went looking for. That ratio asked for a sweep, and
this is it. The anti-pattern is not "d4rt throws the wrong exception" — it is
**d4rt hand-writing a check in front of an operand that is ALREADY NATIVE**, so
the SDK operator never gets to decide. Twenty-one sites, in five families, each
measured by running the same one-line program in real Dart and in d4rt.

**The six bitwise and shift arms** (`& | ^ << >> >>>`) threw
`RuntimeD4rtException('Unsupported binary operator "AMPERSAND"')` — a d4rt-only
type no `on` clause can name, whose message printed the TokenType rather than
the operator. The comparison arms twenty lines above them (`< <= > >=`) had
delegated to the SDK since they were written; these six were the ones nobody
converted. They now fall back to the SDK too, which answers better than any
table could: the expected type follows the RECEIVER (`1 & 2.0` names `int`,
`true & 1` names `bool`, `BigInt << 1.0` names the parameter `shiftAmount`), and
a receiver that declares no such operator raises `NoSuchMethodError` rather than
a type error at all.

**The six list-bounds guards** recomputed `index < 0 || index >= length` in
front of a native list. Right type, wrong in three ways the SDK gets right for
free: a read reports `RangeError (length)` where the guard said `(index)`; a
compound assignment reports the READ error because the read happens first, where
the compound arm's own copy of the guard reported the write's — the same
self-disagreement SCC30 found between `/` and `/=`; and an out-of-range write to
an unmodifiable list raises `UnsupportedError`, which the bounds test used to
pre-empt with a RangeError.

**The four list-index `is int` guards** and **the `String.[]` bridge's `is! int`
guard** threw `RuntimeD4rtException` where the SDK raises `TypeError`.

**Five guards stay**, because there is nothing to delegate to: `&&`/`||`
(short-circuiting is control flow, not a method), unary `-`/`~` and `++`/`--`
(the throw is the last resort after extension-operator lookup, and the increment
sites must assign back). Those now raise the SDK's TYPE carrying d4rt's own
message — the pattern `sdk_errors.dart` exists for. Their DOMAIN was measured
and already matched: `true || 1` is `true`, not an error.

`indexRangeError` keeps its place in `sdk_errors.dart` as API a bridge can use
for a container the SDK cannot be asked about, but no longer stands in front of
a native list.

**Not one existing test failed when all of this changed**, which is the finding
behind the new guard file: none of these types or messages was pinned anywhere,
so any of them could have drifted in either direction unobserved.
`scd93_native_operator_guards_test.dart` (18 cases) pins the divergences that
were fixed AND the cases where d4rt and the SDK already agreed — the latter are
what stop a guard being reinstated "for a better message" — plus the two limits
kept deliberately: a non-int String index carries the SDK's cast wording rather
than its parameter wording, and `x++` on a non-num raises TypeError where the
SDK splits TypeError/NoSuchMethodError by whether the operand's type declares
`+`. A four-case bundle-built twin covers the analyzer-free tree.

## 0.87.0

### Fixed — a binding check compares declared type arguments (scd92)

`f(List<String> xs)` accepted `f([1])`. SCC29 made a declared parameter type a
real check and SCD63 extended it to a typed for-each variable, but both compared
BASE types only, so every generic annotation was erased to its base before the
comparison ever happened.

Erased on both sides, for different reasons.
`InterpretedFunction._resolveTypeAnnotationDynamic` reads a `NamedType`'s name
and ignores its `typeArguments`, so `List<String>` resolved to the bare `List`
bridge. And `Environment.getRuntimeType` answers `List` for every list, because
a native list carries no element type d4rt can read back — `<int>[1]`, `[1]` and
`<dynamic>[1]` are the same object at runtime, and all three report
`List<Object?>` for their script-visible `runtimeType`. The machinery to decide
the question was already present: `AppliedRuntimeType.isSubtypeOf` has compared
arguments element-wise since DFUB6. Nothing ever handed it two applied types.

DFUB6 had solved the identical problem for the RETURN path, by deriving a
collection's element type from its CONTENTS rather than from a static type. That
derivation moved out of the visitor onto `Environment.appliedRuntimeTypeOf`, and
the binding check now feeds it — so a parameter, a for-each variable and a
return decide the same question the same way. The declared arguments are
resolved alongside the base type in `resolveBinding`, not inside
`_resolveTypeAnnotationDynamic`, whose result is also a type parameter's bound
and a callable's structural type.

The check runs only after the base check has already passed, so it can add a
rejection but never remove one, and it is permissive wherever either side has
nothing to read: an empty or heterogeneous collection, a top-type argument, an
UNBOUND type parameter (`f<T>(List<T> xs)` called as `f([1])`), a raw generic
instance, every bridged instance, and anything more than one level deep. A type
parameter the caller BOUND is checked — `f<String>([1])` is an error real Dart
reports too.

That permissiveness is the point rather than a caveat: unlike the return check,
this one runs on every argument of every call, and a false positive rejects a
correct program, which is worse than the silent pass it replaces. Two class
tests that had passed since February proved it. Dart widens an int literal to a
double from its surrounding context, so `Points.fromJson({'x': 3, 'y': 4})`
against a `Map<String, double>` parameter really does pass a map of doubles —
d4rt's map holds the ints it was written with, and the literal comparison
rejected it. The comparison now allows the same widening `bind` already allowed
one level out, on the type used for the comparison only: the collection is
passed through untouched.

F-SCC29-21 pinned the old limit and now asserts the throw.
`scd92_applied_parameter_type_test.dart` (22 cases) carries the boundary, with a
four-case bundle-built twin in `tom_d4rt_ast`.

## 0.86.0

### Fixed — `dynamic` is a top type for `BridgedClass.isSubtypeOf` (scd90)

`BridgedClass('int').isSubtypeOf(BridgedClass('dynamic'))` was `false` — the
predicate reported that an `int` cannot inhabit `dynamic`, which is wrong about
Dart for every value in the language. Measured across the implementations of
`RuntimeType`:

| subject                   | BC(Object) | BC(dynamic) | BC(void) | NRT(Object) | NRT(dynamic) | NRT(void) |
| ------------------------- | ---------- | ----------- | -------- | ----------- | ------------ | --------- |
| `BridgedClass('int')`     | true       | **false**   | **false**| **false**   | **false**    | **false** |
| `NamedRuntimeType('int')` | true       | true        | true     | true        | true         | true      |
| `TypeParameter('T')`      | true       | true        | true     | true        | true         | true      |

So this was never a missing case — it was one implementation disagreeing with
its peers, in five of six cells. The `NamedRuntimeType` column is the half the
filing todo did not mention and is the worse one: `BridgedClass.isSubtypeOf`
reached a name test only inside its `other is BridgedClass` block and fell
through to `return false` for every other kind of target — including the
sentinel `runtime_interfaces.dart` documents as how `dynamic` is spelled when a
richer type object is unavailable.

`isTopTypeName` is now the single answer all three ask, covering `dynamic`,
`Object`, `Object?` and `void`. It replaces two private spellings of the same
idea (`_isWildcardTypeName`, `TypeParameter._isTopType`) that did not agree with
the third implementation, which had neither.

The by-name workaround in `_checkArgumentType` — `declaredName == 'dynamic' ||
declaredName == 'void'` on the RESOLVED type — is removed, because the predicate
answers that question itself now. F-SCC29-19 still passes, and reverting only
the predicate fix makes it fail alone, which is what says it passes for the
right reason rather than through a name test.

**One rule had to stay by name.** Returning a value from a `void` function is
rejected at the declaration in Dart, not because the value fails to inhabit the
type — `void` IS a top type for assignability. The return check previously
entered its error path only because `int <: void` answered false, so making the
predicate correct silently deleted that diagnostic (`I-MISC-209`). The check now
names `void` explicitly, as it already named `dynamic`.

## 0.85.0

### Fixed — an extension member no longer answers for an error raised on a different receiver (scd87)

A genuine error inside a member that EXISTS was being swallowed and replaced by
an unrelated value, with nothing logged:

```dart
class Inner {}
class Outer { String get tag => Inner().tag; }
extension OuterX on Outer { String get tag => 'extension'; }
main() => Outer().tag;   // returned 'extension'
```

`Outer.tag` exists and runs. Its body fails because `Inner` has no `tag`. That
failure escaped the getter, reached the caller's member-lookup handler, was read
as "`tag` is absent on this receiver", and `OuterX.tag` answered.

SCC28's typed signal could not separate the two — both are genuine
`UndefinedMemberD4rtException`s carrying `memberName == 'tag'`. What separates
them is WHICH OBJECT the lookup failed on. `UndefinedMemberD4rtException` now
carries `receiver`, set at all eleven raise sites, and the seven
extension-lookup decision sites compare it with `identical`.

**Identity, not a description.** Two instances of the same class describe
identically, so a receiver string could not separate the failure raised for the
object in hand from one raised for a different object of the same class deeper
in the stack. A null receiver — a static or prefix lookup, where no receiver
object exists — never matches, so the branch is not taken and the failure
propagates, which is the conservative direction.

**One of the eight sites is deliberately left alone**, and the direction is the
reason. At the seven extension sites the branch means "treat the member as
absent and look for an extension", so admitting a same-named inner failure lets
an extension answer for a real error. At the compound-assignment site the branch
means "propagate the specific error instead of relabelling it as `Assigning to
undefined variable`" — narrowing it would send MORE failures to the relabelling
path. Same defect, opposite direction. The comment sits beside the code.

`F-SCC28-9` was written asserting the WRONG answer so that fixing this would
invert it. It is flipped here, and the flip is the proof.

## 0.84.0

### Changed — the last message test in the visitor is typed (scd86)

SCC28 removed every site that decided control flow by reading a member-lookup
diagnostic, with one deliberate exception in the compound-assignment path:

```dart
if ((e is UndefinedMemberD4rtException && e.memberName == variableName) ||
    e.message.contains("Undefined static member")) {
```

`UndefinedStaticMemberD4rtException` replaces that string test, carrying
`memberName`. Six raise sites convert with it — the four sentences the
interpreter composes (`on class`, `on enum`, `on bridged class`, `on
extension`) plus the two property-access sites — and every one had to keep
starting with those three words for the branch to be taken.

**Deliberately a second type, not a reuse.** The two failures answer different
questions: instance-member absence gates extension-method lookup, static-member
absence gates the compound-assignment fallback. Collapsing them would let one
branch answer for the other, which is the defect SCC28 removed, reintroduced
through the type system instead of through a message. F-SCD86-3 pins the
distinction.

**The decision site does not read `memberName`, and that is the conversion being
faithful rather than incomplete.** The string test it replaced carried no name
check, so comparing a name here would have narrowed the branch instead of typing
it.

F-SCC28-1's source scan was the other half. It matched only on "Undefined
property", so this line passed it, and a seventh static-member raise site worded
differently would have passed too — while silently never taking the branch. The
matcher now covers both phrasings. Both controls were run: with it widened,
restoring the string test fails the scan; with the matcher narrowed back to its
old form, the same restored string test passes green, which is the blindness
being fixed.

## 0.83.0

### Changed — `Uri.isScheme` is a method, and a shadowed `TimeoutException.toString` getter is gone (scd77)

`Uri.isScheme` is `bool isScheme(String)` in the SDK and was registered in the
`Uri` bridge's `getters` map, returning the native tear-off. **No script
behaviour changes**: `uri.isScheme('https')` worked before and works now,
because the interpreter tears a bridged method off just as it tore the native
closure off. What the wrong member kind cost was checkability — SCC24's sweep
invokes every registered getter and resolves the value, a tear-off is not a
value it can resolve, so the member had to be exempted, and an exemption is a
member the sweep cannot check. That map is now **empty**.

Sweeping for siblings first, as the todo required, found a second instance the
value sweep could not have surfaced: `TimeoutException.toString` was registered
as a getter AND as a method, the method shadowing the getter. Nothing ever
reached the getter, and its value — a `String` — would have resolved fine. It is
deleted.

**The exemption had already gone stale**, which is the argument for the new
check. Measured by restoring the getter with the map empty: SCC24's value sweep
now PASSES, because a `Function` bridge exists and a tear-off resolves like any
other value. The only thing that ever made this shape visible to it is gone. So
`F-SCD77-4` reads the DECLARATION instead — `dart:mirrors` over each bridge's
native type, flagging any getter the SDK declares purely as a method — and that
is what found the second instance.

One observable difference, and it is a string: `uri.isScheme.runtimeType` read
`(String) => bool` and now reads `BridgedMethodCallable`, which is what every
other bridged method already reads. An earlier draft of this entry also claimed
`uri.isScheme is Function` flipped from `true` to `false`; measured on both
shapes, it is **false either way** — a script cannot see a native function value
as a `Function` regardless of which map it came from, while script functions and
closures can. That is pre-existing and untouched here.

## 0.82.0

### Fixed — a no-hook embedder no longer sees the interpreter's exception wrapper (scd73)

An error escaping an interpreted callback reached an embedder's own
`runZonedGuarded` as `InternalInterpreterD4rtException`, with the thrown value
buried two levels in (`originalThrownValue`, then a `BridgedInstance`'s
`nativeObject`). Unwrapping only happened in the zone d4rt forked, and the fork
only happened when `onUncaughtError` was set — so the shape a host saw depended on
whether it used the hook or its own zone.

The reason this was recorded as unfixable turns out to be half right. Unwrapping
does require *observing* the error, and the only error-interception point Dart
offers is `ZoneSpecification.handleUncaughtError`, which makes the zone a new
**error zone** — and Dart refuses to carry an error across an error-zone
boundary, so owning it unconditionally stops an ordinary script failure from ever
reaching the caller of `executeBundle` (a hang, not a failure). What the analysis
missed is that a callback can be observed **at registration** instead of by
handling what it throws, and a zone specifying only the `register*Callback`
hooks is *not* an error zone. Measured: `identical(zone.errorZone,
parent.errorZone)` stays true, and an ordinary future error still crosses to an
awaiter outside.

So the two halves are now separate. The zone is forked **always** and sheds the
wrapper; the error-zone half stays opt-in behind `onUncaughtError`. A `Timer` body
needed a second seam, found by a failing test rather than a probe: d4rt's own
adapter is `() async { callback.call(...); await _yieldEventLoop(); }`, so the
throw completes the adapter's unheld future instead of escaping the registered
callback, and `Zone.errorCallback` is not consulted for an `async` body's
completion. The three `Timer` adapters therefore unwrap themselves — a bounded
set, counted: of the five stdlib adapters that invoke a `Callable` inside a
native `async` closure, the other two hand their future to someone who can hold
it.

One escape route keeps the wrapper: `Stream.handleError`'s handler, which the SDK
invokes with no zone registration at all. `unwrapScriptError` is therefore now
**public** (top-level, exported) and documented as the remedy — two peels, not
one, which is why it is not left to the caller to write. It returns anything
that is neither wrapper nor `BridgedInstance` unchanged, so applying it twice or
to a native error is a no-op.

That the full unwrap is safe at the callback seam was measured, not assumed: a
`Future.then` callback that throws is the one registered-callback escape an
interpreted `catch` can still receive, and twelve in-script cases — `catch`,
`on`-clause matching against native and script-declared types, `e.message`,
`rethrow`, and in-callback `try`/`catch` inside timers and stream handlers — were
recorded before the change and are byte-identical after it.

`F-SCC23-10` asserted the old behaviour on purpose and is inverted here, keeping
its other half: d4rt still does not take over the embedder's error zone.

## 0.81.0

### Fixed — `InterpretedInstance.toString()` reaches the script's override (scd72)

`'$e'` on a script-defined exception printed `<instance of MyErr>` rather than
the `MyErr: boom` the script wrote. Inside a script, interpolation already
honoured the override — `InterpreterVisitor.stringify` has dispatched for a long
time — so the gap showed only where an instance reaches native code, which is
why it survived. Measured, that was three places and not one: a host
interpolating a value returned by `execute`, a `D4rt.onUncaughtError` hook, and
any native container holding the instance (`'${[e]}'` gave
`[<instance of MyErr>]`, because `List.toString()` is native).

Dispatching needs an `InterpreterVisitor` and `toString()` has nowhere to receive
one. `D4.activeVisitor` — the ambient one the interpreter already maintains — is
not enough: measured, it is NULL inside an `onUncaughtError` hook, because the
interpreter has unwound before the embedder runs. So the visitor is stored on the
CLASS (`InterpretedClass.declaringVisitor`), one reference per class rather than
per instance, assigned once from `visitClassDeclaration` / `visitMixinDeclaration`.

The contract splits by caller, and the split is deliberate. `stringify`
(interpolation inside a script) keeps Dart's semantics: a throwing `toString`
propagates and `toString() => '$this'` overflows the stack, both before this
change and after. `toString()` — what host code reaches — does not throw for
anything recoverable, because a host's first act on receiving an error is to log
it and a second exception raised while reporting the first is worse than an
imperfect string. A re-entry guard terminates a cycle that returns through a
native container.

`StackOverflowError` and `OutOfMemoryError` are rethrown rather than swallowed,
and that is measured rather than principled: the first draft caught everything,
and a pair of mutually-interpolating objects then stopped raising
`StackOverflowError` and started HANGING — the overflow unwound into the catch,
the fallback was returned, the caller resumed on a still-full stack and
overflowed again, forever.

## 0.80.0

### Fixed — adapter arguments are coerced, not cast (scd70)

`s.add([65, 66])` threw `type 'List<Object?>' is not a subtype of type
'List<int>' in type cast`, and `s.add(<int>[65, 66])` threw the same thing: a
list literal written in a script is a `List<Object?>` whatever its elements hold
and whatever the author annotated, because the interpreter checks the element
type without reifying it. There was no spelling of `Socket.add` a script could
reach. Maps arrive the same way, as `Map<Object?, Object?>`.

Seventeen adapters had that cast, against a report that named two — five in
`io/socket.dart`, four in `io/file.dart`, four in `io/http.dart`, one each in
`io/stdio.dart`, `io/io_sink.dart`, `isolate/isolate.dart`, and one in
`core/function.dart`: `Function.apply` with named arguments, which is not io at
all. Each was independently unusable from a script. They now use
`D4.coerceList` / `D4.coerceMap`, which unwrap bridged elements and report a bad
element by parameter name.

`RandomAccessFile.readInto` and `readIntoSync` are the exception and use
`List.cast<int>()` instead. They are OUT parameters — the native writes into the
caller's list — and an eager coercion hands it a copy: measured, that returns
the byte count while leaving the script's buffer untouched, which is quieter
than the cast error it replaced and worse. `cast` returns a writable view.

`test/scd70_no_container_arg_casts_test.dart` derives the rule rather than
listing the sites: an adapter may not cast an argument to a parameterised
container whose type arguments are not top types. Run against the trees as they
stood it reports all thirty-four rows.

## 0.79.0

### Fixed — `FormatException`'s source and offset are positional (scd68)

`FormatException('bad', 'src', 2)` produced an exception whose `source` and
`offset` were both null. The adapter read them out of `namedArgs` while the SDK
declares `FormatException([String message = "", this.source, this.offset])` —
three POSITIONAL parameters, none of them named. So there was no spelling that
worked: the named form the adapter wanted is not legal Dart, and the legal
positional form reached arguments the adapter never read.

Silent in both directions, which is why it lasted. Extra positional arguments
are discarded rather than reported as an arity error, so the exception looked
right until something read `.offset` — and `toString()`, which the SDK builds
from all three, could only ever print the message. It now reports the position
and the caret line the SDK puts under it.

A guard now checks the general claim rather than this instance:
`test/scd68_constructor_named_args_test.dart` reads every `namedArgs['x']` in a
bridged CONSTRUCTOR adapter and asks `dart:mirrors` whether the SDK constructor
declares a named parameter `x`. Measured: 70 such claims across 17 stdlib files,
zero mismatches after this fix, and exactly the two false ones reported when run
against the adapter as it was. Every other exception adapter in both `dart:core`
and `dart:io` was checked the same way and is correct.

## 0.78.0

### Changed — every supertype edge is one SDK hop (scd67)

The `_supertypeRegistry` blocks used to restate whole closures:
`'IndexError': ['RangeError', 'ArgumentError', 'Error']` where the SDK says
`class IndexError extends RangeError` and the other two were already reachable.
That was not a style choice — until SCC19 the registry walk went only one hop
past the direct supertypes, so a two-hop answer had to be written out. SCC19
removed the constraint; the comments explaining it outlived it by months, in
files whose next reader would have copied the shape.

Swept the three blocks that still carried it: `dart:async`'s `StreamController`,
`dart:typed_data`'s eleven list views, and the `dart:core` error chain. Measured,
that removed exactly 18 redundant edges — 155 direct edges became 137 — and the
transitive closure of all 94 registered names is byte-identical before and
after. `test/scd67_hierarchy_edges_test.dart` now derives the invariant instead
of recording it: a parent already reachable through another parent of the same
key does not belong in that key's list. Run against the pre-sweep tree it
reports all 18 by name.

### Fixed — `List -> Iterable` is a `dart:core` edge and is now declared there

`List` and `Set` are `dart:core` types, but their edge to `Iterable` was
declared by `dart:collection`'s registrar — so a script that never imported
`dart:collection` had no path from `List` to `Iterable` at all. That is why
every typed-data view restated the whole closure: it was the only way those
views could reach `Iterable` on their own imports. The edge now lives in
`CoreHierarchyCore`, which always registers, and the eleven views declare the
two edges the SDK gives them.

Purely additive: with `dart:collection` loaded nothing changes, and without it
`List` and `Set` gain a closure they should always have had.

## 0.77.0

### Fixed — the three pattern kinds `_matchAndBind` had no branch for (scd64)

`case (int _)` threw `Unimplemented Error: Pattern type not yet supported in
_matchAndBind: ParenthesizedPatternImpl`, and so did `var (int a) = ...`.
Auditing the rest of the dispatch — every `DartPattern` subtype the analyzer
defines, through five contexts, in one pass — found two more kinds in the same
state rather than one:

| pattern kind         | spelled | before        |
| -------------------- | ------- | ------------- |
| ParenthesizedPattern | `(p)`   | Unimplemented |
| NullCheckPattern     | `p?`    | Unimplemented |
| NullAssertPattern    | `p!`    | Unimplemented |

The other twelve were implemented and answered correctly in all five contexts.

All three are now live in every pattern position: switch statement, switch
expression, `if (v case ...)`, destructuring declaration, pattern assignment
and pattern for-each. `(p)` is pure grouping and recurses. The two null
patterns are the same syntax with OPPOSITE answers for null, measured against
the SDK rather than assumed: `case int n?` with a null scrutinee falls quietly
to the next arm, while `case int n!` raises a `TypeError` with the null-check
operator's own wording and cannot select an arm at all. The exception type is
load-bearing — arm selection catches pattern-match failures and nothing else —
so a null-assert signalled as a non-match would silently take `default`.

The two irrefutable sites (declaration, assignment) also stopped wrapping a
`TypeError` raised during binding in a generic runtime error. `var (a!) =
maybeNull;` is legal Dart whose entire purpose is to raise one, and a script's
`on TypeError` has to see it.

A failing CAST pattern is a separate, unfixed divergence, now pinned: `case var
n as int` over a String signals a non-match and takes `default`, where real
Dart throws.

## 0.76.0

### Fixed — a typed for-each loop variable is checked against what it binds (scd63)

`for (final int x in [1, 'two', 3])` bound the String and kept going. The body
then ran with a value its own declaration rules out — and, measured, did not
fail there either: `x + 1` reached `String.+` and produced `'two1'`. A silently
wrong value, not an error a few frames away. Real Dart raises a `TypeError` on
the offending element, after the earlier iterations have run, which is what
this now does, with the SDK's own wording so a script's `on TypeError` sees
what Dart would have shown it.

SEVEN PATHS, ONE CONSTRUCT. The same loop was checked or unchecked depending on
things a reader of the loop cannot see. The visitor has three for-each
implementations (statement, collection-literal element, await-for item list),
the async state machine two more, and the sync generator a seventh — so whether
a given loop was covered came down to whether its enclosing function was
`async`. All seven now share one rule.

IT IS A BINDING CHECK, NOT `is`. The obvious implementation — the `is`
predicate SCC18 extracted — is wrong twice over. `for (final double d in
[1, 2.5])` is a program real Dart ACCEPTS, because the literal widens, and
`1 is double` is false; and `is` must answer "no" to a type it cannot resolve,
where a binding check has to wave that same type through or a script using an
unbridged library stops running. The check reused is the one SCC29 wrote for
parameter binding, which had already settled both. Its value-independent half
is now split out so a loop resolves its annotation once: measured, that
resolution was ~86% of the check's cost, and hoisting it took the overhead on a
200 000-element typed loop from +16% to +2%.

Two cases are deliberately left as they were: `for (x in xs)` over a variable
declared elsewhere (the annotation is not on this node), and a type name the
interpreter cannot resolve. Both are pinned as they stand.

## 0.75.0

### Fixed — `is` honours the nullable `?` suffix, and so do typed patterns (scd62)

`_valueHasType` switched on the type NAME and dropped the suffix, so `String?`
reached the `String` case and asked the host's own `is` — false for null.
Measured: `null is String?`, `null is int?` and `null is Object?` were all
false. The last is the sharpest form of it, since every value satisfies
`Object?` and there was no input for which that answer was right.

It was not only the operator. SCC18 extracted this predicate out of
`visitIsExpression` and routed typed PATTERNS through it, so the same defect
decided pattern arms: `case String? _` did not match null and the null fell to
a later arm or to `default`. All three pattern contexts — a `switch`
expression arm, `if (v case ...)`, and a `case T? name:` label with its
binding — are fixed and pinned.

Scoped to null deliberately. A non-null value still tests against the bare
type, which was always correct (`'hi' is String?` was true before this), and
`Null`, `dynamic` and `void` keep their own branches rather than being
collapsed into the nullable question.

## 0.74.0

### Fixed — a `throw` inside an async `finally` never completed (scd43_aide)

    Future<dynamic> main() async {
      try { } finally { throw StateError('fin'); }
    }

hung. `_handleAsyncError` asked `_findEnclosingTryStatement` which try protects
the throwing node, and for a node inside a finally block that is the try whose
finally is currently running. It has a finally, so the machine scheduled that
finally again — which threw again, for ever. **A finally block is not protected
by its own try**, so the search now continues at the try's parent.

Every async shape hung: with an outer catch and without, with an `await` before
the throw and without, and whether or not the finally's exception was replacing
one already in flight. The synchronous path was correct throughout and is the
reference the nine new cases are written against.

**The replacement rule is the half that a naive fix gets wrong.** Dart specifies
that an exception raised in a finally REPLACES one propagating from the try
body, and the replaced one is lost. Stopping the loop while leaving scd40's
`errorAfterFinally` hold in place would have surfaced the ORIGINAL exception at
the state machine's terminal exits — a program that no longer hangs and still
answers wrongly. The hold is dropped in the same step, and so is a pending
return: `try { return 7; } finally { throw … }` now throws, as real Dart does.

The rule is read from the AST, not recorded on the state, which is the decision
scd41 made for the rethrow case and for the same reason — whether a node sits
inside a given finally block is a fact no amount of prior execution can change.
Like `_tryOwningCatchClauseOf`, it stops at the FIRST enclosing finally, so a
`try` written inside a finally block still handles its own errors (F-SCD43-9).

These cases HANG when they regress rather than failing: the machine reschedules
through `Future.microtask`, so a loop starves the event loop and the file's own
timeout never fires. Seeing the red state needs a wall clock
(`perl -e 'alarm 90; exec @ARGV' dart test …`), which is stated in the group's
doc comment.

## 0.73.0

### Fixed — a bare block lost its locals across an `await` (scd42_aide)

    main() async {
      { var log = []; log.add(await Future.value(1)); return log; }
    }

reported `Undefined variable: log` for a local plainly in scope. The same code
at the top level of a function body, or inside an `if`, `for` or `while` body,
worked — which is what made it look like an unrelated scoping bug each of the
three separate times SCC12 hit it.

The distinguishing condition is a **bare block**, and it is not the one the
report named. The async state machine flattens the statement tree: it steps into
if/for/while bodies and runs their statements in the function's own frame, so a
declaration there survives a resumption. A standalone `{ … }` had no such
handler, so it was handed to `visitBlock`, which opens a CHILD environment and
runs the statements synchronously. An `await` inside then suspended, the machine
resumed at a statement *inside* the block, and that child environment was gone.

A bare block is now stepped into like every sibling construct, for the reason
the `LabeledStatement` case next to it already gives: accepting the node whole
hands it to the synchronous visitor, which cannot suspend. This carries the
limitation those cases already have — the machine flattens, so block-scoped
shadowing is not honoured in async code — and that is a much smaller problem
than a hard error on ordinary code.

**It was not only failing loudly.** The hoisted form that looks like a
workaround,

    { var log = []; final v = await Future.value(1); log.add(v); return log; }

returned `1` rather than `[1]` — the awaited value instead of the list. A test
that checked only for the absence of an exception would have called the bare
block healthy, so `F-SCD42-5` asserts the value.

The report's framing — "an `await` in ARGUMENT position loses the environment" —
points at the wrong expression. What is lost is the method **target**:
`F-SCD42-3` has no local in the argument list at all and failed identically,
while `F-SCD42-4` passes an awaited argument to a top-level function and always
worked, because the callee is resolved globally.

## 0.72.0

### Fixed — async try/catch now decides like the synchronous path (scd41_aide)

Two defects with one cause: the async state machine approximated two decisions
that `visitTryStatement` already made properly, so the same script behaved
differently depending only on whether the enclosing function was `async`.

**Typed catch clauses were chosen by position.** `_handleAsyncError` took
`enclosingTry.catchClauses.first`, with a comment admitting it was
"simplified". In an async function

    try { throw ArgumentError('a'); }
    on StateError catch (e) { ... }        // ran
    on ArgumentError catch (e) { ... }     // did not

and, worse, a lone `on StateError catch` **caught** an `ArgumentError` that had
to propagate — so the error surfaced nowhere at all. The synchronous path had
converged on one predicate in SCC20 (`on T` asks exactly what `x is T` asks);
the matching rules are now extracted into `catchClauseMatches` /
`selectCatchClause` and both paths call them. The SCC31 undefined-name rule
moves there too, so it exists once instead of at every dispatch site.

**A `rethrow` could not tell which try it was already inside.** The async path
read that from `AsyncExecutionState.activeTryStatement`, a single mutable field,
and tested whether it equalled the try found for the rethrow node. Any try that
completed in between cleared the field, the test then failed, the error was
re-offered to the *same* try, and its catch rethrew again — so the function
**hung**. A nested `try` inside a catch block is enough:

    try { throw StateError('x'); }
    catch (e) {
      try { await Future.value(0); } finally { }   // clears the field
      rethrow;                                      // never escapes
    }

The answer is now read from the AST: the try to skip is the one whose catch
clause lexically contains the rethrow.

**The choice between patching and deriving, recorded.** SCD41 proposed turning
`activeTryStatement` into a stack, and asked whether the async path should be
derived from `visitTryStatement` wholesale rather than reimplementing it. What
landed is the middle answer, and deliberately so:

- The **decision procedures** are now shared. "Which clause matches this error"
  and "which try does this rethrow target" are not suspension concerns, and both
  were already answered correctly next door. Sharing them makes this class of
  divergence impossible rather than fixing its instances.
- The **executors** stay separate. The state machine exists because any
  statement may suspend, and `visitTryStatement` runs its blocks synchronously;
  deriving execution from it means rewriting the suspension model, which is a
  rewrite rather than a refactor.
- `activeTryStatement` is **not** made a stack. Its only fragile read was the
  rethrow test, and that answer is structural. A stack would add push/pop
  obligations to every suspension and resumption path in a machine that has now
  produced six defects — maintaining the dependence instead of removing it.

Eleven cases join the family file. Four were red (`on`-clause selection) and one
**hung**; six were controls, several correct for a different reason than the
fixed cases — a try nested inside a catch must still handle its own errors, and
that is precisely what an over-eager rethrow skip would break.

`F-SCC31-17` is rewritten rather than deleted. It used to assert the
undefined-name rule appeared in all four dispatch files, because there were two
implementations of matching; now it asserts the stronger pair — the rule lives
in the one decision, and `callable.dart` routes to it and does not re-implement
the choice. Verified non-vacuous by reinstating `catchClauses.first`.

## 0.71.0

### Fixed — an async function silently returned its finally block's value instead of throwing (scd40_aide)

The shape is what a careful programmer writes: acquire a resource, use it,
release it in a `finally`. In an `async` function, if anything in the `try` body
raised and there was no `catch`, the error was **discarded** and the function
completed normally with the finally block's last evaluated value.

    Future<dynamic> main() async {
      final o = Thing();
      try { return o.nonsenseXyz; } finally { await o.tidy(); }
    }

returned `42` — `tidy()`'s result — where it must throw `Undefined property
'nonsenseXyz'`. With a `ServerSocket` teardown it returned the socket. This is
the dangerous member of the family SCC12 opened: it does not hang and does not
throw, **it answers, and the answer is wrong**.

SCC12 already parked such an error on `AsyncExecutionState.errorAfterFinally`,
because the main loop clears `currentError` after every statement that completes
normally and the error would not survive even the first statement of the
finally. `_findNextSequentialNode` re-raises it when the block ends — by handing
it to the NEXT node. When the `try` is the last thing in the function there is
no next node: the loop simply ends, and its terminal exits consulted
`returnAfterFinally` and `currentError` and never the hold. The error was
dropped and the function completed with `lastResult`.

The terminal exits now honour the hold, ahead of a pending return: the two are
set by different abrupt completions of the same `try`, and when the try body
threw, Dart propagates that error.

**The preconditions were broader than the report.** `await` in the finally is
not one of them — a wholly synchronous finally in an async function failed
identically, so the fix belongs at the state machine's exits rather than on the
await path. Nor is `return`-in-try: a bare `throw` was discarded the same way.
What matters is an async function, an uncaught error in a `try`, a non-empty
`finally`, and nothing after the `try`. That last condition is why the defect
survived: every existing case in the family had a statement after the try, and
`F-SCC12-12` uses the assign-then-return shape the audit tool had been forced
into precisely by this bug.

A **successful** return is not affected and never was — `try { return 7; }
finally { await … }` returns 7. Establishing that first is what says this is an
error-handling defect rather than "a finally overwrites the pending return",
which would have been broader and worse. `F-SCD40-8` keeps it that way.

Eleven cases in `test/scc12_await_in_finally_test.dart` pin the family: four
were red and seven were already green *for a different reason* — the error takes
another path — which is exactly the set a widened hold would have captured too.

## 0.70.0

### Fixed — an unknown named argument to `Set.castFrom` blamed `newSet` (scd37_aidc)

`Set.castFrom<S, T>(Set<S> source, {Set<R> Function<R>()? newSet})` is the only
member in the whole bridged surface whose parameter is a *generic* function —
one the callee instantiates at a type the caller never writes. Interpreted code
cannot express that, so 1.34.0 made the bridge reject `newSet` rather than
accept and ignore it, and that remains the right answer: a dropped `newSet`
returns a view over a `LinkedHashSet` where the caller asked for a
`SplayTreeSet`, and the script then misbehaves far from the call.

The rejection was implemented as `namedArgs.isNotEmpty`, so ANY named argument
produced the `newSet` explanation. `Set.castFrom(s, newFoo: 1)` was answered
with a paragraph about generic functions — a limitation that has nothing to do
with what the author wrote, and the kind of misdirection that costs a debugging
round. The two cases are now separate: `newSet` gets the reason, anything else
is told it is not a parameter of `castFrom`. The `newSet` message also now says
what to do instead (`SplayTreeSet<T>.of(source.cast<T>())`).

**`Map.castFrom` does not have this shape**, contrary to what the tracking todo
assumed. SDK 3.12.2 declares `Map.castFrom<K, V, K2, V2>(Map<K, V> source)`
with no named parameter at all, so the bridge refusing one is correct rather
than the same defect — a bridge must not accept what the SDK rejects. Pinned by
F-SCD37-5 so the claim stays measured.

`newSet` is the *only* instance: swept against the SDK sources of `core`,
`collection`, `convert`, `async`, `typed_data` and `io`. The sweep has to read
the sources because `dart:mirrors` erases the `<R>` and reports the parameter
as a plain `() -> Set`, which is indistinguishable from an ordinary callback —
so no mirror-based audit can find this shape.

F-SCD37-1 is written as a throw rather than a value comparison on purpose: the
bridge could accept `newSet` and ignore it, and every other assertion here
would still pass.

## 0.69.0

### Fixed — a bridged method tear-off is a function everywhere now (scd35_aidc)

`stream.listen(seen.add)` did not run. `seen.add` tears off a method from a
bridged `List` and yields a `BridgedMethodCallable`; sixty-two stdlib bridge
files cast their callback argument to `InterpretedFunction`, which that is not
a subtype of, so the cast threw. Adapters that guarded with
`is! InterpretedFunction` instead reported `requires a Function` — the same
defect wearing a more confusing message, since the argument *is* a function.
The workaround was to wrap the tear-off in a lambda, which is exactly the kind
of rewrite a script author has no way to predict is necessary.

`Callable` is the supertype `InterpretedFunction` and every bridged callable
already implement, so no new type was needed. Two files had converged on it
independently — `core/list.dart` in the Bug-95 fix and
`collection/unmodifiable_list_view.dart`, whose helper already documented
"accepts any `Callable`, not just `InterpretedFunction`". This finishes that
job across the stdlib rather than adding a third case at each site: every
`as` / `is` narrowing in `lib/src/stdlib` is now `Callable`, in both twins.

Two things were deliberately left narrow. The `InterpretedFunction` checks
outside the stdlib — in `interpreter_visitor.dart`, `callable.dart`,
`environment.dart` — are genuine dispatch on interpreted-only state such as
`isGetter`, not argument coercion, and are untouched. And `errorHandlerArgs`
keeps one `is InterpretedFunction`, because deciding whether an error handler
takes a stack trace means reading `maxPositionalArity`, which only an
interpreted function can answer: `BridgedMethodCallable.arity` is a hardcoded
0 precisely because the adapter validates arity itself. A bridged tear-off
used as `onError` is therefore called with the error alone — the shape every
SDK error handler accepts, where passing a second argument to a one-parameter
tear-off would fail inside the adapter.

Every assertion in `scd35_bridged_tearoff_as_callback_test.dart` is the bare
tear-off. The wrapped form appears once, labelled a control: it passed before
this fix too, so a test written that way measures nothing. Six of the twelve
cases were confirmed red beforehand; the six that were already green document
paths that were never broken — the interpreter's own argument binding accepts
any `Callable` and always did.

F-SCD35-9 is a ratchet rather than a case about today's members. The surface
of this bug grew with the bridge corpus: every newly bridged member is another
tear-off, and every newly written adapter another chance to narrow the type
back. The scan covers the adapters nobody has written yet.

### Fixed — the last three bridged-constructor wrap sites drop the trace (scd34_aidc)

SCC11 gave `RuntimeD4rtException` an `originalStackTrace` so an interpreted
`catch (e, st)` reports where the *native* throw happened rather than where the
interpreter caught it. Three wrap sites were left binding only `catch (e)` and
so had nothing to forward — all three on the bridged-constructor paths: the
explicit `super.named()` call, the implicit super call, and
`visitInstanceCreationExpression`. All three now bind `catch (e, s)` and pass
`originalStackTrace: s`.

The site in `visitInstanceCreationExpression` had a second defect that says how
it got this way: its `Logger.error` line read `\$e\n\$s` — escaped, so it
logged the literal text `$e\n$s` instead of the exception and its trace. That
is what narrowing the binder to `catch (e)` leaves behind when the message is
made to compile rather than fixed. Its sibling twenty lines away still had the
unescaped form, which is what the line should have said all along.

Widening the three was necessary but not sufficient, and only a negative
control could show that. Two of the three sit under a re-wrap in
`InterpretedClass.call` that catches `on RuntimeD4rtException` and builds a
fresh one out of `e.message` alone — discarding the trace that had just been
preserved one frame below. Four re-wraps on the constructor path now carry
`originalStackTrace: e.originalStackTrace` across. They deliberately do **not**
carry `originalException`: that would change which type a script's `on` clause
matches, which is a behavioural question and not this change.

The arity-error throw in the same clause (SCB28) now forwards the trace too. It
replaces the native error as the *value* on purpose, but the adapter frame that
indexed past the end of the argument list is still the only one that says where.

Verified by negative control rather than by a green run: each adapter in
`scd34_constructor_trace_forwarding_test.dart` throws via
`Error.throwWithStackTrace` carrying a `StackTrace.fromString` sentinel, so a
trace manufactured at the wrap site cannot satisfy the assertion by accident.
Removing the forwarding at each of the three sites individually was confirmed
to turn exactly that site's case red.

## 0.68.0

### Changed — the invented-error-contract sweep, and its one survivor (scd31_aidb)

A hand-written adapter that invents an error contract the SDK does not have is a
defect no reachability check can see: the member is registered, it resolves, and
the member diff counts the class complete.

Swept. Of 1138 `throw RuntimeD4rtException` sites under `lib/src/stdlib`, the
argument, target-type and callback-return guards — the overwhelming majority and
all correct — leave 37, of which exactly one is conditioned on the RECEIVER's
state rather than its arguments, which is the shape both known instances had.

That one is `LinkedListEntry.unlink()` on an unlinked entry, and it STAYS: Dart
has no contract there to contradict, throwing an internal
`_TypeError: Null check operator used on a null value` rather than a documented
failure. Where the SDK has no contract, a legible error is the better answer.
The reasoning now sits at the definition so a later sweep matching on shape
alone does not remove it.

`test/stdlib/nullable_returns_do_not_throw_test.dart` holds the property going
forward: sixteen nullable-returning collection members, each driven in the state
that should yield null. It would have caught the `SplayTreeMap.firstKey()` case
that prompted the sweep.

### Fixed — an empty queue raises a catchable `StateError` (scd30_aidb)

`removeFirst` and `removeLast` guarded the empty case by hand and threw
`RuntimeD4rtException` with a message the bridge invented. Dart throws
`StateError` with `Bad state: No element`, so a script written the idiomatic

    try { q.removeFirst(); } on StateError { … }

did not catch, and the failure surfaced as an uncaught interpreter error instead
of the recovery path its author wrote.

The guards are removed rather than corrected: the native call raises the SDK's
error unaided. Six sites — `Queue`, `ListQueue` and `DoubleLinkedQueue`, in both
trees.

`first` and `last` were listed in the report and turned out to be fine already;
they resolve through the supertype edge and were never guarded.

This is a better hiding place than the sibling defect it came from. The
`SplayTreeMap` guard threw where Dart RETURNS, so it changed the value contract
and one probe found it. This one throws where Dart THROWS, so the two behave
identically until a script tries to CATCH — which is why the new cases assert
the catch from inside an interpreted script rather than asserting a throw from
the host.

Three existing cases asserted the old contract and had their PREMISE corrected,
which is noted here because it is a different act from loosening them: I-COLL-69
pinned the invented message verbatim, I-COLL-50 pinned the interpreter's
exception type, and F-SC7-AST-6 expected `removeFirst` to disagree with `first`
in the same bridge.

## 0.67.0

### Fixed — the float typed lists accept int literals, as Dart does (scd29_aidb)

`Float32List.fromList([1, 2])` worked while `setAll(0, [7, 8])` did not, so the
same script could build a float list from int literals and then fail to write
int literals into it.

**Measured against the analyzer, `fromList` was the correct one.** In a context
expecting `double`, an integer LITERAL is a double: `fromList([1, 2])`,
`setAll(0, [7, 8])`, `setRange(0, 2, [7, 8])`, `followedBy([9])` and
`Float32List(1) + [9]` all compile. The other four were rejecting valid Dart,
which is an over-narrow guard rather than a widening.

The conversion is narrow: `int` to `double` only, only where that is the element
type. `double` to `int` is lossy and stays refused, and no other element type is
converted.

One limit is recorded rather than hidden. Dart accepts the literal and refuses a
genuine `List<int>` variable; d4rt erases element types, so the two arrive
indistinguishable and one side has to be chosen. Accepting admits the common,
valid form.

### Changed — the eleven typed lists share one adapter map (scd28_aidb)

`Uint8List` hand-rolled the whole inherited-`List` surface that the other ten
reached through `inheritedListMethods<E>()`. That one structural fact had
already produced two defects in opposite directions (SCB3, SCC9), and both were
hard to see for the same reason: `Uint8List` is the variant most likely to be
probed and the one least representative of the others.

Its 45 duplicate adapters are gone; it uses the shared helper like its siblings.
Measured through the interpreter before and after, **`Uint8List`'s resolvable
surface is identical on all 24 probes** — this removes a duplicate
implementation, not surface.

### Fixed — `first`, `last` and `length` are assignable on every typed list

The same measurement found the asymmetry running the other way. `Uint8List`
declared the three `List` setters and the other ten declared none, so
`l.first = 1` worked on `Uint8List` and raised "undefined setter" on its
siblings — with `Uint8List` being the CORRECT one. All three are valid Dart on
every typed list: `first`/`last` are length-preserving, and `length` exists and
throws `UnsupportedError`, which a script can catch. A missing-member error sends
`try { … } on UnsupportedError { … }` down the wrong path.

Now provided by a shared `inheritedListSetters<E>()`, so the eleven cannot
disagree again. A wrong element type still fails — assigning an `int` into a
`Float64List` is a type error in Dart and stays one — but reports which member
and which element type instead of a raw `_TypeError`.

## 0.66.0

### Fixed — `buffer` was callable as a method on every typed list (scd27_aidb)

`buffer` was registered in the `methods:` map as well as the `getters:` map on
all eleven typed lists, so `list.buffer()` resolved. In the SDK it is a getter
inherited from `TypedData`, and that call does not compile as Dart.

**This removes script-visible surface.** A script written `list.buffer()` stops
working here — and it never worked as Dart, which is the point: the widening
shape makes a script green in the interpreter and invalid outside it, and it is
the one bridge defect no passing test catches, because every assertion anyone
would write uses `list.buffer`, the form that was always correct.

The duplicate is also why it lasted: `list.buffer` read correctly throughout, so
there was nothing broken to trip over — the extra surface simply sat beside the
correct surface.

Both directions are pinned — `F-SCD27-1-*` that the property reads on every
variant, `F-SCD27-2-*` that the call does not resolve — because a deletion
cannot be protected by an assertion that passes.

### Fixed — collection arguments in `core` and `convert` are coerced, not cast (scd26_aidb)

d4rt evaluates a list literal to `List<Object?>` and a map literal to
`Map<Object?, Object?>`, so an adapter written `positionalArgs[0] as
Iterable<int>` tested the CONTAINER's type argument — which never matches —
rather than its CONTENTS, which usually do. `Runes('ab').followedBy([99])` threw
where `Runes('ab').followedBy(Runes('c'))` passed, which is why these survived
review.

Fixed at `Runes.followedBy`, `RegExpMatch.groups`, `Match.groups`,
`latin1.decode`, and `Uri`'s `pathSegments` and `queryParameters`. Two further
sites were probed and found already correct (`Function.apply`, `latin1.encode`)
and are now pinned so a later sweep cannot "fix" them into a regression.

`coerceElements` moves from `typed_data/inherited_list_methods.dart` to
`stdlib/coerce_elements.dart` — it was never typed-data-specific — and gains
`coerceMapArg` and `coerceElementsOrNull`. None of them widens: an element, key
or value whose type genuinely does not fit still fails.

### Fixed — `InternetAddressType` offered four members the SDK does not declare (scd24_aida)

`lookup`, `host`, `address` and `type` were bridged on the enum, each wired to
an unrelated `Object` member: `host` returned `.name`, `address` returned
`.hashCode`, `type` returned `.runtimeType`, `lookup` returned `toString()`. So
`type.address` handed back a hash code and raised nothing.

They were copied from `InternetAddress`, which sits beside it in the same file
and really does declare all four. Removed, and their absence pinned by
`F-SCD24-1..5`.

### Changed — the public barrel documents what it exports (scd14_aicx)

`lib/tom_d4rt_ast.dart` is a pass-through to the serializable mirror AST and
said it "adds the D4rt runtime: interpreter, environment, bridges, and standard
library". Those exist in the package but are not reachable through that entry
point — `package:tom_d4rt_ast/d4rt.dart` is. The docstring now says so, and
`lib/ast.dart` no longer points at an `ast_converter.dart` this package does not
have.

## 0.65.0

Name resolution: yes — a shared name is judged over what the reading script imports (scd4_aicv).

### Fixed — a name two packages share is judged over what the script imports (scd4_aicv)

A bridged name declared by two libraries was marked ambiguous wherever both
were registered, and the mark was enforced on every lookup that reached that
environment. `D4rtRunner`'s warm parent registers every bridged class of every
registered library into one environment that every script encloses, so there
the rule was evaluated over the host's whole registry: a script that imported
only `package:a` was refused `Foo` because `package:b` also declared one. Dart
decides ambiguity over the READER's imports.

Each unprefixed import is now recorded on the scope it lands in
(`Environment.recordUnprefixedImport`, called by both module loaders and by
`visitImportDirective`), and a lookup that meets an ambiguous name narrows the
candidates to the packages the reading module's imports reach — the imported
library's own package, or that of any declaration the import made visible,
honouring `show` / `hide`. One candidate left is the class the script means;
two or more are still Dart's ambiguous import, reported with just those; none,
or no import record at all, keeps the registry's verdict, because there is no
basis to choose.

A name the script's imports bring in is found in its own scope before any of
this, so the change only matters when an import's recorded export surface is
missing the name and the lookup falls through to the baseline — the shape
`cupertino/contextmenu_test.dart` reached with `TextStyle`. Platform precedence
(a `dart:*` declaration loses to a `package:` one) already cleared that case;
this is the package-vs-package half. AMBIG-2 / AMBIG-P4 are unchanged: peers in
scope are still rejected.

Pinned by AMBIG-S1..S7 in `test/environment_lazy_bridge_test.dart` and, at
script level through the runner, by `test/runtime/scd4a_ambiguity_import_scope_test.dart`
(F-SCD4A-AST-1 failed with `Ambiguous Name Error` before the fix).

## 0.64.0

### Fixed — `break` and `continue` reach the statement they name

`break` inside `await for` aborted the script with `Break statement outside of
a loop.` (SCD4). The cause was wider than `await for`: an async body sent every
jump to "the loop on top of `loopNodeStack`", and only `for` loops are pushed
there. So, in any `async` function:

- `break` / `continue` in `await for` failed, in both loop-variable forms;
- `break` / `continue` in `while` and `do` failed the same way;
- a `break` in a `while` nested in a `for` left the `for` — a silent wrong
  answer;
- labels were ignored, and a labelled loop was handed to the synchronous
  visitor, which cannot suspend on an `await` in its body.

The state machine now reads a jump's target from the AST — the innermost
enclosing loop (or `switch`, for a break), or the statement carrying the
label — and restores every loop stack to the depth it had when the outermost
loop being left was entered. A loop left early is forgotten, so re-entering a
`for-in` starts from its first element instead of resuming a stale iterator.
Labelled statements are stepped into, which exposed the next-statement search
recursing on a block instead of the statement in it and skipping the rest of
the block; that is fixed too.

Synchronous code had its own label defect: a label stayed in force for
everything nested inside the statement it was written on, so an unlabelled
inner loop took `break outer` / `continue outer` as its own. A loop or switch
now reads its labels once, on entry, and only when it is the statement the
label is written on.

`I-FILE-179`, the socket test whose catch-all had reported this defect as a
skip, now skips only on a network failure. `I-MISC-327` expected `'012'` from a
`continue outer` whose correct result is `''` — the Dart VM's answer — and is
corrected.

Still open, and tracked: `await for` reads the whole stream before its body
runs and an `async*` generator ignores its listener, so a `break` cannot stop a
generator (sce16); `break` / `continue` out of a `try` in an async body skip
its `finally` (sce18).

`test/runtime/scd4_jump_targets_test.dart` pins the fix against this tree with
hand-built bundles, since `tom_d4rt_exec` measures the published release.

## 0.63.0

### Removed — `lib/src/version.versioner.dart`, a version stamp nothing could read or refresh

It declared `TomVersionInfo` with a version a long way behind the package's
own, because it was never regenerated: this package has no `versioner:`
configuration, so `buildkit :versioner` skips it. Nothing imported it and the
library does not export it, so no consumer could reach it — it could only
mislead someone reading the source. A stamp is kept only where a banner prints
it, and there a test holds it to `pubspec.yaml`.

### Fixed — the host error boundary now unwraps the carrier, as its own doc already said it did (scc92)

`throwAsHostFacingError` in `tom_d4rt` unwraps
`InternalInterpreterD4rtException` so the host receives the value interpreted
code actually threw — including a value in neither error hierarchy, which real
Dart also permits a script to throw. This tree's copy did not, so such a throw
surfaced as `Unexpected error: <carrier>` instead.

It was not a documented difference: THIS FILE'S OWN doc comment says "the
boundary unwraps it one clause earlier so the host receives that value itself".
The prose had been mirrored and the code had not. That is exactly the failure
SCC92 was filed about, and writing the guard is what found it.

### Added — `tool/check_mirrored_sources.dart` and a suite that runs it (scc92)

The rule that an interpreter fix lands in both trees was enforced by nothing: a
one-sided fix analyzed clean, passed both suites, and surfaced only when
somebody read the two files side by side.

Measured, 156 files sit at mirrored paths; 142 agree and 14 diverge. The
divergent ones are baselined with a reason each, and the baseline is checked
from both directions — an entry that stops diverging is reported as stale, which
fired on its first run and removed five barrels that had been copied in from an
earlier measurement.

**It compares code, not text.** The todo proposed deriving one tree's copy from
the other, as the Flutter twins do. Those pairs differ by one import line, so
generation loses nothing; these differ in PROSE on purpose — `unbridged_reasons.dart`
documents a doc-derived pin in the reference and a registry-derived one here,
because those are genuinely different pins. Generating would delete that. So the
comparison strips comments and normalises the two package layouts, and prose
stays per-tree.

## 0.62.0

### Added — a deliberately-unbridged MEMBER now says so, like an unbridged class already did (scc91)

SCB30 made an unbridged CLASS explain itself: `Undefined variable: Zone (not
bridged: …; see doc/d4rt_limitations.md)`. It could not reach a missing MEMBER
on a class that IS bridged, because that fails one layer deeper — in bridged
member dispatch, where the only things in scope are a class and a member name,
not the bare identifier the map is keyed on. So the three `ByteBuffer` SIMD
views and the `RawSocket` message pair still reported a flat
`Bridged class 'ByteBuffer' has no instance method named 'asFloat32x4List'`,
and the limitations doc had to tell readers this was the one case where they
had to arrive by searching.

`kUnbridgedMemberReasons` is keyed on `Class.member` and consulted from all
three bridged-member miss sites — the method call, the property read, and the
implicit-`this` read. The prefix is unchanged and the reason is strictly a
suffix, exactly as SCB30 did it, because that prefix is what the doc tells
readers to grep and what `F-SCB29-3` matches on with `contains`.

**Keyed on the pair, not the member name**, so a typo still looks like a typo:
`buffer.asFlaot32x4List()` gets the bare message while `asFloat32x4List` gets
the reason. Erasing that distinction would undo what SCB30 was for, and
`F-SCB29-3` now pins both directions.

The two maps stay separate because they are keyed on different things, and
merging them would make one of them lie about what its key means.
`F-SCC91-AST-3` pins that they do not overlap; `F-SCC91-AST-1` pins that every
member entry names a class that really is registered, which is the rule that
keeps entries in the right map.

`F-SCB30-3` derives the expected key set from the doc, and the five member
names were subtracted from it because the map could not serve them. They are
now pinned instead of excused, and the doc's "Reported as" column lists
`readMessage` / `sendMessage` — which is what the error actually reports.

## 0.61.0

### Fixed — `WebSocketTransformer` had no supertype edge, and the audit doc had been wrong about it since (scc89)

`abstract interface class WebSocketTransformer implements
StreamTransformer<HttpRequest, WebSocket>`. SCC63 bridged the class and did not
declare the edge, so `transformer is StreamTransformer` answered false and the
whole inherited surface was unreachable. Declared in both trees.

The reason it survived is the point of SCC89. SCC57 measured the hierarchy
audit at zero candidates and wrote that into `doc/stdlib_sdk_gap_audit.md`;
SCC63 landed afterwards; nothing re-runs `--hierarchy` when a bridge ships, so
the sentence stayed there, wrong, for every commit in between.

Also in this change:

- An instance recipe for `HttpClientResponseCompressionState`, the audit's last
  unverified class. It is an enum, so the recipe is a value read — missing
  because nobody had asked the audit about it, not because it was hard.
- `_declinedEdges`, the hierarchy half's equivalent of the member half's
  `_declined`. Making that class measurable surfaced `-> Enum` as confirmed
  missing, which is a convention rather than a defect: the stdlib bridges every
  enum as a `BridgedClass` with `staticGetters`, and no bridged enum declares
  the edge. Declaring it for one would make it the odd one out. Recorded with
  its reason and counted separately, so a decision that stops being visible
  cannot stop being reviewable. Whether all bridged enums should declare it is
  SCD207.
- `test/doc/gap_audit_figures_test.dart`, which parses the doc's two *Current
  measured state* tables and compares every row against a live run of both
  audits. It caught a stale figure within minutes of being written — one this
  change itself introduced.

## 0.60.1

### Fixed — a dead anchor in the README, and the guard widened to cover it (scc88)

The guard walked `doc/` only. The package README is the first page anyone reads,
and `tom_d4rt`'s carried
`#source-based-vs-analyzer-free--which-line-to-use` — a double hyphen left by
stripping an em dash. Fixed, and every package's README is now inside the guard.

### Fixed — four dead cross-file links, and the anchor guard extended to cover them (scc88)

The anchor guard checked `](#anchor)` only, and four links to other FILES were
dead at the same moment: `limitation_and_bug_analysis.md` had been deleted from
both trees, and exec's `issues.md` linked to `d4rt_limitations.md`, which is the
reference tree's filename for a document exec names
`tom_d4rt_exec_limitations.md`. Retargeted or dropped, and `F-SCC88-5` now
checks every relative link resolves. External URLs stay out of scope.

### Added — a doc-anchor guard for this package's own `doc/` (scc88)

`test/doc/doc_anchors_test.dart` checks every `](#anchor)` names a heading in
its own file. This package's docs carry no intra-doc links today, so the guard
is preventive here; it caught 40 dead anchors in the sibling packages.

### Documented — which `D4` argument helper belongs to which side of the bridge layer (scc87)

Two helpers read a positional argument out of an adapter and they throw
different exception types. `D4.getRequiredArg` / `getOptionalArg` throw
`ArgumentD4rtException` and are what `tom_d4rt_generator` emits;
`D4.checkArity` throws `RuntimeD4rtException`, matching what the stdlib dispatch
path already produced and what `describeArityError` emits. Neither is wrong, but
the split was undocumented, so a new bridge had no one obvious way to read an
argument and the inconsistency kept reproducing.

Both definitions now say which side they belong to and point at the other.
`getRequiredArg`'s doc also said "Throws ArgumentError", which is a different
class it never throws.

Doc-only in `lib/`; the guard that keeps the boundary stated
(`stdlib_d4_boundary_test`) ships in `test/`.

## 0.60.0

### Added — `D4.checkArity`, and 526 stdlib adapters that no longer discard a surplus argument (scc85)

An adapter that reads `positionalArgs[0]` and is handed two arguments dropped
the second in silence — `UriData.parse('data:,a', 'extra')` returned the parsed
value, and a typo stayed invisible. The too-FEW half was already covered
generically by `D4.describeArityError`; too-MANY cannot be, because
`BridgedClass` stores an adapter as an untyped closure and nothing on the
dispatch path knows how many arguments it wants.

`D4.checkArity(positionalArgs, 'Class.member', atMost: N)` is the shared guard
that replaces writing that check out by hand, and it is now in 526 adapters per
tree. The unguarded surface measured 443 adapters across 49 files and is now 23
across 3.

**Every inserted bound is `atMost`, never `exactly`**, and that is what makes
the sweep safe. The maximum is derivable from the adapter's own source — one
past the highest index it reads, so anything beyond is provably ignored — while
the minimum is not: an adapter reading `positionalArgs[1]` behind a length test
takes one argument or two. Because `atMost` cannot fire on a too-few call, the
generic SCB28 diagnostic keeps that half untouched and none of F-SCB28-1..6 had
to be repointed as the sweep advanced.

The 23 remaining are a principled residue, not leftovers: 21 sit in shared
method-map helpers (`inheritedListMethods<E>`, `set_algebra_methods`) that serve
several bridged classes at once, so no single `Class.member` label exists for
them, and 2 pass the argument list on whole.

## 0.59.0

### Added — the SCB24 guard, count-based (scb24)

Mirrors `tom_d4rt` 1.70.0's intent with the instrument this package can carry.
The analyzer twin names which definition is unregistered; this one asserts that
the number of `static BridgedClass get …` declarations equals the number of
live bridge names, since the package is analyzer-free by construction.

A count cannot say which definition is orphaned, and could in principle be
balanced by an orphan plus a duplicate registration — but the duplicate half is
covered exactly by `scc76_bridge_name_collision_test.dart`, so the pair is not
open to that. Carried here rather than leaning on the mirror because nothing
verifies the two stdlib trees are copies, and SCC78 found the two interpreters
disagreeing on a line for as long as both existed.

## 0.58.0

### Added — a guard for the `runtimeType` divergence that only the other tree had (scc78)

This tree was already correct: `bridgedInstance.nativeObject.runtimeType` since
GEN-075, where `tom_d4rt` returned the wrapper's type. The two
`interpreter_visitor.dart` files disagreed on one line for as long as both
existed and nothing noticed — the mirror rule says a fix must land in both
trees, but has no counterpart saying the two must AGREE.

`test/runtime/scc78_bridged_runtimetype_test.dart` pins the property from this
side, including that the wrappers of two unrelated types really are
indistinguishable — which is what made the defect invisible rather than merely
wrong.

## 0.57.0

### Fixed — `StringSink.hashCode` was a method shadowing its own getter (scc77)

Mirrors `tom_d4rt` 1.68.0.

### Added — registration-level `StringSink` reachability coverage

`test/runtime/scc77_string_sink_reachability_test.dart`. This tree had NO
coverage of the `StringSink` edges at all: they were mirrored across correctly,
and nothing here would have noticed if they had not been.

Registration level is also the right level for what SCC77 turned out to be — the
fix lives entirely in the supertype registry, and `isSubtypeOf` reads it
directly. The file additionally pins that nothing resolves TO the `StringSink`
bridge, which is why its member list is guarded at registration level rather
than by any script.

## 0.56.0

### Added — a guard that no stdlib bridge name is defined twice (scc76)

Mirrors `tom_d4rt` 1.67.0: `test/scc76_bridge_name_collision_test.dart`
registers every stdlib registrar into one environment and asserts each name
resolves to exactly one bridge, plus `AstModuleLoader.stdlibModuleNames` as the
read-only view it drives off.

This tree's loader lists `core` and `async` with `null` registrars — they are
pre-registered at runner construction — so its `stdlibModuleNames` includes
them where the analyzer tree's does not. The guard covers both shapes.

## 0.55.0

### Added — the eight remaining reachable-member gaps (scc74)

Mirrors `tom_d4rt` 1.66.0: `LinkedListEntry.insertAfter` / `.insertBefore`,
`Object.noSuchMethod`, `StringConversionSink.asUtf8Sink`,
`Stdout.lineTerminator` (getter and setter), `HttpClient.authenticateProxy` /
`.connectionFactory`, and `WebSocketTransformer.cast`.

`SocketMessage`, `SocketControlMessage` and `ResourceHandle` join
`kUnbridgedReasons`, so a script that reaches for file-descriptor passing is
told it is refused for sandbox reasons rather than merely that the name is
undefined.

The audit that found these runs scripts through the analyzer-based interpreter
and cannot run here; coverage on this line is registration-level
(`test/runtime/stdlib_member_axis_gaps_test.dart`), which is the level that
catches the failure this tree is exposed to — an adapter lost crossing the
mirror.

## 0.54.0

### Added — 26 SDK members the bridges declared no way to reach (scc73)

Mirrors `tom_d4rt` 1.65.0: the `dart:collection` map and set named
constructors, `Queue.of` / `ListQueue.of`, `DateTime.timestamp`,
`StackTrace.fromString`, `RangeError.index`, `Iterable.withIterator`,
`StreamTransformer(onListen)`, `StringConversionSink.from` /
`.fromStringSink`, `ProcessResult(...)`, `IOSink(target, {encoding})`,
`Stdin.supportsAnsiEscapes` and `Stdout.nonBlocking`. `Runes.iterator` moves
from `methods` to `getters`, where the SDK declares it.

The guard that found them reads the SDK with the `analyzer` package and so
lives only in `tom_d4rt`. Coverage on this line is registration-level
(`test/runtime/stdlib_sdk_member_completeness_test.dart`), which is the level
that can detect the failure this tree is actually exposed to: an adapter lost
on the way across the mirror.

## 0.53.0

### Fixed — `Converter.bind` and the `addStream` family were unreachable from scripts (scc68)

`D4.coerceStream<T>` and `D4.coerceByteStream` added; the 19 stream-taking
adapters in `dart:convert` and `dart:io` now route their argument through them
instead of casting to a container type the interpreter's erasure can never
produce. Guards narrow from `Stream<T>` to a raw `Stream` so the exception type
at that boundary is unchanged.

Coverage on this line is registration-level
(`test/runtime/stdlib_stream_arg_coercion_test.dart`) — `tom_d4rt_exec` is the
only runner that could execute a script against this tree and it resolves
`tom_d4rt_ast` from pub.dev, so it cannot see unpublished edits.

Mirrors `tom_d4rt` 1.64.0.

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

This section also covers the work released as **0.44.0**, whose heading
was renamed rather than added to when the version was bumped (ab944d4a2,
scc56). 0.44.0 was never published, so no release carries that number.

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

**Known limitation at the time, closed later (scd121).** The
variable-declaration resumption route still bound the first awaited value
straight to the variable instead of re-running the declaration, so
`var s = (await a) + (await b);` yielded `1` rather than `3`. The
return-statement route was already correct. Fixed in 1.107.0 / 0.94.0.

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

This section also covers the work released as **0.22.0**, whose heading
was renamed rather than added to when the version was bumped (10a53c28f).
0.22.0 was never published, so no release carries that number.

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

Name resolution: yes — platform-library precedence, so a `dart:*` name no longer makes a package name ambiguous.

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

Name resolution: yes — the ambiguity rule itself — two same-named bridged classes stop resolving to whichever registered last (tcca19).

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