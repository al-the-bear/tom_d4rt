# Step 4 recursive sync — port recursive `_bridgeInterpreterValueToNative` to `tom_d4rt_ast`

`tom_d4rt_flutterm/doc/d4rt_consolidation_plan.md` — step 4
recursive-sync addendum. `tom_d4rt_ast` was forked from `tom_d4rt`,
but the recursive interpreter→native unwrap that lives in
`tom_d4rt/lib/src/d4rt_base.dart:1938` (called from the equivalent
of `_executeInEnvironment` and friends) was never carried over. As a
result, callers of `D4rtRunner.executeBundle` received raw
`BridgedInstance` / `InterpretedRecord` values inside lists, maps,
and records, and `executeBundleAs<T>` could not coerce them because
`D4.unwrapAs` is intentionally single-level. This addendum closes
that gap.

## What changed

- **`tom_d4rt_ast/lib/src/runtime/d4rt_runner.dart`** —
  - Added imports: `bridge/bridged_enum.dart` (for
    `BridgedEnumValue`), `runtime_types.dart` (for
    `InterpretedInstance` / `InterpretedRecord`).
  - Added `_bridgeInterpreterValueToNative(Object?)` — a verbatim
    port of the recursive unwrap from
    `tom_d4rt/lib/src/d4rt_base.dart:1938`. Same body, same record
    arity ladder (0..16 positional → native record literal, named
    fields → unwrapped `InterpretedRecord`). Leaf-level
    `BridgedInstance`/`BridgedEnumValue` cases delegate to
    `D4.unwrapAs<Object?>`, matching the leaf-twins in this
    package's `InterpreterVisitor` (line 10457) and the equivalent
    twin in `tom_d4rt/lib/src/interpreter_visitor.dart` (line 9152,
    just synced).
  - Wired at the single source point —
    `_executeInEnvironment` (end of method, before `return
    functionResult`). Mirrors how `tom_d4rt/d4rt_base.dart` calls
    `_bridgeInterpreterValueToNative(functionResult)` once at the
    function-call site (lines 1148/1409/1699). The deep-unwrap
    propagates upward to both the untyped `executeBundle` and the
    typed `executeBundleAs<T>` / `executeBundleAsAsync<T>` — those
    typed wrappers now apply only the leaf cast on
    already-deep-unwrapped data, with no double-work.
  - Future returns are unwrapped via `.then(unwrap)` so async entry
    points get the same recursive treatment.

## Setup

- `--concurrency=1` on every `dart test` invocation
  (example/d4 setUpAll race avoidance).
- `D4RT_SKIP_BRIDGE_REGEN=1` for every flutter test run (no
  generator changes; bridges already in their correct state).
- Flutter tests run serially, file by file (the shared HTTP test
  app in `tom_d4rt_flutterm` is corrupted by parallel runs).

## Results vs `testlog_20260429-step4-sync-third-twin`

| Project                | sync-third-twin | recursive-sync | Δ pass | Δ fail | Verdict |
| ---------------------- | -------------: | --------------: | -----: | -----: | ------- |
| essential_classes_test |    108 / 0 / 0 |     108 / 0 / 0 |   +0 |   +0 | match |
| important_classes_test |    164 / 0 / 0 |     164 / 0 / 0 |   +0 |   +0 | match |
| secondary_classes_test |    653 / 0 / 1 |     653 / 0 / 1 |   +0 |   +0 | match |
| tom_d4rt               |  1733 / 6 / ~1 |   1733 / 6 / ~1 |   +0 |   +0 | match |
| tom_d4rt_ast           |    101 / 2 / 0 |     101 / 2 / 0 |   +0 |   +0 | match |
| tom_d4rt_dcli          |    706 / 0 / 0 |     706 / 0 / 0 |   +0 |   +0 | match |
| tom_d4rt_exec          |  2234 / 26 / 0 |   2234 / 26 / 0 |   +0 |   +0 | match |
| tom_d4rt_generator     |   639 / 21 / 0 |    639 / 21 / 0 |   +0 |   +0 | match |
| tom_ast_generator      |    504 / 6 / 0 |     504 / 6 / 0 |   +0 |   +0 | match |
| tom_dcli_exec          |     72 / 8 / 0 |      72 / 8 / 0 |   +0 |   +0 | match |

## Verdict

Zero regressions across all 10 suites. `tom_d4rt_ast` now performs
the same recursive interpreter→native unwrap at the script→host
boundary that `tom_d4rt` has always performed. The two interpreter
packages are back in sync on this concern.

The "deferred recursive-unwrap asymmetry" note added to
`d4rt_consolidation_plan.md` in the prior `sync-third-twin` testlog
is superseded by this addendum — it framed the asymmetry as
deliberate (citing the `D4.unwrapInterpreterValue` reified-generics
docstring caveat), but that caveat applies to leaf-level unwrap
helpers, not to the top-level script-return unwrap, which is a
separate concern. The recursion is the established working
behavior in the parent package and was simply missed during the
fork.

## Why no behavioural change in this corpus

The 10-suite battery is unchanged because none of the existing
test scripts return interpreter-side values that depend on the
deep unwrap at the `D4rtRunner` boundary — `tom_d4rt_flutterm`
exercises the `tom_d4rt_exec` path (which goes through
`tom_d4rt`'s `D4rt`, where the recursion was already in place), and
`tom_d4rt_ast`'s own tests don't currently assert on
deep-unwrapped collections from `executeBundle`. The fix is
correct-by-construction sync — it removes a latent class of bugs
for any future caller who hits the `D4rtRunner` path with a
script returning `List<BridgedInstance>` / records.
