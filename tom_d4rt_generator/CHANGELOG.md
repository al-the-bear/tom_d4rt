## 1.4.0

### Features
- **CLI: tom_build.yaml support**: The `d4rtgen` CLI now reads configuration from `tom_build.yaml` files (in addition to `build.yaml` and `d4rt_bridging.json`), using the shared `tom_build_base` infrastructure.
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
- Updated `doc/d4rt_generator_cli_user_guide.md` with `tom_build.yaml` configuration and multi-project/glob support.

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
