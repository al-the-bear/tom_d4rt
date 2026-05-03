# Error analysis — `20260503-1221-consol-rebaseline-check`

Re-run of the **non-flutter** d4rt-repository test suites against
git revision `53da6410` (`main`), to verify that the recent
interpreter / generator / bridge fixes have not regressed the
component-level test suites of the d4rt projects.

Compared to baseline `testlog_20260502-1010-consol-rebaseline`
(rev `4941d1f5`).

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

**Headline:** −50 failures and −6 errors vs the 0502 rebaseline,
plus +337 new tests. **No regressions** in any non-flutter suite.

## File-by-file failures and errors

### `tom_ast_generator.result.json` — 0 failures, 0 errors

Clean. Six historical G-DCLI failures and one setUpAll error
from the 0502 baseline are now gone.

### `tom_d4rt.result.json` — 1 failure, 0 errors

| # | Test | Source | Verdict |
|---|------|--------|---------|
| 1 | `Open Bugs - Won't Fix (SHOULD FAIL) I-BUG-14a: Records with named fields. [2026-02-10 06:37] (FAIL)` | `limitations_and_bugs_test.dart` | **Intentional won't-fix marker.** |

**Detail:**

```
Expected: <Instance of '({int x, int y})'>
  Actual: InterpretedRecord:<(x: 10, y: 20)>
```

The test description contains the literal text `(SHOULD FAIL)` —
this is a documented limitation tracker. The interpreter currently
returns `InterpretedRecord` for records with named fields where
the test expects the analyzer/runtime native record type. This
has the same status as on the 0502 baseline; it has always
appeared in the historical pre-existing list (`I-BUG-14a`).

### `tom_d4rt_ast.result.json` — 0 failures, 0 errors

Clean. The two `ast_module_loader_test` stdlib-loading errors
that were carried since the 0429 baseline are gone — this suite
is now fully green for the first time since the consolidation
work began.

### `tom_d4rt_dcli.result.json` — 0 failures, 0 errors

Clean. The two VS Code scripting-API live-bridge items flagged
as *environment-dependent* on 0502 (`live bridge can get active
editor`, `VSCodeWindow getActiveTextEditor`) now pass.

### `tom_d4rt_exec.result.json` — 1 failure, 0 errors

| # | Test | Source | Verdict |
|---|------|--------|---------|
| 1 | `Open Bugs - Won't Fix (SHOULD FAIL) I-BUG-14a: Records with named fields. [2026-02-10 06:37] (FAIL)` | `limitations_and_bugs_test.dart` | **Intentional won't-fix marker.** |

Same source file as `tom_d4rt`, re-mounted; same `(SHOULD FAIL)`
test. Identical signature.

The 25 failures and 1 error from the 0502 rebaseline (including
the entire `D4rtTester end-to-end dcli_scripting_guide
G-DCLI-01..14` cluster, plus the `HashSet I-COLL-25` error) are
all gone.

### `tom_d4rt_generator.result.json` — 0 failures, 0 errors

Clean. The remaining `G-DOV3-1`, `G-CB-7/11/12`,
`G-FLP-16/23/28/30` cluster from the 0502 rebaseline is gone —
all 660 tests pass. The bridge generator is a clean reference.

### `tom_dcli_exec.result.json` — 0 failures, 0 errors

Clean. Suite size grew 75 → 412 (+337 tests) since 0502 — an
entire new test layer landed in this project. The three
pre-existing advanced-DCli example failures are gone, and all
new tests pass on first run.

## Comparison vs `testlog_20260502-1010-consol-rebaseline`

### Per-project deltas

| Project | 0502 (T/P/F/S/E) | 0503 (T/P/F/S/E) | Δ tests | Δ pass | Δ fail | Δ err |
|---|---|---|---:|---:|---:|---:|
| `tom_ast_generator` | 510/503/6/0/1 | 510/510/0/0/0 | 0 | +7 | **−6** | **−1** |
| `tom_d4rt` | 1747/1736/9/1/1 | 1747/1745/1/1/0 | 0 | +9 | **−8** | **−1** |
| `tom_d4rt_ast` | 117/115/0/0/2 | 117/117/0/0/0 | 0 | +2 | 0 | **−2** |
| `tom_d4rt_dcli` | 706/704/1/0/1 | 706/706/0/0/0 | 0 | +2 | **−1** | **−1** |
| `tom_d4rt_exec` | 2260/2234/25/0/1 | 2260/2259/1/0/0 | 0 | +25 | **−24** | **−1** |
| `tom_d4rt_generator` | 660/652/8/0/0 | 660/660/0/0/0 | 0 | +8 | **−8** | 0 |
| `tom_dcli_exec` | 75/72/3/0/0 | 412/412/0/0/0 | **+337** | +340 | **−3** | 0 |
| **non-flutter total** | **6075/6016/52/1/6** | **6412/6409/2/1/0** | **+337** | **+393** | **−50** | **−6** |

### Disappeared since 0502

- **`tom_d4rt`** — `GEN-056d` (extension on unknown type),
  `I-MISC-40`, `I-MISC-41` (export conflict), `I-MISC-212`
  (strict-bool / strict-typing), `I-FILE-36`, `I-FILE-38`,
  `DCL-RT-OPT-02`, `I-FILE-47`, `HashSet I-COLL-25` (error).
- **`tom_d4rt_exec`** — entire `D4rtTester end-to-end
  dcli_scripting_guide G-DCLI-01..14` cluster (13 tests), plus
  12 other failures, plus the `HashSet I-COLL-25` error.
- **`tom_d4rt_generator`** — `G-DOV3-1`, `G-CB-7/11/12`,
  `G-FLP-16/23/28/30`.
- **`tom_ast_generator`** — six G-DCLI failures and one
  `(setUpAll)` / G-DCLI-12 error.
- **`tom_d4rt_ast`** — two `ast_module_loader_test` stdlib
  errors (the documented analyzer-free split starting point).
- **`tom_d4rt_dcli`** — two VS Code scripting-API live-bridge
  failures/errors.
- **`tom_dcli_exec`** — three advanced-DCli example failures.

### New since 0502

- **None failing.** +337 new tests landed in `tom_dcli_exec`,
  all green on first run.

## Runtime-error / framework-error sweep

The 0502 rebaseline also tracked "errors" classified by the dart
test runner as `error` rather than `failure` (e.g. setUpAll
blowups, HashSet I-COLL-25). All six are gone. **No new errors
of any class** in the 0503 run.

## Verdict

The interpreter / generator / consolidation work landed since
the 0502 rebaseline (clusters 1..11 + GEN-094 + suspicious-rewrite
cleanup) has produced a **uniform, large improvement** across
every non-flutter d4rt project, with no regressions. The only
remaining failure is the documented `I-BUG-14a` won't-fix marker
(records with named fields) — same status it has held since the
0429 baseline.

## Suggested follow-ups

1. **Reclassify `I-BUG-14a`** — convert the `(SHOULD FAIL)`
   test into either an explicit `expectedFails` annotation or a
   skip with a tracking issue, so the suite can show 0/0 across
   the board.
2. **Lock in the rebaseline.** The 0502 rebaseline is now the
   "before"; this 0503 run is the "after" for the consolidation
   work. Update `_ai/quests/d4rt/overview.d4rt.md` if it still
   references the 0502 numbers.
3. **Drop the cross-project G-DCLI duplication note** from the
   open-questions list — the duplication no longer masks a
   divergence; all three copies pass.
