# Phase 6 Baseline Runs

Per-suite JSON test-reporter output captured on 2026-04-23 after the
Phase 6 deletion of the AST extraction path from `bridge_generator.dart`
(see `tom_d4rt_generator/doc/summary_refactoring_plan.md`).

| Suite | Passed | Failed | Skipped | Phase 0 baseline | Parity |
|-------|--------|--------|---------|------------------|--------|
| essential | 111 | 0 | 0 | 111 / 0 / 0 | OK |
| important | 166 | 1 (`services/ codecs_test.dart`) | 5 | 166 / 1 (same) / 5 | OK |
| secondary | 616 | 1 (`widgets/ gesture_detector_adv_test.dart`) | 40 | 616 / 1 (same) / 40 | OK |

**Phase 6 exit criterion met:** the AST extraction path and
`summary_exclusion.dart` are gone, and all three flutterm gating suites
produce a result column matching the Phase 0 baseline — same tests
passing, same tests failing, zero new regressions. The two pre-existing
failures in important/secondary are unchanged from Phase 0 through
Phase 6.

Generated bridge files are byte-identical to the Phase 5 output except
for the top-of-file `Generated: <timestamp>` comment across all 14
bridge files (`dart_ui_bridges.b.dart`, `painting_bridges.b.dart`,
`foundation_bridges.b.dart`, `animation_bridges.b.dart`,
`physics_bridges.b.dart`, `scheduler_bridges.b.dart`,
`semantics_bridges.b.dart`, `services_bridges.b.dart`,
`gestures_bridges.b.dart`, `rendering_bridges.b.dart`,
`widgets_bridges.b.dart`, `material_widgets_bridges.b.dart`,
`cupertino_bridges.b.dart`, `material_bridges.b.dart`) plus the
barrel, proxies, and relaxers.

`bridge_generator.dart`: 16,678 (Phase 5) → 13,602 lines (Phase 6) — a
3,076-line drop versus the plan's ≥1,800-line target.

See `doc/baseline_runs_phase5/` for the preceding Phase 5 baselines and
`doc/baseline_runs/` for the original Phase 0 baselines this is
compared against.

## Reproduction

```bash
cd tom_ai/d4rt/tom_d4rt_flutterm
flutter test test/essential_classes_test.dart --reporter json > doc/baseline_runs_phase6/essential.json
flutter test test/important_classes_test.dart --reporter json > doc/baseline_runs_phase6/important.json
flutter test test/secondary_classes_test.dart --reporter json > doc/baseline_runs_phase6/secondary.json
dart run ztmp/parse_results.dart doc/baseline_runs_phase6/essential.json
dart run ztmp/parse_results.dart doc/baseline_runs_phase6/important.json
dart run ztmp/parse_results.dart doc/baseline_runs_phase6/secondary.json
```
