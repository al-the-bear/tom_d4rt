## 1.1.6

- Fix duplicate-export collisions that broke AOT compilation in hosted
  consumers (e.g. `tom_core_d4rt`'s `d4rt` binary). The VS Code integration
  re-export now hides `PermissionResult`, `ConversationExchange`, `ProjectInfo`
  and `WorkspaceInfo` so the package's own `bot_mode` types win, and
  `telegram_bot_server` hides the VS Code `ConversationExchange` so the local
  `conversation_trail` type is used. No public API change for the package's own
  types; the VS Code variants of those four names are no longer re-exported
  (import `tom_vscode_scripting_api` directly if you need them).

## 1.1.5

- Housekeeping: test artifacts now live in a gitignored `testlog/` folder; `doc/` no longer ships machine-generated baselines or last_testrun.json. No code changes.

## 1.1.4

### Maintenance

- Regenerated dcli bridges against the current `tom_d4rt_generator` 1.9.0
  (summary-backed extraction, GEN-095 and follow-up fixes).
- Pinned dependency constraints to current releases (`tom_d4rt` ^1.8.20,
  `tom_vscode_scripting_api` ^1.0.1, `tom_chattools` ^1.0.2).

## 1.1.3

### Maintenance

- Renamed `version.g.dart` → `version.versioner.dart`.
- Updated barrel import in `tom_d4rt_dcli.dart`.

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