# Phase 5 Baseline Runs

Per-suite JSON test-reporter output captured on 2026-04-23 after the
Phase 5 migration of `UserBridgeScanner` from an AST `RecursiveAstVisitor`
to a `LibraryElement` walker (see
`tom_d4rt_generator/doc/summary_refactoring_plan.md`).

| Suite | Passed | Failed | Skipped | Phase 0 baseline | Parity |
|-------|--------|--------|---------|------------------|--------|
| essential | 111 | 0 | 0 | 111 / 0 / 0 | ✅ |
| important | 166 | 1 (`services/ codecs_test.dart`) | 5 | 166 / 1 (same) / 5 | ✅ |
| secondary | 616 | 1 (`widgets/ gesture_detector_adv_test.dart`) | 40 | 616 / 1 (same) / 40 | ✅ |

**Phase 5 exit criterion met:** user-bridge overrides continue to
round-trip through generation, and all three flutterm gating suites
produce a result column matching the Phase 0 baseline — same tests
passing, same tests failing, zero new regressions. The two pre-existing
failures in important/secondary are unchanged from Phase 0 through
Phase 5.

Regeneration log confirms the user-bridge pre-scan:

```text
USER-BRIDGE: pre-scanned 2 class user bridges and 0 globals user bridges
    from /srv/repos/.../tom_d4rt_flutterm
```

Generated bridge files are byte-identical to the Phase 4 output except
for the top-of-file `Generated: <timestamp>` comment.

See `doc/baseline_runs/` for the Phase 0 baselines this is compared
against and `doc/baseline_runs_phase4/` for the preceding Phase 4
baselines.

## Reproduction

```bash
cd tom_ai/d4rt/tom_d4rt_flutterm
flutter test test/essential_classes_test.dart --reporter json > doc/baseline_runs_phase5/essential.json
flutter test test/important_classes_test.dart --reporter json > doc/baseline_runs_phase5/important.json
flutter test test/secondary_classes_test.dart --reporter json > doc/baseline_runs_phase5/secondary.json
dart run ztmp/parse_results.dart doc/baseline_runs_phase5/essential.json
dart run ztmp/parse_results.dart doc/baseline_runs_phase5/important.json
dart run ztmp/parse_results.dart doc/baseline_runs_phase5/secondary.json
```
