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