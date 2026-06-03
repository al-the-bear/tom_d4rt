# Flutter suites baseline — `20260518-1449-flutter-suites` — tom_d4rt_flutter_test

Per-file flutter test baseline run after the post-cluster-fixes
generator/interpreter work (commits up to `319825dc`). The 14
suites listed in the prompt were executed **serially** — never in
parallel, per the hard quest rule (concurrent `flutter test`
invocations corrupt results through the shared test-app HTTP
server).

This project mirrors `tom_d4rt_flutter_ast` test-for-test;
totals, failure identity, and skip set are identical to that
project's 1449 run (verified case-by-case from the JSON event
streams).

| Field | Value |
| --- | --- |
| Baseline ID | `20260518-1449-flutter-suites` |
| Date | 2026-05-18 (Mon) |
| Wall window | 16:20:48 CEST → 17:48:10 CEST (≈ 1 h 27 m) |
| Git revision | `319825dc` (`319825dce462a9ef8885f65f51002483c3991e0b`) |
| Branch | `main` |
| Bridges | reused from the 1428 regen (tom_d4rt_flutter_ast `.b.dart` artefacts were already current and are referenced by this project's `bridge_test_runner.b.dart`); no generator changes have landed since |
| Runner | `flutter test test/<file>.dart --file-reporter "json:doc/<base>/<file>.result.json"` |
| Tee | `<file>.log.txt` per test (stdout + stderr) |
| Driver log | `_driver.log.txt` (per-suite begin/rc/dur) |

## Result totals

| Suite | Total | Pass | Fail | Error | Skip | Wall |
|---|---:|---:|---:|---:|---:|---:|
| blocking_tests_test | 7 | 7 | 0 | 0 | 0 | 40s |
| crashing_tests_test | 6 | 6 | 0 | 0 | 0 | 18s |
| essential_classes_test | 110 | 110 | 0 | 0 | 0 | 230s |
| generator_interpreter_issues_test | 85 | 83 | 0 | 0 | 2 | 179s |
| generator_interpreter_retest_test | 60 | 55 | 0 | 0 | 5 | 109s |
| hardly_relevant_classes_1_test | 207 | 204 | 0 | 1 | 2 | 519s |
| hardly_relevant_classes_2_test | 205 | 205 | 0 | 0 | 0 | 389s |
| hardly_relevant_classes_3_test | 203 | 203 | 0 | 0 | 0 | 473s |
| hardly_relevant_classes_4_test | 229 | 229 | 0 | 0 | 0 | 469s |
| hardly_relevant_classes_5_test | 232 | 232 | 0 | 0 | 0 | 448s |
| important_classes_test | 166 | 166 | 0 | 0 | 0 | 336s |
| interactive_tests_test | 8 | 8 | 0 | 0 | 0 | 38s |
| secondary_classes_test | 656 | 655 | 0 | 0 | 1 | 1849s |
| timeout_tests_test | 53 | 53 | 0 | 0 | 0 | 123s |
| **TOTAL** | **2227** | **2216** | **0** | **1** | **10** | |

## Delta vs `testlog_20260517-0914-test_analysis`

| Metric | 0517-0914 | 1449 | Δ |
|---|---:|---:|---:|
| Total | 2227 | 2227 | 0 |
| Pass | 2150 | **2216** | **+66** |
| Fail | 62 | **0** | **−62** |
| Error | 5 | **1** | **−4** |
| Skip | 10 | 10 | 0 |

**Per-suite recovery (only suites that changed):**

| Suite | 0517 P/F/E | 1449 P/F/E | Δ Pass | Δ Fail | Δ Err |
|---|---|---|---:|---:|---:|
| essential_classes_test | 108/2/0 | 110/0/0 | +2 | −2 | 0 |
| generator_interpreter_issues_test | 81/2/0 | 83/0/0 | +2 | −2 | 0 |
| generator_interpreter_retest_test | 53/2/0 | 55/0/0 | +2 | −2 | 0 |
| hardly_relevant_classes_1_test | 196/8/1 | 204/0/1 | +8 | −8 | 0 |
| hardly_relevant_classes_2_test | 204/1/0 | 205/0/0 | +1 | −1 | 0 |
| hardly_relevant_classes_3_test | 193/9/1 | 203/0/0 | +10 | −9 | −1 |
| hardly_relevant_classes_5_test | 231/1/0 | 232/0/0 | +1 | −1 | 0 |
| important_classes_test | 153/12/1 | 166/0/0 | +13 | −12 | −1 |
| secondary_classes_test | 630/24/1 | 655/0/0 | +25 | −24 | −1 |
| timeout_tests_test | 51/1/1 | 53/0/0 | +2 | −1 | −1 |

## Verdict

**No regression — substantial improvement.** All 62 prior failures
across 10 suites and 4 of 5 prior errors are gone. The one
remaining error (`least_squares_solver_test.dart` in
`hardly_relevant_classes_1_test`) is a flaky transport timeout
present at 0517 too, not a content regression. Details in
[`error_analysis.md`](error_analysis.md).

## Skipped tests (10, unchanged from 0517)

Same identity as `tom_d4rt_flutter_ast`:

- `generator_interpreter_issues_test.dart` ×2:
  - Section 2 - Bridge Generator Issues (80) `widgets/android_view_test.dart`
  - Section 2 - Bridge Generator Issues (80) `widgets/animated_switcher_test.dart`
- `generator_interpreter_retest_test.dart` ×5:
  - `dart_ui/system_color_palette_test.dart`
  - `widgets/context_action_test.dart`
  - `widgets/default_text_editing_shortcuts_test.dart`
  - `widgets/live_text_input_status_test.dart`
  - `widgets/lock_state_test.dart`
- `hardly_relevant_classes_1_test.dart` ×2:
  - `dart_ui/image_sampler_slot_test.dart`
  - `dart_ui/isolate_name_server_test.dart`
- `secondary_classes_test.dart` ×1:
  - `widgets/individual android_view_test.dart`

## Files in this directory

| File | Content |
| --- | --- |
| `_baseline_id.txt` | Baseline ID string. |
| `_revision.txt` | Git SHA + branch. |
| `_timestamp.txt` | Wall-clock timestamp. |
| `_driver.log.txt` | Per-suite begin/rc/dur from the driver script. |
| `<file>.result.json` | Raw `dart test` JSON file-reporter output. |
| `<file>.log.txt` | tee'd console output (stdout + stderr). |
| `_summary.md` | Totals table. |
| `_failures.md` | One-line listing of failure/error tests. |
| `error_analysis.md` | Per-suite analysis with framework-noise inventory. |
| `README.md` | This file. |
