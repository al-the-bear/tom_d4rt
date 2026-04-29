# Step 5 idempotency — make D4 / BridgedClass register-* methods idempotent and drop `_relaxersRegistered`

`tom_d4rt_flutterm/doc/d4rt_consolidation_plan.md` — step 5. The
generated `registerRelaxers()` block in `flutter_relaxers.b.dart` issues
~119 calls to `D4.registerGenericConstructor` and several thousand
calls to `D4.registerGenericTypeWrapper`. Two of those registries —
`registerGenericConstructor` (chains via closure) and
`registerGenericTypeWrapper` (appends to per-key list) — are *not*
idempotent: a second invocation re-chains / re-appends the same
factory, so the per-key dispatch grows linearly with the number of
`FlutterD4rt` instances created in a process. The
`_relaxersRegistered` static-bool guard in
`tom_d4rt_flutterm/lib/src/flutter_d4rt.dart` was there only to mask
this — but it imposes a "first instance wins" rule that gets in the
way of the step-6 finalize-bridges hook.

This step makes all five named register-* methods idempotent and
removes the static-bool guard.

## What changed

### `tom_d4rt_ast/lib/src/runtime/generator/d4.dart` — interpreter (analyzer-free)

- `registerGenericConstructor` — added a companion
  `Map<String, Set<GenericConstructorFactory>>
  _genericConstructorIdentities` that tracks which factory identities
  have already been registered for each
  `'$className.$constructorName'` key. The function early-returns when
  the same factory is registered twice; distinct factories still chain
  exactly as before. Idempotency promise documented in the docstring.
- `registerGenericTypeWrapper` — added a companion
  `Map<String, Set<GenericTypeWrapperFactory>>
  _genericTypeWrapperIdentities` for the same purpose. The function
  no-ops on duplicate factory identities; distinct factories for the
  same base type still append in registration order.
- `registerInterfaceProxy`, `registerTypeCoercion`,
  `registerSupplementaryMethod` — already idempotent (overwrite
  semantics on per-key entries). Added explicit "**Idempotent:**"
  notes to the docstrings so the contract is discoverable.

### `tom_d4rt_ast/lib/src/runtime/bridge/bridged_types.dart` — `BridgedClass`

- `registerSupertypes` — already idempotent (per-key value is a `Set`
  with `addAll`). Added explicit "**Idempotent:**" docstring note.

### `tom_d4rt/lib/src/generator/d4.dart` — interpreter (analyzer-based, twin)

- Hard-sync mirror of all the above changes. The two interpreter
  packages must stay aligned per the quest's
  "Keep tom_d4rt ↔ tom_d4rt_ast in sync" rule.

### `tom_d4rt/lib/src/bridge/bridged_types.dart`

- Mirror of the `registerSupertypes` docstring update.

### `tom_d4rt_flutterm/lib/src/flutter_d4rt.dart` — drop the guard

- Removed the file-level `bool _relaxersRegistered = false;` static.
- Removed the `static void _ensureRelaxersRegistered()` wrapper.
- `_registerBridges()` now calls `registerRelaxers()` and
  `registerD4rtRuntimeExtensions()` directly on every instance —
  safe because every register-* call below them is now idempotent.
- Comment explains the load-bearing rationale (so future readers don't
  reintroduce a guard).

### New tests — `tom_d4rt_ast/test/runtime/register_idempotency_test.dart`

Seven tests assert the contract directly with synthetic keys:

1. `registerInterfaceProxy` — repeat register no-throws, key visible.
2. `registerTypeCoercion` — repeat register no-throws.
3. `registerGenericConstructor` (bare) — same factory registered three
   times stays as the bare factory (identity check via
   `findGenericConstructor`); proves no chained-on-itself closure.
4. `registerGenericConstructor` (chain) — two distinct factories chain;
   re-registering either does not extend the chain (identity stays at
   the chained closure built from the two distinct factories).
5. `registerGenericTypeWrapper` — repeat register no-throws for both
   the same factory and a second distinct factory.
6. `registerSupplementaryMethod` — repeat with same adapter is identity
   no-op; different adapter for same key overwrites.
7. `BridgedClass.registerSupertypes` — repeat call with same hierarchy
   is a Set no-op; later calls layer additional supertypes on top.

## Setup

- `--concurrency=1` on every `dart test` invocation
  (example/d4 setUpAll race avoidance).
- `D4RT_SKIP_BRIDGE_REGEN=1` for every flutter test run (no
  generator changes; bridges already in their correct state).
- Flutter tests run serially, file by file, chained with `&&` (the
  shared HTTP test app in `tom_d4rt_flutterm` is corrupted by
  parallel runs).
- Dart suites run in parallel (separate package processes, no shared
  state).

## Results vs `testlog_20260429-step4-recursive-sync`

| Project                | step-4 recursive-sync | step-5 idempotency |  Δ pass |  Δ fail | Verdict |
| ---------------------- | --------------------: | -----------------: | ------: | ------: | ------- |
| essential_classes_test |           108 / 0 / 0 |        108 / 0 / 0 |      +0 |      +0 | match |
| important_classes_test |           164 / 0 / 0 |        164 / 0 / 0 |      +0 |      +0 | match |
| secondary_classes_test |           653 / 0 / 1 |        653 / 0 / 1 |      +0 |      +0 | match |
| tom_d4rt               |          1733 / 6 / ~1 |       1733 / 6 / ~1 |     +0 |      +0 | match |
| tom_d4rt_ast           |           101 / 2 / 0 |        108 / 2 / 0 | **+7** |      +0 | improved (new idempotency tests) |
| tom_d4rt_dcli          |           706 / 0 / 0 |        706 / 0 / 0 |      +0 |      +0 | match |
| tom_d4rt_exec          |          2234 / 26 / 0 |       2234 / 26 / 0 |     +0 |      +0 | match |
| tom_d4rt_generator     |           639 / 21 / 0 |        639 / 21 / 0 |     +0 |      +0 | match |
| tom_ast_generator      |           504 / 6 / 0 |        504 / 6 / 0 |      +0 |      +0 | match |
| tom_dcli_exec          |            72 / 8 / 0 |         72 / 8 / 0 |      +0 |      +0 | match |

## Verdict

Zero regressions across all 10 suites. `tom_d4rt_ast` gains +7 tests —
the new register-twice contract suite (all green). The
`_relaxersRegistered` static-bool guard is gone, and the registry
contract is explicit and tested. The 4-suite flutterm battery (which
exercises the actual `registerRelaxers()` / `registerD4rtRuntimeExtensions()`
path on every test app spin-up) remains all-green, confirming the
removed guard does not regress real Flutter rendering.

## Why no behavioural change in this corpus

The flutterm test app constructs only one `FlutterD4rt` instance per
process (the test harness binds the interpreter once at app startup),
so even before this change the second-time-through path was never
exercised. The fix is correct-by-construction sync: it removes a
latent class of bugs for any harness that does construct multiple
`FlutterD4rt` instances (the planned step-6 finalize-bridges hook
sketches one such harness).

## Why the dart suites are unchanged

`tom_d4rt` and `tom_d4rt_ast` already exercise these registries via
their own bridge generation tests, but those tests build fresh
registries in a clean process per test, never re-registering the
same factory. The new register-twice tests in
`tom_d4rt_ast/test/runtime/register_idempotency_test.dart` are the
first direct coverage of the contract.
