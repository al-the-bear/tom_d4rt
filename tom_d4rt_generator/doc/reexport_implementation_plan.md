# Re-export handling — analysis & implementation plan

**Status:** in progress — Step 2 implementing
**Author:** d4rt quest, source-based interpreter follow-up
**Related:** `bridgegenerator_user_reference.md`, `flutter_fixes_*.md`,
`tom_d4rt_flutter_test/doc/implementaton_plan.md`

## The problem in one sentence

`Widget` is registered under `package:flutter/widgets.dart` only. When a
script writes `import 'package:flutter/material.dart';`, the source-based
interpreter (`tom_d4rt`) loads bridges keyed by `material.dart` — and
`Widget` isn't among them, even though real Flutter's `material.dart`
re-exports `widgets.dart`. Type resolution then fails in Pass 1
(`DeclarationVisitor`) or Pass 2
(`InterpreterVisitor._resolveTypeAnnotationWithEnvironment`).

## Discovery: GEN-107 Phase 2 already implemented the data side

During Step 1 implementation it was discovered that the generator and
runtime infrastructure described below as "Steps 1 + 2" already exists as
**GEN-107 Phase 2**. The actual gap is narrower: only the consumer in
`tom_d4rt/module_loader.dart` is missing. The rest of the pipeline is
operational.

| Layer | Status |
|---|---|
| Generator emits `bridgeReExports()` factory on every bridge class | ✅ done — `_collectSourceFileReExportsFromElement` + `_generateBridgeFile` (bridge_generator.dart ~6480) |
| Generated `registerBridges()` calls `interpreter.registerLibraryReExport(source, target, show, hide)` | ✅ done — `bridge_generator.dart ~6620` |
| `tom_d4rt` `D4rt.registerLibraryReExport` API + `_libraryReExports` storage | ✅ done — `d4rt_base.dart:310` |
| `tom_d4rt_ast` `D4rtRunner.registerLibraryReExport` API + storage | ✅ done — `d4rt_runner.dart:294` |
| `tom_d4rt_exec` forwards `registerLibraryReExport` to AST runner | ✅ done — `d4rt_base.dart:217` |
| `tom_d4rt_ast` `ast_module_loader._mergeReExports` consumer | ✅ done — `ast_module_loader.dart:533` |
| **`tom_d4rt` `module_loader._mergeReExportsGlobal` consumer** | ❌ **missing — the actual work** |

**Why the doc comment in `tom_d4rt/d4rt_base.dart:296-303` is wrong:**
It says "re-exports already work transparently here — once any library
imports a target, its symbols are reachable everywhere." This is only
true if the script imports the target library directly. When a script
imports only `material.dart`, `Widget`'s bridge (registered under
`widgets.dart`) is never loaded into `globalEnvironment`. The fix is to
mirror what `ast_module_loader._mergeReExports` already does.

## Confirmed data pipeline (verified in generated bridges)

`d4rt.libraryReExports['package:flutter/material.dart']` contains:
```
{uri: 'package:flutter/widgets.dart', show: null, hide: null}
```
(among many other source-file entries).
`_hasBridgedContentForUri('package:flutter/widgets.dart')` returns `true`.
Therefore loading the `material.dart` bridges + following the re-export
map is sufficient to make `Widget` resolve.

## Implementation plan

### Step 1 — Generator emits manifest (data only)

**Status: already done by GEN-107 Phase 2.**

The generator already emits `bridgeReExports()` and calls
`registerLibraryReExport` from `registerBridges`. No code changes needed.

### Step 2 — Port `_mergeReExports` consumer into `tom_d4rt`

**Status: this step — the actual work.**

**What to implement** in `tom_d4rt/lib/src/module_loader.dart`:

1. Add two filter helpers (verbatim from `ast_module_loader.dart`):
   - `Set<String>? _intersectShow(Set<String>? outer, Set<String>? inner)`
   - `Set<String>? _unionHide(Set<String>? outer, Set<String>? inner)`

2. Add `_mergeReExportsGlobal(String sourceUri, Set<String>? showNames,
   Set<String>? hideNames, Set<String> visited)`:
   - Guard: `d4rt == null` → return (no re-export data without a runner)
   - Look up `d4rt!.libraryReExports[sourceUri]`
   - For each re-export entry `{uri, show, hide}`:
     - Add to `visited` (skip if already visited — cycle guard)
     - Compute `effectiveShow = _intersectShow(showNames, re.show)`
     - Compute `effectiveHide = _unionHide(hideNames, re.hide)`
     - If `_hasBridgedContentForUri(re.uri)`: call
       `_fetchModuleSource(Uri.parse(re.uri), showNames: effectiveShow,
       hideNames: effectiveHide)` — the existing dedup maps prevent double
       registration; `_fetchModuleSource` also calls `_mergeReExportsGlobal`
       transitively, propagating the chain
     - If `re.uri` is a `dart:` scheme: same — `_fetchModuleSource` handles
       stdlib; wrap in try/catch for unknown dart: libs
     - Else (no bridges, not stdlib): call
       `_mergeReExportsGlobal(re.uri, effectiveShow, effectiveHide, visited)`
       so that transitive re-exports from pure-barrel files are also followed

3. In `_fetchModuleSource`, in the `if (hasContentForUri) { ... return ''; }`
   branch (line ~908), call:
   ```dart
   _mergeReExportsGlobal(uriString, showNames, hideNames, <String>{uriString});
   ```
   before returning. The `uriString` is pre-added to `visited` so the first
   level can't loop back to itself.

**Why not call `_fetchModuleSource` recursively for dart: re-exports?**
The `_fetchModuleSource` already handles `dart:` via the stdlib section
(auto-registers into `globalEnvironment`). Calling it recursively with
`dart:typed_data` is safe and correct.

**Backward compatibility:** The `_libraryReExports` map is empty unless
bridges call `registerLibraryReExport`. Existing bridge packages that
haven't re-generated don't call this method — their `bridgeReExports()`
used to just not call it. Re-generation (when needed for other fixes) will
add the calls automatically. Existing packages continue to work unchanged.

**Correction to `d4rt_base.dart` doc comment:**
The misleading comment at line 296-303 must be corrected to say
"re-exports are processed via `_mergeReExportsGlobal` in
`module_loader.dart`" not "work transparently here".

### Step 3 — Verify and regenerate

- Run `tom_d4rt` test suite (1680-test baseline).
- Regenerate `tom_d4rt_flutter_test/lib/src/bridges/*.b.dart` (no
  generator changes, but confirms regeneration is clean).
- Run `tom_d4rt_flutter_test` corpus to verify `Widget` resolves when
  a script imports only `package:flutter/material.dart`.
- Run gii + essential + important + secondary suites serially per the
  cluster-fix verification protocol. Revert if any regression.

### Step 4 — Cleanup / note on tom_d4rt_exec

`tom_d4rt_exec` wraps `tom_d4rt_ast`'s `D4rtRunner`. The AST runner
already has `_mergeReExports` in `ast_module_loader.dart`. `tom_d4rt_exec`
uses `AstModuleLoader` (not `ModuleLoader`), so **it is already correct**.
No changes needed in `tom_d4rt_exec`.

The misleading comment at `tom_d4rt/d4rt_base.dart:296-303` should be
updated to describe the actual mechanism.

### Out of scope

- `tom_d4rt_generator`: no code changes needed — GEN-107 Phase 2 is
  complete and correct.
- `tom_d4rt_ast`: already correct (`ast_module_loader._mergeReExports`
  exists and is called).
- `buildkit.yaml` files: no changes needed — backward compatible.
- Generic-type-relaxer or proxy-class generation paths. Re-exports are
  orthogonal to those.
