# Step 3 — `FlutterD4rt` cutover regression battery

`tom_d4rt_flutterm/doc/d4rt_consolidation_plan.md` — step 3.
The behavioural cutover: `FlutterD4rt._unwrap<T>` is removed and all
four entry points (`build`, `buildAsync`, `execute`, `executeAsync`)
now route through the runner's typed entry points
(`executeBundleAs<T>` / `executeBundleAsAsync<T>`) introduced in
step 2. `D4UnwrapException` is re-thrown as `FlutterD4rtException`
to preserve the public exception contract.

## Setup

- `D4RT_SKIP_BRIDGE_REGEN=1` for every test run (no generator changes).
- `--concurrency=1` for every dart test invocation (example/d4
  setUpAll race avoidance).
- flutter test runs serially, file by file (the shared HTTP test app
  in tom_d4rt_flutterm is corrupted by parallel runs).

## Results

Compared to `testlog_20260429-1054-consol-baseline` and
`testlog_20260429-step2-executeBundleAs` (where step 2 added new
tests; step 3 is pure-refactor with no new tests).

| Project                | step 2 baseline | step 3 | Δ pass | Δ fail | Verdict |
| ---------------------- | -------------: | -----: | -----: | -----: | ------- |
| essential_classes_test |    108 / 0 / 0 |   108 / 0 / 0 |   +0 |   +0 | match |
| important_classes_test |    164 / 0 / 0 |   164 / 0 / 0 |   +0 |   +0 | match |
| secondary_classes_test |    653 / 0 / 1 |   653 / 0 / 1 |   +0 |   +0 | match |
| tom_d4rt               | 1733 / 6 / ~1  |  1733 / 6 / ~1 |   +0 |   +0 | match |
| tom_d4rt_ast           |    101 / 2 / 0 |   101 / 2 / 0 |   +0 |   +0 | match |
| tom_d4rt_dcli          |    706 / 0 / 0 |   706 / 0 / 0 |   +0 |   +0 | match |
| tom_d4rt_exec          |  2234 / 26 / 0 | 2234 / 26 / 0 |   +0 |   +0 | match |
| tom_d4rt_generator     |   639 / 21 / 0 |  639 / 21 / 0 |   +0 |   +0 | match |
| tom_ast_generator      |    504 / 6 / 0 |   504 / 6 / 0 |   +0 |   +0 | match |
| tom_dcli_exec          |     72 / 8 / 0 |    72 / 8 / 0 |   +0 |   +0 | match |

## Verdict

Zero regressions across all 10 suites. The behavioural cutover from
the local `_unwrap<T>` to the shared `D4.unwrapAs<T>` (via the
runner's typed entry points) is safe and complete.
