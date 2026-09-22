## 1.168.0

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

## 1.167.0

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

## 1.166.0

### Fixed — every host boundary hands over the same shape (sce118)

SCE118 was filed against `execute()` handing a caller a
`BridgedInstance<Object>` instead of the `StateError` the script threw. SCD96
closed that; measured before anything was changed, `execute`, `eval`, the
`onUncaughtError` hook and an embedder's own zone all deliver the SDK type.

WHAT WAS STILL OPEN was the todo's own closing instruction — state that all
delivery paths hand over the identical shape, because nothing did. Stating it
found a live divergence.

`invoke()` is the fourth boundary and was the last one deciding for itself. It
goes through `_tryFunction`, whose catch peeled the interpreted-`throw` carrier
by hand and stringified everything else into `"$error : $e"`. A script method
that hit an ordinary interpreter fault therefore handed the host a **String**
where `execute` and `eval` hand over a `RuntimeD4rtException` — nothing
catchable by type, and nothing saying so. It is on `throwAsHostFacingError`
now, so the context the message carried is in the preserved stack trace
instead.

Four hand-rolled peels became one seam: the two `eval` sites in this tree also
carried their own, including a `RuntimeD4rtException` branch whose two arms are
the same throw with different static types. Converging those changes no
behaviour — measured — but they are how `eval` came to differ from the shared
helper by one level in the first place.

Name resolution: no.

## 1.165.0

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

## 1.164.0

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

## 1.163.0

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

## 1.162.0

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

## 1.161.0

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

## 1.160.0

### Fixed — a module's parse errors are English, and on separate lines (sce111)

The module path's diagnostics read `(ligne N, colonne M)` — the only French
left in the package, and inconsistent with the direct-source path in
`d4rt_base.dart`, which is the same report for the same event one caller over.

And they were joined with `"\\n"`, which in a double-quoted Dart string is an
escaped backslash followed by `n`, not a newline. A module with four syntax
errors therefore arrived as ONE run-on line containing the characters `\n`,
while the direct-source path — which joins on a real newline — printed one per
line. A reader scanning a module failure for `line 1, column 19` found neither
the word nor the line break.

Both were found while converging the module-failure SENTENCE with
`tom_d4rt_exec` (sce111), which is the more visible half of that todo and the
smaller defect of the three.

Name resolution: no.

## 1.159.0

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

## 1.158.0

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

## 1.157.0

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

## 1.156.0

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

## 1.155.0

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

## 1.154.0

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

## 1.153.0

### Documented — the permission gates' null-interpreter branch is the un-sandboxed mode (sce87)

No behaviour change. The five `dart:io` permission gates reach the permission
table through a nullable handle and return when it is absent:

    final d4rt = visitor.moduleLoader.d4rt;
    if (d4rt == null) return;            // no D4rt, no check

An early return from a gate GRANTS, in the capabilities the sandbox exists for,
and the analyzer-free twin — which has no nullable handle and always calls
`checkPermission` — reads as the corrected version. Measured, it is neither a
hole nor a correction:

* the branch is UNREACHABLE FROM A SCRIPT. `d4rt_base.dart` constructs exactly
  one `ModuleLoader` and passes `d4rt: this`; the only `lib/` code that builds
  a d4rt-less loader is the bridged-enum `toString` fallback, which calls a
  `toString` adapter inside a `try/catch` and reaches no gate;
* the gate is LIVE on the path a script takes — granting `FilesystemPermission`
  (which `dart:io` needs to import at all) and withholding
  `DangerousPermission` refuses `Platform.version`;
* the twin is PERMISSIVE IN THE SAME STATE. `NoOpModuleContext.checkPermission`
  returns `true` when no checker is wired, under its own comment "be permissive
  (allow all)".

So both trees grant when nothing sandboxed them, and differ only in where that
is expressed. Denying here would make the reference refuse where the twin
allows — introducing a behavioural divergence rather than removing one, and
breaking the documented mode in which a bridge is driven directly.

All five gates now say this, and both halves are pinned by
`sce87_permission_gate_null_handle_test.dart` in each tree. The load-bearing
case is the structural one: a second `ModuleLoader` construction, or that
`d4rt:` argument going away, is what would turn the branch into a real hole.

## 1.152.0

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

## 1.151.0

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

## 1.150.0

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

## 1.149.0

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

## 1.148.0

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

## 1.147.0

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

## 1.146.0

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

## 1.145.0

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

## 1.144.0

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

## 1.143.0

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

## 1.142.0

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

## 1.141.0

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

## 1.140.0

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

## 1.139.0

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

## 1.138.0

### Changed — doc comments that name a library are marked as prose (sce56)

`_bin/check_doc_references.py` resolves `package:` URIs inside `///` comments
against the workspace. Three doc blocks here name libraries that no file backs,
all of them deliberately: `library_mapping.dart` documents CANONICAL URIs, the
identity a bridge registers under rather than a path, and
`d4rt_user_bridge_annotation.dart` shows annotation targets in packages this one
does not depend on.

Marked with `doc-ref: ok` and the reason, so the check stays quiet without
losing the distinction between "illustrative" and "wrong".

## 1.137.0

Name resolution: yes — a name narrowed by import scope is retrieved by kind, not as a class only (sce25).

### Fixed — an ambiguous name narrowed by import scope was only retrieved as a class

Completes the generalisation the previous release began. `_resolveAmbiguityInImportScope`
narrowed a contested name to the single package the script had imported and then
read `_bridgedClasses[name]` alone, so a narrowed ENUM or top-level value fell
through the branch and reached the `AmbiguousBridgedNameException` throw it had
just been cleared of. Retrieval now consults the alias environment by kind —
bridged class, then bridged enum, then value — so narrowing resolves whatever
kind the name actually denotes.

### Fixed — `getConfiguration`'s example omitted the library argument

`registerGlobalVariable` takes the library URI as a required third argument; the
doc comment showed a two-argument call that does not compile.

## 1.136.0

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

## 1.135.0

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

## 1.134.0

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

## 1.133.0

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

## 1.132.0

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

## 1.131.0

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

## 1.130.0

### Changed - one environment instead of two in the bridged-enum toString visitors (scd208)

`BridgedEnumValue.get` and `BridgedEnumValue.toString` build a throwaway
`InterpreterVisitor` to invoke a bridged `toString` adapter. Each site
constructed TWO separate `Environment()` objects — one as the visitor's
`globalEnvironment`, one inside the `ModuleLoader` it was given — where the
analyzer-free twin has always bound one local and passed it to both.

Inert in practice: both were fresh and empty, and the adapter is called and
discarded in the same expression. It is not a shape anyone would choose, and
it made two spellings of the same construction read as two different
constructions, which is what a mirror baseline is meant to make visible.

Both sites now bind `final env = Environment()`. What remains between the
trees is the type difference that cannot go away — `ModuleLoader` against
`NoOpModuleContext`, the twin having no module loader at all — now four code
lines rather than ten.

## 1.129.0

### Changed - two mirrored files stop diverging for reasons that did not survive reading (scd208)

Both were baselined as SUSPECTED ONE-SIDED EDITS by the mirror guard, meaning
the divergence had been noticed and not investigated. Read with a normalised
diff, neither was an edit that reached one tree.

`environment.dart` declared `removeLocalValue` in both trees, five identical
lines, in a different POSITION — and in this tree the position was wrong: the
method sat BETWEEN `define`'s doc comment and `define`, so `define` documented
`removeLocalValue` and `removeLocalValue`'s doc read as a continuation of
`define`'s. It now sits after `getSlot`, where the twin has always had it, and
`define` has its documentation back.

`BridgedInstance.get` spelled one enum-property lookup — `.name` and `.index`
on a wrapped native `Enum` — as an if-chain here and a switch in the twin.
Behaviour-identical, confirmed by reading both; this tree now carries the
switch, since the analyzer-free tree is where new interpreter work lands.

No behaviour changes. Both pairs now agree whole-file, and the three separate
records that described their divergence — the mirror baseline, SCD183's region
list and SCD199's body census — were each deleted by the guard that noticed
them go stale.

## 1.128.0

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

## 1.127.0

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

## 1.126.0

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

## 1.125.0

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

## 1.124.0

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

## 1.123.0

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

## 1.122.0

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

## 1.121.0

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

## 1.120.0

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

## 1.119.0

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

## 1.118.0

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

## 1.117.0

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

## 1.116.0

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

## 1.115.0

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

## 1.114.0

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

## 1.113.0

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

## 1.112.0

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

## 1.111.0

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

## 1.110.0

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

## 1.109.0

### Added — three files the barrel never exported (scd134)

A type a consumer *receives* but cannot *name* is not a private type; it is a
public type with a missing export. Three files were in that position, and the
AST twin (`tom_d4rt_ast/runtime.dart`) exported all three equivalents:

- `src/bridge/bridged_enum.dart` — `BridgedEnum`, `BridgedEnumValue`.
  `BridgedEnumDefinition.buildBridgedEnum()` returns the first and
  `Environment.getRuntimeType` returns it for any native enum value. Reaching
  them meant importing `package:tom_d4rt/src/...`, which is exactly what the
  `implementation_imports` lint forbids.
- `src/sdk_errors.dart` — `D4rtTypeError`, `D4rtNoSuchMethodError`,
  `indexRangeError`. These are the SDK error types the interpreter raises
  itself so that `on TypeError` matches inside interpreted code (SCB10); a host
  that wants to catch one needs the name.
- `src/module_loader.dart` — `ModuleLoader`, `LoadedModule`.
  `InterpreterVisitor.moduleLoader` is a public field of type `ModuleLoader`.

Purely additive: seven names appear on the public surface, none change or move.

`test/scd134_barrel_surface_parity_test.dart` now compares the two barrels'
exported name sets on every run, with each remaining difference recorded
individually and a reason attached. Twenty remain, and the classification is the
useful part rather than the count: most follow from one line having an analyzer
and the other deliberately not, two are one concept under two names, and five
are recorded as genuine gaps rather than differences (see sce154 and sce155).

## 1.108.0

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

## 1.107.0

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

## 1.106.0

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

## 1.105.0

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

## 1.104.0

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

## 1.103.0

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

## 1.102.0

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

## 1.101.0

### Added — a report-only static pass that finds undefined names (scd95, phase 1)

`lib/src/static_name_report.dart`. **It reports; it never throws, and nothing in
`execute()` calls it.** That is deliberate, and it is the whole risk-management
strategy of the work it belongs to.

SCC31 made an undefined name unswallowable — raised as
`UndefinedNameD4rtException`, declined by both catch-dispatch sites — which
removed the harm but not the divergence. Real Dart rejects the program at
COMPILE time, so it never runs; d4rt runs everything up to the bad line first.
A script that writes a file on line 3 and mistypes a name on line 9 has already
written the file. Closing that needs a pass that can REFUSE to run a program,
and a resolver wrong in the aggressive direction rejects working scripts —
which is far worse than the bug it fixes. So the resolver is built report-only
and swept over corpora of programs known to work first.

**What the sweep measured** (`tool/scd95_sweep.dart`,
`tool/scd95_sweep_inline.dart`):

| corpus                         | units | clean | flagged |
| ------------------------------ | ----: | ----: | ------: |
| flutter-material cluster       |  2085 |  2083 |       1 |
| tom_d4rt inline `execute(...)` |   807 |   799 |       8 |

Every remaining flag is a TRUE positive, in a script written on purpose to
contain one: `ButtonBar` in `a5_deprecated_symbol_absent_test.dart`,
`totallyUndefinedThing` in SCC31's own fixture, `notDefinedAnywhere` in SCD69's,
and `Zone`/`Zoen` in `intentionally_unbridged_test.dart`.

Reaching that state meant closing four real resolver holes, each of which had
produced a page of false positives and each of which is now pinned:

- **Cascade sections.** `x..moveTo(0, 0)` has no target in the AST — the
  receiver is the cascade's. Reading `MethodInvocation.target` alone reported
  `moveTo`, `lineTo`, `setEntry`, `scale`, `sort`, `writeln` and `add` as
  undefined: 833 hits from one missing `isCascaded`.
- **Switch EXPRESSION patterns.** Handling only `SwitchPatternCase` left every
  `switch (s) { Circle(:var radius) => radius * radius }` reporting the name it
  had just bound.
- **Extension-opened classes.** An extension member is reachable through
  implicit `this` by a route no class body mentions, so a class an extension
  targets is open — and an extension on `Object` opens every class.
- **Import prefixes.** `import ... as m` puts `m` in scope as a name.

A fifth was a fault in the SWEEP rather than the resolver, and is the one worth
repeating: suppressing a unit because it merely HAS an import made the first run
report nothing, look clean, and examine none of the 2085 files. `NameReport`
now carries `suppressed`, so a suppressed report is distinguishable from a clean
one, and `openClasses`, so the 12 201 class bodies the flutter sweep skips are
visible in the data rather than only in a comment.

**Why it is not yet enforcing.** The sweeps supply the registration set by
regex-harvesting bridge and stdlib sources — good enough to measure a syntactic
resolver, not good enough to reject a program. The real set lives in the
`Environment` at execute time. See sce128, which records the design this
measurement arrived at, including the two facts that make it viable:
`registerBridgedClassLazy` is name-eager, and directives are processed before
any statement of `main` runs.

## 1.100.0

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

## 1.99.0

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

## 1.98.0

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

## 1.97.0

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

## 1.96.0

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

## 1.95.1

### Removed — `_executeClassic`, which was dead code pinning a retired contract (scd85)

A ~310-line private copy of the original `execute()` implementation, kept
behind `// ignore: unused_element` under a banner reading `PRESERVED FOR
DEBUGGING REFERENCE` / `DO NOT MODIFY OR DELETE THIS METHOD!`. Nothing called
it — that is what the ignore was for.

**The problem was the word "reference".** SCC27 rewrote the live boundary so an
`Error` or `Exception` leaves `execute()` as itself; this copy was deliberately
left alone, because the banner forbade editing it and a dead method cannot fail
a test. Its two catch-alls therefore still said
`throw RuntimeD4rtException('Unexpected error: $e')` — a boundary contract that
holds nowhere — while the banner told the reader it was authoritative. A stale
document that announces itself as current is worse than no copy, and the same
objection would have applied to every future change to the live path.

The banner also contradicted itself: alongside `DO NOT MODIFY OR DELETE` it
carried `TODO: Remove this legacy method once all code uses the new execution
path`. Deleting it follows the second instruction; keeping it accurate was
forbidden by the first.

Git history serves the stated purpose without the risk — `git log -S
_executeClassic` finds it, unambiguously dated, which an in-tree copy is not.
Checked before deleting: nothing in the workspace calls it, and no doc or
guideline names it. The other hits a naive grep finds are `_executeClassicFor`
and `_executeClassicForWithYieldSuspension`, which are about C-style `for` loops
and unrelated.

No behaviour changes: the method was unreachable, and both suites are unchanged
(3648 pass, 0 fail).

## 1.95.0

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

## 1.94.0

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
reaching the caller of `execute` (a hang, not a failure). What the analysis
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

## 1.93.0

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

## 1.92.0

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

## 1.91.0

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

## 1.90.0

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

## 1.89.0

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

## 1.88.0

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

## 1.87.0

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

## 1.86.0

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

## 1.85.0

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

## 1.84.0

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

## 1.83.0

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

## 1.82.0

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

## 1.81.0

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

## 1.80.0

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

## 1.79.0

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

## 1.78.0

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

## 1.77.0

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

This tree registers only bridge TYPES in its warm parent, so bare names
reach a script only through its imports and the narrowing is dormant here; it
is mirrored so the two environments stay one design. Pinned by AMBIG-S1..S7 in
`test/environment_lazy_bridge_test.dart`.

## 1.76.0

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

## 1.75.0

### Removed — `lib/src/version.versioner.dart`, a version stamp nothing could read or refresh

It declared `TomVersionInfo` with a version a long way behind the package's
own, because it was never regenerated: this package has no `versioner:`
configuration, so `buildkit :versioner` skips it. Nothing imported it and the
library does not export it, so no consumer could reach it — it could only
mislead someone reading the source. A stamp is kept only where a banner prints
it, and there a test holds it to `pubspec.yaml`.

### Fixed — one export out of alphabetical order, found by the new mirror check (scc92)

`closable_string_sink.dart` sat between `html_escape` and `json` in
`stdlib/convert.dart` here, while the AST tree already had it in alphabetical
order. Only this tree changed; the pair agrees now.

The check itself lives in `tom_d4rt_ast` — see its CHANGELOG for why it
compares code rather than deriving one tree from the other.

## 1.74.0

### Changed — the audit tool defers to the interpreter's decision table instead of keeping its own (scc91)

`tool/stdlib_member_diff.dart` carried a private `_declined` map of five
`Class.member` decisions. SCC91 gave the interpreter `kUnbridgedMemberReasons`
so a declined member explains itself at the point of failure — and it held
exactly the same five keys. The tool now reads that map. Two tables of the same
decisions in the same key shape is one too many, and the one the error message
uses is the one that cannot go stale unnoticed.

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

## 1.73.0

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

## 1.72.0

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

### Fixed — 40 dead intra-document anchors, and a test that stops them coming back (scc88)

`d4rt_limitations.md` opens with a bug index whose rows link to detail sections,
and 35 of those anchors resolved to nothing; `BRIDGING_GUIDE.md` and
`stdlib_sdk_gap_audit.md` carried five more. The rows still read as
authoritative, so only the navigation was dead — and a dead anchor is silent in
a browser, so a reader concludes the section is missing rather than that the
link is wrong.

23 of the 35 were simply WRONG anchors: the section exists and the slug did not
match it (`bug-27-short-circuit--with-null-check-fails`, a double hyphen left by
stripping `&&`, and similar). Those are retargeted. The other 12 have no detail
section in the file, in the tree, or in this repository's history — the doc
arrived at the initial group-repo import already missing them — so those rows
are UNLINKED, keeping their ID, description and status, with a note above the
table saying why they are not links.

`test/doc/doc_anchors_test.dart` pins it: every `](#anchor)` in `doc/` must name
a heading in its own file. It models GitHub's `-1`/`-2` suffixes for repeated
headings, which this corpus needs — "Problem Description" appears 75 times, once
per bug section.

### Documented — which `D4` argument helper belongs to which side of the bridge layer (scc87)

`D4.getRequiredArg` / `getOptionalArg` throw `ArgumentD4rtException` and are the
GENERATED-code entry points; `D4.checkArity` throws `RuntimeD4rtException` and is
the hand-written stdlib's. The split was undocumented, so a new bridge had no one
obvious way to read an argument. Both definitions now state their side and point
at the other, and `stdlib_d4_boundary_test` pins that no stdlib file reaches for
the generated pair. `getRequiredArg`'s doc also claimed it throws `ArgumentError`,
a class it never throws.

## 1.71.0

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

## 1.70.0

### Added — a guard that a written bridge definition is actually registered (scb24)

`StringConversionConvert` and `ChunkedConversionConvert` were fully written —
constructors, adapters, argument validation — exported from `convert.dart`, and
never passed to `defineBridge`. No script could name either. SC9 found them by
accident, and the SDK gap audit structurally could not: it looks for missing
FILES, and by that measure both libraries were complete.

`test/scb24_unregistered_bridge_test.dart` reads every
`static BridgedClass get …` under the stdlib with the analyzer, extracts the
`name:` it passes to `BridgedClass`, and asserts that name is live in a fully
registered environment. Measured 2026-09-06: 205 declarations, 205 live names,
zero orphans — SC9's two were the only ones.

**It asserts the runtime property, not the source diff SCB24 described.** A
source-level diff of declarations against `defineBridge` calls has a blind spot
this does not: a call inside a `register()` nobody invokes reads as registered
and is not. The environment has to be built either way, so the weaker check
would not have been cheaper.

Verified by commenting out one registration: the guard names the exact
definition and its bridge name.

## 1.69.0

### Fixed — `runtimeType` on a bridged instance reported `BridgedInstance<Object>` (scc78)

`visitPropertyAccess` intercepted `runtimeType` and `hashCode` for a bridged
instance and returned `target.runtimeType` — and `target` IS the wrapper when
the value arrives already wrapped. So every bridged value in the language
reported `BridgedInstance<Object>`: `StringBuffer`, `Object`, `Duration`,
`File`, all of them. The interception sat in a `switch` ahead of the
getter-adapter lookup, so the `runtimeType` getter most bridges declare could
never override it.

Primitives and collections were unaffected, because they are not wrapped —
which is why the defect read as "some types are fine".

**`tom_d4rt_ast` has had the correct form since GEN-075.** The two
`interpreter_visitor.dart` files disagreed on this one line for as long as both
existed, and nothing noticed. The fix is written identically in both, so a diff
of the mirror shows nothing.

### Changed — `I-OBJ-UNI-3` asserts the type it expects

It accepted any non-empty string that was not `"no throw"` — its own comment
said "just assert it produces a non-empty type-name string", which cannot
distinguish a correct answer from any wrong one. It now pins `FormatException`.

SCC78 filed it as the assertion that had MASKED the defect. Measured, that is
not so: re-breaking the fix leaves it green, because a caught `FormatException`
never reaches the bridged-instance branch. It was genuinely too weak and is
tightened on its own merits; it was not what hid the bug.

## 1.68.0

### Fixed — `StringSink.hashCode` was a method shadowing its own getter (scc77)

`StringSinkCore` declared `hashCode` in BOTH `methods` and `getters`, and
`BridgedInstance.get` consults `methods` first — so the getter was dead and
reading `x.hashCode` on a value resolving to this bridge would have yielded the
bound callable instead of the int. The same shape SCC73 found on
`Runes.iterator`. The method entry is gone.

No script could observe it, because nothing resolves to the `StringSink` bridge
— which is exactly why it survived.

### Added — the `StringSink` reachability SCC77 asked for is now pinned

`test/stdlib/core/scc77_string_sink_reachability_test.dart` covers what nothing
covered end to end: `StringBuffer`, `stdout`, a file `IOSink` and a
`ClosableStringSink` all answering `is StringSink`, and `StringSink` used as a
declared parameter type — which is stronger than `is`, since it goes through
parameter checking.

**The reachability itself was already there.** SCC77 was filed when
`StringBuffer() is StringSink` was FALSE; SCC56's supertype edges
(`StringBuffer -> StringSink`, `IOSink -> StreamSink, StringSink`) closed that,
and this release only pins it. Verified by deleting the edge and watching the
cases fail.

### Documented — `StringSinkCore` has no `isAssignable`, and that is a decision

SCC77 also asked for an `isAssignable` predicate. Measured by adding it, running
both suites, and removing it again: resolution is IDENTICAL either way, because
every `StringSink` the stdlib hands a script already has a more specific bridge.
It would be a no-op today and a latent hazard tomorrow — the predicate is what
lets a bridge win the `isAssignable` fallback, so the first stdlib type
implementing `StringSink` without its own bridge would resolve there and lose
its real class's members. The reasoning is recorded in `string_sink.dart`.

One of SCC77's predictions is recorded as tested and FALSE: the edges do not let
member lookup fall through to the `StringSink` bridge, because every
implementor's bridge declares a superset of its members.

## 1.67.0

### Added — a guard that no stdlib bridge name is defined twice (scc76)

SCB26 was a duplicate bridge name: `StringSink` was registered by both the core
and the io registrar. It survived for as long as it existed and only surfaced
because SC9 happened to trip over the warning it logs. The cost was not the
duplication — it was that the LAST registration wins, so `StringSink` silently
lost three members it had in the other copy, and no test noticed.

`test/scc76_bridge_name_collision_test.dart` registers every stdlib registrar
into one environment and asserts each registered name resolves to exactly one
bridge. It is green today (205 names, zero collisions) — the value is the next
one.

The assertion is possible without a production change because
`_recordShadowedBridge` runs on EVERY collision, before the `nativeType`
comparison that decides ambiguity. Two definitions of the same native type read
as a benign re-export and are never marked ambiguous, which is correct for two
barrels exporting one class and exactly wrong for two registrars — but the
displaced bridge is stashed either way, so `findAllBridgedClassesByName` sees
both.

### Added — `ModuleLoader.stdlibModuleNames`

A read-only view of the `dart:` libraries the loader can register on demand, so
the guard drives off the production list instead of a copy. A copy in the test
would decay silently, which is the failure the guard exists to prevent one
level up.

### Fixed — the type-resolution fallback carried a second registrar map, and it had drifted

`module_loader.dart` wrote the stdlib registrar list out twice: once as
`_stdlibRegistrars` and again as a local map in the fallback that auto-loads
stdlib modules while resolving an unknown type. The copy was missing
`isolate`, so a bridge package depending on a `dart:isolate` type found nothing
there while every other stdlib module was tried. The loop now derives from the
one map.

## 1.66.0

### Added — the eight remaining reachable-member gaps, and the audit that was blind to a quarter of the surface (scc74)

SCC73's guard covers constructors and instance getters. Methods and statics are
measured by `tool/stdlib_member_diff.dart` instead, which probes each candidate
through a real instance — the only sound approach for members that are
inherited and that take arguments.

**The instrument first.** Three classes SCC61..SCC63 bridged — `HttpRequest`,
`WebSocket`, `WebSocketTransformer` — never got instance recipes, so 73 members
went into the "cannot be measured" bucket alongside the classes that have a
documented reason to be there. Nothing failed: the baseline folded the two
kinds together. Writing the three recipes found a real gap on the first run.
`F-SCC74-2` now asserts that bucket is empty, so a bridged class without a
recipe fails immediately instead of going quietly dark.

**Then the gaps.** Eight members closed, each with behaviour cases:

- `LinkedListEntry.insertAfter` / `.insertBefore`
- `Object.noSuchMethod` — the route an interpreted `super.noSuchMethod(...)`
  needs
- `StringConversionSink.asUtf8Sink`
- `Stdout.lineTerminator` (getter and setter; the setter enforces the two legal
  values the SDK only asserts on)
- `HttpClient.authenticateProxy` / `.connectionFactory`
- `WebSocketTransformer.cast`

**And a distinction the tool could not previously make.** The remaining five
measured-unreachable members are decisions, not defects, and had been sharing a
number with the backlog: the three `ByteBuffer` SIMD views already had a
limitations-table row and a pinning test, and still read as unfinished work.
The new `_declined` table separates them, pointing at the recorded decision
rather than restating it. `RawSocket.readMessage` / `.sendMessage` join them
with a new limitations row — they move `ResourceHandle`s, raw OS file
descriptors, across a socket, which no permission check can see; that one is
refused rather than deferred.

Confirmed defects on the method/static axis are now **0**, against 73 members
on four classes that still cannot be measured. Those two numbers have to be
read together.

### Fixed — `--baseline` wrote unformatted source (scd184)

The emitter writes one list element per line and `dart format` collapses short
lists, so a two-line change produced a 125-line diff — burying the "which
members moved and why" the tool tells its caller to look for. It formats what
it writes now.

## 1.65.0

### Added — 26 SDK members the bridges declared no way to reach (scc73)

A new guard, `test/scc73_sdk_member_completeness_test.dart`, reads the SDK's
own source with the `analyzer` package and diffs every public constructor and
instance getter it declares against what the bridges expose. SCB24 guards the
axis one level up — that no whole class goes missing from a registrar — and
SCB25's defect sat below that line: `JsonEncoder` was registered, so the
class-level guard was satisfied, while `withIndent` was absent and `indent` was
not exposed at all.

The guard runs over all eight bridged `dart:` libraries and found 26 real gaps,
all of which this release closes:

- **dart:collection** — `HashMap` / `LinkedHashMap` / `SplayTreeMap`
  `fromIterable`, `fromIterables` and `fromEntries`; `HashSet.identity`,
  `HashSet.of`, `LinkedHashSet.identity`, `Queue.of`, `ListQueue.of`.
- **dart:core** — `DateTime.timestamp`, `StackTrace.fromString`,
  `RangeError.index`, `Iterable.withIterator`, and `Runes.iterator`, which was
  registered as a *method*, so reading it handed back the bound callable
  instead of the iterator.
- **dart:async** — `StreamTransformer(onListen)`.
- **dart:convert** — `StringConversionSink.from` and `.fromStringSink`.
- **dart:io** — `ProcessResult(...)`, `IOSink(target, {encoding})`,
  `Stdin.supportsAnsiEscapes`, `Stdout.nonBlocking`.

The three map implementations declare their named constructors with identical
bodies — the SDK shares them through a private `MapBase` helper a bridge cannot
call — so the adapters delegate to one shared `MapNamedConstructors` rather
than repeating the argument handling three times.

The guard ships with an **empty allowlist**. Members are skipped only where the
reason is a property of the language or the SDK's own intent: generative
constructors on abstract classes (unreachable from a script by construction),
`@Deprecated` members, and members `@Since` a version above this package's own
SDK floor — without that last rule the guard would turn red on every SDK
upgrade, demanding members the package cannot legally compile against.

## 1.64.0

### Fixed — `Converter.bind` and the `addStream` family were unreachable from scripts (scc68)

Every adapter that takes a stream guarded its argument with a *container-typed*
test — `positionalArgs[0] is! Stream<String>` — and then made the matching
container-typed cast. The interpreter erases type arguments, so a script's
`Stream.fromIterable([...])` arrives as a `Stream<Object?>` and the guard
rejected it. The whole `Converter.bind` surface, plus `IOSink.addStream`,
`Socket.addStream`, `Stdout.addStream`, `HttpResponse.addStream`,
`HttpClientRequest.addStream` and `WebSocketTransformer.bind`, could not be
called from interpreted code at all. Because the guard fired first, the symptom
was its own "requires a Stream argument" message, which read as a script
mistake rather than a bridge bug.

Two new helpers carry the fix across the 19 affected call sites:

- `D4.coerceStream<T>` converts element by element, and passes an
  already-typed `Stream<T>` through by identity.
- `D4.coerceByteStream` handles the nested case, where erasure applies twice
  over. `Stream.cast<List<int>>()` is *not* enough here: `cast` converts the
  ELEMENT, and a `List<Object?>` chunk is not a `List<int>`. Each chunk goes
  through `D4.coerceList<int>` instead, so a bad chunk fails the way a list
  parameter would.

The guards themselves survive, narrowed from `Stream<T>` — which the
interpreter can never satisfy — to a raw `Stream`. `D4.coerce*` throws
`ArgumentD4rtException` while the stdlib adapters throw `RuntimeD4rtException`,
and those are siblings rather than parent and child, so routing the whole check
through the helper would have silently changed what a script's `catch`
dispatches on.

## 1.63.0

### Added — the last three `dart:io` re-exports a script could reach but not name (scc65)

`HttpDate`, `RedirectInfo` and `HttpClientResponseCompressionState` are now
bridged, closing the `dart:io` re-export surface: 30 of its 32 names are
bridged and the remaining two are decisions recorded in
`doc/d4rt_limitations.md`.

Two of the three were the shape that fails one call *after* the call that
caused it. `HttpClientResponse.redirects` and `.compressionState` had been
bridged all along, so a script could reach a value and then be unable to name,
test or read it — the error names the getter it was passed to, not the getter
that produced it. `RedirectInfo` needed `nativeNames: ['_RedirectInfo']` for
that: what the SDK hands back is the private implementation type, and without
the claim the value resolves to no bridge and is inert even once the name
exists.

`HttpDate` had no such excuse — nothing had registered it. It is two static
methods and no instances, and it is the only way a script can parse the three
RFC date formats `HttpHeaders` puts on the wire. Hand-rolling that in
interpreted Dart handles RFC-1123 and silently fails RFC-850 and asctime, so
the absence pushed scripts toward a worse implementation rather than toward a
workaround.

### Documented — `BadCertificateCallback` and `HttpOverrides` are unbridged by decision (scc65)

Both now carry a row in `doc/d4rt_limitations.md` and a reason in the error
message, so a script that names one reads a decision rather than a gap.

`BadCertificateCallback` is a `typedef`, not a class, and everything a script
does with it already works without the name: the
`HttpClient.badCertificateCallback` setter accepts a plain function value, and
the interpreter does not resolve type annotations at all, so the alias is
usable as an annotation whether or not anything defines it. A `BridgedClass`
would add exactly one thing — `x is BadCertificateCallback` — which is a
question about a function's shape that a bridge keyed on native type cannot
answer honestly.

`HttpOverrides.global` swaps the `HttpClient` implementation process-wide and
outlives the script that set it, so one sandboxed script would redirect every
subsequent HTTP call made by the host and by every other script. Unlike a
filesystem or network grant there is no granularity that makes it safe.

## 1.62.0

### Fixed — a type test no longer runs the function it is asked about (scc64)

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

## 1.61.0

### Added — WebSockets (scc63)

`WebSocket` and the four names around it were bridged nowhere, so a script had
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


## 1.60.0

### Fixed — a script could start an HTTP server but not answer a request (scc62)

`HttpServer` was bridged; `HttpRequest` and `HttpResponse` were not. So
`HttpServer.bind` succeeded, `server.listen` delivered a connection, and the
value the handler was handed had no bridge — every member on it failed with
`Cannot access property 'method' on target of type _HttpRequest`. The one path
by which a request can be answered ran through a name that did not resolve, and
the server bridge was unusable for the whole time it existed.

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

Pinned by a real loopback round trip in
`test/stdlib/io/http_server_test.dart` — the script is both server and client,
because driving the client from the host would need the port before the script
runs. The SCC24 getter sweep was widened to cover these bridges rather than have
its blind-spot baseline raised by four; it now stands a server up in `setUpAll`
to capture the four types that only exist inside a request handler.

**Note on the sandbox**: these bridges do not widen it — `HttpServer.bind` was
already bridged and reachable, so the new types only let a script *name* values
it was already being handed. Measuring that did surface a real and larger gap:
`NetworkPermission` gates exactly one call site in the library
(`InternetAddress.lookup`), while `bind`, `connect` and the whole `HttpClient`
surface sit behind an import gate keyed on `FilesystemPermission`. That is
tracked separately, because a partial gate added here would be bypassable via
`ServerSocket` + `HttpServer.listenOn` while looking like the capability was
sandboxed.

## 1.59.0

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

## 1.58.0

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

## 1.57.0

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

## 1.56.0

This section also covers the work released as **1.55.0**, whose heading
was renamed rather than added to when the version was bumped (ab944d4a2,
scc56). 1.55.0 was never published, so no release carries that number.

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
are on every hot path, so `test/stdlib/core/core_hierarchy_test.dart` reads
subtype-only members off both to prove nothing moved.

### Fixed — `first`, `last` and `single` on the dart:collection bridges now throw the SDK's `StateError` (scc51)

`<Set>{}.first`, `HashSet().single`, `ListQueue().last` and thirteen further
combinations threw a `RuntimeD4rtException` carrying a hand-written message
("Cannot get first from an empty queue."), where native Dart throws
`StateError`. A script written by a Dart author — `try { … } on StateError
catch (e) { … }` — therefore caught nothing, and the difference was invisible
from inside the collection bridges because they all agreed with each other.
Only `List` was correct, and only because its bridge never had a hand-written
copy: `<int>[].first` already reported `StateError`.

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
## 1.54.0

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

### Fixed — `EventSink` is registered as a subtype of `Sink` (scc49)

One line, independent of the above. SC4 registered the sink hierarchy as far
as `EventSink` because `Sink` was not what it was auditing, so `c.sink is
Sink` answered `false` for a value that plainly is one — worse than an
unresolvable name, because it looks like an answer. The hierarchy registry
closes transitively, so `StreamSink` and `StreamController` inherit the edge.

## 1.53.0

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

The damage surfaced in the declared-parameter check, which rejected a
perfectly correct call with `type 'Text' is not a subtype of type
'TextDirection' of 'dir'`. `getRuntimeType` now consults the bridged-enum
registry for any native `Enum` before falling through.

This is a narrow fix at the caller, not a repair of PASS B. The prefix
fallback still claims *unregistered* native types whose names collide with a
bridge name; narrowing it is tracked separately, since doing so needs
`nativeNames` declared on the bridges that currently rely on the loose match.

## 1.52.0

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

## 1.51.0

### Fixed — an unhandled AST node announces itself instead of answering null (scc33)

`InterpreterVisitor` never overrode `visitNode`, so a node type with no handler
fell through to `GeneralizingAstVisitor`'s default and the expression evaluated
to `null`. A gap in an *evaluating* visitor therefore produced a value rather
than a failure, and the program carried that value until something several
frames away could not take it.

**The cost is the diagnosis, not the null.** `#foo` was silently `null` for the
life of the project (fixed in 0.15.0 / SCB11), and the eventual error —
`type 'Null' is not a subtype of type 'Symbol' in type cast` — was raised inside
a *bridge*, which is the one place the defect was not. Every such gap accuses
the wrong component.

`visitNode` now raises a diagnostic naming the node's runtime type and source
offset. The sequencing was deliberate and is the reason this is safe to ship:
instrument the default to log rather than raise, run both suites, add handlers
for everything that legitimately arrived, and only then flip to raising.

**Flipping the default exposed two real defects**, because the inherited default
did not merely return `null` — it *recursed into the node's children*, and two
constructs depended on that recursion by accident. A named argument reached its
label and resolved it as a **variable**: `super(a: 7)` raised
`Undefined variable: a`, while `super(a: a)` appeared to work because a variable
of that name was in scope and the accidental lookup found the right value by the
wrong route. Every existing test wrote the forwarding spelling, which is exactly
why the suite never caught it.

`callable.dart` now **unwraps** a named argument rather than dispatching it.
Dispatching and then re-reading `arg.expression` would evaluate the argument
twice and run its side effects twice.

Measured, not assumed: zero unhandled nodes fire across this package's 2872
tests or `tom_d4rt_exec`'s 2745. Covered by `scc33_unhandled_node_test.dart`.

**Note for consumers.** A script that previously ran and produced a wrong value
may now raise. That is the point of the change, but it is a behavioural break in
the strict sense — if a script depended on an unhandled node yielding `null`, it
will now fail loudly. No such node fires in either suite.

## 1.50.0

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

## 1.49.0

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

## 1.48.0

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

## 1.47.0

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

## 1.46.0

### Changed — "member absent" is a type, not a sentence (scc28)

Member lookup failed by throwing `RuntimeD4rtException("Undefined property
'<name>' on <receiver>")`, and eight sites in the visitor then asked
`e.message.contains("Undefined property '$name'")` to decide between two
entirely different continuations: try extension-method resolution, or propagate
a failure that happened *inside* a member that does exist. **A formatted,
human-readable diagnostic was the control-flow signal**, so rewording it —
including a typo fix or a translation — silently disabled extension methods for
every receiver kind routed through the edited site. The analyzer cannot see
that, and the symptom is a wrong answer rather than a crash.

New in `exceptions.dart`: `UndefinedMemberD4rtException`, a
`RuntimeD4rtException` **subtype** carrying the absent member's name as a field.
Subtyping is what let this land site by site: every surrounding `on
RuntimeD4rtException` handler keeps catching, and `toString()` is inherited, so
the diagnostics are unchanged to the byte. Eleven raise sites now throw it and
eight decision sites ask `e is UndefinedMemberD4rtException && e.memberName ==
name` — an equality where the old code asked for a substring.

Also new: `rewrapPreservingMemberSignal`. Five sites add context to a
member-lookup failure on the way out by concatenating the original message.
Before this change they preserved the signal *by accident* — an outer
`contains(...)` matched straight through the wrap. Typing only the raise sites
would have lost the signal one frame out and reintroduced the very regression
this change removes, so the wrappers re-raise through the helper.

**Not a breaking change.** The new type is a subtype of what was thrown before
and carries the same message, so nothing that caught or printed these failures
moves. The point is that the message is now free to be reworded.

`scc28_typed_undefined_member_test.dart` guards it, and its primary case is a
**source scan** over both mirrored visitors rather than a behavioural
assertion: the property being protected is "no site decides this by reading
text", which is a property of the source. A behavioural test can only show that
the sites which exist today take the right branch today; it cannot notice a
ninth site added next month with a fresh `contains(...)`.

## 1.45.0

### Changed — an error keeps its type when it leaves `execute()` (scc27)

`execute()` ended in a catch-all that relabelled anything it did not recognise
as `RuntimeD4rtException('Unexpected error: $e')`. That message asserts an
interpreter bug — right for a stray internal failure, wrong for every failure a
script legitimately produces. Alongside it, a native callee's error arrived
wrapped in the `RuntimeD4rtException('Native error during …')` that the bridged
call site builds. `visitTryStatement` unwraps that wrapper, so a script's own
`catch` matched by type; the host boundary did not, so the same `catch` clause
written at the *call site* did not. **A script's errors became less catchable
the moment they crossed the boundary — that asymmetry was the bug.**

The boundary now states one rule. Anything that is an `Error` or an `Exception`
leaves as itself, with its original stack trace. Two things do not: a thrown
value in neither hierarchy — nothing in the SDK's vocabulary describes it, so
the caller gets a diagnostic rather than a bare `toString()` — and the
interpreter's own control-flow signals, since a `ReturnException` reaching a
host means a jump was lost, which *is* the interpreter bug the old label
described.

Two new symbols in `exceptions.dart` carry it: `throwAsHostFacingError`, which
every boundary site now calls, and `isInterpreterControlFlowSignal`, the
predicate naming the four carriers. The async path calls it too — an `async
main` reports through the returned future and never through the enclosing try,
so the two halves of the API had been relabelling differently.

**Removed: `isSdkShapedError`.** SCB10 carved four types out of the catch-all
(`AssertionError`, `TypeError`, `NoSuchMethodError`, `RangeError`) because
without it a failing `assert` would have reached the host as "Unexpected error:
Assertion failed". The carve-out was correct and left a boundary a reader could
not predict: four types escaped, everything else was relabelled. The general
rule subsumes the list, so the predicate is gone. Its four cases stay in
`scb10_sdk_shaped_errors_test.dart` as the regression guard.

**Breaking for a caller that matched on the wrapper.** `on RuntimeD4rtException`
around `execute()` no longer catches a failure the *script* or a *native callee*
produced; name the type instead. Eight cases in this suite asserted the old
shape and now name `ArgumentError`, `StateError`, `RangeError`, `IndexError` and
`FormatException` — each one reads better for it, because the assertion now says
what the test's own title always claimed. Errors the interpreter raises about
*itself* (`"No callable 'main' function found"`, arity violations) are
unaffected: a `RuntimeD4rtException` with no wrapped original still arrives as
itself.

## 1.44.1

### Changed — formatted the tree once, at the aligned language version (scc26)

Follows 1.44.0, which raised the SDK floor to the value pub already enforced.
The floor is what selects the formatter style, so the tree was still laid out in
the pre-3.7 style while its mirror twin `tom_d4rt_ast` was in the tall style.
Formatting once, here, is what actually closes the gap: from this point the
formatter is idempotent in both packages and running it is harmless.

The effect on the mirror is the point of the exercise. Across the 119 mirrored
stdlib files, divergence falls from 5012 lines to 670 — and the residue is
genuine content (the two trees use different AST types), not layout.
`stdlib/io/socket.dart` alone went from 1926 divergent lines to 23; its two
copies had been the same file, token for token, the whole time.

This commit contains the formatter's output and nothing else. That it is inert
was not assumed — `git diff -w` cannot establish it, because the tall style
*splits* lines and a whitespace-insensitive diff still counts a moved line
boundary as a change. What was checked instead is the token stream: strip all
whitespace and the two revisions of every changed file are either identical
(153 files) or identical once trailing commas are also stripped (893 files),
commas being pure formatting punctuation in Dart. Zero files carried an edit
that survived both passes.

## 1.44.0

### Changed — the declared SDK floor now matches the one pub can actually reach (scc26)

`environment.sdk` said `^3.5.0`. It could not have been true for some time:
`analyzer: ^10.0.0` resolves to 10.1.0/10.2.0, both of which declare
`sdk: ^3.9.0`, so no resolution of this package below 3.9 exists. The declared
floor was a promise nothing could honour, and it had a second, quieter cost.
`dart format` derives its style from the *language version*, and the formatter
switched to the tall style at 3.7 — a package pinned below that formats in the
old style, while `tom_d4rt_ast`, declaring `^3.10.4`, formats in the new one.
Two trees the workspace requires to stay line-comparable were therefore
guaranteed to diverge the moment anyone ran the formatter on either.

The floor is now `^3.9.0`: the value pub already enforces. Raising it changes
nothing for any consumer that resolves today.

Raising the language version surfaced two lint families the older version could
not report, both fixed here:

- **`unnecessary_underscores`** (23 sites) — wildcard parameters became legal at
  3.7, so the `__` / `___` spellings previously needed to avoid a name clash are
  redundant. `tom_d4rt_ast` already spells these `_`, so this is also a mirror
  convergence.
- **`curly_braces_in_flow_control_structures`** (8 sites) — braceless
  single-line `if`s that exceed the column limit. The tall formatter splits them
  across two lines, which is what makes the lint fire; bracing them first keeps
  the subsequent reformat free of behaviour-adjacent hunks.

No behaviour changes.

## 1.43.0

### Fixed — `listen(null)` now works on every bridge, not two of nine

`Stream.listen` declares its first parameter as `void Function(T)?`, so
subscribing for `onDone` / `onError` without wanting the data is ordinary Dart.
Nine bridges implement `listen`, and they had drifted far enough apart that the
same expression `x.listen(null)` produced three different outcomes depending on
where `x` came from:

| Bridge | Before |
| --- | --- |
| `Stream`, `Socket` | accepted — matches the SDK |
| `ServerSocket`, `RawSocket`, `RawServerSocket`, `RawDatagramSocket` | `type 'Null' is not a subtype of type 'InterpretedFunction'` |
| `Stdin`, `HttpServer`, `HttpClientResponse` | `listen requires an onData callback.` |

Neither of the two failing behaviours was designed. The cast error is an
internal crash leaking out of the interpreter rather than a diagnosable script
fault, and the exception is a restriction d4rt invented that the platform does
not have. No test pinned either, which is why they survived.

All nine now route through one `bridgedStreamListen`, which keeps the SDK's
contract. `socket.listen()` with no arguments is fixed in passing:
`io/socket.dart` indexed `positionalArgs[0]` unguarded, so it raised
`RangeError` instead of a script error.

Because every `listen` is one implementation, its `onError` wrapper goes through
`errorHandlerArgs` once. That helper is what lets a script's unary `(e)` handler
work alongside the binary `(e, st)` form — a fix that previously had to be
applied to fourteen sites by hand.

### Changed — one `runAction`, replacing four private copies

`_runAction` was copy-pasted into four stdlib files in two incompatible shapes:
`T? _runAction<T>` and `FutureOr<T> _runAction<T>`. They differ only for a null
function with a non-nullable `T`, where the `FutureOr` form throws and the
nullable form yields null. No call site depended on it — none of the 84 awaits
the result — so the merged helper takes the nullable form, which is strictly
less likely to throw. The copies also wrapped the call in
`try { … } catch (e) { rethrow; }`, which is a no-op; it is not reproduced.

Two guards keep the duplication from growing back: one fails when a private
`_runAction` reappears, the other when a `listen` adapter builds its own
callback wrappers. Both sweep `tom_d4rt` **and** `tom_d4rt_ast`, since the AST
tree has no parser and cannot run the behavioural cases itself.

## 1.42.0

### Fixed — bridge coverage gaps found by a mechanical sweep, not by accident

A `BridgedClass` claims the SDK's private implementation types by listing them
in `nativeNames`. A type that is not listed resolves to no bridge, so the value
comes back from the interpreter successfully and is then completely inert:
every member on it fails with "Undefined property or method 'x' on _Whatever".

The failure mode hides itself. A missing name does not merely break the value,
it suppresses the tests that would have exercised the code behind it — if
`Codec.inverted` cannot be used, nobody writes a test that uses it. The gap had
therefore been found four times by accident while working on something else,
never by a test.

`test/scc24_native_name_coverage_test.dart` replaces the accidents with a
check. `BridgedInstanceGetterAdapter` takes a nullable visitor, so every
instance getter on every registered bridge can be invoked directly against a
real native instance and the result handed to the resolver — several hundred
return values, with no knowledge of return types, no argument construction and
no private type name written down anywhere. Members that take arguments are
covered by explicit probe tables. No private name appears in the test: every
value is produced by an ordinary public call and the resolver is asked what
claims the result, so an SDK rename keeps the test working rather than breaking
it.

Its first run found eight unclaimed types across five bridges, all of which had
the predicted second-order effect — `Codec.inverted` had zero uses anywhere in
the suite, the general `Converter.fuse` path had none, and the suite's single
`File.openRead` call passed the result straight into `addStream` without ever
calling a member on it:

- `Iterator` — `_LinkedListIterator`, `_AllMatchesIterator` and
  `_TypedListIterator`. The last covers *every* typed list, so `.iterator` was
  a dead end on `Uint8List` and friends: exactly the buffers binary codecs and
  byte-buffer code handle most.
- `Converter` — `_FusedConverter` and `_JsonUtf8Decoder`. The bridge had no
  `nativeNames` at all, so `Converter.fuse` was unusable and only the
  `Codec`-level fuse had ever been tested.
- `Codec` — `_InvertedCodec`, what `Codec.inverted` returns.
- `Stream` — `_FileStream`, what `File.openRead()` returns.
- `OSError` — a *missing bridge*, not a missing name: four `dart:io` exception
  bridges expose an `osError` getter and two constructors accept an `OSError`,
  but the class itself was never registered, so `e.osError.errorCode` was
  unreachable. Now registered with `message`, `errorCode` and `noErrorCode`.

The check runs over `dart:core`, `dart:async`, `dart:collection`, `dart:convert`
and `dart:io` rather than the stream family alone, because the same enumeration
— and the same trap — exists in all of them.

## 1.41.0

### Added — `D4rt.onUncaughtError`, for errors that escape a callback

Some interpreted code is invoked by the *platform* rather than by the script:
the body of a `Stream.listen`, a `handleError` handler, a `Timer` callback. When
one of those throws, native Dart sends the error to the current `Zone` and lets
the enclosing `main()` return normally — and d4rt matched that, correctly.

The hole it left is that `Zone`, `runZoned` and `runZonedGuarded` are
deliberately unbridged, so an interpreted script had no way at all to observe
its own callback failing, and a host that only inspected `execute()`'s result
had none either. The failure was simply invisible from both sides:

```dart
final d4rt = D4rt();
d4rt.onUncaughtError = (error, stackTrace) {
  log.warning('script callback failed', error, stackTrace);
};

// Warns, then returns 'done' normally — as native Dart would.
await d4rt.execute(source: '''
  import 'dart:async';
  main() async {
    Timer(Duration.zero, () => throw StateError('late failure'));
    await Future.delayed(Duration(milliseconds: 10));
    return 'done';
  }
''');
```

The contract:

* **Only escapes reach the hook.** Anything that propagates through
  `execute()`'s return value or thrown exception stays on that path and is not
  also reported here.
* **The error is the value the script actually threw.** The interpreter's
  internal `InternalInterpreterD4rtException` wrapper is removed first, and a
  bridged exception is unwrapped to its native object, so this path agrees with
  the synchronous one. Previously an interpreter-internal type crossed the
  sandbox boundary and a host could not tell "the script threw" from "the
  platform threw".
* **A hook contains the error** — it is reported to the hook and not forwarded
  to the enclosing zone, which is what makes it usable as a sandbox boundary by
  a host running untrusted script. A hook that itself throws is not swallowed.
* **It is opt-in.** With no hook set, nothing changes.

Setting the hook makes d4rt own the *error zone* for the execution, and that is
a real change to an embedder's error routing — which is why it is opt-in and
why d4rt does not fork a zone otherwise. A zone specifying `handleUncaughtError`
*is* a new error zone, and Dart refuses to carry an error across an error-zone
boundary; forking unconditionally would stop an ordinary script failure from
ever reaching the caller of `execute()`.

The fix sits at the one execution chokepoint rather than in each stdlib adapter,
so it covers every interpreted callback the platform invokes — not just the
`Stream.listen` case that surfaced it.

Also verified in the same pass, and *not* a defect: `Stream.listen`'s onError
and `Stream.handleError` deliver the same error object to a script. The
asymmetry between them was in the escape direction only, and is now gone.

## 1.40.0

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
statement always worked. Pinned by F-SCC22-13..17.

### Tested — the nine `dart:io` error-handler arity sites SCB9 left unasserted

SCB9 routed all 15 error-handler adapters through `errorHandlerArgs` but could
only assert the 6 async ones; the 9 io sites were left "verified by
construction". `test/scc22_io_error_handler_arity_test.dart` closes that, and
the split is measured rather than assumed:

- Three sites are reachable from a script and get the full unary / binary /
  optional-second-parameter trio against a real loopback connection.
  `Socket.listen` and `Socket.handleError` are driven by a server that accepts a
  connection and immediately destroys it, so the next write fails with a broken
  pipe; `HttpClientResponse.listen` by a server that promises 100 bytes and
  sends 5.
- Six are not reachable, each for a stated reason: `ServerSocket.listen`,
  `RawServerSocket.listen` and `HttpServer.listen` carry accept-side OS failures
  a test cannot induce; `RawSocket.listen` reports peer loss as a
  `RawSocketEvent.readClosed` *data* event rather than an error;
  `RawDatagramSocket.listen` would need an ICMP unreachable surfaced as one;
  `Stdin.listen` needs a terminal. These are guarded structurally instead —
  F-SCC22-10 asserts the hardcoded `[error, stackTrace]` pair appears nowhere
  but inside the helper, and F-SCC22-11/12 assert the full 15-site map,
  identically in both trees.

The structural guard is a better instrument for the regression actually at risk
(a future adapter reintroducing the hardcoded pair) than six socket tests would
be, and it does not go flaky on a loaded machine.

No permissioned-io harness had to be built for any of this: `executeAsync`
already grants `NetworkPermission.any`, and `stdlib/io/socket_test.dart` already
binds loopback servers.

SCB9's header claimed 14 sites. It is 15 — `async/stream.dart` has three, not
two, and had three in the SCB9 commit itself. The undercount was in the prose
enumeration only; the fix always covered all 15. Corrected, and the count is now
asserted rather than restated.

## 1.39.0

### Fixed — `on T` in a catch clause answered a smaller question than `x is T`

The catch clause carried its own type test: a flat switch over sixteen hardcoded
type names plus a bridge-identity probe. It was never a copy of the `is`
operator's predicate — it was a *smaller* one, and four of the differences were
user-visible bugs, two of them in the dangerous direction:

- `on Exception` and `on Error` did not catch a script class declared
  `implements Exception` / `implements Error`. The switch asked the host `is`
  about the native object, which says nothing about an interpreted class.
- **`on List<int>` caught a `List<String>`**, and `on Box<int>` caught a
  `Box<String>`. Type arguments on the catch type were discarded, so the handler
  ran with a value of the wrong type bound to its parameter.
- `on int Function(int)` and `on (int, String)` were rejected as "unsupported
  type nodes" and never matched.
- A prefixed `on c.HashSet` never resolved.

`on T` now asks exactly the question `x is T` asks, through the same
`_valueHasType` predicate that `is`, declared-type checks and typed patterns
use. One deliberate asymmetry is kept and commented: an unresolvable `on T`
MISSES rather than throwing, so a failed type lookup cannot replace the
exception being dispatched.

### Fixed — no bridged exception was an `Exception`

`FormatException('x') is Exception` answered `false`, and so did the same
question about `TimeoutException`, `SocketException`, `FileSystemException` and
every other bridged exception. The error side of `dart:core` has declared its
supertype edges since RC-7; the exception side had none at all.

Nothing noticed because the one place scripts ask it most — `on Exception catch
(e)` — did not go through the type test. It had its own arm reading the native
object directly, which is right for a native operand and silent about a bridged
one. Removing that arm surfaced the gap immediately. `ExceptionHierarchyCore`
now declares the chain, each edge once as the SDK declares it. These are
registry edges only: no `isAssignable` is added to `Exception`, because that
would make the root steal member dispatch from its own subtypes.

## 1.38.0

### Fixed — a type test stopped two levels up the supertype chain

`BridgedClass.isSubtypeOf` consulted the supertype registry for a class's direct
supertypes and ONE further hop, then gave up. A bridge three levels deep
therefore answered `false` to an `is` against its own root — while the MEMBER
walk, reading the same registry through `transitiveSupertypeNames`, went all the
way down. So a class could resolve its inherited methods correctly and deny
being a subtype of the interface it inherited them from, which is the failure
mode hardest to spot by reading the registry.

The predicate now delegates to `transitiveSupertypeNames`, so the two mechanisms
answer at the same depth. The direct-supertype hit is kept as a short circuit.

**The stdlib hierarchy blocks were flattened to work around this, and are no
longer.** Every edge in `CollectionHierarchyCollection` and
`ConvertHierarchyConvert` used to be written as a full transitive closure —
`'JsonEncoder': ['Converter', 'StreamTransformerBase', 'StreamTransformer']` for
a class the SDK declares as `implements Converter`. Each is now declared once,
mirroring the SDK. This is closure-preserving, so nothing outside
`bridged_types.dart` can observe it: every other consumer already read the
registry through the transitive walk.

`transitiveSupertypeNames` is now memoised, dropped wholesale on
`registerSupertypes`. The closure is read on every `is` and every `catch` once
`isSubtypeOf` consults it, and recomputing it allocates three collections per
query — measured at 0.379us against 0.057us for the old short circuit. With the
cache a miss costs 0.056us, so the fix carries no hot-path regression, and deep
hits — which used to be *wrong* — cost 0.054us.

## 1.37.0

### Fixed — a typed pattern never checked its type, so the first arm of every switch won

`case int _` accepted a String. So did `case Map m`, `int _ =>` in a switch
expression, and `if (x case int _)`. The consequence was not subtle and was not
confined to bridged types: **the first arm of any switch statement, switch
expression or if-case was selected regardless of the scrutinee**, for `int` and
`String` exactly as much as for a `dart:collection` value.

The two branches of `_matchAndBind` that handle these shapes —
`DeclaredVariablePattern` (`int x`) and `WildcardPattern` (`int _`) — read only
`pattern.name`. Neither ever touched `pattern.type`, so neither had any code
path that could signal a mismatch. Both now call `_requireDeclaredType`, which
is a no-op for an untyped `var x` / `_` (irrefutable, as the language says) and
otherwise throws the same non-match signal the other branches use.

**Why ~2270 green tests said nothing about it.** Constant patterns compare, and
destructuring patterns fail to destructure and throw, so both report a non-match
correctly — and every pattern test in the corpus exercised an arm that was
*meant* to match. A suite that only ever asks "does the right arm win" cannot
see a matcher that says yes to everything. The new
`test/scc18_typed_pattern_type_test.dart` is therefore twelve *negative* cases,
one per pattern context, because a thirteenth positive one would have added
nothing.

### Fixed — object patterns matched anything whose type name merely resolved

`case int()` matched the String `'s'`, and `int(isEven: true)` reported `2` as
odd. The object-pattern branch carried its own type test — a name-equality walk
over the class hierarchy, a hardcoded ladder for seven builtins, an
`actualTypeName.endsWith(expectedTypeName)` heuristic, and a final fallback that
declared a match whenever the *name* resolved to some `RuntimeType`. That last
clause is the one that made `int()` match a String: `int` resolves, so it
answered yes without looking at the value.

Field extraction had a matching gap. `int(isEven: true)` reached neither the
`InterpretedInstance` branch nor the `Map` branch and failed with "field access
is not supported"; a native operand now reads its member through its bridge —
getter adapter, then the registered supertype walk — which is the route
`value.isEven` already takes in an expression, so the two cannot disagree.

### Changed — one type-test predicate instead of four

SCB7 measured that "does this value have this type" was implemented three times
independently, and paid for it: its unwrap fix reached the `is` operator, missed
the catch clause, and needed a second edit and a second test. The object-pattern
copy above was a fourth.

`visitIsExpression`'s body is now `_valueHasType(TypeAnnotation, Object?)`, and
the `is` operator, typed patterns and object patterns all call it. This is
deliberately not the whole of the extraction SCC20 describes — the catch-clause
copy is untouched — but it is the sequencing that todo asks for: fix the missing
call first, so the refactor arrives with all its call sites already present
rather than two of them.

One behavioural change falls out of it. `is!` against a `Type`-valued native
returned early from `visitIsExpression` and so silently answered the *un-negated*
result; returning from the predicate instead lets the caller apply the negation.

## 1.36.0

### The stdlib member-gap audit is now a standing test

The 231 unreachable stdlib members this audit has found accumulated over months
for exactly one reason: nothing failed when they appeared. A tool that has to be
remembered measures the past, not the present — so
`test/stdlib/member_coverage_baseline_test.dart` now performs the full two-phase
audit on every suite run and compares it against the checked-in baseline
`test/stdlib/member_coverage_baseline.dart`.

**It reuses the tool rather than reimplementing it.** `stdlib_member_diff.dart`
grew two entry points, `collectMemberDiffs` and `verifyAll`, which both the CLI
and the test call; a test that walked the bridged classes itself could disagree
with the tool about what a candidate even *is*, which is this audit's own failure
mode reproduced one level up. A new `--baseline` mode writes the generated file.
The run is verified, not candidates-only, because removing a supertype edge flips
members from `reachable` to `confirmed` — an event phase 2 catches and a
candidate baseline cannot see at all. That costs ~7 seconds standalone and ~1
second under `dart test`, which is what makes it affordable per-suite; the tool's
former "a few minutes" stderr claim was wrong.

**Four tests, split by remedy.** A single "matches the baseline" assertion cannot
tell a regression from an improvement, so it teaches people to regenerate
reflexively — and a guard people regenerate without reading is decorative.
`F-SCC13-1` fires when a member that used to be reachable is not any more (fix
the bridge); `F-SCC13-2` when a recipe stopped producing an instance or a bridged
class vanished entirely (fix the recipe, or record a platform reason);
`F-SCC13-3` when the baseline no longer describes reality (regenerate it) — and
that one can only be provoked by good news, so the reflex is safe to have.

**`F-SCC13-0` exists because an empty measurement agrees with any baseline.**
Probes run in spawned isolates and a probe that cannot answer is scored "not
measured", so a run where spawning failed finds zero gaps and passes. Measured
with the probe timeout at 1 µs: two of the four tests passed on a run that
learned nothing. `F-SCC13-0` pins floors on how much was examined and measured,
and those floors live in the test rather than the generated file so a bad
regeneration cannot lower them.

**Each guard has been watched fail** — deleting the `DateTime.year` adapter,
breaking its recipe, un-bridging a baselined class, and closing a baselined gap
each fire exactly one expected test. That exercise found a real defect in the
guard: the staleness check originally looked only for `reachable`, but adding a
missing adapter removes the member from the candidate set altogether, so the
*ordinary* way a gap closes went unreported.

The ~378 members reachable only via the supertype fallback are deliberately not
pinned: one going bad presents as "confirmed and absent from the baseline"
either way, so pinning them would triple the file with names that carry no
finding.

## 1.35.0

### Fixed — `await` inside a `finally`, and the exception that a `finally` swallowed

Three defects in one region, found while extending the stdlib gap oracle rather
than from a bug report. The oracle needs to acquire a live resource, read one
member off it and release it again, so every one of its `dart:io` recipes is
shaped `try { read } finally { await release; }` — which turns out to be the
one shape the interpreter got wrong in three independent ways.

**An `await` in a `finally` block never completed.** The interpreter drives
`await` by *replay*: `visitAwaitExpression` returns a suspension sentinel rather
than blocking, every statement visitor propagates it upwards as its own value,
and the async driver awaits the future and re-executes the body. A visitor that
discards a sub-visit's value therefore swallows the suspension — the driver
never learns there is a future to wait for. `visitTryStatement` discarded
exactly one such value, the finally block's, so `await` in a try body worked and
`await` in a catch body worked and the defect was invisible from every direction
except the one the oracle needed. The same statement now also returns a
suspension raised by the *protected region* without running the finally, so a
teardown does not run once on the suspending pass and again on the resuming one.

**Inside an async function a suspending `finally` looped for ever.** An async
function does not run `visitTryStatement` at all — a statement-level state
machine decomposes the try so that any statement may suspend. Its resumption
callback runs after the loop has already restored `visitor.currentAsyncState`,
so it acted on behalf of a state the visitor could no longer see; a finally
whose *last* statement was an `await` never un-marked its enclosing try, and the
`return` that followed was diverted back into the finally, for ever. The
callback now re-asserts the invariant it depends on.

**An exception thrown inside `try { … } finally { … }` vanished.** With no catch
clause the machine jumped to the finally leaving the error in `currentError` — a
field the main loop clears after every statement that completes normally, so the
finally's first statement erased it and the enclosing `catch` never ran. Errors
that are only *passing through* a finally are now held in a dedicated field and
re-raised, from outside the try, once the block ends. Relatedly, the search for a
handler walked out exactly one level: a try with neither a catch nor a non-empty
finally is not a handler, and the search now continues past it instead of
propagating straight to the function's Future.

The last of these was corrupting a measurement, not merely hanging a tool. The
audit reads every candidate member as `try { probed = o.member; } finally { await
o.close(); }`, so for each async recipe a **missing** member was silently
reported as present — the exact failure mode the three-bucket design exists to
prevent.

### Fixed — `ServerSocket.bind` rejecting an `InternetAddress`

The adapter `toString()`-ed its host argument, which is correct for a `String`
and wrong for the `InternetAddress` the SDK signature also accepts: the address
arrived as `InternetAddress('127.0.0.1')` and the bind failed. It is now passed
through unchanged.

### Changed — the member-diff oracle measures the `dart:io` surface

`tool/stdlib_member_diff.dart` gained a generalised recipe model (prelude,
`await`-ed construction, teardown clause) and ~22 recipes covering the live
`dart:io` and `dart:isolate` types, plus a `_notAuditable` table so an entry
that genuinely cannot be measured records *why*. The unverified bucket falls
from 280 to 37, and all 37 carry a stated reason — the "no recipe yet" half,
the half that hides gaps, is empty.

The confirmed-gap count consequently rises from **3 to 231** with nothing
un-bridged: 228 members that no run had ever executed were measured for the
first time and were already unreachable. 219 of them are the `Stream`
combinator surface on the seven `dart:io` / `dart:isolate` types that are
streams. See `doc/stdlib_sdk_gap_audit.md`.

## 1.34.0

### Added — the seven static argument-validation helpers

`RangeError.checkNotNegative` / `checkValidIndex` / `checkValidRange` /
`checkValueInInterval`, `ArgumentError.checkNotNull`, `IndexError.check` and
`Error.throwWithStackTrace`. These are how idiomatic Dart validates arguments, so
a script porting real code reaches them on its first function — and because
statics get no fallback from the interpreter, every one was a hard failure rather
than a degraded behaviour. `ArgumentError`, `RangeError` and `IndexError` had no
`staticMethods` map at all; each gained one.

Throwing is these helpers' normal behaviour, so the value they throw matters as
much as the value they return: letting the native helper raise is what makes an
interpreted `on RangeError` clause match. `IndexError.check` is the one shape
worth reading twice — its optional arguments are *named*, unlike every
`RangeError.check*` sibling, so reading them positionally would compile and then
silently discard every diagnostic the caller supplied.

### Fixed — a bridged throw no longer loses its stack trace

`Error.throwWithStackTrace` exists solely to rethrow while keeping an *earlier*
trace, and it could not do that. Every bridged-adapter wrap site recovers the
thrown value but constructed the `RuntimeD4rtException` inside the interpreter's
own `catch`, so `visitTryStatement` handed the script the trace of the wrap site
rather than of the throw. The member would have been present and inert.

`RuntimeD4rtException` now carries `originalStackTrace` beside
`originalException`, 28 wrap sites pass it, and `visitTryStatement` prefers it
over its own. `wrapDirectiveError` forwards it too — that function reconstructs
the exception rather than mutating it, so anything it forgets to copy is lost,
and a bridged throw inside an imported module is where the trace is worth most.
Three sites bind only `catch (e)` and are unchanged: there is no trace there to
preserve.

This is not confined to the new member. Any script that printed a trace from a
bridged throw was being shown interpreter internals — including from the most
travelled site of all, the bridged instance-method call.

### Added — the `castFrom` family

`Iterable.castFrom`, `Map.castFrom`, `Set.castFrom` and `Converter.castFrom`
(`Queue.castFrom` landed in 1.33.0). `Converter` and `LineSplitter` had no
`staticMethods` map and gained one.

`Set.castFrom`'s optional `newSet` argument is **rejected rather than ignored**:
it is a generic function (`Set<R> Function<R>()`), a value interpreted code
cannot construct, and silently dropping it would hand back a view over the wrong
set implementation.

Two of these exposed a gap the member diff cannot see — a correctly registered
static whose SDK *return type* reaches no bridge. `Iterable.castFrom` returns
`_EfficientLengthCastIterable` whenever the source reports its length cheaply
(the common case), and `LineSplitter.split` returns `_LineSplitIterable`; neither
was in `IterableCore.nativeNames`, so `.length` / `.toList()` raised on a value
the adapter had produced correctly. Both names are now claimed.

### Added — the static and instance long tail

`Enum.compareByIndex` / `compareByName`, `Symbol.empty` / `unaryMinus`,
`ProcessStartMode.values`, `String.matchAsPrefix`, `LineSplitter.split`,
`Iterable.iterableToShortString` / `iterableToFullString`,
`StreamSubscription.asFuture`, `ProcessSignal.signalNumber` and
`InternetAddressType.name`.

The enum comparators are the ones with a design decision in them. Three
representations of an enum value reach the interpreter — a native `Enum`, a
`BridgedEnumValue`, and an `InterpretedEnumValue` for an enum the script itself
declared — and the two wrapper classes share no common enum interface. Writing
`positionalArgs[0] as Enum` would compile and then reject precisely the enums a
script is most likely to declare and then compare. The comparators read the
`index` / `name` that all three can answer: the bridge must not refuse what Dart
accepts, and must not accept what Dart refuses.

`String.matchAsPrefix` is worth one note: the receiver is the *pattern* and the
string being searched is the *argument*. Reading it the other way round produces
a bridge that compiles and matches nothing.

`ProcessStartMode` got `values` as a **static** getter and `toString()` as its
only instance member, because it is *not* a Dart `enum` — it is a final class
with static const instances, so it has no `name` and no `index`. The same is true
of `ProcessSignal`, `FileSystemEntityType`, `InternetAddressType`, `FileMode` and
`SocketDirection`: `x is Enum` is false for every one of them. Synthesising a
`name` would let a script write something the SDK rejects.

### Fixed — the gap oracle no longer reports two kinds of phantom gap

`tool/stdlib_member_diff.dart` reported `unawaited` and
`FileSystemEntityType.NOT_FOUND` as unreachable members. Neither is a gap:
`unawaited` is a top-level *function* whose bridge carries `nativeType:
Function`, so its `Function` class surface was being diffed, and `NOT_FOUND` is a
deprecated SDK alias for the live `notFound`. Registering either would have
produced a member that exports and analyses cleanly and is wrong.

Both are suppressed at the category level. The deprecation filter reads the
`@Deprecated` annotation rather than a name list, so the next alias the SDK
retires drops out on its own instead of arriving as a fresh phantom gap — and it
was verified by negative control, not by a green run: it removes exactly
`NOT_FOUND` and keeps the live `notFound`.

**Member-level gaps now stand at 3 confirmed in 1 class**, down from 28 across
19. All three are `ByteBuffer`'s SIMD views, which are a deliberate boundary
rather than a missing registration — so every non-boundary confirmed member gap
in the stdlib corpus is closed.

## 1.33.0

### Added — `bool` implements `&`, `|`, `^` and their compound forms

Dart declares `& | ^` on `bool` as well as on `int`. They are the
non-short-circuiting siblings of `&& ||`, and the only form that expresses
"evaluate both operands regardless" — which is precisely why `&&` cannot stand in
for them. `flagA & sideEffectingCheck()` threw `Unsupported binary operator
"AMPERSAND"`, and `flagA &= …` threw the distinct `Compound assignment operator
AMPERSAND_EQ`: two dispatch sites, two messages, two fixes. Both are now
implemented for `bool` operands at both sites.

Non-short-circuit evaluation comes for free — the interpreter evaluates both
operands before reaching the binary switch — and is now pinned by a test, so a
future "simplification" into `&&` cannot pass silently. Only `bool`-`bool` is
accepted: `true & 1` is a type error in Dart and remains one here.

### Added — `Queue`'s own surface, and with it `ListQueue`'s

`Queue.remove`, `removeWhere`, `retainWhere` and the static `Queue.castFrom`
were absent. These are exactly the members `Queue` declares itself; everything
else on it arrives through its `-> Iterable` supertype edge, which is why the
gap had this precise shape. Registering the three mutators on `Queue` also
closed the same two gaps on `ListQueue`, which declares a `-> Queue` edge and so
inherits them — `list_queue.dart` needed no change. `castFrom` had to be written
on `Queue` regardless, because statics are never inherited and no supertype edge
can deliver one.

### Fixed — `SplayTreeMap.firstKey()` on an empty map returns `null`, not a throw

`firstKey()` and `lastKey()` are declared `K?` in the SDK and return `null` when
there is no such key. Both bridges hand-threw `RuntimeD4rtException("Map is
empty")` instead, so the idiomatic `if (m.firstKey() == null)` worked as Dart and
died under d4rt. The invented guards are gone.

`I-COLL-78` asserted the throw, which is why the guard survived every green run
for as long as it existed. **The test's premise was wrong about Dart**, so the
case now asserts `null` — a correction of the specification, not a loosened
assertion.

### Added — `SplayTreeMap.firstKeyAfter` and `lastKeyBefore`

The type's distinguishing ordered-navigation pair. Both return `null` when there
is no greater/lesser key, matching the SDK.

### Changed — `tool/stdlib_member_diff.dart` verifies operators and universals

The gap oracle diverted operator and universal `Object` members out of the
candidate list *before* interpreter verification, and excluded them from the
confirmed count. Those two columns therefore carried unchecked map-diff output,
and no published number could move when one held a real defect — which is how
`bool`'s missing operators stayed invisible. Both columns are now verified and
counted.

Three changes were needed together: an `_operatorProbes` table (operators cannot
be read as `o.+`, so they are driven as expressions), the operator error wordings
added to the unreachable-message matcher, and instance recipes for the primitives
(`bool`, `int`, `double`, `num`, `BigInt`) which had none — leaving the column
UNVERIFIED for exactly the classes whose operators matter most. `==` is routed to
the operator probe rather than the member read, whose `o.==` does not parse.
Unverified operators fell from 19 to 2.

The corrected totals: 610 raw candidates, 365 reachable via fallback, 284
unverified, **28 confirmed unreachable across 19 classes** (was published as 36
across 22).

## 1.32.0

### Fixed — a list literal is now a valid argument to a typed-data list member

`Float32List.setAll(0, [7.0, 8.0])` used to throw

```
type 'List<Object?>' is not a subtype of type 'Iterable<double>' in type cast
```

even though both elements really were `double`. d4rt evaluates a list literal to
`List<Object?>` — the element types are erased — and the typed-data adapters
narrowed their argument with a bare `positionalArgs[n] as Iterable<E>`. The cast
is about the list's *type argument*, not its contents, so it failed on every
literal while passing on a typed-data argument
(`l.setAll(0, Float32List.fromList([7.0, 8.0]))`). That asymmetry is why the bug
survived: the natural spot-check uses the typed form.

Affected on all eleven variants: `followedBy`, `setAll`, `setRange` and
`operator+`; additionally on `Uint8List`, which hand-rolls its whole adapter map,
`addAll`, `insertAll` and `replaceRange`. A single `coerceElements<E>` helper in
`inherited_list_methods.dart` now unwraps the container and any
`BridgedInstance` elements at all 28 call sites. It widens nothing — an element
whose type genuinely does not match still fails, so `Float32List.setAll(0, [7,
8])` remains the type error it is in Dart.

`operator+` needed a second fix, one level up: the interpreter's `List + List`
fast path in `visitBinaryExpression` handed the right operand to the SDK
unchanged, and `List.+` demands `List<E>` for the *receiver's* element type. It
now concatenates element-wise, which builds the result in the receiver's own
element type and still rejects an element that does not fit.

### Fixed — fixed-length typed lists raise a *catchable* `UnsupportedError`

The same cast had a second, quieter consequence. A script that guards a
fixed-length list defensively writes

```dart
try { list.addAll(more); } on UnsupportedError { /* recover */ }
```

and on `Uint8List` the failed cast threw *before* the native call, so the
`UnsupportedError` the SDK would have raised never happened and the recovery path
was never taken — the script died instead. Three members were affected
(`addAll`, `insertAll`, `replaceRange`) and only on `Uint8List`; the other ten
variants do not declare them and so reach the native list through the `-> List`
supertype edge, which was already correct.

`F-SCB3-18` used to assert only that `add` on one variant threw *something*,
which passes just as happily when the error is a `RuntimeD4rtException` or a
`_TypeError`. It now covers all eleven variants and all twelve length-changing
operations and asserts the error *type*, and each call is written to genuinely
force the length change — `ListMixin` short-circuits `remove` on an absent
element, `addAll([])` and a `removeWhere` that removes nothing before it ever
reaches the length setter, so a careless call passes on a broken bridge.

## 1.31.0

### Added — `LinkedList.addAll` and `LinkedList.addFirst`

These were the last two members of `LinkedList` a script could not reach. They
are also the only two it *had* to be given by hand: everything else on the class
— all 25 members from `map` and `where` down to `iterator` and `toList` — is
inherited from `Iterable` and became reachable when
`CollectionHierarchyCollection` declared the `LinkedList -> Iterable` edge. What
survives a supertype edge is exactly the set of members the class declares
itself, and for `LinkedList` that set was `addAll` and `addFirst`.

`addAll` validates and materialises its argument **before** linking anything,
which matters for two reasons that both come from the argument being lazy:

- `LinkedList.addAll` links each entry as it walks, so an iterable derived from
  the same list would mutate what it is iterating.
- A bad element part way in would otherwise leave a half-applied `addAll` — some
  entries linked, some not. No program the Dart compiler accepts can reach that
  state, since it rejects a non-`LinkedListEntry` element statically, so
  validating up front costs nothing and removes the state here too.

### Removed — `LinkedList.removeFirst`, which Dart's `LinkedList` does not have

**This is a script-visible break.** A script calling `list.removeFirst()` now
gets a `NoSuchMethodError` where it previously worked. That is the point: the
member does not exist on `LinkedList` in Dart — `Queue` has it, which is where
the expectation comes from — so every script using it ran here and would not
compile as Dart. Bridging a member the SDK lacks is the one class of bridge
defect no passing test can catch, because it makes the wrong script green.

The portable replacement is one call:

```dart
list.first.unlink();   // instead of list.removeFirst()
```

`unlink()` is what `dart:collection` documents for detaching an entry, and it
was already bridged, so the migration is mechanical and needs no new API.

Because a deletion cannot be protected by an assertion that passes, the absence
is pinned by one that fails on reinstatement: `F-SCC8-5` in
`test/stdlib/collection/linked_list_test.dart` asserts the `NoSuchMethodError`.
`I-COLL-42` continues to assert the same head-removal behaviour it always did,
now through `list.first.unlink()`.

### Documentation — the gap audit's measured state, and what `extraBridged` means

`doc/stdlib_sdk_gap_audit.md` was re-measured (2026-09-04): **36 confirmed
unreachable members across 22 classes**, down from the 163 across 38 the table
carried, with `LinkedList` gone from it entirely. Most of that fall is edges
rather than adapters — 315 of 616 raw candidates now resolve through instance
fallback, and the 120 typed-list length mutators reach the native fixed-length
list and raise the SDK's `UnsupportedError`, which a script can catch.

The audit also gained a section on the diff's other direction. `extraBridged` is
**not** a defect list: of its 32 entries, 15 are real Dart *extension* members
the mirror-based oracle structurally cannot see (`firstOrNull`, `indexed`,
`Enum.name`, `Future.ignore`, …) and 13 are conveniences commented as deliberate
at their definition. Four are genuinely fabricated —
`InternetAddressType.host`/`address`/`type`/`lookup`, wired to unrelated `Object`
members, so `type.address` returns a hash code — and are recorded there as an
open finding.

## 1.30.1

Name resolution: yes — platform-library precedence, so a `dart:*` name no longer makes a package name ambiguous.

### Fixed — a `dart:*` declaration no longer makes a package declaration's bare name ambiguous

1.27.0 (tcca19) made two same-named bridged classes reject the bare name instead
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
declares a `TextStyle`, so under the 1.27.0 rule d4rt rejected the reference:

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
and survival across an `importEnvironment`.

## 1.30.0

Four stdlib findings from the SDK gap audit. One adds bridged API, two change
what a failing call reports, and one is documentation.

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
positional is genuinely required, unlike the default constructor's
`reviver:` named argument — so it rejects both absence and null.

`JsonEncoder.indent` is now exposed too; the bridge shipped with `getters: {}`,
so a script could build an indented encoder and then not ask what its indent
was. The rest of `dart:convert` was swept and found already correct
(`Base64Codec.urlSafe`, `Base64Encoder.urlSafe`, `Utf8Codec(allowMalformed:)`,
`HtmlEscape(mode)` all honour their parameters), but three of those had no test
at all, so they gain a regression net.

### Fixed — `dart:io` silently narrowed `StringSink` (SCB26)

`StringSink` was registered twice: `StringSinkCore` from the core registrar and
`StringSinkIo` from the io registrar. `CoreStdlib` registers eagerly at
construction while `IoStdlib` registers lazily on a `dart:io` import, so the io
copy always landed second and displaced the core one under last-wins — and the
two had drifted, with the io copy a strict subset. **Importing `dart:io`
therefore removed `toString`, `hashCode` and `runtimeType` from `StringSink`.**
Because both definitions declared `nativeType: StringSink`, the collision
machinery read it as a benign re-export and never marked the name ambiguous, so
the loss surfaced only as a `Logger.warn`.

`dart:io` does not declare `StringSink` — it re-exports the `dart:core` one — so
the io definition is deleted rather than re-pointed at core's. `StringSinkIo`
had exactly one consumer (the io barrel, which is not re-exported from
`d4rt.dart`), so this is not a public API break.

### Fixed — wrong-arity bridge calls report the member, not a `RangeError` (SCB28)

Calling a hand-written stdlib bridge with too few arguments surfaced a bare list
`RangeError` naming neither the class nor the member:

```
UriData.parse()
-> Native error during static bridged method call 'parse' on UriData:
   RangeError (length): Invalid value: Valid value range is empty: 0
```

A scanner over both trees measured the scope before fixing it: **601 of the 1203
adapters that index `positionalArgs` do so with no leading length check**, spread
over 53 files, and the two trees agree to the adapter. Writing that guard out by
hand would have been ~1200 copies of the same three lines, so the too-few half is
recognised generically instead. `D4.describeArityError` matches the exact field
layout Dart's `List.[]` produces for an out-of-range read on a list of the
argument count's length and restates it as:

```
DateTime.parse expects at least 1 positional argument, but was called with 0.
```

It is consulted from the nine dispatch catch-alls that receive a
script-controlled argument list. A native `RangeError` from *inside* the call —
`sublist(0, 99)` — fails the shape test and passes through untouched.

**Too many arguments cannot be caught generically**: the dispatcher holds no
arity metadata for an adapter, so the call succeeds and the extra argument is
discarded. That stays a per-adapter guard. `UriData` is guarded here in full;
the remaining 52 files are filed with the measurement rather than half-swept.

### Changed — an unbridged name says why it is unbridged (SCB30)

`Undefined variable: Zone` told you the name did not resolve but not that its
absence was a decision, so the next step was to guess whether it was a bug, a
typo, or deliberate. A lookup miss on one of the 25 names that
`doc/d4rt_limitations.md` documents as intentionally unbridged now appends the
reason:

```
Undefined variable: Zone (not bridged: zones intercept the control flow,
scheduling and error handling the interpreter owns, so a bridged Zone would be
a no-op shell; see doc/d4rt_limitations.md)
```

**The `Undefined variable: <name>` prefix is unchanged**, so existing matchers
and consumers that test for it are unaffected; an ordinary typo still gets the
bare message. Names absent for no documented reason are untouched.

This reaches lookup failures only. A missing *member* on a class that IS
bridged — `ByteBuffer.asFloat32x4List` — fails one layer deeper as
`D4rtNoSuchMethodError` and still carries no reason.

### Documentation

`doc/stdlib_sdk_gap_audit.md` now gives every row an explicit disposition
(bridged / deferred with a reason / intentionally out of scope) rather than
leaving unmarked rows to be re-triaged, and the SIMD block is reconciled with
`doc/d4rt_limitations.md` (SCB29).

## 1.29.0

### Fixed — the stdlib on-type probe was still reported as an error (tccc5)

1.28.0 fixed the on-type probe that runs *before* the stdlib fallback. The probe
*inside* it is a second call site with the same defect, and it is the noisier of
the two: `_resolveTypeForExtension` registers one stdlib module at a time and
asks whether the on-type has appeared, so every module that does not carry it
misses by construction, and an on-type that resolves nowhere misses in all of
them. It used the throwing `Environment.get` inside a `try`/`on
RuntimeD4rtException` that discarded the exception — but constructing one
already registers it with the `ErrorReporter`, so each miss left an `Undefined
variable: <Type>` behind.

An unresolvable on-type is not a runtime error: the loader's contract is to warn
and skip the extension (and, under `validateRegistrations`, return one collected
message). Importing a bridge library whose on-type is not itself bridged — a
crypto package's `Digest` — was therefore enough to fail a REPL `-test` run with
four errors while every assertion in it passed.

The probe now uses the non-throwing `Environment.lookup` and the `try`/`catch`
is gone: there is no longer an exception to swallow.

## 1.28.0

### Fixed — a handled on-type lookup miss was still reported as an error (tccc5)

Registering a bridged extension probes the target environment for its on-type,
and falls back to `_resolveTypeForExtension` when the importing script has not
also imported the on-type's own library. That fallback is the normal path — but
the probe used the throwing `Environment.get`, and constructing a
`RuntimeD4rtException` registers it with the `ErrorReporter`. The loader caught
the exception and never revoked it, so every routine miss left a phantom
`Undefined variable: <Type>` behind.

Nothing failed at runtime, but any host that treats reported errors as its
pass/fail signal counted them. The dcli/d4rt REPL in `-test` mode is one:
importing a bridge library with N such extensions failed the run with N errors
while every assertion in it passed.

The probe now uses the non-throwing `Environment.lookup`, as that method's own
doc comment prescribes for callers that fall back on a miss.

## 1.27.0

Name resolution: yes — the ambiguity rule itself — two same-named bridged classes stop resolving to whichever registered last (tcca19).

### Fixed — two packages declaring the same class name resolved to whichever registered last (tcca19)

`package:tom_doc_scanner` and `package:tom_md2latex` each declare a
`MarkdownParser`. Both barrels are registered into one interpreter, and the
registry keyed bridged classes by *simple name* only — so the second
registration silently shadowed the first and a script naming `MarkdownParser`
got an arbitrary one of the two. The interpreter then papered over the
consequences by scavenging sibling same-name bridges for the requested member,
which bound the name to a class the author never named.

The registry now carries the declaring library's source URI through
registration, and applies Dart's own rule:

- **One class under a name resolves as before.** The same class arriving twice
  through two barrels (a re-export) is not an ambiguity — sameness is decided by
  `nativeType`, not by URI.
- **Two different classes under one name make the bare name an error.** The new
  `AmbiguousBridgedNameException` names both declaring URIs and the qualified
  forms that work. It is raised at the *reference*, not at registration, exactly
  as Dart reports an ambiguous import — the host registers every barrel up
  front, so failing at registration would break scripts that never mention the
  name.
- **`<package>.Name` reaches each declaring library.** No import prefix
  directive is required, which matters for `.d4rt` replay files (they cannot
  carry import directives).
- **An ambiguity is only raised when the script has a remedy.** If the colliding
  registrations cannot be told apart by package qualifier, last-wins stands and
  a warning is logged; an error with no available fix would be worse than the
  arbitrary pick it replaces.

**Behaviour change.** A script that referenced a bare name while *both*
declaring libraries were in scope previously got one of the two silently; it now
throws and must qualify. `B2-CLASH-3` was rewritten to assert the new contract.
Import-over-ambient (GEN-100, e.g. `painting.TextStyle` overriding the ambient
`dart:ui` one) is unaffected — that is import-vs-ambient, and only
import-vs-import is ambiguous.

The rule is documented in
`tom_d4rt_generator/_copilot_guidelines/same_name_class_resolution.md`.

## 1.26.0

### Fixed — the `dart:convert` codec/converter half had no hierarchy, and `Encoding.decodeStream` was unreachable (SCB23)

`convert_hierarchy.dart` covered the SINK half of `dart:convert` only. The half
scripts actually touch — codecs, encodings and converters — had no supertype
edges at all, so every type test over it silently answered `false`:
`utf8 is Codec`, `utf8 is Encoding`, `JsonEncoder() is Converter`,
`LineSplitter() is StreamTransformer`. Twenty edges are now declared.

**`decodeStream` was a real member loss, not a cosmetic type-test loss.** It is
declared on `Encoding` and on none of the three character encodings, so
`utf8.decodeStream(...)` threw `Undefined property or method`. The edge alone
does not fix that — the `Encoding` bridge declared no `decodeStream` adapter
either — so the adapter is added here as well. The two halves are one change:
the edge routes the lookup, the adapter answers it. The adapter casts each
chunk in turn rather than calling `Stream.cast<List<int>>()`, because the
interpreter hands over a stream of `List<Object?>` and casting the *element*
fails on the first chunk.

**`LineSplitter` is deliberately NOT a `Converter`.** The SDK declares
`final class LineSplitter extends StreamTransformerBase<String, String>`. It
carries `convert` and `startChunkedConversion` of its own, which is what makes
the wrong edge tempting; it gets the two stream-transformer edges and no more.
`JsonCodec` and `Base64Codec` likewise extend `Codec` directly and are **not**
`Encoding`s. Both negatives are pinned by tests.

**The edge lists are written out flat, and that is load-bearing.**
`BridgedClass.isSubtypeOf` consults the registry for a class's direct
supertypes and ONE further hop, while the member walk
(`transitiveSupertypeNames`) is fully transitive. A minimal edge set would
therefore give correct member resolution and wrong type tests — so the
transitive closure is declared explicitly.

No dispatch changed: `Codec`, `Converter` and `Encoding` declare no
`isAssignable`, so they never enter `Environment._filterToMostSpecific`'s match
list and cannot steal or lose ownership of a native value.

## 1.25.0

### Fixed — `is TypedData` threw, and the typed_data views had no hierarchy (SCB20)

`dart:typed_data` was registered as twelve unrelated bridges. Two consequences,
one of which was worse than a wrong answer:

**`d is TypedData` did not answer — it threw.** `TypedData`, the interface every
view implements, was never bridged, so the type test raised
`Undefined variable: TypedData`. A type test that throws is worse than one that
answers wrongly, because `is` is total in Dart and scripts reasonably assume it
cannot fail. `TypedData` is now bridged as the root of the hierarchy, with its
four interface getters (`buffer`, `lengthInBytes`, `offsetInBytes`,
`elementSizeInBytes`).

**`is Iterable` answered false** on all eleven list views. Supertype edges are
now declared for the eleven views (`-> TypedData`, `-> List`, `-> Iterable`) and
for `ByteData` (`-> TypedData`, which is not a `List`).

**`is List` already worked and is unchanged.** The original report recorded it as
broken; it was not. `BridgedClass.isSubtypeOf` falls back to asking the target's
`isAssignable` about the native value (GEN-075 / GEN-081), and the `List` bridge
carries `isAssignable: (v) => v is List` (GEN-C3c) — a native `Uint8List` is a
native `List`, so the fallback answered true with no edge present. `Iterable`'s
bridge has no predicate, which is the whole reason the two behaved differently.
The `-> List` edge is now declared anyway, so the hierarchy reads correctly
instead of depending on `List` keeping a predicate it is under no obligation to
keep.

No member was lost or gained: every view already declared its ~40 inherited
`List` members explicitly, so `sort`, `where` and indexing worked throughout.
This release corrects type tests only. The `TypedData` bridge deliberately
carries **no** `isAssignable` — that predicate decides which bridge *owns* a
native object, so a root claiming it would compete with the twelve implementors
for every typed buffer; the subtype answers come from the registry instead.

Found by the mechanical hierarchy audit added in SCB19
(`tool/stdlib_member_diff.dart --hierarchy`), which reports the fix
independently: confirmed missing edges fell from 35 across 23 classes to 24
across 12.

## 1.24.0

### Fixed — `.iterator`, `SplayTreeMap.entries`, and `Map.addEntries` (SCB17)

Three defects on the map/set surface, all found by walking every member of
every bridged collection rather than by following a bug report.

**`.iterator` was a dead end for everything but a `List`.** The `Iterator`
bridge's `nativeNames` listed three implementations. The SDK's iterators are
all private types, so a name that is not listed is not claimed by any bridge,
and `for (final x in someSet.iterator ...)` — or any explicit `.moveNext()` —
answered `Undefined property or method 'moveNext' on _CompactIterator`. That
covered `LinkedHashSet`, `SplayTreeSet`, `UnmodifiableSetView`, every map
key/value/entry view, and even a bare `<int>{}` literal (which *is* a
`LinkedHashSet`). Eleven names added, enumerated by asking the SDK for the
runtime type of `.iterator` on each bridged collection.

**`SplayTreeMap.entries` was unusable** while every other map's worked: the
`Iterable` bridge listed `_SplayTreeKeyIterable` and `_SplayTreeValueIterable`
but not `_SplayTreeMapEntryIterable`.

**`HashMap.addEntries` / `LinkedHashMap.addEntries` rejected an interpreted
`MapEntry`.** Both bridges carried a *local* `addEntries` doing
`newEntries.cast()`, which cannot unwrap the `BridgedInstance<MapEntry>` that
interpreted `MapEntry('a', 1)` produces — it failed with `type
'BridgedInstance<Object>' is not a subtype of type 'MapEntry'`. `MapCore`'s
copy unwraps correctly, and `SplayTreeMap` — which never had a local copy —
already worked by inheriting it through the `-> Map` edge. That asymmetry is
what identified this as **shadowing**, not a missing feature, so the fix
deletes the two duplicates rather than adding a third correct one.

**What this change is not.** SCB17 was filed against the map/set *hierarchy*,
on the assumption it had the same gap SCB7 fixed for queues. It does not —
`CollectionHierarchyCollection` already registers those edges, every `is`
answer is correct, and leaf dispatch is intact. Verifying the premise is what
redirected the work to the three defects above.

The `nativeNames` allowlist remains structurally wrong: it can only ever be as
complete as its last update. The structural alternative — a native
`is Iterator` fallback in `Environment.toBridgedInstance` — is deliberately
not taken here, because that predicate decides which bridge *owns* an object
and a blanket claim could steal dispatch from a more specific bridge, the
exact hazard `CollectionHierarchyCollection` exists to avoid. Tracked
separately.

## 1.23.0

### Fixed — `await` in receiver position, e.g. `(await f).join(',')` (SCB14)

`visitMethodInvocation` evaluated its target and used the result without ever
checking for `AsyncSuspensionRequest` — the sentinel the interpreter returns
when an `await` hits an unresolved future. Every intermediate site is obliged to
propagate that sentinel upward so the statement machine can suspend and re-enter
the statement once the future completes. The argument lists in this same method
all did (~25 `_evaluateArgumentsAsync` sites, each with the check); the receiver
slot did not. The sentinel was therefore treated as an ordinary receiver, and
the failure surfaced as `Undefined property or method '<x>' on
AsyncSuspensionRequest` — an error naming an internal type the script author has
never heard of. The fix is the same one-line propagation `visitIndexExpression`
has always carried.

**The blast radius is smaller than the symptom suggests, and only the tests
established that.** `(await f)[0]` and `(await f).length` were already correct —
the index and property-access paths both had the check. `visitMethodInvocation`
was the single gap, so writing each receiver shape as its own test is what
separated the one real defect from two assumed ones.

Two further async defects were isolated while fixing this and are deliberately
**not** addressed here — they are pre-existing, independently reproducible, and
outside "await in receiver position". Both have skipped reproductions in
`test/scb14_await_receiver_position_test.dart` naming their follow-up todos:

- **Multiple `await`s in one statement return the first future's value.** An
  async frame has a single `lastAwaitResult` slot which every
  `visitAwaitExpression` reads on resumption, so `(await a) + (await b)`
  evaluates to `'AA'`. This involves no receiver at all, which is what proves it
  independent of the fix above. It is a silent wrong answer rather than a
  crash — the more dangerous of the two.
- **Resumption loses the enclosing block scope.** An `await` in argument
  position whose invocation target is a local (`out.addAll(await f)`) re-enters
  with `out` undefined. Its error text is byte-identical before and after this
  fix.

### Fixed — symbol literals (`#foo`) evaluate to a `Symbol` (SCB11)

`#foo` evaluated to `null`. There was no `visitSymbolLiteral` in either
interpreter, so `SymbolLiteral` fell through `GeneralizingAstVisitor`'s default
and produced nothing — silently, with no "unsupported node" error to point at
the literal. The cost was paid downstream: `Invocation.method(#foo, [])` died
several frames later with `type 'Null' is not a subtype of type 'Symbol' in type
cast`, an error that accuses the bridge rather than the literal. SC5's tests
spell out `Symbol('foo')` throughout for exactly this reason.

Both interpreters now build a `Symbol` from the literal. Two details are worth
stating because they are easy to get wrong:

- **The dotted form is one name, not a path.** `#foo.bar.baz` is a single
  library-qualified symbol named `'foo.bar.baz'`; it is not a member access on
  `#foo`. The components are joined with `.`, never resolved.
- **A non-const `Symbol` is sufficient.** Real Dart canonicalises `#foo` at
  compile time, but `Symbol` compares by name, so a freshly built `Symbol('foo')`
  is `==` and hash-equal to the canonical one. That is what lets a script mix the
  two spellings freely, including as `Map` keys.

Operator symbols (`#+`, `#[]`, `#==`) work; they arrive as a single component
and need no special handling.

**Known limitation, unchanged and not caused by this fix:** interpreted
`Symbol('foo')` evaluates to a `BridgedInstance` wrapper whose `hashCode` is the
wrapper's identity hash, so `{#a: 1}[Symbol('a')]` still misses. This affects
every bridged value type equally — `{Duration(seconds: 1): 1}[Duration(seconds:
1)]` is `null` for the same reason — and is tracked separately as SCC32.
`containsKey` takes the bridge-call path, which does unwrap, and therefore does
agree across both spellings.

A companion audit walked all 45 `Expression` node types through the
`GeneralizingAstVisitor` chain in both trees: `SymbolLiteral` was the only one
without a handler. The *mechanism* survives, though — `visitNode` still answers
`null` for anything unhandled, so the next node the language grows will fail just
as quietly. Closing that is tracked as SCC33.

### Fixed — the interpreter raises the SDK's own error types (SCB10)

SC5 made seven `dart:core` error classes nameable and catchable, on the premise
that d4rt already *threw* SDK-correct shapes and only the `BridgedClass` was
missing. That premise held for two of them. Everything the interpreter raised
itself was a `RuntimeD4rtException`, so no `on TypeError` / `on NoSuchMethodError`
/ `on AssertionError` clause could ever match the operation that should have
produced it, no matter which bridges were registered. Four raise sites now throw
the real thing:

- a failing `as` cast, and `!` on null → `TypeError`
- a final member-lookup failure → `NoSuchMethodError`
- a failing `assert`, in a statement or a constructor initializer →
  `AssertionError`
- a list index out of range → `RangeError`

**`list[9]` raises a plain `RangeError`, not `IndexError`.** Measured against the
platform, which contradicts the obvious reading: `IndexError` is a `RangeError`
subtype and looks like the better fit, but the VM's `List.[]` does not use it and
`on IndexError` does **not** catch an out-of-range list access. Raising
`IndexError` would have made d4rt strictly *more* catchable than Dart, so a
script written against d4rt would break once compiled.

**Which contract moved: the type, not the message.** `D4rtTypeError` and
`D4rtNoSuchMethodError` `implement` rather than `extend` their SDK counterparts,
because neither SDK type offers a constructor that accepts a message — using
them directly would have discarded the diagnostics that name the receiver, the
member and the failed extension-method lookup. `implements` keeps
`value is TypeError` true, so the SC5 bridges claim these instances and `on`
clauses match, while `toString()` still returns d4rt's own text verbatim. The
SDK does the same thing for the same reason (`_TypeError`, `_AssertionError`).
Consequently no existing message assertion needed rewriting; the five tests that
changed were retargeted at the new *type* and still pin the same strings. The one
genuine text change is `assert`: its message is now the script's raw message
object carried on `AssertionError.message`, rather than a string d4rt
pre-formatted, so `toString()` quotes a String message exactly as the SDK does
(`Assertion failed: "boom"`). The no-message text is unchanged.

Uncaught, these now reach the *host* unwrapped too. `execute()`'s catch-all
re-labels anything it does not recognise as `Unexpected error: ...`, a message
that tells the caller they hit an interpreter bug — wrong for a script whose own
assert failed. Without that carve-out the shape made catchable inside a script
would have been destroyed on the way out of one.

Deliberately not included: the interpreter's *intermediate* member-lookup
failures still raise `RuntimeD4rtException`, because nine call sites branch on
`e.message.contains("Undefined property '<name>'")` to decide whether to attempt
extension lookup — that string is load-bearing control flow, and replacing it
with a typed signal is tracked separately. Genuine interpreter failures keep
raising `RuntimeD4rtException`, as they should.

Fixed as a side effect: the bridged-method lookup site's `throw` sat inside the
`try` whose own `on RuntimeD4rtException` handler caught it, appending the
message to itself ("… has no instance method named 'wibble'. Error during
extension lookup: … has no instance method named 'wibble'."). A
non-`RuntimeD4rtException` escapes that handler instead of being re-wrapped by
it.

### Fixed — error handlers are called with the arity they declare (SCB9)

The SDK accepts an error handler in either arity — `void Function(Object error)`
or `void Function(Object error, StackTrace stackTrace)` — and inspects the
callback to decide which to use. Every d4rt adapter hardcoded the two-argument
call, so the unary form, the one most scripts reach for first, died with `Too
many positional arguments. Expected at most 1, got 2.` The message named
argument counts rather than the callback the author had written, so it read as
an interpreter bug rather than a signature mismatch.

**Fourteen sites, not one.** The adapter had been copy-pasted: `Stream.listen`,
the `StreamSubscription.onError` setter, `Future.then`'s `onError`,
`Future.catchError`, the `FutureExtensions.onError` extension, and nine more
across `dart:io` (`Socket`, `HttpClient`, `Stdin`) — `io/socket.dart`'s listen
adapter is byte-identical to `async/stream.dart`'s, wrapper names included. All
now route through a single `errorHandlerArgs` helper.

**The selection uses total positional arity, not `arity`.** `arity` counts only
*required* positional parameters, so it reports 1 for `(e, [st])` — and native
Dart passes both arguments to that closure, because
`Function(Object, [StackTrace])` is a subtype of `Function(Object, StackTrace)`.
`Stream.handleError` already selected on `arity` and consequently dropped the
stack trace for the optional form; it now uses the new public
`InterpretedFunction.maxPositionalArity` like every other site.

`StreamTransformer.fromHandlers`' `handleError` is deliberately excluded: its
SDK signature is a fixed `(error, stackTrace, sink)` with no arity variance.
The change is confined to error handlers — argument checking elsewhere is
untouched, so a handler with a genuinely wrong signature is still reported
rather than silently accepted.

Also fixed: `_HandleErrorStream` was missing from the `Stream` bridge's
`nativeNames`, so every member of a `handleError()` result failed with
"Undefined property or method 'toList' on `_HandleErrorStream`" — the same
defect SC4 fixed for `_StreamSinkWrapper`, one method away in the same file,
and the reason `handleError`'s arity handling had never been exercised by a
test.

### Fixed — `is` and `on` see a bridged collection's supertypes (SCB7)

`x is Map` was `false` for every bridged `dart:collection` map — `HashMap`,
`LinkedHashMap`, `SplayTreeMap`, `UnmodifiableMapView`, `Map.unmodifiable(...)`
— and `x is List` likewise for `UnmodifiableListView`. `x is Iterable` was
`false` for most bridged sets and for the list view. Two independent defects
were responsible:

- **The type-test switch tested the wrapper, not the value.**
  `visitIsExpression` special-cases the shape types (`int`, `double`, `num`,
  `String`, `bool`, `List`, `Map`) and answered them with the host's own `is`
  operator applied to the operand as it arrived. A bridged value arrives as a
  `BridgedInstance`, which is neither a `List` nor a `Map`, so the answer was
  always `false`. The shape cases now test the underlying native object. `Set`
  and `Iterable` are not in that switch, fell through to the bridged-subtype
  path, and were therefore already answered correctly — which is why the `Set`
  side looked healthy while the `Map` and `List` sides did not.

- **Nothing declared the `dart:collection` supertype graph.** The new
  `CollectionHierarchyCollection` registers the map, set, list-view, queue and
  `LinkedList` edges with `BridgedClass.registerSupertypes`, so the bridged
  subtype walk can reach `Set`, `List`, `Map` and `Iterable`. It absorbs the
  queue-only block that previously lived in the `DoubleLinkedQueue` bridge —
  one declaration of the library's hierarchy rather than one per file.

Also fixed: catch-clause type matching is a **separate** implementation from
`is`, with its own type switch, and it consulted only exact tests — the catch
type's `isAssignable` predicate and bridge identity. Neither can see that an
`UnmodifiableSetView` is an `Iterable`, so `on Iterable` missed a thrown
bridged collection that `x is Iterable` matched. It now falls back to the
thrown value's own bridge and the supertype walk, the way the `is` path does.

Expressed as registry edges and deliberately **not** by widening any
`isAssignable`: that predicate is what `Environment.toBridgedInstance` consults
to decide which bridge *owns* a native object, and every hand-written stdlib
bridge carries `hierarchyDepth == 0`, so a supertype claiming assignability for
its subtypes could quietly steal dispatch. Feeding the registry instead lets
`_filterToMostSpecific` use the hierarchy to drop supertype matches, making
dispatch more exact rather than less.

The generic-argument checks the `List` / `Map` cases carry
(`is List<int>`, `is Map<String, int>`) are preserved and now reachable for
bridged operands too.

**Still open, and unrelated to bridged collections:** pattern matching is a
third copy of the type test, and it does not evaluate its type at all. A bare
typed pattern (`case int _`, `case Map m`) matches unconditionally, so the
first arm of a `switch` statement, `switch` expression or `if-case` always
wins — for `int` and `String` just as much as for a collection. Constant
patterns and destructuring patterns are unaffected. Tracked separately.

### Changed — `UnmodifiableListView` mutators raise the SDK's `UnsupportedError` (SCB6)

**This is a behaviour change to a shipped bridge.** A mutation attempt on
an `UnmodifiableListView` used to be intercepted by the bridge, which
raised `RuntimeD4rtException("Unsupported operation: Cannot modify an
unmodifiable list")`. All 18 mutating methods and the `length` / `first` /
`last` setters now delegate to the native view, so the failure a script
sees is the SDK's own `UnsupportedError`.

Two things this fixes:

- **The failure is catchable by the type the contract names.**
  `on UnsupportedError` is how `dart:collection` says to catch a mutation
  attempt, and it now works. The intercepted exception was catchable — a
  bare `catch (e)` saw it — but only by that broadest handler, so a script
  could not distinguish a rejected mutation from any other bridge error,
  and a typed handler missed it entirely.

- **It matches the sibling bridges.** `UnmodifiableMapView` and
  `UnmodifiableSetView` have delegated since they were added, so the three
  unmodifiable views no longer disagree about how a mutation surfaces.

Arguments are still validated before delegating, so a malformed call
reports the argument problem rather than the equally-true-but-less-useful
unsupported-operation error.

**Migration:** a script that catches `RuntimeD4rtException` around a
mutation of an unmodifiable list will no longer see it — catch
`UnsupportedError` instead. Read-only members, and scripts that do not
attempt mutation, are unaffected.

### Added — the member-level gaps a class-granularity audit cannot see (`ccf041f8`)

Each of these is a member missing from a class the audit already counted as
bridged, which is why none of them showed up in a coverage number: a spot-check
that happens to land on a registered member reports the whole class as covered.
Enumerating the SDK type's members is the only way to see a partial set.

- **`Duration` exposed 6 of its 16 unit constants.** `secondsPerMinute`
  resolved while `microsecondsPerDay` did not. All 16 are now registered.
- **`Uri.base` was absent**, so a script could build and manipulate URIs but
  could not resolve one against the process's working directory.
- **`UriData` had none of the `isMimeType` / `isCharset` / `isEncoding`
  predicates**, so a caller could produce a data URI and read its bytes but not
  decide whether the payload was the shape it expected.
- **`ByteBuffer.asUint8ClampedList` and `ByteData.asUnmodifiableView`** were the
  two omissions in an otherwise complete reinterpretation surface.
- **Set algebra (`difference` / `intersection` / `union`) resolved on a set
  literal but on none of `HashSet` / `LinkedHashSet` / `SplayTreeSet`**, because
  the interpreter's instance-member fallback through the supertype chain is not
  uniform — declaring the trio on the `Set` bridge does not make it reachable on
  a concrete set. The three now carry it, via a new shared
  `setAlgebraMethods` helper rather than a third, fourth and fifth hand-rolled
  copy; the two copies that already existed (`Set`, `UnmodifiableSetView`) were
  converged onto it so they cannot drift apart again.

One diagnostic changed with that convergence and is the only non-additive part:
`Set.difference(notASet)` used to fail with a raw
`type '…' is not a subtype of type 'Set'` cast error and now raises
`Argument to Set.difference must be a Set.`, naming the class the script
actually called. Scripts that pass a `Set` are unaffected.

### Added — `sort`, `shuffle`, `asUnmodifiableView` and `bytesPerElement` on every typed list (`9fca5be3`)

Nine of the ten typed-data lists that share `inheritedListMethods()` could not
sort, shuffle, or take an unmodifiable view. `Uint8List` could, because it
hand-rolls its own adapter map — and it is the most-used variant, so a
spot-check reached the one working case. `bytesPerElement` was missing on all
eleven.

The helper had excluded these on the stated grounds that typed-data lists are
fixed-length and mutating calls "would throw `UnsupportedError`". That
conflated fixed-*length* with immutable: `sort` and `shuffle` permute in place
without changing the length and are fully supported by the SDK, which is exactly
why `Uint8List`'s own copy of `sort` worked. The doc comment now scopes the
exclusion to length-changing operations only, and a test asserts `add` still
refuses, so the correction cannot overreach.

Two registration details worth stating because they are easy to get wrong:
`asUnmodifiableView` is declared per concrete variant rather than on `List<E>`,
so it arrives through a **required** `unmodifiableView` callback — required, so
a newly added variant cannot silently omit it. `bytesPerElement` is a static,
which no supertype fallback can reach, so it is registered through
`typedListStaticGetters()` fed from the SDK constant itself rather than a
literal, to prevent drift from the platform.

### Fixed — `StdioType` and `HtmlEscapeMode` constants were registered but unreachable (`9bb876f3`)

Both classes were bridged but inert: their `static const` constants sat in the
bridge's *instance* `getters` map, so `StdioType.terminal` and
`HtmlEscapeMode.element` could not resolve. That is worse than an absent
bridge — `HtmlEscape`'s constructor advertised a `mode` parameter for which no
script could supply a value, and a `StdioType` could not be compared against
anything. `stdioType()` itself was never registered either, so nothing could
produce the value the class exists to describe.

Also added: `HtmlEscape.mode` (the read half of the constructor's round trip),
the four `HtmlEscapeMode` escape flags, `StdioType.name`, and the missing
`sqAttribute` constant.

Found mechanically rather than by inspection. `tool/stdlib_member_diff.dart`,
added by the same change, diffs each bridged class's adapter-map keys against
the SDK type's real member set via `dart:mirrors`, then uses the interpreter
itself as the oracle for whether a candidate is genuinely unreachable — a static
diff alone over-reports, because instance lookups fall back through the
supertype chain.

## 1.22.0

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

## 1.21.0

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

23 script-level tests (`F-SC9-1` … `F-SC9-23`) under
`test/stdlib/convert/`, mirrored by 15 registration-level tests
(`F-SC9-AST-*`) in `tom_d4rt_ast`.

## 1.20.0

### Added — `BytesBuilder` (SC8)

`BytesBuilder` from `dart:typed_data` is now bridged, closing the last
typed-data entry on the P2 gap list. Scripts can accumulate bytes
incrementally instead of rebuilding a list on every append:

```dart
import 'dart:typed_data';
main() {
  final b = BytesBuilder();
  b.addByte(1);
  b.add([2, 3]);
  return b.takeBytes();   // Uint8List [1, 2, 3]
}
```

The full surface is available: the constructor with its `copy:` flag,
`addByte`, `add`, `takeBytes`, `toBytes`, `clear`, `length`, `isEmpty` and
`isNotEmpty`. `toBytes` and `takeBytes` return objects that route to the
existing `Uint8List` bridge, so indexing and `sublist` work on the result
without further registration.

**Both private implementations are routed.** `BytesBuilder` is abstract and
its only constructor is a factory returning `_CopyingBytesBuilder` by default
or `_BytesBuilder` under `copy: false`. This is the first bridge where a
*constructor argument* decides which private class comes back, so both names
are listed on `nativeNames` — with only the default, `BytesBuilder(copy:
false)` would construct successfully and then fail on its first `addByte`.

Argument mistakes surface as catchable script errors rather than host type
errors: a positional argument to the constructor (the natural misreading of
`BytesBuilder({bool copy})`), a non-`int` to `addByte`, and a list carrying a
non-`int` element to `add` — the last naming the offending element.

## 1.19.0

### Added — `DoubleLinkedQueue` and its entry cursor (SC7)

`DoubleLinkedQueue` is now bridged, together with the `DoubleLinkedQueueEntry`
cursor that is the type's entire reason to exist. Both are mirrored into
`tom_d4rt_ast`.

- **The entry type is not optional.** `DoubleLinkedQueue` differs from the
  already-bridged `ListQueue` in exactly one way: `firstEntry`/`lastEntry`/
  `forEachEntry` hand out cursors that splice in place. Bridging the queue
  without the cursor would have shipped a slower `ListQueue` with no reason to
  exist.
- **`nativeNames: ['_DoubleLinkedQueueElement']`** on the entry bridge.
  `firstEntry()` returns that private SDK subclass, not a
  `DoubleLinkedQueueEntry` — without the routing the entry API would hand back
  objects that reach no bridge at all. Same pattern as `_TypeError` in 1.17.0.

### Fixed — queues could not reach their inherited `Iterable` surface

Pre-existing breakage, not introduced here. Bridges are registered flat and
dispatch is per-bridge, so the shipped `ListQueue` bridge could not reach the
~30 `Iterable` members it inherits: `.where`, `.map`, `.join` and even
`.contains` failed with "has no instance method named", and `q is Iterable`
was false. (`contains` is the sharp case — the `Queue` bridge has always
declared it, but a native `ListQueue` dispatches to the `ListQueue` bridge,
which did not.)

`QueueHierarchyCollection` declares `DoubleLinkedQueue`/`ListQueue -> Queue`
and `Queue -> Iterable` to `BridgedClass.registerSupertypes`. One block both
answers `is` correctly and lets the bridged-supertype walk find the inherited
members, for every queue type at once, instead of copying thirty adapters onto
each bridge.

The edges are deliberately **not** expressed by widening any `isAssignable` —
that predicate decides which bridge *owns* a native object in
`Environment.toBridgedInstance`, where every hand-written stdlib bridge ties at
`hierarchyDepth == 0`. Feeding the registry instead lets the resolver's
most-specific filter *use* the hierarchy to drop supertype matches, so this
makes dispatch more exact rather than less: a deque is not mistaken for a
`ListQueue`.

17 script-level tests under
`test/stdlib/collection/double_linked_queue_test.dart`, mirrored by 15
registration-level tests in `tom_d4rt_ast`.

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

### Known gap (pre-existing, not introduced here) — fixed in 1.23.0

`x is Map` is `false` for every bridged `dart:collection` map — `HashMap`,
`SplayTreeMap` and now the map view alike — and likewise `x is List` for
`UnmodifiableListView`. Characterized by `F-SC3-21` so the day it is fixed shows
up as a red test rather than going unnoticed.

The cause given here originally — that supertype `is` works only where a core
bridge's `nativeNames` enumerates the concrete runtime type, "which is the case
for `Set` but not for `Map`/`List`" — was wrong. `MapCore` enumerates concrete
names and declares `isAssignable` exactly as `SetCore` does. See 1.23.0 for the
two defects that were actually responsible.

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

The first release after 1.12.1, carrying two batches: the fork-update
realignment against upstream `kodjodevf/d4rt` (DFUB1–DFUB13, below) and the
first stdlib gap-audit bridges (SC1/SC10/SC11, further down). Several of the
DFUB entries are behaviour **tightenings** — read the DFUB7 and DFUB11 notes
before upgrading.

DFUB12 is absent by design, not by omission: it split the analyzer-free tree's
library barrel so a web target can avoid `dart:io`, which is meaningless here —
this package depends on `analyzer` and never targeted the web.

### Added — relative filesystem imports actually resolve (DFUB1)

`execute()` / `executeAsync()` have long accepted `basePath` and
`allowFileSystemImports`, and both were dead no-ops: an interpreted script could
not import a sibling `.dart` file from disk no matter how they were set. They are
now wired through to `ModuleLoader`, which resolves a relative import against
`basePath` and reads the file when the flag is enabled.

Nested relative imports resolve without shared state, because `loadModule`
already resolves per module and saves/restores the current library around each
load. Upstream's accompanying 453-line mutable→immutable `currentLibrary`
refactor is deliberately not ported — it is not needed for the fix.

Ports upstream `973feab`.

### Security — filesystem module reads are gated on `FilesystemPermission` (DFUB2)

DFUB1's on-disk reads are checked **before** the read, so enabling
`allowFileSystemImports` is not by itself permission to read the filesystem: an
ungranted import now throws `RuntimeD4rtException ... requires
FilesystemPermission`.

The single terminal "module not found" throw is also replaced by a diagnostic
that distinguishes the four real causes: filesystem imports disabled, an enabled
filesystem import whose file is missing (naming the resolved path), a missing
`package:` import, and a URI that was simply never preloaded.

Separately, `visitImportDirective` now self-resolves any already-absolute URI
rather than only `dart:` and `package:`, so an absolute `file:` import reaches
the loader without a base — matching upstream's `resolveModuleUri`.

Ports the read gate and error shapes of upstream `973feab`.

### Fixed — one file imported two ways was loaded twice (DFUB3)

A filesystem module now has ONE identity regardless of how it is spelled. The
URI that flows through the loader is canonicalized to an absolute `file:` form
for reads and for the DFUB2 permission gate, and the module cache is keyed by the
symlink-resolved real path. Relative, absolute, `..`-containing, symlinked-file
and symlinked-directory spellings of the same file therefore share one module
instance — previously each spelling produced its own, so top-level state was
duplicated and identity comparisons across the two copies failed.

Ports upstream `3b8b8ca`.

### Added — instance-method and setter dispatch on extension-type instances (DFUB4)

`InterpretedExtensionType` gained a `setters` map, so assigning to a member of an
extension-type instance binds and invokes the matching setter instead of failing;
and `InterpretedExtensionTypeInstance` now resolves instance **methods** — not
only getters — at the method-invocation, implicit-`this` identifier, and
property-access sites.

Ports upstream `2f519cd` (Extension Type Support 0.2.2).

### Added — runtime type checks for function types and record types (DFUB5)

`is` / `as` against a function type or a record type annotation no longer throws
"not implemented", and function/record **return-type validation** is now actually
enforced.

Two new structural runtime types in `runtime_interfaces.dart`:
`FunctionRuntimeType` (covariant return, contravariant parameters, arity and
named-parameter shape) and `RecordRuntimeType` (positional arity, named keys,
per-field compatibility), alongside the shared `NamedRuntimeType` contract.
`InterpretedFunction` exposes a cached `callableRuntimeType`.

Ports upstream `848f03d`.

### Added — applied generic type arguments preserved at runtime (DFUB6)

New `AppliedRuntimeType` (a base type plus its applied arguments, with
element-wise subtyping and `dynamic` / `Object` / `void` treated as wildcards),
so `is Box<int>` honours the type argument instead of matching any `Box`.

Generic and typed native-collection returns are validated element-wise: the
applied return type is captured at declaration time onto
`InterpretedFunction.declaredReturnTypeApplied` and checked in
`visitReturnStatement`. Async and generator functions are exempt, because their
`Future<T>` / `Stream<T>` / `Iterable<T>` return type wraps the inner value
rather than describing it.

Ports the applied-runtime-types half of upstream `1042fff`.

### Fixed — `BridgedClass` / `TypeParameter` subtype checks were too permissive (DFUB7)

**Both halves are tightenings and can turn a previously-true `is` into false.**

- `BridgedClass.isSubtypeOf`: the `num` early block answered true for
  `num <: int` and `num <: double`, making `num` a subtype of its own subtypes.
  Only `num <: num` is kept; the downward `int` / `double <: num` direction is
  unaffected.
- `TypeParameter.isSubtypeOf`: the unconditional `return true` is replaced by
  real rules — another `TypeParameter` is a subtype; a bounded `T extends X`
  defers to its bound, so `T extends num` is **not** a subtype of `String`; an
  unbounded `T` is a subtype only of the top types (`Object` / `dynamic` /
  `void`).

Ports the subtype half of upstream `28ca517`.

### Fixed — omitted optional super parameters clobbered the parent's default (DFUB8)

An optional super parameter (`[super.x]` / `{super.x}`) that the caller omits,
and that carries no default of its own in the child constructor, is no longer
forwarded to the parent as an explicit `null`. Skipping the forward lets the
parent apply its declared default, e.g. `Parent(this.name, [this.value = 0])`.
Required super parameters are unaffected.

Ports the two failing super-parameter cases from upstream `class_test`.

### Added — operator and `call()` dispatch on extension-type instances (DFUB9)

Operator methods declared on an `extension type` were already stored on
`InterpretedExtensionType.methods`, keyed by the operator lexeme, but no dispatch
site recognised an `InterpretedExtensionTypeInstance` receiver. Binary operators
reported `Unsupported operator (PLUS) for types InterpretedExtensionTypeInstance
…`, unary `-` reported `Operand for unary '-' must be a number …`, and invoking
an instance silently returned the instance itself instead of running its `call`
method.

Seven dispatch sites now resolve the operator on the extension type, bind `this`,
and invoke it:

- `visitBinaryExpression` — `+`, `*`, `>`, `==` and friends. The lookup runs
  *before* the native comparison/arithmetic switch, because a comparison such as
  `>` would otherwise reach `left as dynamic > right` and throw a
  `NoSuchMethodError` on the instance.
- compound assignment (`+=`, `*=`, …) — dispatches with the *wrapped* instance as
  the receiver, not the unwrapped representation value.
- `visitPrefixExpression` — unary `-` and `~`, bound with an empty argument list.
  A zero-arg `operator -()` and a one-arg binary `operator -` share the `-` key,
  so only the prefix site may bind it with no arguments.
- index get `[]` and index set `[]=`.
- both invocation paths — `visitMethodInvocation` (`calc(5)`) and function
  expression invocation (`(calc)(5)`) — route to the `call` method, forwarding
  positional, named and type arguments.

### Fixed — circular module imports and exports blew the stack (DFUB10)

`ModuleLoader.loadModule` only published a module to its cache at the very END,
after recursing through every import and export directive. A cycle `A -> B -> A`
therefore re-entered the load of `A` while `A` was still in progress, the cache
guard missed, and the recursion never bottomed out. Circular imports and circular
exports are both **legal** Dart and run correctly, so this rejected valid
programs.

The loader now publishes a *partial* module under an in-flight map before walking
any directive, and a cyclic re-entry receives that partial instead of recursing.
The partial carries the very `Environment` instance that later receives the
module's own declarations, so importers hold a live reference.

Because `Environment.importEnvironment` **copies** bindings at call time rather
than aliasing the source environment, a merge taken from a still-incomplete
module would otherwise capture an empty export set and never self-heal. Each such
merge is recorded and **replayed** once the in-flight module finishes. Replays are
idempotent — `importEnvironment` skips names already bound to the identical value
— so they cost nothing and cannot raise a spurious conflict. A failed load drops
its in-flight registration, so an abandoned partial is never handed out on a
later execute.

DELIBERATE DIVERGENCE FROM UPSTREAM: `kodjodevf/d4rt` `f6e1257` fixes the same
crash by *detecting* the cycle and throwing "Circular module dependency
detected". That rejects valid Dart, so it is not adopted here.

### Security — scoped `FilesystemPermission` grants are now actually enforced (DFUB11)

**This is a behavioural tightening. Scripts that relied on the previous, laxer
matching will now be denied.**

Two independent sandbox holes are closed (ported from upstream `861117a`).

**1. No per-operation enforcement.** The `dart:io` bridges in
`stdlib/io/{file,directory,file_system_entity}.dart` carried *zero* permission
checks. The only gate was at `dart:io` IMPORT time, and it merely required that
*some* `FilesystemPermission` had been granted. A grant scoped to one directory
was therefore indistinguishable from `FilesystemPermission.any` once the import
succeeded — every bridged file and directory operation ran unchecked.

Every read/write entry point now calls
`checkFilesystemRead/WritePermission` **before** the native operation, so a
denial cannot leave a side effect behind. Operations are classified by what they
actually do: `rename` requires write on *both* the old and the new path, `copy`
requires read on the source *and* write on the target, and
`File.open`/`openSync` follow the requested `FileMode` (only `FileMode.read`
counts as a read). `FileStat.stat`/`statSync` are gated too — they take a raw
path and would otherwise sidestep every `File`/`Directory` gate.

**2. Naive scope matching.** `FilesystemPermission.allows` compared with a raw
`opPath.startsWith(_path)`. Two consequences: `..` traversal escaped the scope
(`/allowed/../etc/passwd` was "inside" `/allowed`), and a sibling directory whose
name merely shares the string prefix (`/allowed_sneaky` against a grant on
`/allowed`) was treated as inside it.

Matching is now canonical and on a path-*segment* boundary: both sides are
absolutized, normalized to `/` separators, lowercased on a Windows drive letter,
and reduced by resolving `.` and `..` away; the request must then either equal the
scope or start with `scope + '/'`. Symlinks are **not** resolved at this stage —
see the 1.22.0 entry, which revisits exactly that decision and makes the matcher
symlink-aware.

**Pathless operations.** Some checks have no meaningful path — the `dart:io`
import gate asks only "is *any* filesystem access granted?". Those now pass
`'pathAgnostic': true`, which waives the PATH check **only**, never the
read/write/execute flags. Conversely, a scoped grant asked about an operation
with no path and no `pathAgnostic` flag now **denies**, rather than assuming the
operation is in scope. Unscoped grants (`FilesystemPermission.any`, `.read`,
`.write`) are unaffected and remain allow-all.

### Fixed — a failed import or export now says which file to edit (DFUB13)

A missing import was one of the least actionable errors the interpreter could
produce. Three defects conspired:

1. `execute()`'s catch-all relabelled `SourceCodeD4rtException` as "Unexpected
   error: …", discarding a diagnostic the loader had deliberately composed and
   telling the user they had hit an interpreter bug rather than mistyped a
   package name.
2. A missing `package:` URI got the generic "not a recognized Dart standard
   library" tail — noise, since nobody expected it to be a stdlib library, and
   neither real fix (supply the source, bridge the package) was mentioned.
3. The message named the module that could not be FOUND but never the module that
   ASKED for it. In a barrel chain that is the wrong half: the missing URI is the
   symptom, the file holding the directive is what you have to open.

`wrapDirectiveError()` preserves the concrete exception type rather than
returning a fixed one, because the two loaders report a missing module
differently — the filesystem loader raises `SourceCodeD4rtException`, the bundle
loader `RuntimeD4rtException`. The wrap is applied once, at the innermost frame,
so a deep chain yields one prefix instead of one per frame; and it is skipped for
a bare `source:` script, where owner and target coincide and a synthetic owner URI
would only restate the target.

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