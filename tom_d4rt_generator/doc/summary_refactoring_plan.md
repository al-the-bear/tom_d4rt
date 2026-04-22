# Summary-Backed Refactoring Plan

Plan to migrate `tom_d4rt_generator` to a fully summary-backed, element-only
extraction pipeline — eliminating the AST-visitor twin of the element walker
and following the proven pattern of `tom_reflection_generator`.

Owner: d4rt quest.
Status: Draft. Not started.

**Success criteria (the only gates that matter):**

1. `tom_d4rt_flutterm` regenerates and its `essential_classes_test.dart`,
   `important_classes_test.dart`, and `secondary_classes_test.dart`
   suites pass with the same baseline they hold today — i.e. zero
   regressions against the current baseline (today: 1 failing test in
   `important_classes_test`, 1 failing test in `secondary_classes_test`,
   everything else green; **both pre-existing failures stay failing,
   no new failures**).
2. Every other `tom_d4rt_*` consumer package that uses generated bridges
   regenerates and its test suite passes with its current baseline:
   `tom_d4rt_dcli`, `tom_d4rt_exec`, `tom_dcli_exec`, and `tom_d4rt`
   (test suite lives under `tom_d4rt/test/`, not `tom_d4rt_test/`).
3. **Byte-identical intermediate bridge output is not a gate.** Bridge
   files may drift cosmetically (typedef expansion, member ordering,
   whitespace) as long as the consumer-test baselines hold.

---

## 1. Why this migration

### 1.1 The current shape is wrong

`tom_d4rt_generator` has two full-fledged walkers for the same job:

- `_ResolvedClassVisitor` in `lib/src/bridge_generator.dart` (class declared
  at line 13810, runs to ~16015 — roughly 2,200 lines) walks the AST via
  `RecursiveAstVisitor<void>`.
- `ElementModeExtractor` in `lib/src/element_mode_extractor.dart` walks
  `LibraryElement` and is invoked as a fallback from
  `bridge_generator.dart:4064–4118` / `4122–4161` when `getResolvedLibrary`
  returns `NotPathOfUriResult` (which happens whenever a `.sum` bundle
  shadows the source file).

Every feature has to be kept in sync across both walkers. Every bug fix
doubles. Every divergence surfaces as generated-bridge drift that we chase
through diffs (see the recent tolerance-setter incident — the fix needed
to land in the AST path's `_collectInheritedMembersFromElement` *and* be
mirrored into `ElementModeExtractor`).

### 1.2 The reflection generator proves the clean path

`tom_reflection_generator` has **no AST visitor at all**. It walks
`LibraryElement.classes`, `InterfaceElement.methods`, `.fields`, etc.
directly. Turning on summary-backed analysis there was ~200 lines total
across two commits:

- `6f6a546` (+180/−16) — "fix: pass SDK summary and dependency summaries
  during package analysis": threaded `sdkSummaryPath` +
  `librarySummaryPaths` into `AnalysisContextCollectionImpl`. Root cause
  was that `SummaryDataStore` only gets created when
  `librarySummaryPaths` is non-null — without it SDK bundle registration
  silently fails.
- `f15ae96` (+44/−14) — "fix: extract default values and metadata from
  summary-backed elements": switched `_extractDefaultValueCode` to read
  `parameterElement.constantInitializer` (populated by `.sum`
  deserialization), and added a fallback in `_extractMetadataCode` that
  reads from `element.metadata.annotations` when AST resolution fails.

No walker logic changed. The analyzer transparently serves elements from
`.sum` bundles or resolved source — the walker doesn't care. **That is
the target architecture for bridge generation.**

### 1.3 Expected outcomes

- One walker instead of two. `ElementModeExtractor` becomes the canonical
  path; `_ResolvedClassVisitor` is deleted (~2,200 lines removed).
- Summaries are always on for every dependency. No more
  `filterSummariesForBridgedPackages` exclusion logic — bridged packages
  read from `.sum` bundles like every other dependency.
- Bridge generation time collapses from ~208 s to ~30 s on
  `tom_d4rt_flutterm` (already measured with the env-var bypass).
- Fixes land in one place. Inheritance walker, typedef preservation,
  member ordering, default-value rendering — all maintained against a
  single walker.

---

## 2. Scope: three generators

The package exposes three generators, run sequentially by
`lib/src/bridge_api.dart:generateBridges()` (line 77) and
`lib/src/v2/d4rtgen_executor.dart:_generateBridges()` (line 162):

| # | Generator | Entry | Inputs | Walker coupling |
|---|---|---|---|---|
| 1 | **BridgeGenerator** | `bridge_generator.dart:997`, method `generateBridgesFromExports` | Dart sources + `.sum` bundles | Heavy — owns both `_ResolvedClassVisitor` (AST) and drives `ElementModeExtractor` (element fallback) |
| 2 | **ProxyGenerator** | `proxy_generator.dart:170`, function `generateProxies` | Same `AnalysisContextCollectionImpl` set up separately (line 194–207) | AST-only today (uses `getResolvedLibrary` result + visitors) |
| 3 | **RelaxerGenerator** | `relaxer_generator.dart:109`, function `generateRelaxers` | `genericExtractionSites` + `classLookup` (built by BridgeGenerator) | **None** — pure code-gen over the intermediate model |

RelaxerGenerator is already walker-agnostic and needs no migration work.
BridgeGenerator and ProxyGenerator both need to go element-only.

Additionally, `lib/src/user_bridge_scanner.dart` (643 lines) is an
AST-only `RecursiveAstVisitor<void>` that scans user-bridge override
files. It is invoked once upstream of the three generators. It is part
of the same migration and is called out as a dedicated phase below.

---

## 3. What must not change

- **The intermediate model.** `ClassInfo`, `MemberInfo`, `ConstructorInfo`,
  `GlobalFunctionInfo`, `GlobalVariableInfo`, `EnumInfo`, `ExtensionInfo`
  are the contract between extractors and emitters (rendering / emission
  code in `bridge_generator.dart` starting around line 7615 in
  `_generateBridgeForClass`, plus `file_generators.dart`). Do not
  refactor the model. Feed it only from the element walker.
- **The emitter side.** `_generateBridgeForClass`,
  `_generateSignatureMaps` (line 8087), and all of
  `file_generators.dart`, `proxy_generator.dart`'s emission code, and
  `relaxer_generator.dart` stay as-is. They already consume the
  intermediate model and are walker-agnostic.
- **The summary cache pipeline.** `runSummaryCacheStage` (from
  `tom_analyzer_shared`) + `SummaryCacheManager` + SDK summary
  generation already work. The only change is **dropping the bridged-
  package filter** once the element walker is canonical.

---

## 4. What must change — blockers, work items, safe areas

Cross-referenced against the `_ResolvedClassVisitor` audit and the
whole-package `.toSource()` / AST-type audit. Each entry names the
site, the element-API replacement, and the risk class.

### 4.1 Blockers (need solving before element-only is viable)

| # | Site | Problem | Element replacement | Risk |
|---|---|---|---|---|
| B1 | Type annotation rendering via `TypeAnnotation.toSource()` (`bridge_generator.dart:14302, 14395, 14400, 14441, 14502, 14569, 14657, 15686, 15729, 15763, 15825, 15847, 15926, 15959, 16162, 16404`) | `.toSource()` preserves typedef names (`VoidCallback`, `TickerCallback`), source formatting of nullable markers and spacing | `DartType.getDisplayString()` or reconstruct typedef name via `dartType.alias?.element.name` + recursively-rendered type args + `nullabilitySuffix` | Medium — typedef preservation requires an explicit helper |
| B2 | Default-value text (`bridge_generator.dart:15919` `param.defaultValue!.toSource()`; already has fallback to `element.defaultValueCode` at `2100–2101`, `2183`, `15992`) | AST gives raw source text; summary-backed elements may have `defaultValueCode == null` unless `constantInitializer` is read | Primary: `parameter.constantInitializer?.toSource()` (populated from `.sum`), fallback: `parameter.defaultValueCode`. Mirror reflection-generator commit `f15ae96`. | Low — pattern is proven |
| B3 | Annotation argument rendering (`bridge_generator.dart:13969` `annotation.toSource()`) | Used in internal/deprecated string fallback check | Primary element flags (`annotation.isInternal`, `.isMustBeOverridden`, `.isVisibleForOverriding`) are already the main path. Remove `.toSource()` fallback or replace with `ElementAnnotationImpl.annotationAst?.arguments?.toSource()` (already wrapped by `annotationArgumentsSource` in `element_mode_extractor.dart:1071`) | Low — fallback is rarely hit |
| B4 | Source-order iteration of class members (`bridge_generator.dart:14599–14609` `for (final member in node.members)`) | Element API exposes `classElement.getters/setters/methods/fields/constructors` as separate lists; their concatenation does not match source order | Sort combined list by `member.firstFragment.nameOffset` ascending. Verify every emitted map (`getters: {…}`, `setterSignatures: {…}`, `methodSignatures: {…}`) is stable under that sort key | Medium — load-bearing for diff stability; harmless for correctness |

### 4.2 Work items (element-API equivalent exists, pattern is clear)

| # | Site | Work |
|---|---|---|
| W1 | `_hasInternalAnnotation(AnnotatedNode)` at `bridge_generator.dart:13931` + element twin at `13950` + `element_mode_extractor.dart:124` | Consolidate to single element-based helper. Drop the AST overload. Already correctly implemented in `element_mode_extractor.dart`. |
| W2 | `_hasDeprecatedAnnotation(AnnotatedNode)` at `bridge_generator.dart:14031` + element twin at `element_mode_extractor.dart:153` | Same — consolidate. |
| W3 | `_parseConstructor(ConstructorDeclaration)` at `15684`, `_parseMethod(MethodDeclaration)`, `_parseField(FieldDeclaration)` | Already mirrored in `element_mode_extractor.dart` (`_memberFromMethodElement` line 1023, field loop line 841, constructor loop line 937). Port any missing features (default-value via `constantInitializer`, metadata via `element.metadata`) and delete the AST versions. |
| W4 | Type parameter bound extraction (`bridge_generator.dart:14395, 14502, 15686, 16162`) | Replace `bound?.toSource()` with `bound?.getDisplayString()`. Already element-based in `element_mode_extractor.dart:971–990`. |
| W5 | Extension on-clause generic filter (`bridge_generator.dart:14302–14308` `onTypeName.contains('<')`) | Replace with `DartType.typeArguments.isNotEmpty` check on `InterfaceType`. |
| W6 | Typedef alias preservation in emitted parameter/return types | New helper `renderDartType(DartType type)` that checks `type.alias` and emits the alias name with recursively-rendered type arguments; used for setter parameters, method parameters, return types, field types. Add to `ElementModeExtractor`. |
| W7 | `user_bridge_scanner.dart` — AST-only scanner, 643 lines | Reimplement as element walker. It inspects `@D4rtUserBridge` annotations and extracts method/member names — all pure metadata, no AST-only features required. Self-contained phase (no coupling to bridge generation beyond output model). |

### 4.3 Safe (already element-based or trivially removable)

- `_collectInheritedMembersFromElement` at `bridge_generator.dart:15167`,
  `_parseMemberFromGetterElement/SetterElement/MethodElement`,
  `_substituteTypeParameters`, `_buildQualifiedMemberNames`,
  `_collectInfoFromDartType` — all already element-based. I've already
  copied equivalents into `ElementModeExtractor`.
- Global type URI registry (`bridge_generator.dart:13834–13837`, `14316`,
  etc.) — already element-driven via `element.library.identifier`.
- Synthetic unnamed constructor handling
  (`bridge_generator.dart:14630–14640`) — already element-based.
- Import URI collection — already element-based
  (`alias.element.library.identifier`); no `ImportDirective` traversal.
- Doc-comment extraction — not used by the visitor body; no work
  required.
- Constructor `initializers` / `body` — not used by the visitor body; no
  work required.

---

## 5. Phasing

Each phase ends with `dart analyze` clean and `testkit :test` baselines
held for tom_d4rt_generator. A phase may span several sessions.

### Phase 0 — Test baselines (1 session, must land first)

Before touching any generator code: pin down today's passing/failing
state across every consumer test suite. These baselines are the only
regression oracle for the migration — every subsequent phase must keep
them flat (no new failures; pre-existing failures may stay failing).

**Baseline capture steps:**

1. For `tom_d4rt_flutterm`, run each of the following via
   `testkit :baseline` from the project root, producing a CSV under
   `doc/baseline_MMDD_HHMM.csv`:
   - `test/essential_classes_test.dart`
   - `test/important_classes_test.dart`
   - `test/secondary_classes_test.dart`
   - `test/bridge_execution_test.dart` (sanity baseline, not a gate
     but useful)
   Commit the CSVs under `tom_d4rt_flutterm/doc/` with names that
   clearly mark them as the summary-refactor baseline, e.g.
   `baseline_summary_refactor_essential_YYYYMMDD.csv`.

2. For the other consumer packages, run `testkit :baseline` at the
   project root and commit the CSVs under the package's `doc/` folder:
   - `tom_d4rt_dcli` — `test/cli_api_*_test.dart`,
     `test/directory_operations_test.dart`,
     `test/file_operations_test.dart`,
     `test/process_execution_test.dart`, etc.
   - `tom_d4rt_exec` — full `test/` directory
     (`bridge/`, `bundle_*`, async tests, generics tests, …).
   - `tom_dcli_exec` — `test/cli_api_*`,
     `test/tom_dcli_exec_test.dart`, `test/repl_*`, `test/replay/`,
     `test/results/`, `test/stdin/`.
   - `tom_d4rt` — full bridge-touching subset of `test/`.

3. Capture a canonical regeneration transcript. From
   `tom_d4rt_flutterm`: `dart run tool/regenerate_bridges.dart` →
   pipe full stdout to
   `doc/regen_transcript_baseline_YYYYMMDD.txt`. Snapshot the 15
   generated `.b.dart` files into
   `tom_d4rt_generator/doc/baselines_summary_refactor/flutterm/`.
   Repeat per consumer package that regenerates bridges — snapshot
   any `*.b.dart` output plus the regen transcript. These are the
   diff reference, not a byte-identical gate.

4. Add a short `doc/baseline_summary_refactor.md` in
   `tom_d4rt_generator` that:
   - lists the CSV paths and commit SHAs per package,
   - documents today's pre-existing failing tests (1 in `important`,
     1 in `secondary` for flutterm — capture exact test IDs from the
     CSV), so every subsequent phase knows what "flat" means,
   - describes the one-line command per package to regenerate +
     re-run the baseline CSV for comparison.

**Exit criteria:**

- Baseline CSVs committed for all consumer packages.
- Bridge-file snapshots committed under the generator's `doc/`.
- Pre-existing failures enumerated by test ID, confirmed
  reproducible.
- A per-package regen + test command documented, runnable by
  someone with no further context.

### Phase 1 — Port the remaining extractor features into `ElementModeExtractor` (1–2 sessions)

Goal: the element walker produces all the information bridges need.
Byte-identical is **not** required — we just need to cover every
feature the AST walker covers.

Work items:

1. Typedef alias preservation (W6). Add a `renderDartType` helper that
   checks `type.alias` and uses alias name + recursive type-arg
   rendering. Apply throughout the extractor (setter param, method
   param, return type, field type, enum method return).
2. Source-order sorting (B4). Add a `_sortMembersBySourceOrder` helper
   that concatenates getters/setters/methods/fields/constructors and
   sorts by `firstFragment.nameOffset`. Optional per-generator
   behavior flag — OFF by default until we confirm the emitter doesn't
   need source order.
3. Default-value handling (B2). Mirror reflection generator's
   `f15ae96`: primary `param.constantInitializer?.toSource()`, fallback
   `param.defaultValueCode`. `_defaultValueSource` in
   `element_mode_extractor.dart:385` already does this — verify, don't
   regress.
4. Annotation internal/deprecated checks (W1, W2, B3). Remove the
   `.toSource()` string fallback in `element_mode_extractor.dart:139–148`;
   it's already covered by the element flags.
5. Private typedef parity. Decide policy: AST today leaks
   `_PerformanceModeCleanupCallback`; element path filters it. Pick the
   correct behavior (element is likely correct — private is private)
   and document.

Exit criteria: `ElementModeExtractor.extract(library, path)` + the
existing emitter produces bridges that **compile** for
`tom_d4rt_flutterm` (`dart analyze` clean on the generated output).
Test baselines are not yet checked — Phase 2 routes execution through
this path, Phase 3 closes the remaining gaps.

### Phase 2 — Route BridgeGenerator through the element walker unconditionally (1 session)

- Drop the filter-exclusion path. In `bridge_api.dart:147–171` and
  `v2/d4rtgen_executor.dart:188–212`, stop calling
  `filterSummariesForBridgedPackages`. Every package reads from its
  `.sum` bundle; zero exclusions.
- Replace the `getResolvedLibrary` + `ResolvedLibraryResult` /
  `NotPathOfUriResult` branch at `bridge_generator.dart:3813–3873`
  (and the fallback sites at 3969, 4064–4118, 4122–4161) with a single
  call sequence: `context.currentSession.getLibraryByUri(uri)` →
  `ElementModeExtractor.extract(library, path)`.
- Keep `_ResolvedClassVisitor` in the file but unreachable, gated
  behind an internal `useLegacyAstWalker` debug flag (for local
  bisect only). Do not ship this as a user-visible flag.

Exit criteria:

- `tom_d4rt_flutterm` regenerates end-to-end, `dart analyze` clean on
  the generated `.b.dart` files, and `testkit :test` for
  `essential_classes_test.dart` passes with **zero new failures vs.
  the Phase 0 baseline**.
- Bridge diffs against the Phase 0 snapshots are catalogued as a
  structured list (per-bridge-file summary of divergence classes:
  typedef expansion, member ordering, default-value shape) — feeds
  Phase 3.
- `important_classes_test.dart` and `secondary_classes_test.dart` are
  not yet required to pass at this phase; they become the Phase 3
  gate.

### Phase 3 — Close bridge-output diffs (1–3 sessions)

Iterate against the Phase 0 snapshot diffs, fixing implementation
gaps one class at a time:

- Typedef expansion regressions (resolve via W6 helper — already in
  Phase 1 but may miss edge cases: nullable typedef, typedef-of-
  typedef, generic typedef with type args).
- Member ordering — if diffs show unstable map iteration order, turn
  on source-order sort (B4) and verify diffs shrink.
- Default-value rendering — chase any `null` / `dynamic` regressions
  for summary-backed constants. Add unit tests under
  `test/` for representative patterns.
- Function-type parameter naming. Element returns `void Function(void)`
  where AST returned `void Function(void value)` — reconstruct param
  names from `type.formalParameters[i].name` when non-empty.

Exit criteria: **this is the primary success gate for the flutterm
migration.**

- `testkit :test` on each of the three flutterm gating suites produces
  a result column matching the Phase 0 baseline: same tests passing,
  same tests failing, zero new regressions:
  - `test/essential_classes_test.dart` — all baseline-passing tests
    still pass.
  - `test/important_classes_test.dart` — all baseline-passing tests
    still pass (the one pre-existing failure may stay failing).
  - `test/secondary_classes_test.dart` — all baseline-passing tests
    still pass (the one pre-existing failure may stay failing).
- Commit the per-phase baseline CSVs alongside the Phase 0 CSVs so
  the diff is reviewable.
- Cosmetic bridge-output differences (whitespace, key order in emitted
  maps, typedef expansion) are acceptable — they are explicitly
  non-gating.

### Phase 4 — Migrate ProxyGenerator (0.5–1 session)

ProxyGenerator (`proxy_generator.dart:170`) sets up its own
`AnalysisContextCollectionImpl` (194–207) and walks AST. It is a
small generator and its scope is tightly scoped to specific
classes listed in config.

- Replace AST traversal with element walking against
  `ClassElement.methods` / `.getters`. Reuse the helpers added to
  `ElementModeExtractor` in Phase 1. Extract into a shared helper
  module if natural.
- Feed it from the same analysis context as BridgeGenerator (share
  the collection, already loaded by the shared pipeline).

Exit criteria:

- All `D4rtCustomPainter`, `D4rtCustomClipper`, `D4rtFlowDelegate`,
  etc. proxies regenerate and compile.
- `tom_d4rt_flutterm` test baselines (essential/important/secondary)
  still match Phase 0; any consumer package whose tests exercise
  proxy-generated code (primarily `tom_d4rt_flutterm`) is re-run
  and compared.

### Phase 5 — Migrate user_bridge_scanner (0.5–1 session)

`user_bridge_scanner.dart` — 643-line `RecursiveAstVisitor<void>`.
Replace with `LibraryElement` walker. It reads
`@D4rtUserBridge` annotations and extracts method/member names.
No AST-only features required.

Exit criteria:

- User-bridge overrides continue to round-trip through generation.
- Consumer packages that define user-bridge overrides (primarily
  `tom_d4rt_flutterm` and any others flagged during Phase 0
  regen-transcript capture) re-run `testkit :test` with results
  matching the Phase 0 baseline.

### Phase 6 — Delete the AST path (1 session)

- Remove `_ResolvedClassVisitor` (13810–16015), `_ClassVisitor`
  (16063–…), `_parseParameters`, `_parseField`, `_parseMethod`,
  `_parseConstructor` AST variants, and the supporting helpers they
  call (`_collectTypeInfo` AST version, AST-based annotation helpers).
- Remove `summary_exclusion.dart` and its call sites. The filter is
  no longer needed because every package is summary-backed.
- Remove `TOM_D4RT_BRIDGE_USE_SUMMARIES` env-var scaffolding (if still
  present).
- Remove AST imports (`package:analyzer/dart/ast/*`) from files that
  no longer need them. Keep
  `package:analyzer/src/dart/element/element.dart` (for
  `ElementAnnotationImpl.annotationAst` when needed).

Exit criteria:

- `wc -l bridge_generator.dart` drops by at least 1,800 lines.
- `dart analyze` clean on `tom_d4rt_generator`.
- Regenerate bridges in `tom_d4rt_flutterm` and run `testkit :test`
  on the three gating suites — results match the Phase 0 baseline.
- Spot-check at least one non-flutterm consumer (recommended:
  `tom_d4rt_exec`, since it has the broadest bridge coverage) by
  regenerating + running its `testkit :test` and confirming the
  result column matches Phase 0. The full downstream sweep is
  deferred to Phase 7.

### Phase 7 — Publish and verify downstream (1 session)

This is the **final success gate**: every consumer package's test
baseline must match the Phase 0 baseline, not just the flutterm suites.

- Bump `tom_d4rt_generator` version in pubspec.
- `republish` per the project's publishing workflow
  (`_copilot_guidelines/dart/project_republishing.md`).
- Update the pubspec version constraint in every consumer that
  depends on the generator output:
  - `tom_d4rt_flutterm`
  - `tom_d4rt_dcli`
  - `tom_d4rt_exec`
  - `tom_dcli_exec`
  - `tom_d4rt` (test suite lives at `tom_d4rt/test/`; there is no
    `tom_d4rt_test` package)
- For each consumer in the list above, regenerate bridges using its
  documented regen command (captured in Phase 0's
  `baseline_summary_refactor.md`), then run `testkit :test` from the
  project root and compare the result column against the Phase 0
  baseline CSV.
- Exit criteria for each consumer:
  - Every test that passed in Phase 0 still passes.
  - No new failures are introduced. Pre-existing failures enumerated
    in Phase 0 may remain failing with the same test IDs.
  - The per-consumer result delta is captured in
    `tom_d4rt_generator/doc/baseline_summary_refactor.md` as a final
    migration report.
- Run the downstream flutter apps that use the generated bridges to
  confirm runtime behavior is unchanged.

---

## 6. Lessons to carry over from the reflection generator

1. **`AnalysisContextCollectionImpl` must receive both
   `sdkSummaryPath` and `librarySummaryPaths`.** Without
   `librarySummaryPaths` being non-null, `SummaryDataStore` is not
   created and SDK bundle registration silently no-ops. Check this
   in every entry point
   (`bridge_api.dart`, `d4rtgen_executor.dart`, `proxy_generator.dart`).
2. **Default values come from `constantInitializer`, not from a type
   check on `DefaultFormalParameter`.** That pattern is an Element-vs-
   AST type mismatch and silently returns null. Grep bridge_generator
   for `DefaultFormalParameter` during migration and replace every
   instance.
3. **Metadata from summaries is in
   `element.metadata.annotations` as deserialized `AnnotationImpl`
   nodes.** If any annotation-argument rendering is needed, use
   `ElementAnnotationImpl.annotationAst?.arguments?.toSource()` — the
   `annotationArgumentsSource` helper in
   `element_mode_extractor.dart:1071` already does this.
4. **Topological dependency ordering in summary generation matters.**
   The reflection generator uses Kahn's algorithm to analyze packages
   after their deps so summaries accumulate. Verify
   `tom_analyzer_shared`'s `SummaryCacheManager` does the same — if
   not, port.

---

## 7. Risks and mitigations

| Risk | Mitigation |
|---|---|
| Member-ordering diffs break downstream diff-based tests | Phase 0 baseline + per-phase diff checks; if ordering becomes load-bearing, use `nameOffset` sort (B4). |
| `DartType.getDisplayString()` differs from `.toSource()` for edge cases (nullable, FutureOr, function types with named params) | Unit-test every variant in `test/`. Reference reflection generator for working patterns. |
| Summary-backed `constantInitializer` is null for some parameters we rely on | Detect during Phase 3; add a targeted `element.computeConstantValue()?.toDartValue()` fallback. |
| A consumer package depends on an AST-only emitter feature I missed | Phase 7 runs the downstream app smoke tests. Keep the env-var bypass + `useLegacyAstWalker` flag available until Phase 6 exit. |
| Summary cache invalidation stale during rapid iteration | Use `rm -rf .tom/summary_cache/` if debugging; add a `--no-cache` CLI flag if absent. |

---

## 8. Out of scope

- Performance work beyond what the element-only path provides for free.
- Bridge emitter refactoring (generated-file templates, imports, etc.).
- Changes to the intermediate model (`ClassInfo`, `MemberInfo`, …).
- Relaxer generator changes — it's walker-agnostic.
- API changes to `tom_d4rt_generator`'s public surface
  (`bridge_api.dart`, `v2/d4rtgen_tool.dart`).

---

## 9. Entry-point cheat sheet

Use this as a map when reading the migration code:

- `bin/d4rtgen.dart` — CLI entry; calls `createD4rtgenExecutors()`.
- `lib/src/v2/d4rtgen_executor.dart:34` — `D4rtgenExecutor.execute`.
- `lib/src/v2/d4rtgen_executor.dart:162` — `_generateBridges` (v2
  orchestration of the three generators).
- `lib/src/bridge_api.dart:77` — `generateBridges` (programmatic API
  orchestration, same three generators).
- `lib/src/bridge_generator.dart:997` — `BridgeGenerator` class.
- `lib/src/bridge_generator.dart:3813` — library-resolve +
  visitor-dispatch loop (the site that branches on
  `ResolvedLibraryResult` vs `NotPathOfUriResult`).
- `lib/src/bridge_generator.dart:7615` — `_generateBridgeForClass`
  emitter (walker-agnostic; do not change).
- `lib/src/bridge_generator.dart:13810` — `_ResolvedClassVisitor`
  (the AST walker; to be deleted in Phase 6).
- `lib/src/element_mode_extractor.dart` — `ElementModeExtractor`
  (the element walker; promote to canonical path).
- `lib/src/proxy_generator.dart:170` — `generateProxies` (Phase 4).
- `lib/src/relaxer_generator.dart:109` — `generateRelaxers`
  (walker-agnostic; no work).
- `lib/src/user_bridge_scanner.dart` — user-bridge scanner
  (Phase 5).
- `lib/src/summary_exclusion.dart` — summary filter (delete in
  Phase 6).
