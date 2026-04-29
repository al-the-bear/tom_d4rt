# Step 4 sync addendum — third leaf-unwrap copy in `tom_d4rt/interpreter_visitor.dart`

`tom_d4rt_flutterm/doc/d4rt_consolidation_plan.md` — step 4 sync
addendum. Closes the divergence introduced by the original step-4 land:
`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` got the
`D4.unwrapAs<Object?>` delegation, but the structurally identical twin
in `tom_d4rt/lib/src/interpreter_visitor.dart` (line 9152) was missed.
Per the quest's hard sync rule, a fix that lands in only one of the two
interpreter packages is incomplete.

## What changed

- **`tom_d4rt/lib/src/interpreter_visitor.dart`** —
  `_bridgeInterpreterValueToNative` (called from `_evaluateArguments` /
  `_evaluateArgumentsAsync` for argument bridging on lines 9129, 9144,
  9224, 9241) collapsed from the verbatim three-branch original to a
  single `D4.unwrapAs<Object?>(interpreterValue, visitor: this)` call —
  matching the step-4 edit on
  `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart:10457`. `D4`
  is already re-exported via `package:tom_d4rt/d4rt.dart`; no new
  import was needed.

## Deeper asymmetry — flagged, **not** addressed by this sync

`tom_d4rt/lib/src/d4rt_base.dart` carries a structurally larger
`_bridgeInterpreterValueToNative` (line 1938) that recursively walks
`List`, `Map`, and `InterpretedRecord` (with native-record creation up
to 16 positional fields). It is called from `_executeInEnvironment`,
`_executeClassic`, `eval`, and `_tryFunction` to convert script return
values to native form.

`tom_d4rt_ast/lib/src/runtime/d4rt_runner.dart` has no equivalent
recursive pass at its top-level entry points; `executeBundleAs<T>` /
`executeBundleAsAsync<T>` apply only the single-level `D4.unwrapAs<T>`.

This asymmetry is **deliberate** and predates step 4 — `D4` itself
documents the design constraint on `unwrapInterpreterValue`:

> Lists and Maps are NOT recursively unwrapped because doing so destroys
> Dart's reified generic type information.

Forcing `tom_d4rt_ast` to mirror the recursion would regress the
type-fidelity property; forcing `tom_d4rt` to drop the recursion would
risk the 1733 passing tests in its corpus that depend on the legacy
behaviour. The correct resolution is a separate consolidation step that
either extracts the recursion into a named `D4.unwrapDeepAs<T>` helper
dual-landed at top-level entry points only, or deprecates the recursion
in `tom_d4rt` after the corpus is migrated. Tracked in
`d4rt_consolidation_plan.md` (step-4 status note); not in scope here.

## Setup

- `--concurrency=1` on every `dart test` invocation (example/d4
  setUpAll race avoidance — same flake observed in steps 1–4).
- `D4RT_SKIP_BRIDGE_REGEN=1` for every flutter test run (no generator
  changes; bridges already in their correct state).
- Flutter test runs serially, file by file (the shared HTTP test app
  in `tom_d4rt_flutterm` is corrupted by parallel runs).

## Results vs `testlog_20260429-step4-d4rt-base-unwrap`

| Project                | step 4 baseline | sync addendum | Δ pass | Δ fail | Verdict |
| ---------------------- | -------------: | ------------: | -----: | -----: | ------- |
| essential_classes_test |    108 / 0 / 0 |    108 / 0 / 0 |   +0 |   +0 | match |
| important_classes_test |    164 / 0 / 0 |    164 / 0 / 0 |   +0 |   +0 | match |
| secondary_classes_test |    653 / 0 / 1 |    653 / 0 / 1 |   +0 |   +0 | match |
| tom_d4rt               |  1733 / 6 / ~1 |  1733 / 6 / ~1 |   +0 |   +0 | match |
| tom_d4rt_ast           |    101 / 2 / 0 |    101 / 2 / 0 |   +0 |   +0 | match |
| tom_d4rt_dcli          |    706 / 0 / 0 |    706 / 0 / 0 |   +0 |   +0 | match |
| tom_d4rt_exec          |  2234 / 26 / 0 |  2234 / 26 / 0 |   +0 |   +0 | match |
| tom_d4rt_generator     |   639 / 21 / 0 |   639 / 21 / 0 |   +0 |   +0 | match |
| tom_ast_generator      |    504 / 6 / 0 |    504 / 6 / 0 |   +0 |   +0 | match |
| tom_dcli_exec          |     72 / 8 / 0 |     72 / 8 / 0 |   +0 |   +0 | match |

## Verdict

Zero regressions across all 10 suites. The leaf-level unwrap is now
sourced from the shared `D4.unwrapAs` helper in **all three** copies
across the two interpreter packages, satisfying the quest sync rule.
The deeper recursive-unwrap asymmetry between `d4rt_base.dart` and
`d4rt_runner.dart` is documented as a deferred follow-up.
