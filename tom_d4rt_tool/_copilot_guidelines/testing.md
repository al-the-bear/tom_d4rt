# Tom DartScript Bridges - Testing Guidelines

**Project:** `tom_dartscript_bridges`

## Test Architecture

Tests for tom_dartscript_bridges are **replay-based integration tests**. They exercise the full pipeline:

1. **Bridge generation** — `d4rtgen` generates bridge files from `buildkit.yaml`
2. **Binary compilation** — `dart compile exe bin/d4rt.dart` produces a native binary
3. **Replay execution** — the compiled binary runs `.d4rt` and `.dcli` replay files with `-run-replay <file> -test`

This approach validates that:
- The generator produces correct bridge code for all Tom Framework packages
- The compiled binary links and initializes all bridges correctly
- D4rt scripts can access bridged classes, functions, and extensions at runtime

## Test Structure

```
test/
├── replay/                          # Replay test files (.d4rt/.dcli)
│   ├── run_tests.sh                 # Legacy shell-based runner
│   ├── test_d4rt_basics.d4rt        # Basic D4rt language features
│   ├── test_d4rt_tom_core_kernel.d4rt  # Tom Core Kernel bridges
│   └── ...                          # One file per bridge module / feature
├── results/                         # Output directory for test results
├── d4rt_replay_test.dart            # Dart test wrapper — D4rt replay tests
└── dcli_compat_test.dart            # Dart test wrapper — DCli compatibility tests
```

## Running Tests

### Dart Test Runner (Recommended)

```bash
cd dartscript/tom_dartscript_bridges

# Run all replay tests
dart test

# Run only the D4rt replay tests
dart test test/d4rt_replay_test.dart

# Run only the DCli compatibility tests
dart test test/dcli_compat_test.dart

# Run a specific test by name
dart test --name "test_d4rt_basics"
```

### Shell Runner (Legacy)

```bash
cd dartscript/tom_dartscript_bridges
bash test/replay/run_tests.sh
```

## Test Execution Flow

The Dart test files use a three-phase approach:

### Phase 1: Bridge Generation (`setUpAll`)

Runs `d4rtgen` to generate bridge code from `buildkit.yaml`. This step:
- Invokes the `tom_d4rt_generator` via subprocess
- Generates bridge files for all configured modules
- Generates the barrel file and registration class

### Phase 2: Binary Compilation (`setUpAll`)

Compiles `bin/d4rt.dart` to a native executable:
- Output: `bin/d4rt_test` (temporary test binary)
- Verifies the generated bridge code compiles without errors

### Phase 3: Replay Execution (individual tests)

Each test runs a replay file using the compiled binary:
```
bin/d4rt_test -run-replay test/replay/test_d4rt_basics.d4rt -test
```

The `-test` flag enables verification mode in the replay runner, which:
- Tracks `verify()`, `verifyEquals()`, `verifyContains()`, etc. calls
- Sets exit code 0 on success, non-zero on failure
- Outputs verification results to stdout

### Success Criteria

A replay test passes when:
- The process exits with code 0
- No unhandled exceptions in stderr
- The process completes within the timeout

## Adding New Replay Tests

1. Create a `.d4rt` file in `test/replay/` following the naming convention `test_d4rt_<module>.d4rt`
2. Use verification functions: `verify()`, `verifyEquals()`, `verifyContains()`, `verifyNotNull()`, `verifyNotEmpty()`
3. Add a corresponding test case in the appropriate Dart test file
4. Test files that exercise DCli compatibility should be `.dcli` files and go in `test/dcli_compat_test.dart`

### Replay Test File Template

```d4rt
# D4rt Test Suite - <Module Name>
# Run with: d4rt -run-replay test_d4rt_<module>.d4rt -test

import 'package:<module>/<module>.dart';

# =============================================================================
# Test: <Feature Description>
# =============================================================================

var instance = SomeClass('arg');
verifyNotNull(instance, 'SomeClass created');
verifyEquals(instance.field, 'expected', 'Field value');
```

## Timeouts

- **Bridge generation**: 3 minutes (covers `d4rtgen` + `dart compile exe`)
- **Individual replay tests**: 30 seconds per test
- **Network-dependent tests** (e.g., `test_d4rt_tom_basics_network.d4rt`): 60 seconds

## Environment Requirements

- `d4rtgen` must be on PATH or available via `dart run` in the generator project
- DART_SDK environment variable should point to the Dart SDK
- All path dependencies in `pubspec.yaml` must be resolvable
