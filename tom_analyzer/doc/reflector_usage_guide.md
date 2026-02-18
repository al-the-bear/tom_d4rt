# Tom Reflector CLI Usage Guide

Guide to generating Dart reflection code using the Tom Reflector command-line tool.

---

## Table of Contents

1. [Overview](#overview)
2. [Installation](#installation)
3. [Quick Start](#quick-start)
4. [Command-Line Options](#command-line-options)
5. [Configuration (buildkit.yaml)](#configuration-buildkityaml)
6. [Reflection Modes](#reflection-modes)
7. [Navigation Options](#navigation-options)
8. [Examples](#examples)

---

## Overview

Tom Reflector is a standalone CLI tool that generates `.r.dart` reflection files from Dart source code. It supports two generation modes:

- **Legacy mode** — Analyzes a barrel file and generates reflection data for all exports
- **Entry point mode** — Performs reachability analysis from entry points with rich filtering and dependency control

Configuration is read from `buildkit.yaml` files and the tool supports multi-project workspace scanning via the standard Tom build navigation system.

### Key Features

- **Two generation modes** — Legacy barrel-based and new entry-point-based reflection
- **Rich filtering** — Include/exclude by package, annotation, path, type, or element
- **Dependency resolution** — Configurable transitive dependency following (superclasses, interfaces, mixins, type arguments, code bodies)
- **Multi-project support** — Scans workspaces for projects with `tom_reflector:` configuration
- **Standard navigation** — Uses `tom_build_base` navigation options (`-R`, `-s`, `-p`, etc.)

---

## Installation

### Compiled Binary

After workspace compilation, the binary is available at:

```bash
~/.tom/bin/<platform>/reflector
```

### Running from Source

```bash
cd tom_analyzer
dart pub get
dart run bin/tom_reflector.dart [options]
```

### Via Buildkit

```bash
buildkit :reflector [options]
```

---

## Quick Start

### 1. Create a `buildkit.yaml` in your project

```yaml
tom_reflector:
  barrels:
    - lib/my_package.dart
```

### 2. Run the reflector

```bash
# From the project directory
reflector

# Or scan the whole workspace
reflector -R
```

### 3. Output

Generates `lib/my_package.r.dart` alongside the barrel file.

---

## Command-Line Options

### Tool Options

| Option | Short | Default | Description |
|--------|-------|---------|-------------|
| `--config=<path>` | `-c` | `buildkit.yaml` | Path to config file |
| `--entry=<file>` | `-e` | | Entry point file(s) — can repeat, comma-separated. Triggers new reflection mode |
| `--barrel=<path>` | | *(from config)* | Barrel file for legacy mode (overrides config) |
| `--output=<path>` | | *(auto-derived)* | Output file path |
| `--verbose` | `-v` | `false` | Enable verbose output |
| `--list` | `-l` | `false` | List projects that would be processed (no action) |
| `--help` | `-h` | | Show help message |

### Subcommands

| Command | Description |
|---------|-------------|
| `help` | Show full usage information |
| `version` | Show version information |

### Override Precedence

1. `buildkit.yaml` `tom_reflector:` section is loaded first
2. `--barrel` overrides `barrels` from config
3. `--output` overrides derived output path
4. `--entry` **bypasses** barrel-based config entirely and switches to entry-point mode

---

## Configuration (buildkit.yaml)

### Legacy Mode Configuration

The `tom_reflector:` section uses the same configuration keys as `tom_analyzer:`:

```yaml
tom_reflector:
  barrels:
    - lib/my_package.dart
  follow_re_exports: true
  skip_re_exports:
    - dart.core
```

See [analyzer_usage_guide.md](analyzer_usage_guide.md#configuration-reference) for the full configuration reference — all keys are shared.

### Entry Point Mode Configuration

For advanced reflection with entry-point analysis:

```yaml
tom_reflector:
  entry_points:
    - lib/my_app.dart
  output: lib/generated/reflection.r.dart

  defaults:
    exclude_packages:
      - 'dart.*'
    include_annotations:
      - Reflectable

  filters:
    - include:
        packages: ['my_package']
    - exclude:
        annotations: ['DoNotReflect']

  dependency_config:
    superclasses:
      enabled: true
      depth: -1
    interfaces:
      enabled: true
    mixins:
      enabled: true
    type_arguments:
      enabled: true
    code_bodies:
      enabled: false

  coverage_config:
    instance_members:
      enabled: true
    static_members:
      enabled: true
    constructors:
      enabled: true
    metadata:
      enabled: true
```

### Entry Point Configuration Reference

#### Top-Level Keys

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `entry_points` | `List<String>` | `[]` | Entry point files for reachability analysis |
| `output` | `String?` | *(derived from entry point)* | Output file path (`.r.dart` appended automatically) |
| `include_private` | `bool` | `false` | Whether to include private members |

#### Defaults

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `defaults.exclude_packages` | `List<String>` | `[]` | Package globs to always exclude |
| `defaults.include_packages` | `List<String>` | `[]` | Package globs to always include |
| `defaults.include_annotations` | `List<String>` | `[]` | Annotations that trigger automatic inclusion |

#### Filters

Ordered list of include/exclude rules. Each filter has selectors:

```yaml
filters:
  - include:
      packages: ['my_*']          # Package name globs
      annotations: ['Reflectable'] # Annotation names
      paths: ['lib/models/**']     # File path globs
      types: ['MyClass']           # Type names
      elements: ['myFunction']     # Element names
  - exclude:
      annotations: ['NoReflect']
```

#### Dependency Configuration

Controls transitive dependency resolution:

| Section | Key | Type | Default | Description |
|---------|-----|------|---------|-------------|
| `superclasses` | `enabled` | `bool` | `true` | Include superclasses |
| | `depth` | `int` | `-1` | Depth limit (-1 = unlimited) |
| | `external_depth` | `int` | `2` | Max packages deep to follow |
| | `exclude_types` | `List<String>` | `[]` | Types to stop at |
| `interfaces` | `enabled` | `bool` | `true` | Include interfaces |
| | `external` | `bool` | `true` | Include external interfaces |
| `mixins` | `enabled` | `bool` | `true` | Include mixins |
| | `external` | `bool` | `true` | Include external mixins |
| `type_arguments` | `enabled` | `bool` | `true` | Include type arguments |
| | `external` | `bool` | `true` | Include external type arguments |
| `type_annotations` | `enabled` | `bool` | `true` | Include type annotations |
| | `transitive` | `bool` | `false` | Follow meta-annotations |
| | `external` | `bool` | `true` | Include external annotation types |
| | `include_argument_types` | `bool` | `true` | Include types in annotation args |
| | `scan_marked_types` | `bool` | `false` | Scan for all types using annotations |
| `subtypes` | `enabled` | `bool` | `false` | Include subtypes of covered classes |
| `code_bodies` | `enabled` | `bool` | `false` | Analyze method/constructor bodies |
| | `external` | `bool` | `true` | Include external types from bodies |
| | `depth` | `int` | `1` | Depth limit for type following |
| | `include_variable_types` | `bool` | `true` | Include types from variable declarations |
| | `include_invocation_types` | `bool` | `true` | Include types from method invocations |
| | `include_type_operations` | `bool` | `true` | Include types from casts/type tests |
| `marker_annotations` | `enabled` | `bool` | `false` | Enable marker annotation scanning |
| | `marker_annotations` | `List<String>` | `[]` | Annotation names to treat as markers |
| | `scan_packages` | `List<String>` | `[]` | Package patterns to scan |
| | `follow_annotation_chains` | `bool` | `true` | Follow annotation chains |

#### Coverage Configuration

Controls what invokers/declarations to generate:

| Section | Key | Type | Default | Description |
|---------|-----|------|---------|-------------|
| `instance_members` | `enabled` | `bool` | `true` | Generate instance member invokers |
| | `pattern` | `String?` | `null` | Glob pattern for member names |
| | `annotations` | `List<String>` | `[]` | Only annotated members |
| | `exclude_inherited` | `bool` | `false` | Exclude inherited members |
| `static_members` | `enabled` | `bool` | `true` | Generate static member invokers |
| `constructors` | `enabled` | `bool` | `true` | Generate constructor invokers |
| | `pattern` | `String?` | `null` | Constructor name glob |
| | `unnamed` | `bool` | `true` | Include unnamed constructor |
| `top_level` | `enabled` | `bool` | `true` | Generate top-level invokers |
| `metadata` | `enabled` | `bool` | `true` | Include metadata |
| `type_info` | `enabled` | `bool` | `true` | Include type mirrors |
| | `relations` | `bool` | `true` | Include type relationships |
| | `reflected_type` | `bool` | `true` | Support `reflectedType` |
| `declarations` | `enabled` | `bool` | `true` | Include declaration lists |
| | `parameters` | `bool` | `true` | Include parameter info |
| | `default_values` | `bool` | `false` | Include default values (expensive) |

#### Source Extraction (Optional)

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `source_extraction.enabled` | `bool` | `false` | Enable source extraction |
| `source_extraction.include_source_code` | `bool` | `false` | Include full source code |
| `source_extraction.include_doc_comments` | `bool` | `true` | Include doc comments |
| `source_extraction.include_all_comments` | `bool` | `false` | Include all comments |
| `source_extraction.include_line_info` | `bool` | `true` | Include line/column info |
| `source_extraction.max_source_length` | `int` | `0` | Max source length (0 = unlimited) |
| `source_extraction.store_file_contents` | `bool` | `false` | Store full file contents |

---

## Reflection Modes

### Legacy Mode (Barrel-Based)

Triggered by `barrels:` in config or `--barrel` on the CLI.

- Analyzes all exports from a barrel file via `TomAnalyzer.analyzeBarrel()`
- Generates reflection using `ReflectionModel` → `ReflectionGenerator`
- Simple configuration — shares all keys with `tom_analyzer:`
- Output: `<barrel>.r.dart` (`.r.dart` extension enforced)

```bash
# From config
reflector

# Override barrel
reflector --barrel lib/my_lib.dart
```

### Entry Point Mode (New)

Triggered by `--entry` on the CLI or `entry_points:` in config.

- Performs reachability analysis from entry point files
- Rich filtering with include/exclude rules
- Full transitive dependency resolution
- Fine-grained coverage control
- Uses `MultiEntryGenerator` for output
- Output: per-entry `.r.dart` files, or combined via `output`

```bash
# Single entry point
reflector -e lib/my_app.dart

# Multiple entry points
reflector -e lib/app.dart,lib/models.dart

# With output path
reflector -e lib/my_app.dart --output lib/generated/reflection.r.dart
```

### Mode Comparison

| Aspect | Legacy (Barrel) | Entry Point |
|--------|----------------|-------------|
| Trigger | `barrels:` / `--barrel` | `entry_points:` / `--entry` |
| Analysis | Barrel exports | Reachability from entry points |
| Filtering | `follow_re_exports`, `skip_re_exports` | Rich include/exclude filters |
| Dependencies | Re-exports only | Superclasses, interfaces, mixins, type args, code bodies |
| Coverage | Generates everything | Configurable per category |
| Source extraction | Not supported | Optional |
| Multi-entry | Single barrel | Multiple entry points |

---

## Navigation Options

Tom Reflector uses the standard `tom_build_base` navigation system, shared across all Tom build tools. The options are identical to [Tom Analyzer navigation](analyzer_usage_guide.md#navigation-options). For full details on execution modes, project discovery, and all navigation flags, see the [CLI Tools Navigation Guide](../../tom_build_base/doc/cli_tools_navigation.md) and the [Build Base User Guide](../../tom_build_base/doc/build_base_user_guide.md).

### Quick Reference

| Option | Short | Description |
|--------|-------|-------------|
| `--scan=<path>` | `-s` | Scan directory for projects |
| `--recursive` | `-r` | Scan directories recursively |
| `--build-order` | `-b` | Sort projects in dependency build order |
| `--project=<pattern>` | `-p` | Project(s) to run (comma-separated, globs) |
| `--root[=<path>]` | `-R` | Workspace root (bare: auto-detected) |
| `--workspace-recursion` | `-w` | Shell out to sub-workspaces |
| `--inner-first-git` | `-i` | Process innermost git repos first |
| `--outer-first-git` | `-o` | Process outermost git repos first |
| `--exclude=<glob>` | `-x` | Exclude patterns |
| `--exclude-projects` | | Exclude projects by name/path |
| `--recursion-exclude` | | Exclude during recursive scan |

### Default Behavior

When no navigation options are provided:

```
--scan . --recursive --build-order
```

### Project Detection

A directory is recognized as a Tom Reflector project when it has:

1. A `pubspec.yaml` file
2. A `buildkit.yaml` file with a `tom_reflector:` section

---

## Examples

### Basic Reflection

```bash
# Generate reflection for current project
reflector

# With verbose output
reflector -v
```

### Workspace Operations

```bash
# Process all reflector projects from workspace root
reflector -R

# List all reflector projects
reflector -R -l

# Process specific project
reflector -p my_package

# Process matching projects
reflector -p "tom_*" -r
```

### Legacy Mode

```bash
# Override barrel on command line
reflector --barrel lib/my_lib.dart

# Specify output path
reflector --barrel lib/my_lib.dart --output lib/my_lib.r.dart
```

### Entry Point Mode

```bash
# Single entry point
reflector -e lib/my_app.dart

# Multiple entry points
reflector -e lib/app.dart,lib/models.dart

# With custom output
reflector -e lib/my_app.dart --output lib/generated/reflection.r.dart
```

---

## Related Tools

- **Tom Analyzer** — Analyzes Dart barrel files and produces structured output. See [analyzer_usage_guide.md](analyzer_usage_guide.md).
- **Tom Build Base** — Shared navigation infrastructure used by all Tom build tools.
  - [CLI Tools Navigation Guide](../../tom_build_base/doc/cli_tools_navigation.md) — Full reference for execution modes and navigation options
  - [Build Base User Guide](../../tom_build_base/doc/build_base_user_guide.md) — Configuration loading, project discovery, and tool creation

```bash
# Run analyzer instead of reflector
dart run tom_analyzer --help
```
