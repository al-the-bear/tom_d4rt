# Tom D4rt Generator

D4rt bridge generator for creating `BridgedClass` implementations from Dart source code.

This tool analyzes Dart source files and automatically generates bridge classes that make Dart APIs accessible to [D4rt](https://pub.dev/packages/tom_d4rt) scripts. Supports per-package generation, automatic deduplication, multi-barrel modules, and cross-package bridging.

## Features

- **Per-package generation**: Generate separate bridge files for each package
- **Automatic deduplication**: Prevents duplicate registrations across packages using `sourceUri` tracking
- **Multi-barrel modules**: Modules with multiple barrel files (e.g., `dcli.dart` + `dcli_core.dart`) are fully supported — bridges register under all barrel import paths
- **Cross-package support**: Reference types from other packages in your bridges
- **Show/hide filtering**: Control which enums, functions, and variables are bridged
- **Callback wrapping**: Automatic handling of function-type parameters
- **UserBridge overrides**: Customize generated bridges with override classes
- **CLI tool (`d4rtgen`)**: Generate bridges from the command line with `buildkit.yaml` or `build.yaml` configuration
- **build_runner integration**: Use as a standard build_runner builder

## Installation

Add to your `pubspec.yaml`:

```yaml
dev_dependencies:
  tom_d4rt_generator: ^1.5.0
  build_runner: ^2.4.0  # if using build_runner integration
```

## Quick Start

### 1. Configure modules in `build.yaml`

```yaml
targets:
  $default:
    builders:
      tom_d4rt_generator|bridge_builder:
        enabled: true
        options:
          modules:
            - name: all
              barrelFiles:
                - package:my_package/my_package.dart
              barrelImport: package:my_package/my_package.dart
              outputPath: lib/src/bridges/my_package_bridges.b.dart
          generateBarrel: true
          barrelPath: lib/bridges.b.dart
          generateDartscript: true
          dartscriptPath: lib/dartscript.b.dart
          registrationClass: MyPackageBridge
```

### 2. Generate bridges

Using the CLI:

```bash
dart run tom_d4rt_generator:d4rtgen --project=.
```

Or using build_runner:

```bash
dart run build_runner build
```

### 3. Register bridges at runtime

```dart
import 'package:tom_d4rt/d4rt.dart';
import 'package:my_package/dartscript.b.dart';

final d4rt = D4rt();
MyPackageBridge.registerBridges(d4rt, 'package:my_package/my_package.dart');
```

## CLI Usage

The `d4rtgen` CLI supports `buildkit.yaml`, `build.yaml`, and `d4rt_bridging.json` configuration:

```bash
# Generate for a specific project
dart run tom_d4rt_generator:d4rtgen --project=/path/to/project

# Generate for multiple projects using globs
dart run tom_d4rt_generator:d4rtgen --project=tom_*_bridges,devops/tom_build_cli

# Scan workspace for all projects with config
dart run tom_d4rt_generator:d4rtgen --scan=. --recursive

# List discovered projects without generating
dart run tom_d4rt_generator:d4rtgen --scan=. --list

# Verbose output
dart run tom_d4rt_generator:d4rtgen --project=. --verbose
```

## Configuration

See [Configuration Reference](doc/bridgegenerator_user_reference.md) for all `build.yaml` options.

Key module options:

| Option | Description |
|--------|-------------|
| `barrelFiles` | Barrel files to scan for exported types |
| `barrelImport` | Primary barrel for import prefixing |
| `outputPath` | Output path for generated bridge file |
| `excludeClasses` | Class names to skip |
| `excludeSourcePatterns` | Source file patterns to skip |
| `followAllReExports` | Whether to follow re-exports (default: true) |
| `skipReExports` | Packages whose re-exports to skip |

## Documentation

| Document | Description |
|----------|-------------|
| [Bridge Generator User Guide](doc/bridgegenerator_user_guide.md) | How to use the generator |
| [Configuration Reference](doc/bridgegenerator_user_reference.md) | All build.yaml options |
| [CLI User Guide](doc/d4rt_generator_cli_user_guide.md) | Command-line tool usage |
| [UserBridge Guide](doc/user_bridge_user_guide.md) | Custom override classes |
| [UserBridge Design](doc/userbridge_override_design.md) | Override system design |
| [Known Issues](doc/issues.md) | 46 documented issues with examples |
| [Test Coverage](doc/test_coverage.md) | Bridge feature test inventory |

## Known Issues

See [doc/issues.md](doc/issues.md) for a comprehensive list of 46 known issues and limitations, each with concrete source-to-bridge-to-problem examples showing:

- What in the scanned source code triggers the problem
- What the generated bridge code looks like
- Where the problem manifests (compile error, runtime error, type safety loss)

## License

MIT License — see [LICENSE](LICENSE) for details.

Author: Alexis Kyaw ([LinkedIn](https://www.linkedin.com/in/nickmeinhold/))

