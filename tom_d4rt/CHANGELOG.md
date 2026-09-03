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