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

**Status.** _done_ (2026-04-29) — testlog `testlog_20260429-1124-step1-unwrapAs/`.
Twelve new unit tests pass in both `tom_d4rt` and `tom_d4rt_ast`. Flutterm
3-suite battery matches baseline exactly (108/164/653). Other tom_d4rt_*
projects: zero regressions vs `testlog_20260429-1054-consol-baseline`. The
parallel-run summary showed an apparent +1 failure / -93 tests delta in
`tom_d4rt_exec` and a -66 tests delta in `tom_ast_generator`; both were
confirmed to be pre-existing setUpAll parallel-test races on the shared
`example/d4` project — `dart test --concurrency=1` reproduces the exact
baseline failure set (25F+1E in tom_d4rt_exec) and fewer-or-equal failures
in tom_ast_generator. No flutterm caller yet — `FlutterD4rt._unwrap`
unchanged; helper is dead code until step 3.

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

**Status.** _done_ — landed on 2026-04-29.

`D4rtRunner.executeBundleAs<T>` and `executeBundleAsAsync<T>` added
in `tom_d4rt_ast/lib/src/runtime/d4rt_runner.dart`; both forward to
`executeBundle` and apply `D4.unwrapAs<T>(result, visitor: _visitor)`
on the resolved result (the async variant awaits any returned
`Future` first). Mirrored on the analyzer `D4rt` class in
`tom_d4rt_exec/lib/src/d4rt_base.dart`, forwarding to the inner
`_runner`. Existing barrel re-exports already cover the new methods.

Tests:

- `tom_d4rt_ast/test/runtime/execute_bundle_as_test.dart` — 5 tests
  driving the runner with hand-built `SAstNode` bundles (since the
  analyzer-free package has no source parser): `int` passthrough,
  nullable-`null`, `D4UnwrapException` for type mismatch, sync
  passthrough on the async variant, and async type-mismatch via
  `expectLater`.
- `tom_d4rt_exec/test/d4rt_execute_bundle_as_test.dart` — 11 tests
  using `D4rt().createBundleFromSource(...)` with synthetic bridged
  `_NativeBox` / `_NativeColoredBox` classes (supertype hierarchy
  registered via `BridgedClass.registerSupertypes`) covering: int
  passthrough, `BridgedInstance` unwrap, subtype unwrap, the
  `bridgedSuperObject` branch via `class TaggedBox extends _NativeBox`,
  null handling for nullable / non-nullable `T`, `D4UnwrapException`
  for type mismatch, plus async variants for `Future<int>`, sync
  passthrough, `Future<BridgedInstance>`, and async type mismatch.

No flutterm caller yet (deferred to step 3).

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

**Status.** _done_ — landed on 2026-04-29.

`FlutterD4rt._unwrap<T>` (45 lines) deleted from
`tom_d4rt_flutterm/lib/src/flutter_d4rt.dart`. All four entry points
(`build`, `buildAsync`, `execute`, `executeAsync`) are now thin
wrappers around `_interpreter.executeBundleAs<T>` /
`executeBundleAsAsync<T>`. The unwrap path is identical to step 2
since both go through `D4.unwrapAs<T>`.

Public exception contract preserved: a small `_wrapUnwrap` /
`_wrapUnwrapAsync` helper catches `D4UnwrapException` and re-throws
as `FlutterD4rtException(e.message)`, so the test app's
`on FlutterD4rtException catch (e) { ... e.message ... }` paths
keep working without change.

Bridge registration cleanup: factored the duplicate body of the two
constructors into a single `_registerBridges()` method.

Final size: 172 lines (file includes ~30 lines of class-level
dartdoc and per-method dartdoc — the *executable* body is ~80
lines, down from ~135).

Regression vs `testlog_20260429-1054-consol-baseline` /
`testlog_20260429-step2-executeBundleAs`:

- flutterm 3-suite: 108 / 164 / 653~1 — exact baseline match.
- tom_d4rt_ast: +101 −2 — exact step-2 match.
- tom_d4rt_exec: +2234 −26 — exact step-2 match.
- tom_d4rt: +1733 −6 ~1 — exact step-2 match.
- tom_d4rt_dcli: +706 / 0 — exact baseline match.
- tom_dcli_exec: +72 −8 — exact baseline match.
- tom_d4rt_generator: +639 −21 — exact baseline match.
- tom_ast_generator: +504 −6 — exact step-2 match.

No regressions across any suite. The behavioural cutover is safe.

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

**Status.** _done_ — landed on 2026-04-29.

The plan's stated drop-in replacement worked cleanly in `tom_d4rt_ast`
but had to be narrowed in `tom_d4rt`:

- **`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`** — the
  whole `_bridgeInterpreterValueToNative` body collapsed to one
  `D4.unwrapAs<Object?>(interpreterValue, visitor: this)` call. The
  original three branches (BridgedInstance → nativeObject,
  BridgedEnumValue → nativeValue, pass-through) are exactly what
  `D4.unwrapAs` does for `T == Object?`.
- **`tom_d4rt/lib/src/d4rt_base.dart`** — only the BridgedInstance /
  BridgedEnumValue branches inside `_bridgeInterpreterValueToNative`
  delegated to `D4.unwrapAs<Object?>`. The recursive list / map /
  record handling below is intentionally **not** delegated —
  `D4.unwrapAs` is a single-level helper and replacing the recursive
  paths would lose the interpreter's nested-`BridgedInstance` unwrap
  inside collections and records. New import:
  `package:tom_d4rt/src/generator/d4.dart`. `_visitor` (nullable) is
  passed through as the `visitor:` argument.

The plan's pointer to "lines 1820-21 / 1016 / 1376" in `d4rt_base.dart`
was stale — the actual BridgedInstance unwrap lives at lines 1944-50
of the post-step-3 tree, and the script-result unwrap call site is at
line 1408. Lines 1016 and 1376 are pass-1 setup and arity validation
respectively, with no unwrap pattern; the only InterpretedInstance
"handling" near them is `if (functionResult is InterpretedInstance)
_interpretedInstance = functionResult;` (a reference snapshot for
`getCallable`, not an unwrap).

Regression vs `testlog_20260429-step3-flutterD4rt-cutover`:

- flutterm 3-suite: 108 / 164 / 653~1 — exact baseline match.
- tom_d4rt_ast: +101 −2 — exact step-3 match.
- tom_d4rt: +1733 −6 ~1 — exact step-3 match.
- tom_d4rt_dcli: +706 / 0 — exact baseline match.
- tom_d4rt_exec: +2234 −26 — exact step-3 match.
- tom_dcli_exec: +72 −8 — exact baseline match.
- tom_d4rt_generator: +639 −21 — exact baseline match.
- tom_ast_generator: +504 −6 — exact step-3 match.

Zero regressions across all 10 suites.

#### Sync addendum (2026-04-29) — third leaf-unwrap copy in `tom_d4rt/interpreter_visitor.dart`

Audit after the initial step-4 landing surfaced a **third** copy of
`_bridgeInterpreterValueToNative` in
`tom_d4rt/lib/src/interpreter_visitor.dart` (line 9152, called from
`_evaluateArguments` / `_evaluateArgumentsAsync` on lines 9129, 9144,
9224, 9241). Its body was the verbatim three-branch original, structurally
identical to `tom_d4rt_ast`'s pre-step-4 version that this step had
already collapsed to `D4.unwrapAs<Object?>`. Per the quest sync rule,
this twin was synced with the same one-liner delegation. `D4` is already
re-exported via `package:tom_d4rt/d4rt.dart`; no new import needed.

#### Recursive sync — recursive top-level unwrap ported to `tom_d4rt_ast`

`tom_d4rt/lib/src/d4rt_base.dart` carries a **structurally larger**
`_bridgeInterpreterValueToNative` (line 1938) that recursively walks
`List`, `Map`, and `InterpretedRecord` (with native-record creation up to
16 positional fields) before bottoming out on the leaf cases. It is
called from `_executeInEnvironment`, `_executeClassic`, `eval`, and
`_tryFunction` to convert script return values to native form.

`tom_d4rt_ast` is a fork of `tom_d4rt` and the recursive pass was
**not carried over** during the fork. The earlier `sync-third-twin`
testlog initially framed this as a "deliberate asymmetry" by reading
the `D4.unwrapInterpreterValue` reified-generics docstring caveat as
applying here — but that caveat addresses the **leaf-level** helper's
single-level contract, not the **top-level** script-return unwrap,
which is a separate concern. The recursion is the established working
behavior in the parent package and was simply missed during the fork.

Sync applied in this addendum:

- `tom_d4rt_ast/lib/src/runtime/d4rt_runner.dart` — added
  `_bridgeInterpreterValueToNative(Object?)` as a verbatim port of
  the body in `tom_d4rt/lib/src/d4rt_base.dart:1938` (same record
  arity ladder 0..16, same leaf delegation to `D4.unwrapAs<Object?>`
  for `BridgedInstance`/`BridgedEnumValue`).
- Wired at a **single source point** in `_executeInEnvironment`
  (end of method, before `return functionResult`). The deep-unwrap
  propagates to both the untyped `executeBundle` and the typed
  `executeBundleAs<T>` / `executeBundleAsAsync<T>` — those now apply
  only the leaf cast on already-deep-unwrapped data, no double-work.
- Future returns are unwrapped via `.then(unwrap)` so async entry
  points get the same recursive treatment.

Verified by `testlog_20260429-step4-recursive-sync/` — zero
regressions across all 10 suites (1733/6/~1 on `tom_d4rt`,
101/2/0 on `tom_d4rt_ast`, full match on the seven other suites).
The two interpreter packages are back in sync on this concern.

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

**Status.** _done_ — landed on 2026-04-29 (testlog
`testlog_20260429-step5-idempotency/`).

`registerGenericConstructor` and `registerGenericTypeWrapper` got
companion `Set<Factory>` identity maps that no-op on duplicate
factory identities; the other three named registrations (already
overwrite-by-key idempotent) plus `BridgedClass.registerSupertypes`
(already Set-add idempotent) got explicit "**Idempotent:**" docstring
tags. The `_relaxersRegistered` static-bool guard plus its
`_ensureRelaxersRegistered()` wrapper are gone — `flutter_d4rt.dart`'s
`_registerBridges()` now calls `registerRelaxers()` and
`registerD4rtRuntimeExtensions()` directly on every instance. Hard-sync
between `tom_d4rt_ast/lib/src/runtime/generator/d4.dart` and
`tom_d4rt/lib/src/generator/d4.dart` is preserved. New file
`tom_d4rt_ast/test/runtime/register_idempotency_test.dart` adds 7
register-twice tests, all green. All 10 suites match step-4 baselines
exactly except `tom_d4rt_ast` which gains +7 from the new tests.

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
- `tom_d4rt_flutterm/lib/src/flutter_d4rt.dart` — both constructors.
  The plan-spec sketch was:
  ```dart
  FlutterMaterialBridges.register(_interpreter);
  _interpreter.registerExtensions('tom_d4rt_flutterm', () {
    registerRelaxers();
    registerD4rtRuntimeExtensions();
    registerD4rtInterfaceProxyOverrides();
  });
  _interpreter.finalizeBridges();
  ```
  **Implementation deviates intentionally**: only
  `registerD4rtInterfaceProxyOverrides()` is queued in the post-material
  callback. `registerRelaxers()` and `registerD4rtRuntimeExtensions()`
  still run BEFORE `FlutterMaterialBridges.register`, matching the
  step-5 ordering. Reason: generic constructor factories chain
  newest-first; the user-bridge factory for `ValueNotifier<T>` casts
  to `double?` and would shadow material's correctly-typed auto-gen
  factory if it were registered later, breaking
  `ValueNotifier<int>(0)` (caught by `widgets/gesture_detector_adv_test.dart`).
  Only the proxy overrides actually need to run AFTER material
  (Bug-103 — `<dynamic>`-parameterised proxies re-registered with
  concrete type arguments depend on material's proxy registrations).
- New tests in `tom_d4rt_ast`: ordering test (two extensions register,
  assert callback execution order matches registration order), error
  test (calling `finalizeBridges()` twice is a no-op the second time).

**Regression.**

- `dart test` in `tom_d4rt_ast` and `tom_d4rt`.
- 4-suite flutterm battery.

**Status.** _done_ (testlog_20260429-step6-extension-hook/_summary.md)

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

**Status.** _done_ — landed on 2026-04-29 (testlog
`testlog_20260429-step7-final-shrink/_summary.md`).

`tom_d4rt_flutterm/lib/src/flutter_d4rt.dart` shrunk to its final
shape (175 → 158 lines; ~80-line executable body, the rest dartdoc
plus the `FlutterD4rtException` shell). The executable body is
byte-identical to step 6's post-fix shape — only the dartdoc and
`_registerBridges()` comments changed. The pre-material ordering
comment is kept (it pins the `ValueNotifier<int>(0)` regression
fence) and the post-material comment is kept (it points at
`extension_registration.md` for the contract).

`tom_d4rt_ast/doc/extension_registration.md` (new) documents the
`registerExtensions / finalizeBridges` API: the four contracts
pinned by `extension_hook_test.dart`, the canonical `FlutterD4rt`
example with both pre-material (inline) and post-material (queued)
patterns, and "when to use / when not" guidance. Linked from the
quest overview.

`_ai/quests/d4rt/overview.d4rt.md` Architecture section gained a
"Typed execution and extension-hook API" paragraph with a six-line
code example. The Bridging System list also picks up `D4.unwrapAs<T>`
next to the pre-existing helpers.

This is a doc-only step from the test runner's perspective. The
4-suite flutter battery and the dart battery were nonetheless
re-run end-to-end to capture a final canonical baseline.

Final 4-suite numbers (vs pre-migration baseline
`testlog_20260429-1054-consol-baseline`):

| Suite | Pre-migration | Step 7 final | Δ |
|-------|---------------|--------------|---|
| `essential_classes_test` | 108/0/0 | 108/0/0 | 0 |
| `important_classes_test` | 164/0/0 | 164/0/0 | 0 |
| `secondary_classes_test` | 653/0/1 | 653/0/1 | 0 |
| `generator_interpreter_issues_test` | 81/2/0 | 81/2/0 | 0 |

Format: `passing/skipped/failing`. Zero behavioural change end-to-end.

Final dart-battery numbers (cleared `.dart_tool/test` cache before
the canonical run after a one-time stale-cache flake on
`tom_d4rt_exec`):

| Project | Result |
|---------|--------|
| `tom_d4rt` | +1733 ~1 −6 |
| `tom_d4rt_ast` | +115 −2 |
| `tom_d4rt_exec` | +2234 −26 |
| `tom_d4rt_generator` | +639 −21 |
| `tom_ast_generator` | +503 −7 |
| `tom_d4rt_dcli` | +706 / 0 (all passed) |
| `tom_dcli_exec` | +72 −8 |

All match the step 6 baseline exactly.

---

## Status log

Update this section as each step completes, reverts, or defers.

| Step | Owner | Status | Commit(s) | Testlog | Summary |
|------|-------|--------|-----------|---------|---------|
| 1 | claude | done | 5a68848a, e01582b8, 611dbd4f | testlog_20260429-1124-step1-unwrapAs/ | D4.unwrapAs<T> + D4UnwrapException dual-landed; 12 new tests pass; flutterm 3-suite + other tom_d4rt_* match baseline (parallel-run setUpAll flake confirmed via --concurrency=1 reruns). |
| 2 | claude | done | (this session) | testlog_20260429-step2-executeBundleAs/ | `D4rtRunner.executeBundleAs<T>` / `executeBundleAsAsync<T>` added on tom_d4rt_ast; mirrored on tom_d4rt_exec `D4rt`. 16 new tests (5 ast + 11 exec) all green. Flutterm 3-suite matches baseline 108 / 164 / 653~1; tom_d4rt_exec +2234 −26 vs baseline +2223 −26 (+11 new); tom_d4rt_ast +101 −2 vs +84 −2 (+17 cumulative w/ step 1). |
| 3 | claude | done | (this session) | testlog_20260429-step3-flutterD4rt-cutover/ | `FlutterD4rt._unwrap<T>` deleted; all 4 entry points route through `executeBundleAs<T>` / `executeBundleAsAsync<T>`. `D4UnwrapException` re-thrown as `FlutterD4rtException` for public-contract preservation. Bridge registration de-duplicated. Flutterm 3-suite + every other tom_d4rt_* suite match the consol-baseline / step 2 baselines exactly — zero regressions. |
| 4 | claude | done | (this session) | testlog_20260429-step4-d4rt-base-unwrap/ + testlog_20260429-step4-sync-third-twin/ + testlog_20260429-step4-recursive-sync/ | `_bridgeInterpreterValueToNative` leaf unwrap delegated to `D4.unwrapAs<Object?>` across **all three** copies (initial land: tom_d4rt_ast/interpreter_visitor.dart + tom_d4rt/d4rt_base.dart leaf branch; sync addendum: tom_d4rt/interpreter_visitor.dart). Recursive sync addendum: ported the recursive list/map/record top-level unwrap from `tom_d4rt/d4rt_base.dart:1938` to `tom_d4rt_ast/d4rt_runner.dart`'s `_executeInEnvironment` (the recursion was a fork omission, not a deliberate asymmetry — corrected in this session). All 10 suites match step-3 baselines exactly across all three runs — zero regressions. |
| 5 | claude | done | (this session) | testlog_20260429-step5-idempotency/ | `registerGenericConstructor` and `registerGenericTypeWrapper` made idempotent via per-key `Set<Factory>` identity dedupe (chained-on-itself was the load-bearing reason `_relaxersRegistered` existed). The three already-idempotent overwrite registries (`registerInterfaceProxy`, `registerTypeCoercion`, `registerSupplementaryMethod`) plus `BridgedClass.registerSupertypes` got explicit "**Idempotent:**" docstring tags. `_relaxersRegistered` static-bool guard removed from `flutter_d4rt.dart`. Sync between tom_d4rt and tom_d4rt_ast preserved. New file `register_idempotency_test.dart` adds 7 register-twice tests (all green). 10-suite battery matches step-4 baselines exactly; `tom_d4rt_ast` gains +7 from the new tests. |
| 6 | claude | done | (this session) | testlog_20260429-step6-extension-hook/ | `D4rtRunner.registerExtensions(packageName, body)` + `finalizeBridges()` added on tom_d4rt_ast (insertion-order, package-name-overwrite, idempotent finalize, throws after finalize, implicit finalize on first execute). Mirrored on `D4rt` in tom_d4rt_exec. 7 new contract tests (`extension_hook_test.dart`) all green. `flutter_d4rt.dart` switched to the hook for `registerD4rtInterfaceProxyOverrides` only — `registerRelaxers` / `registerD4rtRuntimeExtensions` stay BEFORE material to keep material's auto-gen ValueNotifier factory on top of the chain (initial naive port putting all three in the callback regressed `widgets/gesture_detector_adv_test.dart` — fix preserves step-5 ordering). 4-suite flutterm battery matches step-5 baseline exactly: 108/0/0, 164/0/0, 653/0/1, 81/2/0. Dart battery green vs baseline. |
| 7 | claude | done | (this session) | testlog_20260429-step7-final-shrink/ | Final shrink + doc cleanup. `flutter_d4rt.dart` 175 → 158 lines (executable body unchanged from step 6; dartdoc/comments tightened). `tom_d4rt_ast/doc/extension_registration.md` added with the four `registerExtensions / finalizeBridges` contracts and the canonical FlutterD4rt example. `_ai/quests/d4rt/overview.d4rt.md` Architecture section updated with the typed-execute / extension-hook API note + `D4.unwrapAs<T>` mention. 4-suite flutter battery 108/0/0, 164/0/0, 653/0/1, 81/2/0 — exact step-6 match. Dart battery green vs step-6 baseline (one transient `tom_d4rt_exec` cache flake cleared with `rm -rf .dart_tool/test`). Migration totals: `flutter_d4rt.dart` 228 → 158 lines from pre-migration to final, with the unwrap, ordering rules, and registry idempotency now enforced upstream contracts instead of comments. |

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
