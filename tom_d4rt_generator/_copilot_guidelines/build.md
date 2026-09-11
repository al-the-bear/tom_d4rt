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
│   └── d4rtgen.dart          # CLI entry point (d4rtgen)
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
# Generate bridges for one example project
dart run bin/d4rtgen.dart -s example/user_guide

# Show help
dart run bin/d4rtgen.dart --help

# Scan for projects recursively
dart run bin/d4rtgen.dart --scan=. --recursive

# Select a project by its pubspec name within a scan
dart run bin/d4rtgen.dart -s example -r --project=user_guide_example

# List what a scan would process, without generating
dart run bin/d4rtgen.dart -s example -r --list

# Exclude certain projects
dart run bin/d4rtgen.dart --scan=. -r --exclude="**/test_*"

# Recursion exclusions (skip directories during traversal)
dart run bin/d4rtgen.dart --scan=. -r --recursion-exclude="**/node_modules/**"
```

**Important Path Rules:**
- All paths must be within the current working directory
- Project-local `buildkit.yaml` (`d4rtgen:` section) takes precedence over CLI options
- To access multiple directories, run from the workspace root

### Running Examples

The example folder has several Dart projects demonstrating bridge generation.
From the `tom_d4rt_generator` directory:

```bash
# Regenerate every example's bridges, then run its scripts
dart run example/run_all_examples.dart

# Run the scripts against the committed bridges only
dart run example/run_all_examples.dart --run-only

# Regenerate one example
dart run bin/d4rtgen.dart -s example/<name>
```

`test/example_resolution_test.dart` resolves every example first, so a fresh
checkout needs no manual `dart pub get` inside them.

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

1. **Bump the version and the stamp together**, from this package's
   directory, with the current BuildKit (`tom_binaries/tom/<platform>/buildkit`):

   ```bash
   buildkit -p . :bumpversion --minor=. --versioner   # --major=. / no flag = patch
   ```

   `--versioner` rewrites `lib/src/version.versioner.dart`, which is what
   `d4rtgen --version` prints. The `--minor=` value is matched against the
   project path BuildKit prints (`.` here); a value that matches nothing falls
   back to a PATCH bump without saying so, so check the `(minor)` in its
   output. After a hand edit of `pubspec.yaml`, run `buildkit -v -p .
   :versioner` instead — an older BuildKit writes `lib/src/version.g.dart` and
   leaves the banner behind, so use the current one.
2. **Update CHANGELOG.md** with changes
3. **Run all tests**: `dart test` — `test/version_stamp_test.dart` fails when
   the stamp and `pubspec.yaml` disagree, and the example freshness and
   resolution tests run too
4. **Run analyzer**: `dart analyze`
5. **Verify example scripts work**: `dart run example/run_all_examples.dart --run-only`
6. **Update documentation** if API or configuration changed
7. **Commit and push**

### Publishing Steps

```bash
# Dry run to check for issues
dart pub publish --dry-run

# Publish to pub.dev
dart pub publish
```

### After Publishing: Move the Consumers

`pub get` is lock-preserving: a consumer whose floor admits the new version
keeps its old lock until someone runs `pub upgrade`, so a publish reaches no
consumer by itself. `tom_d4rt_ast/test/scc45_resolution_guard_test.dart`
F-SCC45-2 lists every package on this machine whose lock is behind the newest
cached version — run it once the release is in the cache (after the first
`pub upgrade` anywhere), then in each package it names:

```bash
dart pub upgrade tom_d4rt_generator     # flutter pub upgrade in the Flutter twins
```

Raise a consumer's floor only when it needs something the release adds; the
lock is what has to move.

### After Publishing: Rebuild the Binary

`d4rtgen` on a login PATH is the precompiled binary in `tom_binaries`, not this
source, so a release does not reach it until it is rebuilt:

```bash
TOM_BINARY_PATH=<workspace>/tom_binaries/tom buildkit -p . :compiler --all-platforms
```

That builds darwin-arm64 and the three Linux targets; win32-x64 only builds on
the Windows host. Set `TOM_BINARY_PATH` explicitly — a shell profile may point
it at a different clone. Confirm `d4rtgen --version` reports the release, then
commit only the `d4rtgen` files in `tom_binaries`.

### Version Numbering

Follow semantic versioning:
- **Major** (X.0.0): Breaking changes to generated code format, config schema, or public API
- **Minor** (0.X.0): New features, new config options, backward-compatible
- **Patch** (0.0.X): Bug fixes, improved generation, no API changes

## Regenerating Example Bridges

After a generator change that alters its output, the examples go stale, and
`test/example_bridges_fresh_test.dart` says which. From the `tom_d4rt_generator`
directory:

```bash
# One example
dart run bin/d4rtgen.dart -s example/<name>

# All of them
dart run example/generate_example_bridges.dart

# Verify the example scripts still work
dart run example/run_all_examples.dart --run-only
```

Commit everything the regeneration changes, including any new
`relaxers.b.dart`, and delete the regenerated examples from `knownStale` in
`test/example_bridges_fresh_test.dart` in the same commit.

## Recompiling the d4rtgen Binary

After making source changes to tom_d4rt_generator, recompile the binary with:

```bash
# From the tom_d4rt_generator directory:
buildkit -R --project tom_d4rt_generator build
```

This compiles the d4rtgen binary and places it in the tom_binaries repository.
After recompiling, you can run `d4rtgen` from any project to use the updated generator.

## Build Runner Integration

The package can also be used via build_runner:

```bash
# In a project with build.yaml configured
dart run build_runner build --delete-conflicting-outputs

# Watch mode
dart run build_runner watch
```

````
