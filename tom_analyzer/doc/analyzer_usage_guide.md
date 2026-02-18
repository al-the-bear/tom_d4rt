# Tom Analyzer CLI Usage Guide

Guide to analyzing Dart code using the Tom Analyzer command-line tool.

---

## Table of Contents

1. [Overview](#overview)
2. [Installation](#installation)
3. [Quick Start](#quick-start)
4. [Command-Line Options](#command-line-options)
5. [Configuration (buildkit.yaml)](#configuration-buildkityaml)
6. [Navigation Options](#navigation-options)
7. [Examples](#examples)
8. [Output Formats](#output-formats)

---

## Overview

Tom Analyzer is a standalone CLI tool that analyzes Dart barrel files and produces structured code information in YAML or JSON format. It reads configuration from `buildkit.yaml` files and supports multi-project workspace scanning via the standard Tom build navigation system.

### Key Features

- **Barrel file analysis** — Resolves exports, re-exports, and type information
- **YAML/JSON output** — Machine-readable structured analysis results
- **Multi-project support** — Scans workspaces for projects with `tom_analyzer:` configuration
- **Standard navigation** — Uses `tom_build_base` navigation options (`-R`, `-s`, `-p`, etc.)
- **Config-driven** — All settings in `buildkit.yaml` with CLI overrides

---

## Installation

### Compiled Binary

After workspace compilation, the binary is available at:

```bash
~/.tom/bin/<platform>/analyzer
```

### Running from Source

```bash
cd tom_analyzer
dart pub get
dart run bin/tom_analyzer.dart [options]
```

### Via Buildkit

```bash
buildkit :analyzer [options]
```

---

## Quick Start

### 1. Create a `buildkit.yaml` in your project

```yaml
tom_analyzer:
  barrels:
    - lib/my_package.dart
```

### 2. Run the analyzer

```bash
# From the project directory
analyzer

# Or scan the whole workspace
analyzer -R
```

### 3. Output

By default, analysis output is written to stdout in YAML format. Use `--output` to write to a file.

---

## Command-Line Options

### Tool Options

| Option | Short | Default | Description |
|--------|-------|---------|-------------|
| `--config=<path>` | `-c` | `buildkit.yaml` | Path to config file |
| `--barrel=<path>` | | *(from config)* | Barrel file to analyze (overrides config) |
| `--output=<path>` | | *(stdout)* | Output file path |
| `--format=<fmt>` | `-f` | `yaml` | Output format: `yaml` or `json` |
| `--verbose` | `-v` | `false` | Enable verbose output |
| `--list` | `-l` | `false` | List projects that would be processed (no action) |
| `--help` | `-h` | | Show help message |

### Subcommands

| Command | Description |
|---------|-------------|
| `help` | Show full usage information |
| `version` | Show version information |

### Override Precedence

CLI flags override `buildkit.yaml` values:

1. `buildkit.yaml` `tom_analyzer:` section is loaded first
2. `--barrel` overrides `barrels` from config
3. `--output` overrides `output_file` from config
4. `--format` overrides `output_format` from config
5. `workspace_root` defaults to the project path if not set

---

## Configuration (buildkit.yaml)

The `tom_analyzer:` section in `buildkit.yaml` supports the following keys:

### Basic Configuration

```yaml
tom_analyzer:
  barrels:
    - lib/my_package.dart
  output_format: yaml           # 'yaml' or 'json'
  output_file: doc/analysis.yaml  # Optional output path
  workspace_root: ../..         # Workspace root for resolving packages
```

### Re-Export Control

```yaml
tom_analyzer:
  barrels:
    - lib/my_package.dart

  # Follow all re-exports (default)
  follow_re_exports: true

  # Or follow only specific packages
  follow_re_exports:
    - package_a
    - package_b

  # Skip re-exports from specific packages
  skip_re_exports:
    - dart.core
    - some_external_package

  # Include deprecated members in output
  include_deprecated_members: false
```

### Configuration Reference

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `barrels` | `List<String>` | `[]` | Barrel file(s) to analyze |
| `output_format` | `String` | `'yaml'` | Output format: `yaml` or `json` |
| `output_file` | `String?` | `null` | Output file path (null = stdout) |
| `workspace_root` | `String?` | *(project path)* | Workspace root for resolving packages |
| `follow_re_exports` | `bool` / `List<String>` | `true` | Follow re-exports globally or for specific packages |
| `skip_re_exports` | `List<String>` | `[]` | Package re-exports to skip |
| `include_deprecated_members` | `bool` | `false` | Include `@deprecated` members |

---

## Navigation Options

Tom Analyzer uses the standard `tom_build_base` navigation system, shared across all Tom build tools. For full details on execution modes, project discovery, and all navigation flags, see the [CLI Tools Navigation Guide](../../tom_build_base/doc/cli_tools_navigation.md) and the [Build Base User Guide](../../tom_build_base/doc/build_base_user_guide.md).

### Execution Modes

| Mode | Trigger | Description |
|------|---------|-------------|
| **Project Mode** | *(default)* | Runs from current directory with `-s . -r -b` defaults |
| **Workspace Mode** | `-R`, `-s <path>`, `-i`, `-o` | Runs from workspace root |

### Navigation Flags

| Option | Short | Description |
|--------|-------|-------------|
| `--scan=<path>` | `-s` | Scan directory for projects |
| `--recursive` | `-r` | Scan directories recursively |
| `--build-order` | `-b` | Sort projects in dependency build order |
| `--project=<pattern>` | `-p` | Project(s) to run (comma-separated, globs supported) |
| `--root[=<path>]` | `-R` | Workspace root (bare: auto-detected, with path: specified) |
| `--workspace-recursion` | `-w` | Shell out to sub-workspaces instead of skipping |
| `--inner-first-git` | `-i` | Scan git repos, process innermost (deepest) first |
| `--outer-first-git` | `-o` | Scan git repos, process outermost (shallowest) first |
| `--exclude=<glob>` | `-x` | Exclude patterns (path-based globs) |
| `--exclude-projects=<pattern>` | | Exclude projects by name or path |
| `--recursion-exclude=<glob>` | | Exclude patterns during recursive scan |

### Default Behavior

When no explicit navigation options are provided, the tool applies:

```
--scan . --recursive --build-order
```

This scans the current directory tree for projects with `tom_analyzer:` sections in their `buildkit.yaml`, sorted in dependency order.

### Project Detection

A directory is recognized as a Tom Analyzer project when it has:

1. A `pubspec.yaml` file
2. A `buildkit.yaml` file with a `tom_analyzer:` section

---

## Examples

### Basic Analysis

```bash
# Analyze current project (reads buildkit.yaml)
analyzer

# Analyze with verbose output
analyzer -v
```

### Workspace Operations

```bash
# Process all projects from workspace root
analyzer -R

# List all analyzer projects in workspace
analyzer -R -l

# Process specific project by name
analyzer -p my_package

# Process projects matching a glob pattern
analyzer -p "tom_*" -r
```

### Output Control

```bash
# Override barrel on command line
analyzer --barrel lib/my_lib.dart

# Output as JSON
analyzer --barrel lib/my_lib.dart --format json

# Write to file
analyzer --output doc/analysis.yaml
```

### Scanning

```bash
# Scan a specific directory recursively
analyzer -s packages/ -r

# Scan excluding certain projects
analyzer -R --exclude-projects "test_*"
```

---

## Output Formats

### YAML Output (default)

Structured YAML containing library, class, enum, extension, and function definitions with full type information, documentation, and metadata.

### JSON Output

Same structure as YAML but in JSON format. Useful for programmatic consumption.

---

## Related Tools

- **Tom Reflector** — Generates `.r.dart` reflection code from analysis results. See [reflector_usage_guide.md](reflector_usage_guide.md).
- **Tom Build Base** — Shared navigation infrastructure used by all Tom build tools.
  - [CLI Tools Navigation Guide](../../tom_build_base/doc/cli_tools_navigation.md) — Full reference for execution modes and navigation options
  - [Build Base User Guide](../../tom_build_base/doc/build_base_user_guide.md) — Configuration loading, project discovery, and tool creation

```bash
# Run reflector instead of analyzer
dart run tom_analyzer:tom_reflector --help
```
