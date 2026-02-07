# D4rt Generator CLI User Guide

The D4rt Bridge Generator provides a command-line interface (CLI) called `d4rtgen` for generating bridges without using `build_runner`. This is useful for:

- Quick generation during development
- CI/CD pipelines where build_runner overhead is undesirable
- Projects that don't use build_runner
- Batch processing multiple projects in a workspace

## Installation

The CLI is included with the `tom_d4rt_generator` package. Add it as a dev dependency:

```bash
dart pub add --dev tom_d4rt_generator
```

## Basic Usage

```bash
# Generate bridges for current directory
d4rtgen

# Or run via dart run
dart run tom_d4rt_generator:d4rtgen
```

## Command-Line Options

| Option | Short | Description |
|--------|-------|-------------|
| `--version` | | Display the version of the D4rt Bridge Generator |
| `--project=<pattern>` | `-p` | Project(s) to process (comma-separated, globs: `tom_*`, `./*`) |
| `--config=<file>` | `-c` | Path to specific `d4rt_bridging.json` file |
| `--scan=<dir>` | `-s` | Scan directory for all D4rt projects |
| `--recursive` | `-r` | Recursively process subprojects within each project |
| `--exclude=<glob>` | `-x` | Glob patterns for projects to exclude from processing |
| `--recursion-exclude=<glob>` | `-R` | Glob patterns to exclude from recursive traversal |
| `--verbose` | `-v` | Show detailed output during generation |
| `--list` | `-l` | List projects that would be processed (no action) |
| `--help` | `-h` | Show usage help |

### Project Selection (`--project`)

The `--project` option supports multiple ways to specify projects:

- **Single project**: `--project=my_app`
- **Comma-separated**: `--project='project1,project2,project3'`
- **Glob patterns**: `--project='tom_*'` (matches projects starting with `tom_`)
- **Path globs**: `--project='xternal/tom_module_d4rt/*'`
- **Current directory children**: `--project='./*'`
- **Recursive from current directory**: `--project='./**/*'`

Multiple patterns can be combined: `--project='tom_*_builder,tom_d4rt_*'`

### Version Information

To display the version of the D4rt Bridge Generator:

```bash
d4rtgen --version
# or
d4rtgen version
```

Output example:

```
D4rt Bridge Generator 1.0.0+0
```

### Error Handling

When invalid options or unknown arguments are provided, the CLI displays an error message followed by the full help text:

```bash
d4rtgen --unknown-option
# Error: Could not find an option named '--unknown-option'
# [followed by help text]

d4rtgen unknownarg
# Error: Unknown arguments: unknownarg
# [followed by help text]
```

## Configuration Sources

The CLI reads configuration from multiple sources, in order of precedence:

### 1. Project-Local tom_build.yaml (Highest Priority)

When processing a project (via `--scan`, `--project`, or `--recursive`), the tool checks for a `tom_build.yaml` with a `dartgen:` section in that project's directory. **Project-local config takes precedence over command-line options** for that specific project.

### 2. Command-Line Arguments

Command-line options apply when no project-local config exists.

### 3. tom_build.yaml in Current Directory (Fallback)

If no command-line options are provided, the CLI looks for `tom_build.yaml` in the current directory:

```yaml
# tom_build.yaml
dartgen:
  scan: .
  recursive: true
  exclude:
    - "**/test_*"
    - "**/zom_*"
  recursion-exclude:
    - "**/node_modules/**"
    - "**/build/**"
  verbose: true
```

This allows you to configure the CLI once and run `d4rtgen` without arguments.

When processing subprojects with `--recursive` or `--scan`, the tool also looks for `tom_build.yaml` in each subproject directory. If found, the `dartgen:` settings are used for that specific subproject, allowing per-project customization.

## Path Containment Rules

**All paths must be within the current working directory or project directory:**

- Command-line options (`--project`, `--scan`, `--config`) can only reference paths within the current working directory
- Project-local `tom_build.yaml` files can only reference paths within that project's directory
- Patterns starting with `..` (parent directory references) are not allowed
- To process projects across multiple directories, run from the workspace root

### 3. build.yaml (Per-Project)

If a project has a `build.yaml` file with D4rt generator configuration, the CLI uses it:

```yaml
# build.yaml
targets:
  $default:
    builders:
      tom_d4rt_generator:d4rt_bridge_builder:
        options:
          name: my_package
          generateBarrel: true
          generateDartscript: true
          modules:
            - name: all
              barrelFiles:
                - lib/my_package.dart
              outputPath: lib/d4rt_bridges/
```

### 4. d4rt_bridging.json (Per-Project Fallback)

If no `build.yaml` is found, the CLI looks for `d4rt_bridging.json`:

```json
{
  "name": "my_package",
  "generateBarrel": true,
  "generateDartscript": true,
  "modules": [
    {
      "name": "all",
      "barrelFiles": ["lib/my_package.dart"],
      "outputPath": "lib/d4rt_bridges/"
    }
  ]
}
```

## Project Detection

A directory is considered a D4rt project if it contains:
- `pubspec.yaml`, AND
- Either `build.yaml` (with `tom_d4rt_generator` or `d4rt_bridge_builder` config)
- Or `d4rt_bridging.json`
- Or `tom_build.yaml` with a `dartgen:` section

## Usage Examples

### Generate for Current Project

```bash
# Uses build.yaml or d4rt_bridging.json in current directory
d4rtgen
```

### Generate for Specific Project

```bash
# Process a specific project directory
d4rtgen --project=example/user_reference

# With verbose output
d4rtgen -p example/user_reference -v
```

### Use Explicit Config File

```bash
# Specify a JSON config file directly
d4rtgen --config=path/to/d4rt_bridging.json
```

### Process Projects by Pattern

```bash
# Process all tom_* projects
d4rtgen --project='tom_*'

# Process multiple patterns (comma-separated)
d4rtgen --project='apps/*,packages/*'

# Process all projects in current directory
d4rtgen --project='./*'
```

### Scan Workspace for Projects

```bash
# Scan current directory (non-recursive)
d4rtgen --scan=.

# Recursive scan (finds projects in example/, test/, etc.)
d4rtgen --scan=. --recursive

# Recursive scan with exclusions
d4rtgen -s . -r -x "**/test_*" -x "**/zom_*"
```

### Process Project with Subprojects

```bash
# Process a project and all its subprojects
d4rtgen --project=my_monorepo --recursive

# With recursion exclusions (skip node_modules, build folders)
d4rtgen -p my_monorepo -r --recursion-exclude="**/node_modules/**" -R "**/build/**"
```

### Using tom_build.yaml

Create a `tom_build.yaml` in your workspace root:

```yaml
# tom_build.yaml
dartgen:
  scan: .
  recursive: true
  exclude:
    - "**/test_*"
    - "**/zom_*"
    - "**/example/*"
  recursion-exclude:
    - "**/node_modules/**"
    - "**/build/**"
    - "**/.dart_tool/**"
  verbose: false
```

Then just run:

```bash
d4rtgen
```

### Per-Project Configuration

When recursing into subprojects, each subproject can have its own `tom_build.yaml`:

```yaml
# subproject/tom_build.yaml
dartgen:
  # This overrides the parent settings for this subproject
  recursive: false
  verbose: true
```

## Output

### Normal Output

```
Processing project: example/user_reference
  Using configuration from d4rt_bridging.json

======================================================================
Bridge generation complete:
  Success: 1
======================================================================
```

### Verbose Output (`--verbose`)

```
Found 3 D4rt project(s):
  - example/user_reference
  - example/user_guide
  - example/userbridge_override

Processing project: example/user_reference
  Using configuration from d4rt_bridging.json
Processing: example/user_reference/d4rt_bridging.json
  Project: user_reference_example
  Modules: 1
  Generating module: all
    Generated 6 classes
  Generating barrel: example/user_reference/lib/d4rt_bridges.dart
  Generating dartscript: example/user_reference/lib/dartscript.dart
  ✓ Complete

...

======================================================================
Bridge generation complete:
  Success: 3
======================================================================
```

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | Error (config not found, generation failed, etc.) |

## CLI vs build_runner

| Feature | d4rtgen CLI | build_runner |
|---------|-------------|--------------|
| **Speed** | Faster (no watcher overhead) | Slower startup |
| **Configuration** | `tom_build.yaml`, `build.yaml`, or JSON | `build.yaml` only |
| **Batch Processing** | Yes (`--project='pattern'`, `--scan --recursive`) | Per-project only |
| **Glob Patterns** | Yes (`--project='tom_*'`, `--exclude`) | No |
| **Watch Mode** | No | Yes |
| **Incremental Builds** | No (always regenerates) | Yes |
| **Subproject Support** | Yes (with `--recursive`) | Manual |

**Recommendation:**
- Use CLI for quick generation, CI/CD, or batch processing
- Use build_runner for development with watch mode and incremental builds

## Integration with CI/CD

Example GitHub Actions workflow:

```yaml
- name: Generate D4rt Bridges
  run: |
    dart pub get
    d4rtgen --scan=. --recursive --exclude="**/test_*"
    dart analyze lib/generated/
```

## Troubleshooting

### "No D4rt configuration found"

The CLI couldn't find `build.yaml` or `d4rt_bridging.json` in the project directory.

**Solution:** Ensure one of these files exists in the project root.

### "No projects found matching patterns"

When using `--project` with patterns, no directories matching the pattern are D4rt projects.

**Solution:** 
- Check your pattern syntax
- Ensure matching directories have `pubspec.yaml` and D4rt config

### "No D4rt projects found"

When using `--scan`, no D4rt projects were found in the directory.

**Solution:** 
- Use `--recursive` to search subdirectories
- Verify your projects have `d4rt_bridging.json` or `build.yaml` with D4rt config

### Exclusions not working

Glob patterns may need adjustment based on relative paths.

**Solution:** 
- Use `**` for recursive matching
- Test with `--verbose` to see which projects are found

## See Also

- [Bridge Generator User Guide](bridgegenerator_user_guide.md) - Full configuration reference
- [Bridge Generator Configuration Reference](bridgegenerator_user_reference.md) - Detailed `build.yaml` options
- [User Bridge Guide](user_bridge_user_guide.md) - Manual bridge overrides
