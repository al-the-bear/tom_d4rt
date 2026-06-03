# testlog 20260528-1404 — sweep capture (tom_d4rt_flutter_test side)

This folder holds the 14 captured `*.result.json` + `*.log.txt` files
from the `tom_d4rt_flutter_test` half of the 20260528-1404 sweep.

The capture artifacts themselves are gitignored
(`tom_d4rt_flutter_test/doc/.gitignore` `testlog_*/**`). Only
`_revision.txt` and `_timestamp.txt` are tracked.

The combined two-project analysis + numbered TODO list lives in the
companion folder under `tom_d4rt_flutter_ast`:

  → `../../../tom_d4rt_flutter_ast/doc/testlog_20260528-1404-issue-analysis/error_analysis.md`

Per the sweep outcome documented there, every one of the 14 ×
2 = 28 invocations hit the kernel-zombie wedge at `setUpAll`. Zero
tests executed. The combined analysis covers both projects.
