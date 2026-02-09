# Implementation Hints — tom_build_base Integration

This document describes the relationship between `tom_d4rt_generator` and the shared CLI infrastructure from `tom_build_base`.

## Overview

`tom_d4rt_generator` provides the D4rt bridge generator tooling:
- **d4rtgen** CLI — Command-line bridge generation without build_runner
- **BridgeGenerator** — Core generator class
- **build_runner integration** — Builder for automated generation

The `d4rtgen` CLI uses the shared infrastructure from `tom_build_base` for workspace navigation and CLI standardization.

## Dependencies on tom_build_base

### Workspace Navigation

Navigation options are provided by `tom_build_base`:

```dart
import 'package:tom_build_base/tom_build_base.dart';

// Add navigation options to parser
addNavigationOptions(parser);

// Parse navigation args
final navArgs = parseNavigationArgs(results, bareRoot: bareRoot);

// Apply defaults (scan, recursive, build-order)
navArgs = navArgs.withDefaults();

// Resolve execution root
final executionRoot = resolveExecutionRoot(navArgs, currentDir: currentDir);
```

### CLI Commands

The base package provides standardized help/version detection:

```dart
// Check for help/version commands early
if (isVersionCommand(args)) {
  _printVersion();
  return;
}
if (isHelpCommand(args)) {
  _printUsage(null);
  return;
}
```

### Help Output

Standardized help output is generated using:

```dart
// Header with tool name and usage patterns
for (final line in getToolHelpHeader(
  toolName: 'D4rtgen',
  toolDescription: 'Generates D4rt bridges from configuration files',
  usagePatterns: ['d4rtgen [options]', ...],
)) {
  print(line);
}

// Navigation options (synchronized across all tools)
printNavigationOptionsHelp();

// Footer with examples
for (final line in getToolHelpFooter(toolName: 'd4rtgen')) {
  print(line);
}
```

### Project Discovery

```dart
final projects = await collectProjectsFromNavArgs(navArgs, basePath: executionRoot);
```

## Tom Build Base Reference

See the following documentation in `tom_build_base`:

| Document | Description |
|----------|-------------|
| [cli_tools_navigation.md](../../../tom_module_basics/tom_build_base/doc/cli_tools_navigation.md) | Standard CLI commands, execution modes, navigation options |
| [build_base_user_guide.md](../../../tom_module_basics/tom_build_base/doc/build_base_user_guide.md) | Configuration loading, project discovery, workspace mode |

### Key Files in tom_build_base

| File | Purpose |
|------|---------|
| `lib/src/workspace_mode.dart` | Navigation args, execution modes, CLI helpers |
| `lib/src/project_discovery.dart` | Project scanning and pattern matching |
| `lib/src/build_config.dart` | TomBuildConfig loading |

### Key Functions

| Function | Purpose |
|----------|---------|
| `isHelpCommand(args)` | Detect help command (help, --help, -h, -help) |
| `isVersionCommand(args)` | Detect version command (version, --version, -version, -V) |
| `addNavigationOptions(parser)` | Add -s, -r, -p, -R, -x, etc. to ArgParser |
| `parseNavigationArgs(results)` | Parse navigation options from ArgResults |
| `resolveExecutionRoot(navArgs)` | Determine workspace/project root |
| `getToolHelpHeader/Footer()` | Generate standardized help text |
| `printNavigationOptionsHelp()` | Print navigation options section |

## Version History

- **2026-02**: Added standardized CLI help/version support via tom_build_base
- **2026-02**: Migrated from standalone navigation to shared workspace_mode.dart
