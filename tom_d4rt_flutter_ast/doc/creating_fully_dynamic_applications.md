# Creating Fully Dynamic Applications

**Status:** Architectural analysis + design proposal
**Date:** 2026-05-10
**Quest:** d4rt
**Scope:** `tom_d4rt_flutter_ast` (interpreter + Flutter bridge), `tom_d4rt_flutter_test` (HTTP test driver app)

---

## TL;DR

The current architecture **already supports** continuous animation, listener
callbacks, and `setState`-driven rebuilds, **provided the script puts the
animated state inside a script-defined `StatefulWidget` / `State` subclass**
(with `TickerProviderStateMixin` if a vsync is needed). In that case the
proxy chain `_InterpretedStatefulWidget` → `_InterpretedMultiTickerProviderState`
keeps a real, framework-managed native `State` in the tree, and every frame
re-enters the interpreter through `State.build()`.

What does *not* work today:

1. **Top-level animation ownership.** A script that creates an
   `AnimationController` inside the `static dynamic build(BuildContext)`
   entry point loses it as soon as `build` returns — there is no script-side
   `State` to hold it.
2. **Test-driver visibility past the first post-frame.** The HTTP `/build`
   endpoint completes the response on the *first* post-frame callback and
   then sets `_capturingFrameworkErrors = false`. Errors raised by an
   animation tick three frames later are silently dropped from the test log.
3. **No simulated time / no programmatic frame pump.** The driver runs
   real-time. There is no equivalent of
   `WidgetTester.pump(Duration(milliseconds: 300))` to advance an animation
   to its end without sleeping.
4. **No re-entry into the script's top-level functions.** The bundle's
   entry point runs once. Anything the script wants to keep alive across
   frames must live inside a Flutter widget the script returns.

The proposal in §6 below introduces an opt-in
`D4rtFlutterApplication` value the script can return as an alternative to a
plain `Widget`, which makes the long-lived application model first-class
rather than emergent.

---

## 1. What "fully dynamic" means here

A *fully dynamic* application, in the sense the test corpus needs:

- **Continuous timeline.** Animations, controllers, streams, and listeners
  registered during the first frame keep running; they trigger rebuilds; the
  rebuilt tree shows the new values.
- **Lifecycle ownership.** `initState` runs once, `dispose` runs at teardown,
  `didChangeDependencies` fires when inherited widgets change.
- **Framework-error fidelity past frame 1.** A `RenderFlex overflow` raised on
  frame 7 is just as observable as one on frame 1.
- **Programmatic time control.** A test can request "advance 300 ms of
  animations and report the resulting state" without calling
  `Future.delayed`.

The current architecture meets the first two requirements, partially meets
the third, and does not meet the fourth.

---

## 2. How the current architecture handles a live tree

The flow when a script is sent via `POST /build`:

```
HTTP /build                      ← body: { "bundle": <SAstNode JSON>, "name": "build" }
  └── _handleBuild
       └── set _pendingBundle, setState
            └── D4rtTestPage.build runs
                 └── _buildD4rtWidget(context)
                      └── _d4rt.build<Widget>(bundle, context)
                           └── interpreter executes script's `static build(BuildContext)`
                                └── returns Widget   ← stored in _d4rtWidget
                 └── widget tree:
                      KeyedSubtree(key: ValueKey(_widgetGeneration),
                                   child: _d4rtWidget!)
            └── addPostFrameCallback → complete _BuildResult → respond 200
```

**Key invariant:** `_d4rtWidget` is a *real Flutter widget*. Whatever the
script returns is mounted by the framework as if it had been hand-written
in Dart. Flutter owns its element tree, its build scheduling, its layout,
its paint.

### 2.1 Script returns a script-defined `StatefulWidget`

The hot path. The script body looks like:

```dart
class _Spinner extends StatefulWidget {
  const _Spinner();
  @override
  State<_Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<_Spinner> with TickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() { controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) =>
      AnimatedBuilder(
        animation: controller,
        builder: (_, __) => Transform.rotate(
          angle: controller.value * 6.28,
          child: const Icon(Icons.refresh),
        ),
      );
}

class build {
  static dynamic build(BuildContext context) => const _Spinner();
}
```

What happens in the runtime:

1. The interpreter creates a `BridgedInstance`/`InterpretedInstance` for
   `_Spinner`. The `StatefulWidget` proxy registration in
   `d4rt_runtime_registrations.dart:287` wraps it in a native
   `_InterpretedStatefulWidget` (line 1097).
2. Flutter mounts `_InterpretedStatefulWidget`. It calls `createState()`,
   which (line 1104) executes the interpreted `createState` body to produce
   the script's `_SpinnerState` `InterpretedInstance`, then chooses the
   right native proxy: `_InterpretedMultiTickerProviderState` (line 1135)
   because the script's State mixes in `TickerProviderStateMixin`.
3. Flutter runs lifecycle on the proxy. `initState` (line 1452) calls
   `super.initState()` (real framework init) and then dispatches
   `_callVoidMethod('initState')` → re-enters the interpreter to run the
   script's body. The script calls `AnimationController(vsync: this)` —
   `this` is the script's State `InterpretedInstance`, but
   `D4.extractBridgedArg` resolves it back to the proxy, which is a real
   `TickerProvider`. ✓
4. `controller.repeat()` schedules ticks via the native `Ticker`. Every
   tick fires `controller.notifyListeners()`. `AnimatedBuilder` is a real
   Flutter widget — it listens, calls `markNeedsBuild` on its element, and
   the framework rebuilds it on the next frame.
5. The rebuild triggers `_InterpretedMultiTickerProviderState.build` (line
   1476), which re-enters the interpreter to execute the script's `build`.
   The new `Transform.rotate(angle: controller.value * 6.28, ...)` reflects
   the current controller value. ✓
6. The cycle repeats indefinitely. Native Flutter drives, the interpreter
   reacts. `dispose` flows through the proxy back into the script.

**Conclusion:** a script that places its controllers inside a
script-defined `State` subclass already runs as a fully dynamic Flutter
application.

### 2.2 `setState` from inside the script

`StateUserBridge` (`state_user_bridge.dart`) overrides the auto-generated
`State.setState` adapter. When the script calls `setState(() { ... })`:

- If the scheduler phase is mid-frame (transientCallbacks, midFrameMicrotasks,
  persistentCallbacks), the override defers via `addPostFrameCallback` — see
  C20d in `interpreter_unfixable.md`. Otherwise it calls native
  `state.setState(() => D4.callInterpreterCallback(visitor, fn, []))`
  synchronously.
- The visitor is captured at registration time; it is the same interpreter
  that built the script. Re-entry has full access to the script's lexical
  scope. ✓

### 2.3 `class build { static dynamic build(BuildContext) }` is *only* the entry point

The single most important point about the architecture: the script-level
`build` function runs **once per `/build` request**. Anything the script
wants to outlive that single invocation must be returned as part of the
widget tree. The interpreter does **not** re-enter the entry point on
subsequent rebuilds — Flutter does not even know the entry point exists.

This is the source of the user's intuition that "the test app should call
the script's build method again". It actually does call *Flutter's* build
again, on the script's State subclass, every frame. It does not call the
script's *top-level* `build` again, and that's correct: top-level `build`
is just a factory that produces the root widget.

---

## 3. What today's test driver gives us, and where it stops

The driver in `tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/lib/main.dart`
is fundamentally a one-shot RPC server:

| Endpoint | Behaviour | Limitation |
|----------|-----------|-----------|
| `POST /build` | Builds the bundle once, responds after the **first** post-frame callback | Loses framework errors raised on frame 2+ |
| `POST /interact` | Sends a tap or text input event to the existing tree | Time still real-time, no pump |
| `POST /clear` | Disposes the tree, increments `_widgetGeneration` | Correct |
| `GET /health`, `/logs` | Status checks | — |

The animation continues to run after the response is sent — it is real
Flutter — but the test result has already been committed. Any later error
goes to the `_logs` buffer at best, and `_capturingFrameworkErrors = false`
in `_buildD4rtWidget` (line 617) drops most of it.

Specific gaps observed in practice (from the C6 / suspicious-rewrite
sessions):

- **Tests that depend on second-frame state.** A script using
  `WidgetsBinding.instance.addPostFrameCallback` to call `setState` on the
  next frame produces a different tree than the response captures.
  Workaround so far: rewrite the script to compute the second-frame value
  synchronously (the StatelessWidget rewrites in
  `automatic_keep_alive_client_mixin_test.dart` and similar).
- **No way to ask "what does this look like after 300 ms?"** Tests that
  conceptually want `tester.pump(Duration(milliseconds: 300))` have to
  either accept the first-frame value or sleep, neither of which is great.
- **Top-level controllers leak.** A script that does
  `final _ctrl = AnimationController(...); class build { ... }` outside any
  `State` has no `dispose` — the `Ticker` keeps running until the next
  `/clear`. This shows up as "muted ticker is still active" warnings in
  later tests in the same session.

---

## 4. What's actually broken vs. what's missing

It is worth separating two concerns:

| Symptom | Cause | Class |
|---------|-------|-------|
| Animations don't continue | Script puts controller in top-level scope, not in a State | **Script-side bug** (no architectural change needed) |
| `setState` mid-layout throws | Real Flutter throws too; bridge defers to post-frame | **Documented behavioural deviation** (C20d) |
| Frame-2 errors not in test response | Driver completes after frame 1 only | **Driver gap** — fixable without rebuilding architecture |
| No simulated time | Driver runs real-time | **Driver gap** — needs explicit "pump" endpoint |
| Lifecycle in top-level scope | Top-level scope is a one-shot factory | **Script-side mental model**, plus optional architecture extension §6 |

The architectural foundation for live, interpreted Flutter apps is sound.
What's missing is a small set of **driver-level extensions** and **one
optional library-level abstraction** (§6) that makes the long-lived case
explicit instead of emergent.

---

## 5. Driver-level extensions (low cost, high payoff)

These are independent of any change to the interpreter or the bridge
generator. They live entirely in
`tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/lib/main.dart`.

### 5.1 Extend the framework-error window

Today: `_capturingFrameworkErrors = false` is set inside the first
post-frame callback after `_buildD4rtWidget`. Errors raised by an animation
on frame 2 are dropped from the response.

Proposal: keep `_capturingFrameworkErrors = true` for a configurable
**settle window** (default ~100 ms or N frames), accumulate errors, and
include them in the response. The completer fires at the end of the window,
not the first post-frame.

Cost: ~30 lines of code in `_buildD4rtWidget`. No breaking change — the
existing behaviour becomes the `settleWindow: 0` case.

### 5.2 `POST /pump` endpoint

```http
POST /pump  { "duration_ms": 300, "max_frames": 20 }
```

Calls `WidgetsBinding.instance.scheduleFrameCallback` repeatedly, flushing
microtasks between, advancing the clock-or-frames as requested. The scheduled
animation values progress, post-frame callbacks fire, and we collect any
new framework errors. On completion, return the new
`widgetType`/`output`/`frameworkErrors`.

This is the analogue of `tester.pump(duration)` for the real-time driver.
Implemented entirely on the driver side; the interpreter doesn't need to
know.

Cost: small. The hard part is choosing a reasonable real-time vs.
simulated-time policy (the live `SchedulerBinding` is real-time; we
probably just sleep with `Future.delayed` and ask Flutter to flush, which
is fine for test scripts).

### 5.3 `POST /snapshot` endpoint

Returns the current widget tree summary (a structured JSON of the captured
debug-text from `WidgetsBinding.instance.rootElement.toStringDeep()` or
similar) **without** rebuilding. Useful for tests that want to assert "after
animation completes, the tree contains X" — the test calls `/build`, then
`/pump`, then `/snapshot`.

### 5.4 `POST /clear` already increments `_widgetGeneration` — keep this

Top-level controllers leaked across builds are mitigated by the existing
generation-keyed remount in `KeyedSubtree`. This is correct and should
remain.

---

## 6. `D4rtFlutterApplication` — making long-lived apps first-class

The above driver extensions cover most cases. There is one case they do not
cover cleanly: scripts that genuinely want to *be* an application, with
controllers, listeners, and lifecycle living **outside** any single
`StatefulWidget`. Today the only way to express that is to wrap everything
in a single root `StatefulWidget`, which can be awkward.

Proposal: introduce an opt-in return type from the bundle's entry point.

### 6.1 Library-side definition

In `tom_d4rt_flutter_ast/lib/src/flutter_d4rt.dart` (or a new
`d4rt_flutter_application.dart` part):

```dart
/// A long-lived application root that the script returns *instead of* a
/// plain Widget. The driver mounts [root], runs [onMount] once, runs
/// [onUnmount] on /clear, and exposes [errorListener] for late-arriving
/// framework errors.
///
/// The contract is intentionally minimal: anything the script wants to
/// outlive a single frame goes into a holder it constructs inside [onMount]
/// and tears down in [onUnmount].
class D4rtFlutterApplication {
  /// The root widget. Must be a constructable Flutter widget tree —
  /// usually a script-defined StatefulWidget that owns the live state.
  final Widget root;

  /// Called once, after [root] is first mounted. The script typically uses
  /// this to attach listeners to native objects it created at top level.
  final FutureOr<void> Function()? onMount;

  /// Called when the driver receives /clear (or replaces the tree). The
  /// script tears down controllers, listeners, streams here.
  final FutureOr<void> Function()? onUnmount;

  /// Optional late-error sink. The driver wires Flutter's
  /// `FlutterError.onError` and any zone errors into this callback so the
  /// script can record or transform them.
  final void Function(FlutterErrorDetails details)? errorListener;

  const D4rtFlutterApplication({
    required this.root,
    this.onMount,
    this.onUnmount,
    this.errorListener,
  });
}
```

### 6.2 Driver detection

`_buildD4rtWidget` learns to recognise the new return type:

```dart
final result = _d4rt.execute<Object?>(bundle, name: 'build', positionalArgs: [context]);
if (result is D4rtFlutterApplication) {
  _currentApp = result;
  _d4rtWidget = result.root;
  await result.onMount?.call();
  // settle window + framework-error capture as in §5.1
} else {
  _d4rtWidget = result as Widget;
  // existing path
}
```

`_handleClear` calls `_currentApp?.onUnmount?.call()` before disposing.

### 6.3 What this buys us

- **Explicit ownership.** The script clearly says "I am an application" or
  "I am a one-shot widget". The driver can route framework errors,
  lifecycle, and teardown accordingly.
- **No magic on the interpreter side.** `D4rtFlutterApplication` is a
  plain Dart class registered through the normal bridge machinery (it
  lives in `tom_d4rt_flutter_ast`, the same package as `FlutterD4rt`, so
  it gets auto-bridged).
- **Backwards compatible.** Scripts that return `Widget` continue to
  work unchanged.
- **Testable.** Tests can assert behaviour both at mount time and after a
  `/pump`, with clean teardown semantics.

### 6.4 What it does **not** need to do

- It does **not** need to re-run the script's top-level entry point on
  rebuild. Flutter rebuilds the tree; the interpreter re-enters via the
  proxy `State.build`.
- It does **not** need to bundle native objects "into a structure that can
  run as a real application" — they already run as a real application,
  because they are real Flutter widgets in a real Flutter element tree.
  The `D4rtFlutterApplication` holder just gives the script a place to
  hang non-widget lifecycle (e.g. attaching a `Stream.listen` at top
  level).

---

## 7. Recommended sequence

In rough effort order, smallest first:

1. **§5.1 — Settle window.** Catches frame-2 errors. ~30 lines. No API
   change. **Highest payoff.**
2. **§5.2 — `/pump` endpoint.** Unlocks animation-end assertions in tests.
   Pure driver work. ~80 lines.
3. **§5.3 — `/snapshot` endpoint.** Convenience for animation tests. ~40
   lines.
4. **§6 — `D4rtFlutterApplication`.** Optional, only if §5 leaves
   real-world scripts that still can't express what they need. Adds an
   opt-in return type; non-breaking.

Steps 1–3 are quest-internal driver changes; they do **not** require
mirroring across `tom_d4rt` ↔ `tom_d4rt_ast`. Step 4 is a library addition
in `tom_d4rt_flutter_ast` and will need a corresponding bridge entry in
`flutter_d4rt.dart` plus an end-to-end test in
`tom_d4rt_flutter_test/test/...`.

---

## 8. What to take away

- **Animations and controllers already work** when scripts use the
  natural Flutter pattern (StatefulWidget + State + TickerProviderStateMixin).
  The proxy layer in `d4rt_runtime_registrations.dart` plumbs every frame
  back through the interpreter.
- **The test driver, not the interpreter, is the bottleneck for live
  observability.** Frame-2+ errors and programmatic time advancement are
  driver gaps, addressable in §5 without touching the interpreter.
- **A `D4rtFlutterApplication` return type is a worthwhile but optional
  addition** for scripts that want non-widget lifecycle. The case for
  introducing it is real but not urgent; defer until §5 has shipped and
  we can see which test cases still don't fit the simple `return Widget`
  shape.

---

## 9. References

- `tom_d4rt_flutter_ast/lib/src/d4rt_runtime_registrations.dart`
  (`_InterpretedStatefulWidget` line 1097, `_InterpretedState` line 1213,
  `_InterpretedSingleTickerProviderState` line 1330,
  `_InterpretedMultiTickerProviderState` line 1439).
- `tom_d4rt_flutter_ast/lib/src/d4rt_user_bridges/state_user_bridge.dart`
  (scheduler-phase-aware `setState` deferral).
- `tom_d4rt_flutter_ast/lib/src/flutter_d4rt.dart` (the four entry points
  `build` / `buildAsync` / `execute` / `executeAsync` — all one-shot today).
- `tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/lib/main.dart`
  (`_buildD4rtWidget` line 593, `_handleBuild` line 477,
  `_handleClear` and the `KeyedSubtree` mount at line 719).
- `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` (C20d documents the
  layout-time `setState` deferral).
