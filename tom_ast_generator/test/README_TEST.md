# AST Generator Test Projects

This directory contains sample projects for testing the `astgen` CLI tool.

## Directory Structure

```
test/
├── astgen_test_project/          # Source project with files to convert
│   ├── build.yaml                # astgen configuration
│   ├── pubspec.yaml
│   ├── lib/
│   │   ├── main.runner.dart      # Root-level runner
│   │   ├── generated.g.dart      # Should be excluded
│   │   ├── tools/
│   │   │   ├── tool.runner.dart
│   │   │   └── tool.test.dart    # Should be excluded
│   │   └── utils/
│   │       └── helper.runner.dart
│   ├── example/walkers/bin/
│   │   ├── filesystem.walker.dart
│   │   └── metrics.walker.dart
│   └── tools/scripts/
│       └── cleanup.dart
│
├── astgen_test_output/           # Output project (receives generated ASTs)
│   ├── pubspec.yaml
│   ├── assets/                   # Flat output
│   ├── assets/structured/        # Structured output
│   ├── walkers/                  # Walker ASTs
│   └── scripts/                  # Script ASTs
│
└── README_TEST.md                # This file
```

## Test Files

### Runner Files (*.runner.dart)
- `lib/main.runner.dart` - Simple calculator with classes and enums
- `lib/tools/tool.runner.dart` - Data processor with async/await and extensions
- `lib/utils/helper.runner.dart` - String utilities with mixins

### Walker Files (*.walker.dart)
- `example/walkers/bin/filesystem.walker.dart` - File system traversal with async operations
- `example/walkers/bin/metrics.walker.dart` - Code metrics analyzer with typedefs

### Script Files
- `tools/scripts/cleanup.dart` - Utility script without special suffix

### Excluded Files
- `lib/generated.g.dart` - Generated file (matches `*.g.dart` exclude pattern)
- `lib/tools/tool.test.dart` - Test file (matches `*.test.dart` exclude pattern)

## Configuration Tests

The `build.yaml` defines 4 different conversion configurations:

### Test 1: Basic Flat Output
```yaml
- entrypoints: lib/*.runner.dart
  output: project:astgen_test_output/assets
  root: .
  preserve_structure: false
  include_sourcemap: true
```

**Expected behavior:**
- Converts only `lib/main.runner.dart` (not nested files)
- Outputs to `astgen_test_output/assets/` (flat)
- Includes sourcemap metadata
- Result: `main.ast.yaml`

### Test 2: Nested with Structure Preservation
```yaml
- entrypoints: lib/**/*.runner.dart
  exclude:
    - lib/**/*.g.dart
    - lib/**/*.test.dart
  output: project:astgen_test_output/assets/structured
  root: lib
  preserve_structure: true
  include_sourcemap: true
```

**Expected behavior:**
- Converts all `*.runner.dart` files recursively in `lib/`
- Excludes `*.g.dart` and `*.test.dart` files
- Preserves directory structure relative to `lib/`
- Includes sourcemap metadata
- Results:
  - `main.ast.yaml`
  - `tools/tool.ast.yaml`
  - `utils/helper.ast.yaml`

### Test 3: Walker Files
```yaml
- entrypoints: bin/*.walker.dart
  output: project:astgen_test_output/walkers
  root: example/walkers
  preserve_structure: false
  include_sourcemap: false
```

**Expected behavior:**
- Converts walker files with custom root
- Flat output (no structure preservation)
- No sourcemap metadata
- Results:
  - `filesystem.ast.yaml`
  - `metrics.ast.yaml`

### Test 4: Script Files with Relative Path
```yaml
- entrypoints: scripts/*.dart
  output: ../astgen_test_output/scripts
  root: tools
  preserve_structure: false
  include_sourcemap: false
```

**Expected behavior:**
- Uses relative output path instead of project notation
- Converts script files
- Result: `cleanup.ast.yaml`

## Running the Tests

### Prerequisites

Make sure you're in the test project directory:
```bash
cd test/astgen_test_project
```

### Run All Conversions

```bash
dart run ../../bin/astgen.dart
```

### Run with Verbose Output

```bash
dart run ../../bin/astgen.dart -v
```

### Dry Run (See What Would Happen)

```bash
dart run ../../bin/astgen.dart --dry-run
```

### Test Specific Features

#### Test Exclude Patterns
```bash
# Should NOT find generated.g.dart or tool.test.dart
dart run ../../bin/astgen.dart -v
```

Check output - should see:
- "Excluding: lib/generated.g.dart"
- "Excluding: lib/tools/tool.test.dart"

#### Test preserve_structure
Compare these two outputs:
```bash
# Flat output
ls ../astgen_test_output/assets/

# Structured output
find ../astgen_test_output/assets/structured/ -name "*.ast.yaml"
```

#### Test include_sourcemap
```bash
# Check if sourcemap is included
head -n 5 ../astgen_test_output/assets/main.ast.yaml
```

Should see:
```yaml
sourcemap:
  source_file: /absolute/path/to/main.runner.dart
  generated_at: 2026-02-06T...
ast:
  # ... AST content
```

#### Test project: Notation
```bash
# Should successfully resolve astgen_test_output project
dart run ../../bin/astgen.dart -v 2>&1 | grep "Found project"
```

Should see:
- "Found project "astgen_test_output" at: ..."

## Expected Output Files

After successful conversion, you should have:

```
astgen_test_output/
├── assets/
│   └── main.ast.yaml                    # Test 1: flat output
├── assets/structured/
│   ├── main.ast.yaml                    # Test 2: with structure
│   ├── tools/
│   │   └── tool.ast.yaml
│   └── utils/
│       └── helper.ast.yaml
├── walkers/
│   ├── filesystem.ast.yaml              # Test 3: walkers
│   └── metrics.ast.yaml
└── scripts/
    └── cleanup.ast.yaml                 # Test 4: scripts
```

## Verification

### Check File Count
```bash
# Should have exactly 8 total AST files
find ../astgen_test_output -name "*.ast.yaml" | wc -l
```

### Check Sourcemap Presence
```bash
# Test 1 and 2 should have sourcemaps
grep -l "sourcemap:" ../astgen_test_output/assets/main.ast.yaml
grep -l "sourcemap:" ../astgen_test_output/assets/structured/main.ast.yaml

# Test 3 and 4 should NOT have sourcemaps
grep -L "sourcemap:" ../astgen_test_output/walkers/filesystem.ast.yaml
grep -L "sourcemap:" ../astgen_test_output/scripts/cleanup.ast.yaml
```

### Check Structure Preservation
```bash
# Test 2 should preserve directory structure
test -f ../astgen_test_output/assets/structured/tools/tool.ast.yaml && echo "PASS: Structure preserved"

# Test 1 should be flat
test ! -d ../astgen_test_output/assets/tools && echo "PASS: Flat structure"
```

### Validate YAML Format
```bash
# All files should be valid YAML
for file in $(find ../astgen_test_output -name "*.ast.yaml"); do
    echo "Checking $file..."
    # This will fail if YAML is invalid
    dart run ../../bin/astgen.dart -c /dev/null 2>&1 || echo "Invalid YAML in $file"
done
```

## Cleanup

To remove generated files:
```bash
rm -rf ../astgen_test_output/assets/*
rm -rf ../astgen_test_output/walkers/*
rm -rf ../astgen_test_output/scripts/*
```

## Troubleshooting

### "Project not found" Error
Make sure you're running from `test/astgen_test_project/`:
```bash
pwd  # Should end with test/astgen_test_project
```

### Parse Errors
Check that all source files are valid Dart:
```bash
dart analyze lib/ example/ tools/
```

### No Files Matched
Run with `-v` to see glob pattern matching:
```bash
dart run ../../bin/astgen.dart -v
```

## Adding More Test Cases

To add new test cases:

1. Create new source files in appropriate directories
2. Update `build.yaml` with new conversion configuration
3. Update this README with expected behavior
4. Run and verify output

## Notes

- The `include_imports` feature is not yet implemented (placeholder)
- All parse errors cause immediate failure (no partial conversion)
- The tool automatically creates output directories if they don't exist
- File extensions are always changed to `.ast.yaml`
