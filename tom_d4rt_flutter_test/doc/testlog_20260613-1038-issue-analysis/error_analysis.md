# Issue Analysis — tom_d4rt_flutter_test

| Field | Value |
| --- | --- |
| **Analysis ID** | `20260613-1038-issue-analysis` |
| **Project** | `tom_d4rt_flutter_test` (source-direct twin — in-process `SourceFlutterD4rt.buildMultiFile`) |
| **Git revision** | `7de9b893a` (tom_d4rt repo) |
| **Run date/time** | 2026-06-13 10:38 CEST |
| **Runner** | `test/run_issue_analysis_tests.sh` (file-by-file, strictly serial) |
| **Logs** | `doc/testlog_20260613-1038-issue-analysis/<base>.log.txt` + `.result.json` |
| **Metrics** | `doc/testlog_20260613-1038-issue-analysis/metrics.txt` |
| **Sibling run** | `tom_d4rt_flutter_ast` — same ID, see its `error_analysis.md` for the corpus failures |

## Result summary — CLEAN

| Metric | Value |
| --- | --- |
| Test files run | 2 |
| Tests passed | **185** |
| Tests skipped | 0 |
| Tests failed | **0** |
| Non-fatal framework errors | **0** |
| Runtime / overflow / framework exceptions in logs | **none** (searched both logs) |

## File-by-file

| File | +pass / ~skip / −fail | Notes |
| --- | --- | --- |
| asset_sample_source_test | +2 | clean |
| sample_apps_in_tester_test | +183 | clean — includes the rewritten `conway_life_optimized` (sparse int-keyed) sample and the `particle_field_optimized` sample, all green |

## Notes

- No failures, runtime errors, framework errors, or layout-overflow warnings were
  emitted by either file. The captured script trails show the interpreted samples
  (`life.init` / `life.step`, `field.init` / `field.mode`) running as expected.
- This project runs its samples in-process via `WidgetTester` (no long-lived HTTP
  companion app), so it is not subject to the companion-app wedge / build-timeout
  failure mode seen in the `tom_d4rt_flutter_ast` corpus (class A there).
