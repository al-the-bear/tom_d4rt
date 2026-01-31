# Tom D4rt Generator

D4rt bridge generator for creating BridgedClass implementations from Dart source code.

This tool analyzes Dart source files and automatically generates bridge classes that make Dart APIs accessible to D4rt scripts.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dev_dependencies:
  tom_d4rt_generator: ^1.0.0
```

## Usage

### Configuration File

Create a `d4rt_bridging.json` file in your project root:

```json
{
  "name": "my_package",
  "modules": [
    {
      "name": "all",
      "barrelFiles": ["lib/my_package.dart"],
      "outputPath": "lib/src/d4rt_bridges/my_package_bridges.dart",
      "barrelImport": "my_package.dart",
      "excludePatterns": ["_bridge.dart"],
      "excludeClasses": []
    }
  ],
  "helpersImport": "package:tom_d4rt/tom_d4rt.dart",
  "generateBarrel": true,
  "barrelPath": "lib/d4rt_bridges.dart",
  "generateDartscript": true,
  "dartscriptPath": "lib/dartscript.dart",
  "registrationClass": "MyPackageBridges"
}
```

### CLI Usage

Generate bridges for a specific project:

```bash
# Using executable
dart run tom_d4rt_generator:d4rt_generator --project=/path/to/project

# Using script directly
dart run tom_d4rt_generator/bin/d4rt_generator.dart --project=/path/to/project
```

Scan workspace for all projects with config files:

```bash
# Scan current directory
dart run tom_d4rt_generator:d4rt_generator

# Scan specific directory recursively
dart run tom_d4rt_generator:d4rt_generator --scan=/path/to/workspace --recursive
```

View help:

```bash
dart run tom_d4rt_generator:d4rt_generator --help
```

### Programmatic API

Use the generator in your Dart code:

```dart
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

Future<void> main() async {
  // Generate from config file
  final result = await generateBridges(
    configPath: '/path/to/d4rt_bridging.json',
  );
  
  print('Generated ${result.totalClasses} classes');
  print('Output files: ${result.outputFiles}');
  
  // Generate from config object
  final config = BridgeConfig(
    name: 'my_package',
    modules: [
      ModuleConfig(
        name: 'all',
        barrelFiles: ['lib/my_package.dart'],
        outputPath: 'lib/src/d4rt_bridges/my_package_bridges.dart',
      ),
    ],
  );
  
  final result2 = await generateBridges(config: config);
}
```

### Build Runner Integration

**Note:** The build_runner integration currently works best when triggered manually since `d4rt_bridging.json` files are typically at the project root (outside of lib/). For automatic generation, use the CLI tool with watch mode or the programmatic API.

To use with build_runner:

1. Add dependencies to `pubspec.yaml`:

```yaml
dev_dependencies:
  build_runner: ^2.4.0
  tom_d4rt_generator: ^1.0.0
```

2. Make sure you have a `d4rt_bridging.json` configuration file

3. The builder will run when build_runner processes your project:

```bash
# One-time build
dart run build_runner build

# Watch mode (regenerates on file changes)
dart run build_runner watch
```

**Recommended Approach:** For most use cases, the CLI tool is simpler and more direct:

```bash
# Generate once
dart run tom_d4rt_generator:d4rt_generator --project=/path/to/project

# Or use the programmatic API in a custom build script
```

## Configuration Schema

### BridgeConfig

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | Yes | Package name |
| `modules` | ModuleConfig[] | Yes | List of modules to generate bridges for |
| `helpersImport` | string | No | Import path for D4rt helper library (defaults to tom_d4rt) |
| `generateBarrel` | boolean | No | Whether to generate barrel file (default: true) |
| `barrelPath` | string | No | Path for barrel file (default: lib/d4rt_bridges.dart) |
| `generateDartscript` | boolean | No | Whether to generate dartscript registration file (default: true) |
| `dartscriptPath` | string | No | Path for dartscript file (default: lib/dartscript.dart) |
| `registrationClass` | string | No | Name of registration class (default: {name}Bridges) |

### ModuleConfig

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | Yes | Module name |
| `barrelFiles` | string[] | Yes | List of barrel files to process |
| `outputPath` | string | Yes | Output path for generated bridges |
| `barrelImport` | string | No | Import path for barrel file |
| `excludePatterns` | string[] | No | Patterns to exclude from processing |
| `excludeClasses` | string[] | No | Specific class names to exclude |
| `excludeEnums` | string[] | No | Specific enum names to exclude |
| `excludeFunctions` | string[] | No | Specific global function names to exclude |
| `excludeVariables` | string[] | No | Specific global variable names to exclude |
| `followReExports` | string[] | No | External packages to follow re-exports from |

## Generated Files

The generator creates several files:

1. **Bridge files** (one per module): Contains `BridgedClass` definitions for all exported classes
2. **Barrel file**: Exports all bridge modules
3. **Dartscript file**: Provides unified registration class with:
   - `register()` - Register all bridges with D4rt
   - `getImportBlock()` - Get import statements for D4rt scripts

## Migration from Old System

The old `generate_bridges.dart` with embedded configuration is deprecated. To migrate:

1. Create a `d4rt_bridging.json` file in each project
2. Move module configuration from Dart code to JSON
3. Use the new CLI: `dart run tom_d4rt_generator:d4rt_generator`

The old script still works as a wrapper but prints a deprecation warning.

## Development

### Building

```bash
dart pub get
```

### Running Tests

```bash
dart test
```

### Analyzing

```bash
dart analyze
```

## License

See LICENSE file in the repository root.

## Overview

This package provides:

1. **BridgeGenerator class** - Core generator that analyzes Dart source and produces BridgedClass implementations
2. **generate_bridges.dart** - CLI tool for batch generation across multiple projects

The generator ensures:

- **No duplicate bridges** - Shared types are only bridged once
- **Dependency hierarchy** - Bridges are placed in the correct project  
- **Consistent generation** - All projects use the same generator settings

## Note on Code Location

The `BridgeGenerator` class exists in two locations:

- **tom_bridge_generator/lib/src/bridge_generator.dart** - Authoritative source
- **tom_build/lib/src/tom/cli/bridge_generator.dart** - Copy for use by individual project tools

Individual project tool scripts (e.g., `tom_build/tool/generate_bridge.dart`) import from tom_build
to avoid circular dependencies. When making changes to the bridge generator, update both locations.

## Library Usage

```dart
import 'package:tom_bridge_generator/tom_bridge_generator.dart';

final generator = BridgeGenerator(
  workspacePath: '/path/to/project',
  packageName: 'my_package',
  sourceImport: 'my_package.dart',
);

final result = await generator.generateBridgesFromExports(
  barrelFiles: ['lib/my_package.dart'],
  outputPath: 'lib/src/d4rt_bridges/my_package_bridges.dart',
  moduleName: 'All',
);

print('Generated ${result.classesGenerated} bridges');
```

## CLI Usage

```bash
# From the workspace root
cd tom_bridge_generator

# Install dependencies
dart pub get

# Generate bridges for all projects
dart run bin/generate_bridges.dart

# Generate for a specific project only
dart run bin/generate_bridges.dart --project=tom_core_kernel
dart run bin/generate_bridges.dart --project=tom_build
dart run bin/generate_bridges.dart --project=tom_vscode_bridge

# List available projects
dart run bin/generate_bridges.dart --list

# Dry run (show what would be generated)
dart run bin/generate_bridges.dart --dry-run

# Verbose output
dart run bin/generate_bridges.dart --verbose
```

## Project Hierarchy

The generator respects the dependency hierarchy:

| Project | Gets Bridges For | Shared Externals |
|---------|-----------------|------------------|
| tom_core_kernel | tom_core_kernel classes | tom_reflection types |
| tom_core_server | tom_core_server classes | Imports tom_core_kernel bridges |
| tom_build | tom_build classes only | Imports kernel + server bridges |
| tom_vscode_bridge | VS Code API wrappers | Imports all above |

## Runtime Registration

At runtime, register bridges in dependency order:

```dart
// In your application:
import 'package:tom_core_kernel/dartscript.dart';
import 'package:tom_core_server/dartscript.dart';
import 'package:tom_build/dartscript.dart';
import 'package:tom_vscode_bridge/dartscript.dart';

final interpreter = D4rt();
TomCoreKernelBridges.registerAllBridges(interpreter);
TomCoreServerBridges.registerAllBridges(interpreter);
TomBuildBridges.registerAllBridges(interpreter);
TomDartscriptBridgeBridges.registerAllBridges(interpreter);
```

## How It Works

1. Scans source directories for each project
2. Parses Dart classes and their members using the analyzer package
3. Generates BridgedClass implementations with constructors, methods, getters, setters
4. Tracks seen classes to avoid duplicates across projects
5. Writes output to each project's lib/src/d4rt_bridges/ directory

