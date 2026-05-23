# tom_d4rt — Test Run Issue Analysis — 20260523-1056-issue-analysis

**Run ID:** `20260523-1056-issue-analysis`
**Revision:** `ee10ed726300cf119ac76d3b730979251470293c (main)`
**Date:** 2026-05-23 10:59 (started) — 30 s run wall, rc=1 (one
intentional SHOULD FAIL)

## Result summary

| metric | value | Δ vs 20260522-1328 baseline |
|---|---:|---:|
| tests   | 1788 | +37 |
| passed  | 1786 | +37 |
| failed  |    1 |   0 |
| errored |    0 |  −7 |
| skipped |    1 |   0 |

## Single failure (intentional)

| # | name | error | classification |
|---|---|---|---|
| F7 | `Open Bugs - Won't Fix (SHOULD FAIL) I-BUG-14a: Records with named fields. [2026-02-10 06:37] (FAIL)` | `Expected: <Instance of '({int x, int y})'>` | Intentional `SHOULD FAIL` marker — **no fix required**. |

## Single skip

| # | name | reason |
|---|---|---|
| K10 | `BridgedInstance Unwrapping with Type Promotion D4-WRAP-01: extractBridgedArg unwraps BridgedInstance<int> to double.` | *Needs BridgedInstance mock for proper testing* — test-infra; keep skipped. |

## Notable Δ — Cluster J (bridged-mixin) cleared

The 7 `I-BRIDGE-1/-4/-11/-12/-13/-14/-15` errors that the 20260522-1328
baseline tracked under **Cluster J — Bridged-mixin resolution** are all
gone. The fix landed between the two runs.

## Cross-project linkage

This file is a project-local snapshot; the cross-project narrative
(flutter projects, dcli macOS issues, generator, exec, ast) lives at:
`../../tom_d4rt_flutter_ast/doc/testlog_20260523-1056-issue-analysis/error_analysis.md`
