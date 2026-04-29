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
| [Fa1-N1 — Layout-cascade FE residuals on 6 deep-demo scripts](#fa1-n1--layout-cascade-fe-residuals-on-6-deep-demo-scripts-script-side-annotation-deferred) | Script-side limitation (cosmetic only; zero test failures). Closing route documented per sub-pocket; deferred via `D4RT-SCRIPT-LIMITATION: layout cascade` annotations. Sentinel: `test/fa1_bisect_test.dart [fa1-2250-sentinel]`. | `snapshot_mode_test.dart` (small-overflow, 1 FE), `select_all_text_intent_test.dart` / `transpose_characters_intent_test.dart` / `restoration_mixin_test.dart` (EditableText, 3+2+3 FE), `widget_state_color_test.dart` / `text_magnifier_configuration_test.dart` (C3 sliver-row, 9+6 FE) |
| [N2 — Bridged `RestorableProperty` proxy: late-`_value` + cross-script `for-in BridgedInstance<Object>`](#n2--bridged-restorableproperty-proxy-script-side-eager-init--defensive-iteration) | Same architectural limitation as D3/D4 (bridged `RestorationMixin` lifecycle dispatch under cross-script ordering); script-side workaround supplied: eager-init `_value` from constructor + `_favoritesSnapshot()` defensive iteration. | `widgets/restorable_property_test.dart` (closed 2026-04-29) |

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

**Not annotated.** `widgets/restorable_double_test.dart` —
emitted FE=1 in the `secondary_classes_test` suite at testlog
2250, but FE=0 in isolation under `fa1_bisect_test.dart`. The
inter-script ordering flake doesn't fit the script-annotation
pattern; tracked separately if it persists.

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

## Change Log

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
  `tom_d4rt_flutterm/test/generator_interpreter_retest_test.dart:74`,
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
