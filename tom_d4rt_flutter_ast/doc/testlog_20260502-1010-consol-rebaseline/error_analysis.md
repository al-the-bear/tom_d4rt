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

### Cluster EXPORT — Export-conflict detection missing (4 fails)

Sites: `tom_d4rt` (`I-MISC-40`, `I-MISC-41`), `tom_d4rt_exec`
(`I-MISC-40`, `I-MISC-41`).

Symptom:

- `I-MISC-40`: expected throw with `'Name conflict in environment:
  Symbol 'commonName' is already defined'` — actual call returns
  `'Hello from Local commonName'` (silent shadowing).
- `I-MISC-41`: expected throw with `'Name conflict in environment:
  Symbol 'conflictingSymbol' is already defined'` — actual throws
  `Undefined variable: conflictingSymbol` from
  `interpreter_visitor.dart:445` (`tom_d4rt`) /
  `interpreter_visitor.dart:480` (`tom_d4rt_ast`).

**Root cause.** Two related bugs:

1. **`I-MISC-40`** — When a script declares a local symbol that
   shadows a `export`ed symbol from an imported library, the import
   path silently wins instead of raising the conflict.
2. **`I-MISC-41`** — When two transitively-imported libraries both
   re-export the same symbol, the merged environment ends up with
   the symbol *missing* (resolves to `Undefined`) instead of
   raising a name-conflict.

**Fix.**

1. In `tom_d4rt/lib/src/runtime/environment.dart` (and mirror
   `tom_d4rt_ast/lib/src/runtime/environment.dart`), the
   import-merging step should detect duplicate symbol definitions
   from re-exports and raise
   `RuntimeD4rtException('Name conflict in environment: Symbol '<n>' is already defined')`.
2. The same conflict check must also fire when a local
   declaration coincides with an exported symbol introduced via
   `export` (not just `import`).
3. Run `dart test test/export_test.dart` in **both** `tom_d4rt`
   and `tom_d4rt_exec`. Both share this code (one via the
   analyzer-based path, the other via the AST-based path), so
   per the cross-sync rule fix both at the same time.
4. Closing this cluster removes 4 failures.

### Cluster EXTTYPE — Extension types not registered (2 fails)

Sites: `tom_d4rt` (`I-FILE-47`), `tom_d4rt_generator` (`G-DOV3-1`).

Symptom: `Undefined variable: UserId` when an extension type is
declared and then referenced as a type:

```dart
extension type UserId(int value) {}
final id = UserId(42);  // throws Undefined variable: UserId
```

**Root cause.** Extension-type declarations are parsed but the
declaration visitor does not register the wrapper class in the
environment — so the constructor invocation (which is a
`SimpleIdentifier` for `UserId` followed by an argument list) hits
an empty lookup.

**Fix.**

1. In `tom_d4rt/lib/src/runtime/declaration_visitor.dart` (and the
   mirror in `tom_d4rt_ast`), add a
   `visitExtensionTypeDeclaration` handler that creates an
   `InterpretedClass` (or equivalent) with the extension-type
   field as a single property, and registers it under the
   extension-type name.
2. The `tom_d4rt_generator` `G-DOV3-1` test reuses the runtime so
   the same fix closes it.
3. Run `dart test test/limitations_and_bugs_test.dart` and
   `dart test test/dart_overview_failures3_test.dart` in the
   relevant projects.
4. Closing this cluster removes 2 failures.

### Cluster INTROSPECT — `analyze()` leaks built-ins (4 fails)

Sites: `tom_d4rt` (`I-FILE-36`, `I-FILE-38`), `tom_d4rt_exec`
(`I-FILE-36`, `I-FILE-38`).

Symptom:

- `I-FILE-36`: expected `[]`, actual `[VariableInfo:var
  identityHashCode: NativeFunction = <native fn identityHashCode>]`.
- `I-FILE-38`: expected `<0>`, actual `<1>` for an
  imports-only source.

**Root cause.** `analyze()` returns the full environment including
auto-registered `dart:core` natives (here, `identityHashCode`).
The result should be filtered to *user-declared* symbols only.

**Fix.**

1. Locate `analyze()` (likely
   `tom_d4rt/lib/src/runtime/d4rt_base.dart` and the
   `tom_d4rt_ast` mirror). It returns an `AnalysisResult` with
   variables/functions/classes lists.
2. Filter out symbols whose source identifier matches the
   stdlib registration tag (the bridge-registered ones can be
   marked with a flag at registration time, e.g.,
   `EnvironmentEntry.isBuiltin = true`).
3. Apply the filter in the `AnalysisResult` builder so the
   returned lists reflect only the analyzed source.
4. Run `dart test test/introspection_api_test.dart` in `tom_d4rt`
   and `tom_d4rt_exec`. Closing this cluster removes 4 failures.

### Cluster RETURNTYPE — Null return for non-nullable not caught (2 fails)

Sites: `tom_d4rt` (`I-MISC-212`), `tom_d4rt_exec` (`I-MISC-212` is
inside the existing 25 — confirm via `_failures.md`).

Symptom (`I-MISC-212`):

> Expected throw with `"A value of type 'Null' can't be returned
> from the function 'getObjectWrong' because it has a return type
> of 'Object'."` — actual returned `<null>` silently.

**Root cause.** `visitReturnStatement` does not assert
non-nullability of the declared return type when the returned
expression evaluates to `null`. This is a strict-typing gap: the
checker is only firing on type-mismatch, not on the
nullable/non-nullable distinction.

**Fix.**

1. In `interpreter_visitor.dart` (both copies), at
   `visitReturnStatement`, if the declared function return type
   is non-nullable and the returned value is `null`, raise:
   ```
   A value of type 'Null' can't be returned from the function '<name>'
   because it has a return type of '<DeclaredType>'.
   ```
2. The check must be additive — do not loosen the existing
   assignability check.
3. Run `dart test test/interpreter_test.dart` in `tom_d4rt` and
   `tom_d4rt_exec`. Closing this removes 1–2 failures.

### Cluster STDLIB-PI — `dart:math` constants missing in tom_d4rt_ast (2 errors)

Sites: `tom_d4rt_ast` (the only 2 reds in the project).

Symptom (both errors): `Runtime Error: Undefined variable: pi`.
Test: `ast_module_loader_test.dart` `stdlib loading loads dart:math
and makes math available` and `… does not register same stdlib
twice`.

**Root cause.** The tom_d4rt_ast stdlib loader registers
`dart:math` *functions* (`sin`, `cos`, …) but does not register
top-level *constants* (`pi`, `e`, `ln10`, …). The 0429 baseline
already had these errors; they have not regressed but they remain
the only failures in `tom_d4rt_ast` and they are blocking the
analyzer-free split.

**Fix.**

1. In `tom_d4rt_ast/lib/src/runtime/stdlib/dart_math.dart`
   (or wherever the `dart:math` bridge is defined for the AST
   variant), add top-level `define`s for: `pi`, `e`, `ln10`,
   `ln2`, `log2e`, `log10e`, `sqrt1_2`, `sqrt2`.
2. Run `dart test test/runtime/ast_module_loader_test.dart`.
3. **Cross-sync check.** Confirm the analyzer-based `tom_d4rt`
   *does* register these constants (it does — that's why the
   `tom_d4rt` mirror tests pass). Closing this brings
   `tom_d4rt_ast` to 0/0 for failures and errors.

### Cluster HASHSET — `Iterator.moveNext` missing on `Set` bridge (2 errors)

Sites: `tom_d4rt` and `tom_d4rt_exec` (`I-COLL-25`).

Symptom: `Runtime Error: Bridged class 'Set' has no instance
method named 'moveNext'. Error during extension lookup: Bridged
class 'Set' has no instance method named 'moveNext'.`

**Root cause.** Manual iterator usage on a bridged `Set`:

```dart
final it = mySet.iterator;
while (it.moveNext()) { … }
```

The `Set` bridge surfaces `iterator` (returning a bridged
`Iterator`), but `Iterator.moveNext` / `Iterator.current` are not
exposed.

**Fix.**

1. In the stdlib `Set` / `Iterator` bridges (two copies — analyzer
   and AST), register `moveNext` (`bool Function()`) and `current`
   (instance getter) on the `Iterator` bridge.
2. Run `dart test test/stdlib/collection/hash_set_test.dart` in
   both projects.
3. Closing this removes the 2 long-standing errors that have
   appeared in every recent baseline.

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

### Cluster MAP-COERCE — Native arg coercion for `Map<String,String>` (1 fail)

Site: `tom_dcli_exec` `dcli_example_test.dart` `tomexample
(advanced) environment`.

Symptom:

> `Runtime Error: Unexpected error: Argument Error: Invalid
> parameter "environment": expected Map<String, String>, got
> _Map<Object?, Object?>`.

**Root cause.** When an interpreted `Map` literal is passed across
the bridge to a native function expecting `Map<String, String>`,
the bridge does not coerce the underlying `_Map<Object?, Object?>`
to the native typed map.

**Fix.**

1. In `D4.coerceArg<T>` (or whichever boundary helper handles map
   coercion — `tom_d4rt/lib/src/generator/d4.dart` and the
   `tom_d4rt_ast` mirror), add a `Map<K, V>` branch that walks the
   `_Map<Object?, Object?>` and rebuilds it as a typed
   `Map<K, V>`.
2. Verify with `dart test test/dcli_example/dcli_example_test.dart
   --name 'environment'` in `tom_dcli_exec/`.

### Cluster STRING-AS-PROCESS — `String.start` extension missing (2 fails)

Site: `tom_dcli_exec` (`process_execution`, `redirect`).

Symptom (both):

> `Runtime Error: Bridged class 'String' has no instance method
> named 'start'. Error during extension lookup: Native error during
> default bridged constructor for 'Progress': type
> 'InterpretedFunction' is not a subtype of type '(String) => void'`.

**Root cause.** DCli-style `'cmd'.start(progress: …)` uses the
DCli `StringAsProcess` extension. The extension is not registered
on the bridged `String` class; secondarily the `Progress`
constructor expects a native `(String) => void` callback but the
interpreter passes an `InterpretedFunction`.

**Fix.**

1. Register the `StringAsProcess` extension methods (`start`,
   `run`, `forEach`, `firstLine`, `lastLine`, `pipe`, …) on the
   bridged `String` class for `tom_dcli_exec`. Either generate
   them via the bridge generator from the DCli source or
   hand-write a user-bridge in
   `tom_dcli_exec/lib/src/d4rt_user_bridges/`.
2. Wrap `InterpretedFunction` arguments at the `Progress`
   constructor boundary with `D4.toNative<(String) => void>` so
   the native call site receives a real Dart closure.
3. Closing this fixes 2 of the 3 `tom_dcli_exec` failures.

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

### Cluster D4RT-TESTER-BUSY — Race on `example/d4/bin/d4` (1 error)

Site: `tom_ast_generator` (`G-DCLI-12`).

Symptom: `ProcessException: Text file busy | Command:
…/tom_ast_generator/example/d4/bin/d4 --test
../d4_test_scripts/bin/dcli_scripting_guide/12_error_handling.dart`.

**Root cause.** Two test runs (most likely the parallel suite
runner) try to execute the same compiled `d4` binary while another
process is still writing to it. This is the same parallel-test
hazard that the flutter suites have, but for a Dart binary.

**Fix.**

1. In `tom_ast_generator/test/generator_tests/d4rt_tester_test.dart`,
   wrap the binary-rebuild step in a per-process lock (file
   lock or use a temp dir per process) so two runners can't
   stomp on the same binary.
2. Or, in the project's `test/` config, mark the
   `d4rt_tester_test` group as `isolated: true` so it does not
   run in parallel with other suites that touch the same binary.
3. This is environment-fragile but rarely flakes; it is a low
   priority compared to clusters above.

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
| 10 | **EXTTYPE** | −2 failures in `tom_d4rt` + `tom_d4rt_generator` | `runtime/declaration_visitor.dart` (both copies) |
| 11 | **RETURNTYPE** | −2 failures in `tom_d4rt` + `tom_d4rt_exec` | `runtime/interpreter_visitor.dart` (both copies) |
| 12 | **MAP-COERCE** | −1 failure in `tom_dcli_exec` | `D4.coerceArg<T>` Map branch |
| 13 | **D4RT-TESTER-BUSY** | −1 error in `tom_ast_generator` (env-fragile) | `test/generator_tests/d4rt_tester_test.dart` |
| 14 | **GEN-056d / DCL-RT-OPT-02 / G-DOV2-7** | −3 failures (per-project own bugs, no cluster) | per project |
| 15 | **I-BUG-14a** (Won't Fix) | n/a | leave |
| 16 | **VSCODE-LIVE** | env-dependent — re-run against a live VS Code first | n/a |

Cumulative effect of items 1 – 12: **−43 failures, −9 errors**,
leaving the seven projects at roughly **9 failures + 0 errors**
total (the residual being the per-project own-bug items 14 + the
intentional `I-BUG-14a` + the env-fragile cluster 13).

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
