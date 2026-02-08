# Testing Guidelines — D4rt Bridge Generator

This project's testing strategy is documented in the **global** copilot guidelines:

👉 **[testing_d4rt_bridges.md](../../../../_copilot_guidelines/testing_d4rt_bridges.md)**

That document covers:

- **D4rtTester** infrastructure and test conventions
- **Dual testing** strategy (Generator Coverage Tests vs User Bridge Tests)
- **Override naming conventions** (per-class and global)
- **User bridge design gaps**
- **Issue tracking** workflow
- **Running tests** and adding new example projects

## Project-Specific Test Files

| File | Purpose |
|------|---------|
| `test/d4rt_tester_test.dart` | End-to-end tests per example project |
| `test/d4rt_coverage_test.dart` | Feature-level coverage tests (per feature, using dart_overview) |
| `doc/test_coverage.md` | Feature inventory with Coverage Test and UB Test tracking |
| `doc/issues.md` | Generator issue tracker (GEN-NNN) |

## Quick Commands

```bash
# Run all e2e tests
cd xternal/tom_module_d4rt/tom_d4rt_generator
dart test test/d4rt_tester_test.dart

# Run coverage tests only
dart test test/d4rt_coverage_test.dart

# Run a specific test group
dart test test/d4rt_tester_test.dart --name "userbridge_user_guide"
```
