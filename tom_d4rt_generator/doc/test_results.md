# D4rt Generator Test Results

> Generated: 2026-02-09

## Summary (Full Test Suite)

| Metric | Count |
|--------|-------|
| Total Tests | ~1318 |
| Passed | ~1314 |
| Failed | ~4 |

## Summary (d4rt_coverage_test.dart — Bridge Coverage)

| Metric | Count |
|--------|-------|
| Total Tests | 94 |
| Passed | 70 |
| Failed | 23 |
| Skipped | 1 |

## Failing Bridge Coverage Tests

### Record/Collection Type Issues (INTER-003, INTER-004, GEN-060)

| Test ID | Description | Error | Root Cause |
|---------|-------------|-------|------------|
| TYPE01 | record parameter | `expected (int, int), got InterpretedRecord` | InterpretedRecord not converted to native record |
| TYPE02 | record return type | `expected List<int>, got List<Object?>` | Collection type not cast properly |

### Async/Generator Issues (GEN-059)

| Test ID | Description | Error | Root Cause |
|---------|-------------|-------|------------|
| ASYNC01 | instance async method | Timeout | Bridged async method not awaited correctly |
| ASYNC02 | static async method | Timeout | Bridged async method not awaited correctly |
| ASYNC03 | async method on bridged instance | Timeout | Bridged async method not awaited correctly |
| ASYNC04-08 | Various async/sync* methods | Timeout | Generator methods not properly bridged |

### Callable/Operator Issues (INTER-001)

| Test ID | Description | Error | Root Cause |
|---------|-------------|-------|------------|
| CLS17 | callable class call() | Returns instance instead of result | Interpreter doesn't invoke call() method |
| OP05-08 | operator overloads | `expected double, got int` | Int-to-double promotion missing (INTER-003) |

### Top-Level Issues (INTER-002)

| Test ID | Description | Error | Root Cause |
|---------|-------------|-------|------------|
| TOP28 | top-level setter | Assignment fails | No registerGlobalSetter API |

### Other Issues

| Test ID | Description | Error | Root Cause |
|---------|-------------|-------|------------|
| PAR06 | function-typed parameter | `expected List<int>, got List<Object?>` | Same as INTER-004 |
| GNRC07 | f-bounded polymorphism | `BridgedInstance not Comparable` | INTER-005 — BridgedInstance unwrapping |

## Notes

- Most failures trace back to a few root causes in `D4.extractBridgedArg`:
  1. **INTER-003**: int→double promotion not handled
  2. **INTER-004**: Collection type casting not handled
  3. **GEN-060**: InterpretedRecord→native record conversion not handled
- ASYNC failures may be timeout-related or genuine async bridging issues
- See [issues.md](../tom_d4rt/doc/issues.md) for detailed issue descriptions
