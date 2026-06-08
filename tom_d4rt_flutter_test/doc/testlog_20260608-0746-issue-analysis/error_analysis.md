# Issue Analysis — tom_d4rt_flutter_test

| Field | Value |
|-------|-------|
| Run ID | `20260608-0746-issue-analysis` |
| Git rev | `7a78f4293` |
| Started | 2026-06-08 10:48:50 |
| Finished | 2026-06-08 11:03:53 (~15m) |
| Runner | `test/run_issue_analysis_tests.sh <ID>` (added this run — mirror of the AST sibling) |

## Headline result — clean

| Outcome | Count |
|---------|------:|
| Passed | 182 |
| Skipped | 0 |
| **Failed** | **0** |
| Files run | 2 |

**No failures, no runtime errors, no captured framework errors.** Per the
request, this is a test-result summary rather than a failure analysis.

## Per-file result

| File | Result | Wall | Notes |
|------|--------|-----:|-------|
| `asset_sample_source_test` | `+2` all pass | 00:00 | Asset manifest lists the bundled samples; `loadProgram` pre-resolves relative imports into the source map. |
| `sample_apps_in_tester_test` | `+180` all pass | 14:40 | In-process `WidgetTester` runs the multi-file sample apps via `SourceFlutterD4rt.buildMultiFile` (calculator, clock_face, counter_app, stopwatch_laps, tip_calculator). |

## Framework / runtime error scan (both logs)

| Signature | Count |
|-----------|------:|
| `RenderFlex` / `overflowed` | 0 |
| `EXCEPTION CAUGHT BY …` | 0 |
| `TimeoutException` | 0 |
| `Bad state: Transport failure` | 0 |
| `[framework error]` | 0 |
| `Build timed out` | 0 |

## Why this twin is clean (vs. tom_d4rt_flutter_ast)

This project carries **no flutter-material corpus** — only the two in-process
sample/asset tests. They use `SourceFlutterD4rt.buildMultiFile` inside
`WidgetTester`, with **no shared long-lived HTTP companion app** and **no 45s
build ceiling**. The build-latency timeouts that produced all 138 AST failures
are structurally absent here, which is why this twin is fully green.

> Runner note: `tom_d4rt_flutter_test` had no issue-analysis runner before this
> run. An equivalent `run_issue_analysis_tests.sh` + `idle_timeout.sh` was added
> (mirroring the AST sibling, with `FILES` holding just the two real tests) so the
> same `doc/testlog_<ID>/` output contract is produced for both twins.

## Conclusion

`tom_d4rt_flutter_test`: **182/182 passed, fully clean.** No timeouts, no
framework errors, no overflows. All actionable findings for this run are in
`tom_d4rt_flutter_ast`'s `error_analysis.md` (138 × 45s build-timeout + 1
transport failure, all latency — no correctness defects).
