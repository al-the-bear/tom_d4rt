````markdown
# D4rt Generator Build Guidelines

This document provides build, test, and publishing guidelines for the `tom_d4rt_generator` package.

## Project Structure

```
tom_d4rt_generator/
├── lib/
│   ├── builder.dart           # build_runner integration
│   ├── cli.dart               # CLI exports
│   ├── tom_bridge_generator.dart  # Generator exports
│   ├── tom_d4rt_generator.dart    # Package exports
│   └── src/
│       ├── bridge_generator.dart  # Core generator logic
│       ├── config/                # Configuration parsing
│       └── ...
├── bin/
│   └── d4rt_generator.dart    # CLI entry point
├── example/                    # Example project with test classes
├── test/                       # Unit tests
├── doc/                        # Documentation
├── _copilot_guidelines/        # This folder
├── pubspec.yaml
├── build.yaml                  # Build runner config
├── README.md
├── CHANGELOG.md
└── analysis_options.yaml
```

## Development Workflow

### Prerequisites

```bash
# Ensure dependencies are fetched
dart pub get
```

### Running Analyzer

```bash
# Analyze entire package
dart analyze

# Analyze specific directories
dart analyze lib/
dart analyze example/
dart analyze test/
```

### Running Tests

```bash
# Run all tests
dart test

# Run specific test file
dart test test/generator_test.dart

# Run tests with verbose output
dart test --reporter=expanded
```

### Running the CLI

```bash
# Generate bridges for example project
dart run bin/d4rt_generator.dart --project=example

# Show help
dart run bin/d4rt_generator.dart --help

# Scan for projects with d4rt_bridging.json
dart run bin/d4rt_generator.dart --scan=. --recursive
```

### Running Examples

The example folder is itself a Dart project demonstrating bridge generation:

```bash
# Navigate to example
cd example

# Fetch dependencies
dart pub get

# Generate bridges (from parent directory)
cd ..
dart run bin/d4rt_generator.dart --project=example

# Run D4rt scripts with generated bridges
cd example
dart run run_examples.dart all
```

## Testing Generated Bridges

The example project includes test classes and generated bridges:

| Directory | Purpose |
|-----------|---------|
| `example/lib/test_classes/` | Source classes to be bridged |
| `example/lib/d4rt_bridges/` | Generated bridge files |
| `example/scripts/` | D4rt scripts that use the bridges |
| `example/test/` | Unit tests for bridges |

## Publishing

### Pre-Publish Checklist

1. **Update version** in `pubspec.yaml`
2. **Update CHANGELOG.md** with changes
3. **Run all tests**: `dart test`
4. **Run analyzer**: `dart analyze`
5. **Verify example bridges generate**: Re-run generator on example
6. **Verify example scripts work**: `cd example && dart run run_examples.dart all`
7. **Update documentation** if API or configuration changed
8. **Commit all changes** to submodule

### Publishing Steps

```bash
# Dry run to check for issues
dart pub publish --dry-run

# Publish to pub.dev
dart pub publish

# Update parent repo submodule reference
cd ../../..
git add xternal/tom_module_d4rt
git commit -m "Update tom_module_d4rt submodule to vX.Y.Z"
```

### Version Numbering

Follow semantic versioning:
- **Major** (X.0.0): Breaking changes to generated code format, config schema, or public API
- **Minor** (0.X.0): New features, new config options, backward-compatible
- **Patch** (0.0.X): Bug fixes, improved generation, no API changes

## Regenerating Example Bridges

After making changes to the generator:

```bash
# From tom_d4rt_generator directory
dart run bin/d4rt_generator.dart --project=example

# Verify generated bridges compile
cd example && dart analyze lib/d4rt_bridges/

# Verify example scripts still work
dart run run_examples.dart all
```

## Build Runner Integration

The package can also be used via build_runner:

```bash
# In a project with build.yaml configured
dart run build_runner build --delete-conflicting-outputs

# Watch mode
dart run build_runner watch
```

````
