## 0.210.0

### Added — a browser test (dfin8)

`test/web/bundle_in_browser_test.dart` decodes a bundle the analyzer front end
produced and `dart:io` gzipped on a host, then runs it, compiled to JavaScript
(`dart test -P browser`, Chrome). `dart_test.yaml` keeps the default platform
`vm`, so a host without Chrome passes the suite.

### Fixed — integers are typed `int`, not `double`, on the web (dfin8)

`Environment.getRuntimeType` tested `is int` and then `is double` with no
`else`, so the later test won. Compiled to JavaScript every number is a double
and `1 is double` is true there, so every integer was typed `double`, and
`[1, 2]` was refused where a `List<int>` parameter is declared. The test chain
now stops at the first match, with `int` before `double`. No change on the VM,
where `1 is double` is false. Found by tom_d4rt_ast's new browser test.

Name resolution: no.

## 0.209.0

### Changed — a module exports only its own declarations and its `export`s (dfin6)

BREAKING for a script that relied on the leak. A module's exported environment
used to receive its whole module environment, imports included, so with
`main -> a -> b` the entry could call a name only `b` declares. Dart rejects
that ("Undefined name"), and so does the interpreter now: an importer sees what
the module declares at its top level plus what its `export` directives name
(with their `show` / `hide`). Cyclic imports still load. Unnamed extensions are
still carried, as before.

Name resolution: yes — names an import of an import declares are no longer visible to the importer (dfin6).

## 0.208.0

### Fixed — `Record` is a type; record parameters are checked; the cast message names the type (dfin5)

`x is Record` raised "Undefined variable: Record", and a `Record` return or
parameter type raised "Type 'Record' not found.", although every record is a
`Record` in Dart. Both now work, and `x as Record` refuses a non-record
(dguc7). A RECORD-typed parameter is now checked structurally:
`sum((int, int) p)` called with `('a', 2)` raises
`type '(String, int)' is not a subtype of type '(int, int)' of 'p'`.
FUNCTION-typed parameters stay unchecked on purpose: the interpreter infers no
context type for a closure literal, so a structural check would refuse correct
callbacks (dguc8). A failed cast to a record or function type names the type
as Dart writes it, "(String, int)" or "String Function(int)", where it named
the AST node class ("SRecordTypeAnnotation").

### Changed — a missing module is a SourceCodeD4rtException (dfin5, dgub20)

The bundle loader raised `RuntimeD4rtException` for a module not in the
bundle, where tom_d4rt and tom_d4rt_exec raise `SourceCodeD4rtException` for
the same condition. It now raises the latter, so one `on` clause catches it on
every line.

Name resolution: yes — `Record` resolves in `is`, `as` and type annotations (dfin5).

## 0.207.0

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

## 0.206.0

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

## 0.205.0

### Added — `D4rtRunner.lastErrorTrace` and `D4rtCallStack` (woneprpd153)

The twin of tom_d4rt 1.222.0's interpreted call stack. Positions come from the
bundle's sources (`locateNode`); a bundle built without them yields an empty
trace rather than a wrong one.

Name resolution: no.

## 0.204.0

### Added — `Environment.isDefined` (scg6)

The non-evaluating twin of `lookup`: whether a name is defined anywhere in
the chain, without calling a registered global getter. Mirrors tom_d4rt
1.220.0, whose pre-`main` static-name check uses it.

Name resolution: yes — the environment half of tom_d4rt 1.220.0's pre-`main` undefined-name check (`isDefined`); the static pass itself resolves over the analyzer AST and runs in tom_d4rt only (scg6).

## 0.203.0

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

## 0.202.0

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

## 0.201.0

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

## 0.200.0

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

## 0.199.0

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

## 0.198.0

### Fixed — `obj.v++` and `++obj.v` on a bridged object's property (scf37)

`b.v += 1` worked on a bridged getter/setter pair, but `b.v++`, `b.v--`,
`++b.v` and `--b.v` threw `Cannot increment/decrement property on
non-instance object`: the four increment/decrement sites accepted only an
interpreted instance as the receiver. A bridged receiver now steps through
its getter and setter adapters, as the compound path does. The walk reaches
adapters the bridged class inherits (SCF19), and the step is computed by the
same `computeCompoundValue`. Postfix yields the old value, prefix the new; a
property with no setter is refused by name.

## 0.197.0

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

## 0.196.0

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

## 0.195.0

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

## 0.194.0

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

## 0.193.0

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

## 0.192.0

### Fixed — a bounded generic class accepts its own constructor (scf27)

`class Box<T extends num> { final T v; Box(this.v); }` refused `Box(3)`:
a class type argument that is not written is not inferred, is filled with
`dynamic` — the interpreter's "unknown" — and that unknown was measured
against the bound. The bound is now checked for WRITTEN arguments only, as it
already was for generic functions: `Box(3)` constructs, and `Box<String>('a')`
and `Box<dynamic>(3)` are still refused with the unsatisfied-bound message. A
bounded mixin and a bounded extension type were not affected.

## 0.191.0

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

## 0.190.0

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

## 0.189.0

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

## 0.188.0

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

## 0.187.0

### Changed — the runner's warm parent registers bridge TYPES only (scf9)

`D4rtRunner`'s warm parent used to be a name baseline: every bridged class,
enum, function, variable and accessor of every registered library was bound
into one environment that every script encloses. So a bare name the script
never imported still resolved — to whichever library declared it, or to an
ambiguity between libraries the script never named — and
`executeBundleAs` answered where `tom_d4rt_exec`'s `execute(source:)` said
`Undefined variable`, for the same registration and the same program.

It now registers the type lookup alone (`registerBridgeTypeLazy`), which is
what `toBridgedInstance` needs, as `tom_d4rt`'s warm parent always has. A
script's bare names come from its imports, as in Dart.

**A host whose bundles name a bridged class they do not import will now see
`Undefined variable`.** Add the import the name comes from. Measured before
the switch: the AST base corpus lost no script to an undefined name.

Name resolution: yes — a bare bridged name resolves only through the script's imports; the warm parent no longer binds every registered name (scf9).

## 0.186.0

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

## 0.185.0

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

## 0.184.0

### Fixed — an unsupported construct names where it is in the script (sce236)

The "Unsupported AST node" error gave only a node type and an offset. Someone
running a bundle compiled elsewhere has no file to count that offset into. It
now ends with `Source: ...`:

- when the bundle carries its sources: `'<excerpt>' (<module uri>:<line>:<column>)`;
- when it does not: the module URI and offset, and how to get the excerpt.

The module is found by walking the loaded modules for the node **by
identity**. An offset is only meaningful within one module, and mirror nodes
compare structurally. `AstModuleLoader` takes the bundle's optional
`sources`, and `D4rtRunner` passes `bundle.sources` to it.
`describeNodeSource` and `moduleContaining` are exported for host code that
reports its own errors about a node.

## 0.183.0

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

## 0.182.0

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

## 0.181.0

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

## 0.180.0

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

## 0.179.0

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

## 0.178.0

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

## 0.177.0

### Fixed — an async `rethrow` after a nested try inside the catch reaches the outer catch (sce212)

```dart
try {
  try { throw StateError('x'); }
  catch (e) {
    try { await Future.value(0); } finally { log.add('if'); }
    rethrow;
  }
} catch (e) { log.add('oc'); }
```

escaped the function instead of reaching the outer `catch`. When a rethrow
leaves its owning try, `_handleAsyncError` searched for the next enclosing try
starting from `state.activeTryStatement` — the mutable field SCD41 had already
stopped trusting for the ownership test, and which a try completing inside the
catch leaves pointing elsewhere. The search now starts from the owner itself,
structurally, as `tom_d4rt` always did. Found by porting exec's copy of
`scc12_await_in_finally_test.dart` (F-SCD41-7) once exec could resolve a
current interpreter; `tom_d4rt` was never affected.

## 0.176.0

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

## 0.175.0

### Changed — `dart:io` imports with EITHER FilesystemPermission or NetworkPermission (sce206)

`dart:io` holds the filesystem and every network class, but its import gate
asked only for filesystem access, so a script granted `NetworkPermission`
alone could not import the library its grant is for. The gate now admits
either capability (decision (a)); no existing grant loses anything. The
per-operation gates do the enforcing — `NetworkPermission` on every
socket-acquiring call (SCD170), `FilesystemPermission` on every file
operation — so a network-only script can name `File` and still cannot touch
one. The refusal with neither now names both permissions.

## 0.174.0

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

## 0.173.0

### Documented — why `HashMap` and `LinkedHashMap` keep their `Map` shadows (sce203)

Both bridges re-declare `Map` members (`cast`, `removeWhere`, `update`,
`updateAll`, …) that `SplayTreeMap` leaves to the supertype walk. Their class
docs now record that this is kept on purpose: the drift hazard is measured by
the SCC51 shadow differential, and family parity is measured over REACHABLE
members by the new `sce203_family_reachable_parity_test.dart`, where only the
SDK's own interface differences (`SplayTreeMap`'s sorted-map API,
`DoubleLinkedQueue`'s entry API) separate the collection families. No
behaviour changes.

## 0.172.0

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

## Older releases

Releases 0.90.0 and earlier are in [CHANGELOG_ARCHIVE.md](CHANGELOG_ARCHIVE.md).
pub.dev refuses a `CHANGELOG.md` over 262144 bytes, and this file crossed that
limit on 2026-09-28 (SCE209); the history was moved rather than shortened.
DFIN7 moved 0.66.0 to 0.90.0 as well (2026-10-03), when the file
reached 256 KB again.
