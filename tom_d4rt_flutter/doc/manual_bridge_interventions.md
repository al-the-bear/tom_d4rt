# Manual Bridge Interventions (tom_d4rt_flutter)

`tom_d4rt_flutter` bridges the **full Flutter Material surface** for the D4rt
interpreter. The vast majority of that surface — constructors, methods,
getters, setters, operators, enums, supertype tables, interface proxies,
generic-constructor factories, type relaxers — is generated automatically by
`tom_d4rt_generator` from `buildkit.yaml` and a handful of annotations, and
lands in `lib/src/bridges/*.b.dart`.

A small residue cannot be derived mechanically. It encodes either a runtime
behaviour the generator has no way to know about, or a workaround for a limit
of the interpreter or the Dart type system. **This file is the concrete
catalogue of that residue as it ships in this package** — the actual
hand-written overrides and runtime registrations, with worked examples.

> **Delta on the canonical guide.** The *generic framework* — the two
> extension mechanisms, the full list of patterns the generator now automates
> (so you do **not** hand-write them), and the root-cause taxonomy — is owned
> by the canonical
> [`tom_d4rt/doc/manual_bridge_interventions.md`](../../tom_d4rt/doc/manual_bridge_interventions.md).
> Read it first for the "how the mechanism works" material; this file only
> documents *what tom_d4rt_flutter actually hand-writes* and why. Supporting
> references:
>
> - [`tom_d4rt/doc/advanced_bridging_user_guide.md`](../../tom_d4rt/doc/advanced_bridging_user_guide.md)
>   — the `D4` helper API (argument extraction, coercion, target validation)
>   every override below relies on.
> - [`tom_d4rt_ast/doc/runtime_registration_surface.md`](../../tom_d4rt_ast/doc/runtime_registration_surface.md)
>   — the nine `D4.register*` sinks, the `BridgedClass` supertype mechanism,
>   and the `extractBridgedArg<T>` resolution order.
> - [`tom_d4rt_flutter_user_guide.md`](tom_d4rt_flutter_user_guide.md) §4
>   "Extension registration" — where these registrations are wired into the
>   runner.

---

## 1. Where the hand-written code lives in this package

There are exactly two homes for hand-written bridge code, both consumed by
the runner's `_registerBridges()` (see user-guide §4):

| Location | Purpose |
|----------|---------|
| [`lib/src/d4rt_user_bridges/*.dart`](../lib/src/d4rt_user_bridges/) | **Preferred.** Per-class overrides annotated with `@D4rtUserBridge(libraryPath, className)`. The generator's pre-scan finds them and folds each override into the generated registration, *replacing* the generated adapter. This package ships **four**: `state_user_bridge.dart`, `basic_message_channel_user_bridge.dart`, `strut_style_user_bridge.dart`, `text_user_bridge.dart`. |
| [`lib/src/d4rt_runtime_registrations.dart`](../lib/src/d4rt_runtime_registrations.dart) | Imperative `D4.register*` registrations that run after the generated bridges are installed — interface proxies, type coercions, the `_Interpreted*` proxy/State classes, and cross-cutting interceptors. Use this only for registrations that are not a single-class override. |

Everything else — the generated `lib/src/bridges/*.b.dart` files — is produced
by the generator and **must never be hand-edited**. If a generated adapter is
wrong, either add a `@D4rtUserBridge` override (preferred) or fix the
generator and regenerate with `dart run tool/regenerate_bridges.dart`.

> Before hand-writing anything, confirm the case is not already covered by a
> generator knob. The full "do **not** hand-write these" list (bridged
> supertype tables, abstract-interface proxies, State/RenderBox lifecycle
> proxies, generic widget re-creators, generic-constructor factories,
> type-arg proxy variants, super-arg capture, generic interceptors, relaxer
> breadth) lives in the canonical guide §3.

---

## 2. The user bridges that ship here (`@D4rtUserBridge` overrides)

Each of the following encodes knowledge the generator cannot derive and is
expected to remain hand-written.

### 2.1 Scheduler-phase deferral — `State.setState`

**Why it's manual:** the generated `setState` adapter calls `state.setState(fn)`
synchronously. Scripts in practice call `setState` from inside layout/paint
callbacks; real Flutter throws *"setState() … called during build"* there, and
the generated adapter surfaces that as a framework error before the script can
recover. The fix is a runtime-behaviour decision (defer to the next frame) that
only a human can authorise — it is a deliberate, documented deviation from
Flutter semantics.

```dart
@D4rtUserBridge('package:flutter/src/widgets/framework.dart', 'State')
class StateUserBridge extends D4UserBridge {
  static Object? overrideMethodSetState(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArguments,
  ) {
    final state = D4.validateTarget<State>(target, 'State');
    D4.requireMinArgs(positional, 1, 'setState');
    final fnRaw = positional[0];

    void invokeNative() {
      // ignore: invalid_use_of_protected_member
      state.setState(() => D4.callInterpreterCallback(visitor, fnRaw, []));
    }

    final phase = SchedulerBinding.instance.schedulerPhase;
    final mustDefer = phase == SchedulerPhase.transientCallbacks ||
        phase == SchedulerPhase.midFrameMicrotasks ||
        phase == SchedulerPhase.persistentCallbacks;
    if (mustDefer && state.mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (state.mounted) invokeNative();
      });
    } else {
      invokeNative();
    }
    return null;
  }
}
```

Full source: [`lib/src/d4rt_user_bridges/state_user_bridge.dart`](../lib/src/d4rt_user_bridges/state_user_bridge.dart).

### 2.2 Lower-level API bypass — `BasicMessageChannel.setMessageHandler`

**Why it's manual:** `BasicMessageChannel<T>.setMessageHandler` takes a
`Future<T> Function(T?)?`. The generator cannot preserve the class-level `T`, so
its auto-emitted adapter installs a `(dynamic) => Future<dynamic>` closure that
fails Dart's runtime function-type check against a concrete
`BasicMessageChannel<String>`. The override sidesteps the typed API and installs
the handler one layer down, at the `BinaryMessenger`, round-tripping through the
channel's own codec — exactly what Flutter does internally.

```dart
@D4rtUserBridge('package:flutter/src/services/platform_channel.dart',
    'BasicMessageChannel')
class BasicMessageChannelUserBridge extends D4UserBridge {
  static Object? overrideMethodSetMessageHandler(
    InterpreterVisitor visitor, Object target,
    List<Object?> positional, Map<String, Object?> named,
    List<RuntimeType>? typeArguments,
  ) {
    final channel =
        D4.validateTarget<BasicMessageChannel>(target, 'BasicMessageChannel');
    final handlerRaw = positional.isNotEmpty ? positional[0] : null;
    if (handlerRaw == null) {
      channel.binaryMessenger.setMessageHandler(channel.name, null);
      return null;
    }
    final codec = channel.codec;
    channel.binaryMessenger.setMessageHandler(channel.name,
        (ByteData? message) async {
      final decoded = codec.decodeMessage(message);
      final result = D4.callInterpreterCallback(visitor, handlerRaw, [decoded]);
      final awaited = result is Future ? await result : result;
      return codec.encodeMessage(awaited);
    });
    return null;
  }
}
```

Full source:
[`lib/src/d4rt_user_bridges/basic_message_channel_user_bridge.dart`](../lib/src/d4rt_user_bridges/basic_message_channel_user_bridge.dart).
The generator detects this shape (a method whose function parameters reference
the class's own type parameters) and warns — see GEN-092 — but the substitution
itself stays manual.

### 2.3 Opaque-type substitution — `StrutStyle`

**Why it's manual:** `dart:ui.StrutStyle` is an opaque engine object with no
getters, so a script that constructs one cannot read its properties back. The
override constructs the richer `painting.StrutStyle` (which has full getters)
instead, and a paired `D4.registerTypeCoercion` converts it back to the engine
type when a `dart:ui` API needs it. The choice of which richer type to
substitute is domain knowledge.

```dart
@D4rtUserBridge('dart:ui', 'StrutStyle')
class StrutStyleUserBridge extends D4UserBridge {
  static Object? overrideConstructor(
    Object? visitor, List<Object?> positional, Map<String, Object?> named,
  ) {
    return painting.StrutStyle(
      fontFamily:
          D4.extractBridgedArgOrNull<String>(named['fontFamily'], 'fontFamily'),
      fontSize:
          D4.extractBridgedArgOrNull<double>(named['fontSize'], 'fontSize'),
      height: D4.extractBridgedArgOrNull<double>(named['height'], 'height'),
      // … remaining named params forwarded the same way …
    );
  }
}
```

Full source: [`lib/src/d4rt_user_bridges/strut_style_user_bridge.dart`](../lib/src/d4rt_user_bridges/strut_style_user_bridge.dart).

### 2.4 Degenerate-input normalization — `Text('')`

**Why it's manual:** a bridge-built `Text('')` feeds a zero-glyph paragraph into
the engine, which produces a NaN `Offset` and, under `IntrinsicHeight`, an
"infinite height" error — a defect specific to the bridged paragraph path
(native Flutter renders `Text('')` cleanly). The override normalises an empty
string to a zero-width space so the paragraph always has one (zero-advance)
glyph, forwarding every other argument unchanged. Recognising this degenerate
case and the safe substitution is human knowledge.

```dart
@D4rtUserBridge('package:flutter/src/widgets/text.dart', 'Text')
class TextUserBridge extends D4UserBridge {
  static const String _emptyTextSentinel = '​'; // zero-width space

  static Object? overrideConstructor(
    Object? visitor, List<Object?> positional, Map<String, Object?> named,
  ) {
    final data = D4.getRequiredArg<String>(positional, 0, 'data', 'Text');
    return widgets.Text(
      data.isEmpty ? _emptyTextSentinel : data,
      // … all named params forwarded byte-for-byte against the generated adapter …
    );
  }
}
```

Full source: [`lib/src/d4rt_user_bridges/text_user_bridge.dart`](../lib/src/d4rt_user_bridges/text_user_bridge.dart).
This pattern — mirror the generated adapter exactly, change one input — is the
template for any "the generated bridge is correct except for one edge case"
fix.

> **AST-only sibling — `SceneBuilder.pushOpacity`.** A few `dart:ui` methods
> have a parameter that is non-null on the web but nullable on the VM (e.g.
> `pushOpacity(..., Offset offset)`). The VM-vs-web signature-skew coercion is
> handled as a user bridge **only in the analyzer-free twin**
> (`tom_d4rt_flutter_ast/lib/src/d4rt_user_bridges/scene_builder_user_bridge.dart`),
> because this package targets the VM where the parameter is already nullable.
> It is on the path to full generator automation (behind the
> `enableVmWebSkewCoercion` gate); see the canonical guide §4.5.

---

## 3. Runtime-registration interventions (`d4rt_runtime_registrations.dart`)

These are not single-class overrides, so they live as imperative
`D4.register*` calls rather than `@D4rtUserBridge` files.

### 3.1 `InheritedWidget` ancestor-walk fallback (R5)

**Why it's permanent:** the interpreter collapses every interpreted class to a
single runtime `InterpretedInstance` type, so
`dependOnInheritedWidgetOfExactType<T>()` cannot match on `T` the way Dart's
element tree does. The runtime registration walks the element ancestry matching
on the *script class name* instead (`_findInheritedElementForType` →
`dependOnInheritedElement`). Because Dart provides no way to synthesise a
distinct runtime type per interpreted class, this fallback can never be
generated — it is terminal. A paired `InheritedWidget` interface proxy
(`_InterpretedInheritedWidget`, Bug-102) lets a script wrap a subtree even
though the generator does not emit an `InheritedWidget` proxy.

### 3.2 `bridgedSuperObject` identity proxies — `ChangeNotifier` / `Listenable`

**Why it's manual:** when an interpreted class extends `ChangeNotifier`, the
listener machinery must operate on a single, stable native object — otherwise
`addListener`/`notifyListeners` see different instances. The interface-proxy
registrations for `ChangeNotifier` and `Listenable` return the script's existing
`bridgedSuperObject` to preserve that identity, so consumers that expect a
`Listenable` (e.g. `AnimatedBuilder.animation`, `ListenableBuilder.listenable`)
get the same object the script's `addListener` registered against. Identity
preservation is a semantic guarantee the generator cannot infer.

### 3.3 `TickerProvider` / `State` lifecycle proxies

The `_Interpreted*` proxies (`_InterpretedState`,
`_InterpretedTickerProviderState`, `_InterpretedStatelessWidget`,
`_InterpretedStatefulWidget`, …) bridge interpreted `State`/`Widget`
subclasses onto the native lifecycle. The mixin-gap and lifecycle variants are
now **generated** (see canonical guide §3 and
[`tom_d4rt_flutter_limitations.md`](tom_d4rt_flutter_limitations.md) §1, §5);
only cases that need a *behavioural* change (like §2.1) stay hand-written.

---

## 4. Adding a new override — checklist

1. Confirm the case isn't already covered by a generator knob (canonical
   guide §3).
2. Create `lib/src/d4rt_user_bridges/<thing>_user_bridge.dart`, subclass
   `D4UserBridge`, annotate with `@D4rtUserBridge(libraryPath, className)`.
3. Write the `static` override method(s) using the `D4` helpers
   (`validateTarget`, `getRequiredArg`, `extractBridgedArgOrNull`,
   `coerceListOrNull`, `callInterpreterCallback`) — see
   [`advanced_bridging_user_guide.md`](../../tom_d4rt/doc/advanced_bridging_user_guide.md).
4. Document *why* in a leading doc comment — these files are workarounds, and
   the "why" is the load-bearing part.
5. Regenerate bridges (`dart run tool/regenerate_bridges.dart`) and run the
   bridge-conformance corpus to confirm the override is picked up and nothing
   regresses. **Run the HTTP-harness suites serially** (they share one local
   server) — chain with `&&`, never in parallel.

---

## 5. References

- [`tom_d4rt/doc/manual_bridge_interventions.md`](../../tom_d4rt/doc/manual_bridge_interventions.md)
  — canonical generic guide (mechanisms, generator-automation list, root causes).
- [`tom_d4rt/doc/advanced_bridging_user_guide.md`](../../tom_d4rt/doc/advanced_bridging_user_guide.md)
  — `D4` helper API.
- [`tom_d4rt_ast/doc/runtime_registration_surface.md`](../../tom_d4rt_ast/doc/runtime_registration_surface.md)
  — `D4.register*` sinks and resolution order.
- [`tom_d4rt_flutter_user_guide.md`](tom_d4rt_flutter_user_guide.md) §4
  — how these registrations are wired into the runner.
- [`tom_d4rt_flutter_limitations.md`](tom_d4rt_flutter_limitations.md)
  — the Flutter-runtime limits these interventions work around.
- [`lib/src/d4rt_user_bridges/`](../lib/src/d4rt_user_bridges/) — the live
  override sources quoted above.
