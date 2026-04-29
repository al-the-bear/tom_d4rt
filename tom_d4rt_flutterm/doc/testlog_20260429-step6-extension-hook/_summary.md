# Step 6 — Runner-level extension hook (`registerExtensions` / `finalizeBridges`)

## What landed

- `tom_d4rt_ast/lib/src/runtime/d4rt_runner.dart` — added
  `registerExtensions(String packageName, void Function() body)` and
  `finalizeBridges()` to `D4rtRunner`. Callbacks are stored in a
  `Map<String, void Function()>` keyed by package name (later
  registration with the same key overwrites; insertion order is
  preserved for first-seen keys). `finalizeBridges()` flips
  `_bridgesFinalized = true` on first call and is idempotent
  thereafter; `registerExtensions` after finalize throws
  `StateError`. `_executeInEnvironment` calls `finalizeBridges()` at
  its top, so embedders that skip the explicit call still get the
  callbacks fired before pass 1.
- `tom_d4rt_exec/lib/src/d4rt_base.dart` — `D4rt` mirrors the runner
  surface: `bridgesFinalized` getter, `registerExtensions(...)`,
  `finalizeBridges()`. The classic `_executeInEnvironment` invokes
  `_runner.finalizeBridges()` before pass 1.
- `tom_d4rt_ast/test/runtime/extension_hook_test.dart` — 7-test
  contract suite covering registration order, idempotent finalize,
  package-name overwrite semantics, `StateError` after finalize,
  implicit finalize on first execute, and the no-re-run guarantee on
  subsequent executes.
- `tom_d4rt_flutterm/lib/src/flutter_d4rt.dart` — switched over to the
  hook. **Order deviates from the plan-spec sketch on purpose**: only
  `registerD4rtInterfaceProxyOverrides()` is queued in the post-material
  callback; `registerRelaxers()` and `registerD4rtRuntimeExtensions()`
  still run BEFORE `FlutterMaterialBridges.register`. See
  "Regression and fix" below.

## Regression and fix

Initial implementation followed the plan-spec literally and queued
all three user-bridge calls (`registerRelaxers`,
`registerD4rtRuntimeExtensions`, `registerD4rtInterfaceProxyOverrides`)
inside the post-material callback. Result: secondary suite went from
the step-5 baseline of **653/0/1** to **652/1/1** with one new
failure in `widgets/gesture_detector_adv_test.dart`:

```
Runtime Error: Error in generic constructor factory for 'ValueNotifier':
type 'int' is not a subtype of type 'double?' in type cast
```

triggered by perfectly normal Dart like `ValueNotifier<int>(0)`.

Root cause: generic constructor factories chain newest-first. The
material auto-gen factory for `ValueNotifier<T>` is correctly
type-driven; the user-bridge factory in `registerRelaxers()` /
`registerD4rtRuntimeExtensions()` hard-casts to `double?` (legacy
shape that pre-dates the auto-gen layer). When user-bridge
registration ran AFTER `FlutterMaterialBridges.register` (the
plan-spec order), the user-bridge factory became the primary in the
chain and threw on `int`. Step-5 ordering had user-bridge BEFORE
material, so material's auto-gen factory sat on top of the chain
and handled the call.

Fix: keep `registerRelaxers()` and `registerD4rtRuntimeExtensions()`
BEFORE `FlutterMaterialBridges.register`. Only
`registerD4rtInterfaceProxyOverrides()` truly needs to run AFTER
material (Bug-103: it re-registers a handful of `<dynamic>`-parameterised
proxies with concrete type arguments and depends on material's
proxy registrations), and that one stays inside the queued callback.
The hook still earns its keep — it programmatically enforces the
"after-material" rule for proxy overrides instead of relying on a
comment.

The plan-spec sketch was over-specified; the actual ordering
constraint is narrower than "all post-material work goes in the
callback".

## Verification

Flutter battery (serial, file-by-file, `D4RT_SKIP_BRIDGE_REGEN=1`):

| Suite | Step 5 baseline | Step 6 post-fix | Δ |
|-------|-----------------|-----------------|---|
| `essential_classes_test` | 108/0/0 | 108/0/0 | 0 |
| `important_classes_test` | 164/0/0 | 164/0/0 | 0 |
| `secondary_classes_test` | 653/0/1 | 653/0/1 | 0 |
| `generator_interpreter_issues_test` | 81/2/0 | 81/2/0 | 0 |

Format: `passing/skipped/failing`. All four suites match the step-5
baseline exactly — zero regressions, zero new failures, zero new
passes.

Dart battery (separate-process, runs do not race):

| Project | Step 6 |
|---------|--------|
| `tom_d4rt` | green vs baseline |
| `tom_d4rt_ast` (incl. new `extension_hook_test.dart`) | 7/7 new + green vs baseline |
| `tom_d4rt_exec` | green vs baseline |
| `tom_d4rt_generator` | green vs baseline |
| `tom_ast_generator` | green vs baseline |
| `tom_d4rt_dcli` | green vs baseline |
| `tom_dcli_exec` | green vs baseline |

(Captured during the pre-fix verification round; the regression-fix
edit only touches `tom_d4rt_flutterm/lib/src/flutter_d4rt.dart`, so
the dart-side packages are unaffected and re-running them is not
warranted.)

## Logs in this folder

- `essential_classes_test.log.txt` — pre-fix baseline run (matches
  step 5)
- `essential_classes_test_postfix.log` — post-fix verification
- `important_classes_test.log.txt` / `important_classes_test_postfix.log`
- `secondary_classes_test.log.txt` (pre-fix, 652/1/1) /
  `secondary_classes_test_postfix.log` (post-fix, 653/0/1)
- `generator_interpreter_issues_test_postfix.log` — post-fix gii run
- `tom_d4rt.log.txt`, `tom_d4rt_ast.log.txt`, `tom_d4rt_exec.log.txt`,
  `tom_d4rt_generator.log.txt`, `tom_ast_generator.log.txt`,
  `tom_d4rt_dcli.log.txt`, `tom_dcli_exec.log.txt` — dart battery

## Contracts the hook now enforces

1. Extension callbacks fire in registration order on the first
   `finalizeBridges()` call (or on the implicit hook in
   `_executeInEnvironment` if the embedder skips the explicit call).
2. Subsequent `finalizeBridges()` calls and subsequent `executeBundle`
   calls do NOT re-run callbacks.
3. `registerExtensions` after `finalizeBridges` throws `StateError`.
4. Re-registering with the same package name overwrites the body —
   one extension per package.

These are pinned by `tom_d4rt_ast/test/runtime/extension_hook_test.dart`.
