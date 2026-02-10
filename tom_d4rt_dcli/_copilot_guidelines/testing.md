# Tom D4rt DCli — Testing Guidelines

This document describes the testing strategy and conventions for the D4rt DCli package (`tom_d4rt_dcli`).

---

## Overview

Tests verify that the D4rt DCli correctly handles command-line operations, REPL functionality, and script execution.

---

## Running Tests

Use `testkit` commands from the project root (`tom_d4rt_dcli/`):

```bash
# Run all tests and compare against baseline
testkit :test

# Create a new baseline (after confirming test state is acceptable)
testkit :baseline

# Run tests with dart test directly (for targeted debugging)
dart test --reporter compact
```

---

## Test Results Tracking with Testkit Baselines

Test results are tracked using **testkit baselines** in `doc/baseline_MMDD_HHMM.csv`. The most recent baseline file is the currently relevant one.

### Baseline CSV Format

| Column | Description |
|--------|-------------|
| **ID** | Test ID extracted from the test name (if present) |
| **Groups** | Test group hierarchy from the test file |
| **Description** | Test description extracted from the test name |
| **Baseline [MM-DD HH:MM]** | Result column(s): `OK/OK` = pass, `X/FAIL` = expected fail |

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

- `doc/baseline_MMDD_HHMM.csv` — Baseline files (most recent is current)
- `last_testrun.json` — Raw test output from last run (overwritten each time)

---

## Related Documentation

- `doc/baseline_*.csv` — Test result baselines (most recent is current)
