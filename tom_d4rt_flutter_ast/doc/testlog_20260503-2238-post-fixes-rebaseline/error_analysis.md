# Error analysis — `20260503-2238-post-fixes-rebaseline`

Re-run of the **non-flutter** d4rt-repository test suites at git
revision `71e1984c` (`main`), to verify that the interpreter /
generator / script fixes landed since
`testlog_20260503-1221-consol-rebaseline-check` (rev `53da6410`)
have not regressed any component-level test suite.

The flutter-material suites (`essential` / `important` /
`secondary` …) are explicitly **not** part of this rebaseline —
those are tracked separately under
`testlog_20260503-*-issue-analysis/` in `tom_d4rt_flutter_ast/doc/`
and `tom_d4rt_flutter_test/doc/`.

## Headline

**0 regressions.** Every non-flutter project matches the
`0503-1221` totals exactly. The cumulative `0502 → now` improvement
of **−50 failures**, **−6 errors**, **+337 new tests** is fully
preserved.

## Summary

| Project | Total | Passed | Failed | Skipped | Errors |
|---|---:|---:|---:|---:|---:|
| `tom_ast_generator` | 510 | 510 | 0 | 0 | 0 |
| `tom_d4rt` | 1747 | 1745 | 1 | 1 | 0 |
| `tom_d4rt_ast` | 117 | 117 | 0 | 0 | 0 |
| `tom_d4rt_dcli` | 706 | 706 | 0 | 0 | 0 |
| `tom_d4rt_exec` | 2260 | 2259 | 1 | 0 | 0 |
| `tom_d4rt_generator` | 660 | 660 | 0 | 0 | 0 |
| `tom_dcli_exec` | 412 | 412 | 0 | 0 | 0 |
| **TOTAL** | **6412** | **6409** | **2** | **1** | **0** |

## Commits since `0503-1221`

```
71e1984c docs(d4rt): testlog 20260503-2009 issue-analysis sweep
eadebb6c fix(d4rt-flutter-scripts): clear layout-overflow framework errors (cluster P6)
ae6ad5b6 fix(d4rt): rewrite ButtonBar* scripts onto OverflowBar (cluster P5)
4f183f46 fix(d4rt-flutter-scripts): convert switch-over-bridged-enum to if/else (cluster P4)
e3879c65 fix(d4rt-interpreter): walk bridged supertype chain on missing leaf adapter
66189be9 chore(d4): regen example/d4 bridges across tom_ast_generator, tom_d4rt_exec, tom_d4rt_generator
5784af55 fix(d4rt-interpreter): unwrap BridgedInstance<Iterable> in collection-literal for-in
34125cde fix(d4rt-flutter): allowlist SliderComponentShape + SpellCheckService proxies
4aac542a fix(d4rt-generator): drop dynamic Function() outer cast on callback wrappers
```

Three of these commits change behaviour observable by the
non-flutter suites (the others are flutter-side only):

| Commit | Behaviour change | Where it could surface |
|---|---|---|
| `5784af55` | Interpreter: unwrap `BridgedInstance<Iterable>` in collection-literal `for-in` | Any `tom_d4rt` / `tom_d4rt_exec` test exercising spread / `for`-element over a bridged iterable. |
| `e3879c65` | Interpreter: walk bridged supertype chain on missing leaf adapter | Any test calling an inherited method on a bridged subclass where the leaf class has no adapter (e.g. `dart:io` / `dart:typed_data` hierarchies). |
| `4aac542a` | Generator: drop outer `dynamic Function()` cast on callback wrappers | Generator-test snapshots and any consumer where the wrapper was previously `(...) as dynamic Function()`. |

The non-flutter suites cover every one of those code paths in
their existing fixtures, and all of them remain at the
`0503-1221` headline — i.e. these commits are behaviour-preserving
for the component suites in addition to fixing the flutter-side
regressions they were aimed at.

## File-by-file failures and errors

### `tom_ast_generator.result.json` — 0 failures, 0 errors

Clean. Identical to `0503-1221`.

### `tom_d4rt.result.json` — 1 failure, 0 errors

| # | Test | Source | Verdict |
|---|------|--------|---------|
| 1 | `Open Bugs - Won't Fix (SHOULD FAIL) I-BUG-14a: Records with named fields. [2026-02-10 06:37] (FAIL)` | `limitations_and_bugs_test.dart` | **Intentional won't-fix marker.** |

```
Expected: <Instance of '({int x, int y})'>
  Actual: InterpretedRecord:<(x: 10, y: 20)>
```

The literal `(SHOULD FAIL)` text in the test description is the
documented marker. Same status as on `0503-1221` and the
`0502-1010` baseline.

### `tom_d4rt_ast.result.json` — 0 failures, 0 errors

Clean. Identical to `0503-1221`.

### `tom_d4rt_dcli.result.json` — 0 failures, 0 errors

Clean. Identical to `0503-1221`.

### `tom_d4rt_exec.result.json` — 1 failure, 0 errors

| # | Test | Source | Verdict |
|---|------|--------|---------|
| 1 | `Open Bugs - Won't Fix (SHOULD FAIL) I-BUG-14a: Records with named fields. [2026-02-10 06:37] (FAIL)` | `limitations_and_bugs_test.dart` | **Intentional won't-fix marker.** |

Same source file as `tom_d4rt`, re-mounted; identical signature.

### `tom_d4rt_generator.result.json` — 0 failures, 0 errors

Clean. Identical to `0503-1221`. Notably, the
`4aac542a fix(d4rt-generator): drop dynamic Function() outer cast`
change was specifically validated against `G-FLP-28` before being
committed (the test asserts a non-`dynamic` return signature in
its expected output and is not affected by the dynamic-only skip).
The full 660/660 pass result confirms it.

### `tom_dcli_exec.result.json` — 0 failures, 0 errors

Clean. Identical to `0503-1221`.

## Per-project delta vs `0503-1221`

| Project | 1221 (T/P/F/S/E) | 2238 (T/P/F/S/E) | Δ |
|---|---|---|---|
| `tom_ast_generator` | 510/510/0/0/0 | 510/510/0/0/0 | identical |
| `tom_d4rt` | 1747/1745/1/1/0 | 1747/1745/1/1/0 | identical |
| `tom_d4rt_ast` | 117/117/0/0/0 | 117/117/0/0/0 | identical |
| `tom_d4rt_dcli` | 706/706/0/0/0 | 706/706/0/0/0 | identical |
| `tom_d4rt_exec` | 2260/2259/1/0/0 | 2260/2259/1/0/0 | identical |
| `tom_d4rt_generator` | 660/660/0/0/0 | 660/660/0/0/0 | identical |
| `tom_dcli_exec` | 412/412/0/0/0 | 412/412/0/0/0 | identical |

## Per-project delta vs `0502-1010`

| Project | 0502 (T/P/F/S/E) | 2238 (T/P/F/S/E) | Δ tests | Δ pass | Δ fail | Δ err |
|---|---|---|---:|---:|---:|---:|
| `tom_ast_generator` | 510/503/6/0/1 | 510/510/0/0/0 | 0 | +7 | **−6** | **−1** |
| `tom_d4rt` | 1747/1736/9/1/1 | 1747/1745/1/1/0 | 0 | +9 | **−8** | **−1** |
| `tom_d4rt_ast` | 117/115/0/0/2 | 117/117/0/0/0 | 0 | +2 | 0 | **−2** |
| `tom_d4rt_dcli` | 706/704/1/0/1 | 706/706/0/0/0 | 0 | +2 | **−1** | **−1** |
| `tom_d4rt_exec` | 2260/2234/25/0/1 | 2260/2259/1/0/0 | 0 | +25 | **−24** | **−1** |
| `tom_d4rt_generator` | 660/652/8/0/0 | 660/660/0/0/0 | 0 | +8 | **−8** | 0 |
| `tom_dcli_exec` | 75/72/3/0/0 | 412/412/0/0/0 | **+337** | +340 | **−3** | 0 |
| **non-flutter total** | **6075/6016/52/1/6** | **6412/6409/2/1/0** | **+337** | **+393** | **−50** | **−6** |

## Captured-error sweep

The user's rebaseline brief explicitly asked for "captured error
output in the log which might not have led to a failure" — i.e.
runtime-error / framework-error panels printed by passing tests.
A grep across all 7 `.log.txt` files for the canonical markers
(`framework error`, `Runtime Error`, `Unhandled exception`,
`uncaught`, `setUpAll`) produced these matches:

### `tom_d4rt.log.txt`

```
Runtime Error: Break statement outside of a loop.
```

Two occurrences. Both originate from `expectError`-style fixtures
in `limitations_and_bugs_test.dart` that deliberately exercise the
"break outside loop" path. The corresponding tests pass
(`expectError` checks for the substring, then succeeds). Not a
captured error — expected output. Same pattern as 0503-1221.

### `tom_d4rt_exec.log.txt`

Same two `Runtime Error: Break statement outside of a loop.` lines
as above (the same `limitations_and_bugs_test.dart` is
re-mounted in this project). Same explanation.

### All other logs

No matches. Clean.

## Verdict

The fixes landed since `0503-1221` (interpreter `for-in` over
bridged `Iterable`, interpreter supertype-chain lookup, generator
dynamic-Function cast, plus the proxy allowlist + flutter script
rewrites) leave every non-flutter component test suite at the
same headline as the `0503-1221` rebaseline-check.

**Conclusion:** The flutter-side bug-fix work is not leaking
regressions into the non-flutter component suites. The 0502 → now
improvement of **−50 / −6 / +337** is fully preserved. The
component-level baseline holds.

The only remaining failure remains the documented `I-BUG-14a`
won't-fix marker in `limitations_and_bugs_test.dart` — same
status as the prior two baselines, mounted in both `tom_d4rt` and
`tom_d4rt_exec`.

## Suggested follow-ups

Unchanged from `0503-1221` — the same three follow-ups still
apply:

1. **Reclassify `I-BUG-14a`** — convert the `(SHOULD FAIL)` test
   into either an explicit `expectedFails` annotation or a skip
   with a tracking issue, so the suite can show 0/0 across the
   board.
2. **Lock in the rebaseline.** This `0503-2238` run is the new
   reference for component-suite parity going forward; future
   rebaselines should diff against it.
3. **Drop the cross-project G-DCLI duplication note** — the
   duplication no longer masks a divergence; all three copies
   pass and have stayed green for two consecutive rebaselines.
