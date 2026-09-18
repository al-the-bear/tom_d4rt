## 1.5.0

### Changed — realigned with the `dcli` 10 line

`dcli`, `dcli_core` and `dcli_terminal` move from `^8.4.2` to `^10.0.0`, and
`dart_console` to `^5.0.0` (required by `dcli_terminal` 10). `win32` resolves
6.4.0 in consequence.

The move was blocked, not deferred: `tom_build_base` pinned `dcli: ^8.4.2`,
and because it sits transitively under this package via `tom_d4rt_generator`,
version solving rejected any request for `dcli` 10 regardless of what this
pubspec said. `tom_build_base` 2.11.0 widens that constraint to admit both
majors, which is what unblocks this.

### Changed — bridges regenerated against the dcli 10 API

`lib/src/bridges/*.b.dart` are regenerated. dcli 9 removed a set of members
that had been deprecated through the 8.x line, so the committed bridges
described methods the package no longer has and every test that loaded them
failed to compile. The removals visible here are `Env.addToPATHIfAbsent`,
`Terminal.previousLine`, `Terminal.lines`, `DartProject.current`,
`DartScript.current`, and `DartSdk.globalActivate` /
`globalActivateFromPath`.

### Removed — the `FileSync.tempFile()` bridge test

`FileSync.tempFile()` was deprecated in favour of the top-level
`createTempFilename()` and removed in dcli 9, so the test asserted an API that
no longer exists. `createTempFilename()` is already covered by two tests in
the Temp Files group; a third copy in the FileSync group would have been
duplication rather than coverage.

Suite 704/13/0, against a 705/13/0 baseline — the difference is exactly the
deleted test.

## 1.4.0

### Fixed — the `--version` banner reports the real version (sce9)

`lib/src/version.versioner.dart` said 1.3.1 while the pubspec said 1.4.0, so
`dcli --version` named a release that is not what was running. The stamp is
regenerated and `version_stamp_test` passes; published so the correction
reaches the package people install rather than only this tree.


### Changed — the bridges are regenerated after seven months, and the package can now check them (sce3)

`tom_d4rt_dcli` configured `d4rtgen` in its `buildkit.yaml` but listed
`tom_d4rt_generator` in no dependency block, so `dart run
tom_d4rt_generator:d4rtgen` failed in it and `checkBridgeFreshness` could not
be called from its suite. It was one of two consumers in the workspace that
could neither regenerate its bridges nor check what it had committed.

The dependency was there once, commented out, with a reason:

    # analyzer-10 migration: tom_d4rt_generator (still analyzer ^8.4.1) cannot
    # share a resolution with tom_d4rt's analyzer ^10.

That has not been true for some time. The generator depends on
`analyzer: ^10.0.0` and on `tom_d4rt: ^1.77.0`, which is exactly what this
package already declared; adding it back as a DEV dependency resolves on the
first attempt and changes nothing the package ships.

With it in place the measurement was possible, and eight of the nine generated
files were stale — every bridge module, the dartscript, the test runner and
the relaxers, last written in February. They are now what the generator
produces, and `test/bridges_fresh_test.dart` will say so the next time they
drift.

## 1.3.1

### Changed — formatted the tree once (scd82)

Every package in this repo already declares an SDK floor above the 3.7
tall-style boundary, so the formatter can no longer produce two layouts here.
What was not true is that the trees were formatted: until this commit, running
`dart format` on any single file rewrote it wholesale and buried whatever real
edit came with it. 46 of 60 files under `lib` and `test` were affected.

This package and `tom_dcli_exec` are twins in the sense SCC26 cares about — the
same REPL on the analyzer line and the analyzer-free line, kept in step by
diffing — so unformatted layout was actively costing the check that keeps them
equal, not merely untidy.

**The commit is layout plus twelve brace pairs, and which is which was proven
rather than asserted.** `git diff -w` cannot establish inertness, because the
tall style *splits* lines and a whitespace-insensitive diff still counts a moved
boundary as a change. What was checked is the token stream, per file, twice:
whitespace stripped, then whitespace and commas stripped. 44 of the 46 files are
identical to HEAD under that normalisation.

The other two are `lib/src/cli/repl_base.dart` and
`lib/src/cli/vscode_integration.dart`, which gained braces — ten pairs and two
pairs. Re-wrapping a long braceless `if` splits it across lines, which is what
makes `curly_braces_in_flow_control_structures` fire, and it fired twelve times
here. The braces were added by `dart fix --code=curly_braces_in_flow_control_structures`
rather than by hand: a first attempt to brace them with a regex over the source
corrupted a multi-line string, which is the argument for using the parser. Every
inserted chunk in those two files was then checked to be exactly `{` or `}` and
nothing else.

`dart analyze` is clean, and the formatter is now idempotent here.

## 1.3.0

### Added — the full VS Code scripting API bridge surface

`lib/src/bridges/tom_vscode_scripting_api_bridges.b.dart` was regenerated
against the current `tom_vscode_scripting_api` and grew from a partial surface
to the complete one (~9 000 lines of additional bridged members). Scripts that
previously hit `Undefined member` on a VS Code scripting call now resolve it.

The remaining bridge files (`cli_api`, `dcli`, `path`, `tom_chattools`) were
regenerated in the same pass; their content is unchanged.

### Fixed — barrel re-exports were registered under an unmatched key (GEN-125)

`bridgeReExports()` recorded its `source` as `lib/tom_d4rt_cli_api.dart`
instead of `package:tom_d4rt_dcli/tom_d4rt_cli_api.dart`, because the bridge
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

Requires `tom_d4rt` >= 1.29.0, without which a run whose assertions all pass is
still failed by phantom extension-registration errors. Routing `.start-execute`
through the bridge import block — which it needs, because a bridged library's
top-level functions (`verify`, `verifyEquals`, …) only become visible through
its import — is what made those errors reachable from this path.

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