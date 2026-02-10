# D4rt Interpreter Test Results

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
test('I-LIM-3: Isolate.run interpreted closure [2026-02-10 08:00] (FAIL)', () {
  // test code
});
```

Format: `<ID>: <description> [<creation date>] (<expected result>)`

- **ID**: Prefix + category + number
- **Description**: Brief explanation of what the test validates
- **Creation date**: When the test was first created (YYYY-MM-DD HH:MM)
- **Expected result**: `FAIL` for known limitations/bugs, `PASS` for tests expected to pass

The prefix `I-` (Interpreter) is followed by a category code:
- `I-LIM-n`: Known limitations (Won't Fix)
- `I-BUG-n`: Open bugs
- `I-FILE-n`: File/IO related tests
- See `_copilot_guidelines/testing.md` for full category list

---

## Summary (2026-02-10)

| Metric | Count |
|--------|-------|
| Total Tests | 1654 |
| Passed | 1650 |
| Failed | 4 |
| Skipped | 0 |

---

## Failed Test Tracking

| ID | Description | Created | Expected | Baseline 2026-02-10 |
|----|-------------|---------|----------|---------------------|
| I-LIM-3 | Isolate.run with interpreted closure should work | 2026-02-10 08:00 | fail | ❌ |
| I-BUG-14a | Records with named fields should return native record | 2026-02-10 08:00 | fail | ❌ |
| I-BUG-14b | Records with >9 positional fields should return native record | 2026-02-10 08:00 | fail | ❌ |
| I-FILE-1 | File writeAsStringSync and readAsStringSync | 2026-02-10 08:00 | pass | ❌ |

### Legend

- ✅ Pass
- ❌ Fail
- ⏭️ Skipped
- **Expected: fail** = Known limitation, expected to fail (Won't Fix)
- **Expected: pass** = Should pass, failure indicates regression

---

## Notes

- I-LIM-3, I-BUG-14a, I-BUG-14b are documented in [d4rt_limitations.md](d4rt_limitations.md)
- I-FILE-1 is a new failure requiring investigation
