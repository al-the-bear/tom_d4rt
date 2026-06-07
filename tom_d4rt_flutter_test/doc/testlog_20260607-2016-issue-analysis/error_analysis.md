# Issue Analysis — tom_d4rt_flutter_test

| Field | Value |
|-------|-------|
| Run ID | `20260607-2016-issue-analysis` |
| Git rev | `852f04750` — *docs(d4rt_generator): worked-samples catalog + drift guard* |
| Started | 2026-06-08 00:26:48 |
| Finished | 2026-06-08 00:39:48 |
| Wall clock | ~13m |
| Command | `flutter test test/<file>.dart --file-reporter json:<file>.result.json` |

## Headline result — clean

| Outcome | Count |
|---------|------:|
| Passed | 182 |
| Skipped | 0 |
| **Failed** | **0** |
| Files run | 2 |

**No failures, no runtime errors, no captured framework errors.** Per the
request, this section is a test-result summary rather than a failure analysis.

## Per-file result

| File | Result | Notes |
|------|--------|-------|
| `asset_sample_source_test` | `+2` all pass | Asset manifest lists the bundled samples; `loadProgram` pre-resolves relative imports into the source map. |
| `sample_apps_in_tester_test` | `+180` all pass | In-process `WidgetTester` runs the multi-file sample apps via `SourceFlutterD4rt.buildMultiFile` (calculator, clock_face, counter_app, stopwatch_laps, tip_calculator). |

## Why this project is clean (vs. tom_d4rt_flutter_ast)

This project does **not** carry the 13-file flutter-material corpus. The driver
attempted all 14 corpus filenames and **skipped every one** (no such file here),
then ran the 2 files that actually exist.

The two real files use the **in-process** `SourceFlutterD4rt.buildMultiFile`
path inside `WidgetTester` — there is **no shared long-lived HTTP companion
app**. The 30s-build-hang / 5s-`GET /clear` transport cascade that produced all
208 failures in `tom_d4rt_flutter_ast` is structurally impossible here, which is
exactly why this twin is green.

## Framework / runtime error scan

| Signature | Count |
|-----------|------:|
| `RenderFlex` / `overflowed` | 0 |
| `EXCEPTION CAUGHT BY …` | 0 |
| `TimeoutException` | 0 |
| `Bad state: Transport failure` | 0 |
| `[framework error]` | 0 |
| `capturedFrameworkErrors` > 0 | 0 |

## Conclusion

`tom_d4rt_flutter_test`: **182/182 passed, fully clean.** All interpreter
infrastructure exercised through the in-process multi-file sample runner works;
no timeouts, no framework errors, no overflows. The actionable findings from this
run are entirely in `tom_d4rt_flutter_ast` (see that folder's `error_analysis.md`).
