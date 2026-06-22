# D4rt Build Guidelines

This document provides build, test, and publishing guidelines for the `tom_d4rt` package.

## Project Structure

```
tom_d4rt/
├── lib/
│   ├── d4rt.dart              # Main exports
│   ├── tom_d4rt.dart          # Package exports
│   └── src/
│       ├── d4rt_base.dart     # D4rt class
│       ├── bridge/            # Bridging infrastructure
│       ├── stdlib/            # Standard library implementations
│       └── ...
├── example/                    # Example files
├── test/                       # Test files
├── doc/                        # Documentation
├── _copilot_guidelines/        # This folder
├── pubspec.yaml
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
dart test test/bridge/bridged_class_test.dart

# Run tests with verbose output
dart test --reporter=expanded
```

### Running Examples

```bash
# Run a specific example
dart run example/basic_execution_example.dart

# Run all examples (to verify they work)
for f in example/*.dart; do dart run "$f"; done
```

## Publishing

### Pre-Publish Checklist

1. **Update version** in `pubspec.yaml`
2. **Update CHANGELOG.md** with changes
3. **Run all tests**: `dart test`
4. **Run analyzer**: `dart analyze`
5. **Verify examples work**: Run each example file
6. **Update documentation** if API changed
7. **Commit all changes** to submodule

### Publishing Steps

```bash
# Dry run to check for issues
dart pub publish --dry-run

# Publish to pub.dev
dart pub publish

# Update parent repo submodule reference
cd ../../..
git add tom_ai/d4rt
git commit -m "Update d4rt submodule to vX.Y.Z"
```

### Version Numbering

Follow semantic versioning:
- **MAJOR** - Breaking API changes
- **MINOR** - New features, backward compatible
- **PATCH** - Bug fixes, backward compatible

Current version: **1.5.0**

## Related Packages

When making changes that affect both packages:

1. `tom_d4rt` - The interpreter
2. `tom_d4rt_generator` - The code generator

Ensure they are compatible:
- Generator should reference compatible D4rt version
- Test generated code with current D4rt

## Common Issues

### Submodule Workflow

The `tom_d4rt` package is in the `tom_ai/d4rt` directory.

```bash
# Navigate to project
cd tom_ai/d4rt/tom_d4rt

# Make changes, commit
git add .
git commit -m "Description of changes"

# Push changes
git push

# Update parent repo
cd ../../..
git add tom_ai/d4rt
git commit -m "Update d4rt submodule"
```

### Analyzer Issues

If you see analyzer errors related to types:

1. Ensure all imports are correct
2. Check that `RuntimeType`, `InterpreterVisitor` etc. are properly imported
3. Verify function signatures match typedefs in `registration.dart`

### Test Failures

For bridge-related test failures:

1. Check that bridge adapters have correct signatures
2. Verify argument validation in constructors/methods
3. Check that return values are properly typed
