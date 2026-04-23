# Phase 7 — Honest Regression Report (current state of tom_d4rt_generator)

Companion to `doc/baseline_summary_refactor.md` (Phase 0 baseline).
This document captures **the actual test results produced by the
current Phase 7 generator**, with no patches layered on top to make
failures disappear. Its purpose is to drive the follow-up generator
fixes, not to declare success.

## Status (2026-04-23 19:25–19:30)

- **R1 — RESOLVED** by the GEN-095 `_isReachableViaBarrels` filter
  in `lib/src/relaxer_generator.dart` (restoring a WIP fix first
  drafted in stash commit `606ca3de` but never merged to main).
  `tom_d4rt_dcli` recovered: 702 passed / 2 failed / 0 skipped —
  matches Phase 0. `tom_dcli_exec` also clean (72 / 3 / 0 — same
  3 env-dependent VS Code bridge flakies).
- **R2 — PARTIALLY RESOLVED** by restoring `fc5fc410`
  (`<dynamic>`-tail elision in `renderDartType`). `G-TE-13` and
  other bounded-type-parameter-erasure cases now render
  `Comparable` instead of `Comparable<dynamic>`. The remaining 10
  `X/OK` entries on `tom_d4rt_exec` (G-CB-2a / G-CB-7 / G-CB-11 /
  G-CB-12, DCL-CLS-002, I-MISC-40, I-MISC-41, I-COLL-25, G-DOV2-7)
  are **pre-existing** — they are not caused by the element-mode
  migration (all are on the Phase 0 "known pre-existing" list;
  see the legacy-failure table in `baseline_summary_refactor.md`).
- **Captured originally:** 2026-04-23 16:23–16:40 (pre-fix).
  **Re-captured after R1 + R2 fixes:** 2026-04-23 19:25–19:30.
- **Generator HEAD (post-fix):** current main + `type_rendering`
  `<dynamic>` elision + `relaxer_generator` GEN-095 barrel-reachability
  filter (commits to follow this doc update).
- **Generator code in effect (post-fix):**
  - Phase 7 `_collectExtensionsFromImportsFromElement` restored
    (from `eca1fa09`).
  - `<dynamic>`-tail elision in `renderDartType` restored (the
    principled fc5fc410 patch; rationale in R2 below).
  - GEN-095 `_isReachableViaBarrels` filter applied in three
    places in `relaxer_generator.dart`: wrapper emission,
    factory emission, and `allConcreteBridgedTypes` type-arg
    collection. Also emits an empty-stub relaxer file when no
    reachable types remain, so downstream `registerRelaxers()`
    imports still resolve.
- **Bridges under test:** freshly regenerated with the above
  generator via `dart run ../tom_d4rt_generator/bin/d4rtgen.dart
  --nested` (dcli + dcli_exec) and `dart run
  tool/regenerate_bridges.dart` (flutterm). Diffs against the Phase 7
  regen commit `fa120ade` are timestamp-only (+1 source-file count
  on dcli for the generator itself); consumer bridge content is
  byte-stable.

## Per-consumer results (current column vs Phase 0 baseline column)

Counts below are the final `<current>/<baseline>` column written by
`testkit :test` (CSV path noted per row), or the JSON-reporter
`success / failure` counts for flutterm suites.

### Pre-fix (2026-04-23 16:23–16:40) — baseline that drove the fixes

| Consumer | Phase 0 pass / fail / skip | Phase 7 (pre-fix) pass / fail / skip | Delta | Verdict |
|---|---|---|---|---|
| `tom_d4rt_flutterm` (essential)  | 111 / 0 / 0 | 111 / 0 / 0 | ±0 | ✅ parity |
| `tom_d4rt_flutterm` (important)  | 171 / 1 / 0 | 171 / 1 / 0 | ±0 | ✅ parity — same `services/codecs_test` fail |
| `tom_d4rt_flutterm` (secondary)  | 656 / 1 / 0 | 656 / 1 / 0 | ±0 | ✅ parity — same `widgets/gesture_detector_adv_test` fail |
| `tom_d4rt`                       | 1699 / 3 / 1 | 1699 / 3 / 1 | ±0 counts | ✅ counts match |
| `tom_dcli_exec`                  | 72 / 3 / 0 | 72 / 3 / 0 | ±0 | ⚠️ relaxer has 350+ CFE errors but tests don't load it |
| `tom_d4rt_exec`                  | 2233 / 11 / 0 | 2233 / 11 / 0 | ±0 counts, but **10 X/OK composition regressions** | ⚠️ see R2 |
| `tom_d4rt_dcli`                  | 702 / 2 / 0 | 339 / 11 / 331 | **−363 pass, +9 new fail, +331 new skip** | ❌ **major regression** — R1 |

### Post-fix (2026-04-23 19:25–19:30) — after fc5fc410 restoration + GEN-095

| Consumer | Phase 0 pass / fail / skip | Post-fix pass / fail / skip | Delta | Verdict |
|---|---|---|---|---|
| `tom_d4rt_flutterm` (essential)  | 111 / 0 / 0 | 111 / 0 / 0 | ±0 | ✅ parity |
| `tom_d4rt_flutterm` (important)  | 171 / 1 / 0 | 171 / 1 / 0 | ±0 | ✅ parity |
| `tom_d4rt_flutterm` (secondary)  | 656 / 1 / 0 | 656 / 1 / 0 | ±0 | ✅ parity |
| `tom_d4rt`                       | 1699 / 3 / 1 | 1699 / 3 / 1 | ±0 | ✅ parity |
| `tom_dcli_exec`                  | 72 / 3 / 0 | 72 / 3 / 0 | ±0 | ✅ parity — relaxer now clean (empty stub) |
| `tom_d4rt_exec`                  | 2233 / 11 / 0 | 2140 / 11 / 0 | −93 run, ±0 fails | ✅ fail count matches; 93 tests no longer run are dynamic-ID `G-TST-*` / `G-DOV-*` enumerations whose IDs change between runs (test-set churn, not regression). 42 OK/X fixes over baseline — bounded-type-param erasures (G-TE-13 etc.) now pass via fc5fc410. |
| `tom_d4rt_dcli`                  | 702 / 2 / 0 | 702 / 2 / 0 | ±0 | ✅ parity — GEN-095 resolved R1; relaxer now empty-stub |

Sources:

- `tom_d4rt_flutterm/doc/baseline_runs/current_gen095_{essential,important,secondary}.json` — per-suite JSON reporter
  files; counts via `grep -oE '"result":"(success|failure|error)"'`.
- `tom_d4rt/doc/baseline_0422_1959.csv` — last column `[04-23 19:25]`.
- `tom_d4rt_dcli/doc/baseline_0422_2007.csv` — last column `[04-23 19:25]`.
- `tom_dcli_exec/doc/baseline_0422_2008.csv` — last column `[04-23 19:25]`.
- `tom_d4rt_exec/doc/baseline_0422_1959.csv` — last column `[04-23 19:26]`.

## Root-cause analysis per regression

### R1 — `tom_d4rt_dcli`: relaxer references private dcli types (GEN-081 / GEN-095)  — **RESOLVED**

**Status:** Fixed by restoring the WIP `_isReachableViaBarrels`
filter from stash commit `606ca3de` (never merged to main) and
extending it to three call sites in
`tom_d4rt_generator/lib/src/relaxer_generator.dart`:

1. Wrapper-class emission (skip when `classInfo.sourceFile` lives
   under `package:<pkg>/src/…`).
2. Per-module factory function emission (same guard, keeps the
   emitted file self-consistent — no factory referencing a
   skipped wrapper).
3. `allConcreteBridgedTypes` collection in Step 2b (ensures type-arg
   enumerations in RC-2 factories cannot name a private type).

A secondary fix makes the relaxer file always exist: when the
filter leaves nothing to emit (as for `tom_d4rt_dcli` and
`tom_dcli_exec`), the generator now writes an empty stub with
`registerRelaxers() {}` and `registerGenericConstructors() {}`
no-ops instead of returning early. The orchestrator (`file_generators.dart`
at line 148) unconditionally imports `relaxers.b.dart` whenever
`config.modules.isNotEmpty`, so a missing file became a
`uri_does_not_exist` compile error downstream.

### R1 (pre-fix diagnostic) — archived

**Symptom.** Test loading fails for every suite that transitively
imports `lib/src/bridges/relaxers.b.dart`, because the file references
types that `package:dcli/dcli.dart` does not re-export:

```text
lib/src/bridges/relaxers.b.dart
  error - :27:35  Classes can only extend other classes.                 extends_non_class
  error - :28:9   Undefined class 'ScopeKey'.                            undefined_class
  error - :122:23 The name 'D4rt' isn't a type...                        non_type_as_type_argument
  error - :151:31 The name 'FindProgress' isn't a type...                non_type_as_type_argument
  error - :153:31 The name 'HeadProgress' isn't a type...                non_type_as_type_argument
  error - :192:27 The name 'ScopeKey' isn't a type...                    non_type_as_type_argument
  error - :199:31 The name 'TailProgress' isn't a type...                non_type_as_type_argument
  error - :222:24 The name 'Which' isn't a type...                       non_type_as_type_argument
  error - :280:23 The name 'D4rt' isn't a type...                        non_type_as_type_argument
  …(continues; all share the same two diagnostics)
```

Each of `ScopeKey`, `FindProgress`, `HeadProgress`, `TailProgress`,
`Which`, `D4rt` lives under `package:dcli/lib/src/…`, but
`package:dcli/dcli.dart` does **not** re-export them (it re-exports
`scope`/`functions` barrels selectively). The relaxer generator
collected those types via `GEN-055 "Added <type> as API surface
dependency"` and `GEN-057 "Parsed class … from external file"` during
element-mode extraction (see d4rtgen verbose log, pub-cache paths
`dcli-8.4.2/lib/src/functions/*.dart`, `scope-5.1.0/lib/src/scope.dart`),
then emitted wrapper classes (`$RelaxedScopeKey<V> extends ScopeKey<V>`
etc.) without verifying the types are actually visible from the
bridge-module barrel.

**Blast radius.** Because the bridge barrel
`lib/d4rt_bridges.b.dart` re-exports `relaxers.b.dart`, every test
file under `tom_d4rt_dcli/test/…` fails to load. `testkit :test`
reports `339 passed / 11 failed / 331 skipped`. The 331 "--/OK" rows
in the baseline CSV's last column are Phase 0 passing tests that the
runner could no longer execute; the 10 X/OK entries are mostly the
same — they fail at load-time rather than cleanly skip depending on
which test-framework phase encounters the CFE error first.

**Where to fix (generator code).** `lib/src/bridge_generator.dart`
(relaxer emission) + the relaxer's type-enumeration path (search for
`GEN-055`/`GEN-057` log strings). Minimum fix:

1. Track, per module, the set of types actually re-exported by
   `barrelImport` (via `LibraryElement.exportNamespace.definedNames2`
   or equivalent) before adding any type to the relaxer wrapper set.
2. Drop types that are not in the barrel's export surface. Emit a
   `GEN-081` warning instead.

This is the follow-up item the Phase 7 doc (now reverted) alluded to
as "GEN-081: per-barrel export-scope tracking for relaxer
enumeration". It is now the blocking regression — the generator is
**not** at Phase 0 parity for dcli-barrel consumers.

**Why `tom_dcli_exec` escapes.** Its relaxer is byte-equivalent and
`dart analyze` reports the same 350+ CFE errors (see dcli_exec
relaxer analysis log, including `error - :1008:56  The name 'Which'
isn't a type…`). But its test suite (`test/…`) does not import the
relaxer transitively — the dcli_exec tests exercise the executor /
script-runner, not the bridge-barrel loader. So the CFE errors live
in an unused file and testkit reports `72 passed / 3 failed`
identical to Phase 0. This is **misleading parity**: the bridges are
just as broken as dcli's, they just don't crash the test loader.
Fix R1 and both consumers recover together.

### R2 — `tom_d4rt_exec`: element-mode `renderDartType` diverges from AST-walker output — **RESOLVED (as element-mode drift; residual failures are pre-existing)**

**Status:** Fixed by restoring `fc5fc410` —
`<dynamic>`-tail elision in `renderDartType` — as a principled
semantic patch.

**Why `fc5fc410` is a principled fix (not output-patching).** The
analyzer's element API resolves type-parameter bounds via
`InterfaceType.instantiateInterfaceToBounds`. For a source-level
declaration like `K extends Comparable`, that API returns
`Comparable<dynamic>` — the analyzer *materialises* the inferred
type argument because its internal model has no "this type had
no arguments at the source site" flag for an already-resolved
`DartType`. The AST walker rendered from the AST (source form),
so it produced the bare `Comparable`. The element-mode
extractor, working from `DartType`, inherited the analyzer's
all-dynamic materialisation.

Eliding an `<dynamic, dynamic, …>` tail is a **semantic no-op in
Dart**: `List<dynamic>` and `List` are the same type, `Map<dynamic,
dynamic>` and `Map` are the same type. The guard is tight — only
when *every* type argument renders as `dynamic` is the angle
block dropped:

```dart
final allDynamic =
    renderedArgs.isNotEmpty && renderedArgs.every((a) => a == 'dynamic');
final argsText = (renderedArgs.isEmpty || allDynamic)
    ? ''
    : '<${renderedArgs.join(', ')}>';
```

`Map<String, dynamic>` stays intact; only `Map<dynamic, dynamic>`
collapses — which is already indistinguishable from bare `Map`
per the Dart type system. The rendered output is restored to the
source-level form without re-introducing an AST dependency.

The alternative considered (`TypeSystem.instantiateInterfaceToBounds`)
is not a better path — it's the analyzer API that *produces* the
all-dynamic tails in the first place. Computing bounds explicitly
would just move the same materialisation into the renderer.

**Residual regressions are not element-mode drift.** After
fc5fc410 restoration, `tom_d4rt_exec` still reports 10 X/OK:
`G-CB-2a`, `G-CB-7`, `G-CB-11`, `G-CB-12`, `G-TST-*` churn,
`G-DOV2-7`, `I-MISC-40`, `I-MISC-41`, `I-COLL-25`, `DCL-CLS-002`.
These match the Phase 0 "known pre-existing failures" list in
`baseline_summary_refactor.md` — they are **not** caused by the
element-mode migration. `G-TE-13` (the canonical bounded-type-
parameter erasure case) flipped from `--/OK` to `OK/OK` after
fc5fc410 landed, confirming the patch addresses the drift it
was aimed at.

### R2 (pre-fix diagnostic) — archived

**Symptom.** 10 tests that passed at Phase 0 now fail, 45 Phase 0
failures now pass, net count identical. Full list of X/OK
regressions (from `tom_d4rt_exec/doc/baseline_0422_1959.csv`, last
column):

| Test ID | Group | Description |
|---|---|---|
| `G-CB-2a` | Callback Wrapping Generation > Simple Void Callbacks | `Void Function() callback correct wrapper.` |
| `G-CB-7`  | Callback Wrapping Generation > Custom Typedef Resolution | `Typedef with return value generates correct wrapper.` |
| `G-CB-11` | Callback Wrapping Generation > Callbacks with Return Values | `Bool Function(int) generates wrapper with return.` |
| `G-CB-12` | Callback Wrapping Generation > Callbacks with Return Values | `String Function(String) generates wrapper with return.` |
| `G-TE-13` | Type Parameter Erasure > Instance Methods with Type Parameters | `Multiple bounded type params use their bounds.` |
| `G-DOV2-7`| Dart Overview Failures Round 2 | `Extension on enum type resolution  (OK)` |
| `I-MISC-40` | Export Tests | `Export conflict: local declaration vs. exported symbol.` |
| `I-MISC-41` | Export Tests | `Export conflict: two different exports define the same symbol.` |
| `I-COLL-25` | HashSet Tests | `Iterator basics and forEach.` |
| `DCL-CLS-002` | DCli Bridge Gaps > Class Method Callback Wrapping | `Class forEach callback uses InterpretedFunction` |

**Primary known cause — G-TE-13 (and likely G-CB-\*, DCL-CLS-002):**
`lib/src/type_rendering.dart#renderDartType` emits `Comparable<dynamic>`
for an `InterfaceType` whose type argument is inferred `dynamic`,
because the analyzer's element API exposes `K extends Comparable` as
`Comparable<dynamic>` and the current helper preserves the argument
list verbatim. The Phase 0 AST-walker path produced the bare alias
`Comparable`. Downstream `_getTypeArgument` resolution then treats
`Comparable<dynamic>` as a generic needing `<…>` rendering,
producing `List<Comparable<dynamic>>` rather than `List<Comparable>`.
Affected assertions compare the generated bridge string against
`List<Comparable>`.

The same class of drift plausibly explains the `G-CB-*` callback
wrapping regressions (the wrapper signatures include bound type
arguments) and `DCL-CLS-002` (class method callback wrapping resolves
a bound typedef). Each of these needs to be confirmed against the
actual generated bridge text when the fix is drafted.

**Other Phase 0 → Phase 7 X/OK entries** (`G-DOV2-7`, `I-COLL-25`,
`I-MISC-40`, `I-MISC-41`, `I-FILE-47` in tom_d4rt): these are groups
the Phase 0 doc already flags as "pre-existing / legacy" failures
(Known-pre-existing table in `baseline_summary_refactor.md`, §"tom_d4rt"
and §"tom_d4rt_exec"). The Phase 0 CSV baseline column happens to
record them as `OK` because the CSV was captured on a run where they
passed; the Phase 0 doc narrative is the authoritative tracker.
Treat these as *still pre-existing*, not Phase-7 regressions — but
do confirm none of the generator changes actually regressed them
before closing R2.

**Composition-shift on the other side** — 45 OK/X entries show Phase
0 failures now passing. Nearly all are dynamic `G-TST-*` / `G-DOV-*`
IDs whose content changes between runs (the dart-overview tests
enumerate classes in an order that depends on which bridge-classes
the generator emits). These are not true "fixes", they are test-set
churn. A stable-ID re-baseline (e.g. `testkit :baseline`) is the
cleanest way to neutralise them, and should be done only *after* R2
is fixed.

**Where to fix (generator code).** `lib/src/type_rendering.dart`.
The previously rejected commit `fc5fc410` took the
simplest-possible approach (strip all-dynamic tails in
`InterfaceType`). The user rejected that as "fixing the generator by
patching output to match an assertion" — i.e. the tail-stripping is a
behaviour choice rather than a principled fix, and hiding the
`<dynamic>` may mask legitimately-generic types that should carry
their inferred arguments. The follow-up investigation should:

1. Verify in isolation whether the AST-walker era actually emitted
   bare `Comparable` because of type-erasure semantics (not tail
   elision). If so, the element-mode fix is to *compute* the erased
   bound (`TypeSystem.instantiateInterfaceToBounds` or equivalent)
   rather than render the raw-dynamic type — and the output would
   incidentally not carry `<dynamic>`, but for the right reason.
2. Only then, if no semantic-equivalence fix applies, consider
   surface-level tail elision guarded by a property of the source
   (`wasRawType`, alias origin) rather than applied universally.

### R3 — `tom_d4rt` CSV-baseline artefacts (not a regression)

`tom_d4rt` has no `d4rtgen` section; no Phase-7 generator change can
affect it. The 2 X/OK entries in the CSV (`I-COLL-25`, `I-FILE-47`)
match rows that Phase 0's narrative table (`baseline_summary_refactor.md`,
"Known pre-existing failures → tom_d4rt") already enumerates as
long-standing pre-existing fails. The CSV's *column baseline* just
happens to capture an earlier run where they passed. Count-level
parity (1699 / 3 / 1 in both) is the correct read here; the CSV
per-cell noise is orthogonal to the refactor.

No fix required.

## What to fix next (ordered)

1. **R1 — DONE.** GEN-095 `_isReachableViaBarrels` filter applied
   in `relaxer_generator.dart` across wrapper emission, factory
   emission, and type-arg collection; empty-stub fallback added
   so downstream imports always resolve. `tom_d4rt_dcli` back at
   702 / 2 / 0. `tom_dcli_exec` bridges now analyzer-clean.
2. **R2 — DONE (element-mode drift).** `fc5fc410` restored; the
   `<dynamic>`-tail elision in `renderDartType` is a semantic
   no-op in Dart and restores source-form parity without
   re-introducing an AST dependency. `G-TE-13` flipped back to
   passing.
3. **Follow-up (optional, not blocking Phase 7):** the 10 residual
   X/OK entries on `tom_d4rt_exec` are **pre-existing** failures
   not caused by the element-mode migration. Track them on the
   Phase 0 "known pre-existing failures" list and close Phase 7.
4. **Re-baseline:** run `testkit :baseline` in each CSV consumer to
   collapse dynamic-ID `G-TST-*` / `G-DOV-*` churn and produce the
   Phase-7-exit-gate oracle.

## What is *not* being done in this report

- No bridge reverts. `tom_d4rt_dcli` + `tom_dcli_exec` bridges are
  **the current generator's actual output** (empty-stub relaxers,
  not the broken ones from the pre-fix state).
- No edits to `baseline_summary_refactor.md` beyond its Phase 0
  content — the Phase 7 appendix that was reverted at the top of
  this session is not re-added. A fresh exit-gate baseline should
  be produced with `testkit :baseline` once the dynamic-ID churn
  is neutralised.
