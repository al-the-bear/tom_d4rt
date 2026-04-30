# Step 2 — `executeBundleAs<T>` regression battery

`tom_d4rt_flutterm/doc/d4rt_consolidation_plan.md` — step 2.
Pure-addition step on top of step 1's `D4.unwrapAs<T>` /
`D4UnwrapException`. Adds `D4rtRunner.executeBundleAs<T>` /
`executeBundleAsAsync<T>` on the analyzer-free runner and mirrors the
pair on the analyzer `D4rt` class.

## Setup

- `D4RT_SKIP_BRIDGE_REGEN=1` for every test run (no generator changes
  were made; bridges are already in their correct state).
- `--concurrency=1` for every dart test invocation, to dodge the
  example/d4 setUpAll race (same flake observed in step 1).
- flutter test runs serially, file by file (the shared HTTP test app
  in tom_d4rt_flutterm is corrupted by parallel runs).

## Results vs `testlog_20260429-1054-consol-baseline`

| Project                | Baseline (passed/failed/skipped) | Step 2 | Δ pass | Δ fail | Verdict |
| ---------------------- | -------------------------------: | -----: | -----: | -----: | ------- |
| essential_classes_test |                       108 / 0 / 0 |        108 / 0 / 0 |   +0 |   +0 | match |
| important_classes_test |                       164 / 0 / 0 |        164 / 0 / 0 |   +0 |   +0 | match |
| secondary_classes_test |                       653 / 0 / 1 |        653 / 0 / 1 |   +0 |   +0 | match |
| tom_d4rt               |                  1721 / 6 / ~1 |    1733 / 6 / ~1 | +12* |   +0 | improved |
| tom_d4rt_ast           |                       84 / 2 / 0 |       101 / 2 / 0 | +17† |   +0 | improved |
| tom_d4rt_dcli          |                      706 / 0 / 0 |       706 / 0 / 0 |   +0 |   +0 | match |
| tom_d4rt_exec          |                     2223 / 26 / 0 |     2234 / 26 / 0 | +11 |   +0 | improved |
| tom_d4rt_generator     |                      639 / 21 / 0 |      639 / 21 / 0 |   +0 |   +0 | match |
| tom_ast_generator      |                       476 / 7 / 0 |       504 / 6 / 0 | +28 |   −1 | improved |
| tom_dcli_exec          |                       72 / 8 / 0 |        72 / 8 / 0 |   +0 |   +0 | match |

`*` 12 extra passes in `tom_d4rt` are pre-existing tests not yet
running on the baseline run (likely the cumulative effect of step 1
landing). No new failures.

`†` 17 = step 1's 12 `D4.unwrapAs<T>` tests + step 2's 5 hand-built
`SAstNode` runner tests.

`tom_ast_generator` shows one fewer failure than the baseline — a
pre-existing regression that resolved itself between baseline and
this step. Kept as part of the cumulative diff.

## Verdict

No regressions. All baseline failure counts held flat or improved.
Step 2 is safe to commit.
