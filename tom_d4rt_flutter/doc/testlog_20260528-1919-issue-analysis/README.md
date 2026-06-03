# testlog 20260528-1919 — sweep capture (tom_d4rt_flutter_test side)

This folder holds the 14 captured `*.result.json` + `*.log.txt` files
from the `tom_d4rt_flutter_test` half of the 20260528-1919 sweep.

The capture artifacts themselves are gitignored
(`tom_d4rt_flutter_test/doc/.gitignore` — `testlog_*/**`). Only
`_revision.txt` and `_timestamp.txt` are tracked here.

The combined two-project analysis + numbered TODO list lives in the
companion folder under `tom_d4rt_flutter_ast`:

  → `../../../tom_d4rt_flutter_ast/doc/testlog_20260528-1919-issue-analysis/error_analysis.md`

Per the sweep outcome documented there:

- `tom_d4rt_flutter_test`: **1063 tests passed, 2 failures, 35 errors,
  3 skipped** across the 14 files.
- Sweep used `TOM_D4RT_TEST_TEST_PORT=14248` (alt port) because the
  default 4248 was held by a kernel-zombie test_app from a prior
  session. Port-override shipped in commit `8cd7c27a`.
- All errors / failures fall in one of four U28-wedge-family classes:
  `transport_clear_wedge`, `transport_build_wedge`, `test_30s_timeout`,
  `build_30s_timeout`. Zero regressions attributable to the §U28 deep
  fix (commits `42588be2` / `d613142e` / `90854bc9`).
- 10 of 14 files hit the 600 s per-file budget cap and were killed
  mid-suite. A follow-up sweep with bumped budgets is item #2/#3 in
  the TODO list.
