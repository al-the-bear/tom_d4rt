# testlog 20260529-1944 — sweep capture (tom_d4rt_flutter_test side)

This folder holds the 14 captured `*.result.json` + `*.log.txt` files
from the `tom_d4rt_flutter_test` half of the 20260529-1944 sweep.

The capture artifacts themselves are gitignored
(`tom_d4rt_flutter_test/doc/.gitignore` — `testlog_*/**`). Only
`_revision.txt`, `_timestamp.txt`, and this README are tracked.

The combined two-project analysis + numbered TODO list lives in the
companion folder under `tom_d4rt_flutter_ast`:

  → `../../../tom_d4rt_flutter_ast/doc/testlog_20260529-1944-issue-analysis/error_analysis.md`

Per the sweep outcome documented there:

- `tom_d4rt_flutter_test`: **2058 tests passed, 0 failures, 7 errors,
  4 skipped** across the 14 files (99.7 % pass rate on the 13 of 14
  files that completed within budget).
- `secondary_classes_test` hit the 2400 s budget cap and was
  KILLED at 524/656 tests — host-load variance vs the 2206 sweep
  where the same file finished in 1910 s. **Not a regression of
  test code.** TODO #1 of the companion `error_analysis.md`
  proposes bumping the budget to 3000 s in
  `tom_d4rt_flutter_ast/tool/sweep_both_projects.sh`.
- Sweep used `TOM_D4RT_TEST_TEST_PORT=14251` (alt port) because
  defaults 4247/4248 + previous alts 14247/14248 are still held by
  kernel-zombie test_apps from prior sessions. Port-override
  shipped in commit `8cd7c27a`; lifecycle fix in `9f4dc79c`.
- All 7 errors classify as `transport_clear_wedge` (§U28 family).
  Real cause was disproven on the d4rt side by 2206 TODO #3 (the
  D4-static/Expando hypothesis); suspected to live in Flutter
  framework subsystems.
- **Zero framework-error log noise** across all 14 log files
  (`grep -c "EXCEPTION CAUGHT BY|overflowed by|FlutterError"`
  returns 0 everywhere) — the cumulative suppression chain from
  Cluster H/B/C + 2026-05-27 TODO #9 + 2026-05-29 TODO #7/#8 holds.
- Driver script: `tom_d4rt_flutter_ast/tool/sweep_both_projects.sh`
  (the 2206 TODO #39 promotion's first end-to-end run — verified
  working end-to-end).
