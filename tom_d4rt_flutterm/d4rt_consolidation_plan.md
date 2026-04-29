# `tom_d4rt_flutterm` consolidation plan — lift generic D4rt machinery upstream

**Scope.** Audit `tom_d4rt_flutterm/lib/` and move every component that is
not actually Flutter-specific into `tom_d4rt_ast` (the analyzer-free
core) and `tom_d4rt` / `tom_d4rt_exec` (the analyzer-based companion),
keeping the two interpreter layers in sync per the quest's hard rule.
Drive the migration in 7 small, regression-tested steps so the cluster
campaign on the flutter-material corpus is never broken for more than a
single commit.

**Author.** Senior engineer audit, 2026-04-29.

---

## Part 1 — Analysis

### TL;DR

Roughly **two-thirds of the ~4,700 hand-written lines under
`tom_d4rt_flutterm/lib/`** is generic D4rt machinery that should live in
`tom_d4rt`/`tom_d4rt_ast`. The genuinely Flutter-specific surface is:

1. The bridge artifacts (`bridges/*.b.dart`, all generated).
2. A handful of concrete Flutter native-proxy classes — the
   `_InterpretedXxx implements <Flutter abstract>` adapters that import
   `package:flutter/*` directly.
3. Three user bridges in `lib/src/d4rt_user_bridges/`.

Everything else — including `FlutterD4rt._unwrap`, the
supertype/proxy/coercion *registries*, `registerD4rtRuntimeExtensions`,
the runner-shaped façade — is generic and was only landed here because
that's where the test corpus pressure exposed the gaps.

### What's in `tom_d4rt_flutterm/lib/` and where it should live

| Component | LOC | What it actually does | Where it belongs |
|---|---:|---|---|
| `flutter_d4rt.dart` — `FlutterD4rt._unwrap<T>()` | ~50 | Walks `BridgedInstance.nativeObject`, `BridgedEnumValue.nativeValue`, falls back to `D4.tryCreateInterfaceProxyWithVisitor`, throws on mismatch. | **`tom_d4rt_ast`** (`D4rtRunner` / `D4`) — see "The unwrap discussion" below. |
| `flutter_d4rt.dart` — `FlutterD4rt` shell, `build/buildAsync/execute/executeAsync<T>` | ~120 | Typed convenience over `executeBundle`, optional first-positional `BuildContext` arg, async detection. | **Mostly `tom_d4rt_ast`.** Generic typed `executeBundleAs<T>` plus async unwrap belongs on `D4rtRunner`. The `BuildContext` parameter is the only Flutter concession and is just `[BuildContext? ctx]` syntactic sugar; trivial to keep here as a one-line wrapper around a generic `executeBundleAs<T>(positionalArgs: [...])`. |
| `flutter_d4rt.dart` — `FlutterD4rtException` | ~7 | Throw class. | **Stays here** (or absorb into a generic `D4rtUnwrapException` upstream). |
| `d4rt_runtime_registrations.dart` — `_registerBridgedSupertypes` (`BridgedClass.registerSupertypes({...})`) | ~110 | A *Flutter*-specific data table (Widget hierarchy, RestorationMixin, BoxConstraints, etc.). The mechanism (`BridgedClass.registerSupertypes`) is generic; the *data* is Flutter. | **Mechanism stays in `tom_d4rt_ast`** (it already does). The data table stays here — it is a Flutter dictionary, not interpreter logic. |
| `d4rt_runtime_registrations.dart` — `_registerInterfaceProxies` + the `_InterpretedXxx` adapter classes (~40 of them: `_InterpretedStatelessWidget`, `_InterpretedStatefulWidget`, `_InterpretedRenderBox`, `_InterpretedRouterDelegate`, …) | ~3,000 | Each one is a real Flutter class that extends a Flutter abstract base and forwards calls to an `InterpretedInstance`. They depend on `flutter/widgets.dart`, `flutter/rendering.dart`, etc. | **Stays here.** These cannot move — they import Flutter. The *registration plumbing* (`D4.registerInterfaceProxy`, `D4.tryCreateInterfaceProxyWithVisitor`) is already in `tom_d4rt_ast`. |
| `d4rt_runtime_registrations.dart` — `_registerTypeCoercions` data | ~40 | `painting.TextStyle ↔ ui.TextStyle`, `painting.StrutStyle ↔ ui.StrutStyle`. Flutter-only. | **Stays here.** |
| `d4rt_runtime_registrations.dart` — `_registerGenericConstructors` data (`GlobalKey<T>`, `ValueKey<T>`, `ValueNotifier<T>`, `Tween<T>`, `RestorableValue<T>`, …) | ~140 | Concrete generic-constructor factories. Hard-coded Flutter type names. | **Stays here.** Mechanism (`D4.registerGenericConstructor`) is generic. |
| `d4rt_runtime_registrations.dart` — `_registerSupplementaryMethods` data (`ChangeNotifier.notifyListeners`, `State.widget`, `State.setState`, …) | ~200 | `@protected` methods the bridge generator skips. Flutter targets. | **Stays here**, mechanism upstream. |
| `d4rt_runtime_registrations.dart` — `_registerSupplementaryRelaxers` | ~25 | Same pattern. | **Stays here.** |
| `d4rt_runtime_registrations.dart` — `_registerGenericWidgetReCreators` | ~190 | Re-creates Flutter widgets with concrete type args at boundary crossings. Flutter only. | **Stays here.** |
| `d4rt_runtime_registrations.dart` — `_registerBridgedMethodInterceptors` | ~220 | Late-bound interception of bridge dispatch for specific Flutter classes. | **Stays here.** |
| `d4rt_user_bridges/state_user_bridge.dart` | 70 | Defers `setState` via `addPostFrameCallback` when called mid-frame. Imports `flutter/scheduler.dart`. | **Stays here.** |
| `d4rt_user_bridges/strut_style_user_bridge.dart` | 62 | Maps `ui.StrutStyle()` constructor to `painting.StrutStyle()`. Flutter only. | **Stays here.** |
| `d4rt_user_bridges/basic_message_channel_user_bridge.dart` | 60 | Bypasses `BasicMessageChannel<T>.setMessageHandler` typed signature. Flutter only. | **Stays here.** |
| `bridges/*.b.dart` (17 files, generated) | — | Output of `tom_d4rt_generator` against `flutter/{material, widgets, rendering, …}`. | **Stays here** — these *are* the Flutter package. |

### The unwrap discussion (the part that matters)

`FlutterD4rt._unwrap<T>` (in `lib/src/flutter_d4rt.dart`) does:

```dart
T _unwrap<T>(Object? result) {
  if (result is BridgedInstance)         { ... unwrap nativeObject, type-check T ... }
  if (result is BridgedEnumValue)        { ... unwrap nativeValue, type-check T ... }
  if (result is T)                        return result;
  if (result == null && null is T)        return result as T;
  if (result is InterpretedInstance) {   // INTER-009
    if (bridgedSuperObject is T) ...
    final visitor = D4.activeVisitor ?? _interpreter.visitor;
    final proxy = D4.tryCreateInterfaceProxyWithVisitor<T>(result, visitor);
    if (proxy != null) return proxy;
  }
  throw ...;
}
```

**Nothing here is Flutter-specific.** The pieces it relies on —
`BridgedInstance.nativeObject`, `BridgedEnumValue.nativeValue`,
`InterpretedInstance.bridgedSuperObject`,
`D4.tryCreateInterfaceProxyWithVisitor`, `D4.activeVisitor`,
`D4rt.visitor` — all already live in `tom_d4rt_ast` (and are re-exported
by `tom_d4rt_exec`). The only thing tying the routine here is the entry
point name.

The right shape is one generic helper plus typed convenience methods on
`D4rtRunner`:

```dart
// In tom_d4rt_ast (D4 helper, sibling of D4.unwrapInterpreterValue):
T D4.unwrapAs<T>(
  Object? value, {
  InterpreterVisitor? visitor,
  String? expectedDescription,
});

// On D4rtRunner (and D4 in tom_d4rt_exec):
T executeBundleAs<T>(
  AstBundle bundle, {
  String name = 'main',
  List<Object?>? positionalArgs,
  Map<String, Object?>? namedArgs,
});
Future<T> executeBundleAsAsync<T>(...);
```

`FlutterD4rt.build<Widget>(bundle, ctx)` then shrinks to:

```dart
T build<T>(AstBundle b, [BuildContext? c]) =>
    _interpreter.executeBundleAs<T>(b, name: 'build',
        positionalArgs: c == null ? null : [c]);
```

That is the **only** line of that file with a Flutter import
(`BuildContext`), and the file shrinks from 228 lines to ~60.

This also fixes a small ownership bug. The comment at `flutter_d4rt.dart`
lines 200–209 (INTER-009) says the `tryCreateInterfaceProxy` fallback
"mirrors what `D4.extractBridgedArg<T>` does at every bridge boundary
during script execution." If the boundary version lives in `D4` and the
top-level-return version lives only in `FlutterD4rt`, anyone using
`D4rtRunner` directly (e.g. the `tom_dartscript_bridges` REPL,
server-side scripting, or any future analyzer-free Flutter embedder)
either re-implements this same fallback or drops it silently. The fix is
to lift it onto `D4rtRunner`.

### Other generic candidates worth lifting

These already have their *machinery* upstream but the **typed data
tables** are mixed with the dispatch glue. Worth separating, but lower
priority than the unwrap fix:

1. **`registerD4rtRuntimeExtensions()` orchestrator function.** The
   function name and the 8-step sequence (`supertypes → proxies →
   coercions → generic ctors → supplementary → relaxers → re-creators →
   interceptors`) is a generic ordering convention. It deserves to be a
   documented hook on `D4rtRunner`
   (`D4rtRunner.registerExtensions(void Function() body)`) so other
   bridge packages — `tom_dartscript_bridges`, future `tom_dist_ledger`
   bridges, etc. — don't reinvent the order or land subtle ordering bugs.

2. **The "must run AFTER bridges" comment at lines 38-43 / 55-60 of
   `flutter_d4rt.dart`.** That ordering rule (extension registrations
   follow bridge registrations) is generic. If it has to be respected by
   every bridge package, it should be enforced by `D4rtRunner`
   (e.g. `runner.finalizeBridges()` triggers a single registration
   pass), not by comment-and-hope.

3. **`_relaxersRegistered` static guard.** Anyone calling
   `registerRelaxers()` twice (which happens cleanly when you make two
   `FlutterD4rt` instances) gets duplicate registrations. The
   idempotency belongs in the registry
   (`BridgedClass.registerSupertypes` already deduplicates;
   `D4.registerInterfaceProxy` should too if it doesn't), not in a
   static bool in a downstream package.

### What does *not* belong upstream

- Anything that imports `package:flutter/*` — that's all of `bridges/`,
  all `_InterpretedXxx` adapters, `state_user_bridge.dart`,
  `strut_style_user_bridge.dart`,
  `basic_message_channel_user_bridge.dart`. Moving these would force
  `tom_d4rt_ast` to depend on Flutter and defeat the analyzer-free
  Flutter-app goal in the quest overview.
- The 110-line *data table* in `_registerBridgedSupertypes`. The
  mechanism is generic; the contents aren't.
- The 40-class `_InterpretedXxx` proxy zoo. They're concrete Flutter
  subclasses by definition.

### Recommendation summary

1. **Lift `_unwrap<T>` to a generic `D4.unwrapAs<T>` (and
   `D4rtRunner.executeBundleAs<T>`).** Pure refactor, no behavioural
   change, kills duplication for any future embedder. Mirror in
   `tom_d4rt_exec`'s `D4rt.executeBundleAs<T>`. ~80 lines moved, ~10
   lines stay in flutterm.
2. **Add a `D4rtRunner.finalizeBridges()` hook** that runs registered
   post-bridge callbacks in deterministic order. Replace the
   `_ensureRelaxersRegistered` static bool plus the "must run AFTER"
   comment chain with one call.
3. **Audit `tom_d4rt`'s `D4rt` class for the same
   `BridgedInstance/InterpretedInstance` unwrap pattern** — `d4rt_base.dart`
   line 1820-21 (`if (interpreterValue is BridgedInstance) return
   interpreterValue.nativeObject`) is a third copy of the same logic; it
   should call the shared helper.
4. **Leave the `_InterpretedXxx` adapter zoo and the user bridges
   alone.** They are correctly placed.

---

## Part 2 — Implementation plan (7 sessions)

### Working conventions

The plan is split so each session can be run end-to-end in a fresh
Copilot window without context overlap. Each session follows the same
shape:

1. **Pre-step commit.** Commit any uncommitted state of the projects to
   be modified, scoped to the relevant repos only (no `-A`).
2. **Code change.** Implement the step.
3. **Sync rule.** Any change to the interpreter must land in **both**
   `tom_d4rt/lib/src/interpreter_visitor.dart` and
   `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`. Any change to
   the `D4` helper must land in **both**
   `tom_d4rt/lib/src/generator/d4.dart` and
   `tom_d4rt_ast/lib/src/runtime/generator/d4.dart`. A step that only
   lands in one side is **not done**.
4. **Regression tests** (see "Regression matrix" below).
5. **Capture full output** of every test run to a fresh testlog folder
   under `tom_d4rt_flutterm/doc/testlog_consol_<step>_<id>/`. Never
   re-run tests just to see results — always `tee` to a log first.
6. **Update step status in this file** (`Status: done|deferred|reverted`,
   plus a one-paragraph summary).
7. **Commit + push** in one or more focused commits. Always create a new
   commit; never amend. If a hook fails, fix the cause and create a new
   commit.

### Regression matrix

The regression test rule is the same as for the cluster campaign:

| Change category | Required regression run |
|---|---|
| (a) Test-script only (under `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/`) | Single-test retest of the affected script. |
| (b) Bridge generator / d4rt interpreter / `tom_d4rt_flutterm/lib/` (non-test) | Serial run of the four full suites: `gii` (`generator_interpreter_issues_test.dart`), `essential_classes_test`, `important_classes_test`, `secondary_classes_test`. |

Every step in this plan is category (b), so every step ends with the
4-suite regression battery, run **serially** (never in parallel — the
test app HTTP server corrupts under concurrent test invocations). Run
with `D4RT_SKIP_BRIDGE_REGEN=1` so bridges are not regenerated mid-run
and the runs stay short (~8 minutes total).

If a step's regression run fails, narrow the change or **revert** it,
add the failure mode + diagnosis to `interpreter_unfixable.md`, and mark
the step `Status: reverted`. The migration is sequential: do not start
step `n+1` if step `n` is reverted.

### Step sizing

Steps are scoped to fit one Copilot session each. The risky step is
**Step 3** (the first behavioural cutover); steps 1, 2, 4 are pure
additions; steps 5, 6, 7 are progressive cleanups whose worst case is a
revert with no functional impact.

---

### Step 1 — `D4.unwrapAs<T>` helper, dual-landed

**Goal.** Add a single, well-tested generic helper that consolidates the
three currently scattered unwrap paths (FlutterD4rt._unwrap,
D4.unwrapInterpreterValue, the ad-hoc unwrap in
`tom_d4rt/lib/src/d4rt_base.dart`).

**Files.**

- `tom_d4rt_ast/lib/src/runtime/generator/d4.dart` — add `static T D4.unwrapAs<T>(Object?, {InterpreterVisitor? visitor, String? expectedDescription})`. Behaviour: `BridgedInstance → nativeObject`, `BridgedEnumValue → nativeValue`, `InterpretedInstance → bridgedSuperObject || tryCreateInterfaceProxyWithVisitor<T>`, raw `is T`, null when `null is T`, otherwise throws `D4UnwrapException`.
- `tom_d4rt/lib/src/generator/d4.dart` — same helper, mirrored exactly.
- New `D4UnwrapException` class in both packages (`tom_d4rt_ast/lib/src/runtime/exceptions.dart` and the corresponding file in `tom_d4rt`).
- `tom_d4rt_ast/test/runtime/unwrap_as_test.dart` (new) — unit coverage for every branch (BridgedInstance match, BridgedInstance type mismatch, BridgedEnumValue, InterpretedInstance with proxy, InterpretedInstance without proxy → throws, null + null is T, raw cast).
- `tom_d4rt/test/generator/unwrap_as_test.dart` (new) — same unit coverage, identical assertions, against the analyzer-based class.

**No flutterm caller yet** — `FlutterD4rt._unwrap` continues to use its
local copy. This step is pure addition; the new helper is dead code
until step 3.

**Regression.**

- Run `dart test` in `tom_d4rt_ast` and `tom_d4rt` — new tests must pass, no existing test regresses.
- Run the 4-suite battery in `tom_d4rt_flutterm` — should be a no-op (no flutterm code touched).

**Status.** _pending_

---

### Step 2 — `D4rtRunner.executeBundleAs<T>` and `executeBundleAsAsync<T>`

**Goal.** Expose the unwrap helper as a typed entry point on the
runner, so bridge packages can ask the runner to do the unwrap rather
than re-implementing it.

**Files.**

- `tom_d4rt_ast/lib/src/runtime/d4rt_runner.dart` — add
  ```dart
  T executeBundleAs<T>(AstBundle bundle, {String? entryPoint, String name = 'main', List<Object?>? positionalArgs, Map<String, Object?>? namedArgs});
  Future<T> executeBundleAsAsync<T>(...);
  ```
  Internally call `executeBundle(...)`, await `Future` if needed, then
  `D4.unwrapAs<T>(result, visitor: visitor)`.
- `tom_d4rt_exec/lib/src/d4rt_base.dart` — same pair on the analyzer
  `D4rt` class. The implementation forwards to the inner runner's typed
  variant so the unwrap path is identical.
- Re-export via `tom_d4rt_ast/lib/runtime.dart` and
  `tom_d4rt_exec/lib/d4rt.dart` so existing imports keep working.
- New tests:
  `tom_d4rt_ast/test/runtime/execute_bundle_as_test.dart` and
  `tom_d4rt/test/d4rt_execute_bundle_as_test.dart` covering: bundle returning a
  bridged Flutter-free type (e.g. an `int`), a `BridgedInstance` over a
  test bridge, and an `InterpretedInstance` with a registered interface
  proxy (use a synthetic test bridge, not Flutter — the test stays in
  the analyzer-free package).

**No flutterm caller yet.**

**Regression.**

- `dart test` in `tom_d4rt_ast` and `tom_d4rt`.
- 4-suite battery in `tom_d4rt_flutterm` — still a no-op.

**Status.** _pending_

---

### Step 3 — Cut `FlutterD4rt` over to `executeBundleAs<T>` (the behavioural step)

**Goal.** Delete `FlutterD4rt._unwrap` and route every `build / buildAsync /
execute / executeAsync<T>` through `_interpreter.executeBundleAs<T>`. This is
the only step that actually changes runtime behaviour for the test app, and
it is the highest-risk one — the regression battery here is the gate.

**Files.**

- `tom_d4rt_flutterm/lib/src/flutter_d4rt.dart`:
  - Remove `_unwrap<T>` (~50 lines).
  - Rewrite `build`, `buildAsync`, `execute`, `executeAsync` as
    one-liners that call the typed runner methods.
  - Keep `FlutterD4rtException` for now — re-throw `D4UnwrapException`
    as `FlutterD4rtException` to preserve the public exception contract;
    bridge any other paths users may catch on.
  - Final file should be ~60 lines.

**Regression.**

- 4-suite battery (gii, essential, important, secondary) in
  `tom_d4rt_flutterm`, serial, with `D4RT_SKIP_BRIDGE_REGEN=1`.
- Diff the testlog against the most recent green baseline
  (`session_resume.d4rt.md` records the latest counts). Any new
  failure or new framework error blocks the step — narrow or revert.
- Capture all four `.log.txt` and `.result.json` to
  `doc/testlog_consol_03_<id>/`.

**Status.** _pending_

---

### Step 4 — De-duplicate the third unwrap path in `tom_d4rt`'s `D4rt` class

**Goal.** Replace the ad-hoc unwrap inside
`tom_d4rt/lib/src/d4rt_base.dart` (line 1820-21:
`if (interpreterValue is BridgedInstance) return interpreterValue.nativeObject`,
plus the `InterpretedInstance` handling around lines 1016 and 1376) with a
call into the shared helper from step 1.

**Files.**

- `tom_d4rt/lib/src/d4rt_base.dart` — replace each duplicate unwrap with
  `D4.unwrapAs<Object?>(value, visitor: _visitor)` (typed `Object?`
  preserves the existing `dynamic` callers; tighten where the local
  type is known).
- `tom_d4rt_ast/lib/src/runtime/d4rt_runner.dart` — audit for the same
  pattern; if any exists (e.g. inside `executeBundle` post-processing),
  replace it too. **Sync rule applies** — both files in step.
- No new tests — the existing tom_d4rt unit suite already covers these
  paths.

**Regression.**

- `dart test` in `tom_d4rt` and `tom_d4rt_ast`.
- 4-suite flutterm battery (low risk — the unwrap in `d4rt_base.dart`
  is mostly hit by REPL / `eval()` paths the test app does not exercise,
  but rerun anyway for safety).

**Status.** _pending_

---

### Step 5 — Idempotency on registries; remove `_relaxersRegistered`

**Goal.** Make `D4.registerInterfaceProxy`,
`D4.registerTypeCoercion`, `D4.registerGenericConstructor`,
`D4.registerSupplementaryMethod`, and `BridgedClass.registerSupertypes`
*idempotent* — repeated calls with the same key return without error
and overwrite (or no-op, whichever each registry already supports for a
single call). Remove the `_relaxersRegistered` static bool from
`flutter_d4rt.dart`.

**Files.**

- `tom_d4rt_ast/lib/src/runtime/generator/d4.dart` — audit each
  registration map; ensure repeat-write is well-defined and documented.
- `tom_d4rt_ast/lib/src/runtime/bridge/bridged_types.dart` — same audit
  on `BridgedClass.registerSupertypes` (it already merges; document it).
- `tom_d4rt/lib/src/generator/d4.dart` — sync.
- `tom_d4rt/lib/src/bridge/...` — sync.
- `tom_d4rt_flutterm/lib/src/flutter_d4rt.dart` — drop
  `_relaxersRegistered`, drop `_ensureRelaxersRegistered`, call
  `registerRelaxers()` and `registerD4rtRuntimeExtensions()` directly
  in both constructors.
- New tests in `tom_d4rt_ast`: register-twice tests for each registry,
  asserting no exception and consistent post-state.

**Regression.**

- `dart test` in `tom_d4rt_ast` and `tom_d4rt`.
- 4-suite flutterm battery — particularly important here because the
  `_relaxersRegistered` removal allows registrations to fire twice if a
  process creates two `FlutterD4rt` instances (the test app does not,
  but other harnesses might).

**Status.** _pending_

---

### Step 6 — `D4rtRunner.registerExtensions(...)` / `finalizeBridges()` hook

**Goal.** Replace the comment-driven "must run AFTER bridges" rule
(lines 38-43 / 55-60 of `flutter_d4rt.dart`) with an enforced
mechanism. Bridge packages register an extension callback at
construction; the runner runs all callbacks in deterministic order
(insertion order, breaking ties by bridge package name) when
`finalizeBridges()` is called.

**Files.**

- `tom_d4rt_ast/lib/src/runtime/d4rt_runner.dart` — add
  ```dart
  void registerExtensions(String packageName, void Function() body);
  void finalizeBridges();
  ```
  Track whether `finalizeBridges()` has been called and assert that
  `executeBundle*` callers either call it explicitly or have it called
  on first execution. Document both contracts.
- `tom_d4rt_exec/lib/src/d4rt_base.dart` — mirror the methods on
  `D4rt`, forwarding to the inner runner.
- `tom_d4rt_flutterm/lib/src/flutter_d4rt.dart` — both constructors:
  ```dart
  FlutterMaterialBridges.register(_interpreter);
  _interpreter.registerExtensions('tom_d4rt_flutterm', () {
    registerRelaxers();
    registerD4rtRuntimeExtensions();
    registerD4rtInterfaceProxyOverrides();
  });
  _interpreter.finalizeBridges();
  ```
- New tests in `tom_d4rt_ast`: ordering test (two extensions register,
  assert callback execution order matches registration order), error
  test (calling `finalizeBridges()` twice is a no-op the second time).

**Regression.**

- `dart test` in `tom_d4rt_ast` and `tom_d4rt`.
- 4-suite flutterm battery.

**Status.** _pending_

---

### Step 7 — Final shrink + documentation cleanup

**Goal.** Lock in the final shape of `flutter_d4rt.dart` (~60 lines),
move the explanatory comments about ordering into upstream docs (or
delete them since the contract is now enforced), and update the
quest-level docs.

**Files.**

- `tom_d4rt_flutterm/lib/src/flutter_d4rt.dart` — final pass: any
  remaining "Bug-103" / "GEN-079" / "RC-2" comments that referenced the
  old ordering rule are either deleted (rule now enforced by
  `finalizeBridges()`) or moved into the doc comment of the upstream
  function they describe.
- `tom_d4rt_ast/doc/extension_registration.md` (new) — short note on
  the `registerExtensions / finalizeBridges` pattern, with the canonical
  example from `FlutterD4rt`.
- `tom_d4rt_flutterm/doc/d4rt_consolidation_plan.md` (this file) —
  flip every step status to `done` and add the final 4-suite numbers
  for comparison against the pre-migration baseline.
- `_ai/quests/d4rt/overview.d4rt.md` — one-paragraph note in the
  "Architecture" section that the typed-execute / extension-hook API
  lives upstream, with a one-line code example.

**Regression.**

- 4-suite flutterm battery, with the post-step results recorded in this
  document for the historical record.

**Status.** _pending_

---

## Status log

Update this section as each step completes, reverts, or defers.

| Step | Owner | Status | Commit(s) | Testlog | Summary |
|------|-------|--------|-----------|---------|---------|
| 1 | — | pending | — | — | — |
| 2 | — | pending | — | — | — |
| 3 | — | pending | — | — | — |
| 4 | — | pending | — | — | — |
| 5 | — | pending | — | — | — |
| 6 | — | pending | — | — | — |
| 7 | — | pending | — | — | — |

---

## Risk and rollback

Every step is reversible by `git revert <commit>`. Steps 1, 2, 4 are
pure additions (low risk). Step 3 is the only step that *removes* a
known-good code path (`FlutterD4rt._unwrap`); if its 4-suite battery
regresses, revert step 3 immediately — steps 1, 2 remain valid as dead
code until step 3 lands in a later session. Steps 5, 6, 7 each touch
production code paths but each has a small blast radius and a clean
revert.

The 4-suite battery is the tripwire. Any new framework error, any new
test failure, any cascade timeout that was not already in the baseline:
revert the step, document the failure mode in
`tom_d4rt_flutterm/doc/interpreter_unfixable.md`, and re-plan.
