# Testing D4rt and DCli Tools

This document explains how to test D4rt and DCli tools using replay files and the built-in verification system.

## Overview

D4rt and DCli provide a testing infrastructure that allows you to:

1. **Run replay files in test mode** - Execute command sequences and capture output
2. **Use verification functions** - Assert conditions and collect failures
3. **Generate test reports** - Output results to files for CI/CD integration

## Test Mode

### Running Tests from Command Line

```bash
# Run a test file in test mode
d4rt mytest.d4rt -test

# Run with output to a file
d4rt mytest.d4rt -test -output=test_results.txt

# Alternative syntax
d4rt -run-replay mytest.d4rt -test -output=results.txt
```

### Test Mode Behavior

When running in test mode:

1. Commands are executed silently (no normal output)
2. All verification failures are collected
3. A test report is generated showing:
   - File executed
   - Start/end timestamps
   - Number of lines executed
   - Verification failures (if any)
   - Final PASSED/FAILED status
4. Exit code is 0 for PASSED, 1 for FAILED

### Running All Tests

A script is provided to run all replay tests in the `test/replay` directory:

```bash
# From the project root
./test/replay/run_tests.sh
```

This script will:
1. Find all `*.dcli` files in `test/replay`
2. Run each test using the local `bin/dcli.dart`
3. Store results in `test/results`
4. Report overall PASSED/FAILED status

## Verification Functions

The following verification functions are available in D4rt/DCli scripts:

### Basic Verification

```dart
// Verify a boolean condition
verify(count > 0, 'Count should be positive');
verify(result == expected, 'Result mismatch');
```

### Equality Checks

```dart
// Verify two values are equal
verifyEquals(result, 42, 'Result should be 42');
verifyEquals(name, 'test');  // Message is optional
```

### Null Checks

```dart
// Verify value is not null
verifyNotNull(result, 'Result should not be null');

// Verify value is null
verifyNull(error, 'Error should be null');
```

### String Verification

```dart
// Verify string contains substring
verifyContains(output, 'success', 'Output should contain success');

// Verify string matches pattern
verifyMatches(email, r'^[\w.]+@[\w.]+$', 'Invalid email format');
```

### List Verification

```dart
// Verify list is not empty
verifyNotEmpty(results, 'Results should not be empty');

// Verify list has specific length
verifyLength(items, 3, 'Should have exactly 3 items');
```

### Exception Verification

```dart
// Verify that code throws an exception
verifyThrows(() => divide(1, 0), 'Division by zero should throw');
```

### Test Summary

```dart
// Print a summary of all verifications
testSummary();  // Returns true if all passed
```

## Writing Test Files

### Example Test File (mytest.d4rt)

```dart
// Test file for D4rt CLI functionality
// Run with: d4rt mytest.d4rt -test

// Define a helper function
int add(int a, int b) => a + b;

// Test the function
verify(add(2, 3) == 5, 'add(2, 3) should equal 5');
verifyEquals(add(0, 0), 0, 'add(0, 0) should equal 0');
verifyEquals(add(-1, 1), 0);

// Test string operations
var greeting = 'Hello, World!';
verifyContains(greeting, 'Hello', 'Should contain Hello');
verifyMatches(greeting, r'^\w+,\s+\w+!$', 'Should match greeting pattern');

// Print summary (optional in test mode, but useful for manual runs)
testSummary();
```

### Multi-line Test Blocks

You can use `.start-execute` and `.end` for isolated test blocks:

```
// Main test file
var counter = 0;

// This block runs in a fresh environment
.start-execute
var x = 10;
verify(x == 10, 'x should be 10');
.end

// counter is still 0 here (not affected by execute block)
verify(counter == 0, 'counter should be unaffected');
```

Use `.start-file` for blocks that run in the current environment:

```
// Main test file
var sharedValue = 0;

.start-file
sharedValue = 42;
verify(sharedValue == 42, 'sharedValue should be set');
.end

// sharedValue is now 42
verify(sharedValue == 42, 'sharedValue persists');
```

## Test Output Format

When running in test mode, the output looks like:

```
Test Mode: /path/to/mytest.d4rt
Started: 2026-02-02T15:30:00.000Z

Lines executed: 25

Result: PASSED
Completed: 2026-02-02T15:30:01.234Z
```

With failures:

```
Test Mode: /path/to/mytest.d4rt
Started: 2026-02-02T15:30:00.000Z

Lines executed: 25

VERIFICATION FAILURES (2):
  - add(2, 3) should equal 5
  - Should contain Hello

Result: FAILED
Completed: 2026-02-02T15:30:01.234Z
```

## CI/CD Integration

### Exit Codes

- `0` - All tests passed
- `1` - One or more tests failed or an error occurred

### GitHub Actions Example

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Dart
        uses: dart-lang/setup-dart@v1
        
      - name: Run D4rt Tests
        run: |
          d4rt tests/test_basic.d4rt -test -output=results/basic.txt
          d4rt tests/test_advanced.d4rt -test -output=results/advanced.txt
          
      - name: Upload Test Results
        if: always()
        uses: actions/upload-artifact@v3
        with:
          name: test-results
          path: results/
```

## Best Practices

1. **One assertion per verification** - Makes failures easier to diagnose
2. **Descriptive error messages** - Include expected vs actual values
3. **Group related tests** - Use comments to organize test sections
4. **Use `.start-execute` for isolation** - When tests shouldn't affect each other
5. **Run `testSummary()` at the end** - For manual test runs
6. **Check exit codes in CI** - Fail builds on test failures

## Debugging Tests

For more detailed output during development:

```bash
# Run with debug mode
DEBUG=true d4rt mytest.d4rt -test

# Run without test mode to see all output
d4rt mytest.d4rt
```

## See Also

- `.help test` - In-REPL help for test commands
- `verify --help` - Documentation for verify functions
- `info verify` - Shows verify function signature in REPL
