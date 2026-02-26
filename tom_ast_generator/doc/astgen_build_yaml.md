# AST Generator Build Configuration

The `astgen` tool uses a two-tier configuration pattern for project discovery and file conversion.

## Related Documentation

This tool uses the shared CLI infrastructure from **tom_build_base**:

- [CLI Tools Navigation](../../tom_build_base/doc/cli_tools_navigation.md) — Standard CLI commands, execution modes, and navigation options
- [Build Base User Guide](../../tom_build_base/doc/build_base_user_guide.md) — Configuration loading, project discovery, and workspace mode

For CLI usage details, see [tom_build_configuration_and_cli.md](tom_build_configuration_and_cli.md).

## 1. Project Discovery - tom_build.yaml

Create a `tom_build.yaml` file in your project root to mark it as an astgen consumer:

```yaml
# tom_build.yaml
astgen:
  project: .
  verbose: false
```

This enables project auto-discovery when using `--scan`:

```bash
# Scan a directory for astgen projects
dart run tom_d4rt_astgen:astgen --scan test

# Process a specific project  
dart run tom_d4rt_astgen:astgen --project path/to/project

# Run from project root (auto-detects tom_build.yaml or build.yaml)
cd my_project
dart run tom_d4rt_astgen:astgen
```

## 2. Conversion Configuration - build.yaml

The `astgen` tool reads conversion configurations from `build.yaml` to convert Dart source files into serialized AST YAML files.

### Configuration Structure

```yaml
astgen:
  convert:
    - entrypoints: <glob-pattern>
      output: <output-path>
      root: <root-directory>
      exclude: [<glob-patterns>]
      preserve_structure: <boolean>
      include_sourcemap: <boolean>
      include_imports: <boolean>
      import_depth: <integer>
      include_relative_imports: <boolean>
```

## Configuration Options

### Required Fields

#### `entrypoints` (string, required)
Glob pattern matching the Dart source files to convert.

**Examples:**
```yaml
entrypoints: lib/*.runner.dart          # All *.runner.dart files in lib/
entrypoints: lib/**/*.runner.dart       # Recursive search in lib/
entrypoints: example/*/bin/*.dart       # Multiple levels with wildcards
```

#### `output` (string, required)
Destination path for generated AST files. Supports three formats:

1. **Project notation** (recommended):
   ```yaml
   output: project:tom_uam_client/assets
   ```
   Finds the `tom_uam_client` project in the workspace, verifies it has a `pubspec.yaml` with matching name, and uses the specified subdirectory.

2. **Absolute path**:
   ```yaml
   output: /absolute/path/to/output
   ```

3. **Relative path**:
   ```yaml
   output: ../relative/path/to/output
   ```

**Project Resolution:**
The `project:name/path` notation searches for a project with:
- A `pubspec.yaml` file
- `name: <project-name>` in the pubspec
- Searched in parent and sibling directories of the current workspace

### Optional Fields

#### `root` (string, optional, default: `"."`)
Base directory for resolving glob patterns and relative paths.

**Example:**
```yaml
root: example/walkers
entrypoints: bin/*.walker.dart    # Resolves to example/walkers/bin/*.walker.dart
```

#### `exclude` (list of strings, optional, default: `[]`)
Glob patterns for files to exclude from conversion.

**Examples:**
```yaml
exclude:
  - lib/**/*.g.dart          # Ignore generated files
  - lib/**/*.freezed.dart    # Ignore Freezed files
  - lib/**/*.test.dart       # Ignore test files
```

**Single pattern:**
```yaml
exclude: lib/**/*.g.dart     # Can also be a single string
```

#### `preserve_structure` (boolean, optional, default: `false`)
Controls output file organization:

- `false` (default): All output files placed directly in output directory (flat structure)
- `true`: Preserve source directory structure relative to `root`

**Example:**
```yaml
root: lib
entrypoints: **/*.runner.dart
output: project:runtime/assets
preserve_structure: true
```

With `preserve_structure: true`:
```
lib/tools/my_tool.runner.dart     → runtime/assets/tools/my_tool.ast.yaml
lib/utils/helper.runner.dart      → runtime/assets/utils/helper.ast.yaml
```

With `preserve_structure: false`:
```
lib/tools/my_tool.runner.dart     → runtime/assets/my_tool.ast.yaml
lib/utils/helper.runner.dart      → runtime/assets/helper.ast.yaml
```

#### `include_sourcemap` (boolean, optional, default: `false`)
Adds source mapping information to the generated AST file for error tracking.

When enabled, wraps the AST with metadata:
```yaml
sourcemap:
  source_file: /absolute/path/to/source.dart
  generated_at: 2026-02-06T10:30:45.123Z
ast:
  # ... actual AST content
```

This allows runtime errors in the AST to be traced back to the original source file and line number.

**Example:**
```yaml
include_sourcemap: true
```

#### `include_imports` (boolean, optional, default: `false`)
**Status: Not yet implemented (placeholder)**

When enabled, recursively converts imported Dart files along with the entrypoint file.

**Example:**
```yaml
include_imports: true
import_depth: 2
include_relative_imports: true
```

#### `import_depth` (integer, optional, default: `1`)
**Status: Not yet implemented (placeholder)**

Maximum depth for recursive import resolution when `include_imports: true`.

- `1`: Only direct imports of the entrypoint
- `2`: Imports of imports
- `0` or negative: Unlimited depth (not recommended)

**Example:**
```yaml
include_imports: true
import_depth: 3    # Follow imports up to 3 levels deep
```

#### `include_relative_imports` (boolean, optional, default: `true`)
**Status: Not yet implemented (placeholder)**

Controls whether to include files imported with relative paths when `include_imports: true`.

- `true`: Include both `package:` and relative imports
- `false`: Only include `package:` imports

**Example:**
```yaml
include_imports: true
include_relative_imports: false    # Exclude relative imports like '../helper.dart'
```

## Complete Example

```yaml
astgen:
  convert:
    # Main application runners
    - entrypoints: lib/*.runner.dart
      exclude:
        - lib/*.test.dart
        - lib/*.g.dart
      output: project:tom_runtime/assets
      root: .
      preserve_structure: false
      include_sourcemap: true
      include_imports: false
      
    # Walker tools with preserved structure
    - entrypoints: example/walkers/bin/**/*.walker.dart
      exclude:
        - example/walkers/bin/**/*.test.dart
      output: project:tom_walkers_runtime/assets/walkers
      root: example/walkers/bin
      preserve_structure: true
      include_sourcemap: true
      include_imports: false
      
    # Utility scripts
    - entrypoints: tools/scripts/*.dart
      output: ../runtime_project/assets/scripts
      root: tools
      preserve_structure: false
      include_sourcemap: false
      include_imports: false
```

## Output Format

All generated files have the `.ast.yaml` extension:
- `my_tool.dart` → `my_tool.ast.yaml`
- `helper.runner.dart` → `helper.ast.yaml`

The AST is serialized as YAML containing:
- All declarations (classes, functions, variables)
- All statements and expressions
- Type information
- Metadata/annotations
- Optional sourcemap information

## Error Handling

**The tool always fails on errors:**
- Parse errors in source files cause immediate exit
- Missing projects in `project:name/path` notation cause immediate exit
- Invalid glob patterns cause immediate exit
- File I/O errors cause immediate exit

There are no "continue on error" options - all errors must be fixed.

## Running the Tool

```bash
# Use default build.yaml in current directory
dart run tom_d4rt_astgen:astgen

# Specify custom config file
dart run tom_d4rt_astgen:astgen -c my_build.yaml

# Dry run (show what would be done)
dart run tom_d4rt_astgen:astgen --dry-run

# Verbose output
dart run tom_d4rt_astgen:astgen -v

# Show help
dart run tom_d4rt_astgen:astgen --help
```

## Workspace Search Algorithm

For `project:name/path` notation:

1. Start from current directory
2. Navigate to parent directory
3. Search in:
   - Parent directory itself
   - All sibling directories (same level as current directory)
   - All subdirectories of siblings
4. For each directory found:
   - Check for `pubspec.yaml`
   - Read `name` field from pubspec
   - Match against requested project name
5. Return first matching project path
6. Fail if no project found

**Example workspace structure:**
```
workspace/
├── tom_d4rt_astgen/        ← Current directory
│   └── build.yaml
├── tom_runtime/            ← Found as sibling
│   └── pubspec.yaml (name: tom_runtime)
└── apps/
    └── tom_uam_client/     ← Found as nested directory
        └── pubspec.yaml (name: tom_uam_client)
```

Both `project:tom_runtime/assets` and `project:tom_uam_client/assets` will be resolved correctly.

## Tips

1. **Use project notation** for output paths to ensure portability across different workspace layouts
2. **Enable `include_sourcemap`** during development for better error tracking
3. **Use `preserve_structure`** when you need to maintain organization of generated files
4. **Use `exclude`** patterns to skip generated files (`.g.dart`, `.freezed.dart`)
5. **Run with `--dry-run`** first to verify file matching and output paths
6. **Use `--verbose`** to see detailed resolution and conversion information
