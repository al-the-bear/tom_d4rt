# Tom D4rt AST Generator - Configuration and CLI Reference

This document covers both the `tom_build.yaml` configuration file and command-line interface options for the Tom D4rt AST Generator tool.

## Related Documentation

This tool uses the shared CLI infrastructure from **tom_build_base**:

- [CLI Tools Navigation](../../tom_build_base/doc/cli_tools_navigation.md) — Standard CLI commands, execution modes, and navigation options
- [Build Base User Guide](../../tom_build_base/doc/build_base_user_guide.md) — Configuration loading, project discovery, and workspace mode

## Configuration File: tom_build.yaml

The `tom_build.yaml` file is an optional configuration file placed in the project root that controls project discovery, default CLI options, and AST generation settings for the astgen tool.

### Location

```
my_project/
├── tom_build.yaml    # Optional configuration
├── build.yaml        # Optional: builder configuration
└── pubspec.yaml
```

### Structure

```yaml
# tom_build.yaml
astgen:
  project: .
  scan: ../
  recursive: true
  exclude:
    - '**/node_modules/**'
    - '**/build/**'
  recursion-exclude:
    - '**/.git/**'
  verbose: false
  output: lib/d4rt_ast.g.dart
```

### Configuration Fields

#### `project` (string, optional)

Path to a specific project to generate AST files for. Relative to the tom_build.yaml location.

**Default:** `.` (current directory)

**Examples:**
```yaml
project: .                    # Current directory
project: ../my_app            # Parent directory
project: packages/core        # Subdirectory
```

**CLI equivalent:** `--project` or `-p`

#### `scan` (string, optional)

Directory to scan for projects needing D4rt AST generation.

**Default:** Not set (no scanning)

**Examples:**
```yaml
scan: .                       # Scan current directory
scan: ../                     # Scan parent directory
scan: packages/               # Scan packages directory
```

**CLI equivalent:** `--scan` or `-s`

**Note:** When `scan` is set, the tool will search for all projects with `build.yaml` files containing `tom_d4rt_astgen:astgen` configuration.

#### `recursive` (boolean, optional)

Whether to recursively process subprojects found during scanning.

**Default:** `false`

**Examples:**
```yaml
recursive: true               # Process subprojects
recursive: false              # Only top-level projects
```

**CLI equivalent:** `--recursive` or `-r`

#### `exclude` (list, optional)

Glob patterns for projects to exclude from processing.

**Default:** `[]` (no exclusions)

**Examples:**
```yaml
exclude:
  - '**/node_modules/**'      # Skip node_modules
  - '**/build/**'             # Skip build directories
  - '**/.dart_tool/**'        # Skip Dart tool cache
  - '**/test/**'              # Skip test directories
  - '**/example/**'           # Skip example projects
```

**CLI equivalent:** `--exclude` or `-e`

**Pattern syntax:** Uses glob patterns with `*` (any characters except /) and `**` (any characters including /)

#### `recursion-exclude` (list, optional)

Glob patterns to exclude from recursive directory traversal. Unlike `exclude`, these patterns prevent the tool from even looking inside matching directories.

**Default:** `[]` (no recursion exclusions)

**Examples:**
```yaml
recursion-exclude:
  - '**/.git/**'              # Don't traverse .git directories
  - '**/node_modules/**'      # Don't traverse node_modules
  - '**/.dart_tool/**'        # Don't traverse Dart cache
```

**CLI equivalent:** `--recursion-exclude`

**Use case:** Performance optimization - skip directories that definitely don't contain projects.

#### `verbose` (boolean, optional)

Enable detailed output showing generation progress and analyzed classes.

**Default:** `false`

**Examples:**
```yaml
verbose: true                 # Show detailed output
verbose: false                # Show summary only
```

**CLI equivalent:** `--verbose` or `-v`

#### `output` (string, optional)

Path for the generated AST file, relative to project root.

**Default:** `lib/d4rt_ast.g.dart`

**Examples:**
```yaml
output: lib/d4rt_ast.g.dart       # Default location
output: lib/src/ast.g.dart        # Custom location
output: lib/generated/ast.g.dart  # Subdirectory
```

**CLI equivalent:** `--output`

**Note:** This can also be configured in `build.yaml` if using the builder integration.

### Complete Example

```yaml
# tom_build.yaml
astgen:
  # Scan the workspace for projects
  scan: ../
  recursive: true
  
  # Exclude unnecessary directories
  exclude:
    - '**/node_modules/**'
    - '**/build/**'
    - '**/.dart_tool/**'
    - '**/test/**'
    - '**/example/**'
  
  # Don't even look inside these directories
  recursion-exclude:
    - '**/.git/**'
    - '**/node_modules/**'
  
  # AST file settings
  output: lib/d4rt_ast.g.dart
  
  # Show detailed output
  verbose: true
```

## Command-Line Interface

### Basic Usage

```bash
# Run with tom_build.yaml configuration
dart run tom_d4rt_astgen:astgen

# Override configuration with CLI options
dart run tom_d4rt_astgen:astgen --project=my_app --verbose

# Scan for projects
dart run tom_d4rt_astgen:astgen --scan=. --recursive
```

### CLI Options

#### `-p, --project <pattern>`

Project(s) to generate AST files for. Supports comma-separated values and glob patterns.

**Patterns:**
- **Single project**: `--project=my_app`
- **Comma-separated**: `--project='project1,project2,project3'`
- **Glob patterns**: `--project='tom_*'` (matches projects starting with `tom_`)
- **Path globs**: `--project='xternal/tom_module_d4rt/*'`
- **Current directory children**: `--project='./*'`
- **Recursive from current directory**: `--project='./**/*'`

**Examples:**
```bash
dart run tom_d4rt_astgen:astgen --project=.
dart run tom_d4rt_astgen:astgen -p ../my_app
dart run tom_d4rt_astgen:astgen --project=packages/core
dart run tom_d4rt_astgen:astgen --project='tom_*_builder,my_app'
dart run tom_d4rt_astgen:astgen --project='./*'
```

**Overrides:** `astgen.project` in tom_build.yaml

#### `-s, --scan <path>`

Directory to scan for projects needing D4rt AST files.

**Examples:**
```bash
dart run tom_d4rt_astgen:astgen --scan=.
dart run tom_d4rt_astgen:astgen -s ../
dart run tom_d4rt_astgen:astgen --scan=packages/
```

**Overrides:** `astgen.scan` in tom_build.yaml

#### `-r, --recursive`

Process subprojects recursively.

**Examples:**
```bash
dart run tom_d4rt_astgen:astgen --scan=. --recursive
dart run tom_d4rt_astgen:astgen -s ../ -r
```

**Overrides:** `astgen.recursive` in tom_build.yaml

#### `-e, --exclude <pattern>`

Glob pattern for projects to exclude. Can be specified multiple times.

**Examples:**
```bash
dart run tom_d4rt_astgen:astgen --scan=. --exclude='**/test/**'
dart run tom_d4rt_astgen:astgen -e '**/node_modules/**' -e '**/build/**'
```

**Overrides:** `astgen.exclude` in tom_build.yaml

#### `--recursion-exclude <pattern>`

Glob pattern to exclude from recursive traversal. Can be specified multiple times.

**Examples:**
```bash
dart run tom_d4rt_astgen:astgen --scan=. --recursion-exclude='**/.git/**'
dart run tom_d4rt_astgen:astgen --recursion-exclude='**/node_modules/**'
```

**Overrides:** `astgen.recursion-exclude` in tom_build.yaml

#### `--output <path>`

Path for the generated AST file (relative to project root).

**Examples:**
```bash
dart run tom_d4rt_astgen:astgen --output=lib/ast.g.dart
dart run tom_d4rt_astgen:astgen --output=lib/src/d4rt_ast.g.dart
```

**Overrides:** `astgen.output` in tom_build.yaml

#### `-v, --verbose`

Show detailed output including analyzed classes and generated registrations.

**Examples:**
```bash
dart run tom_d4rt_astgen:astgen --verbose
dart run tom_d4rt_astgen:astgen -v --scan=.
```

**Overrides:** `astgen.verbose` in tom_build.yaml

**Verbose output includes:**
- Projects being processed
- Classes being analyzed
- Annotations detected
- Generated registration calls
- Output file paths

#### `-h, --help`

Display help message with all available options.

**Example:**
```bash
dart run tom_d4rt_astgen:astgen --help
```

### Workspace Navigation Options

These options provide consistent workspace traversal behavior across all Tom build tools (astgen, d4rtgen, versioner, compiler, etc.).

#### `-R, --root [path]`

Run from the workspace root. When used without a path argument (bare `-R`), the tool automatically detects the workspace root by looking for `tom_workspace.yaml`, `tom.code-workspace`, or `buildkit_master.yaml`. When used with a path, specifies the workspace root explicitly.

**Examples:**
```bash
# Auto-detect workspace root
dart run tom_d4rt_astgen:astgen -R -l

# Specify workspace root
dart run tom_d4rt_astgen:astgen -R /path/to/workspace -r
```

**Use case:** Run the tool from any subdirectory while processing the entire workspace.

#### `-b, --build-order`

Sort projects in dependency build order before processing. Projects that depend on others will be processed after their dependencies.

**Examples:**
```bash
dart run tom_d4rt_astgen:astgen --scan=. --recursive --build-order
dart run tom_d4rt_astgen:astgen -R -b
```

**Use case:** Ensure dependent projects are processed in the correct order.

#### `-w, --workspace-recursion`

Shell out to sub-workspaces instead of skipping them. Sub-workspaces are directories containing their own `buildkit_master.yaml`.

**Examples:**
```bash
dart run tom_d4rt_astgen:astgen -R -w
```

**Use case:** Process projects across sub-workspaces in a multi-workspace setup.

#### `-i, --inner-first-git`

Scan for git repositories and process the innermost (deepest nested) repository first.

**Examples:**
```bash
dart run tom_d4rt_astgen:astgen --scan=. -i
```

**Use case:** Process nested git repos depth-first.

#### `-o, --outer-first-git`

Scan for git repositories and process the outermost (shallowest) repository first.

**Examples:**
```bash
dart run tom_d4rt_astgen:astgen --scan=. -o
```

**Use case:** Process git repos in breadth-first order.

#### `-x, --exclude <pattern>`

Exclude patterns (path-based globs). Can be specified multiple times.

**Examples:**
```bash
dart run tom_d4rt_astgen:astgen -R -x '**/test/**' -x '**/example/**'
```

#### `--exclude-projects <pattern>`

Exclude projects by name or path. More specific than `--exclude`, matching project names rather than paths.

**Examples:**
```bash
dart run tom_d4rt_astgen:astgen -R --exclude-projects='zom_*,test_*'
dart run tom_d4rt_astgen:astgen --exclude-projects='xternal/tom_module_basics/*'
```

#### `--recursion-exclude <pattern>`

Glob patterns to exclude during recursive directory traversal.

**Examples:**
```bash
dart run tom_d4rt_astgen:astgen --scan=. --recursion-exclude='**/.git/**'
```

### Default Behavior

When no explicit navigation options are provided, the tool applies these defaults:
- `--scan .` (scan current directory)
- `--recursive` (enabled)
- `--build-order` (enabled)

This means running `astgen` without arguments is equivalent to:
```bash
dart run tom_d4rt_astgen:astgen --scan=. --recursive --build-order
```

## Configuration Priority

When the same option is specified in multiple places, the priority order is:

1. **CLI arguments** (highest priority)
2. **tom_build.yaml file**
3. **build.yaml file** (for `output` only)
4. **Default values** (lowest priority)

**Example:**
```yaml
# tom_build.yaml
astgen:
  output: lib/d4rt_ast.g.dart
  verbose: false
```

```bash
# CLI overrides verbose, uses output from config
dart run tom_d4rt_astgen:astgen --verbose
# Result: output=lib/d4rt_ast.g.dart, verbose=true
```

## Usage Patterns

### Pattern 1: Single Project

Generate AST file for a specific project:

```bash
dart run tom_d4rt_astgen:astgen --project=my_app
```

Or with configuration:
```yaml
# tom_build.yaml
astgen:
  project: .
  output: lib/d4rt_ast.g.dart
```

```bash
dart run tom_d4rt_astgen:astgen
```

### Pattern 2: Workspace Scanning

Generate AST files for all projects in a workspace:

```bash
dart run tom_d4rt_astgen:astgen --scan=. --recursive --exclude='**/test/**'
```

Or with configuration:
```yaml
# tom_build.yaml (in workspace root)
astgen:
  scan: .
  recursive: true
  exclude:
    - '**/test/**'
    - '**/example/**'
```

```bash
dart run tom_d4rt_astgen:astgen
```

### Pattern 3: Pre-Build AST Generation

Generate AST files before building:

```bash
#!/bin/bash
# build.sh
dart run tom_d4rt_astgen:astgen --scan=packages --recursive
dart run build_runner build
dart compile exe bin/app.dart
```

### Pattern 4: CI/CD Integration

In CI/CD scripts:

```bash
#!/bin/bash
# ci_build.sh
dart run tom_d4rt_astgen:astgen \
  --scan=packages \
  --recursive \
  --exclude='**/test/**' \
  --verbose
```

### Pattern 5: Selective Projects

Generate AST files only for specific projects:

```bash
dart run tom_d4rt_astgen:astgen --project=packages/core
dart run tom_d4rt_astgen:astgen --project=packages/utils
```

### Pattern 6: Custom Output Location

Generate AST files in a custom directory:

```yaml
# tom_build.yaml
astgen:
  scan: packages/
  output: lib/generated/d4rt_ast.g.dart
```

## Integration with build_runner

The AST generator can be integrated into your build_runner pipeline:

```yaml
# build.yaml
targets:
  $default:
    builders:
      tom_d4rt_astgen:astgen:
        enabled: true
        options:
          output: lib/d4rt_ast.g.dart
```

**Note:** This is in addition to the standalone CLI tool. The builder runs automatically with `build_runner`, while the CLI tool is run manually or in scripts.

## Generated File Structure

The tool generates a `d4rt_ast.g.dart` file with:

```dart
// GENERATED FILE - DO NOT EDIT
// Generated by D4rt AST Generator at 2026-02-06T10:30:45.123Z

import 'package:tom_d4rt/tom_d4rt.dart';

// Imports for analyzed classes
import 'package:my_package/my_class.dart';
import 'package:my_package/other_class.dart';

/// Registers all D4rt-annotated classes with the D4rt runtime.
/// 
/// Call this function in your D4rt initialization code to make
/// all classes available for instantiation and manipulation in
/// the D4rt scripting environment.
void registerD4rtClasses() {
  // Registration calls for each class
  D4rtRuntime.registerClass<MyClass>();
  D4rtRuntime.registerClass<OtherClass>();
}
```

## Project Discovery

A project is considered an "astgen project" if it:
1. Contains a `pubspec.yaml` file
2. Contains either:
   - A `tom_build.yaml` file with `astgen:` section, or
   - A `build.yaml` file with `tom_d4rt_astgen:astgen` configuration
3. Is not a builder definition project itself

## Troubleshooting

### "No projects found to process"

**Cause:** No projects with AST generator configuration found.

**Solutions:**
1. Verify `build.yaml` contains `tom_d4rt_astgen:astgen` configuration
2. Check `scan` path is correct
3. Verify projects aren't excluded by `exclude` patterns
4. Use `--verbose` to see which directories are being scanned

### Configuration not loading

**Cause:** tom_build.yaml not found or has syntax errors.

**Solutions:**
1. Verify file is named exactly `tom_build.yaml` (not `tom-build.yaml` or `tom_build.yml`)
2. Check YAML syntax with a validator
3. Ensure file is in the project root or working directory
4. Use `--verbose` to see which configuration is loaded

### No classes being registered

**Possible causes:**
1. No classes have D4rt annotations
2. Source files not in lib/ directory
3. Import statements incorrect in source files

**Solutions:**
- Verify classes have `@D4rtClass()` or similar annotations
- Check classes are in lib/ directory
- Use `--verbose` to see which classes are detected
- Review generated file to see what was found

### Generated file empty or missing registrations

**Cause:** No classes with D4rt annotations found.

**Solutions:**
- Add D4rt annotations to classes that should be scriptable:
  ```dart
  import 'package:tom_d4rt/tom_d4rt.dart';
  
  @D4rtClass()
  class MyClass {
    @D4rtMethod()
    void myMethod() { }
  }
  ```
- Verify annotations are properly imported
- Use `--verbose` to see analysis results

### Import errors in generated file

**Cause:** Generated imports don't match package structure.

**Solutions:**
- Ensure source classes are in lib/ directory
- Verify package name in pubspec.yaml is correct
- Check that classes are public (not private with underscore)

### Patterns not matching expected projects

**Cause:** Glob pattern syntax issues.

**Solutions:**
1. Use `**` for recursive matching: `**/test/**` not `*/test/**`
2. Always use forward slashes `/` even on Windows
3. Quote patterns in shell: `--exclude='**/test/**'`
4. Test patterns with `--verbose`

## Best Practices

1. **Generate before building**
   ```bash
   dart run tom_d4rt_astgen:astgen
   dart run build_runner build
   ```

2. **Add generated files to .gitignore**
   ```gitignore
   **/d4rt_ast.g.dart
   ```

3. **Use consistent output paths**
   ```yaml
   output: lib/d4rt_ast.g.dart
   ```

4. **Call registration in initialization**
   ```dart
   import 'package:my_package/d4rt_ast.g.dart';
   
   void main() {
     registerD4rtClasses();
     D4rtRuntime.start();
   }
   ```

5. **Scan at workspace level**
   ```yaml
   # workspace root tom_build.yaml
   astgen:
     scan: .
     recursive: true
     exclude:
       - '**/test/**'
       - '**/example/**'
   ```

6. **Use verbose for debugging**
   ```bash
   dart run tom_d4rt_astgen:astgen --verbose
   ```

## See Also

- [User Guide](astgen_build_yaml.md) - Complete usage documentation
- [build.yaml Configuration](astgen_build_yaml.md) - Builder configuration
- [D4rt Annotations](https://pub.dev/packages/tom_d4rt) - Available annotations
