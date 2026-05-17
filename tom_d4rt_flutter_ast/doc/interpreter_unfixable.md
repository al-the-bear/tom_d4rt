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
| [E6 — Native Dart Record named-field access](#e6--native-dart-record-named-field-access-interpreter-limitation) | Interpreter limitation (no reflection for named fields without `dart:mirrors`; positional access works, named access requires destructuring or class wrapper) | E6 partial closure (`widgets/platform_menu_widgets_test.dart` only used positional access; named-field consumers must use the workarounds) |
| [E7 — `Iterable.whereType<T>()` drops generic argument](#e7--iterablewheretypet-drops-generic-argument-interpreter-limitation) | Interpreter limitation (stdlib `whereType`/`cast` adapters discard `T`; same family as E3 generic-erasure). Script-side rewrite supplied in `script_rewrites.md`. | `widgets/restorable_double_n_test.dart` |
| [E8 — `ScrollController` state field passed through a `StatelessWidget` chain to a `Scrollable`](#e8--scrollcontroller-state-field-passed-through-statelesswidget-chain-to-a-scrollable-interpreter-limitation) | Interpreter limitation (scaling: each leaf `Scrollable` that receives the propagated controller produces exactly one null-check; locally-constructed controllers do not exhibit it). Layout-cascade fix already lands script-side (8→2); residual 2 errors deferred. | `widgets/scroll_deceleration_rate_test.dart` (E8 partial closure) |
| [Fa1-N1 — Layout-cascade FE residuals on 6 deep-demo scripts](#fa1-n1--layout-cascade-fe-residuals-on-6-deep-demo-scripts-script-side-annotation-deferred) | Script-side limitation (cosmetic only; zero test failures). Closing route documented per sub-pocket; deferred via `D4RT-SCRIPT-LIMITATION: layout cascade` annotations. Sentinel: `test/fa1_bisect_test.dart [fa1-2250-sentinel]`. **Small-overflow + EditableText + C3 sub-pockets all closed 2026-04-29** (see Fa1-N1 §Affected scripts and §Small-overflow pocket — empirical findings 2026-04-29). | ~~`snapshot_mode_test.dart` (small-overflow, 1 FE)~~ closed, ~~`restorable_double_test.dart` (small-overflow, 1 FE)~~ closed, ~~`select_all_text_intent_test.dart` / `transpose_characters_intent_test.dart` / `restoration_mixin_test.dart` (EditableText, 3+2+3 FE)~~ closed, ~~`widget_state_color_test.dart` / `text_magnifier_configuration_test.dart` (C3 sliver-row, 9+6 FE)~~ closed |
| [N2 — Bridged `RestorableProperty` proxy: late-`_value` + cross-script `for-in BridgedInstance<Object>`](#n2--bridged-restorableproperty-proxy-script-side-eager-init--defensive-iteration) | Same architectural limitation as D3/D4 (bridged `RestorationMixin` lifecycle dispatch under cross-script ordering); script-side workaround supplied: eager-init `_value` from constructor + `_favoritesSnapshot()` defensive iteration. | `widgets/restorable_property_test.dart` (closed 2026-04-29) |
| [P1 — `PreferredSizeWidget` cast fails when arg arrives as a cached native widget proxy](#p1--preferredsizewidget-cast-fails-when-arg-arrives-as-a-cached-native-widget-proxy) | Interpreter limitation (proxy walk runs on `InterpretedInstance` only; once the same instance has been wrapped in `_InterpretedStatelessWidget` and cached as `nativeProxy`, the bridge call site receives the native widget directly and the multi-interface walk over `bridgedInterfaces` is skipped). Script-side workaround supplied (`PreferredSize(preferredSize: …, child: AppBar(...))`). | `widgets/snapshot_mode_test.dart` (1 FE — Scaffold.appBar) |
| [P4 — `switch (BridgedEnum)` may fall through every case, returning null](#p4--switch-bridgedenum-may-fall-through-every-case-returning-null) | Interpreter limitation (bridged-enum case match is unreliable for some Flutter enums in `case BridgedEnum.value:` form — the equality probe in `visitSwitchStatement` returns `false` for both directions on certain bridged enum values, so a `String`-returning helper falls through and returns `null` implicitly). Script-side workaround: convert switches to `if/else` chains over `==` (the path used by `_isCupertinoFamily` is reliable), and seed local result variables with a default. | `widgets/tooltip_window_controller_delegate_test.dart`, `foundation/target_platform_test.dart`, `material/time_of_day_format_test.dart` |
| [G1 — `D4.getNamedArgWithDefault<T?>` collapses explicit `null` to default](#g1--d4getnamedargwithdefaultt-collapses-explicit-null-to-default-for-nullable-typed-named-args) | Generator/runtime helper limitation (the helper conflates "key absent" with "key present but `null`" by guarding on `!named.containsKey(p) || named[p] == null`, so an explicit `null` named-arg falls back to the constructor default). Script-side workaround: prefer a finite cap over an explicit `null` when the bridge default would violate a downstream invariant (`CupertinoTextField`'s `(maxLines == null) || (maxLines >= minLines)` assertion). | `cupertino/textfield_test.dart`, `cupertino/cupertino_text_selection_handle_controls_test.dart` |
| [R1 — Redirecting factory constructor syntax (`factory X() = Y`) not implemented](#r1--redirecting-factory-constructor-syntax-factory-x--y-not-implemented) | Interpreter limitation (parser/interpreter does not lower the redirecting-factory `=` form into a forwarding call to the redirected concrete constructor; the abstract class is treated as directly instantiable and throws `Cannot instantiate abstract class`). Script-side workaround: instantiate the redirected concrete subclass directly while keeping the variable type as the abstract base. | `widgets/regular_window_test.dart` (4 sites: `RegularWindowController(...)` → `_HostRegularWindowController(...)`) |
| [L1 — `AnimatedBuilder.animation` rejects script-defined subclass of bridged `Listenable`/`ChangeNotifier`](#l1--animatedbuilderanimation-rejects-script-defined-subclass-of-bridged-listenablechangenotifier) | Bridge-generator architectural limitation (proxy/relaxer pipeline does not synthesise native `ChangeNotifier`-backed proxies for script-defined subclasses of bridged `Listenable`; `D4.getRequiredArg<Listenable>` rejects the `InterpretedInstance` even though its synthetic class hierarchy reaches `ChangeNotifier`). Script-side workaround: pass `const AlwaysStoppedAnimation<double>(0.0)` as the `animation:` argument and access the controller via closure capture inside the `builder`. | `widgets/windowing_owner_mac_o_s_test.dart` (2 sites: `_MacChrome.build`, `_DockTile.build`) |
| [I1 — C-style `for (var i = 0; …; i++)` shares loop variable across closures](#i1--c-style-for-loop-shares-loop-variable-across-closures-interpreter-limitation) | Interpreter limitation (`_executeClassicFor` creates one `loopEnvironment` for the whole loop and reuses it every iteration; standard Dart instead allocates a fresh per-iteration variable so closures created inside the body each capture their own `i`). Script-side workaround: replace collection-`for` / body-less for-loops that build closures over `i` with `List<T>.generate(n, (i) => …)`, which gives each iteration a fresh function-parameter `i`. | `widgets/drag_target_details_test.dart` (Section 11 rank-slot row, 5 FE) |
| [T1 — `runtimeType.toString()` on user-defined interpreted classes](#t1--runtimetypetostring-on-user-defined-interpreted-classes) | Interpreter limitation (`InterpretedInstance.runtimeType` returns the `InterpretedClass`, which does not expose `toString` as a callable static — the chained call resolves to a static lookup and throws). Script-side workaround: emit the class-name string from an explicit `is`-check ladder. | `widgets/route_transition_record_test.dart` (1 FE — `_buildSurfaceRow` line 836) |
| [S1 — `const Stream<T>.empty()` rejected by `Stream` bridge](#s1--const-streamtempty-rejected-by-stream-bridge-interpreter-limitation) | Interpreter limitation (the stdlib `Stream` `BridgedClass` registers `empty`/`value`/`fromIterable`/etc. under `staticMethods:` and leaves `constructors: {}`. `MethodInvocation`-shaped calls — `Stream.empty()` — fall through to `staticMethods` and succeed; `InstanceCreationExpression`-shaped calls — `const Stream<int>.empty()` — go through `findConstructorAdapter` only and never see the static-method registration, so the lookup throws `Bridged class 'Stream' does not have a registered constructor named 'empty'`). Script-side workaround: drop `const`, drop the explicit type-arg, and call as a method invocation (`Stream<int>.empty()` or `Stream.fromIterable(const <int>[])`), or hold the stream in a non-const `final` so the parser keeps the call as `MethodInvocation`. | `widgets/streambuilder_test.dart` (Section 6 — `stream: const Stream<int>.empty()`) |
| [U1 — Demo-scale renderings that overload the test-app transport](#u1--demo-scale-renderings-that-overload-the-test-app-transport-interpreter-limitation) | Interpreter limitation, two sub-cases. (1) Top-level `const` of an interpreted subclass of a *native* abstract class (here `extends Notification`) exercises the adapter-proxy infrastructure before the visitor has wired its context, and crashes the test-app transport (`Lost connection to device`, no stderr). (2) `SelectableText.rich(TextSpan(children: spans))` with ~1000+ TextSpans (built per-character by an interpreted Dart colorizer from a ~1.8 KB code listing) exceeds the test-app per-frame transport budget and the device disconnects. Workaround: keep the displayed values as top-level `const` primitives (no native-abstract subclass), and render long code listings (>≈500 chars / >≈22 lines) through a sibling helper that wraps a single plain monospace `Text` instead of the per-char colorizer + `SelectableText.rich`. | `widgets/notificationlistener_test.dart` (C05 closed 2026-05-17) |
| [U2 — Non-wrappable arithmetic defaults on positional-only native constructors](#u2--non-wrappable-arithmetic-defaults-on-positional-only-native-constructors-generator-limitation) | Generator limitation. `BridgeGenerator._wrapDefaultValue` returns `null` for any default expression containing an operator (e.g. `double endAngle = math.pi * 2`), so the generated bridge emits `D4.getRequiredArgTodoDefault<…>(…, 'math.pi * 2')` which throws `Argument Error: <Class>: Parameter "<name>" has non-wrappable default …` when the argument is omitted. For purely-positional native constructors (`dart:ui` `Gradient.sweep`, `Gradient.radial`, …) the script cannot use named-arg form to skip earlier optional positionals, so any default expression with an operator anywhere in the positional list becomes mandatory at every call site beyond that index. Workaround: at every call site, supply *all* preceding optional positionals up to and including the offending one (use the framework's documented default value literally, e.g. `math.pi * 2.0`). | `rendering/gradient_rendering_test.dart` (C09 closed 2026-05-17 — `ui.Gradient.sweep` `endAngle = math.pi * 2`) |
| [U3 — Interpreted subclass of native abstract `Curve`: `transformInternal` override not routed through `Curve.transform`](#u3--interpreted-subclass-of-native-abstract-curve-transforminternal-override-not-routed-through-curvetransform-interpreter-limitation) | Interpreter limitation (adapter-proxy delegation gap). The native `Curve.transform(t)` template-methods through `Curve.transformInternal(t)`; for script-defined subclasses of `Curve`, the adapter proxy does not intercept the native call to `transformInternal` and route it back to the interpreted override, so `transform()` returns `null` to the bridge consumer. Downstream arithmetic on the null sample (`28.0 * s`, then `12.0 + …`) throws `Native error during bridged operator '+' on double: type 'Null' is not a subtype of type 'num' in type cast`. Reproduces both const and non-const, so distinct from U1. Workaround: use a framework-provided `Curve` subclass (`FlippedCurve(Curves.easeInOut)`) instead of a script-defined `Curve` subclass. | `animation/animation_misc_adv_test.dart` (C10 closed 2026-05-17 — `_FlippedShim extends Curve`) |
| [U4 — Standalone `'\n'` `TextSpan` between two styled siblings crashes the test-app transport](#u4--standalone-n-textspan-between-two-styled-siblings-crashes-the-test-app-transport-truly-unfixable) | Truly unfixable — Dart-VM-level crash inside the bridged render path; `Lost connection to device.` surfaces only as `Bad state: Transport failure while running …`. Trigger is specifically a child `TextSpan(text: '\n')` (literal newline, with or without `style`, with or without `const`) sitting between two other `TextSpan` siblings that each carry a non-null `style`, in the same parent `TextSpan.children` list (`RichText` / `Tooltip(richMessage:)` / `Text.rich(...)`). Both the `'\n'` character and the flanking pair of style-bearing siblings are necessary. Mandatory script-side workaround: append the `'\n'` to the preceding styled `TextSpan`'s `text` and drop the standalone newline child. | `material/tooltip_feedback_test.dart` (C15 closed 2026-05-17 — `_privateRichMessageExample` `RichText`) |

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

## E6 — Native Dart Record named-field access (interpreter limitation)

**Category.** Interpreter / generator architectural limitation.

**Triggering shape.** A d4rt script reads a *named* field on a
**native** Dart record (the `({name: value, age: int})` syntax)
that crossed the interpreter ↔ native boundary — for example,
the result of a stdlib API or a bridged getter that returns
`({String name, int age})`.

```dart
final ({String name, int age}) entry = someBridgedCall();
print(entry.name); // RuntimeD4rtException at this access
```

**What works.** Positional fields (`.$1`, `.$2`, …) are routed
through `dynamic` dispatch in the interpreter (added 2026-04-28
for E6). The script `widgets/platform_menu_widgets_test.dart`
exercises this path and passes.

**Why named-field access is unfixable here.** Dart records
expose their named fields only as **statically-resolved
getters** — the field name has to be known at compile time so
the Dart compiler can emit the right vtable lookup. From inside
the interpreter we only have a `String` for the field name at
runtime, with no compile-time site to dispatch from. The two
"normal" ways out are both blocked:

- `dart:mirrors` would let us look the getter up reflectively,
  but Flutter forbids `dart:mirrors`.
- `(record as dynamic).fieldName` doesn't help because
  `fieldName` is a Dart identifier, not a string variable; you
  can't say `(record as dynamic).(name)` at runtime.

A switch-table that hard-codes a finite list of names won't work
either, because record literals can use *any* identifier.

**Architectural workaround.** The interpreter recognises
`InterpretedRecord` (records authored inside d4rt source) as a
distinct runtime type that carries its named fields in a `Map`,
so reflection by string name *does* work for those. Scripts that
need named-field access should construct or convert to
`InterpretedRecord` rather than relying on a native record value.

When the value comes from a bridged API and only its native form
is available, the practical alternatives are:

- destructure with a record-pattern at the boundary —
  `final (:name, :age) = bridgedCall();` — which the interpreter
  *does* understand, and lets you operate on plain locals from
  there;
- expose the data through a class with explicit getters in the
  bridge instead of a record return type.

The interpreter throws a clear, intentional error in this case:
"Cannot access named field 'X' on a native Dart record. Native
records expose positional fields ('\$1', '\$2', …) but their
named fields are not reflectively accessible without
`dart:mirrors`."

**Documented.** 2026-04-28 with the E6 fix in
`tom_d4rt/lib/src/interpreter_visitor.dart` and
`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`.

---

## E7 — `Iterable.whereType<T>()` drops generic argument (interpreter limitation)

**Category.** Interpreter / generator architectural limitation
(same family as E3 — bridged generic methods drop their type
argument at the boundary).

**Triggering shape.** Any d4rt script that relies on
`whereType<T>()` to remove `null` (or off-type values) from an
iterable and feeds the result into code that requires the
declared type.

```dart
final List<double> logged = _allDays
    .map((RestorableDoubleN d) => d.value) // Iterable<double?>
    .whereType<double>()                    // expected to drop nulls
    .toList();
double sum = 0.0;
for (final double v in logged) {
  sum += v;                                 // null reaches here
}
```

**Where it fails.** The stdlib bridges for collection types call
`whereType()` (no type argument) inside the adapter:

```dart
// tom_d4rt/lib/src/stdlib/core/iterable.dart:177
'whereType': (visitor, target, positionalArgs, namedArgs, _) {
  return (target as Iterable).whereType();
},
// Same shape: list.dart, set.dart, hash_set.dart, runes.dart,
// typed_data/uint8_list.dart, plus `cast` adapters alongside.
```

`whereType()` with no argument resolves to `whereType<dynamic>()`,
which never filters anything. The d4rt bridge has no view of the
caller's `<double>` annotation, so the filter is silently a
no-op.

**Why it's an architectural limitation.** Propagating the call
site's generic argument through the bridge dispatcher would
require generic type tracking on every `BridgedClass` method
call. It would touch every generic stdlib method (`whereType`,
`cast`, and their per-collection variants), the bridge generator's
emitted adapters, and the interpreter's method-resolution path.
This is the same architectural ceiling already documented for
**E3 — `findAncestorStateOfType<T>()`** above; both are instances
of the broader generic-type-argument-erasure issue. A targeted
follow-up would unify the two under a shared "preserve generic
arg through bridged dispatch" change.

**Why not just hard-code `whereType<T>()` per common T?** Dart
allows `whereType<MyDomainType>()` for any user type, including
interpreted classes. A switch over a few well-known `T`s would
fix the common cases (`whereType<double>`, `whereType<Widget>`,
…) but leave the long tail.

**Workaround at the script level.** Replace
`.map(...).whereType<T>()` with explicit accumulation that
null-checks (or type-checks) inline. See the E7 entry in
`script_rewrites.md` for the canonical rewrite.

**Documented.** 2026-04-28 alongside the E7 script-side closure
of `widgets/restorable_double_n_test.dart`.

---

## E8 — Reading `ScrollPosition.maxScrollExtent` between attach and first `applyContentDimensions` (script-side guard required)

**Status.** **Resolved as script-side guard tightening** (Fa2,
2026-04-28). The original E8 diagnosis below was wrong — see
"Misdiagnosis correction" at the end of this entry.

**Symptom.** A `ScrollController` is declared as a state field,
attached to a `Scrollable` (typically a sibling `ListView`), and
the same state field is then read from a *separate* widget that
guards with `controller.hasClients ? controller.position.<X> : …`,
where `<X>` is one of the position getters that asserts
`hasContentDimensions` (e.g. `minScrollExtent`,
`maxScrollExtent`, `viewportDimension`). Two `Null check operator
used on a null value` framework errors fire during the harness
snapshot — one per consumer of the position.

**Triggering Dart/Flutter pattern.**

```dart
class _TelemetryCard extends StatelessWidget {
  final ScrollController controller;
  const _TelemetryCard({required this.controller});
  @override
  Widget build(BuildContext context) => Text(
        controller.hasClients
            ? controller.position.maxScrollExtent.toStringAsFixed(0)
            : '—', // ← unsafe: hasClients ⇏ hasContentDimensions
      );
}
```

`hasClients == true` only means a `ScrollPosition` has been
*attached* to the controller; it does **not** mean the position
has finished its first layout. Between attach and the first call
to `applyContentDimensions`, the position's private
`_maxScrollExtent` field is still null, and `maxScrollExtent`'s
getter (`return _maxScrollExtent!;`) throws `Null check operator
used on a null value`. The same applies to `minScrollExtent` and
to anything that reads the not-yet-set extents.

In a normal compiled Flutter app this race is rarely visible
because `build` runs after layout has stabilised. The d4rt
`SendTestRunner` harness, however, captures the screenshot during
the first frame after attach — exactly inside the
attach-but-not-laid-out window — so the unsafe getter call lands
during the build that produces the screenshot.

**Workaround (script-side, functionally equivalent).** Tighten
the guard to also require `hasContentDimensions`:

```dart
controller.hasClients && controller.position.hasContentDimensions
    ? controller.position.maxScrollExtent.toStringAsFixed(0)
    : '—',
```

This preserves the same visual output (the `'—'` fallback
already exists for the "no clients" case; the harden-up path
extends it to "attached but not yet measured"). No behavioural
change in a real running app — by the time the user can see the
card, content dimensions are set.

**Applied at.**
`widgets/scroll_deceleration_rate_test.dart` (Fa2 fix,
commit covering the cluster). Drops FE from 2 → 0 on the
`hardly_relevant_classes_5` retest.

**Why this is not an interpreter bug.** The d4rt interpreter
correctly forwards the call, and the bridged `ScrollPosition`
correctly throws — that is the documented native behaviour of
`maxScrollExtent` before `hasContentDimensions`. The script's
guard was simply incomplete.

**Misdiagnosis correction.** The previous E8 entry attributed
the residual 2 framework errors to a `BridgedInstance` lifecycle
problem with state-field `ScrollController` propagated through a
`StatelessWidget` chain. That diagnosis was wrong: the bisect
table that supported it (locally-constructed controller "fixes"
the issue) was an artefact of the `_TelemetryRow` path being
short-circuited when the controller was rebuilt locally. Bisecting
slivers of `widgets/scroll_deceleration_rate_test.dart` after the
layout-cascade fix located the FE precisely on the
`_TelemetryCard.maxScrollExtent` ternary inside `_TelemetryRow`;
removing only that line drops FE from 2 → 0 with everything else
intact, including the state-field controller propagation through
`_DynoTrackPair → _DynoLane → ListView.builder`. Six minimal
reproducers built from the misdiagnosis (state-field +
StatelessWidget chain, with and without listeners / physics /
ValueListenableBuilder) all reported FE=0; only after restoring
the unguarded `maxScrollExtent` read did the failure surface.

**Documented.** 2026-04-28 (corrected from prior misdiagnosis).

**Re-verified.** 2026-04-29 — `widgets/scroll_deceleration_rate_test.dart`
inspected during the Fa1 cluster sweep; FE=0 confirmed across all
three observed runtime contexts (single-script `--plain-name`
filter on `hardly_relevant_classes_5_test.dart`, full
`hardly_relevant_classes_5_test.dart` suite run with cross-script
ordering, and the `[fa1-c3]` group of `fa1_bisect_test.dart`).
Both `CrossAxisAlignment.stretch` sites in the file (the Row.stretch
in `_DynoTrackPair` and the Column.stretch in `_DynoLane`) were
inspected and confirmed safe — the Row.stretch is wrapped in an
explicit `SizedBox(height: 420)` (matches the C3 closing recipe
"pin a finite parent height before the sliver boundary"), and the
Column.stretch operates on the bounded horizontal axis from the
surrounding `Expanded`. No latent C3 / Fa1 pocket present. The
E8/Fa2 fix from 2026-04-28 fully addresses this script's only
historical FE source. Logs:
`doc/testlog_scroll_deceleration_fix/{baseline,hr5_full,fa1c3_baseline}.log.txt`.

---

## Fa1-N1 — Layout-cascade FE residuals on 6 deep-demo scripts (script-side, annotation-deferred)

**Cluster reference.** `error_analysis.md` cluster N1 / Fa1
(`testlog_20260428-2250-issue-analysis`).

**Severity.** Cosmetic only — every affected script passes at the
suite level (zero test failures). The framework errors are
recorded by Flutter's debug overlay but do not fail any
assertion that the harness counts as a hard test failure.

**Status.** Reverted/Deferred. Each script carries a
`D4RT-SCRIPT-LIMITATION: layout cascade` annotation block
explaining the local cause and the closing route. The closing
route is documented (below) but not applied because the
risk-vs-reward of large-script rewrites isn't justified for
zero-failure noise. A sentinel is kept in
`test/fa1_bisect_test.dart` (`[fa1-2250-sentinel]` group) so any
future flutter behaviour change that drops these to FE=0 will
surface in a routine baseline run.

### Affected scripts and FE shapes

| Script | FE | Sub-pocket | Triggering Flutter codepath |
|---|---:|---|---|
| `widgets/snapshot_mode_test.dart`                | 1 | small-overflow   | `RenderFlex` overflowed by 14 px on the bottom — one of the panel-level Columns has fixed children summing > available height |
| `widgets/select_all_text_intent_test.dart`       | 3 | EditableText     | Negative-min-h on `_RenderEditableCustomPaint` + semantics-layout race |
| `widgets/transpose_characters_intent_test.dart`  | 2 | EditableText     | Same as above (semantics race fires; the leading constraint failure is suppressed by Flutter's tolerance, leaving 2 FE) |
| `widgets/restoration_mixin_test.dart`            | 3 | EditableText     | Same as `select_all_text_intent_test.dart` |
| `widgets/widget_state_color_test.dart`           | 9 | C3 (Row(stretch)+Expanded inside Sliver) | Row(stretch) + Expanded children inside SliverToBoxAdapter — sliver protocol gives unbounded vertical, Row(stretch) cannot resolve |
| `widgets/text_magnifier_configuration_test.dart` | 6 | C3 (Row(stretch)+Expanded inside Sliver) | Same as `widget_state_color_test.dart` |

**Not annotated.** ~~`widgets/restorable_double_test.dart` —
emitted FE=1 in the `secondary_classes_test` suite at testlog
2250, but FE=0 in isolation under `fa1_bisect_test.dart`. The
inter-script ordering flake doesn't fit the script-annotation
pattern; tracked separately if it persists.~~ — **closed
2026-04-29** via small-overflow recipe applied to the VU meter's
`_buildVuBar`. See "Small-overflow pocket — empirical findings
2026-04-29" subsection below for the full diagnosis: the centre
shaft (190 px) + gap (6 px) + label (~16 px) summed past the
inner content area (196 px after `Container(padding: all(12))`
inside `SizedBox(height: 220)`) by 17 px. Capped centre at 170
px and sides at 150 px to preserve the original 20 px asymmetry
while leaving 6 px headroom. FE → 0 across single-script,
x-script (`restorable_(date_time|double)`), sentinel, and full
secondary suite contexts.

**Also closed 2026-04-29 (crashing-suite, single-script
context):** ~~`widgets/display_feature_sub_screen_test.dart` —
emitted FE=1 (40 px bottom overflow) in the `crashing_tests_test`
suite. Closed by aligning `MediaQuery.size` with the surrounding
`SizedBox` extent in `_ComparisonCard.build` for the
`horizontalFold` mode of `_FeatureComparisonScene`.~~ See
"Small-overflow pocket — DFSS MediaQuery / SizedBox mismatch
2026-04-29" subsection below for the full diagnosis. FE → 0
under single-script retest (regression rule (a) — test-script-
only change).

### Sub-pocket rewrite recipes (the closing routes)

#### Small-overflow pocket (snapshot_mode)

The flutter debug overlay records `RenderFlex overflowed by N
pixels` whenever a Column or Row's children exceed the available
main-axis extent by N pixels. The demo's panel-level layouts use
fixed `SizedBox(height: <constant>)` spacers and content that, on
the test app's surface size, sum to slightly more than the
panel height.

**Workaround patterns — same functional result, no FE:**

1. Convert the offending panel Column to a `ListView` (the C22
   pattern already applied to `shortcut_activator_test.dart`
   etc.) so the children scroll instead of overflowing.
2. Wrap the panel body in `SingleChildScrollView`.
3. Reduce the offending fixed-height spacer (`SizedBox(height:
   24)` → `SizedBox(height: 10)` etc.) by the documented
   overflow amount.

The blocker is **finding the offending panel** without runtime
instrumentation — the FE message lists no `Widget` ancestor. A
bisecting harness that replaces panels one at a time with
`SizedBox.shrink()` would localise the offender; deferred as
non-essential effort.

##### Small-overflow pocket — empirical findings 2026-04-29

Two scripts in this pocket were closed with a manual rewrite,
proving the recipes work and producing reusable bisect knowledge:

- **`snapshot_mode_test.dart` (1 FE):** closed by bumping the
  AppBar `preferredSize` from 72 → 88 to fit the 44 px shutter
  + 38 px padding combination.

- **`restorable_double_test.dart` (1 FE):** closed by capping the
  VU meter shaft heights — `centreMax` 190→170, `leftMax/rightMax`
  170→150 — so each `Column(mainAxisSize.min)` fits inside its
  parent `SizedBox(height: 220)` minus the surrounding
  `Container(padding: all(12))`. The Column adds shaft + 6 px gap
  + ~16 px Text label, so the budget is `220 − 24 (padding) − 6
  (gap) − 16 (label) ≈ 174 px max shaft`. The original 190 px
  centre exceeded that by 17 px under cross-script font/sub-pixel
  rounding (any preceding `restorable_*` render in the same
  in-process suite triggers it). The original 20 px asymmetry
  (centre slightly taller than sides) is preserved by trimming
  both pairs by the same delta.

**Bisect tactics that worked.** The FE only manifests when at
least one preceding script has rendered in the same suite — the
single-script `--plain-name` filter on the home suite reports
FE=0 because the harness has no prior render to perturb the font
metrics. To reproduce in seconds rather than running the full
~8-min suite, use a 2-script regex filter:

```bash
flutter test test/secondary_classes_test.dart \
    --name "restorable_(date_time|double)"
```

This runs ~2 seconds and reproduces the 17 px overflow reliably.
Inside the script, comment out the top-level child sections one
at a time in the build's outer `Column`, then bisect within the
remaining section by replacing sub-Rows / sub-Columns with
`SizedBox.shrink()` until the FE stops. For
`restorable_double_test.dart` the path was: S5→S4→S3→S2 each
disabled showed FE persisted (so it was in S1), then dial-only
showed FE=0 and VU-only showed FE=1 — pinpointing the VU meter
in 4 ~3-second iterations.

**Mental model.** A "small overflow" usually means the layout is
correct on the *first* render in the test app's process but
drifts by a few pixels on subsequent renders due to font cache
warming, baseline-grid rounding, or platform glyph-height
fallback. The fix is to leave a 4–8 px headroom on every fixed-
height container that hosts an intrinsic-sized Column. If a
panel was designed with the bar/shaft height precisely matching
parent height − padding − labels, that's a fragile measurement
that *will* surface as a small-overflow FE under some preceding
test ordering.

##### Small-overflow pocket — DFSS MediaQuery / SizedBox mismatch 2026-04-29

A third script in this pocket was closed with a manual rewrite,
and is recorded here because the trigger is structurally
distinct from the font-drift cases above:

- **`widgets/display_feature_sub_screen_test.dart` (1 FE, 40 px
  bottom):** closed by aligning `MediaQuery.size` with the
  surrounding `SizedBox` extent in `_ComparisonCard.build`
  (scene `_FeatureComparisonScene`, `horizontalFold` mode).
  Original used `MQ size = Size(360, 220)` inside an outer
  `SizedBox(width: 300)` and inner `SizedBox(width: 300, height:
  180)`; fix uses `canvas = Size(300, 220)` for both MQ and the
  inner SizedBox, with the outer SizedBox bumped to 324 (=300 +
  Container padding 12 × 2) so the inner 300 px width is not
  clamped.

**Triggering Flutter codepath.**
`DisplayFeatureSubScreen.build` (see
`flutter/lib/src/widgets/display_feature_sub_screen.dart` lines
111–118) wraps `child` in a `Padding` whose insets are computed
from `mediaQuery.size` minus the closest sub-screen rect:

```dart
return Padding(
  padding: EdgeInsets.only(
    left: closestSubScreen.left,
    top: closestSubScreen.top,
    right: parentSize.width - closestSubScreen.right,
    bottom: parentSize.height - closestSubScreen.bottom,
  ),
  child: MediaQuery(data: mediaQuery.removeDisplayFeatures(...), child: child),
);
```

When `mediaQuery.size` is *larger* than the actual parent box
(here: 360×220 declared inside a 300×180 SizedBox), the Padding
insets are computed against the wider/taller parent and then
applied inside the smaller box. For `horizontalFold` with
default LTR anchor `(120, 140)`, the closest sub-screen is the
bottom half (`y = 118 .. 220`), so `Padding.top = 118`. The
parent SizedBox only provides 180 px of height, leaving
`180 − 118 = 62 px` for the child's intrinsic Column inside
`_MiniPaneCard` (which needs ~91 px), producing the 40 px bottom
overflow.

**Workaround pattern — same functional result, no FE:** keep
`MediaQuery.size` *exactly* equal to the parent SizedBox extent
that hosts the DFSS subtree, and ensure each candidate
sub-screen rect produced by the configured display features has
enough room for the child's intrinsic Column. For
`horizontalFold` on a 300×220 canvas, each sub-screen is `220/2
− 8 = 102 px` tall, leaving ~11 px headroom over `_MiniPaneCard`'s
~91 px column — comfortably inside the 4–8 px headroom rule.

**Mental model.** DFSS is unique in this pocket because the
overflow is not driven by font metric drift; it is a deliberate
geometric placement. Any DFSS-using widget that synthesises its
own `MediaQuery` (rather than passing the ambient one through)
must keep `MQ.size == hosting SizedBox`, and must size the
SizedBox so that every candidate sub-screen — top/bottom for
horizontal folds, left/right for vertical hinges — has enough
room for the child Column at its intrinsic height plus the
4–8 px headroom. Otherwise some anchor + posture combination
will pin the child to a sub-screen that cannot hold it.

#### EditableText pocket (select_all_text_intent, transpose_characters_intent, restoration_mixin)

The flutter framework's `_RenderEditableCustomPaint` is laid out
during the layout pass. When its parent (typically the
`Container > TextField(maxLines: N)` chain inside a
`Column(crossAxisAlignment: stretch)`) computes a constraint
where the minimum height shrinks below zero — a normal edge case
when the editable's preferred height exceeds the panel chrome's
remaining vertical extent — the layout assertion `'hasSize'`
fires. Compounding it, `_RenderEditable.attach()` registers
itself with the semantics owner; if semantics tries to
re-evaluate the editable in the same frame it walks the render
object before layout completes, hitting
`!childSemantics.renderObject._needsLayout` (object.dart:5737).

**Workaround patterns — same functional result, no FE:**

1. Pin the TextField parent height with `SizedBox(height:
   <fixed>)` so the constraint never shrinks negative:

    ```dart
    SizedBox(
      height: 80, // pinned — fits 3 lines of body text
      child: TextField(
        controller: _tierAController,
        maxLines: 3,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    )
    ```

2. Replace the live `TextField` demo with a static
   `SelectableText` + a manually-drawn caret glyph. The
   select-all dispatch surface remains visible; only the
   *editable* render path is removed:

    ```dart
    SelectableText(
      _tierAController.text,
      style: const TextStyle(...),
    )
    ```

3. Drop `crossAxisAlignment: stretch` on the parent Column so
   the editable computes an intrinsic width without forcing a
   stretched parent; the editable's own width is left free:

    ```dart
    Column(
      crossAxisAlignment: CrossAxisAlignment.start, // was stretch
      children: <Widget>[ ..., TextField(...), ... ],
    )
    ```

The blocker is that the TextField *is* the demo — Tier-A in
`select_all_text_intent_test.dart` exists specifically to show
the select-all intent firing on a live editable. Replacing it
with a SelectableText loses the demo's central value
proposition. Deferred until a per-script visual rework is
prioritised.

**Update 2026-04-29 — empirical findings on the listed
workarounds:**

The three scripts `select_all_text_intent_test.dart`,
`transpose_characters_intent_test.dart`, and
`restoration_mixin_test.dart` were promoted out of
this deferral on 2026-04-29 (the EditableText pocket is now
fully closed; only the `widget_state_color` and
`text_magnifier_configuration` C3 sliver-row sub-pockets remain
in this cluster). Working through them surfaced
two important refinements to the workaround patterns above:

- **Workaround 1 (`SizedBox(height:)` pin) does NOT reliably
  close the cascade.** The pin sets a tight outer constraint on
  the TextField, but `InputDecorator`'s intrinsic-height pass
  still computes its inner editable's measurement
  independently, and that pass can produce the negative-min
  constraint inside the SizedBox during the same frame the
  semantics walker runs. Verified empirically: SizedBox(76)
  around `TextField(maxLines: 3)` and SizedBox(40-44) around
  `TextField(maxLines: 1)` both left FE counts unchanged.

- **A bare `EditableText` (without `InputDecoration`) does NOT
  bypass the cascade either.** The negative-min-height assertion
  originates inside `_RenderEditableCustomPaint`, which is
  EditableText's own internal render object — TextField just
  embeds an EditableText, so swapping the wrapper changes
  nothing at the render layer. Verified empirically on
  `transpose_characters_intent_test.dart`: replacing all three
  `TextField`s with bare `EditableText`s kept FE at 2.

- **Workaround 2 (replace with `SelectableText`) is the only
  reliable closing route.** `SelectableText` uses
  `_RenderParagraph`, which has no editable render path and
  does not assert on the parent's constraint shape. Confirmed
  by both the 2026-04-29 fixes mentioned above (FE → 0).

- **Functional preservation when the demo "needed" a live
  editable:** in practice, all three scripts' demos kept their
  educational value through alternate channels — Action chains
  dispatched via buttons / `Actions.invoke` / default keyboard
  handlers (select_all, transpose), or other `RestorableX`
  properties exercised through interactive buttons
  (restoration_mixin's `_score` / `_currentTurn` / `_diceValue`
  / `_isRolling` / `_lastRollAt`). The per-keystroke "live
  preview" of caret manipulation / text entry is the only
  behaviour lost.

- **Cross-script state-bleed asymmetry:** `restoration_mixin_test`
  reported FE=0 in its home suite (`secondary_classes_test`)
  but FE=3 in the `[fa1-2250-sentinel]` context — proof that
  the cascade is sensitive to test-runner ordering and that the
  preceding `restorable_double_test.dart` leaves residual
  editable state which the next script inherits. The
  SelectableText replacement closes both contexts because it
  bypasses the editable render path entirely.

**Trigger code (Dart/Flutter side):**

```dart
// 3-FE cascade (negative-min-h → !hasSize → !_needsLayout):
ListView(
  children: <Widget>[
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ANY of these triggers the cascade when the parent
          // chain shrinks the constraint mid-frame:
          TextField(maxLines: 3),       // Tier-A
          TextField(maxLines: 1),       // single-line
          EditableText(controller: c, focusNode: f, ...), // bare
        ],
      ),
    ),
  ],
)
```

**Workaround code (Dart/Flutter side, same functional result
where possible):**

```dart
// Replace the editable with a non-editable equivalent that
// uses _RenderParagraph instead of _RenderEditableCustomPaint:
SelectableText(
  _controller.text,
  style: TextStyle(...),
)

// If the demo's Intent dispatch chain fires from a button
// (Actions.invoke / Actions.maybeInvoke) or keyboard
// shortcut wired through Shortcuts/Actions, the registered
// Action still fires regardless of editable focus — so the
// educational narrative is preserved.
```

#### C3 pocket (widget_state_color, text_magnifier_configuration)

A `Row(crossAxisAlignment: stretch)` with `Expanded` children
placed inside a `SliverToBoxAdapter` (or anywhere inside a
`CustomScrollView`) hits a fundamental incompatibility in
flutter's render protocol: slivers measure their adapter children
with `BoxConstraints(minHeight: 0, maxHeight:
double.infinity)`. `Row(stretch)` requires a *finite* parent
height to stretch its children to. The result: `BoxConstraints
forces an infinite height`, the row's children fail to lay out
(`hasSize` assertion), the sliver adapter's
`firstChild`/`lastChild` walk hits null in the paint phase, and
9 FE cascade out for `widget_state_color_test.dart` (6 for
`text_magnifier_configuration_test.dart`).

**Workaround patterns — same functional result, no FE:**

1. Drop `crossAxisAlignment: stretch` (use the default `start`
   or `center`); explicitly set each card's height where the
   visual symmetry needs it:

    ```dart
    Row(
      crossAxisAlignment: CrossAxisAlignment.start, // was stretch
      children: <Widget>[
        SizedBox(height: 220, child: Expanded(child: card1)),
        SizedBox(height: 220, child: Expanded(child: card2)),
        SizedBox(height: 220, child: Expanded(child: card3)),
      ],
    )
    ```

2. Pin the parent vertical extent before the sliver boundary,
   so `Row(stretch)` sees a finite height:

    ```dart
    SliverToBoxAdapter(
      child: SizedBox(
        height: 220, // pinned
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[ ... ],
        ),
      ),
    )
    ```

3. Replace the `Row` with `IntrinsicHeight + Row(stretch)` (the
   IntrinsicHeight provides a finite vertical extent for the
   Row's stretch axis):

    ```dart
    IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[ ... ],
      ),
    )
    ```

The blocker is that the demo's hero strip leans on stretched
rows for the brass-rimmed-lens / chameleon-card visual
composition; pinning a height changes the demo's appearance.
Deferred until a per-script visual rework is prioritised.

**Update 2026-04-29 — empirical findings (Fa1 cluster fully closed):**

Both C3 sub-pocket scripts (`widget_state_color_test.dart` and
`text_magnifier_configuration_test.dart`) were promoted out of
this deferral on 2026-04-29. With them, the entire Fa1 cluster
is closed — all 7 sentinel slots now report FE=0. Working through it confirmed:

- **Workaround 1 (stretch → start) is sufficient and simplest.**
  Both `Row(crossAxisAlignment: stretch)` sites in
  `_WscAnatomyFactories.build` and `_WscFromMapVsResolveWith.build`
  were switched to `CrossAxisAlignment.start`. FE drops from 9
  to 0. The visual cost is the loss of guaranteed equal-height
  between the two cards in each row; in practice this script's
  cards have nearly identical natural heights, so the visual
  difference is minimal. No SizedBox pin or `IntrinsicHeight`
  wrap was needed — the Expanded's horizontal flex is preserved
  intact, and each card simply sizes to its own intrinsic
  vertical extent.

- **Not all `CrossAxisAlignment.stretch` instances need to
  be flipped.** A `Column(crossAxisAlignment: stretch)` whose
  parent has a *bounded width* (e.g., a Container inside an
  Expanded) is safe: the Column's cross-axis is horizontal, so
  the stretch operates on the bounded axis only. The third
  stretch site in `_constructorCard`'s inner Column was left
  in place after verifying FE=0 in both the home suite and the
  fa1 sentinel. The cascade only fires when the stretch axis
  matches the unbounded axis the SliverList feeds (i.e., a
  vertical-stretch on a Row inside a sliver-fed extent).

- **Workaround 3 (`IntrinsicHeight + Row(stretch)`) was
  attempted first** as a way to preserve the equal-height
  visual that `stretch` was guaranteeing, but produced a
  fragile structure that wrapped each Expanded child individually
  with no clean closing recipe. Workaround 1 (drop stretch) is
  preferred for its readability — the demo's narrative survives
  unchanged either way.

- **A C3 cascade can mask an underlying Fa1 EditableText
  cascade in the same script.** Confirmed empirically on
  `text_magnifier_configuration_test.dart`: pre-fix FE was 6
  (pure C3 shape — infinite-height RenderPadding + RenderFlex /
  RenderPadding `hasSize` + 3× null-check). After the C3 fix
  (stretch→start), FE jumped to 9 — the script's two
  `TextField`s embedding `magnifierConfiguration` started
  reporting the negative-min-height + `hasSize` cascade on
  `_RenderEditableCustomPaint` plus a semantics `!_needsLayout`
  assertion. The C3's "infinite height" propagated up the
  layout tree fast enough that the inner editable's layout pass
  was short-circuited before its negative-min could fire; once
  the C3 was closed, the editable layout completed and produced
  its own cascade. **Implication for future cluster fixes:**
  when a C3 fix surfaces new errors instead of dropping to 0,
  the new errors are likely a previously-masked Fa1 sub-pocket
  in the same script — apply the EditableText-pocket closing
  recipe (TextField/EditableText → SelectableText) on top of
  the C3 fix. For demos that depend on `magnifierConfiguration`,
  `SelectableText` is a one-for-one swap because it accepts the
  same parameter and triggers the configured loupe through the
  long-press handle drag path.

### Sentinel test

`test/fa1_bisect_test.dart` carries a recurring sentinel group
`[fa1-2250-sentinel]` that runs each of the 7 scripts (6
annotated + `restorable_double` to track the inter-suite flake)
and prints `FA1 STATUS: <bool>  FE: <int>  SCRIPT: <path>`. If
any script's FE drops to 0 in a future run (e.g., flutter
upstream changes the sliver protocol or relaxes the semantics
race), the annotation can be removed and the script counted as
genuinely fixed without script-side surgery.

**Documented.** 2026-04-28 (Fa1-N1 closure via annotation).

---

## N2 — Bridged `RestorableProperty` proxy: script-side eager-init + defensive iteration

- **Cluster:** N2 (testlog_20260428-2250-issue-analysis) ·
  **Severity:** Low (single FE, zero test failures) · **Owner:**
  scripts (the underlying interpreter limitation is the same one
  documented above for D3/D4 — bridged `RestorationMixin`
  lifecycle dispatch under cross-script ordering)
- **Affected script:** `widgets/restorable_property_test.dart`
- **Status:** Closed via script-side workaround 2026-04-29.
  Single-suite isolation already FE=0; the FE only surfaces when
  the script runs inside the full `secondary_classes_test`
  ordering.

### What the underlying Dart/Flutter code does

The script demonstrates writing **custom** `RestorableProperty<T>`
subclasses, which is the canonical way to persist non-primitive
state across `RestorationMixin`. Both `_RestorableColor` and
`_RestorableStringList` follow the textbook pattern:

```dart
class _RestorableColor extends RestorableProperty<Color> {
  _RestorableColor([Color? defaultValue])
      : _defaultValue = defaultValue ?? const Color(0xFF3F51B5);

  final Color _defaultValue;
  late Color _value;                      // ← (A) late-init

  Color get value => _value;
  set value(Color newValue) { /* … */ }

  @override
  Color createDefaultValue() => _defaultValue;

  @override
  void initWithValue(Color value) {       // ← (B) framework writes _value here
    _value = value;
    notifyListeners();
  }
  // …
}

class _RestorableStringList extends RestorableProperty<List<String>> {
  _RestorableStringList([List<String>? defaultValue])
      : _defaultValue = List<String>.unmodifiable(defaultValue ?? const <String>[]);

  final List<String> _defaultValue;
  late List<String> _value;

  // ← (C) defensive copy through `List.unmodifiable`
  List<String> get value => List<String>.unmodifiable(_value);
  // …
}

// In `_buildFavoritesStrip`:
final List<String> favs = _favoriteSwatches.value;
return Wrap(children: <Widget>[
  for (final String hex in favs) _favoriteChip(hex),  // ← (D) for-in
]);
```

In real Flutter the chain is: `initState()` → `restoreState()` is
called *before* the first build → `registerForRestoration` calls
`initWithValue(createDefaultValue())` (or
`initWithValue(fromPrimitives(saved))`) → `_value` is set → first
`build()` runs and `_value` is safe to read.

### Why it FE-fires under d4rt

Two distinct shapes, both rooted in the bridged
`RestorationMixin` proxy (the same architectural limitation
documented above for D3/D4):

1. **(A) `late _value` LateInit.** Under cross-script ordering
   the bridged `registerForRestoration` → user-override
   `initWithValue` dispatch can be skipped or reordered, so
   `_value` is read before `initWithValue` was called and the
   `late` field throws `LateInitializationError`.

2. **(C)→(D) `for-in BridgedInstance<Object>`.** Even after the
   late-init shape is fixed by eager-seeding (workaround below),
   reading `_favoriteSwatches.value` from script context can
   short-circuit through the bridge proxy and return a
   `BridgedInstance<Object>` instead of dispatching to the user's
   `value` getter override. The `for-in` then trips
   "`Value used in collection 'for-in' must be an Iterable, but
   got BridgedInstance<Object>`".

Both shapes only surface inside the multi-script
`secondary_classes_test` sequence — the script in isolation
records FE=0. The interpreter cannot deliver bridged
`RestorationMixin` proxy dispatch deterministically under
cross-script ordering without a full restore-bucket emulation,
which is the architectural limitation already catalogued for
D3/D4 in the closed clusters of `testlog_20260428-1333` and
`testlog_20260427-1339`.

### Workaround applied (script-side, single-test verified)

Three small, surgical edits to
`widgets/restorable_property_test.dart`:

**(1) Eager-seed `_value` from constructor and drop `late`.**

```dart
_RestorableColor([Color? defaultValue])
    : _defaultValue = defaultValue ?? const Color(0xFF3F51B5),
      _value = defaultValue ?? const Color(0xFF3F51B5);   // ← seeded

final Color _defaultValue;
Color _value;                                              // ← no longer late
```

Functionally equivalent to the textbook pattern: `initWithValue`
still reassigns `_value` from the framework-supplied value when
the lifecycle does run, so restoration round-trips remain
correct. The default is just a *safe initial* that prevents
LateInit if the framework dispatch is skipped.

**(2) Replace `List.unmodifiable` with `List.from` in the list
getter.**

```dart
List<String> get value => List<String>.from(_value);
```

`List.unmodifiable` returns a bridged read-only view that surfaces
as `BridgedInstance<Object>` to script-side iteration in some
ordering paths. `List.from` returns a plain `List<String>` and
preserves the defensive-copy guarantee (callers still cannot
mutate `_value`).

**(3) Defensive snapshot for the iteration site.**

```dart
List<String> _favoritesSnapshot() {
  try {
    final dynamic raw = _favoriteSwatches.value;
    if (raw is List<String>) return raw;
    if (raw is List) {
      final List<String> out = <String>[];
      for (final dynamic e in raw) {
        out.add(e.toString());
      }
      return out;
    }
  } catch (_) {
    // Fall through — bridge proxy didn't dispatch to override.
  }
  return const <String>[];
}

// Use:
final List<String> favs = _favoritesSnapshot();
//                       and …
if (_favoritesSnapshot().contains(hex)) { /* … */ }
```

If the proxy chain dispatches correctly, the snapshot returns the
real list. If the cross-script ordering path falls through to a
`BridgedInstance<Object>`, the type checks fail and we get an
empty list — equivalent to the "no favourites yet" first-render
branch the framework would have produced in real Flutter, so the
demo still renders coherently with no FE.

### Verification

- **Pre-fix (testlog_20260428-2250):** `restorable_property_test`
  FE=1 (`LateInitializationError`) inside `secondary_classes_test`.
- **Post-eager-init only:** `restorable_property_test` FE=1
  (shape changed to `for-in BridgedInstance<Object>`) — the
  late-init shape was cured but exposed the iteration shape.
- **Post-full workaround:** `restorable_property_test` FE=0
  inside `secondary_classes_test` (`secondary_post3.log.txt`).
- Single-test invocation (regression rule (a) was sufficient
  because all changes are confined to a single test script):
  `secondary_classes_test --plain-name 'restorable_property'` →
  FE=0.

**Documented.** 2026-04-29 (N2 closure via script-side
eager-init + defensive iteration; underlying interpreter
limitation remains the same one catalogued for D3/D4).

### Deferred architectural fix (C-E4 closing route)

The carry-over cluster **C-E4** (`testlog_20260428-2250` /
1333 §E4) lists an alternative closing route: thread the
bridged `RestorableProperty.value` setter through the
interpreter visitor's `_setBridgedInstanceField` path so that
the assignment performed by the bridged constructor pipeline
reaches the script-side late field. This would close the
late-init path at the interpreter level and remove the need
for the script-side eager-seed step (1) above. The other two
steps (`List.from` getter swap and `_favoritesSnapshot()`)
would still be required for the iteration shape, which is a
separate manifestation of the same proxy-dispatch limitation.

**Why deferred:**

- The fix touches both `tom_d4rt/lib/src/interpreter_visitor.dart`
  and `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`
  (sync rule), and the bridged-mixin field-storage path is
  consumed by every `RestorationMixin`-derived script —
  regression risk is broad.
- Symptomatic closure is already in place (FE=0 on
  `restorable_property_test` and `restorable_string_test`),
  so the architectural fix has no remaining test-side urgency.
- The scope overlaps the larger D3/D4 architectural limitation
  catalogued above; the right place to land it is alongside a
  more general bridged-mixin lifecycle pass, not as a
  property-class-specific shim.

**Re-opening trigger:** any new `RestorableProperty` subclass
in the test corpus that cannot be made FE=0 by the script-side
recipe above; or a planned interpreter pass on
bridged-mixin field-storage / proxy lifecycle that would
naturally fold this in.

---

## P1 — `PreferredSizeWidget` cast fails when arg arrives as a cached native widget proxy

**Source:** `testlog_20260503-0948-issue-analysis` priority-1
cluster ("Bridge: `InterpretedInstance` not coerced for typed
Flutter param"). Two of the three reported sub-cases —
`SliderThemeData.thumbShape` and
`SpellCheckConfiguration.spellCheckService` — were closed by
adding `SliderComponentShape` and `SpellCheckService` to the
`proxyClasses` allowlist in `buildkit.yaml` and regenerating
`flutter_proxies.b.dart`. The third sub-case
(`Scaffold.appBar` in `widgets/snapshot_mode_test.dart`) does
**not** close on the same fix and is documented here as an
interpreter architectural limitation.

### What the script does

`widgets/snapshot_mode_test.dart` follows the canonical Flutter
pattern for a custom app bar:

```dart
class _SmodeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _SmodeAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(88);

  @override
  Widget build(BuildContext context) => AppBar(...);
}

// later, in a build method:
Scaffold(appBar: const _SmodeAppBar(), body: ...)
```

The class chain has `bridgedSuperclass = StatelessWidget` and
`bridgedInterfaces = [PreferredSizeWidget]`.

### Why the cast fails

The `Scaffold` bridge constructor calls
`D4.extractBridgedArg<PreferredSizeWidget?>(arg, 'appBar', visitor)`.
The reported error is:

```
Native error during default bridged constructor for 'Scaffold':
Argument Error: Invalid parameter "appBar":
expected PreferredSizeWidget?, got _InterpretedStatelessWidget
```

Trace:

1. The interpreter evaluates `_SmodeAppBar()` and creates an
   `InterpretedInstance`. As part of its lifecycle (auto-instantiation
   via the `StatelessWidget` proxy factory) the instance's
   `nativeProxy` is set to a `_InterpretedStatelessWidget` —
   the proxy registered for the *first* matching bridged
   superclass walked, which is `StatelessWidget`.
2. By the time the `Scaffold` argument list is assembled by the
   visitor, the value reaching the bridge is the cached
   `_InterpretedStatelessWidget` itself, **not** the
   `InterpretedInstance` — the framework-side caller already
   "extracted" the native Widget proxy when the value was bound
   into the widget tree.
3. `extractBridgedArg<T>` in
   `tom_d4rt/lib/src/generator/d4.dart` and the mirror in
   `tom_d4rt_ast/lib/src/runtime/generator/d4.dart` only run the
   `tryCreateInterfaceProxyWithVisitor<T>` walk when
   `arg is InterpretedInstance`. With a native Widget arg the
   walk is skipped, and the final `arg as T` cast fails because
   `_InterpretedStatelessWidget` does not implement
   `PreferredSizeWidget`.
4. The hand-written `_InterpretedPreferredSizeWidget` proxy
   *would* have satisfied the cast — the proxy walk in
   `tryCreateInterfaceProxyWithVisitor<PreferredSizeWidget>` even
   collects it correctly via `bridgedInterfaces` (see
   `d4.dart:1929-1949`). The issue is that the walk never runs
   because the arg's type changed upstream.

### Why we are not fixing this in cluster scope

A clean fix would require:

- A marker abstraction (e.g. `InterpretedNativeProxy`) that every
  hand-written `_Interpreted…Widget` proxy implements, exposing
  the underlying `InterpretedInstance` and `InterpreterVisitor`.
- A new branch in `extractBridgedArg<T>` that, when arg matches
  `InterpretedNativeProxy` *and* the cast `arg is T` already
  fails, re-runs `tryCreateInterfaceProxyWithVisitor<T>` against
  the wrapped instance — picking up other registered proxies on
  the same script class for a different `T`.
- Mirrored changes in `tom_d4rt` and `tom_d4rt_ast`, plus a
  retroactive update of every existing
  `_Interpreted…Widget`/`_Interpreted…Element` proxy in
  `tom_d4rt_flutter_ast/lib/src/d4rt_runtime_registrations.dart`
  and the `tom_d4rt_flutter_test` mirror to implement the marker.

The change touches the interpreter's ergonomic argument-coercion
path on every bridged constructor call. It is well outside the
scope of a single-cluster fix and risks regressions across the
whole bridge surface, so it is deferred.

### Script-side workaround (functional equivalent)

Flutter ships a concrete `PreferredSize` widget that wraps any
child with a declared preferred size:

```dart
PreferredSize(
  preferredSize: const Size.fromHeight(88),
  child: AppBar(
    backgroundColor: _kSmodeCharcoalDeep,
    elevation: 0,
    automaticallyImplyLeading: false,
    toolbarHeight: 88,
    title: ...,
  ),
)
```

`PreferredSize` is a `StatelessWidget` that *implements*
`PreferredSizeWidget` natively, so passing one to
`Scaffold(appBar: ...)` satisfies the cast directly. The
functional result is identical: the appBar's preferred height is
declared, `Scaffold` reserves the right amount of vertical
space, and the `AppBar` body renders unchanged. The only
behavioural difference is that the script no longer needs a
custom subclass — the `_SmodeAppBar` declaration can be folded
into a top-level `Widget _smodeAppBar()` factory or directly
inline at the call site.

This is the recommended rewrite for any d4rt script that hits
the same FE; whether to apply it now or wait for the
interpreter-level fix is left to the per-script cluster owner.

### Re-opening trigger

Any of:

- A planned interpreter pass that introduces an
  `InterpretedNativeProxy` marker interface (or equivalent
  re-walk hook) on the cached `nativeProxy` field.
- A new test script in the corpus that fails the same way and
  cannot be rewritten to use `PreferredSize(...)` (e.g. a script
  that needs to expose other state through the
  `PreferredSizeWidget` interface beyond `preferredSize`).

---

## P4 — `switch (BridgedEnum)` may fall through every case, returning null

### What the scripts do

Each affected script defines `String`-returning helpers that
switch over a Flutter-bridged enum (`TargetPlatform` in
`foundation/target_platform_test.dart` and
`widgets/tooltip_window_controller_delegate_test.dart`,
`TimeOfDayFormat` in `material/time_of_day_format_test.dart`).
The shape is the canonical exhaustive Dart switch:

```dart
String _platformOs(TargetPlatform p) {
  switch (p) {
    case TargetPlatform.android: return 'Android';
    case TargetPlatform.iOS: return 'iOS / iPadOS';
    // … one return per enum value, no default
  }
}
```

The result flows into a downstream `Text(...)` either directly
(`Text(_icuPattern(fmt))`) or via a wrapper widget that requires
a non-null `String` parameter (`_heroChip(label, _platformFamily(current), tint)`
→ `Text(value, ...)`).

### Why it FE-fires under d4rt

The interpreter's `visitSwitchStatement` matches each
`SSwitchCase` by evaluating the case expression and probing both
directions:

```dart
if (switchValue == caseValue ||
    (caseValue != null && caseValue == switchValue)) {
  matched = true;
  execute = true;
}
```

The Cluster-26 comment alongside the probe acknowledges that
"the native enum / BridgedEnumValue boundary is asymmetric." In
practice, for some bridged enum values neither direction returns
true at the case-statement boundary, even though the same
expression `p == TargetPlatform.android` evaluates correctly when
written outside a switch (`_isCupertinoFamily` in
`foundation/target_platform_test.dart` uses exactly this `==`
form and works). Result: every case is skipped, the function
falls through without executing any return, and the implicit
return value is `null` — which surfaces downstream as
`Native error during default bridged constructor for 'Text': … "data": expected String, got Null`.

The mismatch only manifests for `case <BridgedEnum>.value:` forms
specifically. Pattern cases (`SSwitchPatternCase`) and `==` in
plain expressions both work — only legacy switch case statements
exhibit the asymmetry.

### Why we are not fixing this in cluster scope

A real fix would patch the bridged-enum equality probe inside
`visitSwitchStatement` (mirror in both `tom_d4rt` and
`tom_d4rt_ast`). The existing Cluster-26 comment shows that the
asymmetry is recognised and partly defended against — the
single-side `caseValue == switchValue` probe was added there for
exactly this reason. Hardening it further (e.g. unwrapping
`BridgedInstance` operands and comparing native enum identities
directly) is a small change in principle, but:

- It requires landing in two interpreters in lock-step
  (`tom_d4rt`, `tom_d4rt_ast`).
- It needs full regression — switch-equality is reused for every
  type, not just enums, so a regression risk reaches every
  script that uses any switch.
- The flutter-material script corpus already prefers the
  if/else form (`_isCupertinoFamily` proves it), so the
  script-side path is uncomplicated and produces fewer surprises
  for future contributors.
- The cluster description in
  `testlog_20260503-0948-issue-analysis/error_analysis.md`
  explicitly suggests a script-side or interpreter null-check —
  i.e. a script-side rewrite is acceptable.

### Script-side workaround

For each affected helper, convert `switch (e) { case A: …; case B: …; }`
to an `if/else` chain over `==` and add a final `return` that
covers the theoretically unreachable case (Dart's exhaustiveness
checker stays satisfied; the d4rt fall-through path now hits the
default instead of returning null):

```dart
String _platformOs(TargetPlatform p) {
  if (p == TargetPlatform.android) return 'Android';
  if (p == TargetPlatform.iOS) return 'iOS / iPadOS';
  if (p == TargetPlatform.fuchsia) return 'Fuchsia';
  if (p == TargetPlatform.linux) return 'Linux desktop';
  if (p == TargetPlatform.macOS) return 'macOS';
  if (p == TargetPlatform.windows) return 'Windows';
  return p.name; // unreachable on real Dart; safety net for d4rt
}
```

For `String note;`-style declared-but-unassigned variables fed
by a switch (`tooltip_window_controller_delegate_test.dart`
`_PlatformNotesSection.build`), seed the variable with the
default branch's text and let the `if/else` chain overwrite it
when a more specific branch matches:

```dart
String note = 'On ${p.name}, real tooltip windows … (default branch text)';
if (p == TargetPlatform.macOS) note = '…macOS-specific…';
else if (p == TargetPlatform.windows) note = '…Windows-specific…';
else if (p == TargetPlatform.linux) note = '…Linux-specific…';
```

### Verification

Per regression rule (a) in the cluster fix protocol — script-only
changes need only individual retests, no full essential /
important / secondary regression suite:

| Script | Driver | Result |
|--------|--------|--------|
| `widgets/tooltip_window_controller_delegate_test.dart` | `tom_d4rt_flutter_ast` | **PASS** (was the gii failure in §2.2) |
| `widgets/tooltip_window_controller_delegate_test.dart` | `tom_d4rt_flutter_test` | **PASS** |
| `foundation/target_platform_test.dart` | `tom_d4rt_flutter_ast` | **PASS** (was the hr1 failure in §2.3) |
| `foundation/target_platform_test.dart` | `tom_d4rt_flutter_test` | **PASS** |
| `material/time_of_day_format_test.dart` | `tom_d4rt_flutter_ast` | **PASS** (was the hr2 failure in §2.4) |
| `material/time_of_day_format_test.dart` | `tom_d4rt_flutter_test` | **PASS** |

Captured in
`tom_d4rt_flutter_test/doc/testlog_20260503-0948-issue-analysis/cluster4_individual/`.

### Re-opening trigger

Any of:

- A planned interpreter pass that rewrites the bridged-enum
  case-match probe in `visitSwitchStatement` to unwrap
  `BridgedInstance` operands and compare native enum identities
  directly. Mirror in `tom_d4rt` and `tom_d4rt_ast`.
- A new test script in the corpus that uses `switch
  (BridgedEnum)` with side-effects in the case bodies (i.e.
  cannot easily be rewritten as a pure `if/else` returning a
  String).

---

## G1 — `D4.getNamedArgWithDefault<T?>` collapses explicit `null` to default for nullable-typed named args

**Source cluster:** `testlog_20260503-2009-issue-analysis`
cluster **C1 — Cupertino minLines/maxLines assertion** (essential
`cupertino/textfield_test.dart`, hardly_1
`cupertino/cupertino_text_selection_handle_controls_test.dart`).

**Status:** ✅ **RESOLVED at the helper level (2026-05-04).** The
two-branch fix proposed below was applied to both
`tom_d4rt/lib/src/generator/d4.dart` and
`tom_d4rt_ast/lib/src/runtime/generator/d4.dart`. The script-side
workaround has been reverted — the two Cupertino scripts now use
the original `maxLines: null` form again and pass.

### Symptom

Both Cupertino scripts authored deep-demos that paired
`maxLines: null` (Flutter's "grow without bound" sentinel) with
`minLines: N` (N ≥ 2). Stock Flutter accepts this combination —
the constructor assertion is

```dart
// flutter/lib/src/cupertino/text_field.dart:310-320
assert(
  (maxLines == null) || (minLines == null) || (maxLines >= minLines),
  'minLines can\'t be greater than maxLines',
);
```

— so passing `maxLines: null` short-circuits the assertion. Under
d4rt the assertion fires:

```
Native error during default bridged constructor for
'CupertinoTextField': 'package:flutter/src/cupertino/text_field.dart':
Failed assertion: line 320 pos 10: '(maxLines == null) ||
(minLines == null) || (maxLines >= minLines)':
minLines can't be greater than maxLines
```

— because by the time the assertion runs, `maxLines` is **`1`**
(the constructor's default), not the `null` the script passed.

### Root cause

The generated `cupertino_bridges.b.dart` constructor adapter for
`CupertinoTextField` resolves `maxLines` via:

```dart
final maxLines = D4.getNamedArgWithDefault<int?>(named, 'maxLines', 1);
```

where `D4.getNamedArgWithDefault` is defined in both
`tom_d4rt/lib/src/generator/d4.dart` (≈line 1590) and
`tom_d4rt_ast/lib/src/runtime/generator/d4.dart` (≈line 1634) as:

```dart
static T getNamedArgWithDefault<T>(
  Map<String, Object?> named,
  String paramName,
  T defaultValue,
) {
  if (!named.containsKey(paramName) || named[paramName] == null) {
    return defaultValue;
  }
  return extractBridgedArg<T>(named[paramName], paramName);
}
```

The guard `!named.containsKey(paramName) || named[paramName] == null`
**conflates two semantically distinct cases**:

1. The caller did not pass the named arg (key absent) — fall back
   to the bridge-supplied default.
2. The caller explicitly passed `null` (key present, value
   `null`) — keep `null`.

For nullable-typed parameters (`T = int?`, `T = double?`,
`T = String?`, …), case (2) is the user's deliberate signal. The
helper silently rewrites it back to (1), erasing the distinction
between "I want the framework's default" and "I want the
explicit-null sentinel".

`CupertinoTextField` is the noisy surface because Flutter encodes
"grow without bound" as the explicit-null sentinel and pairs it
with an assertion that depends on it.

### Resolution applied (2026-05-04)

The helper's single guard was replaced with two branches in both
`tom_d4rt/lib/src/generator/d4.dart` and
`tom_d4rt_ast/lib/src/runtime/generator/d4.dart`:

```dart
static T getNamedArgWithDefault<T>(
  Map<String, Object?> named,
  String paramName,
  T defaultValue,
) {
  if (!named.containsKey(paramName)) return defaultValue;
  final raw = named[paramName];
  if (raw == null) {
    // Explicit null is the caller's intent; only fall back to the
    // default when T is non-nullable, since extractBridgedArg<T>
    // would throw on null in that case.
    return null is T ? null as T : defaultValue;
  }
  return extractBridgedArg<T>(raw, paramName);
}
```

Rationale:

- `null is T` is true iff `T` accepts null. For nullable type
  parameters (`int?`, `Widget?`, `SpellCheckService?`, …) the
  helper now preserves the script's explicit-null intent; for
  non-nullable type parameters it still falls back to the
  bridge-supplied default (an explicit null on a non-nullable
  param is treated as an omission — `extractBridgedArg<T>` would
  otherwise throw on null).
- The helper is mirrored in both `tom_d4rt` and `tom_d4rt_ast`
  per the quest's "keep tom_d4rt ↔ tom_d4rt_ast in sync" rule.

### Script-side workaround (no longer required)

Historically the closing path for this cluster was to replace
`maxLines: null` with a finite cap. **As of 2026-05-04 this is no
longer necessary** — the helper now honours explicit-null. The two
Cupertino scripts have been reverted to use `maxLines: null`
again. The captured workaround text below is kept for history.

```dart
// reverted form — explicit-null is now honoured by the helper
CupertinoTextField(
  controller: _ctrl,
  maxLines: null,
  minLines: 4,
  // …
)
```

### Verification

The runtime helper is called from every generated `*.b.dart`
constructor adapter across the entire `flutter-material` corpus.
Per regression rule (b) in the cluster fix protocol —
interpreter/runtime change requires the individual scripts plus
the essential, important, and secondary suites:

| Script | Driver | Result |
|--------|--------|--------|
| `cupertino/textfield_test.dart` (individual, reverted form) | `tom_d4rt_flutter_test` | ✅ pass (`testlog_20260504-g1fix-verify/textfield_individual.*`) |
| `cupertino/cupertino_text_selection_handle_controls_test.dart` (individual, reverted form) | `tom_d4rt_flutter_test` | ✅ pass (`testlog_20260504-g1fix-verify/handle_controls_individual.*`) |
| `essential_classes_test.dart` | `tom_d4rt_flutter_test` | ✅ 108/108 pass |
| `important_classes_test.dart` | `tom_d4rt_flutter_test` | ✅ 164/164 pass |
| `secondary_classes_test.dart` | `tom_d4rt_flutter_test` | ✅ 653 pass / 1 skip |

### Re-opening trigger

The bug is closed. A re-open would only be triggered by a future
finding that the new helper semantics break a different bridge
adapter that genuinely relies on the old "null → default"
coalescing. Such a case must surface in the regression suites
captured at fix time; if it appears later, raise a new bug rather
than re-opening §G1.

---

## R1 — Redirecting factory constructor syntax (`factory X() = Y`) not implemented

### What the script does

Flutter's modern public API for `RegularWindowController` (and a
growing number of other framework classes) uses the **redirecting
factory constructor** form to keep a clean public abstract type
while delegating instantiation to a private host implementation:

```dart
abstract class RegularWindowController extends ChangeNotifier {
  // Redirecting factory: `RegularWindowController(...)` forwards to
  // `_HostRegularWindowController(...)` at the language level — no
  // body, no `return`, just `=`.
  factory RegularWindowController({
    Size? preferredSize,
    Offset? preferredPosition,
    String? title,
    BoxConstraints? preferredConstraints,
    bool isActivated = true,
  }) = _HostRegularWindowController;

  // ... abstract API surface ...
}

class _HostRegularWindowController extends RegularWindowController {
  _HostRegularWindowController({...}) : super._();
  // ... concrete implementation ...
}
```

Call sites then look like:

```dart
final RegularWindowController controller = RegularWindowController(
  preferredSize: const Size(640, 280),
  title: 'Regular Window Demo',
);
```

This is the same pattern Flutter uses for many factory-bound types
(`Map`, `Set`, `List` historically; modern window/desktop APIs;
material `Color` factories with platform fallbacks). The Dart
analyzer lowers the abstract-class `factory X(...) = Y;` form into
a forwarding call to the redirected concrete constructor, so the
runtime sees `Y(...)` even though the source wrote `X(...)`.

### Why it FE-fires under d4rt

The d4rt interpreter does not implement the redirecting-factory
`=` form. Concretely:

- `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` only
  honours `redirectedConstructor` in the **enum** declaration path
  (around line 8895), where it throws an `UnimplementedD4rtException`
  for redirected enum constructors. There is no class-level
  handling.
- `tom_d4rt_ast/lib/src/runtime/callable.dart` (lines ~1010-1075)
  handles `SRedirectingConstructorInvocation` — but that node
  type represents only the **initializer-list** redirect form
  (`MyClass.alt() : this(arg);`), not the **factory** redirect
  form (`factory MyClass() = Other;`).
- When the interpreter encounters
  `RegularWindowController(preferredSize: …)`, it resolves the
  identifier to the abstract class, finds no concrete
  constructor body to execute, and throws `Cannot instantiate
  abstract class 'RegularWindowController'`. The redirected target
  `_HostRegularWindowController` is never consulted.

The same limitation applies to any abstract class that exposes its
public constructor purely as a redirecting factory; scripts
calling the abstract name directly will all fail this way.

### Why we are not fixing this in cluster scope

Implementing redirecting factory constructors correctly requires:

1. A new AST node (or extension of the existing factory-constructor
   node) carrying the `redirectedConstructor` reference at class
   level.
2. `tom_ast_generator` changes to copy the analyzer's
   `redirectedConstructor` field into the mirror AST.
3. Interpreter dispatch logic that, when a constructor invocation
   resolves to a redirecting factory, looks up the redirected
   target (potentially in another library), substitutes the type
   arguments, and forwards the original arguments — including
   handling chains of redirects and constructor-name forms
   (`= Y.named`).
4. Mirror in `tom_d4rt` (analyzer-based) ↔ `tom_d4rt_ast`
   (mirror-AST) so both drivers behave identically.
5. A regression-coordinated pass through essential + important +
   secondary + gii to surface secondary-effect call sites — the
   current corpus has at least one (`RegularWindowController`),
   and the SDK uses this form widely so silent forwarding could
   produce surprising aliasing in unrelated tests.

That is a multi-day interpreter feature, not a cluster-scope fix.

### Script-side workaround (functional equivalent)

Replace the abstract-class call with a direct instantiation of the
concrete redirected subclass, while keeping the variable type as
the abstract base so the rest of the script still exercises the
public API:

```dart
// BEFORE — relies on redirecting factory:
final RegularWindowController _primaryController =
    RegularWindowController(
  preferredSize: const Size(640, 280),
  title: 'Regular Window Demo',
);

// AFTER — direct concrete instantiation, abstract type preserved:
//
// d4rt INTERPRETER NOTE: the interpreter does not implement the
// redirecting factory constructor syntax
// (`factory RegularWindowController(...) = _HostRegularWindowController;`
// on the abstract class above). When the script writes
// `RegularWindowController(...)`, d4rt sees the abstract class and
// throws `Cannot instantiate abstract class
// 'RegularWindowController'` instead of forwarding to the
// redirected concrete constructor. Therefore the live call sites
// instantiate the concrete `_HostRegularWindowController` directly
// while the variable types remain the abstract
// `RegularWindowController`, preserving SDK-shape fidelity.
final RegularWindowController _primaryController =
    _HostRegularWindowController(
  preferredSize: const Size(640, 280),
  title: 'Regular Window Demo',
);
```

This is **functionally identical** to the redirected call: the
analyzer would have lowered the original to exactly this. The
abstract base type continues to drive all subsequent code (method
calls, listener wiring, the `RegularWindowController` API
contract), so the rest of the script remains unchanged.

### Verification

- Individual flutter test on
  `widgets/regular_window_test.dart` after the rewrite:
  `+1: All tests passed!` (status=success, httpStatus=200,
  frameworkErrors=0, bundleJsonBytes≈917 KB).
- `dart analyze` on `tom_d4rt_flutter_ast` after the edit: clean.

### Re-opening trigger

Any of:

- A planned interpreter pass that implements redirecting factory
  constructors at class scope (mirror across `tom_d4rt` ↔
  `tom_d4rt_ast`, with the AST + astgen changes outlined above and
  a regression-coordinated essential + important + secondary + gii
  sweep).
- A script that genuinely depends on the abstract-name
  instantiation being observable through reflection (e.g. asserts
  `runtimeType == RegularWindowController` rather than the
  concrete subclass). The current rewrite preserves the **static**
  type but the **runtime** type is the concrete subclass — same
  behaviour as the analyzer's lowered output, so this is not
  actually a divergence from native Flutter.

---

## L1 — `AnimatedBuilder.animation` rejects script-defined subclass of bridged `Listenable`/`ChangeNotifier` (RESOLVED 2026-05-10)

> **Status: resolved** — the architectural gap described below is
> closed by registering a `ChangeNotifier` / `Listenable` interface
> proxy in `d4rt_runtime_registrations.dart` (both
> `tom_d4rt_flutter_ast` and `tom_d4rt_flutter_test`). The
> script-side workaround in
> `widgets/windowing_owner_mac_o_s_test.dart` was reverted; the
> two layout fixes (`_DockTile` overflow, `_ContentArea` badge
> overflow) that were necessary follow-ups remain. This entry is
> kept for historical context — see "Resolution" below for the
> final design.

### What the script does

Flutter's `AnimatedBuilder` accepts any `Listenable` as its
`animation:` argument; the most common pattern in larger demos is
to subclass `ChangeNotifier` from a script and pass `this` so the
builder rebuilds whenever the controller fires `notifyListeners()`:

```dart
abstract class BaseWindowController extends ChangeNotifier {
  // ... abstract API ...
}

abstract class RegularWindowController extends BaseWindowController { … }

class RegularWindowControllerMacOS extends RegularWindowController {
  // concrete impl with notifyListeners() in setters
}

// Caller:
return AnimatedBuilder(
  animation: controller, // ← controller : RegularWindowControllerMacOS
  builder: (BuildContext context, Widget? _) {
    return Text(controller.title);
  },
);
```

This is the canonical "use a `ChangeNotifier` subclass as the
`Listenable` for an `AnimatedBuilder`" Flutter recipe. It works in
native Flutter because `RegularWindowControllerMacOS extends
ChangeNotifier`, and `ChangeNotifier implements Listenable`, so the
script-defined class is statically and dynamically a `Listenable`.

The trigger appeared in
`testlog_20260503-2009-issue-analysis/error_analysis.md` cluster
**C2** for `widgets/windowing_owner_mac_o_s_test.dart`, with 11
failure events of:

```
Native error during default bridged constructor for 'AnimatedBuilder':
Argument Error: Invalid parameter "animation":
expected Listenable, got InterpretedInstance(RegularWindowControllerMacOS)
```

The same family of errors hit any script that authors a
`ChangeNotifier`-based controller and hands it to a bridged Flutter
type whose constructor parameter is typed `Listenable` (or
`Animation<T>`, or anything in that hierarchy).

### Why it FE-fired under d4rt

The bridge generator emits the `AnimatedBuilder` constructor
adapter with a typed coercion for `animation`:

```dart
final animation = D4.getRequiredNamedArg<Listenable>(
    named, 'animation', 'AnimatedBuilder');
```

`getRequiredNamedArg<T>` delegates to `D4.extractBridgedArg<T>`
which, for an `InterpretedInstance` argument, walks (1) the cached
`nativeProxy`, (2) `bridgedSuperObject`, (3) registered generic
wrapper factories, (4) registered **interface proxy factories**
(`tryCreateInterfaceProxyWithVisitor<T>`). The proxy walk collects
candidate names from the InterpretedClass's `bridgedSuperclass`,
`bridgedInterfaces`, `bridgedMixins` (recursively, via
interpreted `superclass`/`mixins`/`interfaces`) plus
`BridgedClass.transitiveSupertypeNames`. For
`RegularWindowControllerMacOS extends RegularWindowController
extends BaseWindowController extends ChangeNotifier`, the candidate
list reaches `ChangeNotifier` and `Listenable` correctly.

The gap was simply that **no proxy factory was registered** for
`'ChangeNotifier'` or `'Listenable'`. The walk therefore returned
null and `extractBridgedArg` fell through to its terminal throw.

### Resolution (2026-05-10)

Both `ChangeNotifier` and `Listenable` are now registered in
`_registerInterfaceProxies()` (same code in both
`tom_d4rt_flutter_ast` and `tom_d4rt_flutter_test` so the
analyzer-free and analyzer-based variants behave identically):

```dart
D4.registerInterfaceProxy('ChangeNotifier', (visitor, instance) {
  final bridgedSuper = instance.bridgedSuperObject;
  if (bridgedSuper is ChangeNotifier) return bridgedSuper;
  final cached = instance.nativeProxy;
  if (cached is ChangeNotifier) return cached;
  final proxy = ChangeNotifier();
  instance.nativeProxy ??= proxy;
  return proxy;
});
D4.registerInterfaceProxy('Listenable', (visitor, instance) {
  final bridgedSuper = instance.bridgedSuperObject;
  if (bridgedSuper is Listenable) return bridgedSuper;
  final cached = instance.nativeProxy;
  if (cached is Listenable) return cached;
  final proxy = ChangeNotifier();
  instance.nativeProxy ??= proxy;
  return proxy;
});
```

Why this works without any generator change:

1. **No new wrapper allocation in the common case.** When a script
   class declares `extends ChangeNotifier` (with or without an
   explicit constructor that calls `super()`), the interpreter
   already invokes the bridged `ChangeNotifier` default constructor
   and stores the resulting native `ChangeNotifier()` on
   `instance.bridgedSuperObject`
   (`tom_d4rt_ast/lib/src/runtime/runtime_types.dart` Path B,
   `callable.dart` explicit-super paths).
2. **Listener contract is preserved end-to-end.** Bridged-super
   method dispatch on the InterpretedInstance routes through
   `bridgedSuperObject ?? nativeProxy`
   (`runtime_types.dart` line 1319), so:
    - Flutter widgets call `proxy.addListener(_handleChange)` →
      native `ChangeNotifier.addListener` registers the listener
      on the same instance the proxy returned.
    - Script code calls `controller.notifyListeners()` → resolves
      to the bridged `ChangeNotifier.notifyListeners` adapter,
      which forwards to `bridgedSuperObject.notifyListeners()` —
      the same `ChangeNotifier` the listener was registered on.
   Identity is preserved, the listener fires, and the AnimatedBuilder
   rebuild path works.
3. **Fallback for `implements Listenable` (no bridged super).**
   When `bridgedSuperObject` is null, allocate a fresh
   `ChangeNotifier()` lazily and cache on `nativeProxy`. Bridged
   dispatch's `bridgedSuperObject ?? nativeProxy` then routes
   `notifyListeners()` calls through the same instance. Pure
   `implements Listenable` script classes that define their own
   `addListener`/`notifyListeners` without ever delegating to a
   bridged method are not covered by this fallback — that's a
   separate, narrower limitation.

### Verification

- Individual retest:
  `flutter test test/generator_interpreter_issues_test.dart
  --plain-name "windowing_owner_mac_o_s"` →
  `+1: All tests passed!` (status=success, frameworkErrors=0,
  sourceChars=99640).
- The script-side workaround at
  `_MacChrome.build()` (line 810) and `_DockTile.build()`
  (line 2622) was reverted: `animation: const
  AlwaysStoppedAnimation<double>(0.0)` → `animation: controller`.
- The `_DockTile` and `_ContentArea` layout fixes from the
  workaround commit (gradient/font/padding shrink, badge `Wrap`
  wrapped in `Expanded(SingleChildScrollView)`) remain in place —
  those are real layout bugs that surfaced once `AnimatedBuilder`
  builds actually completed and are not specific to d4rt.
- Per regression rule (b) — change outside `test/` — the
  fix was followed by an essential + important + secondary
  classes serial sweep before commit. Results recorded in the
  resolution commit message.

### Why this is **not** in the proxy generator

Earlier analysis assumed this needed a generator-side template that
emits `ChangeNotifier`-backed proxy classes per bridged
`ChangeNotifier` subclass. That assumption was wrong: the existing
runtime infrastructure (proxy registry + `bridgedSuperObject`
backing + bridged-super method dispatch fallback) already covers
the listener contract correctly when the candidate name is known to
the registry. Two factory registrations are sufficient — the
generator doesn't need to know about ChangeNotifier semantics at
all. This keeps the generator simple and the fix narrowly scoped.

---

## T1 — `runtimeType.toString()` on user-defined interpreted classes

### Symptom

```text
Runtime Error: Class '_DemoRouteTransitionRecord' has no static
method or named constructor named 'toString'.
```

Surfaces wherever a script reads `someInstance.runtimeType` and
then calls `.toString()` on the result, e.g. for diagnostic
labels:

```dart
final String runtime = record.runtimeType.toString();
```

### Diagnosis

For native Dart objects, `Object.runtimeType` returns a `Type`
instance whose `toString()` is the class name. The d4rt
interpreter, however, returns the interpreted class itself
(`InterpretedClass`) as the `runtimeType` of an
`InterpretedInstance`. `InterpretedClass.toString` is not
exposed as a callable member, so the chained `.toString()`
invocation looks up a static method named `toString` on the class
and throws `no static method or named constructor named
'toString'`.

The same construct works on bridged native classes because their
`runtimeType` resolves to a real `Type` whose `toString()` lives on
the native side.

### Workaround (script-side)

Emit the class-name string manually using `is` checks against the
expected concrete subclass:

```dart
final String runtime = record is _DemoRouteTransitionRecord
    ? '_DemoRouteTransitionRecord'
    : 'RouteTransitionRecord';
```

For diagnostic-only contexts (logging, debug labels), this is
purely cosmetic and behavioural-equivalent. If a script actually
needs to dispatch on runtime type, use a `switch (record) {
case _Foo(): ... }` pattern instead.

### Architectural fix (deferred)

`InterpreterVisitor` should expose `toString` (and the rest of
`Object`'s universal members) when the `runtimeType` of an
`InterpretedInstance` is dereferenced. The cleanest path is to
return a `Type`-shaped façade with `toString()` defined to return
`InterpretedClass.name`, mirroring what GEN-094 did for
universal `Object` members on instances. Mirror the change in
`tom_d4rt` and `tom_d4rt_ast` per the sync rule.

---

## I1 — C-style for loop shares loop variable across closures (interpreter limitation)

### Symptom

A C-style `for (var i = 0; i < n; i++)` whose body builds widgets
that close over `i` (e.g. inside DragTarget callbacks, ListTile
`onTap`, etc.) crashes with `Index out of range: <n>` when those
closures fire after layout. The most direct repro is

```dart
Row(
  children: [
    for (var i = 0; i < rankSlots.length; i++)
      DragTarget<int>(
        builder: (ctx, _, __) => Text(rankSlots[i]?.toString() ?? '—'),
      ),
  ],
)
```

— five DragTarget builders are constructed during the for-loop, but
when Flutter calls the `builder` lambdas during the next paint the
captured `i` is `5` for every one of them, and `rankSlots[i]`
throws.

### Root cause

`InterpreterVisitor._executeClassicFor`
(`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` ~line
5396) creates **one** `loopEnvironment` *before* entering the
while-loop and reuses it for every iteration. The standard Dart
spec instead requires the loop variable to be allocated *per
iteration* so that each closure captures a fresh binding (the
practical effect that any post-ES6/Dart-2 programmer relies on).
Because d4rt's loop env is a single shared env, every closure
captures the same `i` cell, and after the loop ends that cell holds
`n`.

The mirror `tom_d4rt/.../interpreter_visitor.dart` has the same
shape, so the analyzer-based interpreter has the identical
behaviour.

A correct fix would, on each iteration:

1. Snapshot the loop variables' current values.
2. Open a fresh `Environment` rooted in the loop's outer scope,
   re-define the loop-variable names with the snapshot values, and
   execute the body inside that env (so closures created in the
   body capture the fresh env).
3. After the body, copy the variables back into the persistent
   loop env so updaters and the next condition check observe any
   in-body mutations.

The change is small but touches a hot path; mirroring it across
both interpreters and re-running the full essential / important /
secondary suites is the price of admission. The work is queued —
deferred from this cluster because the script-side rewrite is one
line per call site and unblocks the corpus immediately.

### Script-side workaround

Replace the collection-`for` / body-less for-loop with
`List<T>.generate`, which calls the builder with `i` as a function
parameter — each invocation has its own parameter binding, which
the interpreter handles correctly.

```dart
Row(
  children: List<Widget>.generate(rankSlots.length, (int i) {
    return DragTarget<int>(
      builder: (ctx, _, __) => Text(rankSlots[i]?.toString() ?? '—'),
    );
  }),
)
```

`List.generate` sidesteps `_executeClassicFor` entirely (the
builder runs once per index inside the bridged `List.generate`
implementation, and its parameter env is fresh per call).

### Affected scripts

| Script | Site | FE before | FE after |
|---|---|---:|---:|
| `widgets/drag_target_details_test.dart` | Section 11 (`_buildRankSlots`) | 5 | 0 |

### Future fix path

Land per-iteration capture in `_executeClassicFor` in both
`tom_d4rt` and `tom_d4rt_ast`, regenerate bridges, run the four
suites. Once landed, the script-side `List.generate` rewrite can
revert to the original `for` form (left in place for now — it is a
valid Dart shape and not a regression).

---

## S1 — `const Stream<T>.empty()` rejected by `Stream` bridge (interpreter limitation)

### Symptom

```
Runtime Error: Bridged class 'Stream' does not have a registered
constructor named 'empty'. Check bridge definition.
```

Surfaces from `tom_d4rt`'s
`InterpreterVisitor.visitInstanceCreationExpression` (line ~9275) when
the script contains:

```dart
final liveStreamBuilder = StreamBuilder<int>(
  stream: const Stream<int>.empty(),    // <— shape that triggers it
  initialData: 42,
  builder: (BuildContext ctx, AsyncSnapshot<int> snap) { … },
);
```

### Root cause

The stdlib `Stream` bridge in
`tom_d4rt/lib/src/stdlib/async/stream.dart` (and the mirror in
`tom_d4rt_ast/lib/src/runtime/stdlib/async/stream.dart`) registers the
factory constructors under `staticMethods`, not `constructors`:

```dart
static BridgedClass get definition => BridgedClass(
      nativeType: Stream,
      name: 'Stream',
      typeParameterCount: 1,
      …
      constructors: {},                // ← empty
      staticMethods: {
        'value': (visitor, …) { … },
        'empty': (visitor, …) { … },   // ← lives here
        'fromIterable': (visitor, …) { … },
        …
      },
      …
    );
```

The interpreter has two entry points that can resolve `Stream.empty()`:

1. `visitMethodInvocation` (path used when the call parses as a
   `MethodInvocation`). It first tries `findConstructorAdapter`,
   then **falls through to `staticMethods`**.
2. `visitInstanceCreationExpression` (path used when the call parses
   as `InstanceCreationExpression`). It tries `findConstructorAdapter`
   and throws if the lookup fails. It **does not** fall through to
   `staticMethods`.

**The crucial point:** the Dart analyzer parses *every*
`Stream.factoryName(...)` form as `InstanceCreationExpression` —
because `Stream.empty`, `Stream.value`, `Stream.fromIterable`, … are
*named constructors* in the real `dart:async` `Stream` class, even
though the d4rt bridge happens to register them as `staticMethods`.
This applies to:

- `const Stream<int>.empty()` — InstanceCreationExpression (const + type-args)
- `Stream<int>.empty()` — InstanceCreationExpression (type-args)
- `Stream.empty()` — InstanceCreationExpression (named ctor of Stream)
- `Stream<int>.fromIterable(const <int>[])` — InstanceCreationExpression
- `Stream.fromIterable(<int>[])` — InstanceCreationExpression

In every case `findConstructorAdapter('empty')` /
`findConstructorAdapter('fromIterable')` returns `null` (the bridge's
`constructors:` map is empty), and the interpreter throws.

### Why this is "unfixable" without a behavioural deviation

- The split between `constructors:` and `staticMethods:` is the
  canonical bridge-shape for `Stream` (and `Iterable.empty`,
  `List.empty`, `StackTrace.empty`, …): the d4rt API treats them as
  static factories so they share dispatch with `Stream.value(...)` and
  `Stream.fromFuture(...)` which are not constructors in the dart:async
  source either. Re-routing them to `constructors:` would couple their
  dispatch path to constructor semantics (instance creation, `const`
  evaluation, type-argument propagation) that don't apply to a static
  factory.
- Patching `visitInstanceCreationExpression` to fall through to
  `staticMethods` for `BridgedClass` targets is technically possible
  but changes the meaning of `new`/`const` for every bridge — code
  written against the canonical Dart semantics (where a static method
  with the same name as a non-existent constructor is a static-call,
  not a constructor-call) would silently start succeeding.
- Adding a special case for `Stream` (and the handful of other stdlib
  classes with this shape) is a bridge-side patch that has to live in
  every downstream interpreter; the script-side workaround is one line
  per call site and uses a Dart shape that is already idiomatic.

### Workaround

Because every `Stream.factory(...)` shape in source code parses as
`InstanceCreationExpression` (see "Root cause"), there is no
script-side incantation of `Stream.empty` / `Stream.fromIterable` /
… that hits the `MethodInvocation` fall-through. The two real
options are:

**1. Pass `null` if the consumer is `Stream<T>?`-nullable.**
`StreamBuilder.stream` is declared `Stream<T>? stream` and accepts
`null`, which exercises the `initialData` / "no live stream" code
path without constructing a Stream at all:

```dart
// instead of:
//   stream: const Stream<int>.empty(),
stream: null,
```

This is the smallest, most idiomatic change for `StreamBuilder`.

**2. Build the stream from a non-named-constructor source.**
Use `StreamController` (default constructor — registered under
`constructors:`) or transform a future:

```dart
final ctrl = StreamController<int>();
ctrl.close();              // immediately-closed empty stream
final emptyStream = ctrl.stream;
…
stream: emptyStream,
```

Both give an empty, single-subscription `Stream<int>` that never
emits.

**Workarounds that look right but DO NOT WORK** (all parse as
`InstanceCreationExpression` and hit the same `findConstructorAdapter`
miss):

```dart
stream: Stream<int>.empty(),                   // ← still IC-expr (named ctor of Stream)
stream: Stream.empty(),                         // ← still IC-expr (named ctor of Stream)
stream: Stream<int>.fromIterable(const <int>[]),// ← still IC-expr
stream: Stream.fromIterable(<int>[]),           // ← still IC-expr
final s = Stream<int>.empty(); …; stream: s,    // ← RHS is still IC-expr
```

### Affected scripts

| Script | Site |
|--------|------|
| `tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/widgets/streambuilder_test.dart` | Section 6 — `stream: const Stream<int>.empty()` (line ≈ 758, rewritten in commit `5dc78999` "test(flutter_ast): hand-author Batch 2 deep demos") |

### What a real fix would look like

Land a single combined-lookup helper on `BridgedClass` (call it
`findStaticOrConstructor(name)`) that first tries `constructors[name]`
and then `staticMethods[name]`, and route both
`visitMethodInvocation` and `visitInstanceCreationExpression` through
it. Mirror in `tom_d4rt_ast`. Migrate the existing duplicated
fall-through in `visitMethodInvocation` to the helper. Audit all
stdlib bridges that register factories as `staticMethods`
(`Stream.empty/value/fromIterable/…`, `Iterable.empty`, `List.empty`,
`Map.fromIterable/from/of`, `Set.from/of`, `StackTrace.empty`,
`StreamController.broadcast` if present) so the `const`/`new`-shaped
call site reaches them. Out of scope for the priority-1 cluster; the
script-side workaround above is the closure for now.

---

## U1 — Demo-scale renderings that overload the test-app transport (interpreter limitation)

### Symptom

The Flutter test app crashes mid-run with:

```
Bad state: Transport failure
Lost connection to device.
```

No interpreter stack, no analyzer error, no framework exception
surfaces — the app process simply detaches from the HTTP transport
mid-execution and the test fails as
`status=transport_failure`. From `flutter test`'s point of view the
device just disconnected.

Reproduces deterministically on
`widgets/notificationlistener_test.dart` (C05 in
`testlog_20260517-0914`) and on both drivers
(`tom_d4rt_flutter_ast`, `tom_d4rt_flutter_test`).

### Root cause

The C05 demo combined two independently-fatal shapes:

1. **Top-level `const` of an interpreted subclass of a native
   abstract class** — the script declared
   `class _PrivateScoreNotification extends Notification` (where
   `Notification` is the *native* abstract class from
   `package:flutter/widgets.dart`) and instantiated three
   top-level `const _PrivateScoreNotification(...)` values during
   the script's static initialization. The interpreter does
   support interpreted subclasses of native abstract classes via
   adapter proxies (see *Abstract Class Inheritance*), but the
   adapter-proxy infrastructure is intended for *instance*
   construction inside `build()`/lifecycle methods; running it
   during the top-level constant-evaluation phase, before the
   interpreter has wired up its full visitor context, causes the
   process to terminate before any error gets serialised over the
   transport.

2. **A very large `SelectableText.rich` TextSpan tree built
   per-character by an interpreted colorizer** — the demo had a
   `_privateCodeBlock(String code)` helper that ran
   `_privateColorizeDart(code)` to produce a `List<TextSpan>` one
   character at a time (each non-keyword/non-string char became
   its own `TextSpan(text: c)`), then fed the list into
   `SelectableText.rich(TextSpan(children: spans))`. For most
   sections (≤500 chars / ≤22 lines of code) this works fine. The
   "mini recipe" code listing in Section 7 was ~1.8 KB / ~58
   lines, producing roughly 1000+ TextSpan objects. Rendering it
   exhausts whatever the transport budget is and the app
   disconnects without surfacing an error.

Both sub-cases were confirmed by bisection on `build()`'s child
list (`ztmp/c05_repro.log.txt`,
`ztmp/c05_bisect_s7_only.log.txt`,
`ztmp/c05_ast_fixed.log.txt`). Removing either sub-case alone is
not enough; both must be neutralised.

### Why this is interpreter-limitation rather than "truly unfixable"

- The native-abstract-subclass-at-top-level-const case is a real
  blind spot in the adapter-proxy initialisation order. A
  long-term fix would land in `tom_d4rt` and `tom_d4rt_ast` by
  hoisting the proxy registration into the
  `DeclarationVisitor`'s pre-pass so that any top-level
  `const`-evaluated interpreted subclass of a native abstract
  class has a working proxy ready before constant evaluation
  begins. This is a non-trivial cross-cutting change (mirrors,
  abstract-class scanner, proxy wiring) and not in scope for the
  C05 cluster.
- The large-TextSpan-tree case is a transport-budget interaction:
  every TextSpan that the interpreter constructs has to be
  serialised through the bridge boundary into a real Flutter
  `TextSpan` object. For ~1000+ spans this exceeds whatever
  per-frame transport budget the test-app is configured for. The
  fix-shaped solution is either bridge-side batching of
  `TextSpan` construction, or a transport-budget bump in the
  test-app HTTP harness; either would be a separate workstream.

### Workaround

Both sub-cases admit a clean script-side rewrite that preserves
the *documentation intent* of the demo:

**1. Don't declare an interpreted subclass of a native abstract
class for a value the demo never actually dispatches.** The
`_PrivateScoreNotification` class was only used for its `score`
and `label` fields displayed in a UI card; nothing ever called
`.dispatch(context)`. Inline the displayed values as top-level
`const` primitives and keep the class definition only in the
*code-listing text* (which is the documentation intent anyway):

```dart
// Don't do (top-level, const, before build()):
//   class _PrivateScoreNotification extends Notification {
//     final int score;
//     final String label;
//     const _PrivateScoreNotification(this.score, {this.label = 'score'});
//     …
//   }
//   const _PrivateScoreNotification _kSampleScoreB =
//       _PrivateScoreNotification(108, label: 'levelB');
//
// Do (inline the displayed values, keep the class only as text):
const int _kSampleScoreBValue = 108;
const String _kSampleScoreBLabel = 'levelB';

// … and in the banner widget:
Text('$_kSampleScoreBValue', …)
Text('label: $_kSampleScoreBLabel', …)
```

**2. Render large code listings with a single plain monospace
`Text` widget, not `SelectableText.rich`-of-many-TextSpans.**
Define a sibling helper that keeps the same dark-card visual
container but skips per-char colorization for snippets above
~1KB / ~25 lines:

```dart
Widget _privatePlainCodeBlock(String code) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: _kPageInkFaint.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: Text(
      code,
      style: TextStyle(
        color: _kCodeFg,
        fontFamily: 'monospace',
        fontSize: 12,
        height: 1.5,
      ),
    ),
  );
}
```

Use `_privateCodeBlock` (the colorized helper) for code listings
of ≲500 chars / ≲22 lines (the size used in Sections 3–6 of the
demo). Use `_privatePlainCodeBlock` (plain Text) for anything
larger.

### Affected scripts

| Script | Sites | Notes |
|--------|-------|-------|
| `widgets/notificationlistener_test.dart` | top-level `_PrivateScoreNotification` class + 3 `const _kSampleScore*` values; Section 7's `_privateCodeBlock(...)` (~1.8 KB recipe) | Both sub-cases neutralised by inlining displayed values and switching Section 7 to `_privatePlainCodeBlock`. C05 closed 2026-05-17 on both drivers. |

### What a real fix would look like

For sub-case (1): in `DeclarationVisitor` (both `tom_d4rt` and
`tom_d4rt_ast`), pre-register adapter proxies for every
interpreted class whose direct or indirect base is a native
abstract class *before* visiting top-level `const`-evaluated
variable declarations. The current dispatch order constructs
proxies on first instantiation inside an evaluated method body,
which is too late for top-level `const` literals.

For sub-case (2): batch
`SelectableText.rich`/`TextSpan(children: …)` transport so the
interpreter ships the full span tree as a single payload rather
than synthesising each `TextSpan` through the bridge boundary
individually. Or raise the test-app per-frame transport budget
to accommodate ≥4000 small object constructions.

---

## U2 — Non-wrappable arithmetic defaults on positional-only native constructors (generator limitation)

### Symptom

Calling a positional-only bridged constructor whose Dart signature
has an arithmetic-expression default value, while passing fewer
positionals than the index of that parameter, throws:

```
Runtime Error: Native error during bridged constructor 'sweep' for class 'Gradient':
Argument Error: Gradient: Parameter "endAngle" has non-wrappable default (math.pi * 2).
Value must be specified but was null.
```

Reproduced in `testlog_20260517-0914` C09 on both drivers
(`tom_d4rt_flutter_ast`, `tom_d4rt_flutter_test`) for
`rendering/gradient_rendering_test.dart` calling
`ui.Gradient.sweep(Offset(...), kRainbow)`.

### Root cause

`BridgeGenerator._wrapDefaultValue`
(`tom_d4rt_generator/lib/src/bridge_generator.dart` lines 4606–4613)
returns `null` for any default expression containing an operator,
because the generator can only inline literal values / simple
named constants and would otherwise have to parse and re-emit the
expression in the generated bridge file. When `_wrapDefaultValue`
returns `null`, the parameter is recorded as a non-wrappable
default and the generated bridge emits, for that positional slot:

```dart
final endAngle = D4.getRequiredArgTodoDefault<double>(
    positional, 5, 'endAngle', 'Gradient', 'math.pi * 2');
```

`getRequiredArgTodoDefault` throws an `ArgumentError` whenever the
positional slot is absent (`positional.length <= 5`) — there is no
fallback to "synthesise the default at runtime" because the
generator could not produce one.

For *named-only* constructors this is mostly cosmetic: callers
that omit the named arg get the same error, but adding the named
arg back is trivial. For **positional-only** native constructors
— `dart:ui` `Gradient.sweep`, `Gradient.radial`, `Gradient.linear`,
several `Path` and `Picture` methods — there is no way to skip the
earlier optional positionals while supplying a later one. Once a
single positional default contains an operator, every call site
must spell out every preceding positional, with the framework's
own default values, all the way up to the operator-bearing index.

Concretely for `Gradient.sweep`:

```dart
external factory Gradient.sweep(
  Offset center,
  List<Color> colors,
  [ List<double>? colorStops,
    TileMode tileMode = TileMode.clamp,    // ← OK (enum constant)
    double startAngle = 0.0,               // ← OK (literal)
    double endAngle = math.pi * 2,         // ← non-wrappable (operator)
    Float64List? matrix4, ]);
```

Calling `Gradient.sweep(center, colors)` works in native Dart
because the engine resolves all four defaults internally. Through
the bridge, the generator can wrap `colorStops` (null literal),
`tileMode` (enum constant), and `startAngle` (numeric literal) — but
fails on `endAngle` because `math.pi * 2` is an arithmetic
expression. The call then throws on the 6th positional even though
the script only intended to supply the 2 mandatory ones.

### Why this is a generator limitation rather than "truly unfixable"

The generator could grow a small evaluator for the limited
shape of arithmetic-default expressions actually used by the
framework SDKs (`identifier * literal`, `identifier / literal`,
`-literal`, `literal * literal`, possibly `identifier.identifier *
literal`). All known offending cases in `dart:ui` /
`flutter/{painting,rendering}` resolve to numeric primitives once
the `math.pi`/`math.e` constants are bound. Implementing this
would unblock the entire family without per-call-site script
edits.

A safer narrower fix: have `_wrapDefaultValue` recognise
expressions of the form `math.<name> <op> <numericLiteral>` and
emit the equivalent numeric constant directly (since `math.pi` and
`math.e` are compile-time-known doubles, the multiplication
result is also compile-time-known).

Neither variant is in scope for the C09 cluster — fixing the
generator and regenerating every bridge package would put
hundreds of `.b.dart` files in the diff.

### Workaround

At each call site, supply *all* preceding optional positionals up
to and including the operator-bearing one, using the framework's
documented defaults literally. For `ui.Gradient.sweep`:

```dart
// Don't (compiles natively, but the bridged form throws on `endAngle`):
final ui.Gradient sweep = ui.Gradient.sweep(
  Offset(100.0, 60.0),
  kRainbow,
);

// Do — spell out every preceding positional default, plus the
// operator-bearing one, using the framework's defaults literally:
final ui.Gradient sweep = ui.Gradient.sweep(
  Offset(100.0, 60.0),
  kRainbow + <Color>[kSpecRed],
  <double>[0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0], // colorStops
  TileMode.clamp,                                                  // tileMode
  0.0,                                                             // startAngle
  math.pi * 2.0,                                                   // endAngle (operator-bearing default)
);
```

Two practical notes when applying this workaround:

1. **The `colors`/`colorStops` invariant runs natively on
   `dart:ui`.** Once `colorStops` becomes an explicit list rather
   than `null`, the engine enforces
   `colorStops.length == colors.length` (and not the
   `colors.length == 2 || colorStops != null` form that handles
   the `null` case). Build the stops list to match the colour
   count exactly — usually evenly spaced
   (`List.generate(n, (i) => i / (n - 1))`).
2. **Keep `math.pi * 2.0` literally, not a `kTwoPi` constant.**
   The framework spells it `math.pi * 2`, and matching that form
   in the script keeps the workaround intent obvious: every
   preceding positional plus the operator default. Using a named
   constant invites a future reader to think the value is
   significant rather than load-bearing-for-bridge-defaults.

### Affected scripts

| Script | Sites | Notes |
|--------|-------|-------|
| `rendering/gradient_rendering_test.dart` | 1 (Section "sweep gradient", lines 1416–1437) | `ui.Gradient.sweep(center, colors)` expanded to 6 positionals (added `colorStops` 9-element stop list, `TileMode.clamp`, `0.0`, `math.pi * 2.0`). C09 closed 2026-05-17 on both drivers. |

### What a real fix would look like

In `tom_d4rt_generator/lib/src/bridge_generator.dart`'s
`_wrapDefaultValue`: before falling through to the final
`return null;` on line 4613, detect arithmetic-default expressions
that reference only compile-time-known constants (`math.pi`,
`math.e`, numeric literals) and one of the four basic operators
(`+`, `-`, `*`, `/`). Evaluate them at generation time and emit
the resulting numeric literal as the wrapped default. The bridge
will then accept the omitted argument instead of routing it
through `getRequiredArgTodoDefault`.

A test fixture in `tom_d4rt_generator/test/` exercising this
shape against `dart:ui` `Gradient.sweep` / `radial` / `linear`
would catch regressions if the operator list ever grows.

---

## U3 — Interpreted subclass of native abstract `Curve`: `transformInternal` override not routed through `Curve.transform` (interpreter limitation)

### Symptom

A D4rt-script-defined subclass of the native abstract
`flutter/animation` `Curve` class — overriding `transformInternal(double t)`
as the framework expects — returns `null` from `curve.transform(t)`
when invoked through the bridge. Downstream arithmetic on the null
sample then throws:

```
Runtime Error: Native error during bridged operator '+' on double:
type 'Null' is not a subtype of type 'num' in type cast
```

The stack trace bottoms out in `visitBinaryExpression` at the
`12.0 + (28.0 * s)` site (where `s = curve.transform(i / (steps - 1))`),
two `_processCollectionElement` frames deep inside the for-element
that builds the curve-strip's sample bars.

Reproduced in `testlog_20260517-0914` C10 on both drivers
(`tom_d4rt_flutter_ast`, `tom_d4rt_flutter_test`) for
`animation/animation_misc_adv_test.dart` with the catalog specimen
`_FlippedShim extends Curve` (overriding `transformInternal` to flip
`Curves.easeInOut`).

### Root cause

Native `Curve.transform(double t)` is a *template method*: it
validates `t ∈ [0, 1]`, handles the `t == 0` / `t == 1` edges, and
delegates the interior to `transformInternal(t)`. Subclasses are
expected to override `transformInternal`, not `transform`.

When a D4rt script declares `class _FlippedShim extends Curve` and
implements only `transformInternal`, the adapter-proxy
infrastructure builds a `_InterpretedCurve` native shim that holds
the `InterpretedInstance`. A bridge consumer that calls
`curve.transform(t)` invokes the *native* `Curve.transform`
implementation on the proxy, which then calls `this.transformInternal(t)`
on the proxy itself — but the proxy does not override
`transformInternal` to route back to the interpreted method. The
native `Curve.transformInternal` is abstract; on the proxy it
either resolves to `null` (effectively returning the missing
implementation as null through the bridge) or to a default that
yields null in the consumer's `num` arithmetic.

The net effect: the interpreted `transformInternal` override is
never called by the framework's own `transform` template, so the
sample returns null, and the next bridged `*` / `+` on a `double`
rejects the null right-hand operand with the cast error above.

The failure reproduces identically whether `_FlippedShim()` is
constructed as a top-level `const` or as a non-const local — so this
is **not** the same bug as U1 (top-level `const` of an interpreted
subclass crashing the test-app transport before the visitor is
wired). U1 is a transport/lifecycle crash; U3 is a steady-state
delegation gap that surfaces only when the native template method
calls back into a method the script overrides.

### Why this is an interpreter / generator limitation rather than "truly unfixable"

The adapter-proxy / bridge generator could synthesise a
`transformInternal` override on the native `_InterpretedCurve`
proxy that calls `InterpretedInstance.invoke('transformInternal', [t])`
on the held interpreted instance. The same pattern already exists
for `State.build`, `StatelessWidget.build`, and several other
abstract-method template-method pairs; `Curve.transformInternal` is
just another case of the same shape.

The general fix is to identify *every* template-method/abstract-hook
pair in framework abstract classes the script can subclass (Curve →
transformInternal, ScrollPhysics → applyPhysicsToUserOffset, …) and
have the proxy generator emit native overrides that route back to
the interpreted instance.

Neither variant is in scope for the C10 cluster — touching the
proxy generator would put dozens of `.b.dart` files in the diff and
risks regressing the existing `State` / `StatelessWidget`
adapter-proxy paths.

### Workaround

Use a framework-provided `Curve` subclass instead of a
script-defined one. The script's catalog specimen needs only to
*display* a curve named "flipped easeInOut", which `FlippedCurve`
(in `flutter/animation`) implements natively:

```dart
// Don't (compiles, but bridged `transform()` returns null):
const MapEntry<String, Curve>(
  'Curves.easeInOut.flipped',
  _FlippedShim(),
),
// where:
class _FlippedShim extends Curve {
  const _FlippedShim();
  @override
  double transformInternal(double t) {
    final double v = Curves.easeInOut.transform(1.0 - t);
    return 1.0 - v;
  }
}

// Do — use the framework's `FlippedCurve`:
MapEntry<String, Curve>(
  'FlippedCurve(easeInOut) [native]',
  FlippedCurve(Curves.easeInOut),
),
```

The catalog still demonstrates the "flipped" curve shape; the
sampling now goes through `FlippedCurve.transformInternal`, which
is real native Dart and runs identically to a hand-rolled flip.

The `_FlippedShim` class itself can be kept in the script as
documentation of the user-extension pattern, annotated with
`// ignore: unused_element` so the analyzer does not warn.

### Affected scripts

| Script | Sites | Notes |
|--------|-------|-------|
| `animation/animation_misc_adv_test.dart` | 1 (`_customCurves` specimens list, original lines 863–866; specimen class `_FlippedShim` at original lines 911–935) | Replaced specimen with `MapEntry<String, Curve>('FlippedCurve(easeInOut) [native]', FlippedCurve(Curves.easeInOut))`. `_FlippedShim` class retained for documentation with `// ignore: unused_element`. C10 closed 2026-05-17 on both drivers. |

### What a real fix would look like

In `tom_d4rt_generator/lib/src/proxy_generator.dart`: when
generating the native proxy class for an abstract framework class
that follows the template-method pattern (public method calls a
hookable protected/abstract method), emit native overrides on the
proxy for the hookable method(s) that delegate to
`interpretedInstance.invoke(hookName, args)`. Concretely for `Curve`:

```dart
class _InterpretedCurve extends Curve {
  _InterpretedCurve(this.interpretedInstance);
  final InterpretedInstance interpretedInstance;
  @override
  double transformInternal(double t) {
    return interpretedInstance
        .invoke('transformInternal', <Object?>[t]) as double;
  }
}
```

A test fixture exercising
`class MyCurve extends Curve { @override double transformInternal(double t) => 1 - t; }`
sampled through `MyCurve().transform(0.25)` would catch regressions
across this whole family.

---

## U4 — Standalone `'\n'` `TextSpan` between two styled siblings crashes the test-app transport (truly unfixable)

**Category.** Truly unfixable — Dart-VM-level crash inside the
bridged render path. The fault does not surface as a catchable
`RuntimeD4rtException`; the test-app process dies and the HTTP
transport closes mid-build, manifesting at the runner level as
`Bad state: Transport failure while running …` and on the device
side as `Lost connection to device.`.

**Reproducer.** Inside a parent `TextSpan.children` list, a child
`TextSpan` whose `text` is exactly the single-character newline
string `'\n'` — sitting *between* two other `TextSpan`s that each
carry a non-null `style` — kills the Dart VM during build:

```dart
RichText(
  text: TextSpan(
    style: const TextStyle(color: Colors.white, fontSize: 13),
    children: [
      TextSpan(text: '(Cmd+S)', style: TextStyle(color: mint)),
      const TextSpan(text: '\n'),                         // ← crash
      TextSpan(text: 'tip:',    style: TextStyle(color: amber)),
    ],
  ),
)
```

Equivalence cases verified during bisection (see C15 entry in
`testlog_20260517-0914-test_analysis/error_analysis.md` for the
full bisect trail and probe-log filenames):

| children layout | result |
|-----------------|--------|
| `[styled, styled, styled]` (no `\n`-only child) | pass |
| `[styled, TextSpan(text: 'middle', style: red), styled]` | pass |
| `[styled, TextSpan(text: '\n'), styled]` (no `const`, no `style`) | crash |
| `[styled, TextSpan(text: '\n', style: TextStyle()), styled]` | crash |
| `[styled, TextSpan(text: '\n', style: white), styled]` | crash |
| `[styled, TextSpan(text: ' ',  style: white), styled]` | pass |
| `[styled('(Cmd+S)\n'), styled]` (merge `\n` into preceding) | pass |
| `[plain, styled, plain]` (single styled, no second styled) | pass |
| `[const, styled, const, styled]` (alt form of the trigger) | crash |
| `[styled, styled]` (two adjacent styled, no `\n`-only between) | pass |

So both the *character* `'\n'` in the middle child *and* the
flanking pair of style-bearing siblings are necessary. Adding a
`style:` to the middle child is **not** sufficient; the trigger
depends on the literal `'\n'` text value.

**Constraints.**

- No smaller reproducer exists outside the bundled-script HTTP
  transport: a hand-written `RichText` with the exact same shape,
  rendered from native Dart, renders fine. The fault therefore
  lives in the d4rt bridged-render path, not in Flutter itself.
- The crash terminates the Dart VM (`Lost connection to device`),
  so neither the interpreter nor the test runner can intercept
  it and present a usable error.
- The bundle JSON size, byte difference between repro and
  workaround (2 bytes for `'\n'` → `' '`), and ordinal position
  within the script are all neutral; only the literal `'\n'`-as-
  sole-text in the middle child matters.

**Script-side workaround (mandatory).** Append the `'\n'` to the
preceding styled span's `text` and drop the standalone newline
child:

```dart
children: [
  const TextSpan(text: 'Save changes '),
  TextSpan(text: '(Cmd+S)\n', style: TextStyle(color: mint)), // \n merged in
  TextSpan(text: 'tip:',      style: TextStyle(color: amber)),
  const TextSpan(text: ' shift to save-as'),
],
```

The newline still hard-breaks at the same visual position because
`TextSpan` glyph layout is style-insensitive for whitespace.

If merging into the preceding span is structurally awkward (e.g.,
the preceding span is `const` and the surrounding `children:` is
also `const`), a `WidgetSpan(child: SizedBox(width: double.infinity, height: 0))`
sandwiched in place of the `'\n'` `TextSpan` is the next-best
alternative — it forces a line break without any text content at
all.

**Diagnostic guidance.** If a script newly added under a
cluster-by-cluster pass turns up
`Bad state: Transport failure while running …` with no preceding
framework-error block and the script contains a `RichText` /
`Tooltip(richMessage:)` / `Text.rich(...)` with multiple styled
`TextSpan` children, suspect a literal `'\n'`-only child between
them first. Strip down the offending children list with the
probes documented in C15 to confirm.

---

## Change Log

- 2026-05-17: **Add U4 — Standalone `'\n'` `TextSpan` between two
  styled siblings crashes the test-app transport.** Documents the
  `testlog_20260517-0914` C15 cluster
  (`material/tooltip_feedback_test.dart`, `_privateRichMessageExample`
  `RichText`). Root cause is a Dart-VM-level crash in the
  bridged-render path triggered specifically by a child
  `TextSpan(text: '\n')` between two other styled `TextSpan`s in
  the same `children:`. No interpreter or generator fix is
  feasible: the failure mode is `Lost connection to device.`,
  which is uncatchable. Mandatory script-side workaround:
  append `'\n'` to the preceding styled `TextSpan` and drop the
  standalone newline child.

- 2026-05-17: **Add U3 — Interpreted subclass of native abstract
  `Curve`: `transformInternal` override not routed through
  `Curve.transform`.** Documents the `testlog_20260517-0914` C10
  cluster (`animation/animation_misc_adv_test.dart`, `_FlippedShim
  extends Curve` returning `null` from bridged `transform()` and
  the resulting `Native error during bridged operator '+' on
  double: type 'Null' is not a subtype of type 'num' in type cast`
  in `12.0 + (28.0 * s)`). Root cause: the adapter-proxy for a
  script-defined `Curve` subclass does not synthesise a native
  `transformInternal` override that routes the framework's
  template-method `Curve.transform(t)` call back into the
  interpreted method via `InterpretedInstance.invoke`. Distinct
  from U1: reproduces both const and non-const, and is a
  steady-state delegation gap rather than a startup transport
  crash. Workaround applied script-side: replace the catalog
  specimen with the framework-provided
  `FlippedCurve(Curves.easeInOut)` and retain the `_FlippedShim`
  class as documentation with `// ignore: unused_element`. C10
  closes on both drivers 2026-05-17. Long-term fix sketched:
  proxy-generator emits native `transformInternal` override that
  delegates to `interpretedInstance.invoke('transformInternal',
  [t])`; same shape applies to other template-method/hook pairs
  (`ScrollPhysics.applyPhysicsToUserOffset`, …).
- 2026-05-17: **Add U2 — Non-wrappable arithmetic defaults on
  positional-only native constructors.** Documents the
  `testlog_20260517-0914` C09 cluster
  (`rendering/gradient_rendering_test.dart`, `ui.Gradient.sweep`
  rejecting `endAngle` with `Parameter "endAngle" has non-wrappable
  default (math.pi * 2)`). Root cause is
  `BridgeGenerator._wrapDefaultValue` returning `null` for any
  default expression containing an operator
  (`tom_d4rt_generator/lib/src/bridge_generator.dart:4606-4613`),
  so the generated bridge emits `D4.getRequiredArgTodoDefault<…>`
  for `endAngle` and throws when the slot is omitted. Workaround
  applied script-side: spell out all preceding optional positionals
  using the framework's documented defaults literally
  (`colorStops` explicit 9-element stop list, `TileMode.clamp`,
  `0.0`, `math.pi * 2.0`). C09 closes on both drivers 2026-05-17.
  Long-term fix sketched: have the generator evaluate
  `math.pi`/`math.e` arithmetic at generation time and emit the
  resulting numeric literal as the wrapped default.
- 2026-05-17: **Add U1 — Demo-scale renderings that overload the
  test-app transport.** Documents the
  `testlog_20260517-0914` C05 cluster (`widgets/notificationlistener_test.dart`,
  "Lost connection to device"). Two independent fatal shapes
  bundled: (1) top-level `const` of an interpreted subclass of
  the native abstract `Notification`, which exercises the
  adapter-proxy infrastructure before the visitor has finished
  wiring its context, and (2) `SelectableText.rich` with a ~1000+
  TextSpan tree produced by the demo's per-character
  `_privateColorizeDart` helper from a ~1.8 KB code listing,
  which exceeds the test-app transport budget. Both neutralised
  script-side by inlining the demo's displayed values
  (`_kSampleScoreBValue`, `_kSampleScoreBLabel`) and rendering
  Section 7's large code listing as a single plain monospace
  `Text` widget through a new `_privatePlainCodeBlock` helper.
  Cluster closes on both drivers 2026-05-17.
- 2026-05-05: **Add S1 — `const Stream<T>.empty()` rejected by
  `Stream` bridge.** `BridgedClass` for `Stream` registers
  `empty`/`value`/`fromIterable`/… as `staticMethods`, so the
  `MethodInvocation` path falls through to them but the
  `InstanceCreationExpression` path does not. **Important
  correction** (same-day update): every `Stream.factory(...)`
  source shape parses as `InstanceCreationExpression` because all
  of them are named constructors on the real `Stream` class —
  including `Stream.empty()` and `Stream.fromIterable(...)`
  without type-args. Surfaced when
  `widgets/streambuilder_test.dart` was rewritten as a deep demo
  in Batch 2. Working workarounds: pass `stream: null`
  (StreamBuilder.stream is nullable) or build via
  `StreamController().stream` after `close()`.
- 2026-05-04: **Add T1 — `runtimeType.toString()` on user-defined
  interpreted classes throws "no static method 'toString'".**
  Documents `testlog_20260503-2009-issue-analysis` cluster C10
  follow-up. `InterpretedInstance.runtimeType` returns the
  `InterpretedClass` itself, which does not expose `toString` as a
  callable static. Workaround: emit the class-name string from an
  explicit `is`-check ladder. Architectural fix (universal-Object
  shim on the runtimeType façade) queued. Surfaced in
  `widgets/route_transition_record_test.dart` line 836.
- 2026-05-04: **Add I1 — C-style `for (var i = 0; …; i++)` shares
  loop variable across closures.** Documents the interpreter
  limitation diagnosed via stack-trace from
  `widgets/drag_target_details_test.dart` Section 11 (5 FE). The
  C-style for-loop's `loopEnvironment` is shared across all
  iterations, so DragTarget builder closures all see the post-loop
  `i = 5`. Cluster-scope fix is the script-side rewrite to
  `List<T>.generate`; the architectural fix (per-iteration
  variable capture in `_executeClassicFor` in both interpreters)
  is queued.
- 2026-05-04: **Add L1 — `AnimatedBuilder.animation` rejects
  script-defined subclass of bridged `Listenable`/`ChangeNotifier`.**
  Documents `testlog_20260503-2009-issue-analysis` cluster C2 for
  `widgets/windowing_owner_mac_o_s_test.dart`. The script defines
  `BaseWindowController extends ChangeNotifier` →
  `RegularWindowController` → `RegularWindowControllerMacOS`, then
  passes `controller` as `AnimatedBuilder.animation`. The bridge
  adapter rejects the `InterpretedInstance` because the bridge
  proxy/relaxer pipeline does not currently synthesise native
  `ChangeNotifier`-backed proxies for script-defined subclasses of
  bridged `Listenable`. Cluster-scope fix is the script-side
  workaround `animation: const AlwaysStoppedAnimation<double>(0.0)`
  with controller still accessed via closure capture. Two
  follow-up layout overflows fixed in the same edit (DockTile
  shrink + ContentArea badge Wrap inside Expanded scrollview).
- 2026-05-04: **Add R1 — Redirecting factory constructor syntax
  (`factory X() = Y`) not implemented.** Documents the
  `testlog_20260503-2009-issue-analysis` cluster C4
  (`widgets/regular_window_test.dart`,
  `Cannot instantiate abstract class 'RegularWindowController'`).
  The script authored Flutter's modern desktop-window pattern:
  abstract `RegularWindowController` with a
  `factory RegularWindowController(...) = _HostRegularWindowController;`
  redirect. d4rt only handles class-level redirecting constructors
  in the **initializer-list** form
  (`SRedirectingConstructorInvocation`,
  `tom_d4rt_ast/.../callable.dart`); the analyzer's class-level
  factory redirect is not lowered, so the abstract class is
  treated as directly instantiable and FE-fires. Closed script-side
  per cluster owner = script: 4 call sites instantiate the
  concrete `_HostRegularWindowController` directly while the
  variable types remain the abstract base — functionally identical
  to the analyzer's lowered output. Bridge fix proposed in §R1
  for a future regression-coordinated pass that mirrors across
  `tom_d4rt` ↔ `tom_d4rt_ast` and runs essential + important +
  secondary + gii.
- 2026-05-03 (later): **Add G1 — `D4.getNamedArgWithDefault<T?>`
  collapses explicit `null` to default for nullable-typed named
  args.** Documents the
  `testlog_20260503-2009-issue-analysis` cluster C1 (Cupertino
  `(maxLines == null) || (minLines == null) || (maxLines >= minLines)`
  assertion). Underlying generator/runtime helper conflates "key
  absent" with "explicit null"; `CupertinoTextField` exposes it
  because Flutter encodes "grow without bound" as the
  explicit-null sentinel. Both affected scripts
  (`cupertino/textfield_test.dart`,
  `cupertino/cupertino_text_selection_handle_controls_test.dart`,
  4 sites) closed script-side per cluster owner = script: replace
  `maxLines: null` with a finite cap ≥ `minLines`; bridge fix
  proposed in §G1 for a future regression-coordinated pass.
- 2026-05-03: **Add P4 — `switch (BridgedEnum)` may fall through
  every case, returning null.** Documents the priority-4 cluster
  from `testlog_20260503-0948-issue-analysis` (`Bridge: Text.data:
  null` ×3). All three scripts
  (`widgets/tooltip_window_controller_delegate_test.dart`,
  `foundation/target_platform_test.dart`,
  `material/time_of_day_format_test.dart`) now pass on both
  drivers after the script-side rewrite (switch → if/else with
  `==`, plus a default for declared-but-unassigned `String note;`
  variables).
- 2026-05-03: **Add P1 — `PreferredSizeWidget` cast fails when
  arg arrives as a cached native widget proxy.** Documents the
  third sub-case from the
  `testlog_20260503-0948-issue-analysis` priority-1 cluster
  (`widgets/snapshot_mode_test.dart` Scaffold.appBar FE). The
  other two sub-cases (`SliderThemeData.thumbShape`,
  `SpellCheckConfiguration.spellCheckService`) were closed by
  adding `SliderComponentShape` and `SpellCheckService` to the
  `proxyClasses` allowlists in
  `tom_d4rt_flutter_ast/buildkit.yaml` and
  `tom_d4rt_flutter_test/buildkit.yaml` and regenerating
  `flutter_proxies.b.dart`. The `snapshot_mode_test` case did
  not close on the same fix because the arg reaches the bridge
  as the cached `_InterpretedStatelessWidget` native proxy
  rather than the original `InterpretedInstance`, so the
  multi-interface proxy walk in
  `tryCreateInterfaceProxyWithVisitor` is never executed —
  documented as an interpreter architectural limitation with a
  script-side `PreferredSize(preferredSize: …, child: AppBar(…))`
  workaround.
- 2026-04-28 (latest): **Close E9 in `error_analysis.md` —
  `clampDouble` class is empty.** Sweep of essential, important,
  secondary, hr5, and gii suites recorded zero
  `dart:ui/math.dart` line-14 `<optimized out>` triggers. The
  C21 fix (slotted-multichild constructor routing) removed the
  only upstream that was producing NaN / out-of-range numerics
  reaching the engine; no residual call sites remain. The
  `D4RT_TRACE_NUMERIC_ARGS=1` instrumentation and
  `D4.checkFiniteNumeric` bridge guard are kept as a future
  tripwire only. See `doc/testlog_20260428-e9-fix/`.
- 2026-04-28: **Add E8 entry — `ScrollController`
  state-field-through-StatelessWidget-chain.** Cluster E8
  closed partial (8→2). Layout-cascade fix (drop `stretch`
  from 4 `Row` sites) landed in `script_rewrites.md`. Residual
  2 framework errors are interpreter-level (state-field
  identity loss across bridged `Scrollable.attach`) and
  documented for next interpreter pass.
- 2026-04-28: **Move Index 32
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
- 2026-04-28 (close-out, E14): Cluster **E14 — `SystemColor`
  platform guard on Linux** in
  `testlog_20260428-1333-issue-analysis/error_analysis.md`
  closed as deferred-pending-platform-support. No interpreter
  or generator change is possible: the Linux desktop test
  harness does not expose Flutter's `SystemColor` platform
  channel, and the interpreter faithfully forwards the `null`
  it receives — fabricating colours would make the test pass
  on a lie. The closure rests on three artifacts already in
  place: (1) the `Platform.isLinux` test-runner skip at
  `tom_d4rt_flutter_ast/test/generator_interpreter_retest_test.dart:74`,
  (2) script-side `try/catch` around `ui.SystemColor.light` /
  `ui.SystemColor.dark` with a fallback UI in
  `retest/dart_ui/system_color_palette_test.dart` (lines
  831-842, marked with a `D4RT-LIMITATION` comment), and
  (3) the canonical write-up in `script_rewrites.md` under
  "Platform capability guard — `SystemColor` on Linux"
  (lines 79-100). Reopen and drop the skip if Linux gains
  `SystemColor` support upstream.
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
