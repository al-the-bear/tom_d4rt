# tom_d4rt_exec — Test Run Issue Analysis — 20260523-1056-issue-analysis

**Run ID:** `20260523-1056-issue-analysis`
**Revision:** `ee10ed726300cf119ac76d3b730979251470293c (main)`
**Date:** 2026-05-23 10:59 (started) — 120 s wall, rc=1 (one
intentional SHOULD FAIL)

## Result summary

| metric | value | Δ vs 20260522-1328 baseline |
|---|---:|---:|
| tests   | 2293 | +35 |
| passed  | 2292 | +35 |
| failed  |    1 |   0 |
| errored |    0 |  −8 |
| skipped |    0 |   0 |

## Single failure (intentional)

| # | name | error | classification |
|---|---|---|---|
| F7 (shared with tom_d4rt) | `Open Bugs - Won't Fix (SHOULD FAIL) I-BUG-14a: Records with named fields. [2026-02-10 06:37] (FAIL)` | `Expected: <Instance of '({int x, int y})'>` | Intentional `SHOULD FAIL` marker — **no fix required**. |

## Notable Δ — Clusters J + K cleared

- **Cluster J (Bridged-mixin)** — same 7 `I-BRIDGE-*` entries that
  cleared in `tom_d4rt`, shared fixture.
- **Cluster K (d4 binary "Text file busy")** — the `G-TST-9: UBR01 user
  bridge class (basic)` end-to-end `d4` binary execution test that the
  20260522-1328 baseline tracked is now passing.

## Cross-project linkage

The cross-project narrative lives at:
`../../tom_d4rt_flutter_ast/doc/testlog_20260523-1056-issue-analysis/error_analysis.md`
