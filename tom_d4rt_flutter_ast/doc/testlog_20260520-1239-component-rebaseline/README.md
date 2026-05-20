# Component rebaseline — `20260520-1239-component-rebaseline`

Re-run of the **non-flutter** d4rt-repository test suites to verify
that the interpreter / generator / `_ast` / script fixes that
closed Clusters 1–11 of the flutter-material campaign (and the
38-item framework-error fix sweep in
`testlog_20260519-1247-flutter-suites-fixes`) have not regressed
any component-level test suite. Compared against the two prior
component baselines:

- [`testlog_20260503-2238-post-fixes-rebaseline`](../testlog_20260503-2238-post-fixes-rebaseline/README.md) — pre-May-18 high-water (clean: 6412 tests, 2 documented "won't fix" failures).
- [`testlog_20260518-1428-post-cluster-fixes-rebaseline-3`](../testlog_20260518-1428-post-cluster-fixes-rebaseline-3/README.md) — the May-18 same-day reproducible regression baseline (6 new `setUpAll` compile-error failures, totals 6064/6055/8/1).

> **Naming note:** the request referenced
> `testlog_20260519-1247-post-cluster-fixes-rebaseline`, which does
> not exist. The 0519-1247 testlog folder is
> `testlog_20260519-1247-flutter-suites-fixes`, a flutter-suite
> framework-error fix log — not a component rebaseline. The closest
> existing post-cluster component baseline is the
> `0518-1428` triplet (1357/1415/1428 are bit-identical), and that
> is what this run is compared against.

The flutter-material suites (`essential` / `important` /
`secondary` / `hardly_relevant_*` / `gii` / `retest` …) are
explicitly **not** part of this rebaseline — those run via
separate `testlog_20260520-0933-issue-analysis/` logs in both
`tom_d4rt_flutter_ast/doc/` and `tom_d4rt_flutter_test/doc/`.

| Field | Value |
| --- | --- |
| Baseline ID | `20260520-1239-component-rebaseline` |
| Date | 2026-05-20 (Wed, 12:39 CEST) |
| Git revision | `43947032` (`43947032a40400092b5498f9078ca0731074b650`) |
| Branch | `main` (with sibling-project working-tree changes — none affect the d4rt component tests) |
| Bridges | regenerated via `tom_d4rt_flutter_ast/tool/regenerate_bridges.dart` (log: `_regen_bridges.log.txt`, **`Success: true`**, **0:00:26.99**) |
| Run protocol | `dart test --reporter expanded --file-reporter "json:<base>/<project>.result.json"`, all 7 non-flutter projects in parallel (independent suites, no shared HTTP server) |
| Wall (parallel) | ~06:00 (dominated by `tom_d4rt_dcli` at 5m43s; first finisher `tom_d4rt_ast` at 0m07s; see `_progress.txt`) |
| Comparison | non-flutter projects only — `0518-1428` (most-recent same-day) and `0503-2238` (older clean) |
| Verdict | **No regressions — 0518-1428's setUpAll compile failures are GONE; totals are back at or above the 0503-2238 high-water.** |

## Projects covered

7 packages with a `test/` directory under `tom_ai/d4rt/`:

`tom_ast_generator`, `tom_d4rt`, `tom_d4rt_ast`, `tom_d4rt_dcli`,
`tom_d4rt_exec`, `tom_d4rt_generator`, `tom_dcli_exec`.

Two additional packages in the same folder have no `test/`
directory and are out of scope: `tom_ast_model` (model-only,
no tests) and `tom_d4rt_test` (workspace stub, only `lib/` +
`bin/`).

## Result totals

| Project | Total | Passed | Failed | Skipped | Errors |
|---|---:|---:|---:|---:|---:|
| `tom_ast_generator` | 510 | 510 | 0 | 0 | 0 |
| `tom_d4rt` | 1753 | 1751 | 1 | 1 | 0 |
| `tom_d4rt_ast` | 117 | 117 | 0 | 0 | 0 |
| `tom_d4rt_dcli` | 706 | 706 | 0 | 0 | 0 |
| `tom_d4rt_exec` | 2266 | 2265 | 1 | 0 | 0 |
| `tom_d4rt_generator` | 660 | 659 | 1 | 0 | 0 |
| `tom_dcli_exec` | 412 | 412 | 0 | 0 | 0 |
| **TOTAL** | **6424** | **6420** | **3** | **1** | **0** |

(Bit-identical to `_summary.md`.)

## Delta vs `testlog_20260518-1428-post-cluster-fixes-rebaseline-3`

| Project | 0518-1428 (T/P/F/S/E) | 1239 (T/P/F/S/E) | Δ tests | Δ pass | Δ fail | Δ err |
|---|---|---|---:|---:|---:|---:|
| `tom_ast_generator` | 390/388/2/0/0 | 510/510/0/0/0 | **+120** | **+122** | **−2** | 0 |
| `tom_d4rt` | 1753/1751/1/1/0 | 1753/1751/1/1/0 | 0 | 0 | 0 | 0 |
| `tom_d4rt_ast` | 117/117/0/0/0 | 117/117/0/0/0 | 0 | 0 | 0 | 0 |
| `tom_d4rt_dcli` | 706/706/0/0/0 | 706/706/0/0/0 | 0 | 0 | 0 | 0 |
| `tom_d4rt_exec` | 2146/2143/3/0/0 | 2266/2265/1/0/0 | **+120** | **+122** | **−2** | 0 |
| `tom_d4rt_generator` | 540/538/2/0/0 | 660/659/1/0/0 | **+120** | **+121** | **−1** | 0 |
| `tom_dcli_exec` | 412/412/0/0/0 | 412/412/0/0/0 | 0 | 0 | 0 | 0 |
| **TOTAL** | **6064/6055/8/1/0** | **6424/6420/3/1/0** | **+360** | **+365** | **−5** | 0 |

**The 0518-1428 regression has been fully resolved.** All six
`setUpAll` compile-error failures from
`example/d4/lib/src/d4rt_bridges/test_callback_types.b.dart:175:158`
(`FutureOr<Object?>` vs `FutureOr<Object>`) are gone, restoring the
+120 test-count contributions from the `example/d4` smoke suites
in `tom_ast_generator`, `tom_d4rt_exec`, and `tom_d4rt_generator`.

## Delta vs `testlog_20260503-2238-post-fixes-rebaseline`

| Project | 0503-2238 (T/P/F/S/E) | 1239 (T/P/F/S/E) | Δ tests | Δ pass | Δ fail | Δ err |
|---|---|---|---:|---:|---:|---:|
| `tom_ast_generator` | 510/510/0/0/0 | 510/510/0/0/0 | 0 | 0 | 0 | 0 |
| `tom_d4rt` | 1747/1745/1/1/0 | 1753/1751/1/1/0 | **+6** | **+6** | 0 | 0 |
| `tom_d4rt_ast` | 117/117/0/0/0 | 117/117/0/0/0 | 0 | 0 | 0 | 0 |
| `tom_d4rt_dcli` | 706/706/0/0/0 | 706/706/0/0/0 | 0 | 0 | 0 | 0 |
| `tom_d4rt_exec` | 2260/2259/1/0/0 | 2266/2265/1/0/0 | **+6** | **+6** | 0 | 0 |
| `tom_d4rt_generator` | 660/660/0/0/0 | 660/659/1/0/0 | 0 | **−1** | **+1** | 0 |
| `tom_dcli_exec` | 412/412/0/0/0 | 412/412/0/0/0 | 0 | 0 | 0 | 0 |
| **TOTAL** | **6412/6409/2/1/0** | **6424/6420/3/1/0** | **+12** | **+11** | **+1** | 0 |

Net vs 0503-2238: **+12 new tests, +11 passing, +1 nominal new
failure**. The new failure is an environmental flake (G-DCLI-07,
see `error_analysis.md` §2) — passes on isolated re-run — not a
code regression. The +6 / +6 deltas on `tom_d4rt` and
`tom_d4rt_exec` reflect new entries in
`limitations_and_bugs_test.dart` that both packages share.

## Failing tests

`_failures.md` lists 3 failures, all benign:

```
### tom_d4rt
Failures (1):
  - I-BUG-14a: Records with named fields. (FAIL)
    [limitations_and_bugs_test.dart]

### tom_d4rt_exec
Failures (1):
  - I-BUG-14a: Records with named fields. (FAIL)
    [limitations_and_bugs_test.dart]
    (same script, both packages share limitations_and_bugs_test.dart)

### tom_d4rt_generator
Failures (1):
  - G-DCLI-07: Basic file operations.
    [d4rt_tester_test.dart] — TRANSIENT environmental flake
```

The first two are the pre-existing won't-fix `I-BUG-14a`
"`(SHOULD FAIL)`" marker (interpreter returns
`InterpretedRecord:<(x: 10, y: 20)>` where the test expects
`Instance of '({int x, int y})'` — a documented limitation, not a
regression).

The third is the same `dcli_07_basic_file_ops` test that passed
on isolated re-run (see `error_analysis.md` §2 for the
environmental-cleanup-race diagnosis).

## Captured-error sweep

Beyond the three documented failures, no log carries an
unattributed error / framework-error / runtime panel. The
recurring noise lines are all test-internal `print()` calls from
`expectError`-style fixtures and from `dart_overview.b.dart`
coverage scripts that intentionally invoke failing flows:

- `Error: Network error`, `[404] Error: Not found`,
  `Failed: Invalid password (3 attempts)` — fixture prints from
  `dart_overview` coverage scripts (same dismissal as
  0503-2238 and 0518-1428).
- `Warning: Failed to log d4rtgen invocation: PathNotFoundException` —
  a hardcoded macOS path `/Users/alexiskyaw/Desktop/Code/tom2/…`
  in a test fixture; the warning is the expected output, not an
  error.
- `Runtime Error: Break statement outside of a loop` lines in
  `tom_d4rt.log.txt` and `tom_d4rt_exec.log.txt` — deliberate
  `expectError` fixture output.
- `Caught in catch: TryException` — try/catch coverage fixture
  output.
- `[DEBUG] [Environment] Defined bridge for class: …` — d4rt
  startup diagnostics, not errors.

## Verdict — no regressions; 0518-1428 fully resolved

The fixes landed since `0518-1428` (the 38-item flutter-suite
fix campaign + Cluster I closure on 2026-05-20, plus the
companion interpreter and `_ast` mirrors required by the
"keep tom_d4rt ↔ tom_d4rt_ast in sync" rule) leave every
non-flutter component test suite at or above the 0503-2238
clean high-water:

- Net **+360 tests, +365 passing, −5 failures** vs 0518-1428.
- Net **+12 tests, +11 passing** vs 0503-2238 with one
  environmental-flake failure that re-runs green.
- 0 regressions attributable to the recent interpreter / `_ast` /
  generator changes.

## Files in this directory

| File | What it is |
| --- | --- |
| `_baseline_id.txt` | Just the baseline ID string. |
| `_revision.txt` | Git SHA + branch at the time of the run. |
| `_timestamp.txt` | Wall-clock timestamp. |
| `_regen_bridges.log.txt` | Output from `tool/regenerate_bridges.dart`. |
| `_progress.txt` | Per-suite completion markers (one line per suite). |
| `_summarize.dart` | `*.result.json` → totals table. Re-runnable. |
| `_summary.md` | Latest table generated by `_summarize.dart`. |
| `_failures.dart` | `*.result.json` → per-project failure list. Re-runnable. |
| `_failures.md` | Latest list generated by `_failures.dart`. |
| `error_analysis.md` | Failure / error analysis summary. |
| `<project>.result.json` | Raw `dart test` JSON file-reporter output (7 files). |
| `<project>.log.txt` | tee'd console output for human inspection (7 files). |

## How to compare a future run

```bash
cd doc/testlog_<new-id>
dart run _summarize.dart > _summary.md
dart run _failures.dart > _failures.md
diff _summary.md ../testlog_20260520-1239-component-rebaseline/_summary.md
diff _failures.md ../testlog_20260520-1239-component-rebaseline/_failures.md
```
