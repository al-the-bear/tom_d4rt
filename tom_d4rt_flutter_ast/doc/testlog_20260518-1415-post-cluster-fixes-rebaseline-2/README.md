# Post-cluster-fixes rebaseline (re-run) — `20260518-1415-post-cluster-fixes-rebaseline-2`

Second non-flutter rebaseline of the same day, requested after the
`20260518-1357-post-cluster-fixes-rebaseline` run. No code changes
under test landed in between (the only commit added since 1357 is
the testlog-only `65677675` that documented 1357 itself), so this
run serves as a **reproducibility check** of the 1357 result.

The flutter-material suites are intentionally **not** part of this
rebaseline.

| Field | Value |
| --- | --- |
| Baseline ID | `20260518-1415-post-cluster-fixes-rebaseline-2` |
| Date | 2026-05-18 (Mon, 14:15 CEST) |
| Git revision | `65677675` (`65677675396422d4f48a30a8107789f75ea771bf`) |
| Branch | `main` |
| Bridges | regenerated via `tom_d4rt_flutter_ast/tool/regenerate_bridges.dart` (log: `_regen_bridges.log.txt`, success=true, 26.9 s) |
| Run protocol | `dart test --reporter expanded --file-reporter "json:<base>/<project>.result.json"`, all 7 projects in parallel |
| Comparison | non-flutter projects only |
| Verdict | **Regression confirmed reproducible** — identical totals, failures, and error blocks to the 1357 run. |

## Result totals

| Project | Total | Passed | Failed | Skipped | Errors | Wall |
|---|---:|---:|---:|---:|---:|---:|
| `tom_ast_generator` | 390 | 388 | 2 | 0 | 0 | 00:39 |
| `tom_d4rt` | 1753 | 1751 | 1 | 1 | 0 | 00:24 |
| `tom_d4rt_ast` | 117 | 117 | 0 | 0 | 0 | 00:02 |
| `tom_d4rt_dcli` | 706 | 706 | 0 | 0 | 0 | 06:00 |
| `tom_d4rt_exec` | 2146 | 2143 | 3 | 0 | 0 | 00:54 |
| `tom_d4rt_generator` | 540 | 538 | 2 | 0 | 0 | 00:45 |
| `tom_dcli_exec` | 412 | 412 | 0 | 0 | 0 | 00:12 |
| **TOTAL** | **6064** | **6055** | **8** | **1** | **0** |  |

`_summary.md` and `_failures.md` are **bit-identical** to the 1357
baseline (verified with `diff`). The three captured compile-error
blocks are bit-identical too. Wall times shifted by ±1–4 s across
suites — within normal noise.

## Delta vs `testlog_20260518-1357-post-cluster-fixes-rebaseline`

| Project | 1357 (T/P/F/S/E) | 1415 (T/P/F/S/E) | Δ |
|---|---|---|---|
| `tom_ast_generator` | 390/388/2/0/0 | 390/388/2/0/0 | identical |
| `tom_d4rt` | 1753/1751/1/1/0 | 1753/1751/1/1/0 | identical |
| `tom_d4rt_ast` | 117/117/0/0/0 | 117/117/0/0/0 | identical |
| `tom_d4rt_dcli` | 706/706/0/0/0 | 706/706/0/0/0 | identical |
| `tom_d4rt_exec` | 2146/2143/3/0/0 | 2146/2143/3/0/0 | identical |
| `tom_d4rt_generator` | 540/538/2/0/0 | 540/538/2/0/0 | identical |
| `tom_dcli_exec` | 412/412/0/0/0 | 412/412/0/0/0 | identical |
| **non-flutter total** | **6064/6055/8/1/0** | **6064/6055/8/1/0** | **identical** |

## Delta vs `testlog_20260503-2238-post-fixes-rebaseline`

| Project | 2238 (T/P/F/S/E) | 1415 (T/P/F/S/E) | Δ tests | Δ pass | Δ fail | Δ err |
|---|---|---|---:|---:|---:|---:|
| `tom_ast_generator` | 510/510/0/0/0 | 390/388/2/0/0 | **−120** | **−122** | **+2** | 0 |
| `tom_d4rt` | 1747/1745/1/1/0 | 1753/1751/1/1/0 | **+6** | **+6** | 0 | 0 |
| `tom_d4rt_ast` | 117/117/0/0/0 | 117/117/0/0/0 | 0 | 0 | 0 | 0 |
| `tom_d4rt_dcli` | 706/706/0/0/0 | 706/706/0/0/0 | 0 | 0 | 0 | 0 |
| `tom_d4rt_exec` | 2260/2259/1/0/0 | 2146/2143/3/0/0 | **−114** | **−116** | **+2** | 0 |
| `tom_d4rt_generator` | 660/660/0/0/0 | 540/538/2/0/0 | **−120** | **−122** | **+2** | 0 |
| `tom_dcli_exec` | 412/412/0/0/0 | 412/412/0/0/0 | 0 | 0 | 0 | 0 |
| **non-flutter total** | **6412/6409/2/1/0** | **6064/6055/8/1/0** | **−348** | **−354** | **+6** | 0 |

Same picture as the 1357 baseline: −348 tests / +6 new
`setUpAll` failures attributable to the
`FutureOr<Object?>` vs `FutureOr<Object>` generator regression.

## Delta vs `testlog_20260502-1010-consol-rebaseline`

| Project | 0502 (T/P/F/S/E) | 1415 (T/P/F/S/E) | Δ tests | Δ pass | Δ fail | Δ err |
|---|---|---|---:|---:|---:|---:|
| `tom_ast_generator` | 510/503/6/0/1 | 390/388/2/0/0 | **−120** | **−115** | **−4** | **−1** |
| `tom_d4rt` | 1747/1736/9/1/1 | 1753/1751/1/1/0 | **+6** | **+15** | **−8** | **−1** |
| `tom_d4rt_ast` | 117/115/0/0/2 | 117/117/0/0/0 | 0 | **+2** | 0 | **−2** |
| `tom_d4rt_dcli` | 706/704/1/0/1 | 706/706/0/0/0 | 0 | **+2** | **−1** | **−1** |
| `tom_d4rt_exec` | 2260/2234/25/0/1 | 2146/2143/3/0/0 | **−114** | **−91** | **−22** | **−1** |
| `tom_d4rt_generator` | 660/652/8/0/0 | 540/538/2/0/0 | **−120** | **−114** | **−6** | 0 |
| `tom_dcli_exec` | 75/72/3/0/0 | 412/412/0/0/0 | **+337** | **+340** | **−3** | 0 |
| **non-flutter total** | **6075/6016/52/1/6** | **6064/6055/8/1/0** | **−11** | **+39** | **−44** | **−6** |

(Note: the earlier reference path the user mentioned —
`testlog_20260503-1010-consol-rebaseline` — does not exist in
this folder. The closest "before" snapshots are
`testlog_20260502-1010-consol-rebaseline` and
`testlog_20260503-2238-post-fixes-rebaseline`, both compared above.)

## Failing tests

`_failures.md` lists 8, identical to the 1357 run:

```
tom_ast_generator      (2):
  (setUpAll)                                                                 [d4rt_tester_test.dart]
  dart_overview coverage (setUpAll)                                          [d4rt_coverage_test.dart]

tom_d4rt               (1):
  Open Bugs - Won't Fix (SHOULD FAIL) I-BUG-14a: Records with named fields.  [limitations_and_bugs_test.dart]

tom_d4rt_exec          (3):
  Open Bugs - Won't Fix (SHOULD FAIL) I-BUG-14a: Records with named fields.  [limitations_and_bugs_test.dart]
  (setUpAll)                                                                 [d4rt_tester_test.dart]
  dart_overview coverage (setUpAll)                                          [d4rt_coverage_test.dart]

tom_d4rt_generator     (2):
  (setUpAll)                                                                 [d4rt_tester_test.dart]
  dart_overview coverage (setUpAll)                                          [d4rt_coverage_test.dart]
```

- 2 × `I-BUG-14a` "SHOULD FAIL" — pre-existing won't-fix marker.
- 6 × `setUpAll` — same generator-side regression as 1357.

## Captured-error sweep

All three regressing projects fail the same compile at
`test_callback_types.b.dart:175:158`:

```
Error: The argument type 'FutureOr<Object?> Function(dynamic)'
       can't be assigned to the parameter type
       'FutureOr<Object> Function(dynamic)'.
```

The extracted blocks (`<project>_d4_compile_error.log.txt`) are
bit-identical to the 1357 run.

No other unattributed errors. The two `Skipping HTTP request
test: Runtime Error: Break statement outside of a loop` hits in
`tom_d4rt.log.txt` / `tom_d4rt_exec.log.txt` are deliberate
test-internal prints from `expectError`-style fixtures whose
tests pass — same dismissal as 1357 and 0503-2238.

## Verdict — same regression, fully reproducible

The 6 new `setUpAll` failures from 1357 reproduce 1-for-1 with
identical error blocks and identical pass / fail / skip
counts. The regression is real and stable. Diagnosis and
suggested fix shape are documented in 1357's `error_analysis.md`
(suspect commit `114f11f5`, "C11 nullable FutureOr callback
returns" — generic-erasure path appears to be applied to the
non-generic overload of `CallbackTypeService.withConnection`).

`error_analysis.md` in this folder is intentionally short — it
points back at the 1357 analysis rather than duplicating it.

## Files in this directory

| File | What it is |
| --- | --- |
| `_baseline_id.txt` | Just the baseline ID string. |
| `_revision.txt` | Git SHA + branch at the time of the run. |
| `_timestamp.txt` | Wall-clock timestamp. |
| `_regen_bridges.log.txt` | Output from `tool/regenerate_bridges.dart`. |
| `_progress.txt` | Per-suite completion markers (one line per suite). |
| `_summarize.dart` | Result.json → totals table. Re-runnable. |
| `_summary.md` | Latest table generated by `_summarize.dart`. |
| `_failures.dart` | Result.json → per-project failure list. Re-runnable. |
| `_failures.md` | Latest list generated by `_failures.dart`. |
| `error_analysis.md` | Short pointer to the 1357 analysis. |
| `<project>.result.json` | Raw `dart test` JSON file-reporter output. |
| `<project>.log.txt` | tee'd console output for human inspection. |
| `<project>_d4_compile_error.log.txt` | Extracted compile-failure block. |
