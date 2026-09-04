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
| `limitations_and_bugs_test.dart` | Pinned gaps, documented limitations, fixed-bug regressions |
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
- Unique IDs enable tracking in baseline CSV files
- Creation date helps understand test history

---

## Running Tests

Use `testkit` commands from the project root (e.g., `tom_d4rt/`):

```bash
# Run all tests and compare against baseline
testkit :test

# Create a new baseline (after confirming test state is acceptable)
testkit :baseline

# Run tests with dart test directly (for targeted debugging)
dart test --reporter compact
dart test test/global_setter_test.dart
dart test --name "Lim-3"
```

---

## Test Results Tracking with Testkit Baselines

Test results are tracked using **testkit baselines** in `testlog/baseline_MMDD_HHMM.csv`. The most recent baseline file is the currently relevant one.

### Baseline CSV Format

The baseline file has these columns:

| Column | Description |
|--------|-------------|
| **ID** | Test ID (e.g., `I-LIM-3`) extracted from the test name |
| **Groups** | Test group hierarchy from the test file |
| **Description** | Test description extracted from the test name |
| **Baseline [MM-DD HH:MM]** | Result column(s): `OK/OK` = pass, `X/FAIL` = expected fail |

When test descriptions follow the naming convention (`ID: description [date] (result)`), the columns parse correctly.

### Result Values

Format: `<current>/<baseline>` where `-` = SKIP, `X` = FAIL, `OK` = PASSED

- `OK/OK` — Test passed now and in baseline
- `OK/X` — Test passed now, failed in baseline (fix/improvement)
- `X/OK` — Test failed now, passed in baseline (regression)
- `X/X` — Test failed now and in baseline (expected or ongoing failure)
- `-/OK` — Test skipped now, passed in baseline
- `-/X` — Test skipped now, failed in baseline
- `--/OK` — Test not run (filtered out), passed in baseline
- `--/X` — Test not run (filtered out), failed in baseline

### Testkit Commands

| Command | Purpose |
|---------|---------|
| `testkit :test` | Run tests, add a new result column to the most recent baseline |
| `testkit :baseline` | Create a fresh baseline file with current test results |

### Passing Arguments to dart test

Use `--test-args` to pass options to the underlying `dart test` command:

```bash
testkit :test --test-args="--name 'parser' --fail-fast --timeout 60s"
```

**Disallowed options:** `--reporter`, `--file-reporter`, `--pause-after-load`, `--debug` (run will fail if used).

Testkit always uses `--reporter json` internally for parsing results.

### Output Files

- `testlog/baseline_MMDD_HHMM.csv` — Baseline files (most recent is current)
- `last_testrun.json` — Raw test output from last run (overwritten each time)

### Workflow

1. **Before making changes**: Run `testkit :test` to verify current state
2. **After fixing bugs**: Run `testkit :test` to see improved results
3. **When baseline is stale**: Run `testkit :baseline` to create new reference point

---

## Recording a known gap — one convention

A suite that carries a sanctioned red cannot gate regressions: the real
regression looks exactly like the expected failure, and telling them apart means
diffing a baseline by hand. So **a known gap is recorded by pinning the broken
behaviour, not by asserting the correct behaviour and leaving the case red.**

### The rule

1. Assert what the interpreter actually does today, so the case **passes**.
2. Put a marker in the comment **directly above the `test(`** naming who removes
   it:

   ```dart
   // KNOWN-GAP(scb7_agñd-short-description): `is Map` is false for bridged map
   // subtypes; closing it makes the pin below red.
   test('F-SC3-21: ... [2026-07-27] (PASS)', () { ... });
   ```

   Use `WONT-FIX: <reason>` instead when nothing will ever close it — an absent
   owner must be a decision, not an oversight.
3. When the gap closes, the pin goes **red**. Delete it — **in every tree**.
   This suite is mirrored verbatim into `tom_d4rt_exec`, so a pin always exists
   at least twice.

### What enforces it

`F-SCC6-5` in `tom_d4rt_exec/test/conformance_drift_test.dart` fails when a
`KNOWN-GAP()` names no owner, and when a marker exists in one tree's copy of a
file but not the other's. The parity half takes no exemption from
`_divergentBaseline` — a divergent file is precisely where a one-sided deletion
hides.

### Naming groups

Name a group after the **contract** its cases hold to, never after a status.
`Pinned Gaps (SHOULD PASS)`, `Fixed Bugs (SHOULD PASS)`,
`Documented Limitations (SHOULD PASS)` all survive a bug closing;
`Open Bugs - Pending (SHOULD FAIL)` did not — it held twenty-one passing cases
for months.

### The `(FAIL)` suffix

`(FAIL)` in a test name means the case is *expected* to fail. Under this
convention that combination should not arise in these suites, since a pinned gap
passes. Treat a `(FAIL)` suffix on a passing test as a stale label to correct,
not as a result to preserve.



---

## Writing New Tests

### Test Structure

```dart
import 'package:test/test.dart';
import 'package:tom_d4rt_exec/tom_d4rt.dart';

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
4. Run `testkit :test` to verify the fix is captured in baseline

---

## Related Documentation

- `testlog/baseline_*.csv` — Test result baselines (most recent is current)
- `doc/issues.md` — Bug and issue documentation

