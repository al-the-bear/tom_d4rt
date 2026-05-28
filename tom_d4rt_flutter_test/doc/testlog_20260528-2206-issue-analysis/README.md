# testlog 20260528-2206 — sweep capture (tom_d4rt_flutter_test side)

This folder holds the 14 captured `*.result.json` + `*.log.txt` files
from the `tom_d4rt_flutter_test` half of the 20260528-2206 sweep.

The capture artifacts themselves are gitignored
(`tom_d4rt_flutter_test/doc/.gitignore` — `testlog_*/**`). Only
`_revision.txt`, `_timestamp.txt`, and this README are tracked.

The combined two-project analysis + numbered TODO list lives in the
companion folder under `tom_d4rt_flutter_ast`:

  → `../../../tom_d4rt_flutter_ast/doc/testlog_20260528-2206-issue-analysis/error_analysis.md`

Per the sweep outcome documented there:

- `tom_d4rt_flutter_test`: **2125 tests passed, 0 failures, 59 errors,
  4 skipped** across the 14 files (97.3 % pass rate).
- Sweep used `TOM_D4RT_TEST_TEST_PORT=14251` (alt port) because the
  default 4248 + previous alt 14248 were held by kernel-zombie
  test_apps from prior sessions. Port-override shipped in commit
  `8cd7c27a`; lifecycle fix in `9f4dc79c`.
- All 59 errors classify as `transport_clear_wedge` (23) or
  `test_30s_timeout` (36) — both known U28-wedge-family causes.
- 13 of 14 files completed within budget; only `important_classes_test`
  hit the 300 s cap and was killed after 120 passes (needs 600 s+).
- 2 known framework-error patterns surfaced in logs: §U17
  (ConstraintsTransformBox overflow, intentional script demo) and §U29
  (MemoryImage codec failure, bridge ↔ ui.ImmutableBuffer gap).
