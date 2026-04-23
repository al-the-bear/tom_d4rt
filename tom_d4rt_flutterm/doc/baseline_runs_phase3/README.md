# Phase 3 Baseline Runs

Per-suite JSON test-reporter output captured on 2026-04-23 against the
Phase 2 element-mode walker.

| Suite | Passed | Failed | Skipped | Phase 0 baseline | Parity |
|-------|--------|--------|---------|------------------|--------|
| essential | 111 | 0 | 0 | 111 / 0 / 0 | ✅ |
| important | 166 | 1 (`services/ codecs_test.dart`) | 5 | 166 / 1 (same) / 5 | ✅ |
| secondary | 616 | 1 (`widgets/ gesture_detector_adv_test.dart`) | 40 | 616 / 1 (same) / 40 | ✅ |

**Phase 3 exit criterion met:** all three flutterm gating suites produce
a result column matching the Phase 0 baseline — same tests passing,
same tests failing, zero new regressions. The two pre-existing
failures in important/secondary are unchanged.

See `doc/baseline_runs/` for the Phase 0 baselines this is compared
against.

## Reproduction

```bash
cd tom_ai/d4rt/tom_d4rt_flutterm
flutter test test/essential_classes_test.dart --reporter json > doc/baseline_runs_phase3/essential.json
flutter test test/important_classes_test.dart --reporter json > doc/baseline_runs_phase3/important.json
flutter test test/secondary_classes_test.dart --reporter json > doc/baseline_runs_phase3/secondary.json
dart run ztmp/parse_results.dart doc/baseline_runs_phase3/essential.json
dart run ztmp/parse_results.dart doc/baseline_runs_phase3/important.json
dart run ztmp/parse_results.dart doc/baseline_runs_phase3/secondary.json
```
