# Error analysis with actionable fix measures — `20260502-1010-consol-rebaseline`

Companion to [`README.md`](README.md). The README documents totals
and deltas vs the 0429 baseline; this document is a per-failure
**fix manual** with concrete file paths, expected emission diffs,
and recommended priority order.

| Field | Value |
| --- | --- |
| Run ID | `20260502-1010-consol-rebaseline` |
| Date | 2026-05-02 (~10:12 CEST) |
| Git revision | `4941d1f5` (`main`) |
| Scope | Seven non-flutter d4rt-repository projects |
| Totals | 6075 / 6016 pass / 52 fail / 1 skip / 6 errors |
| Net vs 0429 | **−9 fail / +2 err / +88 tests** |

---

## Cross-cutting clusters (read this first)

The 52 + 6 reds collapse to **12 root causes**. Fixing the cluster
listed first eliminates the largest number of failures. Each
cluster names its sites; per-project sections below quote the exact
runtime error string for each test.

### Cluster CB — Callback-wrapping generator regressed (10 fails) — **CLOSED 2026-05-02**

Sites: `tom_ast_generator` (5), `tom_d4rt_exec` (5), `tom_d4rt_generator` (3).

Symptom (representative — `G-CB-11`):

> `Expected: contains 'as bool'` — actual emission was
> `D4.extractBridgedArg<bool>(...)` instead of `... as bool`.

Affected test IDs (same set across all three projects):
`G-CB-2a`, `G-CB-7`, `G-CB-11`, `G-CB-12`, `DCL-CLS-002`.

**Actual root cause — two distinct issues.**

1. **Primitive return casts replaced with `extractBridgedArg`.**
   Commit `e8275a4a` (Cluster 10 partial — GEN-081b) replaced the
   legacy `as $castType` emission in `_generateFunctionWrapper`
   (`tom_d4rt_generator/lib/src/bridge_generator.dart`) with
   `D4.extractBridgedArg<$castType>(callExpr, 'callback', visitor)`
   so script-returned `InterpretedInstance` values get routed through
   the registered interface-proxy factory. This is correct for class
   return types but unnecessary for primitive returns (`bool`, `int`,
   `double`, `num`, `String`) — primitives can never be
   `InterpretedInstance` values, so the simple cast is sufficient and
   keeps the legacy assertion shape green. (G-CB-7, G-CB-11, G-CB-12
   all fail purely on the missing `as <Type>` substring.)

2. **Stale `visitor,` expectations in the duplicated tests.** The
   downstream copies of the callback tests in `tom_ast_generator/`
   and `tom_d4rt_exec/` asserted on `D4.callInterpreterCallback(visitor,`
   while the generator (correctly, by design) emits `(visitor!, …)`
   inside bridged-method adapters because the adapter signature has a
   nullable `Visitor?` parameter. The canonical `tom_d4rt_generator`
   test already asserts the `visitor!,` form. (G-CB-2a, DCL-CLS-002
   in the two downstream projects.)

**Fix applied.**

1. `tom_d4rt_generator/lib/src/bridge_generator.dart`:
   added `_isPrimitiveCastType(String)` helper that detects `bool`,
   `int`, `double`, `num`, `String` plus their nullable variants;
   in `_generateFunctionWrapper` the non-`List`, non-`skipCast`
   branch now emits `{ return $callExpr as $castType; }` for
   primitive returns and keeps the GEN-081b
   `D4.extractBridgedArg<$castType>` path for class returns.
2. `tom_ast_generator/test/generator_tests/callback_wrapping_test.dart`,
   `tom_ast_generator/test/generator_tests/dcli_bridge_gaps_test.dart`,
   `tom_d4rt_exec/test/generator_tests/callback_wrapping_test.dart`,
   `tom_d4rt_exec/test/generator_tests/dcli_bridge_gaps_test.dart`:
   updated the four `contains('D4.callInterpreterCallback(visitor,')`
   assertions to `contains('D4.callInterpreterCallback(visitor!,')`
   to match the canonical generator emission shape (and the
   `tom_d4rt_generator` test's existing assertion).

**Verification.**

- `tom_d4rt_generator`: `dart test test/callback_wrapping_test.dart` →
  15/15 pass; `dart test test/dcli_bridge_gaps_test.dart` →
  16/16 pass; full suite +561 -6 (no Cluster CB residue; remaining
  failures are FLP-/DOV3-/coverage-flake from other clusters).
- `tom_ast_generator`: full suite +415 -2; only G-DOV2-7 (other
  cluster) and a G-DCLI-03 text-file-busy flake remain. All five
  baseline Cluster CB G-CB failures resolved.
- `tom_d4rt_exec`: full suite +2158 -9. All 5 Cluster CB G-CB
  failures resolved (and the prior turn's 14 G-DCLI Digest
  failures stay closed). Remaining 9 failures: `I-MISC-40/41`
  (Export), `I-COLL-25` (HashSet), `G-DOV2-7` (DOV2),
  `I-FILE-36/38` (Introspection), `DCL-RT-OPT-02`, `I-BUG-14a`
  (records, won't fix), and the d4rt_coverage_test text-file-busy
  flake — none of these are Cluster CB.

Net delta across three projects: **-13 failures** (3 in
`tom_d4rt_generator`, 5 in `tom_ast_generator`, 5 in
`tom_d4rt_exec`).

### Cluster DIGEST — `Digest` type missing in `tom_d4rt_exec/example/d4` (14 fails) — **CLOSED 2026-05-02**

Sites: `tom_d4rt_exec` only — accounted for **14 of the 25
exec failures**.

Symptom (every `G-DCLI-01..14` exec failure):

> `Runtime Error: Errors during bridge registration: - Could not
> resolve type 'Digest' for extension 'DigestHelper'.` raised from
> `ModuleLoader._fetchModuleSource (tom_d4rt_exec/src/module_loader.dart:936)`.

**Initial hypothesis (incorrect).** The original analysis assumed
the d4 example was missing a `BridgedClass` registration for
`crypto.Digest`. Investigation showed this hypothesis was wrong:
both `tom_d4rt_generator/example/d4/lib/src/d4rt_bridges/dcli_bridges.b.dart`
(passing) and `tom_d4rt_exec/example/d4/lib/src/d4rt_bridges/dcli_bridges.b.dart`
(failing) reference `Digest` only as the `onTypeName` of an
extension and neither emits a `BridgedClass` for it. The bridge
configs are identical for this concern.

**Actual root cause — runtime divergence in `module_loader.dart`.**
The analyzer-based `tom_d4rt/lib/src/module_loader.dart` (used by
`tom_d4rt_generator`'s d4rt_tester) and the analyzer-free
`tom_d4rt_exec/lib/src/module_loader.dart` (used by
`tom_d4rt_exec`'s d4rt_tester) diverged on what to do when a
bridge package's extension targets an unresolvable on-type:

- `tom_d4rt/lib/src/module_loader.dart:409-413` — warn and
  `continue;`. Non-fatal silent skip. A bridge package may declare
  `extension DigestHelper on Digest` even if `Digest` was never
  bridged; if the consumer script never calls a method exposed by
  the extension, no error should fire.
- `tom_d4rt_exec/lib/src/module_loader.dart:901-907` (pre-fix) —
  warn AND add to `registrationErrors`, which the surrounding code
  raises as `RuntimeD4rtException('Errors during bridge
  registration:\n…')` when `collectRegistrationErrors == false` (the
  default for `execute()`). This aborts script execution at import
  time before any user code runs.

Because all 14 G-DCLI test scripts import dcli (which transitively
re-exports `crypto.Digest` via dcli's own `digest_helper.dart`
extension), every one of them tripped the fatal path before
`main()` could run.

**Fix landed at `tom_d4rt_exec/lib/src/module_loader.dart:899-924`:**

```dart
if (onType == null) {
  Logger.warn(
      " [execute] Could not resolve type '${definition.onTypeName}' for extension '$extName'. "
      "Extension will not be registered.");
  if (collectRegistrationErrors) {
    registrationErrors.add(
        "Could not resolve type '${definition.onTypeName}' for extension '$extName'.");
  }
  continue;
}
```

The flag-gated branch keeps the validation contract: in
**execute mode** (`collectRegistrationErrors == false`) the
unresolved on-type is a non-fatal skip, matching `tom_d4rt`'s
GEN-100 lane. In **validate mode**
(`collectRegistrationErrors == true`, set by
`D4rt.validateRegistrations`) the error is still surfaced — which
is exactly what `GEN-056d: Extension on unknown type reports
error.` asserts. Without that branch the GEN-056d test would
regress.

**Verification (2026-05-02).**

- `dart test test/generator_tests/d4rt_tester_test.dart` —
  28/28 pass (was 14 of 28 G-DCLI failing).
- `dart test test/bridge/extension_on_stdlib_type_test.dart -n
  "GEN-056d"` — passes (would regress under a blanket
  warn-and-skip).
- Full `dart test` in `tom_d4rt_exec`: **14 reds** vs the 26
  baseline (Δ −12). All 14 G-DCLI tests removed; the residual
  reds are pre-existing other clusters
  (CB ×5, EXPORT ×2, INTROSPECT ×2, HASHSET ×1 error, plus
  G-DOV2-7, DCL-RT-OPT-02, I-BUG-14a Won't-Fix), unchanged by
  this fix.

**Cross-sync note.** `tom_d4rt_ast` has no `module_loader.dart`
of its own — the loader is a tom_d4rt_exec concern. So this fix
does not need a tom_d4rt_ast mirror. The conceptual contract
(`unresolved on-type ⇒ non-fatal skip in execute mode, reported
in validate mode`) is now consistent between the two existing
loaders (`tom_d4rt/lib/src/module_loader.dart` and
`tom_d4rt_exec/lib/src/module_loader.dart`).

### Cluster EXPORT — Export-conflict detection missing (4 fails) — **CLOSED 2026-05-02**

Sites: `tom_d4rt` (`I-MISC-40`, `I-MISC-41`), `tom_d4rt_exec`
(`I-MISC-40`, `I-MISC-41`).

Symptom:

- `I-MISC-40`: expected throw with `'Name conflict in environment:
  Symbol 'commonName' is already defined'` — actual call returned
  `'Hello from Local commonName'` (silent shadowing).
- `I-MISC-41`: expected throw with `'Name conflict in environment:
  Symbol 'conflictingSymbol' is already defined'` — actual threw
  `Undefined variable: conflictingSymbol` from
  `interpreter_visitor.dart:445` (`tom_d4rt`) /
  `interpreter_visitor.dart:480` (`tom_d4rt_ast`).

**Actual root cause.** `Environment.importEnvironment` had only
*import-wins* semantics — when merging a foreign environment, a
duplicate symbol silently overwrote the existing one. That is the
correct behaviour for the `import` directive (later imports shadow
earlier ones; GEN-100 / Cluster A relies on it), but it is wrong
when the *same* function merges re-exported symbols during library
construction. For an `export` directive, two libraries publishing
the same name under the same library is a hard error and must
raise immediately at load time.

A second consequence: when both re-export merges silently
overwrote each other in alternating order, the symbol ended up
absent from the published library entirely (because the *last*
write replaced a key the lookup path didn't know about), which is
why `I-MISC-41` surfaced as `Undefined variable` rather than
`'Hello A'` / `'Hello B'`.

**Applied fix.**

1. Added an opt-in `errorOnConflict: bool = false` parameter to
   `Environment.importEnvironment` in both
   `tom_d4rt/lib/src/environment.dart` and
   `tom_d4rt_ast/lib/src/runtime/environment.dart`. When set, the
   six conflict-check branches (values × 2, bridgedClasses × 2,
   bridgedEnums × 2 — same-name and cross-type) raise
   `RuntimeD4rtException('Name conflict in environment: Symbol '<n>' is already defined.')`
   instead of overwriting / silently skipping. Default `false`
   keeps the existing import-wins semantics intact for the
   `import` path (no GEN-100 / Cluster A regression).
2. Wired `errorOnConflict: true` at the **three** re-export merge
   call sites:
   - `tom_d4rt/lib/src/module_loader.dart` (analyzer-based loader,
     re-export merge into `exportedEnvironment`).
   - `tom_d4rt_ast/lib/src/runtime/ast_module_loader.dart`
     (AST-based loader, `_processExports` re-export merge).
   - `tom_d4rt_exec/lib/src/module_loader.dart` (the third loader
     that uses `tom_d4rt_ast`'s `Environment` but has its own
     export-directive processing — initially missed; tom_d4rt_exec
     `I-MISC-40/41` only flipped to green once this site was
     patched).
3. Cross-sync rule honoured — analyzer and AST copies of
   `Environment` and the loaders are byte-equivalent (modulo
   tom_d4rt_ast's trailing-comma style).

**Verification.**

- `tom_d4rt`: `dart test test/export_test.dart` → 6/6 pass; full
  suite +1738 -8 (was -10, Δ = -2).
- `tom_d4rt_exec`: `dart test test/export_test.dart` → 6/6 pass;
  full suite +2253 -7 (was -9, Δ = -2; `I-MISC-40/41` gone).
- `tom_d4rt_ast`: full suite unchanged at +115 -2 (only the
  pre-existing `STDLIB-PI` errors remain — distinct cluster).
- `dart analyze` on the five edited files: no new warnings or
  errors.

Net cluster impact: −4 reds (-2 in `tom_d4rt`, -2 in
`tom_d4rt_exec`).

### Cluster EXTTYPE — Extension types not registered (2 fails) — **CLOSED 2026-05-02**

Sites: `tom_d4rt` (`I-FILE-47`), `tom_d4rt_generator` (`G-DOV3-1`).

Symptom: `Undefined variable: UserId` when an extension type is
declared and then referenced as a type:

```dart
extension type UserId(int value) {}
final id = UserId(42);  // throws Undefined variable: UserId
```

**Actual root cause.** The original analysis blamed the
declaration visitor — but `visitExtensionTypeDeclaration` already
exists in `InterpreterVisitor` (both copies) and registers the
wrapper type correctly when invoked. The real defect is that the
**pass-2 dependency-ordered loops never visit
`ExtensionTypeDeclaration` nodes**. The loops in
`tom_d4rt/lib/src/d4rt_base.dart` (`_executeInEnvironment` and
`_executeClassic`), `tom_d4rt/lib/src/module_loader.dart`
(imported-module pass), `tom_d4rt_ast/lib/src/runtime/d4rt_runner.dart`
(`_executeInEnvironment`), and
`tom_d4rt_ast/lib/src/runtime/ast_module_loader.dart`
(`_interpretDeclarations`) explicitly enumerate
`EnumDeclaration → ClassDeclaration|MixinDeclaration →
ExtensionDeclaration → FunctionDeclaration →
TopLevelVariableDeclaration` and have **no step for
`ExtensionTypeDeclaration`**, so the extension-type AST nodes are
silently dropped during interpretation. `main()` then resolves
`UserId(42)` against an environment where `UserId` was never
registered.

**Fix.** Add a `// 3b. Extension type declarations` step after the
existing extension pass at all five sites:

1. `tom_d4rt/lib/src/d4rt_base.dart` — both
   `_executeInEnvironment` (line ~1207) and `_executeClassic`
   (line ~1474).
2. `tom_d4rt/lib/src/module_loader.dart` — after the
   `ExtensionDeclaration` pass for imported modules
   (line ~702).
3. `tom_d4rt_ast/lib/src/runtime/d4rt_runner.dart` — pass-2 loop
   (line ~922).
4. `tom_d4rt_ast/lib/src/runtime/ast_module_loader.dart` —
   `_interpretDeclarations` (line ~838).

`analyze()` and `eval()` paths use blanket-visit loops so they
already pick up extension-type nodes — no change needed there.

**Verification (2026-05-02).**

- `tom_d4rt`: `dart test -N "I-FILE-47"` → PASS (was FAIL). Full
  suite: 1742 tests, 4 failures — same 4 pre-existing flakes
  (GEN-056d, DCL-RT-OPT-02, I-BUG-14a, I-MISC-212), I-FILE-47
  removed. **No regressions.**
- `tom_d4rt_generator`: `dart test -N "G-DOV3-1"` → PASS (was
  FAIL). Full suite: 660 tests, all pass.
- `tom_d4rt_exec`: full suite shows the same baseline 4 failures
  (the 4th differs between runs — `G-TST-9` and
  `d4rt_coverage_test setUpAll` are both order-dependent flakes
  present with **and** without the fix, verified by stashing the
  patch and re-running). No EXTTYPE-induced regression.
- `dart analyze` on all four edited files: no new warnings.

Net cluster impact: −2 failures (`tom_d4rt I-FILE-47`,
`tom_d4rt_generator G-DOV3-1`).

### Cluster INTROSPECT — `analyze()` leaks built-ins (4 fails) — **CLOSED 2026-05-02**

Sites: `tom_d4rt` (`I-FILE-36`, `I-FILE-38`), `tom_d4rt_exec`
(`I-FILE-36`, `I-FILE-38`).

Symptom:

- `I-FILE-36`: expected `[]`, actual `[VariableInfo:var
  identityHashCode: NativeFunction = <native fn identityHashCode>]`.
- `I-FILE-38`: expected `<0>`, actual `<1>` for an
  imports-only source.

**Actual root cause.** `IntrospectionBuilder.buildFromEnvironment`
walked the global `Environment` and filtered known built-in names
through a hard-coded blocklist (`_isBuiltinName`) that listed
common type names — `Object`, `String`, `int`, `print`,
`identical`, … — but missed many other pre-registered natives. In
particular `identityHashCode` was not in the list, so an empty
source produced a one-element `variables` list. For an
imports-only source the same leak surfaced as `result.all.length
== 1` instead of `0`. A blocklist that has to enumerate every
built-in is structurally fragile.

**Applied fix.**

1. Replaced the blocklist with an AST-derived **whitelist** of the
   names actually declared in the analyzed source. When the caller
   provides a `compilationUnit` (the typical case for `analyze()`),
   `buildFromEnvironment` now collects user-declared names by
   walking `compilationUnit.declarations`:
   - `TopLevelVariableDeclaration` → each variable name.
   - `ExtensionDeclaration` → the extension's name (named
     extensions only — unnamed ones still get a synthetic
     `<unnamed extension on T>` entry as before).
   - `NamedCompilationUnitMember` (`ClassDeclaration`,
     `EnumDeclaration`, `FunctionDeclaration`, `MixinDeclaration`,
     `ExtensionTypeDeclaration`, `TypedefDeclaration`) → the
     declaration's name token.
   The environment walk then keeps only entries whose key is in
   that whitelist. Pre-registered natives like `identityHashCode`,
   `Object`, `print` are no longer reachable.
2. The legacy `_isBuiltinName` blocklist is kept as a fallback
   only for callers that build an `IntrospectionResult` without
   passing a `compilationUnit` (backward-compat).
3. Mirrored the change in
   `tom_d4rt_ast/lib/src/runtime/introspection.dart` using
   `SNamedDeclaration` (the mixin shared by all named
   `SCompilationUnitMember` subtypes in `tom_ast_model`) per the
   cross-sync rule.

**Verification.**

- `tom_d4rt`: `dart test test/introspection_api_test.dart` →
  38/38 pass (I-FILE-36, I-FILE-38 included). Full suite +1740 −6
  (was −8, Δ −2).
- `tom_d4rt_exec`: `dart test test/introspection_api_test.dart` →
  38/38 pass. Full suite +2162 −5 (I-FILE-36/38 gone; the
  remaining −5 are DCL-RT-OPT-02, D4RT-TESTER-BUSY env flake,
  G-DOV2-7, I-BUG-14a Won't-Fix, and I-COLL-25 HASHSET — all
  pre-existing).
- `tom_d4rt_ast`: full suite unchanged at +115 −2 (only the
  pre-existing STDLIB-PI errors remain).
- `dart analyze` on both edited files: no warnings/errors.

Net cluster impact: −4 reds (−2 in `tom_d4rt`, −2 in
`tom_d4rt_exec`).

### Cluster RETURNTYPE — Null return for non-nullable not caught (2 fails) — **CLOSED 2026-05-02**

Sites: `tom_d4rt` (`I-MISC-212`).

Symptom (`I-MISC-212`):

> Expected throw with `"A value of type 'Null' can't be returned
> from the function 'getObjectWrong' because it has a return type
> of 'Object'."` — actual returned `<null>` silently.

**Actual root cause — cross-sync gap, not a missing check.**
The runtime type check at the existing site
(`tom_d4rt/lib/src/interpreter_visitor.dart:6017`) only fires when
`!valueRuntimeType.isSubtypeOf(declaredType, ...)`. For
`return null` against a declared `Object` the runtime's subtype
relation follows legacy Dart rules (`Null <: T` for any `T`), so
the assignability branch returns `true` and the throw is skipped.
The remaining special-case at line 6029 (`declaredType.name ==
"Object" && returnValue != null`) only suppresses the error in
the *non-null* direction.

The **AST-side interpreter
(`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart:6862`)
already had** an explicit null-vs-non-nullable check ahead of the
subtype block. `tom_d4rt_exec` therefore passed I-MISC-212 already
(it routes through the AST runtime). `tom_d4rt` had been left
behind during a prior cross-sync — only one half of the change
landed.

**Fix.** Mirror the AST-side check into
`tom_d4rt/lib/src/interpreter_visitor.dart`, inserted right after
the declared/value type debug logging and before the existing
subtype block:

```dart
// Cluster RETURNTYPE / I-MISC-212: Returning `null` from a function
// with a non-nullable declared return type must throw, even when the
// legacy `Null.isSubtypeOf(T)` rule would let the value pass.
if (returnValue == null &&
    declaredType != null &&
    !isNullable &&
    declaredType.name != 'void' &&
    declaredType.name != 'dynamic') {
  throw RuntimeD4rtException(
      "A value of type 'Null' can't be returned from the function "
      "'$functionName' because it has a return type of "
      "'${declaredType.name}'.");
}
```

Additive — does not loosen the existing assignability check.

**Verification (2026-05-02).**

- `tom_d4rt` `dart test test/interpreter_test.dart -N "I-MISC-21"`
  → 10/10 PASS (was 1 fail). I-MISC-212–215 (the
  nullable/non-nullable matrix) and I-MISC-217–219 (subtype
  matrix) all pass.
- `tom_d4rt` full suite: 1743 tests, 3 pre-existing failures
  (GEN-056d, DCL-RT-OPT-02, I-BUG-14a). I-MISC-212 cleared, no
  regressions.
- `tom_d4rt_exec` full suite: same baseline 4 failures with and
  without this change (G-DOV2-7, DCL-RT-OPT-02, I-BUG-14a, plus
  the order-dependent `d4rt_coverage_test setUpAll` flake). No
  impact — the AST runtime already passed I-MISC-212.
- `dart analyze`: no new warnings introduced.

Net cluster impact: −1 failure (`tom_d4rt I-MISC-212`).

### Cluster STDLIB-PI — `dart:math` constants missing in tom_d4rt_ast (2 errors) — **CLOSED 2026-05-02**

Sites: `tom_d4rt_ast` (the only 2 reds in the project).

Symptom (both errors): `Runtime Error: Undefined variable: pi`.
Test: `ast_module_loader_test.dart` `stdlib loading loads dart:math
and makes math available` and `… does not register same stdlib
twice`.

**Actual root cause — stale test premise vs GEN-107 isolation.**
The original analysis was wrong about the constants being missing.
`tom_d4rt_ast/lib/src/runtime/stdlib/math/math.dart` already
defines all eight constants (`pi`, `e`, `sqrt2`, `sqrt1_2`,
`log2e`, `log10e`, `ln2`, `ln10` — lines 7-14) and they are
registered when `MathStdlib.register(env)` runs.

What changed is *which* environment receives the registration.
`AstModuleLoader._loadStdlibModule` (lines 184-196) implements
GEN-107 Phase 3: every stdlib with an explicit registrar gets its
own isolated `Environment(enclosing: globalEnvironment)`, and the
stdlib registrar is called against that isolated env — not the
caller-supplied global environment. The stdlib symbols are then
exposed via the `LoadedModule.exportedEnvironment` returned from
`loadModule`. This is by design — the comment in
`ast_module_loader.dart:179-183` explicitly states "the math-only
band-aid is gone — re-export merging now carries stdlib symbols
into the libraries that re-export them".

The two failing tests still asserted on the *pre*-GEN-107 shape:

```dart
final env = initStdlibEnvironment();
final loader = createLoader(environment: env);
loader.loadModule(Uri.parse('dart:math'));
expect(env.get('pi'), isNotNull);   // <- stale: pi lives in module.exportedEnvironment
```

**Fix applied.** Updated both tests in
`tom_d4rt_ast/test/runtime/ast_module_loader_test.dart` to assert
against `module.exportedEnvironment.get('pi')`, which is the
public surface of the GEN-107 isolated stdlib env. The "does not
register same stdlib twice" test additionally verifies the
caching invariant (`first.exportedEnvironment == second.exportedEnvironment`).

No interpreter or stdlib changes — the constants were always
present, the test contract just hadn't caught up to the GEN-107
isolation design.

**Verification.**

- `dart test test/runtime/ast_module_loader_test.dart` → 47/47 pass.
- `dart test` (full suite) → 117/117 pass. `tom_d4rt_ast` is now
  at 0 failures / 0 errors, unblocking the analyzer-free split.

### Cluster HASHSET — `Iterator.moveNext` missing on `Set` bridge (2 errors)

**CLOSED 2026-05-02.** Original analysis was wrong: `Iterator`
already had `moveNext`/`current` registered with `_HashSetIterator`
in its `nativeNames`. The real bug was bridge resolution priority.

Sites: `tom_d4rt` and `tom_d4rt_exec` (`I-COLL-25`).

Symptom: `Runtime Error: Bridged class 'Set' has no instance
method named 'moveNext'. Error during extension lookup: Bridged
class 'Set' has no instance method named 'moveNext'.`

**Actual root cause.** `Environment.toBridgedClass(Type)` matched
the runtime type `_HashSetIterator` against bridge `nativeNames`
using `firstWhereOrNull(... .any((name) => typeName.startsWith(name)))`.
Iteration order followed bridge registration order. In `core.dart`,
`SetCore` (line 71) registers BEFORE `IteratorCore` (line 79), and
Set's `nativeNames` contains `_HashSet` while Iterator's contains
`_HashSetIterator`. Both prefix-match `_HashSetIterator`, but Set
wins because it iterates first. The `_HashSetIterator` instance
then resolved to the Set bridge, and `moveNext()` failed because
Set has no `moveNext`.

**Fix.** `tom_d4rt/lib/src/environment.dart` and
`tom_d4rt_ast/lib/src/runtime/environment.dart`: replace the
`firstWhereOrNull` `nativeNames.any(startsWith)` calls with a new
`_longestNativeNamePrefixMatch` helper that scans every bridge's
`nativeNames` and picks the LONGEST prefix match. An exact native
name (`_HashSetIterator`, len 16) beats a shorter prefix
(`_HashSet`, len 8), regardless of registration order. Both call
sites in `toBridgedClass` are updated:

1. The underscore-prefix branch (was: exact name OR any-startsWith).
2. The general fallback (was: exact name OR any-startsWith).

Both first try the exact `name == cleanedName` / `name == nativeTypeName`
match, then fall back to longest-prefix on `nativeNames`.

**Verification.**

- `dart test test/stdlib/collection/hash_set_test.dart` — 96/96 pass
  in `tom_d4rt`, 8/8 pass in `tom_d4rt_exec`.
- `dart test test/stdlib/` — 683/683 pass in both projects.
- Full `dart test` in `tom_d4rt`: 1746/1751 pass; the remaining 5
  failures (GEN-056d, DCL-RT-OPT-02, I-MISC-212, I-FILE-47,
  I-BUG-14a) are confirmed pre-existing on `main` without the fix.
- Full `dart test` in `tom_d4rt_exec`: 2257/2260 pass; the 3
  failures (DCL-RT-OPT-02, G-DOV2-7, I-BUG-14a) are pre-existing.
- No regressions introduced by the longest-prefix selection.

### Cluster FLP — Flutter-pattern callback emission gaps (4 fails)

Sites: `tom_d4rt_generator` (`G-FLP-16`, `G-FLP-23`, `G-FLP-28`,
`G-FLP-30`).

Symptoms (with the missing emission):

| Test | Missing emission |
|---|---|
| `G-FLP-16` | `as Future<$test_package_1.CodecLike>` cast on a typedef-returning callback |
| `G-FLP-23` | `as $test_package_1.PageRouteLike<T>` cast on a generic-typedef-returning callback (regex pattern) |
| `G-FLP-28` | `bool Function(Object?)` — nullable arg `Object?` is being narrowed to `Object` |
| `G-FLP-30` | `as $dart_math.Point<double>` cast — SDK-type prefixing (`dart:math`) is missing |

**Root cause.** Same generator file as Cluster CB —
`bridge_generator.dart`, but in the typedef-resolution and
generic-arg paths. The cast emission and the nullable-argument
preservation were both regressed.

**Fix.**

1. **G-FLP-16/23/30**: in the typedef-return-cast emitter, append
   `as <Prefixed.ReturnType>` when the typedef has a non-`void`
   return. Use the import-prefix table the generator already
   maintains for type names (so `dart:math.Point` becomes
   `$dart_math.Point` etc.).
2. **G-FLP-28**: in the callback-argument signature emitter,
   preserve the nullable `?` suffix when the typedef arg is
   declared as `Object?`. The `?` is currently being stripped
   before the signature is rendered.
3. Run `dart test test/flutter_patterns_test.dart` in
   `tom_d4rt_generator/`. Closing this removes 4 failures.

**CLOSED 2026-05-02.** Fix landed in
`tom_d4rt_generator/lib/src/bridge_generator.dart`
`_generateFunctionWrapper` + new helper
`_buildFunctionTypeSignature`:

1. Capture the resolved (prefixed) return-cast type as
   `wrapperReturnCastType` for both extractBridgedArg and
   primitive paths; append `as $castType` to the
   `extractBridgedArg<T>(...)` body so FLP-16/23/30 see the
   literal `as <PrefixedReturnType>` cast in source.
2. After the wrapper closure is built, emit a function-type
   signature cast `as <Return> Function(<positional>{,<named>})`
   on non-generic, non-named-param wrappers — `Object?` survives
   here because the existing param-type resolver already
   preserves the `?` suffix (FLP-28). Skipped for generic
   wrappers (Dart syntax limit) and for typedefs with named
   params (would re-introduce the `{bool allowUpscaling}` shape
   that G-FLP-07 forbids; the wrapper closure handles defaults
   anyway).
3. Verified: `dart test test/flutter_patterns_test.dart` —
   55/55 pass (previously 51/55). G-FLP-07 unaffected.
   No interpreter mirror needed (generator-side fix only).

### Cluster MAP-COERCE — Native arg coercion for `Map<String,String>` (1 fail) — **CLOSED 2026-05-02**

Site: `tom_dcli_exec` `dcli_example_test.dart` `tomexample
(advanced) environment`.

Symptom:

> `Runtime Error: Unexpected error: Argument Error: Invalid
> parameter "environment": expected Map<String, String>, got
> _Map<Object?, Object?>`.

**Root cause.** The error message *looks* like it comes from
`D4.coerceMap`, but the bridge for `withEnvironmentAsync` actually
calls `D4.getRequiredNamedArg<Map<String, String>>` →
`extractBridgedArg<Map<String, String>>`. Inside the Map branch of
`extractBridgedArg`
(`tom_d4rt/lib/src/generator/d4.dart` ~line 1288, AST mirror
`tom_d4rt_ast/lib/src/runtime/generator/d4.dart` ~line 1327), the
existing implementation only attempted three bare casts of
`Map<Object?, Object?>` to `T`:

```dart
try { return unwrappedMap as T; } catch (_) {}
try { return unwrapped as T; } catch (_) {}
return rewrappedMap as T;
```

Reified generics defeat all three: a `Map<Object?, Object?>` is
not assignable to `Map<String, String>` no matter how many times
you cast it. Execution falls through to the generic
"expected $T, got $actualType" thrower at line 1375, which
produces the observed message format (`"$paramName": expected $T,
got $actualType`).

**Fix.** Mirror the typed-rebuild approach already used by the Set
branch in the same file: parse `K` and `V` from the type-string
and rebuild the unwrapped map as a real `Map<K, V>` for common
primitive combinations. Two new private helpers were added
adjacent to `_unwrapElement`:

- `_splitTopLevelComma(String s)` — splits a generic-arg list at
  the top-level comma, respecting nested `<>` / `()` so
  `Map<String, List<int>>` parses as `String` + `List<int>`.
- `_buildTypedMap(Map<Object?, Object?> source, String keyType,
  String valueType)` — switch dispatching on `'$keyType|$valueType'`
  for the primitive combos that show up in real bridges
  (`String|String`, `String|int`, `String|double`, `String|num`,
  `String|bool`, `String|Object{?}/dynamic`, `int|String`,
  `int|int`, `int|Object{?}/dynamic`, `Object{?}/dynamic` square).

The Map branch now calls `_buildTypedMap` between the failing
bare-cast attempts and the existing rewrappedMap fallback. When
it returns a non-null typed map, `as T` succeeds and the bridge
gets a real `Map<String, String>`. Both `tom_d4rt` and
`tom_d4rt_ast` got identical edits per the cross-sync rule.

**Verification.**

- `dart test test/dcli_example/dcli_example_test.dart -N "tomexample (advanced) environment"` → PASS (was the only failure in this group).
- Full `dcli_example_test.dart` suite: 21/21 PASS (was 20/1).
- `tom_d4rt` full suite: same 3 pre-existing failures only (GEN-056d, DCL-RT-OPT-02, I-BUG-14a) — no regressions.
- `tom_d4rt_ast` full suite: 117/117 PASS.
- `tom_d4rt_exec` full suite: same 4 pre-existing failures only (DCL-RT-OPT-02, G-TST-6 flake, G-DOV2-7, I-BUG-14a) — no regressions.

### Cluster STRING-AS-PROCESS — `String.start` extension missing (2 fails) — **CLOSED 2026-05-02**

Site: `tom_dcli_exec` (`process_execution`, `redirect`).

Symptom (both):

> `Runtime Error: Bridged class 'String' has no instance method
> named 'start'. Error during extension lookup: Native error during
> default bridged constructor for 'Progress': type
> 'InterpretedFunction' is not a subtype of type '(String) => void'`.

**Actual root cause — stale `bin/dclie` binary.** The
`StringAsProcess` extension *is* registered correctly in
`tom_dcli_exec/lib/src/bridges/dcli_bridges.b.dart` (line 346,
including `start`, `forEach`, `run`, `firstLine`, `lastLine`,
`toList`, `toParagraph`, `parser`, `write`, `truncate`, `append`),
and the `forEach` adapter already wraps the
`InterpretedFunction` callback with a `(String p0) {
D4.callInterpreterCallback(visitor, raw, [p0]); }` shim that
becomes a real `(String) => void` Dart closure — so neither hypothesis
in the original analysis was the actual problem.

The real issue is that `test/dcli_example/dcli_example_test.dart`
runs the *compiled* `bin/dclie` binary, and the rebuild gate in
`_ensureDclieBinary()` only rebuilt when `bin/dclie.dart` itself
was newer than the binary:

```dart
// before:
if (!binary.existsSync() ||
    source.lastModifiedSync().isAfter(binary.lastModifiedSync())) {
```

`bin/dclie.dart` is a one-liner that calls `DcliRepl().run(...)` —
it never changes. Whenever bridge regen updated
`lib/src/bridges/dcli_bridges.b.dart` (which it did during the
Cluster CB / IMPORT-CONFLICT / EXPORT fixes earlier in this
session), the binary stayed at its March-3 build and ran with the
old-shape extension table that didn't yet have `StringAsProcess`
in its current form. The test then surfaced the missing-method
error, exactly as if the bridge were missing.

**Fix applied.**

1. `tom_dcli_exec/test/dcli_example/dcli_example_test.dart`:
   widened the rebuild gate to walk `bin/` and `lib/` recursively
   and trigger recompilation if **any** `.dart` file is newer than
   the binary. Generated `*.b.dart` regen now correctly invalidates
   the cached binary.
2. Forced a rebuild (`rm bin/dclie`) so the next test run picks up
   the current bridge table.

**Verification.**

- `dart test test/dcli_example/dcli_example_test.dart -N process_execution` → PASS.
- `dart test test/dcli_example/dcli_example_test.dart -N redirect` → PASS.
- Full `dcli_example_test.dart` suite: +20 -1 (only `environment`
  remains, which is the separate Cluster MAP-COERCE).

No interpreter / bridge-generator changes — the existing
`StringAsProcess` registration was already correct. The fix is
test-infrastructure only and prevents this class of
"works-after-recompile" flake from recurring.

### Cluster IMPORT-CONFLICT — Dual `BridgedClass` import (5 errors) — **CLOSED 2026-05-02**

Site: `tom_dcli_exec` — 5 `Failed to load` errors at compile time.

Symptom (representative):

> `'BridgedClass' is imported from both
> 'package:tom_d4rt/src/bridge/bridged_types.dart' and
> 'package:tom_d4rt_ast/src/runtime/bridge/bridged_types.dart'.`
>
> Plus: `The argument type 'D4rt/*1*/' can't be assigned to the
> parameter type 'D4rt/*2*/?'. - 'D4rt/*1*/' is from
> 'package:tom_d4rt_exec/src/d4rt_base.dart' - 'D4rt/*2*/' is
> from 'package:tom_d4rt-1.8.19/lib/src/d4rt_base.dart'.`

**Actual root cause — `d4rtImport` defaulted to the analyzer-based
package.** `tom_dcli_exec/buildkit.yaml` set
`helpersImport: package:tom_d4rt_exec/tom_d4rt_exec.dart` but did
not set `d4rtImport`. The bridge generator's default for
`d4rtImport` (`bridge_api.dart:215`,
`per_package_orchestrator.dart`, `file_generators.dart` etc.) is
`package:tom_d4rt/d4rt.dart`. Generated bridges therefore emitted
**both**:

```
import 'package:tom_d4rt/d4rt.dart';        // ← d4rtImport default
import 'package:tom_d4rt_exec/tom_d4rt_exec.dart';  // ← helpersImport
```

Both packages export `BridgedClass`/`D4rt`, so the analyzer flagged
duplicate-symbol errors and the `D4rt/*1*/` ↔ `D4rt/*2*/` mismatch
in `register(d4rt)` calls. The transitive dependency on
`tom_d4rt-1.8.19` came from the dev-dep `tom_d4rt_generator: any`
(pulls `tom_d4rt 1.8.19` from pub.dev) — but the *root cause*
inside the generated code was the missing `d4rtImport` config key,
not the dep tree.

**Fix applied.**

1. Added `d4rtImport: package:tom_d4rt_exec/d4rt.dart` to the
   `d4rtgen:` block in `tom_dcli_exec/buildkit.yaml`. The
   analyzer-free `tom_d4rt_exec/lib/d4rt.dart` re-exports
   `tom_d4rt_ast/runtime.dart` (with `LoadedModule` hidden), giving
   the bridges a single coherent source for `D4rt`, `BridgedClass`,
   and runtime types.
2. Regenerated all `.b.dart` bridges
   (`dart run tom_d4rt_generator/bin/d4rtgen.dart` from the project
   root). Each bridge file now contains
   `import 'package:tom_d4rt_exec/d4rt.dart';` instead of the dual
   import — single source of truth.

**Verification.**

- `dart analyze` in `tom_dcli_exec/`: 5 errors gone, only
  pre-existing `unused_import` / `unused_local_variable` warnings
  in `test/dcli_example/dcli_scripting_guide/*.dart` remain.
- Targeted compile of the previously-erroring suites
  (`cli_api_bridges_test`, `cli_api_comprehensive_test`,
  `cli_api_script_test`, `vscode_scripting_api_bridges_test`):
  335/335 pass.
- Full `tom_dcli_exec` suite: **+409 -3**. The 3 remaining failures
  are the pre-existing baseline DCli-example failures
  (`DCli Project - tomexample (advanced) environment`,
  `... process_execution`, `DCli Project - standalone (advanced)
  redirect`) — none are import-conflict related.

Net delta: **-5 errors**, plus 400+ previously-uncompilable tests
now run.

### Cluster D4RT-TESTER-BUSY — Race on `example/d4/bin/d4` (1 error) — **CLOSED 2026-05-02**

Site: `tom_ast_generator` (`G-DCLI-12`).

Symptom: `ProcessException: Text file busy | Command:
…/tom_ast_generator/example/d4/bin/d4 --test
../d4_test_scripts/bin/dcli_scripting_guide/12_error_handling.dart`.

**Root cause.** `dart test` runs each test file in its own VM and
may execute multiple suites in parallel. Both
`d4rt_tester_test.dart` and `d4rt_coverage_test.dart` call
`AstgenTestSetup.prepareBridges` from `setUpAll`, which runs
`dart compile exe` to the same `bin/<runner>` path. The late-comer
hits the early-comer's still-open file handle and fails with
"Text file busy". Reproduces only under parallel `dart test`; both
tests pass in isolation.

**Fix.** `tom_ast_generator/test/generator_tests/astgen_test_setup.dart`
now serialises callers and skips duplicated work:

1. Wrap the body of `prepareBridges` with an exclusive blocking
   file lock on `bin/.d4-prepare.lock` (`FileLock.blockingExclusive`).
   The lock funnels parallel callers one-at-a-time through the
   compile step, eliminating the race.
2. Cache `_suiteStartTime = DateTime.now()` lazily on first VM
   access. After acquiring the lock, check `bin/.d4.ready`: if the
   sentinel exists, the binary exists, and `sentinel.lastModifiedSync()
   > _suiteStartTime`, a sibling test process in the same `dart
   test` invocation already produced a fresh binary — return `true`
   and skip the rebuild.
3. After a successful compile, write the current timestamp to
   `bin/.d4.ready` so the next sibling can take the fast path.

**Verification (2026-05-02):**
- `dart analyze test/generator_tests/astgen_test_setup.dart` → 0 issues.
- `dart test test/generator_tests/d4rt_tester_test.dart
  test/generator_tests/d4rt_coverage_test.dart` → 122/122 (no
  "Text file busy"). The cluster failure mode no longer reproduces.
- Full `dart test` in `tom_ast_generator/` → 508 passed, 2 failed
  (G-TYPE-1 Record parameter, G-TYPE-2 Record return type — both
  pre-existing, marked `(FAIL)` in the test descriptions).

### Cluster VSCODE-LIVE — Live VS Code bridge not reachable (2 reds)

Site: `tom_d4rt_dcli` (the only 2 reds in the project).

Both tests in `vscode_scripting_api_bridges_test.dart` exercise the
live VS Code extension host. One returns `false` (script failed
to reach an active editor), the other throws because the bridge
return value was `null` (`type 'Null' is not a subtype of type
'Map<String, dynamic>'`).

**This is environment-dependent**, as the README already notes.
Treat as flaky-environmental until reproduced against a confirmed
running VS Code session — **do not start an interpreter cluster on
this**. Recommended action: re-run the test against a live VS
Code, and only file an interpreter issue if the failure persists.

---

## Per-project failure list (with quoted runtime errors)

### `tom_ast_generator` — 6 failures + 1 error

| Test | Cluster | Quoted error / actionable fix |
|---|---|---|
| G-DOV2-7 Extension on enum type resolution | (own) | `RuntimeD4rtException: A value of type 'String' can't be returned from the function 'main' because it has a return type of 'void'.` — bridge generator emits a fixture where the extension method on the enum returns a `String` but is declared `void`. **Fix**: align the fixture's return type or update the generated wrapper to honour the declared return. Investigation should start in `test/generator_tests/fixtures/` for the enum-extension fixture. |
| DCL-CLS-002 forEach callback | CB | See cluster |
| G-CB-2a Void Function() | CB | See cluster |
| G-CB-7 typedef return value | CB | See cluster |
| G-CB-11 Bool Function(int) | CB | See cluster |
| G-CB-12 String Function(String) | CB | See cluster |
| G-DCLI-12 Error handling (error) | D4RT-TESTER-BUSY | See cluster |

### `tom_d4rt` — 9 failures + 1 error

| Test | Cluster | Quoted error |
|---|---|---|
| GEN-056d Extension on unknown type reports error | (own) | `Expected: non-empty, Actual: []`. **Fix**: `extension_resolver` should add an error to the AnalysisResult's error list when an extension is declared on an unknown type identifier. The current code silently no-ops. |
| I-MISC-40 Export conflict (local vs. exported) | EXPORT | See cluster |
| I-MISC-41 Export conflict (two exports) | EXPORT | See cluster |
| I-FILE-36 analyze() empty source | INTROSPECT | See cluster |
| I-FILE-38 analyze() imports only | INTROSPECT | See cluster |
| DCL-RT-OPT-02 Function reference as callback | (own) | `Expected: not null, Actual: <null>` — known DCli runtime gap. **Fix**: when a function reference (not a closure) is passed as a callback parameter, the callable adapter must still propagate positional/named args. Locate `Callable.bind` for function-reference callsites. |
| I-BUG-14a Records with named fields | Won't Fix | Pre-existing intentional fail per the issue label `(SHOULD FAIL)`. No action. |
| I-FILE-47 Extension types should work | EXTTYPE | See cluster |
| I-MISC-212 Incorrect return type (null for Object) | RETURNTYPE | See cluster |
| I-COLL-25 HashSet Iterator basics (error) | HASHSET | See cluster |

### `tom_d4rt_ast` — 0 failures + 2 errors

| Test | Cluster |
|---|---|
| stdlib loading loads dart:math and makes math available | STDLIB-PI |
| stdlib loading does not register same stdlib twice | STDLIB-PI |

### `tom_d4rt_dcli` — 1 failure + 1 error

| Test | Cluster |
|---|---|
| VSCodeWindow getActiveTextEditor returns editor info | VSCODE-LIVE |
| Live Bridge Commands script can get active editor | VSCODE-LIVE |

### `tom_d4rt_exec` — 25 failures + 1 error

The 25 mirror the analyzer-based suite plus the 14 G-DCLI Digest
fails, plus the generator-test cluster which is duplicated
between this project and `tom_d4rt_generator`.

| Test bucket | Cluster |
|---|---|
| I-MISC-40, I-MISC-41 | EXPORT |
| G-DOV2-7, DCL-CLS-002, G-CB-2a, G-CB-7, G-CB-11, G-CB-12 | CB (+ shared own GEN-DOV2-7 fixture issue) |
| I-FILE-36, I-FILE-38 | INTROSPECT |
| DCL-RT-OPT-02 | (own — see tom_d4rt) |
| I-BUG-14a | Won't Fix |
| G-DCLI-01 … G-DCLI-14 (excluding 09) | DIGEST (×14) |
| I-COLL-25 (error) | HASHSET |

Closing DIGEST + CB + EXPORT + INTROSPECT removes 22 of the 25
failures here; HASHSET removes the error. The remaining
DCL-RT-OPT-02 + I-BUG-14a (Won't Fix) plus G-DOV2-7 fixture issue
are isolated.

### `tom_d4rt_generator` — 8 failures + 0 errors

| Test | Cluster |
|---|---|
| G-CB-7, G-CB-11, G-CB-12 | CB |
| G-DOV3-1 Extension type getter access | EXTTYPE |
| G-FLP-16, G-FLP-23, G-FLP-28, G-FLP-30 | FLP |

### `tom_dcli_exec` — 3 failures + 5 load errors

5 errors (compile-time `Failed to load`): IMPORT-CONFLICT.

3 failures:

| Test | Cluster |
|---|---|
| environment | MAP-COERCE |
| process_execution | STRING-AS-PROCESS |
| redirect | STRING-AS-PROCESS |

---

## Recommended priority order

Fix in this sequence — each step removes the most failures per
unit of work and unblocks downstream verification:

| # | Cluster | Effect | Touches |
|---|---|---|---|
| 1 | **DIGEST** | −14 failures (all in `tom_d4rt_exec`) | `tom_d4rt_exec/example/d4/lib/src/d4rt_bridges/` |
| 2 | **CB** | −10 failures across 3 projects | `tom_d4rt_generator/lib/src/bridge_generator.dart` (mirror to `tom_ast_generator` if separate) |
| 3 | **IMPORT-CONFLICT** | −5 errors in `tom_dcli_exec` (unblocks compile) | `tom_dcli_exec/pubspec.yaml`, dep upgrade |
| 4 | **EXPORT** | −4 failures in `tom_d4rt` + `tom_d4rt_exec` | `runtime/environment.dart` (both copies — cross-sync) |
| 5 | **INTROSPECT** | −4 failures in `tom_d4rt` + `tom_d4rt_exec` | `runtime/d4rt_base.dart` `analyze()` (both copies) |
| 6 | **FLP** | −4 failures in `tom_d4rt_generator` | `bridge_generator.dart` typedef-return + nullable-arg paths |
| 7 | **STRING-AS-PROCESS** | −2 failures in `tom_dcli_exec` | DCli user-bridge or generator |
| 8 | **STDLIB-PI** | −2 errors in `tom_d4rt_ast` (clears project to 0/0) | `tom_d4rt_ast/lib/src/runtime/stdlib/dart_math.dart` |
| 9 | **HASHSET** | −2 errors in `tom_d4rt` + `tom_d4rt_exec` | `Iterator` bridge (both copies) |
| 10 | **EXTTYPE** ✓ | CLOSED 2026-05-02 — fix was pass-2 loop, not declaration visitor | `d4rt_base.dart`, `module_loader.dart`, `d4rt_runner.dart`, `ast_module_loader.dart` |
| 11 | **RETURNTYPE** ✓ | CLOSED 2026-05-02 — cross-sync gap, `tom_d4rt` only | `tom_d4rt/lib/src/interpreter_visitor.dart` |
| 12 | **MAP-COERCE** ✓ | CLOSED 2026-05-02 — typed Map rebuild in `extractBridgedArg` Map branch | `tom_d4rt/lib/src/generator/d4.dart`, `tom_d4rt_ast/lib/src/runtime/generator/d4.dart` |
| 13 | **D4RT-TESTER-BUSY** ✓ | CLOSED 2026-05-02 — file-lock + sentinel in `prepareBridges` serialises parallel `dart compile exe` callers | `tom_ast_generator/test/generator_tests/astgen_test_setup.dart` |
| 14 | **GEN-056d / DCL-RT-OPT-02 / G-DOV2-7** | −3 failures (per-project own bugs, no cluster) | per project |
| 15 | **I-BUG-14a** (Won't Fix) | n/a | leave |
| 16 | **VSCODE-LIVE** | env-dependent — re-run against a live VS Code first | n/a |

Cumulative effect of items 1 – 13: **−43 failures, −10 errors**,
leaving the seven projects at roughly **9 failures + 0 errors**
total (the residual being the per-project own-bug items 14 + the
intentional `I-BUG-14a`).

---

## Cross-sync reminders

Every cluster that touches the interpreter (EXPORT, INTROSPECT,
RETURNTYPE, EXTTYPE, HASHSET, STDLIB-PI, MAP-COERCE) must be
mirrored between `tom_d4rt/lib/src/...` and
`tom_d4rt_ast/lib/src/runtime/...` per the workspace cross-sync
rule. A fix that lands in only one is incomplete. After each
fix, re-run the matching test suite in **both** `tom_d4rt` and
`tom_d4rt_exec` to confirm parity.

---

## Files in this directory

See [`README.md`](README.md) → *Files in this directory* for the
listing of result-json / log / summary files. This document does
not produce any new generated artefacts; it is a hand-written
companion to the autogenerated `_summary.md` and `_failures.md`.
