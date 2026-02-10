# D4rt Interpreter — Testing Guidelines

This document describes the testing strategy and conventions for the D4rt interpreter (`tom_d4rt`).

---

## Overview

Tests verify that the D4rt interpreter correctly executes Dart code. They cover:
- Language features (expressions, statements, control flow)
- Type system and generics
- Async/await and generators
- Pattern matching
- Bridged class interactions
- Known limitations and expected failures

---

## Test Files Location

All tests are in `tom_d4rt/test/`:

| Test File | Purpose |
|-----------|---------|
| `interpreter_test.dart` | Core interpreter functionality |
| `limitations_and_bugs_test.dart` | Known limitations (expected failures) |
| `global_setter_test.dart` | INTER-002: Global setter API |
| `bridged_instance_sort_test.dart` | INTER-005: BridgedInstance unwrapping |
| `future_factory_test.dart` | Bug-92: Future factory constructor |
| `extension_list_getter_test.dart` | Bug-98: Extension getters |
| `stream_handle_error_test.dart` | Bug-99: Stream.handleError callback |
| `async_nested_loops_test.dart` | Async loop behavior |
| `pattern_matching_*.dart` | Pattern matching features |
| `generics_*.dart` | Generic type handling |
| `const_expressions_test.dart` | Const evaluation |

---

## Test ID Convention

Tracked tests (failing or previously-failing) use a structured naming convention in the test code:

```dart
test('I-LIM-3: Isolate.run interpreted closure [2026-02-10 08:00]', () {
  // test code
});
```

### Format

`<ID>: <description> [<creation date>] (<expected result>)`

- **ID**: Prefix `I-` (Interpreter) + category + number
- **Description**: Brief explanation of what the test validates
- **Creation date**: `YYYY-MM-DD HH:MM` format, when test was added
- **Expected result**: `FAIL` for known limitations/bugs, `PASS` for tests expected to pass

### ID Categories

#### Issue Tracking Categories

| Prefix | Category | Example | Description |
|--------|----------|---------|-------------|
| `I-LIM-n` | Known limitations | I-LIM-3 | Fundamental constraints or unsupported features |
| `I-BUG-n` | Bugs | I-BUG-14a | Known issues that should be fixed |

#### Feature Categories

| Prefix | Category | Example | Description |
|--------|----------|---------|-------------|
| `I-EXPR-n` | Expressions | I-EXPR-1 | Arithmetic, logical, bitwise operators |
| `I-STMT-n` | Statements | I-STMT-1 | Control flow, loops, switches |
| `I-ASYNC-n` | Async/await | I-ASYNC-1 | Futures, async/await, Streams |
| `I-GEN-n` | Generators | I-GEN-1 | sync*, async*, yield, yield* |
| `I-PAT-n` | Patterns | I-PAT-1 | Pattern matching, guards, destructuring |
| `I-TYPE-n` | Type system | I-TYPE-1 | Type checks, casts, generics |
| `I-GNRC-n` | Generics | I-GNRC-1 | Type parameters, bounds, variance |
| `I-COLL-n` | Collections | I-COLL-1 | List, Map, Set operations |
| `I-CLASS-n` | Classes | I-CLASS-1 | Inheritance, mixins, constructors |
| `I-ENUM-n` | Enums | I-ENUM-1 | Enum declarations, enhanced enums |
| `I-FUNC-n` | Functions | I-FUNC-1 | Closures, named params, defaults |
| `I-STRING-n` | Strings | I-STRING-1 | Interpolation, multiline, raw |
| `I-RECORD-n` | Records | I-RECORD-1 | Record types and destructuring |
| `I-EXT-n` | Extensions | I-EXT-1 | Extension methods and getters |
| `I-CONST-n` | Constants | I-CONST-1 | Const expressions and evaluation |
| `I-FILE-n` | File/IO | I-FILE-1 | File system operations |
| `I-ISO-n` | Isolates | I-ISO-1 | Isolate spawning and communication |
| `I-NET-n` | Network | I-NET-1 | HTTP, sockets, URIs |
| `I-BRIDGE-n` | Bridged classes | I-BRIDGE-1 | Host-interpreter interop |

### Benefits

- Test output shows ID, description and date — easy to cross-reference
- Unique IDs enable tracking in `doc/test_results.md`
- Creation date helps understand test history

---

## Running Tests

```bash
# Run all tests
cd tom_d4rt && dart test

# Run with compact output
dart test --reporter compact

# Run specific test file
dart test test/global_setter_test.dart

# Run specific test by name
dart test --name "Lim-3"
```

---

## Test Results Tracking

See `doc/test_results.md` for the test failure tracking table and keep it current for full runs of the tests. Don't update for limited testing during the test/fix cycle. However, before reporting back in a test/fix cycle a full run must be done and the table updated.

### Purpose of test_results.md

The test results file tracks:
- Which tests are currently failing
- Whether failures are expected (known limitations) or unexpected (regressions)
- Progress over time via dated columns

### Maintaining the Table

1. **After each test run**, add a new column with timestamp (YYYY-MM-DD HH:MM)
2. Mark each test with ✅ (pass), ❌ (fail), or ⏭️ (skipped)
3. Only list failed tests (tests that failed in any tracked run)
4. Keep tests in table even if passing, until new baseline is created
5. **Creating a baseline**: Delete all run columns, add single "Baseline" column

### Expected Failures

Tests marked `Expected: fail` are known limitations that we know about and will either solve later or leave open
- `I-LIM-3`: Isolate.run can't use interpreted closures
- `I-BUG-14a/b`: Records with named fields or >9 positional fields



---

## Writing New Tests

### Test Structure

```dart
import 'package:test/test.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

void main() {
  late D4rt interpreter;

  setUp(() {
    interpreter = D4rt(sourceLoader: testLoader);
  });

  tearDown(() {
    interpreter.dispose();
  });

  group('Feature Name', () {
    test('specific behavior', () async {
      final result = await interpreter.execute(source: '''
        void main() {
          // test code
        }
      ''');
      expect(result, equals(expected));
    });
  });
}
```

### Test for Bug Fixes

When fixing a bug:
1. Add test that reproduces the bug first (should fail)
2. Fix the bug
3. Verify test passes
4. Add test ID to `doc/test_results.md` if it was a tracked failure

---

## Related Documentation

- `doc/test_results.md` — Failure tracking table
- `doc/issues.md` — Bug and issue documentation

