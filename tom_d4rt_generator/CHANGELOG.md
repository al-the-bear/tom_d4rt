## 1.15.3

### Fixed — a relative scan root emitted unrooted source URIs (GEN-125)

GEN-123 let `d4rtgen -s .` reach the analyzer; this fixes what it then wrote.
`_getPackageUri` maps a source file to the URI embedded in the generated
bridge, and every probe it uses looks for a **leading-separator** segment:

    normalizedPath.indexOf('/lib/')
    normalizedPath.indexOf('/test/')
    normalizedPath.contains('/sky_engine/lib/')

A relative path can never contain one, so `lib/tom_d4rt_cli_api.dart` matched
nothing and fell through to the raw-path fallback. The visible damage was in
`bridgeReExports()`, whose `source` is the key `registerLibraryReExport` looks
up when a script imports the barrel:

    - (source: 'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart', …)
    + (source: 'lib/tom_d4rt_cli_api.dart', …)

No importer can ever match `lib/…`, so every re-export declared by a barrel
regenerated from a relative scan root was silently dead.

This is GEN-123's rule at a second call site — *normalizing is not rooting* —
so the fix is the same shape: root a relative path against
`Directory.current` before the probes run. Only genuine filesystem paths are
rooted; callers that pass an already-resolved `package:`/`dart:` URI are left
alone, and the scheme test requires two or more characters before the colon so
a Windows drive prefix (`C:/Code/x`) still reads as a path.

Covered by `G-PURI-03` (relative path → package URI) and `G-PURI-04`
(resolved URIs pass through untouched).

## 1.15.2

### Fixed — a relative scan root silently dropped every user bridge (GEN-123)

`d4rtgen -s .` aborted on the one corpus project that carries user bridges:

    Error processing ./d4rt_userbridges_sample: Invalid argument(s):
      Only absolute normalized paths are supported: d4rt_userbridges_sample

The same command with `-s "$(pwd)"` succeeded, so the defect was never in the
project — it was that a relative project directory reached the analyzer.

The analyzer requires every path it is given to be **absolute and normalized**.
That is one rule with two independent halves, and it was written out by hand at
five call sites. Three of them satisfied only the second half:

    final normalizedProjectDir = p.normalize(projectDir);   // WRONG

`p.normalize` collapses `.` and `..`; it does not make a path absolute. The two
correct sites additionally joined against `Directory.current.path`. Only a
project carrying `lib/src/d4rt_user_bridges/` could trip it, because everywhere
else the context is built from an already-absolutised path.

Fixed by extracting `analysisIncludedPath()` (`lib/src/analysis_paths.dart`),
which states the whole contract once, and using it at every site. Applying it
turned up a **sixth** site the audit had missed — the per-package context in
`bridge_generator.dart`, which derives its root by walking up from a file path
and so inherits that path's shape.

**The first fix was incomplete, in the more dangerous direction.** Absolutising
`includedPaths` stopped the crash but merely moved the failure downstream:
`contextFor` and `getResolvedLibrary` were still handed relative paths, threw
the same `ArgumentError`, and the throw was swallowed by a `verbose`-gated
`catch`. A relative-root run then found **0** user bridges where an absolute
run found 4, and emitted bridges missing every override — no error, no warning,
wrong output. Three changes close that:

- The scan directories are derived from the *absolutised* root, so every
  collected file path is absolute by construction rather than by remembering to
  convert it at three later call sites.
- Resolution failures are no longer `verbose`-gated. A user-bridge file that
  exists on disk but does not resolve is a wrong-output condition, not a debug
  detail.
- Finding files but registering nothing now warns. Under the previous
  `> 0`-only reporting that state was indistinguishable from a project with no
  user bridges at all, which is precisely why the regression was silent.

### Changed — the two user-bridge pre-scans are one function

`bridge_api.dart` and `v2/d4rtgen_executor.dart` each carried their own ~60-line
copy of the pre-scan, differing only in log wording and in which warnings were
`verbose`-gated — which is how one copy came to swallow errors the other
reported. Both now call `preScanUserBridges()`
(`lib/src/user_bridge_prescan.dart`).

### Tests

`test/gen123_analysis_included_path_test.dart` (6 tests). G-GEN123-01..03 cover
the helper, including a behavioural check that the analyzer still *rejects*
`p.normalize(relative)` — so the suite cannot pass for the wrong reason if the
helper is ever reduced back. G-GEN123-06 pins the property the silent-zero
violated: a relative and an absolute project dir must find the *same number* of
user bridges. Asserting "does not throw" would have passed throughout the
broken window. G-GEN123-04/05 are structural gates: a seventh hand-derived
`includedPaths` argument, or a bare `p.normalize` on a project path, fails the
suite.

## 1.15.0

### Added — the generated bridge is now really analysed, not proxied (GEN-121)

`test/gen121_generated_output_analyze_gate_test.dart` generates a bridge into a
throwaway package and runs `dart analyze` on it, with no
`analysis_options.yaml` in a position to exclude the output.

This replaces a standing compromise. The GEN-119 smoke gate asserts a *property*
of the emitted file — every import URI must be absolute — because analysing an
emitted file standalone appeared unviable: without a package config, every
`package:` import fails too and the report is all noise (measured: 38 issues,
every one of them downstream of a missing import). The proxy caught the defect
that shipped, but GEN-120 then walked straight past it, so the gap was not
hypothetical.

Two things turn that noise into signal, and only the first is obvious:

- A synthesised `.dart_tool/package_config.json` beside the output. It is built
  by copying the generator's own resolved config — whose entries carry absolute
  `file://` roots and so stay valid anywhere — and appending the fixture package.
- A fixture that is a *real package*. The corpus under `test/fixtures/` is not:
  those files live outside any package `lib/`, so the generator cannot emit an
  import for the very types it bridges and no package config can rescue the
  output.

The fixture is created in `Directory.systemTemp`, and that is load-bearing
rather than tidiness: an ancestor `pubspec.yaml` in the workspace tree hijacks
resolution for anything nested under it. The identical fixture reports four
`URI_DOES_NOT_EXIST` errors under `<ws-root>/ztmp/` and zero in the system temp
directory, so a gate placed inside the tree would have been permanently and
invisibly red.

**Warnings fail the gate unless explicitly allowlisted.** `equal_keys_in_map` —
the GEN-120 defect — is a warning, not an error, so a gate that failed only on
errors would have been blind to the defect class that motivated it. The
allowlist is currently empty; the fixture analyses completely clean.

Two of the four tests assert that the gate *detects*, by feeding it known-bad
output: a bare-path import must be reported (`URI_DOES_NOT_EXIST`, the GEN-119
shape) and a duplicate map key must be reported (`EQUAL_KEYS_IN_MAP`, the
GEN-120 shape). Without them a silently-neutered gate would keep reporting green.
Verified against a real regression, not just injected strings: reverting the
GEN-120 fix in `bridge_generator.dart` turns the gate red, while the GEN-119
property suite stays green at 9/9 — the gap, demonstrated.

The GEN-119 property assertions are **kept**. They are cheap enough to run over
the whole fixture corpus; the analyze gate is heavier and runs on one fixture.

### Fixed — an extension declared in a `part of` file was registered twice (GEN-120)

`tom_dist_ledger`'s generated bridge carried

```dart
static Map<String, String> extensionSourceUris() {
  return {
    'DLLogLevelExtension': 'package:tom_dist_ledger/src/ledger_api/call_callback.dart',
    'DLLogLevelExtension': 'package:tom_dist_ledger/src/ledger_api/ledger_api.dart',
    ...
```

`DLLogLevelExtension` is declared in `call_callback.dart`, which is
`part of 'ledger_api.dart'`. The analyzer flags the duplicate map key
(`equal_keys_in_map`), but that is only the visible half: `bridgedExtensions()`
emitted the same extension twice as two complete
`BridgedExtensionDefinition` entries, and a duplicate element in a list literal
is perfectly legal Dart — nothing complained at all. Deduplicating the map alone
would have silenced the warning and left the double registration in place, so
the fix is at collection time.

The extension arrives by two routes that tag it with different URIs. The local
extractor sees it while extracting the parent library and tags it with the
parent's path; GEN-049 import discovery sees it again while extracting a file
that *imports* the parent, and tags it with
`extElement.firstFragment.libraryFragment.source.uri` — which for a
part-declared extension is the **part's** URI, not the library's. GEN-064's
dedupe key was `name|sourceUri`, so the two spellings read as two distinct
extensions and both survived.

The dedupe now canonicalises the URI through the `part of` → parent-library
resolver before keying on it, and pins that canonical URI onto the survivor.
The parent library is the only correct answer: a part file is not
independently importable, so its URI is useless to any consumer acting on it.

Deduplication also now prefers the copy carrying full `MemberInfo`. Import
discovery populates only `methodNames`, never `methods`, so keeping whichever
copy happened to arrive first could silently degrade callback wrapping
(GEN-052) depending on source-file ordering.

`test/gen120_part_declared_extension_test.dart` pins all of it, including an
anti-vacuity guard — "exactly one" passes just as happily when the extension
was dropped entirely as when it was correctly deduplicated.

## 1.14.0

### Fixed — auxiliary imports could be emitted as bare file paths (GEN-119)

`tom_dist_ledger`'s generated bridge carried

```dart
import 'lib/src/ledger_api/ledger_api.dart' as $aux_aux;
```

a project-relative path where a `package:` URI belongs. It resolves against the
*generated file's* directory, so it pointed at a file that does not exist —
while the very same library was correctly emitted as
`package:tom_dist_ledger/src/ledger_api/ledger_api.dart` a few lines above.
The `$aux_aux` prefix is the fingerprint: both prefix factories derive their
base name from a `package:` URI and fall back to the literal `aux` otherwise,
so a doubled token proves a non-package URI reached the factory.

The chain: `d4rtgen` is invoked as `d4rtgen -s .`, so `workspacePath` is
relative. The own package's `rootUri` in `.dart_tool/package_config.json` is
`../`, which normalised against a relative workspace path collapses to `.`.
`_getFilePathForPackageUri` therefore returned a relative path, and when the
requested type lived in a `part of` file (`DLLogLevel` in `call_callback.dart`)
the part-of resolver derived the parent path relatively too. `_getPackageUri`
maps a path back to a package by scanning for a `/lib/` segment — which a path
that *starts* with `lib/` does not have — and returns its input unchanged when
it cannot, so a bare path entered the auxiliary-import map and was written
verbatim.

Fixed in three layers:

- **Root cause** — `_packageRootSync` now returns an absolute path regardless of
  how `workspacePath` was spelled.
- **Guard** — the `part of` → parent-library resolver keeps the part file's own
  (importable) `package:` URI when the parent cannot be expressed as one,
  instead of propagating a bare path.
- **Last resort** — the auxiliary-import writer drops any import whose URI is
  neither `package:` nor `dart:`, with a warning. Dropping degrades loudly (an
  undefined prefix is a compile error at the use site) rather than silently
  shipping an import that resolves nowhere.

### Added — regen smoke gate for emitted import URIs

`test/gen119_auxiliary_import_uri_test.dart` regenerates five fixtures into a
temp directory and asserts that **every** emitted import URI is absolute
(`package:` or `dart:`). Analysing an emitted file standalone is not viable —
without a `package_config.json` every `package:` import would fail too — so the
gate asserts the property that actually separates good output from bad. The
defect shipped precisely because the consumer's `analysis_options.yaml` excludes
`lib/src/d4rt_bridges/**`, so `dart analyze` reported the project clean.

`G-GEN119-05` pins that `user_proxy_relaxer_source.dart` still drives the
auxiliary-import writer, so the gate cannot quietly become vacuous.

## 1.13.0

### Added — configurable `typeMappings` escape hatch + `additionalImports` (DGU3)

- New top-level `d4rtgen:` config keys mirroring upstream `GeneratorConfig`:
  - `typeMappings: Map<String,String>` — substitute an awkward source type with
    another type at emission time. Keyed by source type name (`SomeType`) or its
    exact nullable spelling (`SomeType?`); the value is emitted verbatim wherever
    that type would appear (parameters, fields, return types, and each type
    argument inside generics). Applied at the single type-resolution chokepoint
    (`_resolveTypeArgument`), so it covers bare types and generic arguments. The
    mapped type's own bridge registration is left intact.
  - `additionalImports: List<String>` — full `import` URIs added to every
    generated bridge file, pairing with `typeMappings` when a substitute type
    lives in a package the generator would not otherwise import.
- This is the config seam behind the "fix the generator, not the generated code"
  rule: a downstream package can resolve a hard-to-bridge type through
  `buildkit.yaml` instead of patching the generator. Both keys default to empty,
  so generated `*.b.dart` output stays byte-identical until a config opts in.
- Wired through `BridgeConfig` (field + constructor + `fromJson`/`toJson`/
  `copyWith`), the `BridgeGenerator` constructor, and both executor paths
  (`bridge_api.dart`, `v2/d4rtgen_executor.dart`).

### Added — generated-code-quality regression guards (DGU4)

- Cross-checked upstream 0.2.1's four generated-code-quality fixes against our
  output. Our analyzer-driven emitter produces **none** of the four
  anti-patterns (they targeted a heuristic generator): generic collection
  extraction is already well-formed, abstract classes already strip their
  generative constructors (GEN-051) and carry `isAbstract: true`, no redundant
  `?? null` is emitted, and a param named `key` keeps its *declared* type rather
  than being force-inferred. No production change was needed.
- Locked those properties in with `test/generated_code_quality_test.dart`
  (`G-DGU4-1..4`) + fixture so a future emitter change cannot silently
  reintroduce one.

## 1.12.5

### Changed — make the `tom_analyzer_shared >=0.7.2` floor authoritative on pub.dev

- RCJ3/RCJ6 bumped the `tom_analyzer_shared` constraint to `>=0.7.2` (SDK-version
  partitioned summary cache + transitive-dependency bundle invalidation), but the
  version published on pub.dev (1.12.4) still carried the old `>=0.6.0` floor, so
  a fresh consumer resolving this generator from pub.dev was only *allowed* — not
  *required* — to pick a fixed `tom_analyzer_shared`. This patch republish makes
  the `>=0.7.2` floor the authoritative constraint every downstream consumer
  inherits. No code change; hardening only. (RCL2)

## 1.12.4

### Fixed — silence GEN-079 warnings for `dart:async` SDK generics

- The relaxer generator only builds type-relaxing wrappers for *application-
  package* generics scanned from module barrels. `dart:core` collections
  (`List`/`Set`/`Map`/…) were already skipped silently, but the `dart:async`
  SDK generics that appear in bridged signatures — `FutureOr`,
  `StreamSubscription`, `StreamConsumer`, `StreamTransformer`, `EventSink`,
  `StreamSink` — were not, so each produced a noisy
  `No ClassInfo for generic base type "…"` / `… — skipping wrapper` warning
  even though the outcome (no wrapper) was correct and expected. These types are
  provided by D4rt's stdlib bridges (`tom_d4rt/lib/src/stdlib/async/`), not by
  relaxer wrappers; `FutureOr` is a union type, not a class, and can never be
  wrapped at all. The relaxer skip-set (renamed `_dartCoreGenericTypes` →
  `_sdkGenericTypesWithoutRelaxers`) now covers both families, so these SDK
  generics are skipped silently. No change to generated output. New regression
  coverage: `relaxer_sdk_generic_skip_test.dart`.

## 1.12.3

### Fixed — escape `$`-prefixed member names in *all* generated bridge maps

- Completes 1.12.2: the `$`-escaping was applied to the getter/setter function
  maps but not to the **signature maps** (`getterSignatures`, `setterSignatures`,
  `methodSignatures`, `constructor`/`static*` variants) nor the instance/static
  **method** and **static getter/setter** function-map keys. Those still emitted
  a raw `'$sectionId'` key (the signature *value* was already escaped), so a
  bridge for a class exposing a `$`-prefixed member still failed to compile with
  "Undefined name 'sectionId'". Every member-name map **key** now routes through
  `_escapeString`. Regression coverage added: G-CLS-7d (getter/setter signature
  keys) and G-CLS-7e (method map + signature keys) over a new `$compute()` method
  on the fixture.

## 1.12.2

### Fixed — escape `$`-prefixed member names in generated bridges

- Members whose name begins with `$` (e.g. a structural accessor deliberately
  named `$sectionId` to avoid colliding with a model field literally called
  `sectionId`) were emitted verbatim into the single-quoted, *interpolating*
  Dart string literals the bridge uses for its getter/setter/signature map keys
  and for the arg-name passed to `D4.extractBridgedArg*`. The unescaped `'$sectionId'`
  was read by the analyzer as an interpolation and failed to compile with
  "Undefined name 'sectionId'". `_escapeString` now escapes `$` (and the
  getter/setter map-key and setter-cast arg-name sites route their names through
  it), so the key is emitted as `'\$sectionId'` while the member *access* stays
  the raw identifier `.$sectionId`. Regression coverage: `class_bridge_generation_test`
  G-CLS-7a/7b/7c.

## 1.12.1

- Track our latest published components: `tom_analyzer_shared` floor raised to
  `>=0.6.0` (ToolCacheLocator shared tool-cache root), and all in-workspace
  dependencies now use lower-bound-only constraints (no upper cap) so
  `pub upgrade` resolves to our latest versions during active development.

## 1.12.0

### Added — emit static enum methods into `BridgedEnumDefinition` (GitHub issue #2)

- The enum extractor now collects an enum's **public static** methods (these
  were previously dropped) and emits them into a `staticMethods:` block on the
  generated `BridgedEnumDefinition`, dispatched on the enum **type** (not an
  instance receiver). This makes static factory/helper methods like
  `PageFormat.fromString(name)` reachable from interpreted code.
- Collection-typed static parameters reuse the existing coercion path via a
  parameterized receiver, so `D4.coerceList`/map coercion applies the same way
  it does for instance methods.
- Requires `tom_d4rt` `^1.11.0` (which accepts the new `staticMethods`
  parameter); the floor was raised accordingly.

## 1.11.0

### Lazy bridge factories (import-optimization)

- Generated per-package bridges now emit **factory thunks** instead of a
  pre-built `List<BridgedClass>`:
  - `static Map<String, BridgedClass Function()> bridgeClassThunks()` — class
    name → deferred factory that builds one class's member maps + adapter
    closures on demand.
  - `static Map<String, Type> bridgeClassTypes()` — class name → native `Type`,
    so the same thunk registers into both the name-keyed and type-keyed
    registries with the correct `sourceUri`.
  - `registerBridges` now loops the thunks through the interpreter's
    `registerBridgedClassLazy(name, type, thunk, importPath, sourceUri:)`
    instead of constructing every `BridgedClass` eagerly. A script that uses
    N of M generated classes materializes ≈N objects, not M.
  - `bridgeClasses()` is retained (eager, diagnostic) for callers that still
    want the full materialized list.
- The aggregator barrel (`per_package_orchestrator`) now spreads
  `bridgeClassThunks()` / `bridgeClassTypes()` from each per-package bridge.
- Bumped `tom_d4rt` constraint to `^1.9.0`: the generated `registerBridges`
  targets the import-optimization API (`registerBridgedClassLazy`) introduced
  in `tom_d4rt` 1.9.0 / `tom_d4rt_ast` 0.1.9.

## 1.10.0

### Analyzer 10 migration

- Upgraded `analyzer` to `^10.0.0` (from `^8.4.1`). Applied the analyzer-10 API
  renames the generator relied on:
  - `AnalysisContextCollectionImpl(..., packagesFile: …)` →
    `packageConfigFile: …` (constructor parameter rename) in
    `bridge_generator.dart`.
  - `NamedType.name2` → `NamedType.name` in `corpus_type_scanner.dart`.
  - Tidied a now-flagged null-aware spread (`...?externalClassLookup`) in
    `bridge_generator.dart`.
  `Element.isSynthetic` remains deprecated-but-functional under analyzer 10; it
  is left in place because this package already sets
  `deprecated_member_use: ignore` project-wide, so no per-call migration was
  needed.
- Bumped `tom_d4rt` to `^1.8.25` (first analyzer-10 build on pub.dev; earlier
  `1.8.x` carry `analyzer ^8` and would conflict) and `tom_analyzer_shared` to
  `^0.4.0`.
- Stale analyzer-8 `.sum` summary bundles under `example/d4/.tom/analyzer-cache/`
  are undecodable by analyzer 10's `bundle_reader` (`RangeError` in
  `_decodeVariance`) and were poisoning the test suites. Added a `.gitignore`
  for `**/.tom/analyzer-cache/` and untracked the 92 regenerable bundles; they
  rebuild on demand under the active analyzer.

> **Incorporates 1.9.9** (published out-of-band, skipping local's 1.9.8): the
> `tom_analyzer_shared ^0.3.0` shared-tool-cache change (analyzer summaries
> resolved via `ToolCacheLocator` into the shared Tom tool-cache directory) is
> superseded here by the `^0.4.0` constraint, so its behaviour is retained. This
> release also carries the 1.9.8 const-arg suppression that 1.9.9 omitted.

## 1.9.8

### Generation quality (suppress unavoidable const-arg warning)

- Bridge `.b.dart` files emit constructor calls that forward script-supplied
  runtime values into `const` constructors (e.g. `IconData(codePoint, …)`).
  Because those arguments are only known at run time they can never be const,
  so the analyzer reports `non_const_argument_for_const_parameter` — an
  unavoidable, cosmetic warning for bridged code. Added
  `non_const_argument_for_const_parameter` to the generated
  `// ignore_for_file:` directive so regenerated bridge surfaces analyze
  cleanly (previously surfaced as 3 warnings against `IconData` in
  `widgets_bridges.b.dart` for both `tom_d4rt_flutter` and
  `tom_d4rt_flutter_ast`).

## 1.9.7

### Bug fixes (AllBridge import surface dropped under single-package inline)

- **GEN-077** — the generated dartscript helper calls
  `AllBridge.getImportBlock()` and `AllBridge.subPackageBarrels()`
  unconditionally, but the AllBridge emitter gated both methods behind
  `if (importBlockUri != null)` while `sourceLibraries()` was always emitted.
  In the single-package inline strategy (`sourceImport` unset, so
  `importBlockUri` resolves to `null`), AllBridge declared `sourceLibraries()`
  but neither `getImportBlock()` nor `subPackageBarrels()` — and the
  `dartscript.b.dart` half that calls them still compiled, breaking downstream
  consumers (`tom_brain_procedure`, `tom_brain_run`, Observatory) with
  "method isn't defined" errors after regeneration. The emitter now writes
  both methods unconditionally: when there is no resolved barrel URI it derives
  the import block straight from the canonical `sourceLibraries()` URIs and
  returns an empty `subPackageBarrels()`. Adds the GEN-077 regression tests
  (G-ISS-37/38/39) that force `importBlockUri == null`.

## 1.9.6

### Bug fixes (empty-Set default coercion)

- **GEN-SET** — a `Set` parameter whose default was a bare `const {}` (e.g.
  `TomCommandParser({Set<String> additionalCommands = const {}})`,
  `ParsedCommand({Set<String> flags = const {}})`) emitted the default
  unchanged. Dart parses bare `const {}` as an empty **Map** (static type
  `Object`), so the generated constructor call failed with
  `argument_type_not_assignable` ("The argument type 'Object' can't be
  assigned to the parameter type 'Set<String>'") — visible at
  `dart compile exe` and `dart analyze`, and the cause of broken
  `tom_build_cli` bridge calls after regeneration. `_getTypedDefaultValue`
  now has a `Set` branch (checked before `Map`) that renders both bare and
  already-typed empty-set defaults as `const <T>{}`, covering the named and
  positional coercion paths. Adds the GEN-SET-1/GEN-SET-2 regression tests.

## 1.9.5

### Bug fixes (AOT-only bridge compile defects)

Two defects surfaced by `tom_core_d4rt`'s bridge corpus, visible only at
`dart compile exe` (masked from `dart analyze` by the generated
`ignore_for_file` header):

- **B3b** — generic methods whose callback parameter returns the method's
  own type parameter (e.g. `FutureOr<T> Function(MySQLConnection)` in
  `MySQLConnectionPool.withConnection<T>` / `transactional<T>`) failed with
  `FutureOr<Object?> Function(X) can't be assigned to
  FutureOr<Object> Function(X)`: the callback wrapper resolves `T` to
  `Object?` but generic inference picked a non-nullable `Object`. The
  generated method call now pins explicit type arguments (each parameter's
  bound, or `Object?` when unbounded) via `_methodCallTypeArgs` when a
  function-typed parameter references the method type parameter, bypassing
  inference.
- **B4** — package-URI resolution used a hardcoded sub-workspace
  `searchDirs` list that omitted `distributed/`, so `part of` files in
  packages outside that list were imported directly ("has a 'part of'
  declaration"). Resolution now goes through
  `.dart_tool/package_config.json` (`_packageRootSync`) first, covering
  every package in the resolution graph, with the directory scan kept as a
  fallback.

Also removes leftover GEN-060 debug prints. Adds the G-CB-13 regression
test.

## 1.9.4

- Housekeeping: test artifacts now live in a gitignored `testlog/` folder; `doc/` no longer ships machine-generated baselines or last_testrun.json. No code changes.

## 1.9.3

### Generated-code hygiene
- Emit expanded `// ignore_for_file:` headers in generated `*.b.dart` bridges
  so generated bridge corpora (including `tom_d4rt_flutter`) are analyzer-clean
  without per-file hand edits.

### Documentation
- Consolidated proxy/relaxer manual-intervention guidance into
  `doc/user_proxy_relaxer_annotations.md` and the baseline docs; README
  aligned with the source-primary documentation reframe.

## 1.9.2

### Generator features
- Annotation-driven proxy/relaxer directive core + scanner (`@D4rtUserProxy` /
  `@D4rtUserRelaxer`) with a variant-pattern engine.
- Template families: B3 generic-constructor reifiers, A4 RenderBox-proxy,
  super-constructor-arg capture factories, generic-type-arg proxy variants,
  State-proxy mixin variants, generic interceptor re-dispatch.
- `genericInterceptors` config wired into `BridgeConfig`; VM↔web
  signature-skew coercion table.
- `yieldVoidCallbacks` switch for cooperative input/frame yield (OPEN B.14):
  void callback wrappers emitted as async closures awaiting a 1ms delay.
- Per-symbol `@Deprecated` allowlist; opt-in `vector_math_64` bridge.

### Dependency
- Require `tom_d4rt ^1.8.21`.

## 1.9.1

### Fix — build_runner path emits a compiling `dartscript.b.dart`
The build_runner / orchestrator code path previously produced a
`dartscript.b.dart` that could not compile, because:

- the delegating barrel (`<Module>Bridge`) was missing the
  `subPackageBarrels()` method the shared dartscript template calls
  unconditionally, and
- `relaxers.b.dart` (imported by the dartscript template whenever the
  config has modules) was never generated on the build_runner path.

Both halves are fixed: the orchestrator's delegating barrel now emits
`subPackageBarrels()` (primary package excluded, sub-package barrel URIs
listed), and the build_runner path now generates `relaxers.b.dart` —
falling back to a resolvable no-op stub (`registerRelaxers()` /
`registerGenericConstructors()`) when there are no extraction sites. The
standalone/CLI and build_runner paths now emit interchangeable
registration code. Covered by a new regression test
(`test/build_runner_dartscript_compile_test.dart`) that assembles the
build_runner artifacts and asserts `dart analyze` reports no errors.

## 1.9.0

### Refactoring — summary-backed extraction migration (Phases 1–6)
Completes the multi-phase migration from dual-path (AST + element) bridge
extraction to a single element-mode code path backed by analyzer `.sum`
summaries. See `doc/summary_refactoring_plan.md` for the full plan and
`doc/baseline_summary_refactor.md` for the regression oracle.

- **Phase 1**: `ElementModeExtractor` reaches output parity with the legacy
  AST `_ResolvedClassVisitor` (type aliases, inheritance resolution,
  default values, metadata, inherited members, substitution).
- **Phase 2**: `BridgeGenerator` routes every package through the element
  walker by default; summary-cache stage runs before scanning so external
  deps resolve from `.sum` bundles.
- **Phase 3**: Default-value rendering and annotation-arg serialization
  unit tests lock the extractor API.
- **Phase 4**: `ProxyGenerator` migrated to the shared element-mode path.
- **Phase 5**: `UserBridgeScanner` migrated to `LibraryElement` walker;
  legacy `RecursiveAstVisitor<void>` path removed.
- **Phase 6**: Deleted the AST extraction path entirely —
  `_ResolvedClassVisitor` (~2,200 lines), `_ClassVisitor`, `_ParsedClass`,
  the `useLegacyAstWalker` debug flag, and `summary_exclusion.dart`.
  `lib/src/bridge_generator.dart` dropped from 16,678 → 13,602 lines
  (−3,076 lines vs the plan's ≥1,800-line target). `TOM_D4RT_BRIDGE_USE_SUMMARIES`
  env-var scaffolding removed.

### Maintenance
- Update dependency on tom_d4rt 1.8.19 (type matching, enum handling,
  isSubtypeOf, stdlib fixes) — carried over from 1.8.24.

### Compatibility
- Public generator API is unchanged. Generated bridge output for
  `tom_d4rt_flutterm` is byte-identical to the pre-migration baseline
  modulo the `Generated: <timestamp>` header (per Phase 6 exit check).
- All five consumers documented in `baseline_summary_refactor.md`
  (flutterm, dcli, exec, dcli_exec, tom_d4rt) match their Phase 0
  test baselines — no new regressions.

## 1.8.24

### Maintenance
- Update dependency on tom_d4rt 1.8.19 (type matching, enum handling, isSubtypeOf, stdlib fixes)

## 1.8.23

### Bug Fixes
- **RC-2**: Fix inline function types with type params (e.g., `Object? Function(T)`) — cast to `dynamic` to bypass static type checking since analyzer expands typedef aliases to inline form which can't be cast back to the typedef
- **RC-2**: This fixes the remaining 3,208 compile errors in flutter_relaxers.b.dart (total error reduction: 441,443 → 0)

## 1.8.22

### Bug Fixes
- **RC-2**: Comprehensive fix for generic constructor param type handling — reduced compile errors from 441K to 3K (99.3%)
- **RC-2**: Extended `_rc2SkipTypes` with `FutureOr`, type param names (T/E/K/V/R/S), and vector_math types
- **RC-2**: Improved `isTypeParamTyped` to detect types containing type params (e.g., `MessageCodec<T>`)
- **RC-2**: Fixed bounded type params — `Object` bound now correctly excludes `dynamic` fallback
- **RC-2**: Add `!` assertion for non-nullable params since extraction produces nullable values
- **RC-2**: Proper type substitution and casting for params containing type params

## 1.8.21

### Bug Fixes
- **RC-2**: Fix nullable param passing in `_writeRC2Case()` — add `!` assertion for required non-nullable params
- **RC-2**: Add missing types to `_rc2SkipTypes` (meta annotations, vector_math types not imported in relaxer output)

## 1.8.20

### Features
- **UserBridge**: CLI executor now scans `lib/src/d4rt_user_bridges/` and `lib/d4rt_user_bridges/` directories for user bridge classes

### Bug Fixes
- **Off-by-one**: Fix `_getPackageUri()` sky_engine parsing producing `dart:i` instead of `dart:ui`

## 1.8.19

### Bug Fixes
- **RC-2**: Wire `registerGenericConstructors()` and `registerRelaxers()` into dartscript registration
- **RC-5**: Fix 11 misleading comments in annotation filtering (actual: @internal/@visibleForOverriding/@mustBeOverridden only)

## 1.8.18

### Bug Fixes
- Minor internal refactoring

## 1.8.17

### Features
- **GEN-100d**: Auto-generate function typedef registrations from source
- **GEN-083**: Proxy/adapter class generator for abstract delegates (CustomPainter, CustomClipper, etc.)
- **GEN-082**: Setter `sourceFilePath` fix + resolved 14 skipped and 3 failed tests
- **GEN-081**: Generator now emits `isAssignable` callback in `BridgedClass` constructors

### Bug Fixes
- **GEN-100**: Follow-up fix for secondary_classes_test failures
- Auto `dart pub get` for barrel resolution
- Pass `d4rtImport` from config in `generateBridges()`
- Dart format cleanup

## 1.8.16

### Bug Fixes
- **RC-4**: Generator map key unwrap via `D4.extractBridgedArg` instead of raw cast

## 1.8.15

### Bug Fixes
- **GEN-075**: Fixed required nullable argument handling — generates null-safe parameter extraction
- **GEN-076**: Raised non-wrappable default threshold from 4 to 8 to reduce combinatorial explosion

## 1.8.14

### Bug Fixes

- **GEN-077**: Skip same-package re-exports to prevent duplicate bridge generation (e.g., Tween only in animation module)
- **GEN-078**: Collect deprecated non-function type aliases (e.g., `MaterialStateProperty`)

## 1.8.13

### Added

- **GEN-074** (`bridge_generator.dart`) — Added support for type aliases (non-function typedefs) bridging:
  - New `visitGenericTypeAlias` in `_ResolvedClassVisitor` collects type aliases like `typedef MaterialStateProperty<T> = WidgetStateProperty<T>`
  - Generated `classAliases()` method returns a map of alias name to target class name
  - `registerBridges()` now automatically registers class aliases with the interpreter
  - Enables D4rt scripts to use type aliases like `MaterialStateProperty` that resolve to their target classes

### Tests

- **`gen074_type_alias_test.dart`** — Unit tests for type alias detection and code generation (8 tests)

## 1.8.12

### Fixed

- **GEN-073** (`bridge_generator.dart`) — Added `Iterator` to the list of built-in types that don't need import prefixes. This fixes compile errors in generated code where `Iterator<E>` was incorrectly prefixed with Flutter imports (e.g., `$flutter_3.Iterator`).

## 1.8.11

### Fixed

- **GEN-072** (`bridge_generator.dart`) — Fixed export detection bug where a direct export (no show/hide clause) didn't override a restrictive re-export from the same package when processed in wrong order. This caused classes like Flutter's `Curves` to be incorrectly marked as "not exported from barrel file" even though they were directly exported. The fix adds `isCurrentMorePermissive && !isExistingMorePermissive` check to `shouldOverride` logic.

### Added

- **`gen072_permissive_override_test.dart`** — Unit tests for GEN-072 fix, verifying permissive exports override restrictive same-package re-exports.

## 1.8.10

### Fixed

- **GEN-071** (`bridge_generator.dart`) — Fixed required nullable parameters incorrectly rejecting null values. Parameters marked as `required` + nullable now correctly accept explicit null.

## 1.8.9

### Fixed

- **`bridge_generator.dart`** — Minor fixes and improvements to bridge generation.

## 1.8.8

### Added

- **`bridge_generator.dart`** — Dynamic member dispatch for ~24 Flutter access-restricted members (e.g. `initState`, `dispose`, `build`, `activate`) using `(t as dynamic).member` fallback to avoid compile errors in generated bridge code.
- **`bridge_generator.dart`** — Protected override filtering: skips unannotated overrides of protected/visibleForTesting base methods.
- **`bridge_generator.dart`** — Extended `ignore_for_file` directive with `implementation_imports`, `sort_child_properties_last`, `non_constant_identifier_names`, `avoid_function_literals_in_foreach_calls`.
- **`file_generators.dart`** — Added `ignore_for_file: avoid_print` to generated test runner files.

### Fixed

- Callback wrapper return cast: only skips redundant `as Object?` cast when original return type is `dynamic`/`Object`/`Object?`, preventing type errors on typed callbacks.

## 1.8.6

### Changed

- Updated `tom_build_base` dependency from `^1.7.1` to `^2.5.2`.

## 1.8.5

### Added

- **`bridge_config.dart`** — New `d4rtImport` field on `BridgeConfig` to configure the D4rt runtime import path. Defaults to `package:tom_d4rt/d4rt.dart`. Enables generating bridges for alternative runtimes (e.g. `package:tom_d4rt_exec/d4rt.dart`).
- **`d4rtgen_tool.dart`** — Added `worksWithNatures: {DartProjectFolder}` to tool definition.

### Changed

- **`bridge_generator.dart`** — Uses configurable `d4rtImport` instead of hardcoded `package:tom_d4rt/d4rt.dart` import.
- **`file_generators.dart`** — Dartscript file generator uses `config.d4rtImport` for the runtime import.
- **`per_package_orchestrator.dart`** — Minor formatting cleanup.
- **`d4rtgen_executor.dart`** — Minor formatting cleanup.
- Renamed `version.g.dart` → `version.versioner.dart`.

## 1.8.4

### Bug Fixes
- **GEN-070**: Fixed barrel export bug for multi-chain re-exports — when a symbol is exported through multiple barrel chains (e.g., `Find` class via direct dcli_core export AND indirect find.dart re-export), the show clauses are now unioned instead of the second chain being blocked by the visited set

### Tests
- Added `gen070_reexport_show_test.dart` with 3 tests for multi-chain re-export scenarios
- All 464 tests pass

## 1.8.3

### Architecture
- **v2 ToolRunner migration**: Refactored d4rtgen CLI to use v2 ToolRunner framework (`D4rtgenTool`, `D4rtgenExecutor`) for better code organization and testability

### Bug Fixes
- **GEN-064**: Fixed duplicate extension keys in generated bridge files — extensions are now deduplicated by fully qualified key before generation
- **GEN-065**: Fixed type resolution for cross-file references — types defined in one file but used in another now correctly resolve prefixes
- **GEN-066**: Fixed extension target resolution when the target type is parameterized with types from other files
- **GEN-067**: Fixed resolution of types in generic bounds that reference cross-file definitions
- **GEN-068**: Fixed method return type resolution when the return type is from a different source file than the method declaration
- **GEN-069**: Fixed parameter type resolution for callbacks and function types that reference cross-file types

### Tests
- Added `cross_file_type_resolution_test.dart` with 132 lines of new test coverage
- Added `d4rtgen_traversal_test.dart` with 236 lines validating v2 traversal logic
- All 461 tests pass

## 1.8.2

### Republish
- Republish with all 1.8.1 fixes (previous publish failed to complete)

## 1.8.1

### Bug Fixes
- **GEN-058**: Fixed nullable generic type resolution — types like `List<RuntimeType>?` now correctly retain the `?` suffix when resolved through `_resolveGenericTypeWithPrefixes`
- **GEN-059**: Fixed extension filtering — extensions whose target type (`onTypeName`) isn't among bridged classes/enums or built-in types are now filtered out before generation, preventing runtime errors for unresolvable extension targets
- **Multi-barrel registration**: Added `subPackageBarrels()` static method to bridge classes and registration loop in dartscript.b.dart. This enables imports like `import 'package:dcli_core/dcli_core.dart'` to work when the primary package is `dcli` — the module loader now finds content under sub-package URIs
- **Content-based barrel filtering**: `getImportBlock()` and `subPackageBarrels()` now use content-based filtering (derived from actual bridged class/enum/function/extension source URIs) instead of type-reference-based filtering. This prevents including packages that are only type-referenced but not bridged (e.g., crypto with skipReExports)

## 1.8.0

### Architecture
- **Direct source file imports**: Generator now imports source files directly (`import 'package:<pkg>/<path>.dart' as $<pkgname>_<N>`) instead of relying solely on barrel exports. This resolves issues with types not being accessible through barrel files and eliminates prefix collisions across packages.

### Bug Fixes
- **GEN-055/056**: Fixed type dependency resolution and extension on-type URI resolution for cross-package types
- **GEN-057**: Fixed return type bridging and prefix stripping in API surface dependencies — return types now correctly use the source file's own import alias
- **Part-of files**: Fixed prefix resolution for `part of` files and extensions whose on-type comes from a different package
- **G-DCLI-05/07/08/11/12/13/14**: All DCli bridge issues resolved — show/hide clause propagation, callback bridging, and DCli-specific type handling

### Tests
- Updated 46 test expectations to match new direct source import generation patterns (`$<pkgname>_<N>` prefixes and `D4.callInterpreterCallback`)
- All 444 tests pass

## 1.7.0

### Bug Fixes
- **G-DCLI-07/11: Show/hide clause propagation**: Fixed export parsing to properly propagate show/hide clauses when following re-exports. When a barrel file re-exports from another package with a `show` clause (e.g., `export 'package:dcli_core/dcli_core.dart' show FindItem`), nested exports now correctly filter symbols. This fixes cases where dcli's `find()` was incorrectly bridged from dcli_core (callback-based) instead of dcli's own version (returns `FindProgress`).
  - Added `mergeWithParent()` method to `ExportInfo` for clause merging
  - Added `parentShowClause`/`parentHideClause` parameters to `parseExportFiles()`
  - Show clauses merge via intersection; hide clauses merge via union

## 1.6.1

### Bug Fixes
- **SDK path detection**: Compiled d4rtgen binaries now correctly locate the Dart SDK. The analyzer's default SDK detection fails for compiled binaries because `Platform.resolvedExecutable` returns the binary path instead of the Dart executable. Added `_getSdkPath()` method that checks `DART_SDK` environment variable first, then derives SDK from `dart` in PATH (handles Flutter's embedded SDK structure).

## 1.6.0

### Features
- **Record type support (G-TYPE-1, G-TYPE-2)**: Full support for Dart records as function parameters and return types. The generator emits inline conversion code:
  - Parameters: `InterpretedRecord` → native Dart record at call sites
  - Returns: Native Dart record → `InterpretedRecord` for interpreter access
  - New helpers: `_isRecordType()`, `_parseRecordType()`, `_generateRecordParamExtraction()`, `_generateRecordReturnWrapper()`

### Bug Fixes
- **G-TE-1**: Added `sourceFilePath` parameter to global function type resolution. Type bounds in generic parameters now resolve correctly for global functions.
- **G-TE-2**: Fixed type erasure test expectations — import prefixes for non-barrel-exported types now correctly use auxiliary prefixes.
- **G-OP-8**: Fixed barrel export collision — `Point` class now exports from `run_static_object_methods.dart` (which has `operator ==`, `hashCode`, `toString`) instead of `run_constructors.dart`.
- **GEN-045**: Barrel name collision for constrained mixins resolved as side effect of G-OP-8 fix.

### Tests
- All 431 tests now pass (was 430 pass, 1 fail)
- Full dart_overview coverage suite validated

## 1.5.2

### Bug Fixes
- **GEN-049**: Extension methods on bridged classes from imported libraries are now discovered. The generator walks the import tree of each source file to collect extensions from imported packages. This enables D4rt scripts to call extension methods from packages like `package:collection` when they are in scope.
- **GEN-048**: Pure `mixin` declarations are now bridged. Previously only `mixin class` declarations were handled. Mixins are bridged as abstract classes without constructors, including their methods, getters, setters, and fields.
- **GEN-020**: Global exclusions no longer merge across modules. Each module's exclusions now apply only to packages belonging to that module, preventing accidental cross-filtering.
- **GEN-046**: GlobalsUserBridge overrides now work correctly. Fixed example project annotations and method signatures. The generator already correctly wired up overrides—the issue was missing `@D4rtGlobalsUserBridge` annotations in user code.
- **GEN-007**: Expanded `_knownFunctionTypeAliases` from 7 to ~50 common function type aliases. Now covers D4rt, Dart core, Flutter, and async package types for better function type detection in syntactic fallback.
- **GEN-009**: Improved `_isGenericTypeParameter()` heuristic to recognize multi-character type parameter patterns like `T1`, `T2`, `K2`, `V2` and `TValue`, `TOutput`, `TState`, etc. Eliminates false "Missing export" warnings.
- **GEN-021**: Verified this issue is already resolved — no builder-skip logic exists in the current codebase.
- **GEN-011**: Global function/variable generation counts now report actual values instead of hardcoded 0.
- **GEN-013**: Verified already resolved — approximate class count (files × 10) pattern no longer exists.
- **GEN-019**: Barrel preference now prioritizes primary barrel (`barrelImport`) over same-package barrels for consistent `$pkg` prefix usage.
- **GEN-008**: Expanded `mapPrivateSdkLibrary()` from 6 to 20+ entries covering common SDK private libraries. Added optional warning callback for unknown libraries.
- **GEN-025**: Enhanced record type resolution to handle named field groups `({int x, String y})` and mixed positional/named fields.
- **GEN-027**: Added explicit `InvalidType` handling in `_collectInfoFromDartType()` to gracefully skip analyzer resolution failures.

### New Features
- `_collectExtensionsFromImports()`: New function that walks library imports and collects visible extensions
- `visitMixinDeclaration()`: Added to both visitors to handle pure mixin declarations
- `_getExclusionsForPackage()`: New helper that returns exclusions scoped to a package's owning modules
- Verbose mode shows `GEN-049: Discovered extension {name} on {type} from import {uri}` messages

### Example Fixes
- `userbridge_override`: Added missing `@D4rtGlobalsUserBridge` and `@D4rtUserBridge` annotations
- `userbridge_override`: Fixed `MyListUserBridge` operator override signatures

### Tests
- Added `test/import_extension_discovery_test.dart` — 5 tests for import-based extension discovery
- Added `test/fixtures/external_extensions.dart` and `test/fixtures/imports_external_extensions.dart` test fixtures
- Added `test/mixin_bridge_generation_test.dart` — 12 tests for mixin bridging
- Added `test/fixtures/mixin_test_source.dart` test fixture with pure mixin declarations

## 1.5.1

### Documentation
- **Config filename standardization**: Updated all documentation references from `tom_build.yaml` to `buildkit.yaml`. All CLI help text, README, user guides, and code comments now use the current filename.

### Internal
- `d4rt_gen.dart`: CLI help text and print statements reference `buildkit.yaml`
- `_printBuildYamlSection()`: Uses `TomBuildConfig.projectFilename` constant
- `BuildConfigLoader`: Updated doc comments

### Dependencies
- Updated `tom_build_base` to `^1.3.2` (buildkit.yaml references)

## 1.5.0

### Features
- **Test infrastructure**: New `testing.dart` library with `D4rtTester` — run D4rt test scripts that verify bridge correctness by executing DartScript code against real bridges.
- **D4rtTestResult**: Structured pass/fail/skip/error results with detailed assertion messages for programmatic test evaluation.
- **IssueTestHelper**: Specialized test helper for writing regression tests against known generator issues (GEN-xxx).
- **94 D4rt test scripts**: Comprehensive test coverage across 6 example projects — constructors, fields, methods, operators, generics, inheritance, parameters, async, enums, and UserBridge overrides.
- **Test coverage documentation**: `doc/test_coverage.md` with feature inventory across 10 categories.

### Refactoring
- **CLI scanning replaced with ProjectDiscovery**: Eliminated ~200 lines of manual directory traversal in `d4rt_gen.dart`, replaced with `ProjectDiscovery.resolveProjectPatterns()` and `scanForProjects()` from `tom_build_base`.
- **Removed dead CLI code**: Deleted unused `d4rt_generator_cli.dart` (274 lines) and `cli.dart` barrel export.
- **Shared YAML utilities**: Replaced private `_yamlToJson`/`_yamlListToJson` in `BuildConfigLoader` with shared `yamlToMap()` from `tom_build_base`.

### Documentation
- Expanded `doc/issues.md` to 46 documented issues (GEN-001 through GEN-046).
- Added `doc/test_coverage.md` — full bridge generator feature inventory with pass/fail status.
- Added project-level `_copilot_guidelines/testing.md`.

### Dependencies
- Updated `tom_build_base` to `^1.2.0` (adds `yamlToMap`/`yamlListToList` utilities).

## 1.4.0

### Features
- **CLI: buildkit.yaml support**: The `d4rtgen` CLI now reads configuration from `buildkit.yaml` files (in addition to `build.yaml` and `d4rt_bridging.json`), using the shared `tom_build_base` infrastructure.
- **CLI: Multi-project and glob support**: `--project` option now accepts comma-separated lists and glob patterns (e.g., `--project=tom_*_builder,xternal/tom_module_*/*`).
- **CLI: `--list` flag**: List discovered projects without generating bridges.
- **CLI: ProjectDiscovery integration**: Proper scan vs recursive semantics — scans directories until a project boundary, recursive mode also looks inside projects for nested subprojects.
- **Known issues documentation**: Comprehensive `doc/issues.md` documenting 30 known issues and limitations with concrete cause→effect examples from real generated bridge code.

### Bug Fixes
- **Multi-barrel registration (GEN-030)**: Modules with multiple barrel files (e.g., `dcli.dart` + `dcli_core.dart`) now register bridges under ALL barrel import paths. Previously only the primary `barrelImport` was registered, causing `SourceCodeException: Module source not preloaded for URI` when scripts imported secondary barrels.
- **CLI export filtering params (GEN-028)**: CLI code path now passes `followAllReExports`, `skipReExports`, `followReExports`, and `excludeSourcePatterns` from module config to the generator. Previously these were silently ignored, causing the CLI to follow all re-exports regardless of configuration.
- **CLI global export filtering (GEN-029)**: CLI code path now filters global functions, variables, and enums by barrel export show/hide clauses, matching the build_runner path behavior. Previously the CLI would generate bridges for non-exported globals, causing compile errors.
- **Import block for multi-barrel modules**: `getImportBlock()` now returns import statements for all barrel files, not just the primary barrel.

### Dependencies
- Added `tom_build_base: ^1.0.0` as a pub.dev dependency (replaces path dependency).

### Documentation
- Added `doc/issues.md` with 30 documented issues (GEN-001 through GEN-030) including concrete source→bridge→problem examples.
- Updated `doc/d4rt_generator_cli_user_guide.md` with `buildkit.yaml` configuration and multi-project/glob support.

## 1.3.0

### Features
- **Per-package bridge generation**: Generate separate bridge files per package to improve code organization and enable deduplication
- **Cross-package support**: Package URI support for generating bridges that reference types from other packages
- **Bridge deduplication**: Automatic deduplication for enums, variables, and global functions with `sourceUri` tracking
- **Element-aware exclusions**: Exclude specific elements by source file pattern
- **Show/hide filtering**: Filter enums, functions, and variables with show/hide lists
- **Callback wrapping**: Automatic wrapping of function-type parameters for proper bridge integration
- **Improved dartscript generation**: Generated file headers and stdlib imports in dartscript output

### Bug Fixes
- Fixed type erasure for complex generic types
- Fixed dartscript.dart generation for cross-package scenarios
- Fixed unwrappable defaults using combinatorial dispatch
- Fixed typedef callback wrapping
- Fixed auxiliary import resolution for complex dependency graphs
- Fixed Windows filename compatibility (renamed files with invalid characters)

### Breaking Changes
- Per-package generation is now the default behavior
- Generator output structure may differ from 1.2.x for multi-package projects

### Internal
- Consolidated duplicated file generation code into file_generators.dart
- Improved error aggregation for bridge registration failures
- Refactored type resolution for better accuracy

## 1.2.0

### Features
- **GlobalsUserBridge**: New override system for top-level global variables, getters, and functions
  - `overrideGlobalVariableXxx` - override global variable values
  - `overrideGlobalGetterXxx` - override global getters with lazy evaluation functions
  - `overrideGlobalFunctionXxx` - override global function implementations
- **Getter vs Variable distinction**: Generator now correctly uses `registerGlobalGetter` for top-level getters (lazy evaluation) and `registerGlobalVariable` for constants/variables
- **Operator overrides enabled**: Removed outdated skip for operator UserBridge overrides - operators are now fully supported

### Documentation
- Updated bridgegenerator_user_guide.md with GlobalsUserBridge documentation
- Updated bridgegenerator_user_reference.md with global override reference
- Added global overrides section to userbridge_override_design.md

## 1.1.2

### Changes
- **Repository reorganization**: Moved to tom_module_d4rt repository as part of modular workspace structure
- Updated repository URL to https://github.com/al-the-bear/tom_module_d4rt
- Package now published to pub.dev (removed `publish_to: none`)
- **followReExports feature**: Bridge generator can now follow re-exports from external packages

## 1.1.1

### Fixes
- **Operator argument typing**: Operator bridges now use `D4.getRequiredArg<T>()` for properly typed argument extraction
- This ensures type-safe operator implementations (e.g., `operator+` extracts `other` as the correct type)
- Affected operators: `[]`, `[]=`, and all binary operators (`+`, `-`, `*`, `/`, `%`, `&`, `|`, `^`, `<<`, `>>`, `>>>`, `<`, `>`, `<=`, `>=`, `==`)

## 1.1.0

### Features
- **Operator bridging**: Full support for all Dart operators (+, -, *, /, [], []=, ==, <, >, etc.)
- **UserBridge override system**: Selective method overrides via `*UserBridge` companion classes extending `D4UserBridge`
- Override individual constructors, getters, setters, methods, and operators while generating the rest

### Documentation
- Added comprehensive operator override reference
- Added UserBridge override design documentation

## 1.0.1

- Fix: BuildRunnerFileWriter now writes directly to filesystem for `build_to: source` compatibility
- This fixes `UnexpectedOutputException` when using build_runner integration

## 1.0.0

- Initial version.