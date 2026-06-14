# Manual Bridge Interventions

When you bridge a large native library (such as the full Flutter Material
surface) for the D4rt interpreter with `tom_d4rt_generator`, the vast majority
of the surface is generated automatically — constructors, methods, getters,
setters, operators, enums, supertype tables, interface proxies, generic
constructor factories, and type relaxers all come out of the generator from
`buildkit.yaml` and a handful of annotations.

A small residue cannot be derived mechanically. It encodes either a runtime
behaviour the generator has no way to know about, or a workaround for a
limitation of the interpreter or the Dart type system. This guide catalogues
that residue: **the interventions that are still required, with worked
examples**, and — equally important — the patterns you should *not* hand-write
anymore because the generator now produces them.

The worked examples are drawn from the reference consumer,
[`tom_d4rt_flutter`](../../tom_d4rt_flutter) (and its analyzer-free twin
`tom_d4rt_flutter_ast`), which bridges every Flutter Material library. Read this
alongside:

- [`advanced_bridging_user_guide.md`](advanced_bridging_user_guide.md) — the
  `D4` helper API (argument extraction, coercion, target validation) every
  override below relies on.
- [`runtime_registration_surface.md`](runtime_registration_surface.md) — the
  nine `D4.register*` sinks, the `BridgedClass` supertype mechanism, and the
  `extractBridgedArg<T>` resolution order.
- The generator-side docs under `tom_d4rt_generator/doc/` for how the automated
  patterns are configured.

---

## 1. Where manual code lives

There are exactly two homes for hand-written bridge code:

| Location | Purpose |
|----------|---------|
| `lib/src/d4rt_user_bridges/*.dart` | **Preferred.** Per-class overrides annotated with `@D4rtUserBridge(libraryPath, className)`. The generator's pre-scan finds them and folds them into the generated registration so a generated adapter is *replaced* by your override. |
| `lib/src/d4rt_runtime_registrations.dart` | Imperative registrations that run after the generated bridges are installed — `D4.register*` calls and the `_Interpreted*` proxy/State classes they reference. Use this only for cross-cutting registrations that are not a single-class override. |

Everything else — the generated `*.b.dart` files — is produced by the generator
and **must never be hand-edited**. If a generated adapter is wrong, either add a
`@D4rtUserBridge` override (preferred) or fix the generator and regenerate.

## 2. The two extension mechanisms

### 2a. `@D4rtUserBridge` overrides (preferred)

Subclass `D4UserBridge`, annotate it with the library path and class name, and
declare `static` override methods. The generator recognises a fixed set of
override method names and substitutes them for the generated adapter:

| Override method | Replaces |
|-----------------|----------|
| `overrideConstructor` | the default (unnamed) constructor adapter |
| `overrideConstructor<Name>` | a named constructor adapter |
| `overrideMethod<Name>` | an instance method adapter |
| `overrideStaticMethod<Name>` | a static method adapter |
| `overrideGetter<Name>` / `overrideSetter<Name>` | property adapters |
| `overrideOperatorIndex` / … | operator adapters |

Constructor overrides take `(Object? visitor, List<Object?> positional,
Map<String, Object?> named)`. Method overrides take `(InterpreterVisitor
visitor, Object target, List<Object?> positional, Map<String, Object?> named,
List<RuntimeType>? typeArguments)`.

### 2b. Imperative `D4.register*` registrations

For registrations that are not a single-class override (interface proxies,
supertype tables, type coercions, generic wrappers/constructors, interceptors)
use the `D4.register*` sinks from `d4rt_runtime_registrations.dart`. See
`runtime_registration_surface.md` for the full sink list. Most of these are now
**generated** — see §3 before writing one by hand.

---

## 3. What the generator now automates — do **not** hand-write these

These patterns were once hand-written but are now emitted by the generator.
Configure them via `buildkit.yaml` / the `@D4rtProxy` annotation family instead
of adding code to `d4rt_runtime_registrations.dart`:

| Pattern | How to get it now | Generator source |
|---------|-------------------|------------------|
| **Bridged supertype table** (`registerSupertypes`) | Automatic — emitted as `classSupertypes()` from analyzed supertypes. | `bridge_generator.dart` |
| **Abstract-interface forwarding proxies** (`_Interpreted*` `implements` native abstract) | List the class under `proxyClasses:` → `D4rt*` proxy + `registerProxyFactories()`. | `proxy_generator.dart` |
| **State / RenderBox lifecycle proxies** (mixin-gap variants) | `@D4rtProxy(mixinVariants: [...])`. | `state_proxy_generator.dart`, `render_box_proxy_generator.dart` |
| **Generic widget re-creators** (`registerGenericTypeWrapper`) | `recreatorClasses:` in `buildkit.yaml`. | `relaxer_generator.dart` (`generateWidgetReCreator`) |
| **Generic constructor factories** (`registerGenericConstructor`) | `@D4rtGenericConstructor(typeArgVariants: [...])`. | `generic_constructor_generator.dart` |
| **Type-arg proxy variants** (e.g. `CustomClipper<Path>` vs `<Rect>`) | `@D4rtProxy(typeArgVariants: [...])`. | `typearg_proxy_generator.dart` |
| **Super-constructor-argument capture** | `@D4rtProxy(superArgDefaults: {...})`. | `superarg_proxy_generator.dart` |
| **Generic method/static interceptor re-dispatch** | `GenericInterceptorConfig` in `buildkit.yaml`. | `generic_interceptor_generator.dart` |
| **Relaxer / RC-2 breadth control** | `generateAllRelaxers`, `relaxerClasses`, `additionalRelaxerTypes`, `reducedTypeArgAllowlist` in `BridgeConfig`. | `relaxer_generator.dart` |

> The runtime also ships **usage logging** (`D4RT_LOG_RELAXER_USAGE` /
> `D4.usageLogSummary()`) and **enriched missing-bridge errors**
> (`extractBridgedArg<T>` reports the resolution order it tried). Use those to
> discover which relaxer/proxy a script actually needs before reaching for a
> manual registration. There is also a **public registration facade**
> (`registerRelaxerFactory`, `registerInterfaceProxy`,
> `registerGenericConstructor` on the runner) so a consumer can register a
> missing factory at runtime without editing generated code.

If you find yourself writing one of the patterns above by hand, stop and reach
for the configuration knob instead — the hand-written version will drift from
the generated one and is dead weight.

---

## 4. Interventions still required (with examples)

Each of the following encodes knowledge the generator cannot derive. They are
expected to remain hand-written.

### 4.1 Scheduler-phase deferral — `State.setState`

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

Full source: `tom_d4rt_flutter/lib/src/d4rt_user_bridges/state_user_bridge.dart`.

### 4.2 Lower-level API bypass — generic method on a generic class

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
`tom_d4rt_flutter/lib/src/d4rt_user_bridges/basic_message_channel_user_bridge.dart`.
The generator detects this shape (a method whose function parameters reference
the class's own type parameters) and warns — see GEN-092 — but the substitution
itself stays manual.

### 4.3 Opaque-type substitution — `StrutStyle`

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

Full source: `tom_d4rt_flutter/lib/src/d4rt_user_bridges/strut_style_user_bridge.dart`.

### 4.4 Degenerate-input normalization — `Text('')`

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

Full source: `tom_d4rt_flutter/lib/src/d4rt_user_bridges/text_user_bridge.dart`.
This pattern — mirror the generated adapter exactly, change one input — is the
template for any "the generated bridge is correct except for one edge case"
fix.

### 4.5 VM↔web signature-skew coercion — `SceneBuilder.pushOpacity`

**Why it's manual (for now):** a few `dart:ui` methods have a non-null parameter
on the web that is nullable on the VM (e.g. `pushOpacity(..., Offset offset)`).
A script written against the VM signature passes `null` and breaks on the web.
The generator can emit a coercion table (`_vmWebSkewNonNullParams`, gated behind
`enableVmWebSkewCoercion`, **off by default**), but until that gate is turned on
the coercion lives as an AST-only override that fills the missing argument:

```dart
// tom_d4rt_flutter_ast/lib/src/d4rt_user_bridges/scene_builder_user_bridge.dart
@D4rtUserBridge('dart:ui', 'SceneBuilder')
class SceneBuilderUserBridge extends D4UserBridge {
  static Object? overrideMethodPushOpacity(/* … */) {
    final offset = /* named['offset'] */ ?? Offset.zero;
    // forward to the native pushOpacity with the coerced offset
  }
}
```

This one is on the path to full automation; treat it as the example of an
intervention that is *temporarily* manual behind a generator gate.

### 4.6 `InheritedWidget` ancestor-walk fallback (R5)

**Why it's permanent:** the interpreter collapses every interpreted class to a
single runtime `InterpretedInstance` type, so
`dependOnInheritedWidgetOfExactType<T>()` cannot match on `T` the way Dart's
element tree does. The runtime registration walks the element ancestry matching
on the *script class name* instead (`_findInheritedElementForType` →
`dependOnInheritedElement`). Because Dart provides no way to synthesise a
distinct runtime type per interpreted class, this fallback can never be
generated — it is documented as terminal.

This lives in `d4rt_runtime_registrations.dart` (the interceptor registrations
around `_findInheritedElementForType`), not as a `@D4rtUserBridge`, because it is
a cross-cutting lookup rather than a single-class override.

### 4.7 `bridgedSuperObject` identity proxies — `ChangeNotifier` / `Listenable`

**Why it's manual:** when an interpreted class extends `ChangeNotifier`, the
listener machinery must operate on a single, stable native object — otherwise
`addListener`/`notifyListeners` see different instances. The interface-proxy
registrations for `ChangeNotifier` and `Listenable` return the script's existing
`bridgedSuperObject` to preserve that identity. Identity preservation is a
semantic guarantee the generator cannot infer.

---

## 5. Root causes (why these remain manual)

The interventions above trace back to a small set of interpreter / type-system
limitations:

- **No runtime mixin synthesis.** The interpreter cannot add a native mixin to
  an interpreted class at runtime; the State/RenderBox proxy *families* exist to
  cover the mixin combinations (now generated, §3), but cases that need a
  *behavioural* change (4.1) stay manual.
- **No type-argument reification.** Generic class type parameters (`T` in
  `BasicMessageChannel<T>`, 4.2) and generic constructors are erased at the
  bridge boundary.
- **Collapsed `runtimeType`.** All interpreted instances share one runtime type,
  defeating type-keyed lookups like `dependOnInheritedWidgetOfExactType` (4.6).
- **Opaque external types.** Some native types expose no readable surface (4.3).
- **Platform signature skew.** VM vs web `dart:ui` signatures differ (4.5).
- **Defects in specific bridged paths.** Edge-case inputs that only misbehave
  through the bridge (4.4).

The first two are mitigated by configuration (§3); the rest require a human
decision and stay hand-written.

---

## 6. Adding a new override — checklist

1. Confirm the case isn't already covered by a generator knob (§3).
2. Create `lib/src/d4rt_user_bridges/<thing>_user_bridge.dart`, subclass
   `D4UserBridge`, annotate with `@D4rtUserBridge(libraryPath, className)`.
3. Write the `static` override method(s) with the signatures from §2a, using the
   `D4` helpers (`validateTarget`, `getRequiredArg`, `extractBridgedArgOrNull`,
   `coerceListOrNull`, `callInterpreterCallback`) — see
   `advanced_bridging_user_guide.md`.
4. Document *why* in a leading doc comment — these files are workarounds, and the
   "why" is the load-bearing part.
5. Regenerate bridges and run the bridge conformance corpus
   (`tom_d4rt_flutter/test/run_issue_analysis_tests.sh`) to confirm the override
   is picked up and nothing regresses.

---

## 7. References

- `advanced_bridging_user_guide.md` — `D4` helper API.
- `runtime_registration_surface.md` — `D4.register*` sinks and resolution order.
- `tom_d4rt_generator/doc/` — how the automated patterns (§3) are configured.
- `tom_d4rt_flutter/lib/src/d4rt_user_bridges/` — the live override examples
  quoted above.
