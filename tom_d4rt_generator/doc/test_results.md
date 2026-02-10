# D4rt Generator Test Results

> Last Updated: 2026-02-10

## Test Result Tracking

This document tracks test results across runs to monitor progress and detect regressions.

### Purpose

- Track which tests are failing and why
- Monitor progress on bug fixes
- Detect regressions when changes cause previously-passing tests to fail
- Provide a baseline for comparison

### How to Maintain This Table

1. **After each test run**, add a new column with timestamp (YYYY-MM-DD HH:MM)
2. **Mark each test** with ✅ (pass), ❌ (fail), or ⏭️ (skipped)
3. **Only list failed tests** in the table (tests that failed in any tracked run)
4. **Keep tests in table** even if they pass, until a new baseline is created
5. **Creating a baseline**: Run all tests, remove all run columns, create single "Baseline" column
6. **Expected failures**: Tests marked with "fail" in Expected column are known/accepted failures

### Test ID Format

Tests use a structured naming convention in the test code:

```dart
test('G-TE-1: bounded type param uses bound type [2026-02-10 08:00] (FAIL)', () {
  // test code
});
```

Format: `<ID>: <description> [<creation date>] (<expected result>)`

- **ID**: Prefix + category + number
- **Description**: Brief explanation of what the test validates
- **Creation date**: When the test was first created (YYYY-MM-DD HH:MM)
- **Expected result**: `FAIL` for known limitations/bugs, `PASS` for tests expected to pass

The prefix `G-` (Generator) is followed by a category code:
- `G-TE-n`: Type erasure tests
- `G-CB-n`: Callback wrapping tests
- `G-GB-n`: Global bridge tests
- `G-UB-n`: User bridge override tests
- See `_copilot_guidelines/testing.md` for full category list

---

## Summary (2026-02-10)

| Metric | Count |
|--------|-------|
| Total Tests | 384 |
| Passed | 341 |
| Failed | 42 |
| Skipped | 1 |

---

## Failed Test Tracking

| ID | Description | Created | Expected | Baseline 2026-02-10 |
|----|-------------|---------|----------|---------------------|
| G-TE-1 | bounded type param uses bound type | 2026-02-10 08:00 | fail | ❌ |
| G-TE-2 | static castFrom uses constrained types | 2026-02-10 08:00 | fail | ❌ |
| G-CB-1 | VoidCallback parameter generates wrapper | 2026-02-10 08:00 | pass | ❌ |
| G-CB-2 | void Function() callback generates correct wrapper | 2026-02-10 08:00 | pass | ❌ |
| G-CB-3 | method with multiple callbacks generates all wrappers | 2026-02-10 08:00 | pass | ❌ |
| G-GB-1 | generates globalFunctionNames list | 2026-02-10 08:00 | pass | ❌ |
| G-GB-2 | generates globalVariableNames list | 2026-02-10 08:00 | pass | ❌ |
| G-GB-3 | generates getGlobalInitializationScript method | 2026-02-10 08:00 | pass | ❌ |
| G-GB-4 | initialization script contains variable getters | 2026-02-10 08:00 | pass | ❌ |
| G-GB-5 | const variables use registerGlobalVariable | 2026-02-10 08:00 | pass | ❌ |
| G-GB-6 | final variables use registerGlobalVariable | 2026-02-10 08:00 | pass | ❌ |
| G-GB-7 | mutable variables use registerGlobalVariable | 2026-02-10 08:00 | pass | ❌ |
| G-GB-8 | getter returning singleton uses registerGlobalGetter | 2026-02-10 08:00 | pass | ❌ |
| G-GB-9 | getter returning computed value uses registerGlobalGetter | 2026-02-10 08:00 | pass | ❌ |
| G-GB-10 | nullable getter uses registerGlobalGetter | 2026-02-10 08:00 | pass | ❌ |
| G-GB-11 | getter depending on mutable state uses registerGlobalGetter | 2026-02-10 08:00 | pass | ❌ |
| G-GB-12 | registerGlobalVariables method contains both types | 2026-02-10 08:00 | pass | ❌ |
| G-UB-1 | override for global variable appName | 2026-02-10 08:00 | pass | ❌ |
| G-UB-2 | override for global variable maxRetries | 2026-02-10 08:00 | pass | ❌ |
| G-UB-3 | override for global getter currentTime | 2026-02-10 08:00 | pass | ❌ |
| G-UB-4 | override for global getter globalService | 2026-02-10 08:00 | pass | ❌ |
| G-UB-5 | override for global function greet | 2026-02-10 08:00 | pass | ❌ |
| G-UB-6 | override for global function add | 2026-02-10 08:00 | pass | ❌ |
| G-TOP-12 | enhanced enum with mixin | 2026-02-10 08:00 | fail | ❌ |
| G-TOP-13 | generic enum (N/A — Dart limitation) | 2026-02-10 08:00 | fail | ❌ |
| G-TOP-19 | typedef (function, not needed) | 2026-02-10 08:00 | fail | ❌ |
| G-TOP-24 | top-level async function | 2026-02-10 08:00 | pass | ❌ |
| G-TOP-28 | top-level setter | 2026-02-10 08:00 | pass | ❌ |
| G-CLS-6 | late field | 2026-02-10 08:00 | pass | ❌ |
| G-PAR-6 | function-typed parameter | 2026-02-10 08:00 | pass | ❌ |
| G-GNRC-7 | F-bounded polymorphism | 2026-02-10 08:00 | fail | ❌ |
| G-OP-8 | operator == (equality) | 2026-02-10 08:00 | pass | ❌ |
| G-ASYNC-1 | async function (Future) | 2026-02-10 08:00 | pass | ❌ |
| G-ASYNC-2 | async* generator (Stream) | 2026-02-10 08:00 | pass | ❌ |
| G-ASYNC-3 | sync* generator (Iterable) | 2026-02-10 08:00 | pass | ❌ |
| G-ASYNC-4 | callback parameter (Function) | 2026-02-10 08:00 | pass | ❌ |
| G-ASYNC-5 | instance async method (Future) | 2026-02-10 08:00 | pass | ❌ |
| G-ASYNC-6 | instance sync* method (Iterable) | 2026-02-10 08:00 | pass | ❌ |
| G-ASYNC-7 | instance async* method (Stream) | 2026-02-10 08:00 | pass | ❌ |
| G-ASYNC-8 | static sync*/async* method | 2026-02-10 08:00 | pass | ❌ |
| G-TYPE-1 | record parameter | 2026-02-10 08:00 | fail | ❌ |
| G-TYPE-2 | record return type | 2026-02-10 08:00 | fail | ❌ |

### Legend

- ✅ Pass
- ❌ Fail
- ⏭️ Skipped
- **Expected: fail** = Known limitation, expected to fail (Won't Fix)
- **Expected: pass** = Should pass, failure indicates a bug to fix

---

## Root Cause Summary

| Root Cause | Failures | Issue ID | Notes |
|------------|----------|----------|-------|
| Type erasure limitations | 2 | — | Fundamental Dart limitation |
| Callback wrapping generation | 3 | — | Generator bug |
| Global bridge API | 12 | INTER-002 | Needs interpreter API |
| User bridge overrides | 6 | INTER-002 | Needs interpreter API |
| Coverage test failures | 19 | Various | Mixed causes |

---

## Notes

- G-TE-1, G-TE-2, G-TOP-12, G-TOP-13, G-GNRC-7, G-TYPE-1, G-TYPE-2 are known limitations
- G-GB-* and G-UB-* tests depend on INTER-002 interpreter API being available
- Coverage tests (G-TOP-*, G-CLS-*, etc.) are from d4rt_coverage_test.dart
