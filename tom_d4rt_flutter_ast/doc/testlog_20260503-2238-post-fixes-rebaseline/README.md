# Post-fixes rebaseline — `20260503-2238-post-fixes-rebaseline`

Re-run of the **non-flutter** d4rt-repository test suites to verify
that the interpreter / generator / script fixes landed since the
`20260503-1221-consol-rebaseline-check` have not regressed any
component-level test suite. Compared against the
[`20260502-1010-consol-rebaseline`](../testlog_20260502-1010-consol-rebaseline/README.md)
"before" and the
[`20260503-1221-consol-rebaseline-check`](../testlog_20260503-1221-consol-rebaseline-check/README.md)
intermediate.

The flutter-material suites (`essential` / `important` /
`secondary` …) are explicitly **not** part of this rebaseline —
those run via separate `testlog_20260503-*-issue-analysis` logs in
both `tom_d4rt_flutter_ast/doc/` and `tom_d4rt_flutter_test/doc/`.

| Field | Value |
| --- | --- |
| Baseline ID | `20260503-2238-post-fixes-rebaseline` |
| Date | 2026-05-03 (Sun, ~22:38 CEST) |
| Git revision | `71e1984c` (`71e1984ca2fccd99742d6a711aeb494c2f2eaa38`) |
| Branch | `main` |
| Bridges | regenerated via `tom_d4rt_flutter_ast/tool/regenerate_bridges.dart` (log: `_regen_bridges.log.txt`, success=true, 28 s) |
| Run protocol | `dart test --reporter expanded --file-reporter "json:<base>/<project>.result.json"`, all 7 projects in parallel (independent suites, no shared HTTP server) |
| Comparison | non-flutter projects only |

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

The fixes that change behaviour observable by the non-flutter
suites (interpreter `for-in`, interpreter supertype-chain lookup,
generator dynamic-Function cast) are the ones a regression would
surface in. The remaining commits are flutter-side only.

## Result totals

| Project | Total | Passed | Failed | Skipped | Errors | Wall |
|---|---:|---:|---:|---:|---:|---:|
| `tom_ast_generator` | 510 | 510 | 0 | 0 | 0 | 01:21 |
| `tom_d4rt` | 1747 | 1745 | 1 | 1 | 0 | 00:24 |
| `tom_d4rt_ast` | 117 | 117 | 0 | 0 | 0 | 00:01 |
| `tom_d4rt_dcli` | 706 | 706 | 0 | 0 | 0 | 06:20 |
| `tom_d4rt_exec` | 2260 | 2259 | 1 | 0 | 0 | 01:44 |
| `tom_d4rt_generator` | 660 | 660 | 0 | 0 | 0 | 01:24 |
| `tom_dcli_exec` | 412 | 412 | 0 | 0 | 0 | 00:17 |
| **TOTAL** | **6412** | **6409** | **2** | **1** | **0** |  |

(Wall times are per-suite; runs were parallel.)

## Delta vs `testlog_20260502-1010-consol-rebaseline`

| Project | 0502 (T/P/F/S/E) | 2238 (T/P/F/S/E) | Δ tests | Δ pass | Δ fail | Δ err |
|---|---|---|---:|---:|---:|---:|
| `tom_ast_generator` | 510/503/6/0/1 | 510/510/0/0/0 | 0 | **+7** | **−6** | **−1** |
| `tom_d4rt` | 1747/1736/9/1/1 | 1747/1745/1/1/0 | 0 | **+9** | **−8** | **−1** |
| `tom_d4rt_ast` | 117/115/0/0/2 | 117/117/0/0/0 | 0 | **+2** | 0 | **−2** |
| `tom_d4rt_dcli` | 706/704/1/0/1 | 706/706/0/0/0 | 0 | **+2** | **−1** | **−1** |
| `tom_d4rt_exec` | 2260/2234/25/0/1 | 2260/2259/1/0/0 | 0 | **+25** | **−24** | **−1** |
| `tom_d4rt_generator` | 660/652/8/0/0 | 660/660/0/0/0 | 0 | **+8** | **−8** | 0 |
| `tom_dcli_exec` | 75/72/3/0/0 | 412/412/0/0/0 | **+337** | **+340** | **−3** | 0 |
| **non-flutter total** | **6075/6016/52/1/6** | **6412/6409/2/1/0** | **+337** | **+393** | **−50** | **−6** |

## Delta vs `testlog_20260503-1221-consol-rebaseline-check`

| Project | 1221 | 2238 | Δ |
|---|---|---|---|
| `tom_ast_generator` | 510/510/0/0/0 | 510/510/0/0/0 | identical |
| `tom_d4rt` | 1747/1745/1/1/0 | 1747/1745/1/1/0 | identical |
| `tom_d4rt_ast` | 117/117/0/0/0 | 117/117/0/0/0 | identical |
| `tom_d4rt_dcli` | 706/706/0/0/0 | 706/706/0/0/0 | identical |
| `tom_d4rt_exec` | 2260/2259/1/0/0 | 2260/2259/1/0/0 | identical |
| `tom_d4rt_generator` | 660/660/0/0/0 | 660/660/0/0/0 | identical |
| `tom_dcli_exec` | 412/412/0/0/0 | 412/412/0/0/0 | identical |

**Headline:** 0 regressions vs both prior baselines. Same single
intentional `(SHOULD FAIL)` `I-BUG-14a` failure (records with
named fields, mounted in both `tom_d4rt` and `tom_d4rt_exec`
because they share `limitations_and_bugs_test.dart`).

## Failing tests

See `_failures.md`. Both failures are the same documented
won't-fix marker:

```
Open Bugs - Won't Fix (SHOULD FAIL) I-BUG-14a:
  Records with named fields. [2026-02-10 06:37] (FAIL)
  [limitations_and_bugs_test.dart]
```

The interpreter currently returns `InterpretedRecord:<(x: 10, y: 20)>`
where the test expects `Instance of '({int x, int y})'`. Tracked
as a documented limitation; not a regression.

## Captured-error sweep

Beyond the won't-fix `I-BUG-14a` failures, no log carries an
unattributed error / framework-error / runtime panel. The two
matches for `Runtime Error: Break statement outside of a loop` in
`tom_d4rt.log.txt` and `tom_d4rt_exec.log.txt` are deliberate
test-internal `print('Skipping HTTP request test: ...')` lines
emitted by an `expectError`-style fixture; the corresponding
tests pass.

## Verdict — no regressions; baseline holds

The fixes landed since `0503-1221`
(generator dynamic-Function cast, interpreter `for-in` over
bridged `Iterable`, interpreter supertype-chain lookup, plus the
allowlist + script work) leave every non-flutter component test
suite at the same headline as the `0503-1221` rebaseline-check.
The `0502 → now` improvement of −50 failures / −6 errors / +337
new tests is preserved.

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
| `error_analysis.md` | Failure / error analysis summary. |
| `<project>.result.json` | Raw `dart test` JSON file-reporter output. |
| `<project>.log.txt` | tee'd console output for human inspection. |

## How to compare a future run

```bash
cd doc/testlog_<new-id>
dart run _summarize.dart > _summary.md
dart run _failures.dart > _failures.md
diff _summary.md ../testlog_20260503-2238-post-fixes-rebaseline/_summary.md
diff _failures.md ../testlog_20260503-2238-post-fixes-rebaseline/_failures.md
```
