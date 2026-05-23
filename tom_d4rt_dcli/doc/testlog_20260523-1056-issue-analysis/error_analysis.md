# tom_d4rt_dcli — Test Run Issue Analysis — 20260523-1056-issue-analysis

**Run ID:** `20260523-1056-issue-analysis`
**Revision:** `ee10ed726300cf119ac76d3b730979251470293c (main)`
**Date:** 2026-05-23 10:59 (started) — 369 s wall, rc=1
**Host:** macOS (Darwin)

## Result summary

| metric | value | Δ vs 20260522-1328 baseline |
|---|---:|---:|
| tests   | 706 | −13 |
| passed  | 692 | −12 |
| failed  |  13 | +12 |
| errored |   1 |   0 |
| skipped |   0 |   0 |

## All 14 failures are macOS-known upstream DCli bugs

The 13 failures + 1 error all carry the `[fails on Macos]` suffix in their
test description. Root cause is documented in
`doc/known_issues_macos.md`: DCli 8.4.2's `_whoami()` returns `"root"`
instead of the actual user when invoked under the macOS Dart VM (no
controlling terminal → `getlogin()` throws `ENXIO` → DCli incorrectly
defaults to `'root'`). Every permission check that compares
`Shell.current.loggedInUser` against the file owner therefore returns
false.

The 20260522-1328 baseline executed on Linux and did not surface these
entries; they are not new regressions in this codebase.

| # | test | failure |
|---|---|---|
| F8  | `find case-insensitive matching when specified [fails on Macos]` | upstream DCli |
| F9  | `isWritable returns true for writable file [fails on Macos]` | upstream DCli |
| F10 | `isWritable returns true for writable directory [fails on Macos]` | upstream DCli |
| F11 | `isWritable can write to writable file [fails on Macos]` | upstream DCli |
| F12 | `chmod via shell makes file writable [fails on Macos]` | upstream DCli |
| F13 | `chmod via shell handles directory permissions [fails on Macos]` | upstream DCli |
| F14 | `permission modes mode 644 - rw-r--r-- [fails on Macos]` | upstream DCli |
| F15 | `permission modes mode 755 - rwxr-xr-x [fails on Macos]` | upstream DCli |
| F16 | `permission modes mode 600 - rw------- [fails on Macos]` | upstream DCli |
| F17 | `permission modes mode 700 - rwx------ [fails on Macos]` | upstream DCli |
| F18 | `special permissions hidden files are accessible [fails on Macos]` | upstream DCli |
| F19 | `special permissions symlink permissions follow target [fails on Macos]` | upstream DCli |
| F20 | `real-world scenarios create config file with restricted permissions [fails on Macos]` | upstream DCli |
| E44 | `real-world scenarios check before writing [fails on Macos]` | `Bad state: No element` (same root cause) |

**Action:** Optional — gate the 14 tests with `@TestOn('!mac-os')` so they
don't surface as failures on macOS hosts. Otherwise leave as-is; the
`doc/known_issues_macos.md` documentation is sufficient.

## Δ — Cluster L (VS Code Scripting API) cleared

The 20260522-1328 baseline tracked 2 dcli failures
(`VSCodeWindow.getActiveTextEditor returns editor info` and `Live Bridge
Commands: script can get active editor through bridge`). They do not
appear in this run — either the gating in Cluster L was applied or the
headless test environment on macOS no longer triggers them.

## Cross-project linkage

The cross-project narrative lives at:
`../../tom_d4rt_flutter_ast/doc/testlog_20260523-1056-issue-analysis/error_analysis.md`
