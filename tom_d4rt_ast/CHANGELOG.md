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