## 1.3.0

### Fixed — the `--version` banner reports the real version (sce9)

`lib/src/version.versioner.dart` said 1.2.2 while the pubspec said 1.3.0, so
`dclie --version` named a release that is not what was running. The stamp is
regenerated and `version_stamp_test` passes; published so the correction
reaches the package people install rather than only this tree.


### Changed — eight stale bridge files regenerated at generator 1.26.2 (sce1)

This package was recorded FRESH in the 2026-09-11 bridge survey and was not.
Its own `bridges_fresh_test.dart` reported eight stale files — every bridge
module, the relaxers, the dartscript and the test runner — two of them outside
`lib/src/bridges`, where a regeneration scoped by directory would have missed
them.

All eight are now what the generator produces, and the freshness gate passes
for the first time.

## 1.2.2

### Changed — formatted the tree once (scd82)

The analyzer-free twin of `tom_d4rt_dcli`, formatted in the same pass and for
the same reason: the two are the same REPL on the two interpreter lines, kept in
step by diffing, so unformatted layout was costing the check that keeps them
equal rather than merely looking untidy. 57 of 84 files under `lib` and `test`
were affected.

**Layout plus two brace pairs, proven per file rather than asserted.**
`git diff -w` cannot establish inertness, because the tall style *splits* lines
and a whitespace-insensitive diff still counts a moved boundary as a change.
What was checked is the token stream, twice: whitespace stripped, then whitespace
and commas stripped. 56 of the 57 files are identical to HEAD under that
normalisation.

The exception is `lib/src/cli/vscode_integration.dart`, which gained two brace
pairs — re-wrapping a long braceless `if` splits it across lines, which is what
makes `curly_braces_in_flow_control_structures` fire. They were added by
`dart fix --code=curly_braces_in_flow_control_structures`, not by hand, and every
inserted chunk in that file was checked to be exactly `{` or `}`.

Worth noting for the mirror: `vscode_integration.dart` needed the same two
braces in both twins, at the same two sites. That is the twins being twins.

`dart analyze` is clean, and the formatter is now idempotent here.

## 1.2.1

### Fixed — barrel re-exports were registered under an unmatched key (GEN-125)

`bridgeReExports()` recorded its `source` as `lib/tom_d4rt_cli_api.dart`
instead of `package:tom_dcli_exec/tom_d4rt_cli_api.dart`, because the bridge
generator failed to root a relative source path before mapping it to a package
URI. `registerLibraryReExport` matches that key against a script's `import`,
which is always a `package:` URI — so every symbol reached only through a
re-export of the CLI API barrel was invisible to interpreted scripts.

Fixed upstream in `tom_d4rt_generator` 1.15.3 and picked up here by
regeneration; no hand edits to any `*.b.dart`.

## 1.2.0

### Fixed — `.start-execute` blocks of bare statements failed to parse (tccc5)

`D4rt.execute(source:)` parses its argument as a *compilation unit* and calls
the top-level `main`. A `.start-execute` block was handed straight to it, so a
block of bare statements

```
.start-execute
var testVar = 100;
verify(testVar == 100, '.start-execute variable works');
.end
```

parsed as a top-level variable followed by a function declaration with no body
and failed with `Expected to find ')'` / `A function body must be provided`.

The three-case rule that fixes this already existed — but only on the stdin
path. It is now the top-level `prepareProgramSource`, applied at every entry
point that means "run this as a fresh program": stdin, the `exec` command,
`.start-execute`, and `CliController.execute`.

- imports + `main` → run unchanged
- `main` without imports → the bridge import block is prefixed
- bare statements → prefixed *and* wrapped in a generated `main`

The generated wrapper is `async` when the statements await, matching what
`.start-script` already did; `await` inside a string or comment does not count.
`.start-execute` also awaits a `Future` result now instead of printing it.

Requires `tom_d4rt_exec` >= 1.13.0, without which a run whose assertions all
pass is still failed by phantom extension-registration errors. Routing
`.start-execute` through the bridge import block — which it needs, because a
bridged library's top-level functions (`verify`, `verifyEquals`, …) only become
visible through its import — is what made those errors reachable from this path.

## 1.1.3

- Housekeeping: test artifacts now live in a gitignored `testlog/` folder; `doc/` no longer ships machine-generated baselines or last_testrun.json. No code changes.

## 1.1.2

### Bug Fixes
- **GEN-070 follow-up**: `Find` class now properly bridged via generator fix (multi-chain barrel re-export)
- Removed `dcli_missing_bridges.dart` supplementary bridge (no longer needed)
- Removed `lastModified`/`setLastModifed` tests (not exported from dcli barrel)
- Replaced deprecated `symlink()` tests with `createSymLink()` tests

### Tests
- All 389 tests pass, 0 failures, 0 skips

## 1.1.1

### Bug Fixes
- **DCLI-GEN-001**: Added supplementary bridge for missing global functions (`lastModified`, `setLastModifed`, `symlink`)
- **DCLI-GEN-002**: Added `Find` class bridge with static getters (`file`, `directory`, `link`)
- **DCLI-VSCODE-001**: Fixed VS Code bridge import path and test constructor arguments
- **DCLI-LOCK-001**: Updated tests for deprecated `NamedLock.withLock` (dcli 8.4.2), added `withLockAsync` tests
- **DCLI-API-001**: Fixed `expandDefine` test prefix (`$` → `@`)
- Symlink bridge uses `createSymLink` internally (avoids deprecated `symlink()` warning)

### Tests
- All 391 tests pass, 0 failures, 0 skips

## 1.1.0

- Full DCli scripting support now
- Updated tom_d4rt dependency to ^1.8.1
- Regenerated bridges with latest generator (multi-barrel registration, extension filtering)

## 1.0.0

- Initial version.