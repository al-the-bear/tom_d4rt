# Post-cluster-fixes rebaseline (third same-day re-run) — `20260518-1428-post-cluster-fixes-rebaseline-3`

Third non-flutter rebaseline of the same day. The two prior runs
(`20260518-1357-post-cluster-fixes-rebaseline` and
`20260518-1415-post-cluster-fixes-rebaseline-2`) produced
bit-identical artefacts. No code changes under test have landed
since 1357 — the only commits since are the two testlog folders
themselves.

The flutter-material suites are intentionally **not** part of this
rebaseline.

| Field | Value |
| --- | --- |
| Baseline ID | `20260518-1428-post-cluster-fixes-rebaseline-3` |
| Date | 2026-05-18 (Mon, 14:28 CEST) |
| Git revision | `0fc468d4` (`0fc468d45b659a5d43a7972ddd4a792e252bd138`) |
| Branch | `main` |
| Bridges | regenerated via `tom_d4rt_flutter_ast/tool/regenerate_bridges.dart` (log: `_regen_bridges.log.txt`, success=true, 26.9 s) |
| Run protocol | `dart test --reporter expanded --file-reporter "json:<base>/<project>.result.json"`, all 7 projects in parallel |
| Comparison | non-flutter projects only |
| Verdict | **Regression confirmed reproducible a third time** — bit-identical totals, failures, and error blocks vs both prior same-day runs. |

## Result totals

| Project | Total | Passed | Failed | Skipped | Errors | Wall |
|---|---:|---:|---:|---:|---:|---:|
| `tom_ast_generator` | 390 | 388 | 2 | 0 | 0 | 00:36 |
| `tom_d4rt` | 1753 | 1751 | 1 | 1 | 0 | 00:29 |
| `tom_d4rt_ast` | 117 | 117 | 0 | 0 | 0 | 00:02 |
| `tom_d4rt_dcli` | 706 | 706 | 0 | 0 | 0 | 05:58 |
| `tom_d4rt_exec` | 2146 | 2143 | 3 | 0 | 0 | 01:01 |
| `tom_d4rt_generator` | 540 | 538 | 2 | 0 | 0 | 00:43 |
| `tom_dcli_exec` | 412 | 412 | 0 | 0 | 0 | 00:12 |
| **TOTAL** | **6064** | **6055** | **8** | **1** | **0** |  |

`_summary.md`, `_failures.md`, and the three
`*_d4_compile_error.log.txt` blocks are bit-identical to the 1357
run (verified with `diff`). Wall times shifted by ±0–7 s — normal
noise.

## Delta vs the two prior same-day baselines

| Comparison | Δ |
|---|---|
| vs 1357 | **identical** (summary, failures, error blocks all bit-identical) |
| vs 1415 | **identical** (summary, failures, error blocks all bit-identical) |

## Delta vs `testlog_20260503-2238-post-fixes-rebaseline`

Unchanged from 1357/1415: **−348 tests / +6 new `setUpAll`
failures** attributable to the
`FutureOr<Object?>` vs `FutureOr<Object>` generator regression at
`test_callback_types.b.dart:175:158`.

| Project | 2238 | 1428 | Δ tests | Δ pass | Δ fail |
|---|---|---|---:|---:|---:|
| `tom_ast_generator` | 510/510/0 | 390/388/2 | −120 | −122 | +2 |
| `tom_d4rt` | 1747/1745/1 | 1753/1751/1 | +6 | +6 | 0 |
| `tom_d4rt_ast` | 117/117/0 | 117/117/0 | 0 | 0 | 0 |
| `tom_d4rt_dcli` | 706/706/0 | 706/706/0 | 0 | 0 | 0 |
| `tom_d4rt_exec` | 2260/2259/1 | 2146/2143/3 | −114 | −116 | +2 |
| `tom_d4rt_generator` | 660/660/0 | 540/538/2 | −120 | −122 | +2 |
| `tom_dcli_exec` | 412/412/0 | 412/412/0 | 0 | 0 | 0 |
| **TOTAL** | 6412/6409/2 | 6064/6055/8 | **−348** | **−354** | **+6** |

## Delta vs `testlog_20260502-1010-consol-rebaseline`

Note: the path the user mentioned —
`testlog_20260503-1010-consol-rebaseline` — does not exist;
closest "before" is `testlog_20260502-1010-consol-rebaseline`.
Net vs 0502 is still better than the May-2 high-water mark
(−44 failures / −6 errors), but the new May-18 regression claws
back gains that 0503-2238 had cleanly resolved.

## Failing tests

`_failures.md` lists 8, bit-identical to 1357/1415:

- 2 × `I-BUG-14a` "SHOULD FAIL" (records with named fields) — pre-existing won't-fix marker.
- 6 × `setUpAll` compile failures in the `example/d4` smoke tests of `tom_ast_generator`, `tom_d4rt_exec`, `tom_d4rt_generator`.

## Captured-error sweep

All three regressing projects fail the same compile at
`test_callback_types.b.dart:175:158`:

```
Error: The argument type 'FutureOr<Object?> Function(dynamic)'
       can't be assigned to the parameter type
       'FutureOr<Object> Function(dynamic)'.
```

No other unattributed errors. The two `Skipping HTTP request
test: Runtime Error: Break statement outside of a loop` hits in
`tom_d4rt.log.txt` / `tom_d4rt_exec.log.txt` are deliberate
test-internal prints from `expectError`-style fixtures — same
dismissal as 1357, 1415, and 0503-2238.

## Verdict — same regression, third reproduction

The 6 new `setUpAll` failures from 1357 reproduce 1-for-1 for the
third time. Diagnosis and recommended fix shape live in
`testlog_20260518-1357-post-cluster-fixes-rebaseline/error_analysis.md`.

`error_analysis.md` in this folder is intentionally short — it
points back at the 1357 analysis rather than triple-duplicating
it.

## Files in this directory

Identical structure to the 1357 / 1415 testlog folders.
