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
