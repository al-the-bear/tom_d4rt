# D4rt Interpreter Test Results

> Generated: 2026-02-09

## Summary

| Metric | Count |
|--------|-------|
| Total Tests | 1629 |
| Passed | 1625 |
| Failed | 4 |
| Skipped | 0 |

## Failing Tests

### Expected Failures (Won't Fix — Documented Limitations)

| Test | Issue | Reason |
|------|-------|--------|
| Bug-14: Records with named fields should return native record | Bug-14 | Dart language limitation — cannot create records dynamically |
| Bug-14: Records with >9 positional fields should return native record | Bug-14 | Dart language limitation — switch case limit |

### Unexpected Failures

| Test File | Test Name | Error |
|-----------|-----------|-------|
| await_constructor_test.dart | Stream transformation async constructor pattern | Async generator timing issue |
| await_constructor_test.dart | Complex stream async constructor with error handling | Async generator timing issue |
| await_constructor_test.dart | Stream controller async constructor pattern | Async generator timing issue |

## Notes

- The Bug-14 failures are expected and documented as "Won't Fix" in [d4rt_limitations.md](d4rt_limitations.md)
- The await_constructor_test failures appear to be related to async stream handling timing issues
