## 1.227.0

### Fixed — `Record` is a type; record parameters are checked (dfin5)

`x is Record` raised "Undefined variable: Record", and a `Record` return or
parameter type raised "Type 'Record' not found.", although every record is a
`Record` in Dart. Both now work, and `x as Record` refuses a non-record
(dguc7). A RECORD-typed parameter is now checked structurally:
`sum((int, int) p)` called with `('a', 2)` raises
`type '(String, int)' is not a subtype of type '(int, int)' of 'p'`.
FUNCTION-typed parameters stay unchecked on purpose: the interpreter infers no
context type for a closure literal, so a structural check would refuse correct
callbacks (dguc8).

Name resolution: yes — `Record` resolves in `is`, `as` and type annotations (dfin5).

## 1.226.0

### Changed — no web platform claim (dfin4)

`platforms:` no longer lists `web`. This package depends on `analyzer` and
uses `dart:io`, so it cannot run on the web; pub.dev showed a web badge it
could not honour. Web embeddings use tom_d4rt_ast's bundle runtime.

### Changed — the working directory and process execution are permission-checked (dfin3)

`Directory.current = x` is a WRITE on `x`. Changing the working directory
moves every relative path a grant is checked against, process-wide and for
every later script, so it needs the standing of a write there. The `current`
and `systemTemp` getters stay unchecked: each returns a `Directory`, and
every operation on that is checked.

A process starts when EITHER a ProcessRunPermission covers the command and its
arguments, OR a FilesystemPermission with `execute` covers the executable. The
executable is the command itself when it names a path, else the first match on
`PATH` (`PATHEXT` on Windows), checked on its real path. `Process.killPid`
names no executable and needs ProcessRunPermission. Until now the gate passed
neither the command nor its arguments, so `ProcessRunPermission.command(...)`
and `.commandWithArgs(...)` allowed nothing, and the `execute` flag gated
nothing. BEHAVIOUR CHANGE: `FilesystemPermission.any` and
`FilesystemPermission.path(...)` carry `execute`, so a script holding either can
now run an executable. A host that wants file access only should grant
`FilesystemPermission.read` / `.write` (or the `readPath` / `writePath`
forms). The `dart:io` import gate also admits a script holding only a
ProcessRunPermission (`commandAgnostic`, as `pathAgnostic` is for files).

Name resolution: no.

## 1.225.0

### Changed — the script runners read imports through the interpreter's permissions (dfin2)

BREAKING for a script that imports from outside its own directory without a
grant. `executeFile`, `executeSource` and `executeFileContinued` used to
resolve imports with a regex pre-walk that read every transitive import off
disk directly, so a scoped FilesystemPermission did not hold, a symlink
inside the script directory read outside it, and a run with no grant at all
could read anything the process could. `executeFile` and `executeSource` now
hand the interpreter only the entry source, and the module loader reads
every import under FilesystemPermission on the file's real path.
`executeFileContinued` evaluates file by file, so it keeps its own walk, but
every read goes through the same check.

Each run adds one implicit grant: READ on the entry script's directory tree
(the `basePath` for `executeSource`), added and removed by identity, so a
host grant is never touched. An import beside or below the script runs as
before, and anything outside needs the host's own grant.
`resolveImportsRecursively` remains a host-side utility (no sandbox), now
resolving paths with `Uri.resolve` and taking an optional `readFile`.
`D4rt.loadedSourceModuleCount` reports the `file:` modules of the last run;
`sourcesLoaded` is read from it.

Name resolution: no — the loader resolves the same imports; only who reads the files changed.

## 1.224.0

### Fixed — a conditional import is not refused as an undefined name (sci2)

scg6's static pass read the `dart.library.io` of
`import 'x.dart' if (dart.library.io) 'y.dart';` as a variable named `dart`,
so 1.220.0 through 1.223.0 refused every program with a conditional import
before `main`. A `DottedName` is now a tag, like the other directive parts.
tom_d4rt_exec's suite found it while taking over the enforcement.

Name resolution: yes — a conditional import's configuration is no longer read as a name (sci2).

## 1.223.0

### Fixed — an alias of a bridged enum defines (SCI1)

`typedef MaterialState = WidgetState;` is Flutter's deprecated name for an
enum, and the generator emits it in `classAliases()` beside the class aliases.
`Environment.defineBridgeAlias` looked the target up among bridged classes
only, logged "target class not found" and defined nothing, so `MaterialState`
was undefined in every run. Scripts naming it passed only while that line went
unevaluated, until scg6's static name pass refused them before `main` (the
pre-publish base corpus found it in `material/datatable_test.dart`). The alias
now falls back to a bridged enum of that name anywhere on the scope chain, and
resolves to the same `BridgedEnum`. Of the 14 aliases in the Flutter bridges,
it is the only one whose target is an enum.

Name resolution: yes — an alias whose target is a bridged enum now defines the alias name (SCI1).

## 1.222.0

### Added — `D4rt.lastErrorTrace`: the interpreted frames an error left (woneprpd153)

A script that threw reached the host with the interpreter's own Dart trace —
frames of the visitor — and no position in the script. The interpreter now
keeps an interpreted call stack (`D4rtCallStack`, on the run's `ModuleLoader`):
which interpreted functions are active and which statement each is executing.
The first time an error leaves an interpreted call the stack is snapshotted
against it, and `D4rt.lastErrorTrace` hands the host those frames, innermost
first — `D4rtStackFrame(member, line, column, source)`. A run that succeeds,
or fails outside any interpreted call, leaves it empty.

Synchronous call chains are traced in full. An async function's frames are
known only until its first suspension: a continuation resumes outside the call
that started it.

Name resolution: no.

## 1.221.0

### Added — `D4rt.parse` and `D4rt.executeProgram`: parse once, run many times (woneprpd132)

`execute` parsed its source on every call, and no public API accepted or
returned a parsed unit, so an embedder that re-runs one script paid for the
parse on every run. `parse(source, {basePath})` now returns a `D4rtProgram`,
and `executeProgram(program, {name, positionalArgs, namedArgs, sources,
allowFileSystemImports})` runs it exactly as `execute` runs its source,
without parsing again.

A program carries only syntax: `executeProgram` resets the global environment
and rebuilds declarations and static coordinates per run, as `execute` does,
so two runs of one program share no state, and one program may be run by
several interpreters. A program also survives `dispose()`, which releases
only what the interpreter retains, so an embedder can cache programs and still
dispose between runs. The parse is the one `execute` uses (it moved into
`_parseDirectSource`, which both call), so a parse error is the same
`SourceCodeD4rtException`, raised by `parse`. `basePath` belongs to the
program because the unit is anchored at `<basePath>/main.dart`. A root loaded
by `library` URI goes through the module loader and stays with `execute`.

The AST line needs no counterpart: `D4rtRunner` already runs a pre-built
bundle, which is this split's other half.

## 1.220.0

### Changed — a program reading an undefined name is refused before `main` runs (scg6)

Dart rejects an undefined name at compile time, so such a program never runs.
d4rt ran everything up to the bad line: a script that recorded a side effect
on its first line and misspelled a name on its second had already recorded
it. After imports and declarations are registered, and before `main`,
`_refuseStaticallyUndefinedNames` now runs SCD95's static pass in two stages.
The pass narrows to candidates. The populated environment confirms, through
the new non-evaluating `Environment.isDefined` (which, unlike `lookup`, never
calls a registered global getter). Only a name both agree on is refused, and
the refusal evaluates that identifier, so the error is exactly the one the
line would have raised (`UndefinedNameD4rtException`, including a "not
bridged" reason). A name the runtime would resolve some other way, an
assignment target (whose runtime message differs), and everything the pass
cannot see (after a `.`, class bodies whose supertype leaves the unit,
extension members, type positions) stay with the runtime guards. Top-level
initializers have already run at that point, so the guarantee is about `main`.

The pass no longer treats the constructor named by `: this.x()` /
`: super.x()` as a read.

Name resolution: yes — an undefined name is now raised before `main` rather than at its use (scg6).

## 1.219.0

### Fixed — reading a member of a value needs no import of its type's library (scf44)

`import 'dart:io'; main() => stdout.encoding.name;` failed with "Undefined
property or method 'name' on Utf8Codec. No bridge claims this type" until the
script also imported `dart:convert`. Imports govern which NAMES a script can
write, not which members a value it holds exposes. A stdlib module's
type→bridge mapping reached the lookup only when the module was imported.

A latent registry of every stdlib library's bridges now answers a native
value's bridge when the imported scope misses. It is asked in two tiers,
each after the imported scope's own: a precise match (exact type, or the name
or `nativeNames`) before SCC49's suffix guess, and the suffix guess after
it. An imported library therefore still wins at each tier, and the widening
never lets a guess outrank a declared match. Names are untouched: `Utf8Codec`
still does not resolve as a name without `dart:convert`.

Name resolution: yes — a native value whose bridge lives in an unimported stdlib library now resolves to that bridge (scf44).

## 1.218.0

### Fixed — `await` in the body of a collection-literal `for` element (scf43)

`[for (var x in xs) await f(x)]` is valid Dart and was refused with "`await`
is not supported in the body of a collection-literal `for` element". The
refusal was deliberate, because the interpreter drives `await` by replay.
Re-evaluating the literal would have re-run the earlier iterations, and the
await-site cache, keyed by the node every iteration shares, would have handed
the second iteration the first one's value.

Both are now handled. Each iteration evaluates into a buffer that is merged
only when the iteration completes. The completed buffers are recorded when a
later iteration suspends, and the replay emits them instead of re-running those
bodies. The await sites an iteration reached leave the cache when it completes.
This covers for-in, pattern and classic `for` elements, nesting, lists, sets
and maps. The record exists only from a suspension to the literal's
completion, so a `for` element that never suspends behaves as before.

## 1.217.0

### Fixed — the host `invoke` path reaches inherited bridged members (scf42)

`D4rt.invoke(name, args)` on an interpreted instance whose class extends a
bridged class asked only that bridge's own maps. So for
`class MyQ extends ListQueue`, `invoke('elementAt', [1])` and
`invoke('first', [])` failed with "Method or getter not found", though the
same members worked inside the script (SCF19). The bridged-superclass branch
now uses `BridgedClass.findReachable*Adapter`, the walk every script path
uses.

## 1.216.0

### Fixed — a class name stored by a method or `[]=` reaches a `runtimeType` lookup (scf40)

A bare bridged class name evaluates to its `BridgedClass`. SCD198 stored the
native `Type` when a set or map literal held one, but a key that reached the
collection any other way stayed a `BridgedClass`:
`(<Type, int>{}..[String] = 1)['x'.runtimeType]` was null, and
`(<Type>{}..add(String)).contains('x'.runtimeType)` false. That broke the
`Map<Type, Handler>` registry idiom whenever the registry was built rather
than written as a literal. Identity collections missed both ways.

A class name now has one representation in every collection, its native
`Type`. It is converted at the argument boundary every call crosses (the
same rule ENG-002 applied only to Type-typed parameters), at the index
operators (`m[k]`, `m[k] = v`, the cascade and `++`/`--` forms, and a
bridged `[]`/`[]=`), and in a list literal's elements. A wrapped instance in
a list still keeps its representation, as before.

## 1.215.0

### Fixed — an interpreted `Error` subclass answers as its own class (scf39)

`class MyError extends Error {}` is built on a native `Error` super-object,
and two answers came from that object instead of the script's class.
`MyError().toString()` printed `Instance of 'Error'`, naming the native class,
while `'$e'` on the same value printed `<instance of MyError>`. A native
super-object or proxy whose `toString` is `Object`'s default now yields the
instance's own default, for a member read and for `super.toString()` inside
an override alike. A super-object that overrides `toString` is still the
answer, and now for interpolation too: an `ArgumentError` subclass
interpolates as its message.

`stackTrace` stayed null after the error was thrown. Dart sets it on the
first throw; the native super-object is never thrown and its `stackTrace`
cannot be assigned, so the instance records the stack trace of its first
throw, and a later throw keeps it.

## 1.214.0

### Fixed — a native closure resolves to the `Function` bridge (scf38)

A function type prints as `(params) => Ret`, and the name-shaped bridge
passes read its RETURN type. A host-built `(int x) => x` was claimed by the
`int` bridge and a `() => Map<String, Object>` tear-off by `Map`, so a member
read on the closure ran that bridge's adapters against a function: `f.length`
on the tear-off failed inside the Map bridge's cast. In the Flutter twins that
is every callback read off a host-built widget, since `(BuildContext) =>
Widget` matched `Widget`. A function value now resolves to the `Function`
bridge; only an exact registration for its type outranks that. Calling such a
closure stays a native call, with its arguments coerced as before (GEN-110):
the invocation sites no longer route a native function through the bridge's
`call`, which serves interpreted Callables.

Name resolution: yes — a native function value resolves to the `Function` bridge instead of the bridge named like its return type (scf38).

## 1.213.0

### Fixed — `obj.v++` and `++obj.v` on a bridged object's property (scf37)

`b.v += 1` worked on a bridged getter/setter pair, but `b.v++`, `b.v--`,
`++b.v` and `--b.v` threw `Cannot increment/decrement property on
non-instance object`: the four increment/decrement sites accepted only an
interpreted instance as the receiver. A bridged receiver now steps through
its getter and setter adapters, as the compound path does. The walk reaches
adapters the bridged class inherits (SCF19), and the step is computed by the
same `computeCompoundValue`. Postfix yields the old value, prefix the new; a
property with no setter is refused by name.

## 1.212.0

### Fixed — a surplus positional argument is an error, in every stdlib adapter (scf36)

SCE245's census measured 315 adapters per tree that read `positionalArgs[k]`
and never checked the length, so an extra argument was dropped in silence:
`Stream.value(1).asyncMap((x) => x + 1, 99)` yielded `[2]`,
`Stream.value(1).contains(1, 2)` answered `true`, `Error.safeToString(1, 2)`
formatted the `1`. Native Dart rejects all of these at compile time. Every
one now opens with `D4.checkArity(positionalArgs, '<Class>.<member>',
atMost: N)`.

N is the SDK's own positional count, read through `dart:mirrors` by
`tool/bound_surplus_arity.dart`. It is not the highest index the adapter
happens to read, so a member with an optional positional parameter keeps
accepting it. Two adapters turned out to ignore such a parameter, and now
honour it:
- `num.parse`'s `onError` is called with the input when the input does not
  parse.
- `Uri.parseIPv4Address` forwards `start` and `end`.

The census reports 0 unguarded adapters in both trees.

## 1.211.0

### Added — `scheduleMicrotask`, and the rest of the top-level surface nothing checked (scf35)

`scheduleMicrotask(() => ...)` failed with `Undefined variable`, and the name
was not recorded as deliberately unbridged either. It is now a `dart:async`
global. The callback runs under the discipline a Timer body uses: queued as a
real microtask, and an error it throws leaves unwrapped, so an embedder's
`onUncaughtError` receives what the script threw.

The gap existed because the SDK-surface guard (`scc73`) read only the
constructors and getters of classes. Its new axis, F-SCC73-5, reads every
public top-level function, getter and variable of the eight bridged `dart:`
libraries and resolves each from a script. On its first run it found four more
names, now bridged: `base64UrlEncode`, `unicodeBomCharacterRune` and
`unicodeReplacementCharacterRune` (`dart:convert`), and `systemEncoding`
(`dart:io`). Six names are deliberately not bridged, each with a recorded
reason: `exit`, `sleep`, `exitCode` and `pid` (`dart:io`), and the
`deprecated` / `override` annotation constants.

## 1.210.0

### Fixed — a script subclass of a concrete bridged class is recognised when native code hands it back (scf31)

`class _RenderMeasureBox extends RenderProxyBox` has no proxy: the base is
constructed natively and that native object is what the framework holds and
hands back — to `updateRenderObject(..., covariant _RenderMeasureBox r)`, or
through a viewport's `delegate` getter. Every check that asked for the script
class refused it (`type 'RenderProxyBox' is not a subtype of type
'_RenderMeasureBox'`), and `delegate as _TwoDMgrCountingDelegate` returned the
native base, which has none of the script's members.

Setting `InterpretedInstance.bridgedSuperObject` now records the pairing, and
`D4.interpretedBehind` answers for a bridged super object as it does for a
proxy. A parameter declared as the script class binds the INSTANCE, `as`
yields it, `is` answers for it, and `identical` / `==` treat the two as one
object. What crosses to native code is unchanged — handing the instance back
out yields the same native object — so layout and paint are untouched, which
is what the proxy-based attempts (SCE164) broke. An unrelated script class and
a base nobody subclassed are still refused.

`D4.ownerOfSuperObject` is new. `D4.registerInterpretedForNative` is now a
no-op for values an `Expando` cannot key on, instead of throwing.

## 1.209.0

### Fixed — four await-resumption routes that re-evaluated or dropped an await (scf29)

Measured with a `next()` that counts its calls:

- `=> add(await next(), await next())` answered 4 with three calls;
- `if (add(await next(), await next()) == 3)` took the false branch;
- `while (add(await next(), 0) < 2)` never ran its body;
- `s = (await next()) + (await next());` bound the first await's value and
  never evaluated the second.

Each now hands its unit back to the state machine so the resolved await sites
replay: an `=>` body's expression, and an `if` / `while` / `do` reached from
its condition, join the statements SCE139 re-runs (`_resumableNodeFor`), and
an assignment whose right-hand side is more than the await is re-run as
SCD121 re-runs a declaration. The machine's `if` / `while` / `do` branches end
the replay cache when their condition completes, so a loop condition does not
replay a previous iteration's values. The same reading of one await's value as
the whole condition broke `if ((await a) + (await b) == 3)` and
`while (!await f())`; both are re-entered the same way, and a prefix operator
now propagates an awaited operand's suspension instead of applying `!` to it.

## 1.208.0

### Changed — binding a typed collection is O(1) in its length (scf28)

SCD92 checks a declared `List<T>` / `Set<T>` / `Map<K, V>` against the type a
native collection's contents share, because a native collection carries no
element type the interpreter can read back. That derivation read every
element on every binding — parameters, typed locals, typed patterns, for-each
variables — about 0.096 us per element, half a millisecond per binding of a
5000-element list. It now reads the first `Environment.elementTypeSample` (8)
elements: the overhead of `List<int> v = c;` over `var v = c;` is flat at
about 4 us from 100 to 5000 elements, where it was 98 us and 474 us.

The bound is 8 because both suites pass at 2 and 4 and exactly one case
(a disagreement at index 1) fails at 1. One answer changes: a collection that
agrees for the whole prefix and disagrees later used to count as
heterogeneous and pass; it is now checked against the prefix's type, and
refused only when a prefix element is provably not the declared argument —
which Dart refuses too. A top-type argument (`List<dynamic>`) was already
exempt before any element is read.

## 1.207.0

### Fixed — a bounded generic class accepts its own constructor (scf27)

`class Box<T extends num> { final T v; Box(this.v); }` refused `Box(3)`:
a class type argument that is not written is not inferred, is filled with
`dynamic` — the interpreter's "unknown" — and that unknown was measured
against the bound. The bound is now checked for WRITTEN arguments only, as it
already was for generic functions: `Box(3)` constructs, and `Box<String>('a')`
and `Box<dynamic>(3)` are still refused with the unsatisfied-bound message. A
bounded mixin and a bounded extension type were not affected.

## 1.206.0

### Fixed — a bare name reaches the getter or setter it names (scf25)

Top-level accessors and a class's static ones (inside a static member, where
the class's statics resolve without a prefix) were bound as the getter and
setter FUNCTIONS under the plain name. So:

- a bare read of a getter answered the function — `int get g => 1;
  main() => g;` returned `<fn g>`;
- a bare write rebound the name and never called the setter — `s = 3` left
  `set s` unrun, and a static `set v` normalising its input was skipped;
- a getter and a setter of one name replaced each other;
- `++v` read through a getter and then overwrote its binding.

A setter is now bound under Dart's setter name, `v=` (`Environment.setterKey`),
which `show` / `hide` treat as `v`. A bare read of a getter calls it. A bare
write — `=`, compound, `??=`, `++` / `--` either side — calls the setter unless
a closer binding of `v` (a local, a parameter) shadows it. From an instance
method a bare write reaches a static setter in the class chain, as SCE125 made
it reach a static field.

Name resolution: yes — a bare name bound to a getter or setter now resolves to a call of it, and `v=` is a new binding a bare write consults (scf25).

## 1.205.0

### Fixed — a script class that declares no `toString` still has `Object`'s (scf24)

`class C {}` answered `hashCode`, `runtimeType`, `==` and `'$c'`, but an
explicit `C().toString()`, its tear-off and a call through an `Object`
parameter raised a no-such-method error naming a member the script correctly
did not write. So did `super.toString()` and `super.noSuchMethod(i)` from a
class whose superclass is `Object` — the forms an override commonly uses.

`InterpretedInstance.objectMember(name)` holds `Object`'s answers:
`toString` renders as `'$c'` does, without re-dispatching to a script
override, so `super.toString()` inside one cannot recurse; `noSuchMethod`
raises a catchable `NoSuchMethodError`. `InterpretedInstance.get` consults it
last, after the script's own members, mixins, interpreted supers and a
bridged super. `super` in a class whose superclass is `Object` binds to a new
`BoundObjectSuper`, and a `super` chain through interpreted classes that ends
at `Object` falls back to the same answers. A declared `toString` and a
bridged super's still win.

## 1.204.0

### Changed — a generic element is type-tested by the same predicate as `is` (scf22)

`[x] is List<T>` and `m is Map<K, V>` asked each element, key and value a
second, smaller copy of the type test. Every divergence found between the two
copies had been a defect in one of them, in both directions, so the element
checks now ask `_valueHasType` — the predicate behind `is`, typed patterns and
`on` clauses — and the second copy is gone.

**Three element-position answers change, each to what `is` already answers:**

- a type name the interpreter cannot resolve now fails as `x is Unknown`
  does — it raises the same error — where it used to answer `true`;
- a function or record element type (`List<int Function(int)>`,
  `List<(int, String)>`) is checked structurally, where any element used to
  match;
- `List<void>` is false for a non-empty list, where it used to be true.

`F-SCE101-10` (`tom_d4rt/test/sce101_element_type_test.dart`) holds the rule
over 14 values × 22 types: a one-element list is a `List<T>` exactly when its
element is a `T`.

## 1.203.0

### Fixed — an interpreted subclass reaches its bridged superclass's INHERITED members (scf19)

A bridge carries the members its class declares, so the `ListQueue` bridge
has `removeFirst` and no `elementAt` — that one is `Iterable`'s. A bare
`ListQueue()` reached it through the supertype walk; `class MyQ extends
ListQueue {}` did not, because every path from an interpreted instance to its
bridged superclass asked that bridge's own maps. `elementAt`, `first`, `map`,
`fold` were absent through `q.`, bare inside a method and `super.` alike, each
failing with a different exception type.

`BridgedClass.findReachableMethodAdapter` / `…GetterAdapter` /
`…SetterAdapter` return the bridge's own adapter, else the first registered
supertype bridge's, resolving supertype names in the visitor's environment.
They replace the own-map lookups on the bridged-superclass paths of
`InterpretedInstance.get` / `set` and of `super.` access, and the method
invocation path now supplies the visitor (`InterpretedInstance.getForInvocation`,
which leaves a miss to the invocation site's own `noSuchMethod` handling).

Name resolution: yes — a bare name inside an interpreted subclass of a bridged class now resolves to a member the bridged superclass inherits (scf19).

## 1.202.0

### Fixed — `break` / `continue` in an async body run the finallys they cross (scf6)

SCE18 fixed the `return` route; the jump route still went straight to its
target, so `for (..) { try { if (i == 1) break; } finally { log.add('f1'); } }`
never logged, and a `continue` skipped the finally for that iteration. The
synchronous visitor was always right and is the oracle.

A jump that leaves a try with a non-empty finally now parks on
`AsyncExecutionState.pendingJump` and runs the finallys between it and its
target, innermost first and nothing in between; after the last one it
completes exactly as before (loops left, next node). A `return`, a `throw`
that escapes the finally, or another jump that leaves it replaces the pending
jump, as in Dart; a jump or catch local to the running finally does not.

## 1.201.0

### Fixed — an `async*` generator obeys its listener (scf4)

A generator ran to completion whatever its subscriber did: `yield` added its
value and suspended on an already-completed future, and the stream controller
had no `onPause`/`onResume`/`onCancel`. So a consumer's `break` out of an
`await for` cancelled the subscription while the body ran on — SCE16 had fixed
the consumer's interleaving and left exactly this. Now:

- `yield` waits for the listener: one microtask so a consumer that pauses on
  receipt has done so, then for as long as the subscription is paused, which is
  `async*` backpressure.
- cancelling the subscription ends the body at its pending `yield` as if by
  `return`: `finally` blocks run, and no `catch` clause may claim it
  (`GeneratorCancelledSignal`, riding the same route as SCC31's uncatchable
  undefined name). `cancel()` completes once the body has finished.
- `yield*` stops forwarding once the listener is gone.

## 1.200.0

### Fixed — `e.hashCode` / `e.runtimeType` answer natively on a bridged value (sce239)

`visitPrefixedIdentifier` now answers `hashCode` and `runtimeType` on a
bridged value from the native object before consulting any member map, as
`visitPropertyAccess` already did (SCC78) and as `tom_d4rt_ast` has in both
places (GEN-075). A bridge that declared either one as a method (the shape
of SCD196's `MapEntry.hashCode` defect) made `e.hashCode` return the bound
method instead of an int in this tree, while `(expr).hashCode` and the
analyzer-free tree answered correctly. That was one line of mirror
divergence with a behavioural consequence.

## 1.199.0

### Changed — the unsupported-node message has one shape in both trees (sce236)

`visitNode` builds its message identically in this tree and in
`tom_d4rt_ast`. Only the excerpt helper differs: it still renders with the
analyzer's `toSource()`, now quoted by the helper itself. The text is
unchanged: `Source: '<excerpt>'.`

## 1.198.0

### Fixed — a class name is identical to the Type it denotes (sce234)

`identical(String, 'x'.runtimeType)` is now true, as in Dart, and
`identityHashCode(String) == identityHashCode('x'.runtimeType)` holds.
SCD198 had made the two equal with the same hash code, but not one object.
`identical` and `identityHashCode` already treat a native proxy and the
interpreted instance behind it as one object. A bridged class name and its
native `Type` now join that rule. Interpreted classes already agreed.
Different types still compare non-identical, and `identical(List,
[1].runtimeType)` is false, as it is in Dart.

Making every class-name expression evaluate to the native `Type` (the
todo's option (a)) was measured and not taken. Scripts can observe the
difference only through identity, and that option would have changed every
place that consumes a class name.

## 1.197.0

### Removed — the `num` bridge's instance members (sce233)

The `num` bridge no longer declares instance methods or getters. It keeps
`isAssignable`, `num.parse` and `num.tryParse`. Scripts see no change: every
`num` value is an `int` or a `double`, Dart forbids any other class to
implement `num`, and both of those bridges already declare every member. The
32 adapters removed had never run. A test now checks that `int` and `double`
keep declaring all of them. The member audits in both trees treat `num` as
sealed to those two heirs (`sealedToHeirs`), so they do not report its
members as unreachable.

Every other bridge that SCD197 recorded as unreachable is kept, and its
source says why beside its member maps. The measurement undercounted in two
ways:

- It stood one instance in for each bridged type. `Match` and
  `FileSystemEntity` are reached by values whose own class has no bridge: a
  `String.allMatches` result, and a `Link`.
- It followed bridged heirs only. An interpreted subclass of
  `LinkedListEntry` or `Error` reads inherited members through the bridged
  superclass.

## 1.196.0

### Changed — `BridgedInstance.get` reads bridged getters (sce232)

`BridgedInstance.get` now resolves a member in the same order as the
interpreter's property readers: bridged getter first, then the bound instance
method, then `name` / `index` on a wrapped enum. It used to look up methods
only, so a getter-only name threw `UndefinedMemberD4rtException`. The 1.195.0
note that `set` works "as `get` reads through the getter" was not true when it
was written, and is true from this release.

`get` takes an optional visitor and passes it to the getter adapter, as `set`
already did for setters. The change is invisible to scripts:

- the full `tom_d4rt` suite (4 416 tests) never calls this method;
- no name may be both a getter and a method on one class
  (`scd196_member_map_disjointness_test.dart`), so no method name answers
  differently;
- none of the 824 stdlib or 20 901 Flutter getters reads its visitor.

Measured 2026-09-29. The change matters to host code that calls the primitive
directly. Comments at both reader sites point back to this method.

## 1.195.0

### Fixed — the interpreter no longer announces gaps that are not gaps (sce223)

- `await` accepts a non-Future (`await 5` is 5, `await null` is null) and
  still yields to the event loop, as Dart does. It was refused as an error.
- `BridgedInstance.set` assigns through the bridged setter, as `get` reads
  through the getter; a missing setter is an undefined member. It threw "not
  implemented" whatever the class declared.
- `o.x = await f()` / `l[i] = await f()` no longer log "Resumption for simple
  assignment to complex LHS not implemented" — that path IS the
  implementation, and it evaluates each side once.
- `for (var i = await f(), j = 0; ...)` stays unsupported, now saying exactly
  that shape and the workaround (declare the awaited variable before the
  loop).
- An `await` in a `super(...)` / `this(...)` initializer is reported as what it
  is — a constructor cannot be async — instead of "not yet supported".

## 1.194.0

### Fixed — `pipe` accepts the consumers a script can hold (sce217)

`Stream<X>.pipe(StreamConsumer<X>)` is a typed call, and Dart generics are
covariant, so a consumer passed only if its element type is a subtype of `X`.
No consumer a script holds is one: a script's `StreamController()` is
`StreamController<dynamic>`, and an `IOSink` (a file's `openWrite()`, a
`Socket`) is `StreamConsumer<List<int>>` where a socket streams `Uint8List`.
So `socket.pipe(controller)` and the proxy `client.pipe(upstream)` threw a raw
`_TypeError` — through `Socket.pipe`'s own guard-then-cast copy AND through the
inherited `Stream.pipe` adapter. The `Socket` copy is deleted; `Stream.pipe`
now runs the SDK's own body (`addStream`, then `close`) via the new
`D4.pipeStream`, with the consumer's `addStream` dispatched dynamically. A
consumer of an unrelated element type still fails inside its own `addStream`.

## 1.193.0

### Changed — `fuse` says why a script-defined converter is refused (sce216)

A `Converter` or `Codec` a script defines is an interpreted instance, not a
native one, and `fuse` builds a native pipeline the interpreter does not run,
so every bridged `fuse` refuses it — a deliberate limit, not an erasure bug.
The refusal used to read "requires another Converter<String, dynamic> as
argument", which looked exactly like the SCD181 erasure defect. All twenty
bridged `fuse` guards now go through one helper
(`stdlib/convert/fuse_argument.dart`): a script-defined argument is told it
cannot be fused and to call `convert` on each stage; any other wrong argument
keeps the plain type requirement. Native-to-native fusion is unchanged.

## 1.192.0

### Fixed — a coercion error inside `WebSocketTransformer.bind` reaches the script (sce208)

`D4.coerceStream` turns a wrongly typed element into an error event on the
mapped stream. Eleven of the twelve bridged consumers of a coerced stream
forward that error to the script; `WebSocketTransformer.bind` did not — the
SDK transformer listens to its source with no `onError`, so the diagnostic
went to the zone and the bound stream never produced another event: the
script hung. The bridge now binds through the new
`D4.bindForwardingSourceErrors`, which splits source errors off before the
native consumer and merges them into its output. `await upgraded.first`
throws the diagnostic, a listener's `onError` receives it, and the stream
keeps serving the next request. No eager check — nothing is drained ahead of
the consumer.

## 1.191.0

### Changed — `dart:io` imports with EITHER FilesystemPermission or NetworkPermission (sce206)

`dart:io` holds the filesystem and every network class, but its import gate
asked only for filesystem access, so a script granted `NetworkPermission`
alone could not import the library its grant is for. The gate now admits
either capability (decision (a)); no existing grant loses anything. The
per-operation gates do the enforcing — `NetworkPermission` on every
socket-acquiring call (SCD170), `FilesystemPermission` on every file
operation — so a network-only script can name `File` and still cannot touch
one. The refusal with neither now names both permissions.

## 1.190.0

### Fixed — a `rethrow` runs its own try's `finally` first (sce205)

`try { … } catch (e) { rethrow; } finally { cleanup(); }` propagated the right
exception and never ran `cleanup()` — in synchronous AND async functions, for
two unrelated reasons. The synchronous `visitTryStatement` relaunched the
rethrow from inside the catch handling, before reaching the finally; it now
holds it and throws it on after the finally, like an unhandled exception. The
async `_handleAsyncError` advanced its search past the owning try outright
(SCD41's skip); it now keeps an owner that has a non-empty finally, and
SCD169's rule — no clause of a try may match an error from its own catch —
runs that finally and releases the error outward. F-SCE205-1..4 in
`scc12_await_in_finally_test.dart` pin the sync, async and nested orders and a
non-rethrowing control, each self-limiting against a re-entry spin.

## 1.189.0

### Documented — why `HashMap` and `LinkedHashMap` keep their `Map` shadows (sce203)

Both bridges re-declare `Map` members (`cast`, `removeWhere`, `update`,
`updateAll`, …) that `SplayTreeMap` leaves to the supertype walk. Their class
docs now record that this is kept on purpose: the drift hazard is measured by
the SCC51 shadow differential, and family parity is measured over REACHABLE
members by the new `sce203_family_reachable_parity_test.dart`, where only the
SDK's own interface differences (`SplayTreeMap`'s sorted-map API,
`DoubleLinkedQueue`'s entry API) separate the collection families. No
behaviour changes.

## 1.188.0

### Changed — the eleven typed-data lists share one getter map (sce202)

Ten typed-list bridges guarded each of their eleven getters with a
wrong-target `RuntimeD4rtException`; `Uint8List` used a bare cast. Measured
before deleting: all 176 guard branches (both trees) were instrumented, and
4 092 interpreted calls — every variant, built six ways (including views and
`sublistView`), through five static types — plus both full suites reached
none. Dispatch selects the bridge from the value's own class and no variant
subtypes another, so the branches were dead. They are gone; all eleven
variants now take `length`, `lengthInBytes`, `elementSizeInBytes`,
`offsetInBytes`, `buffer`, `first`, `last`, `isEmpty`, `isNotEmpty`,
`hashCode` and `runtimeType` from the shared `typedListGetters`, whose
comment records the measurement. No behaviour a script can reach changes.

## 1.187.0

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

## 1.186.0

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

## 1.185.0

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

## 1.184.0

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

## 1.183.0

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

## 1.182.0

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

## 1.181.0

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

## 1.180.0

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

## 1.179.0

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

## 1.178.0

### Deprecated — the bridge-mapping types nobody ever used (sce155)

`LibraryBridgeDefinition`, `BarrelMapping` and `ModuleBridgeInfo` in
`lib/src/bridge/library_mapping.dart` describe a RUNTIME answer to barrel
re-export deduplication: group bridged elements by the canonical library they
came from, record which source libraries each barrel re-exports, let the
interpreter recognise one element reached two ways.

That deduplication happens — in the other layer. `PerPackageBridgeOrchestrator`
in `tom_d4rt_generator` maps each source file to the barrel exporting it and
emits one per-package bridge file plus delegating barrels, so the duplicate
never reaches the runtime to be deduplicated. These types are a SUPERSEDED
design, not an unfinished one, and there is no intent to recover.

MEASURED RATHER THAN PRESUMED, in both directions. Workspace-wide, the only
`.dart` files naming any of the three are the declaring file and the two guards
that record them as dead. Outside it, pub.dev lists exactly four dependents of
`tom_d4rt` — `tom_d4rt_generator`, `tom_d4rt_exec`, `tom_d4rt_dcli`,
`tom_d4rt_flutter`, every one of them from this workspace — and no cached
release of any of the four names one of these types. The API has never had a
consumer anywhere.

Deprecated rather than deleted: it is on a published surface and removal is
breaking whether or not anybody is hurt. Removal is due at 2.0.0 and is not
left to memory — `test/sce155_dead_surface_removal_test.dart` fails the moment
this package's major reaches 2 with the file still present, and separately when
a deprecation stops naming the release that removes it. A todo saying "remove
at 2.0.0" would sit unread until the one release it applied to; a red test
cannot.

Name resolution: no — three unused data classes gain an annotation.

## 1.177.0

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

## 1.176.0

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

## 1.175.0

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


## 1.174.0

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

## 1.173.0

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

## 1.172.0

### Fixed — two holes in the static name resolver (sce128, phase 2 groundwork)

SCE128 wired SCD95's report-only pass to the environment and let it REFUSE a
program, then ran it over the reference suite — a broader corpus than either of
phase 1's sweeps. Enforcement is NOT landed (see the todo); what is landed is
what that run found.

TWO FALSE-POSITIVE CLASSES, both structural:

* A LABEL REFERENCE. The declaration is a `Label` node and was excluded; the
  `outer` in `break outer;` is a bare `SimpleIdentifier` under a
  `BreakStatement`, so it read as an undefined name. The most frequent false
  positive by a wide margin.
* AN EXTENSION TYPE'S REPRESENTATION. Its members read the representation bare
  — `int get doubled => value * 2` — and nothing recorded it as declared, so
  every such read was reported, twelve distinct members across the suite
  including the operator ones.

An extension type is now an OPEN class alongside mixins and extensions, because
it `implements` types that can leave the unit. That buys correctness at the
price of reach, and F-SCD95-13 states the trade rather than leaving it to be
discovered.

MEASURED, both sweeps re-run: the inline sweep goes to 1045 clean of 1069
(phase 1: 799 of 807, on a smaller corpus) and the flutter sweep to 2083 clean
of 2085 with ONE dirty, down from two. Every remaining flag was read and is a
true positive — a deliberately undefined name, an out-of-scope `catch` binding
used after its block, or an intentionally-unbridged SDK type.

The pass remains REPORT-ONLY; `execute()` does not call it.

Name resolution: no — the pass is not wired into execution.

## 1.171.0

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

## 1.170.0

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

## 1.169.0

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

## Older releases

Releases 1.77.0 and earlier are in [CHANGELOG_ARCHIVE.md](CHANGELOG_ARCHIVE.md).
pub.dev refuses a `CHANGELOG.md` over 262144 bytes, and this file crossed that
limit on 2026-09-28 (SCE209); the history was moved rather than shortened.
