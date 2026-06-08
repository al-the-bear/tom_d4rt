# Issue Analysis — tom_d4rt_flutter_test

| Field | Value |
|-------|-------|
| Run ID | `20260608-1153-issue-analysis` |
| Git rev | `f20bd42e0` |
| Started | 2026-06-08 11:53:52 |
| Finished | 2026-06-08 12:08:05 (~14m) |
| Runner | `test/run_issue_analysis_tests.sh <ID>` — idle watchdog 70s, `--timeout 60s` per-test, 900s file backstop, JSON file-reporter |

> Scope: this run covered **tom_d4rt_flutter_test only** (per the request
> headline). The AST twin was not re-run; its latest analysis is in
> `tom_d4rt_flutter_ast/doc/testlog_20260608-0746-issue-analysis/error_analysis.md`.

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

| File | Result | Wall | Pass / Fail / Skip | Notes |
|------|--------|-----:|--------------------|-------|
| `asset_sample_source_test` | `+2` all pass | 00:00 | 2 / 0 / 0 | Asset manifest lists the bundled samples; `loadProgram` pre-resolves relative imports into the source map. |
| `sample_apps_in_tester_test` | `+180` all pass | 13:52 | 180 / 0 / 0 | In-process `WidgetTester` runs the multi-file sample apps via `SourceFlutterD4rt.buildMultiFile` (calculator, clock_face, counter_app, stopwatch_laps, tip_calculator, sudoku_app). |

## Framework / runtime error scan (both logs)

The "test-internal problems like overflow errors" category — captured output that
may not surface as a test failure:

| Signature | Count |
|-----------|------:|
| `RenderFlex` / `overflowed` | 0 |
| `EXCEPTION CAUGHT BY …` | 0 |
| `TimeoutException` | 0 |
| `Bad state: Transport failure` | 0 |
| `Build timed out` | 0 |
| `[framework error]` | 0 |
| `capturedFrameworkErrors=[1-9]` | 0 |
| captured `Exception` / `Error:` lines | 0 |

**Clean.** No RenderFlex/overflow, no uncaught framework exceptions, no captured
build-time framework errors.

## Conclusion

`tom_d4rt_flutter_test`: **182/182 passed, fully clean** (~14m). All sample apps
build and run through the in-process `SourceFlutterD4rt.buildMultiFile` path with
no timeouts, no framework errors, and no overflows. There is no shared HTTP
companion app and no 45s build ceiling here, so the build-latency timeouts that
affect the `tom_d4rt_flutter_ast` corpus are structurally absent. Nothing
actionable in this run.
