# Step 4 — De-duplicate the third unwrap path in `tom_d4rt`/`tom_d4rt_ast`

`tom_d4rt_flutterm/doc/d4rt_consolidation_plan.md` — step 4.
Replaces the leaf-level `BridgedInstance` / `BridgedEnumValue` unwrap
inside `_bridgeInterpreterValueToNative` with a delegated call to the
shared `D4.unwrapAs<Object?>` helper introduced in step 1.

## What changed

- **`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`** —
  `_bridgeInterpreterValueToNative` collapsed to a single
  `D4.unwrapAs<Object?>(interpreterValue, visitor: this)` call. The
  original three branches (BridgedInstance → nativeObject,
  BridgedEnumValue → nativeValue, otherwise pass-through) are exactly
  what `D4.unwrapAs` does for `T == Object?`.
- **`tom_d4rt/lib/src/d4rt_base.dart`** — only the `BridgedInstance` /
  `BridgedEnumValue` branches in `_bridgeInterpreterValueToNative` are
  delegated to `D4.unwrapAs<Object?>`. The recursive list / map /
  record handling below is intentionally **not** delegated — those are
  a separate native-bridging concern that the single-level
  `D4.unwrapAs` contract does not cover, and replacing them wholesale
  would lose the interpreter's recursive unwrap of nested
  `BridgedInstance` values inside collections and records. New import:
  `package:tom_d4rt/src/generator/d4.dart`.

The plan's stated "drop-in replace" approach worked cleanly in
`tom_d4rt_ast` (whose `_bridgeInterpreterValueToNative` was already a
simple three-branch leaf function) but had to be narrowed in `tom_d4rt`
where the same-named function carries an additional recursive
list/map/record bridging concern. Both packages now route the leaf
unwrap through the shared helper, satisfying the de-duplication goal.

## Setup

- `--concurrency=1` on every `dart test` invocation (example/d4
  setUpAll race avoidance — same flake observed in steps 1–3).
- `D4RT_SKIP_BRIDGE_REGEN=1` for every flutter test run (no generator
  changes; bridges already in their correct state).
- Flutter test runs serially, file by file (the shared HTTP test app
  in `tom_d4rt_flutterm` is corrupted by parallel runs).

## Results vs `testlog_20260429-step3-flutterD4rt-cutover`

| Project                | step 3 baseline | step 4 | Δ pass | Δ fail | Verdict |
| ---------------------- | -------------: | -----: | -----: | -----: | ------- |
| essential_classes_test |    108 / 0 / 0 |   108 / 0 / 0 |   +0 |   +0 | match |
| important_classes_test |    164 / 0 / 0 |   164 / 0 / 0 |   +0 |   +0 | match |
| secondary_classes_test |    653 / 0 / 1 |   653 / 0 / 1 |   +0 |   +0 | match |
| tom_d4rt               |  1733 / 6 / ~1 | 1733 / 6 / ~1 |   +0 |   +0 | match |
| tom_d4rt_ast           |    101 / 2 / 0 |   101 / 2 / 0 |   +0 |   +0 | match |
| tom_d4rt_dcli          |    706 / 0 / 0 |   706 / 0 / 0 |   +0 |   +0 | match |
| tom_d4rt_exec          |  2234 / 26 / 0 | 2234 / 26 / 0 |   +0 |   +0 | match |
| tom_d4rt_generator     |   639 / 21 / 0 |  639 / 21 / 0 |   +0 |   +0 | match |
| tom_ast_generator      |    504 / 6 / 0 |   504 / 6 / 0 |   +0 |   +0 | match |
| tom_dcli_exec          |     72 / 8 / 0 |    72 / 8 / 0 |   +0 |   +0 | match |

## Verdict

Zero regressions across all 10 suites. The leaf-level unwrap is now
sourced from a single place (`D4.unwrapAs`) in both interpreter
packages.
