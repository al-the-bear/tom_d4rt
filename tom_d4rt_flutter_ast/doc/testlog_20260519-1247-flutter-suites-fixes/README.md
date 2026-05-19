# Flutter suites baseline — `20260519-1247-flutter-suites-fixes` — tom_d4rt_flutter_ast

Step 11 (Full re-baseline) of `testlog_20260518-1449-flutter-suites/error_analysis.md`.
Per-file flutter test baseline produced after closing Steps 3–10 of
the 1449 fix-plan. The 14 suites were executed **serially** by
`ztmp/step11/run_baseline.sh` — never in parallel, per the hard
quest rule (concurrent `flutter test` invocations in the same
package corrupt results through the shared test-app HTTP server).

| Field | Value |
| --- | --- |
| Baseline ID | `20260519-1247-flutter-suites-fixes` |
| Date | 2026-05-19 |
| Wall window | 12:47:31 CEST → 14:16:26 CEST (≈ 1 h 29 m) |
| Git revision | `c73595af` (`c73595af6ebbc36f2b8d90be6ec359481a09031d`) |
| Branch | `main` |
| Bridges | unchanged since `319825dc` (no generator changes since the 1449 baseline; bridge `.b.dart` artefacts reused as-is) |
| Runner | `flutter test test/<file>.dart --file-reporter "json:doc/<base>/<file>.result.json"` |
| Tee | `<file>.log.txt` per test (stdout + stderr) |
| Driver | `ztmp/step11/run_baseline.sh <project_dir> <baseline_id>` |
| Driver log | `_driver.log.txt` (per-suite begin/rc/dur) |

## Result totals

| Suite | Total | Pass | Fail | Error | Skip | Wall |
|---|---:|---:|---:|---:|---:|---:|
| blocking_tests_test | 5 | 5 | 0 | 0 | 0 | 51s |
| crashing_tests_test | 4 | 4 | 0 | 0 | 0 | 28s |
| essential_classes_test | 108 | 108 | 0 | 0 | 0 | 257s |
| generator_interpreter_issues_test | 83 | 81 | 0 | 0 | 2 | 189s |
| generator_interpreter_retest_test | 58 | 53 | 0 | 0 | 5 | 133s |
| hardly_relevant_classes_1_test | 205 | 203 | 0 | 0 | 2 | 622s |
| hardly_relevant_classes_2_test | 203 | 203 | 0 | 0 | 0 | 420s |
| hardly_relevant_classes_3_test | 201 | 201 | 0 | 0 | 0 | 457s |
| hardly_relevant_classes_4_test | 227 | 227 | 0 | 0 | 0 | 441s |
| hardly_relevant_classes_5_test | 230 | 230 | 0 | 0 | 0 | 441s |
| important_classes_test | 164 | 164 | 0 | 0 | 0 | 409s |
| interactive_tests_test | 6 | 6 | 0 | 0 | 0 | 49s |
| secondary_classes_test | 654 | 653 | 0 | 0 | 1 | 1725s |
| timeout_tests_test | 51 | 51 | 0 | 0 | 0 | 113s |
| **TOTAL** | **2199** | **2189** | **0** | **0** | **10** | |

## Delta vs `testlog_20260518-1449-flutter-suites`

The 1449 baseline counted the same suites via the same JSON reporter.
The 2227/2216 figures in the 1449 README were measured by a different
roll-up that included some non-test entries; re-tallying its
`*.result.json` files with the same script used here gives the
apples-to-apples comparable: **total=2199 pass=2188 error=1 skip=10**.

| Metric | 1449 (re-tally) | 1247-fixes | Δ |
|---|---:|---:|---:|
| Total | 2199 | 2199 | 0 |
| Pass | 2188 | **2189** | **+1** |
| Fail | 0 | 0 | 0 |
| Error | 1 | **0** | **−1** |
| Skip | 10 | 10 | 0 |

The −1 error / +1 pass is `gestures/least_squares_solver_test.dart`
in `hardly_relevant_classes_1_test`, closed by Step 9's A+B hybrid
(60 s dart-test wrapper + 50 s `httpBuildTimeout` for that single
script — see Step 9 in
`testlog_20260518-1449-flutter-suites/error_analysis.md`).

## Framework-error banner reduction

Steps 5, 6, 7, 8 of the 1449 fix-plan filtered out non-test framework
debug-print banners from script logs. Total banners across all 14
suite logs:

| Snapshot | Banners |
|---|---:|
| 1449 baseline | 161 |
| 1247-fixes | **139** |
| Δ | **−22** |

The remaining 139 banners are predominantly the
`BorderRadius`-of-non-uniform-Border bridge defect (B-bridge) and
under-constrained-layout `BoxConstraints` / `RenderFlex` debug
prints (B-layout). Steps 6 and 8 of the 1449 fix-plan were closed
partial — the *layout* and *unhandled* shapes remain documented but
not fixed because they are non-blocking and would require
significant test-script edits (or a redesigned `SendTestRunner`
banner filter). The original Step-11 DoD line *"Banner counts in
the noise inventory drop to 0 across every column"* was aspirational
and is not met.

## Verdict

**No regression — clean green.** All 14 suites returned rc=0;
zero failures, zero errors, identical skip set vs the 1449
baseline. The previously-pending `least_squares_solver` flake is
now stable. The full-banner-zero stretch goal is not met (139
remain, down from 161); the failures/errors=0 acceptance criterion
**is** met.

## Skipped tests (10, unchanged from 1449)

See `_failures.md` for the full list — same set of `skip: true`
entries.

## Files in this directory

| File | Content |
| --- | --- |
| `_baseline_id.txt` | Baseline ID string. |
| `_revision.txt` | Git SHA + branch. |
| `_timestamp.txt` | Wall-clock timestamp at run start. |
| `_driver.log.txt` | Per-suite begin/rc/dur from `run_baseline.sh`. |
| `<file>.result.json` | Raw `dart test` JSON file-reporter output. |
| `<file>.log.txt` | tee'd console output (stdout + stderr). |
| `_summary.md` | Totals table. |
| `_failures.md` | Failures / errors / skipped tests. |
| `README.md` | This file. |
