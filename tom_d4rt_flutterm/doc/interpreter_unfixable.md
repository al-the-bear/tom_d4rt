# Interpreter Unfixable Issues

This document catalogs interpreter / generator issues that **cannot
be worked around in the test scripts themselves**. Two categories
live here:

1. **Truly unfixable** — the failure is rooted in the Flutter
   framework, the engine, or the test-app transport, and *no*
   change to either the interpreter or the script can resolve it.
2. **Interpreter / generator architectural limitations** —
   situations where the interpreter's design (e.g., abstract-class
   inheritance via proxies, runtime-only enum metadata) imposes a
   ceiling that a particular code shape cannot cross. We document
   the limitation and the architectural workaround the interpreter
   already applies; specific scripts that hit it remain failing
   until the architectural work lands.

Cases that *can* be worked around at the script level are tracked
separately in `script_rewrites.md`. When you read this file and
think "I could fix this by changing the script", that's a sign
the entry belongs in `script_rewrites.md` — please move it.

---

## Index

| Section | Category | Source |
|---|---|---|
| [Abstract Class Inheritance — architecture](#abstract-class-inheritance) | Interpreter limitation (worked around via adapter proxies; auto-generation explored as E12) | Architectural |
| [`gir` W1–W5 transport cascade — structural](#cluster-r--gir-w1-w5-transport-cascade-test-app-structural) | Truly unfixable (test-app transport layer) | W1–W5 wedgers (all 5 pass in isolation, see `test/blocking_tests_test.dart`) |
| [E3 — `findAncestorStateOfType<T>()` ignores type argument](#e3--findancestorstateoftypet-ignores-type-argument) | Interpreter limitation (bridge generator drops `T`; script-side rewrite supplied) | `widgets/scroll_position_with_single_context_test.dart` |

Entries that previously lived here but have **suggested
interpreter / generator fixes** have been moved to
`testlog_20260428-1333-issue-analysis/error_analysis.md` for the
next round of work — see the migration log at the bottom of this
file.

---

## Abstract Class Inheritance

### Background

Interpreted classes cannot directly inherit from abstract native
classes because the interpreter architecture maintains
`bridgedSuperObject` — a native instance of the bridged
superclass. For abstract classes like `State`, `StatelessWidget`,
or `StatefulWidget`, we cannot instantiate them directly.

**Why it's a limitation:**

- When a D4rt script declares `class _MyState extends State<MyWidget>`,
  the interpreter creates an `InterpretedClass` with `bridgedSuperclass = StateBridge`.
- During constructor execution, the implicit `super()` call would
  normally create a native instance and store it in
  `bridgedSuperObject`.
- For abstract classes, the constructor lookup fails (empty
  `constructors: {}`).
- `bridgedSuperObject` remains null, breaking access to inherited
  properties like `widget`, `setState`, `context`.

### Solution Architecture (already in place)

For abstract framework classes (State, StatelessWidget,
StatefulWidget), the interpreter uses **adapter proxies** instead
of direct bridged super objects:

1. **Interface Proxy Factories** — registered via
   `D4.registerInterfaceProxy()` for each abstract class.
2. **Native Adapter Classes** — e.g., `_InterpretedState`,
   `_InterpretedStatelessWidget` that:
   - Extend the real abstract class.
   - Hold a reference to the `InterpretedInstance`.
   - Delegate abstract methods (build, createState) to the
     interpreted class.
   - Provide access to superclass properties (widget, setState)
     via their native implementation.
3. **`nativeProxy` Field** — the `InterpretedInstance` stores its
   adapter in `nativeProxy`.
4. **Property Resolution** — `InterpretedInstance.get()` uses
   `nativeProxy` as fallback when `bridgedSuperObject` is null.
5. **Property Interceptors** — registered via
   `D4.registerPropertyInterceptor()` to intercept property access
   and return interpreted instances instead of native wrappers
   (e.g., `widget` property on `State`).

**Property Interceptor Pattern:**

For properties that need to return the original
`InterpretedInstance` instead of a native wrapper object, the
adapter implements an interface with a getter:

```dart
abstract class InterpretedStateProxy {
  InterpretedInstance get interpretedWidget;
}
```

Then register an interceptor:

```dart
D4.registerPropertyInterceptor('State', (instance, propertyName, nativeProxy, ...) {
  if (propertyName == 'widget' && nativeProxy is InterpretedStateProxy) {
    return InterceptedValue(nativeProxy.interpretedWidget);
  }
  return null; // Fall through to normal handling
});
```

See the [Advanced Bridging User Guide](../../tom_d4rt/doc/advanced_bridging_user_guide.md#rc-9-property-interceptors)
for the complete RC-9 documentation.

**Classes requiring adapters:**

- `State<T>` — Framework state management base class
- `StatelessWidget` — Immutable widget base class
- `StatefulWidget` — Stateful widget base class
- Similar patterns for `ChangeNotifier`, `Listenable`, etc.

The adapter pattern is implemented in
`d4rt_runtime_registrations.dart` (proxies and interceptors) and
integrated with the `InterpretedInstance.get()` method in
`runtime_types.dart`.

**Why this stays in `interpreter_unfixable.md`:** the
limitation is architectural — every new abstract framework
class that scripts subclass requires a new adapter pair
(`_InterpretedX` + interface proxy registration). There is no
script-side workaround; the script "just works" once the adapter
is registered, and fails completely until then. New abstract-class
gaps (e.g., `RouterDelegate`, see `back_button_listener` below)
are tracked individually under the symptom-by-symptom entries
later in this file.

---

## Cluster R — `gir` W1-W5 transport cascade (test-app structural)

**Why truly unfixable at the interpreter or the script level.**
The cascade trigger (e.g. `retest/widgets/lock_state_test.dart`
at gir TID=43 in `testlog_20260428-1333-issue-analysis`) emits an
`HttpException: Connection closed before full header was received`
on `POST /build`, after which the test app process dies and every
subsequent script fails at `GET /clear` with `SocketException:
Connection refused (errno = 111)` against the (now closed)
ephemeral port. The cascade is in the **test runner ↔ test app
transport layer**, not the interpreter — the interpreter never
got a chance to evaluate the next script's source.

**Verification — all 5 wedgers pass in isolation (2026-04-28).**
Running W1–W5 in the dedicated isolation harness
`test/blocking_tests_test.dart` (5 tests, in this order: W1, W2,
W3, W4, W5) produced **all five passing** in 38 seconds wall
time, with `frameworkErrors=0` on every script:

| Wedger | Script | totalMs | frameworkErrors |
|---|---|---|---|
| W1 | `retest/widgets/context_action_test.dart` | 1725 | 0 |
| W2 | `retest/widgets/default_text_editing_shortcuts_test.dart` | 11100 (10 s preamble) | 0 |
| W3 | `retest/widgets/live_text_input_status_test.dart` | 11172 (10 s preamble) | 0 |
| W4 | `retest/widgets/lock_state_test.dart` | 965 | 0 |
| W5 | `widgets/animated_switcher_test.dart` | 1095 | 0 |

This confirms that **none of W1–W5 are intrinsically broken
scripts**. The cascade is purely a function of the test-app
process having accumulated state from a long preceding suite —
W4's `HttpException` only fires on `POST /build` when the app has
been alive for ~13 minutes of prior tests, not in a fresh
process. The fix-cluster work F1–F5 in
`testlog_20260428-1333-issue-analysis/error_analysis.md` is
therefore *unnecessary as per-script investigations*; the only
durable lever is the META watchdog.

**Workaround (already applied):**

1. **Isolation harness** — `test/blocking_tests_test.dart` runs
   the 5 wedgers in their own suite. Use this to verify scripts
   stay viable as the interpreter changes.
2. **Skip** the 5 wedgers in their respective long suites
   (`generator_interpreter_retest_test.dart` for W1–W4,
   `generator_interpreter_issues_test.dart` for W5).
3. **Test-app watchdog** (META structural fix tracked in
   `interpreter_issues.md` "[META] Structural cascade in retest
   suite") — extend `SendTestRunner` so a single
   `Connection closed` / `Connection refused` triggers a fast
   app-process restart and a port re-discovery rather than letting
   subsequent `/clear` calls fail against a dead socket. This
   converts a 20-script cascade into a single failure + 19
   retries. Given that W1–W5 all pass in isolation, the watchdog
   alone — without per-script F1–F5 work — should restore the
   skipped tests to the long suites once it lands.

---

## E3 — `findAncestorStateOfType<T>()` ignores type argument

**Trigger.** A `StatelessWidget` (or any descendant) calls
`context.findAncestorStateOfType<SpecificStateClass>()` to grab a
typed handle to an owning State subclass declared in the same
script, e.g.:

```dart
final _SpwscDemoHomeState? state =
    context.findAncestorStateOfType<_SpwscDemoHomeState>();
state?._controller.hasClients; // KaBOOM
```

**Underlying interpreter limitation.** The auto-generated bridge
adapters for `BuildContext.findAncestorStateOfType` (and
`findRootAncestorStateOfType`) drop the generic type argument:

```dart
'findAncestorStateOfType': (visitor, target, positional, named, typeArgs) {
  final t = D4.validateTarget<…Element>(target, '…Element');
  return t.findAncestorStateOfType(); // <-- T missing
},
```

The native Flutter API resolves the type at compile time
(`findAncestorStateOfType<T>` is monomorphised), so the generator
has no obvious surface to forward an interpreted `T` into. With
`T == dynamic`, Flutter walks ancestors and returns the *first*
State of any type. In a real script that is almost always the
wrong State — typically an `_AnimatedContainerState`,
`NavigatorState`, `OverlayState`, or some other framework State
mixing in `SingleTickerProviderStateMixin` /
`TickerProviderStateMixin`. The script then calls a member that
only exists on its own State subclass, the bridge adapter for
the framework State doesn't have the field, and the runtime
surfaces:

```
Runtime Error: Undefined property or method '_controller' on
bridged instance of 'SingleTickerProviderStateMixin'.
```

(Same shape for `TickerProviderStateMixin`, `NavigatorState`,
etc., depending on which State the walk happens to land on.)

A "proper" fix would require the bridge generator to emit a
type-aware adapter that:

1. Walks ancestors via `Element.visitAncestorElements`.
2. For each `StatefulElement`, checks whether its
   `state` is a `D4InterpretedProxy` whose `d4rtInstance`
   `InterpretedInstance` extends the requested
   `InterpretedClass` (or, for native targets, an `is T` check
   against the resolved native bridge).
3. Returns the **`InterpretedInstance`** directly so script-side
   field access works.

This change touches every Element subclass adapter in
`widgets_bridges.b.dart` (100+ call sites), needs a runtime D4
helper mirrored across `tom_d4rt` and `tom_d4rt_ast`, and full
bridge regeneration. It is tracked separately and not part of
the cluster-by-cluster bug-fix campaign.

**Workaround at the script level.** Pass the controller (or
state-derived value) down explicitly, e.g.:

```dart
// Owner — give the descendant what it needs.
actions: [
  _HeroPulseIcon(controller: _controller),
  const SizedBox(width: 12),
],

// Descendant — drop the typed ancestor lookup.
class _HeroPulseIcon extends StatelessWidget {
  const _HeroPulseIcon({required this.controller});
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    if (!controller.hasClients) return const _PulseDot(active: false);
    return ValueListenableBuilder<bool>(
      valueListenable: controller.position.isScrollingNotifier,
      builder: (_, scrolling, __) => _PulseDot(active: scrolling),
    );
  }
}
```

Functionally equivalent in real Flutter, and side-steps the
interpreter limitation entirely. Applied to
`widgets/scroll_position_with_single_context_test.dart` (E3,
2026-04-28).

---

---

## Change Log

- 2026-04-28 (latest): **Move Index 32
  `GappedRangeSliderTrackShape` to `script_rewrites.md`.** Per
  user assessment, the null-deref pattern is most consistent
  with a script-side contract violation against
  `RangeSliderTrackShape.paint` rather than a genuine framework
  null path that requires monkey-patching. The previous
  classification in this doc claimed the entry as "truly
  unfixable" without a debug-build bisect to confirm — that
  framing was speculative, and a script-side workaround is
  available. Tracked in `script_rewrites.md` until / unless a
  debug-build bisect proves otherwise.
- 2026-04-28 (later evening): **Move suggested-fix entries to
  `error_analysis.md`.** Three sections that previously lived
  here had concrete interpreter / generator fix proposals
  attached, and therefore belong in the active fix-tracking doc
  rather than the unfixable-issue catalogue:
  - "Residual `dart:ui/math.dart:14` `clampDouble` assertion" —
    moved to error_analysis.md as **E9** (numeric-arg
    passthrough audit).
  - "gir TID=31 `render_animated_size_state` 2.0 px overflow" —
    moved to error_analysis.md as **E10** (intrinsic-pass audit
    in `_InterpretedSlottedRenderBox`).
  - "gir TID=37 `back_button_listener` Router routerDelegate
    coercion" — moved to error_analysis.md as **E11**
    (`RouterDelegate` adapter proxy registration).
  An exploratory section on auto-generating abstract-class
  adapters across the bridge generator's scanned codebase was
  added as **E12** in `error_analysis.md`.
- 2026-04-28 (evening): Restructure into "truly unfixable" vs
  "interpreter architectural limitation"; move script-rewriteable
  cases (enum exhaustiveness, system_color_palette platform
  guard, C20d State.setState mid-frame, D3 RestorableProperty
  initState, E2 layout cascade, E5 widgets_binding_observer
  borderRadius) to `script_rewrites.md`. Deduplicate post-C22
  cases that were already in `script_rewrites.md`
  (image_sampler_slot, D6 layout cascade, D8g RawTooltipState
  multi-ticker, D8h SemanticsData null textDirection, C3 Row
  stretch + Expanded). Promote the post-C22 list into the
  permanent index above with explicit "truly unfixable" vs
  "interpreter limitation" tags.
- 2026-04-27: Add C20d behavioural-deviation entry for the
  `StateUserBridge.overrideMethodSetState` workaround that defers
  `setState` calls made during layout / paint / transient
  callbacks. *(Moved to `script_rewrites.md` 2026-04-28.)*
- 2026-04-27: Add four script-side / engine-platform cases from
  `testlog_20260427-1339-post-c22` (image_sampler_slot engine
  cascade, layout-cascade D6, multi-ticker D8g, semantics
  textDirection D8h). *(Moved to `script_rewrites.md`
  2026-04-28.)*
- 2025-04-13: Add property interceptor mechanism (RC-9) for
  generic externalized property handling.
- 2025-04-13: Document abstract class inheritance limitation and
  adapter proxy solution.
- 2025-01-21: Add 7 more enum exhaustiveness fixes
  (popup_menu_position, axis_direction, hit_test_behavior,
  render_android_view, vertex_mode, live_text_input_status,
  lock_state). *(Moved to `script_rewrites.md` 2026-04-28.)*
- 2025-01-21: Add index 32 (framework null errors), 34, 36, 38,
  40 (enum exhaustiveness). *(Index 32 retained here; 34, 36, 38,
  40 moved to `script_rewrites.md` 2026-04-28.)*
- 2025-01-21: Initial document with issues 13, 16, 30 documented.
  *(13, 30 moved to `script_rewrites.md` 2026-04-28; 16 also
  moved.)*
