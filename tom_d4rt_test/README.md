# tom_d4rt_test

> Behavioural **conformance** suite for the source-based D4rt interpreter
> [`tom_d4rt`](../tom_d4rt). **Scaffold today** — wired into the workspace, not
> yet populated.

`tom_d4rt_test` is a standalone Dart package in the
[`tom_d4rt`](https://github.com/al-the-bear/tom_d4rt) monorepo (under
`tom_ai/d4rt/`). Its purpose is to pin down `tom_d4rt`'s observable behaviour
with executable tests — the same behaviour the analyzer-free twin
[`tom_d4rt_exec`](../tom_d4rt_exec) must reproduce, so the suite doubles as the
cross-engine conformance reference.

## Status

An empty `dart create` skeleton: no entry point, no public API, no tests yet.
Only the generated `lib/src/version.versioner.dart` build stamp is non-empty,
and the package does not yet depend on `tom_d4rt`. The wiring (version
stamping, build state, copilot guidelines) is in place; the suite content is
still to be written.

## How conformance testing will work

Run tests with `testkit` so results land in the baseline CSV
(`testlog/baseline_*.csv`); the most recent baseline is the reference and a
`testkit :test` run reports each test as pass/fail against it. The strategy
mirrors the established D4rt corpus workflow: a test names the behaviour, the
baseline records the expected result, and regressions surface as `X/OK`
columns.

When populated, expect the suite to grow as: a `test/` tree grouped by language
feature / bridge area, fixture scripts under `test/` exercised through
`tom_d4rt`'s `execute()` / `eval()`, and a `tom_d4rt` path dependency added to
`pubspec.yaml`. The same fixtures can later be run against
[`tom_d4rt_exec`](../tom_d4rt_exec) to compare the two engines.

## Related packages

- [`tom_d4rt`](../tom_d4rt) — the interpreter under test.
- [`tom_d4rt_exec`](../tom_d4rt_exec) — the analyzer-free twin the suite also targets.
- D4rt ecosystem repository: <https://github.com/al-the-bear/tom_d4rt>
