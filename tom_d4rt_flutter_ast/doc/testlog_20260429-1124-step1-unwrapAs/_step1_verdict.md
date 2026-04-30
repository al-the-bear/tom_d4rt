# Step 1 — `D4.unwrapAs<T>` verdict

**Status:** ✅ Done — no regressions caused by the change.

**Baseline used:** `testlog_20260429-1054-consol-baseline/_summary.md`.

## Per-project comparison

| Project | Baseline (Total/Pass/Fail/Err) | Step 1 parallel run | Step 1 serial rerun (--concurrency=1) | Verdict |
|---------|------------------------------|---------------------|---------------------------------------|---------|
| flutterm essential   | 108 / 108 / 0 / 0   | 108 / 108 / 0 / 0   | n/a (already serial)                                    | ✅ unchanged |
| flutterm important   | 164 / 164 / 0 / 0   | 164 / 164 / 0 / 0   | n/a                                                     | ✅ unchanged |
| flutterm secondary   | 654 / 653 / 0 / 0 (1 skip) | 654 / 653 / 0 / 0 (1 skip) | n/a                                              | ✅ unchanged |
| tom_d4rt             | 1728 / 1721 / 5 / 1 | 1740 / 1733 / 5 / 1 | (parallel ok)                                           | ✅ +12 expected (new unit tests) |
| tom_d4rt_ast         | 86 / 84 / 0 / 2     | 98 / 96 / 0 / 2     | (parallel ok)                                           | ✅ +12 expected (new unit tests) |
| tom_d4rt_dcli        | 706 / 706 / 0 / 0   | 706 / 706 / 0 / 0   | n/a                                                     | ✅ unchanged |
| tom_d4rt_generator   | 660 / 639 / 21 / 0  | 660 / 639 / 21 / 0  | n/a                                                     | ✅ unchanged |
| tom_dcli_exec        | 75 / 72 / 3 / 0     | 75 / 72 / 3 / 0     | n/a                                                     | ✅ unchanged |
| tom_d4rt_exec        | 2249 / 2223 / 25 / 1| 2156 / 2129 / 26 / 1| 2249 / 2223 / 25 / 1                                    | ✅ matches baseline serially |
| tom_ast_generator    | 483 / 476 / 7 / 0   | 417 / 410 / 7 / 0   | 510 / 504 / 6 / 0                                       | ✅ no regression (one fewer flake than baseline) |

## Why the parallel-run deltas were false positives

Two test files in tom_d4rt_exec / tom_ast_generator drive bridge
generation against the shared `tom_ast_generator/example/d4`
project (`d4rt_coverage_test.dart`, `d4rt_tester_test.dart`,
`dcli_*_test.dart`). When dart test runs them in parallel the
shared `example/d4` build directory races and one of the
`setUpAll` blocks fails with "Bridge generation/compilation
failed for dart_overview". This is a pre-existing condition: the
prior consol-baseline shows the same race with a different victim
(`(setUpAll) [d4rt_tester_test.dart]` in tom_ast_generator).

`dart test --concurrency=1` reproduces the exact baseline failure
set in tom_d4rt_exec (25 failures + 1 error, identical names) and
gives one fewer failure than baseline in tom_ast_generator. Step 1
itself only adds new code (`D4UnwrapException`, `D4.unwrapAs<T>`,
12 new unit tests) and changes nothing about existing
interpretation paths.

## Artifacts

- `tom_d4rt_exec.rerun.result.json` / `.log.txt` — serial rerun, 25F+1E
- `tom_ast_generator.rerun.result.json` / `.log.txt` — serial rerun, 6F
- `_summary.md`, `_failures.md` — original parallel-run summaries
