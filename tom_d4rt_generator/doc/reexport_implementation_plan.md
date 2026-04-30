# Re-export handling — analysis & implementation plan

**Status:** proposal, awaiting approval
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

The orchestrator-level `registrationAliases` patch attempted in an earlier
session would have papered over the symptom but would not have honoured
`show`/`hide` clauses, would have caused duplicate-registration errors when
a real "alias" barrel is also a primary module (which all the lower-level
Flutter barrels are), and would have left the interpreter's lookup model
unchanged. The design below fixes all three.

## Proposed model

### 1. Generation-time

When the generator processes a barrel B, it walks B's re-export graph.
For each transitively reachable barrel X (subject to `skipReExports`):

- Bridges for X are generated **once** in X's own bridge file (the
  existing `*_bridges.b.dart`).
- B's bridge file records a **re-export manifest**:
  `{barrel: X, kind: full | show[...] | hide[...]}` for each X that B
  re-exports, possibly indirectly.
- Deduplication: a class lives in exactly one bridge file (its declaring
  package's). All other bridge files reference it via the manifest.

### 2. Registration-time

The orchestrator's `register(d4rt)` does two things per module:

- Calls the existing `registerBridges(d4rt, primaryUri)` so direct classes
  are stored under the primary library URI (unchanged).
- Calls a new `registerReExports(d4rt, primaryUri)` that, for each entry
  in the manifest, registers an alias mapping
  `(primaryUri, className) → (originalUri, className)` filtered by
  show/hide.

### 3. Interpreter-time

The environment grows a second lookup table:

- `_bridgedClases` stays as today: `library URI → list<className → BridgedClass>`
  (the canonical home).
- A new `_bridgeAliases`: `(library URI, className) → (canonical library URI, className)`,
  populated from manifests at finalize time.
- When `_fetchModuleSource` builds the synthetic environment for an
  `import 'package:flutter/material.dart'`, it walks both tables: direct
  bridges *plus* aliased classes resolved through `_bridgeAliases`.

## Feasibility — verdict

**Feasible, and the right shape of fix.** It addresses the model mismatch
(D4rt treating bridges as flat per-URI buckets vs. Dart's transitive
re-export graph) at the layer where the mismatch lives. It does not
require any change to scripts, bridges-as-data, or downstream packages.

## Scope of impact

| Layer | Change | Cost |
|---|---|---|
| `tom_d4rt_generator/bridge_generator.dart` | Already walks re-export edges via `_followBarrelExports`. New work: keep the *list* of edges (with show/hide) instead of just inlining their content. Emit a `reExports()` method on each generated bridge class returning `List<ReExportEntry>`. | Medium — touches the per-barrel walker plus the generated-class template. |
| `tom_d4rt_generator/file_generators.dart` | Orchestrator calls `bridgeClass.reExports().forEach(d4rt.registerReExport)` after `registerBridges`. | Small. |
| `tom_d4rt/d4rt_base.dart` & `tom_d4rt_ast/.../d4rt_runner.dart` | New `registerReExport(BridgedReExport entry, String fromLibrary)` API. New `_bridgeAliases` table (or extend `LibraryClass` with a "this is an alias to X" variant). | Small-to-medium per runner. **Must mirror across `tom_d4rt` ↔ `tom_d4rt_ast`** — quest non-obvious rule #3. |
| `tom_d4rt_exec/lib/src/d4rt_base.dart` | Add a thin forwarding method `void registerReExport(...) => _runner.registerReExport(...)` mirroring the existing forwarders for `registerBridgedClass`, `registerExtensions`, `finalizeBridges`. The heavy lifting lives in `tom_d4rt_ast`'s `D4rtRunner`; exec's `D4rt` is the public facade and stays in sync automatically once the underlying runner exposes the API — but the forwarding stub must be added explicitly. | Trivial. |
| `tom_d4rt/module_loader.dart` & `tom_d4rt_ast/.../module_loader.dart` mirror | `_fetchModuleSource` resolves alias entries: when iterating registered bridges for an import URI, also iterate alias entries and resolve them to the canonical bridge for the synthetic environment. Show/hide filter applied at this step. | Medium — load-bearing change; needs careful interaction with the existing dedup logic at line 559–578 (same-sourceUri silent skip / different-sourceUri "Duplicate class" error). |
| `tom_d4rt_generator/bridge_config.dart` | Optional: add `reExportPolicy: registered \| ignored` per module if we want an escape hatch. Probably not needed for v1 — `skipReExports` already gates the walk. | Negligible. |
| `buildkit.yaml` files (downstream) | **No change required** if `skipReExports` semantics stay the same. The generator now does the right thing automatically. | Zero — backward compatible. |

## Edge cases and how the model handles them

1. **Cyclic re-exports** (A re-exports B; B re-exports A — rare but
   legal). Walker already needs a `visited` set; alias edges should be
   deduped on `(fromBarrel, toBarrel)` key. No new risk.

2. **Same class reachable via two paths** — `Widget` is reachable from
   `material.dart` via `widgets.dart` and (hypothetically) via some other
   path. The canonical home is still `widgets.dart`; aliases pointing to
   it from multiple parents are fine because the alias table maps
   `(parent, name) → canonical`, never the reverse.

3. **`show` / `hide` on re-exports** — Encoded per alias entry as
   `Set<String>` filter; applied at registration time so the alias table
   only contains the visible names. This is the only correctness-critical
   bit; getting filters right matters more than getting graph traversal
   right.

4. **An alias barrel is also a primary module** (this is the case that
   broke the earlier patch — all of Flutter's lower-level barrels are also
   primary modules). The design handles it correctly: the canonical
   bridge for `Widget` lives under `widgets.dart`, the entry under
   `material.dart` is an *alias*, not a duplicate registration. No
   "Duplicate class" error path is reached.

5. **Conflicting names across re-exports** (e.g., `material.dart` and
   `cupertino.dart` both define `BackButton`). Real Dart resolves by
   source-order or `show`/`hide`; the generator must mirror the
   `analyzer`'s view, which it already has access to via
   `LibraryElement.exportNamespace`. Manifest entries should be emitted in
   the same order the analyzer presents them.

6. **A re-exported barrel has no bridges generated for it** (out-of-scope
   package). Walker should skip silently — alias entries pointing at
   non-existent bridge files would be dead weight.

7. **`_initModule` pass — sourceUri dedup**
   (`module_loader.dart:559-578`). Aliases must NOT pass through that
   path — they're not new registrations, they're lookups. This is the
   cleanest separation: `_bridgedClases` is the registry, `_bridgeAliases`
   is the symbol table; `_fetchModuleSource` consults both.

8. **Performance** — Re-export walking is bounded by the static graph
   (single-digit hops in practice). Alias lookup is O(1) hash. The
   synthetic environment build is O(direct + aliased), no worse than
   today's O(direct).

9. **Backward compatibility** — Existing buildkit.yaml configs Just Work
   with better behaviour (more types resolve). The only observable
   difference: scripts that previously errored with "type X not found"
   now succeed. No new config required, no migration.

## Risks to surface before coding

- **`_bridgedClases` is a list-of-maps, not a map-of-maps.** Adding
  parallel `_bridgeAliases` is fine, but `module_loader.dart` iterates
  the list in order and the existing dedup logic is sensitive to
  iteration. Aliases must be processed *after* direct bridges per import
  URI to avoid the alias getting flagged as a "Duplicate class with
  different sourceUri" against a real registration that arrives later in
  the list.

- **`tom_d4rt_ast` mirroring discipline + `tom_d4rt_exec` forwarding.**
  The interpreter changes have to land in both runners in the same
  commit. The runtime types `BridgedClass`, `LibraryClass`, and any alias
  struct must be defined symmetrically across `tom_d4rt` and
  `tom_d4rt_ast`. `tom_d4rt_exec/lib/src/d4rt_base.dart` is a thin
  facade over `D4rtRunner` from `tom_d4rt_ast` — it stays *almost*
  automatically in sync, but every new public API on the runner needs
  an explicit forwarding stub on exec's `D4rt` class (mirroring the
  existing `registerBridgedClass` / `registerExtensions` /
  `finalizeBridges` forwarders). Don't ship without that stub or
  downstream packages that consume `package:tom_d4rt_exec/d4rt.dart`
  won't see the new API.

- **Two-pass interpretation.** Pass 1's placeholder fallback
  (`declaration_visitor.dart:191-207`) silently substitutes
  `BridgedClass(nativeType: Object, name: typeName)` when a type isn't
  found. Once aliases work, that fallback should be hit much less — but
  it can mask bugs. Worth adding a debug-mode log when the fallback
  fires *after* the alias table is populated.

- **`bridge_generator.dart` is 12k lines.** The existing
  `_followBarrelExports` (line 1875–2015) inlines re-exported elements
  today. Switching from "inline everything" to "inline direct + alias
  indirect" is a behaviour change for the existing `subPackageBarrels()`
  path; we'd need to keep that path working for any consumer that relies
  on it, or migrate to alias semantics universally. Worth auditing
  before committing to the refactor.

## Recapitulation

Move the model from "flat per-URI bridge buckets" to "per-URI bridges +
per-URI alias mappings to canonical bridges, generated from the
analyzer's re-export graph with show/hide preserved". It is
**backward-compatible at the buildkit.yaml level**, requires changes in
three places (generator walker + emitted manifest, orchestrator
registration call, interpreter alias table + `_fetchModuleSource`
consultation), and must be mirrored across `tom_d4rt` and `tom_d4rt_ast`
per the quest's sync rule.

## Implementation plan

Suggested order, each commit independently testable:

### Step 1 — Generator emits manifest (data only)

- Extend `bridge_generator.dart` to record re-export edges discovered by
  `_followBarrelExports` (currently they're consumed silently). Track
  `(targetUri, kind, names)` where `kind ∈ {full, show, hide}`.
- Emit a `List<BridgedReExport> reExports()` method on each generated
  bridge class. `BridgedReExport` is a new tiny data class in the
  runtime (`tom_d4rt` + `tom_d4rt_ast`) — `{String targetUri, ReExportKind kind, Set<String> names}`.
- Add a unit test under `tom_d4rt_generator/test/` that a known re-export
  chain (build a small fixture; do not add to flutter_test) produces the
  expected manifest entries.
- Empty alias table on the runner side means zero behavioural change.
  Existing tests must stay green.

**Commit boundary.**

### Step 2 — Runners gain alias table (no consumers yet)

- `tom_d4rt/lib/src/d4rt_base.dart`: add `registerReExport(BridgedReExport entry, String fromLibrary)`
  and `_bridgeAliases: Map<(String,String), (String,String)>`.
- `tom_d4rt_ast/lib/src/runtime/d4rt_runner.dart`: mirror the same API
  and table verbatim.
- `tom_d4rt_exec/lib/src/d4rt_base.dart`: add the forwarding stub
  `void registerReExport(BridgedReExport entry, String fromLibrary) => _runner.registerReExport(entry, fromLibrary);`
  next to the existing `registerExtensions` / `finalizeBridges` forwarders. Re-export the
  `BridgedReExport` type from `package:tom_d4rt_exec/d4rt.dart` (it
  comes through from `tom_d4rt_ast`, but the public surface needs it
  visible).
- `module_loader.dart` (both `tom_d4rt` and `tom_d4rt_ast`): in
  `_fetchModuleSource`, after the existing direct-bridge iteration,
  walk `_bridgeAliases` for `fromLibrary == importUri`. For each
  alias, resolve to the canonical `BridgedClass` and add it to the
  synthetic environment, applying the show/hide filter. Aliases never
  go through the `_registeredClasses`/sourceUri dedup path.
- Keep the alias table empty for now; verify no regression in
  `tom_d4rt`'s 1680-test baseline, the `tom_d4rt_exec` test suite,
  and the flutter_test corpus.

**Commit boundary.**

### Step 3 — Orchestrator wires it up

- `tom_d4rt_generator/lib/src/file_generators.dart`: in the per-module
  block of `generateDartscriptFileContent`, after the existing
  `registerBridges` calls and `subPackageBarrels()` loop, emit:
  ```dart
  for (final entry in <prefix>.<bridgeClass>.reExports()) {
    d4rt.registerReExport(entry, '<primaryUri>');
  }
  ```
- Regenerate `tom_d4rt_flutter_test/lib/src/bridges/*.b.dart` and
  `tom_d4rt_flutterm/lib/src/bridges/*.b.dart`.
- Verify the original failing case: a corpus script that imports only
  `package:flutter/material.dart` and references `Widget` resolves
  cleanly.
- Run the cluster-fix verification protocol from the quest overview:
  reproduce, fix, mirror, regenerate, then gii + essential + important +
  secondary serially. Revert or narrow if any suite regresses.

**Commit boundary.**

### Step 4 — Cleanup

- If steps 1–3 fully subsume the existing `subPackageBarrels()` /
  `contentPackages` machinery (line 7267–7448 of `bridge_generator.dart`),
  consider deprecating it in a follow-up commit. Audit downstream
  consumers first; this may be deferred indefinitely if anything outside
  the orchestrator reads `subPackageBarrels()`.
- Update `bridgegenerator_user_reference.md` with the new
  `reExports()` method and the `BridgedReExport` runtime type.
- Add a debug-mode log in `declaration_visitor.dart:191-207` so the
  `BridgedClass(nativeType: Object, name: typeName)` placeholder
  fallback is observable when it fires after alias-table population —
  helps catch missed re-export edges.

**Commit boundary.**

### Out of scope for this plan

- Generic-type-relaxer or proxy-class generation paths. Re-exports are
  orthogonal to those.
- Any change to `D4rtUserBridge` overrides or
  `d4rt_user_bridges/` hand-written bridges. Aliases are emitted by the
  generator; user bridges remain at the URI they declare.

### Note on `tom_d4rt_exec`

`tom_d4rt_exec` is **in scope** even though it doesn't host the
implementation. Its `D4rt` class (`lib/src/d4rt_base.dart`) is a thin
facade that forwards every public method to the underlying
`D4rtRunner` from `tom_d4rt_ast`. Most of the alias machinery flows
through automatically — but each new public API needs an explicit
forwarding stub, and `BridgedReExport` needs to be re-exported from
`package:tom_d4rt_exec/d4rt.dart` so downstream packages (e.g.,
`tom_d4rt_flutter_ast`, the AST-bundle test apps) can call
`registerReExport` without reaching into `tom_d4rt_ast` directly.

The AST-bundle pipeline itself doesn't need a model change: bundles
already resolve imports at compile time. But scripts executed via
`exec.execute(source: ...)` (the source-based path that exec also
supports) hit the same `_fetchModuleSource` logic as `tom_d4rt`, so
the alias table benefits both pipelines.
