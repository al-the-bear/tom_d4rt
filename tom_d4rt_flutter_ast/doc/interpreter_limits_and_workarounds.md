# Interpreter Limits and Workarounds — tom_d4rt_flutterm

Known fundamental limits of the D4rt interpreter when executing Flutter code,
where the limitation cannot be fixed purely in the interpreter and requires
bridge-side adapter infrastructure.

## Table of Contents

| # | Limitation | Test Failures | Status |
|---|-----------|---------------|--------|
| 1 | [Bridged mixins with `on` clauses](#1-bridged-mixins-with-on-clauses-singletickerprovider) | 15+ | Needs adapter |
| 2 | [Enum exhaustiveness in switch statements](#2-enum-exhaustiveness-in-switch-statements) | Many | Script workaround |
| 3 | [Sealed class exhaustiveness](#3-sealed-class-exhaustiveness) | TBD | Script workaround |
| 4 | [Platform capability (SystemColor)](#4-platform-capability-systemcolor) | 1 | Script workaround |
| 5 | [Abstract class inheritance](#5-abstract-class-inheritance) | State-related | Adapter + interceptor |
| 6 | [Real Dart isolates not supported](#6-real-dart-isolates-not-supported) | 1 (skipped) | Won't fix — fundamental limit |
| 7 | [FragmentProgram.fromAsset hangs on missing assets (Linux)](#7-fragmentprogramfromasset-hangs-on-missing-assets-linux) | 1 (skipped) | Script fix needed |
| 8 | [Action/Intent type-keyed dispatch](#8-actionintent-type-keyed-dispatch-with-user-defined-subclasses) | Several | Script workaround |

---

## 5. Abstract Class Inheritance

### Error Messages

```
Undefined property 'widget' on _MyState
Undefined property or method 'accent' on bridged instance of 'StatefulWidget'
Cannot access property 'X' on target of type null
```

### Impact

- All interpreted State subclasses accessing `widget`, `context`, `mounted` properties
- Affects any class extending an abstract bridged class where `bridgedSuperObject` cannot be instantiated

### Why This Can't Be Fixed Purely in the Interpreter

The interpreter maintains `bridgedSuperObject` — a native instance of the bridged superclass that handles inherited property/method access. For abstract classes (like `State`, `StatelessWidget`, `StatefulWidget`), we cannot instantiate them directly:

1. D4rt script declares `class _MyState extends State<MyWidget>`
2. Interpreter creates `InterpretedClass` with `bridgedSuperclass = StateBridge`
3. During constructor, implicit `super()` would create native `State` instance
4. But `State` is abstract — constructor fails, `bridgedSuperObject` remains null
5. Accessing `widget`, `setState`, `context` fails because they resolve via `bridgedSuperObject`

### Solution: Adapter Proxies + Property Interceptors

The solution has two parts:

**1. Adapter Proxies (`_InterpretedState`, etc.)**

Native adapter classes extend the abstract bridged class and hold a reference to the `InterpretedInstance`. These are created via `D4.registerInterfaceProxy()` and stored in `InterpretedInstance.nativeProxy`.

**2. Property Interceptors (RC-9)**

For properties like `widget` that return native wrappers but need to return `InterpretedInstance` objects, interceptors redirect the property access:

```dart
// The adapter implements an interface with the interpreted instance getter
abstract class InterpretedStateProxy {
  InterpretedInstance get interpretedWidget;
}

class _InterpretedState extends State<_InterpretedStatefulWidget>
    implements InterpretedStateProxy {
  @override
  InterpretedInstance get interpretedWidget => super.widget._instance;
  // ... lifecycle method delegation ...
}

// Register the property interceptor
D4.registerPropertyInterceptor('State', (instance, propertyName, nativeProxy, bridgedSuperObject, visitor) {
  if (propertyName == 'widget' && 
      bridgedSuperObject == null && 
      nativeProxy is InterpretedStateProxy) {
    return InterceptedValue(nativeProxy.interpretedWidget);
  }
  return null; // Fall through to normal handling
});
```

### How Property Access Works After the Fix

1. Script accesses `widget` on interpreted State subclass
2. `InterpretedInstance.get('widget')` is called
3. Since `bridgedSuperObject` is null, it uses `nativeProxy` as fallback
4. Before calling the getter adapter, `D4.interceptPropertyAccess()` is called
5. The registered interceptor detects `widget` access on `InterpretedStateProxy`
6. Returns `InterceptedValue(nativeProxy.interpretedWidget)` — the original script widget
7. Script receives the `InterpretedInstance` of its widget class, not the native wrapper

### Implementation Location

- Adapter classes: [d4rt_runtime_registrations.dart](../lib/src/d4rt_runtime_registrations.dart)
- Property interceptors: same file, `_registerPropertyInterceptors()`
- Interceptor mechanism: [D4 class](../../tom_d4rt_ast/lib/src/runtime/generator/d4.dart) (RC-9 section)
- Documentation: [Advanced Bridging User Guide](../../tom_d4rt/doc/advanced_bridging_user_guide.md#rc-9-property-interceptors)

---

## 2. Enum Exhaustiveness in Switch Statements

### Error Messages

```
'>' called on null
Cannot access property 'value' on target of type null
Non-exhaustive switch statement: case X not handled
```

### Impact

- Many test scripts using switch statements/expressions on Material enums
- Affects: `ButtonBarLayoutBehavior`, `ButtonTextTheme`, `DropdownMenuCloseBehavior`, `ColorSpace`, etc.

### Why This Can't Be Fixed in the Interpreter

Dart's exhaustive switch checking is a compile-time feature. The D4rt interpreter:

1. **Cannot perform exhaustive analysis**: Bridged enum values are runtime objects without complete type metadata
2. **Switch evaluation returns null**: When no case matches a bridged enum value, the switch returns null instead of throwing an exhaustiveness error
3. **Subsequent operations fail**: Code that expects a non-null result (`.value`, comparison operators) fails with misleading errors

### Script Workaround

**Always add a `default:` case to enum switches in D4rt scripts:**

```dart
// BEFORE: Fails in D4rt interpreter
String describe(ButtonTextTheme theme) {
  switch (theme) {
    case ButtonTextTheme.normal: return 'Normal';
    case ButtonTextTheme.accent: return 'Accent';
    case ButtonTextTheme.primary: return 'Primary';
  }
}

// AFTER: Works in D4rt interpreter
// D4RT-LIMITATION: enum exhaustiveness
String describe(ButtonTextTheme theme) {
  switch (theme) {
    case ButtonTextTheme.normal: return 'Normal';
    case ButtonTextTheme.accent: return 'Accent';
    case ButtonTextTheme.primary: return 'Primary';
    default: return 'Unknown: ${theme.name}';
  }
}

// For switch expressions, use wildcard:
final desc = switch (theme) {
  ButtonTextTheme.normal => 'Normal',
  ButtonTextTheme.accent => 'Accent',
  ButtonTextTheme.primary => 'Primary',
  _ => 'Unknown',  // D4RT-LIMITATION: enum exhaustiveness
};
```

### Fixed Scripts

- `retest/dart_ui/color_space_test.dart` (index 13)
- `retest/material/button_bar_layout_behavior_test.dart` (index 25)
- `retest/material/button_text_theme_test.dart` (index 27)
- `retest/material/dropdown_menu_close_behavior_test.dart` (index 30)

---

## 3. Sealed Class Exhaustiveness

### Impact

Same issue as enum exhaustiveness but for sealed class hierarchies.

### Script Workaround

Add a `default:` case or `_` wildcard to handle unmatched sealed class subtypes.

---

## 4. Platform Capability (SystemColor)

### Error Messages

```
Unsupported operation: SystemColor not supported on the current platform.
```

### Impact

- Scripts accessing `ui.SystemColor.light` or `ui.SystemColor.dark`
- Fails on Linux and some embedded platforms

### Why This Isn't an Interpreter Bug

This is a genuine platform limitation. Some platforms (e.g., Linux) don't expose system color palette data to the Flutter engine. The same exception occurs in native Dart execution.

### Script Workaround

**Wrap SystemColor access in try-catch:**

```dart
// D4RT-LIMITATION: Platform capability - SystemColor not supported on all platforms
ui.SystemColorPalette? light;
String? platformError;

try {
  light = ui.SystemColor.light;
} catch (e) {
  platformError = e.toString();
  print('WARNING: SystemColor not supported: $platformError');
}

if (light == null) {
  // Return fallback UI
  return FallbackWidget();
}
```

### Fixed Scripts

- `retest/dart_ui/system_color_palette_test.dart` (index 16)

---

## 1. Bridged Mixins with `on` Clauses (SingleTickerProvider)

### Error Messages

```
Runtime Error: Bridged class 'SingleTickerProviderStateMixin' cannot be used as a mixin.
Set canBeUsedAsMixin=true when registering the bridge.
```

```
Runtime Error: Type 'State' in 'on' clause of mixin '_TickerProviderShim' not found.
Ensure it's defined.
```

### Impact

- **15 test failures** from scripts using `SingleTickerProviderStateMixin`
- Affects all animation-heavy widgets (transitions, animated containers, tab controllers)
- Additional 5+ failures from `_TickerProviderShim` workaround attempts in test scripts

### Why This Can't Be Fixed in the Interpreter

The `SingleTickerProviderStateMixin` pattern requires:

```dart
class _MyState extends State<MyWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
  }
}
```

Two fundamental problems:

1. **Mixin `on` clause resolution**: `SingleTickerProviderStateMixin` has an `on State<StatefulWidget>` clause. Even if we set `canBeUsedAsMixin=true`, the interpreter would need to verify that the interpreted class satisfies the `on` constraint — matching a bridged `State` type against an interpreted class hierarchy.

2. **`vsync: this`**: The `AnimationController` constructor expects a native `TickerProvider` argument. Passing `this` (an `InterpretedInstance`) fails because `InterpretedInstance` does not implement `TickerProvider`. The existing `_InterpretedTickerProvider` proxy handles this at the interface level, but the mixin integration (where `this` is both a `State` and a `TickerProvider`) creates a dual-identity problem that the current proxy system doesn't solve.

### Workaround: Adapter Classes

See [Proposal: TickerProvider Adapter Solution](#proposal-tickerprovider-adapter-solution) below.

### Affected Scripts (examples)

- `rendering/render_animated_opacity_test.dart`
- `rendering/alignment_geometry_tween_test.dart`
- `material/stepper_state_test.dart`
- All `*_transition_test.dart` files

---

## Proposal: TickerProvider Adapter Solution

### Context

The existing codebase already has adapter patterns for bridging interpreted classes
to native Flutter types:

| Adapter | Purpose | Location |
|---------|---------|----------|
| `_InterpretedTickerProvider` | `TickerProvider` interface delegation | [d4rt_runtime_registrations.dart](../lib/src/d4rt_runtime_registrations.dart) |
| `_InterpretedStatelessWidget` | `StatelessWidget.build()` delegation | same file |
| `_InterpretedStatefulWidget` | `StatefulWidget.createState()` delegation | same file |
| `_InterpretedState` | `State` lifecycle delegation | same file |

### The Problem

The existing `_InterpretedTickerProvider` handles the case where a standalone class
implements `TickerProvider`. But the common Flutter pattern is:

```dart
class _MyState extends State<MyWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: ...);
  }
}
```

Here, `this` must be **both** a `State` and a `TickerProvider` simultaneously.
The `_InterpretedState` proxy is a `State` but not a `TickerProvider`.

### Proposed Solution: `_InterpretedTickerProviderState`

Create a specialized State proxy that also implements `TickerProvider`, combining
the roles of `_InterpretedState` and `_InterpretedTickerProvider`:

```dart
/// State proxy that also provides TickerProvider capabilities.
/// Used when an interpreted State subclass mixes in SingleTickerProviderStateMixin
/// or TickerProviderStateMixin.
class _InterpretedTickerProviderState extends State<_InterpretedStatefulWidget>
    with SingleTickerProviderStateMixin {
  final InterpreterVisitor _visitor;
  final InterpretedInstance _stateInstance;

  _InterpretedTickerProviderState(this._visitor, this._stateInstance, _);

  // -- State lifecycle delegation (same as _InterpretedState) --

  @override
  void initState() {
    super.initState();
    _callVoidMethod('initState');
  }

  @override
  Widget build(BuildContext context) {
    final method = _stateInstance.klass.findInstanceMethod('build');
    if (method != null) {
      final bound = method.bind(_stateInstance);
      final result = bound.call(_visitor, [context], {});
      return D4.extractBridgedArg<Widget>(result, 'build');
    }
    throw StateError(
      'Interpreted State ${_stateInstance.klass.name} does not implement build()',
    );
  }

  @override
  void dispose() {
    _callVoidMethod('dispose');
    super.dispose();
  }

  // ... remaining lifecycle methods ...

  void _callVoidMethod(String name) {
    final method = _stateInstance.klass.findInstanceMethod(name);
    if (method != null) {
      try {
        method.bind(_stateInstance).call(_visitor, [], {});
      } catch (_) {}
    }
  }
}
```

### Integration Point

In `_InterpretedStatefulWidget.createState()`, detect whether the interpreted State
class uses `SingleTickerProviderStateMixin` or `TickerProviderStateMixin` and
return the appropriate proxy:

```dart
@override
State<_InterpretedStatefulWidget> createState() {
  // ... existing method invocation ...
  if (result is InterpretedInstance) {
    // Check if the State subclass mixes in TickerProvider
    if (_usesSingleTickerProvider(result.klass)) {
      return _InterpretedTickerProviderState(_visitor, result, this);
    }
    return _InterpretedState(_visitor, result, this);
  }
}

bool _usesSingleTickerProvider(InterpretedClass klass) {
  return klass.mixins.any((m) =>
    m.name == 'SingleTickerProviderStateMixin' ||
    m.name == 'TickerProviderStateMixin');
}
```

### Why `with SingleTickerProviderStateMixin` Works

The key insight is that the **native** `_InterpretedTickerProviderState` class
mixes in the **native** `SingleTickerProviderStateMixin`. This means:

1. `createTicker()` is provided by the native mixin — no interpreter delegation needed
2. `AnimationController(vsync: this)` works because `this` is a native `TickerProvider`
3. Ticker lifecycle (active ticker disposal) is handled by the native mixin's `dispose()`
4. The interpreted `initState()` can call `AnimationController(vsync: this)` and
   the `this` reference in the D4rt script's scope needs to resolve to the native
   proxy (not the `InterpretedInstance`)

### Open Question: `this` Binding

The remaining challenge is making `this` in the interpreted script resolve to the
native `_InterpretedTickerProviderState` proxy when passed as `vsync: this`.
Options:

**A. Inject the proxy as `this` in the interpreted environment:**
Before calling interpreted lifecycle methods, set `this` to the native proxy.
This way `vsync: this` passes the native object.

**B. Register a type coercion for TickerProvider:**
Already exists — `_InterpretedTickerProvider` proxy is registered. But when
`this` is an `InterpretedInstance`, the coercion to `TickerProvider` creates a
**new** proxy that delegates `createTicker()` back to the interpreter — which
doesn't have a native implementation of `createTicker()`.

**C. Override the TickerProvider proxy for State subclasses:**
When creating the `_InterpretedTickerProviderState`, register the native proxy
as the "self" reference for the `InterpretedInstance`. When `this` is used as a
`TickerProvider` argument, the proxy system returns the native State object
instead of creating a delegation wrapper.

**Recommended: Option C.** The native proxy holds the real `SingleTickerProviderStateMixin`
implementation. When the script calls `AnimationController(vsync: this)`, the
argument extraction should detect that `this` (an `InterpretedInstance` whose
native proxy is a `_InterpretedTickerProviderState`) should be passed as the
native proxy directly, since it already satisfies the `TickerProvider` interface.

This could be implemented by storing a `nativeProxy` reference on `InterpretedInstance`:

```dart
// In _InterpretedStatefulWidget.createState():
final nativeState = _InterpretedTickerProviderState(_visitor, result, this);
result.nativeProxy = nativeState; // Store reference for argument extraction

// In D4.extractBridgedArg<T>():
if (value is InterpretedInstance && value.nativeProxy is T) {
  return value.nativeProxy as T;
}
```

### Additional Adapters Needed

For `TickerProviderStateMixin` (multiple tickers), a separate
`_InterpretedMultiTickerProviderState` using `with TickerProviderStateMixin`
may be needed, but the pattern is identical.

No separate `TickerCallbackAdapter` or `TickerAdapter` is needed — the native
`SingleTickerProviderStateMixin` provides `createTicker()` which returns a native
`Ticker` directly. The `TickerCallback` (a `void Function(Duration)` typedef)
is already handled by the existing callback wrapping in the bridge system.

---

## Generic function-typed return values from interpreted overrides (Bug-47 partial)

**Status:** *Partial* — the most common case (single-arg, no-arg, two-arg
nullable function types) works after the regex fix in
[`d4.dart`](../../tom_d4rt_ast/lib/src/runtime/generator/d4.dart). Fully
generic function-type adaptation requires per-call-site typed wrapper
emission in the bridge generator, which is not implemented yet.

### The problem

A bridged class has an abstract method or getter typed
`R Function(A)?` (or any other strict function type). A script subclass
overrides it:

```dart
class _MyPainter extends CustomPainter {
  @override
  SemanticsBuilderCallback? get semanticsBuilder {
    return (Size size) {
      return [
        CustomPainterSemantics(rect: ..., properties: ...),
        ...
      ];
    };
  }
}
```

The auto-generated proxy (e.g. `D4rtCustomPainter` in
`flutter_proxies.b.dart`) calls the interpreted getter to satisfy its
own native callback. The getter returns an `InterpretedFunction`. The
proxy then calls
`D4.extractBridgedArg<List<CustomPainterSemantics> Function(Size)?>(...)`
to coerce the value to the strict native function type.

`extractBridgedArg` does try to wrap a `Callable` into a Dart closure
via `_wrapCallableForMap<T>` — but the wrapper is constructed with
*untyped parameters* (`(arg) { ... }` returns `dynamic Function(dynamic)`).
Dart's reified function-type subtyping then refuses the assignment:

```dart
dynamic Function(dynamic) is List<CustomPainterSemantics> Function(Size)? // false
```

So the wrapper falls back through every path, the original
`InterpretedFunction` is forwarded across the bridge, and the bridge's
argument validator rejects it:

```
Argument Error: Invalid parameter "semanticsBuilder":
  expected ((Size) => List<CustomPainterSemantics>)?,
  got InterpretedFunction
```

### What was fixed

The `_isSingleArgFunction` / `_isNoArgFunction` / `_isTwoArgFunction`
regexes in `d4.dart` were updated to recognize **nullable** function
types (`Function(...)?`). Before the fix the regexes anchored to `)$`
and missed every nullable function type, falling all the way through to
the variadic dynamic wrapper. Now the type-class detection works
correctly. This is enough for single/no/two-arg cases that don't need
strict reified subtype checks (e.g. when assigned to a `Function`
parameter or used in a `late dynamic` field).

### What still doesn't work

When the bridge generator emits a strict-typed call site like:

```dart
return D4.extractBridgedArg<List<CustomPainterSemantics> Function(Size)?>(
    result, 'semanticsBuilder');
```

…the runtime cannot construct a closure with the exact static type
`List<CustomPainterSemantics> Function(Size)` from a `Callable` and
runtime type info alone (Dart has no `dart:mirrors` to do this
generically). The wrapped closure remains `dynamic Function(dynamic)`
and the assignment fails the reified-type check.

### Script-level workaround

There is **no clean script-level workaround** for the override-and-be-used
case: once a script returns a closure across a strictly-typed bridge
boundary, the return cannot be reified to the exact required signature.
The closest workarounds are:

- **Don't override the method/getter** that returns the function type.
  For `CustomPainter.semanticsBuilder`, simply do not override it
  (the inherited default returns `null`).
- **Substitute a non-function-typed override** when possible. E.g. for
  callbacks that the framework only ever invokes once with arguments
  the script also has access to elsewhere, capture the result statically
  and expose it via a different field.
- **Use a `StatefulWidget` wrapper** that exposes the desired callback
  via a parameter instead of an inheritance override. The native side
  then receives the closure as a constructor argument (where simpler
  callback-bridging machinery applies) instead of an inheritance
  override (which goes through the strict reified-type check).

For deep-demo scripts that need to demonstrate `semanticsBuilder` itself,
none of these is satisfactory — see "Proper fix" below.

### Proper fix (bridge generator)

The proxy generator (in `tom_d4rt_generator`) needs to emit typed
closures at the call site. Because the generator already knows the exact
static signature from the original Flutter class, it can produce code
shaped like:

```dart
onSemanticsBuilder: instance.klass.findInstanceGetter('semanticsBuilder') != null
    ? () {
        final getter = instance.klass.findInstanceGetter('semanticsBuilder');
        if (getter == null) return null;
        final raw = getter.bind(instance).call(visitor, [], {});
        if (raw == null) return null;
        final c = raw as Callable;
        // The wrapper has the exact static type the proxy needs:
        return (Size size) {
          final out = c.call(visitor, [size], {});
          return D4.extractBridgedArg<List<CustomPainterSemantics>>(
              out, 'semanticsBuilder');
        };
      }
    : null,
```

Once the wrapper has the exact static type, no `is T` round-trip is
needed — the assignment is statically valid. The same change applies to
every proxy returning a typed function value (CustomClipper, FlowDelegate,
SliverPersistentHeaderDelegate, etc.) and to every constructor parameter
typed `T Function(...)`.

This requires re-running the bridge generator and regenerating every
`.b.dart` file under `tom_d4rt_flutterm/lib/src/bridges/`.

---

## 6. Real Dart Isolates Not Supported

### Error Messages

```
NoSuchMethodError: The getter 'sendPort' was called on null.
Null check operator used on a null value
IsolateNameServer.registerPortWithName returned false
```

### Impact

- Any script using `IsolateNameServer` (registering/looking up ports by name)
- Any script using `Isolate.spawn()` or `Isolate.run()`
- Any script using `ReceivePort` / `SendPort` for cross-isolate communication
- Affected test: `dart_ui/isolate_name_server_test.dart` (skipped in `hardly_relevant_classes_1_test.dart`)

### Why This Cannot Be Fixed

The D4rt interpreter runs all interpreted code in a **single Dart isolate** (the
host application's main isolate). It provides limited async/await simulation via
`Future` and `Stream` bridge support, but it does not spawn real OS-level
isolates and therefore cannot support:

1. **`Isolate.spawn()`** — requires transferring a closure to a new native isolate.
   The interpreter cannot serialize an `InterpretedFunction` across the isolate
   boundary.
2. **`IsolateNameServer.registerPortWithName()` / `lookupPortByName()`** — these
   APIs register `SendPort` objects in a global registry shared across isolates.
   Without real isolate spawning, there are no secondary isolates whose ports
   could be registered, and the registry is always empty.
3. **`ReceivePort` / `SendPort` for cross-isolate messages** — message passing
   between isolates relies on the Dart runtime's inter-isolate channel. The
   interpreter has no mechanism to intercept or synthesize these channels.

### Status

**Won't fix — fundamental limit.** The interpreter is intentionally single-threaded
to maintain sandboxing guarantees. Supporting real isolates would require either:
- Native host code to pre-spawn isolates and proxy interpreted code into them
  (very complex, breaks sandboxing), or
- A first-class "simulated isolate" model (major interpreter rework, not planned).

### Test Disposition

Tests covering `IsolateNameServer` are **skipped** with a note in the test file.
This is tracked here as a known limitation rather than a bug.

---

## 7. FragmentProgram.fromAsset Hangs on Missing Assets (Linux)

### Error Messages

```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds.
  dart:isolate  _RawReceivePort._handleMessage
```

No `[METRIC]` line follows; the HTTP request never returns.

### Impact

- `dart_ui/image_sampler_slot_test.dart` — calls
  `ui.FragmentProgram.fromAsset('shaders/not_existing_sampler_demo.frag')`
  inside a widget `initState` async callback.
- On the Linux desktop test runner, the platform message for a missing
  asset sometimes never returns. The test app process stays alive but
  blocked on the platform channel, so the test times out after 30 s and
  all subsequent tests in the suite also time out (the `/clear` endpoint
  is also blocked).

### Why It Is Intermittent

The asset loading is handled by Flutter's engine platform channel. On
Linux (particularly with `flutter run -d linux` in test mode), the
platform responder for asset loads is non-deterministic: sometimes it
responds quickly with "asset not found", sometimes it blocks indefinitely.
The test passed in the original run but failed in the re-run after
`isolate_name_server_test.dart` was skipped.

### Root Cause in the Script

The script intentionally probes `FragmentProgram.fromAsset` with a
non-existent path as a "capability probe":

```dart
try {
  await ui.FragmentProgram.fromAsset('shaders/not_existing_sampler_demo.frag');
  _record('FragmentProgram.fromAsset probe', true);
} catch (e) {
  _record('FragmentProgram.fromAsset probe', true,
      note: 'Expected in test env without bundled shader asset: $e');
}
```

The intent is to catch the exception and record it. But the `await` never
returns when the platform channel hangs.

### Script Fix

Wrap the `fromAsset` call in a `Future.any` race with a short timeout:

```dart
// D4RT-WORKAROUND: FragmentProgram.fromAsset hangs on Linux for missing assets.
// Race with a timeout so the probe degrades gracefully.
try {
  await Future.any(<Future<void>>[
    ui.FragmentProgram.fromAsset('shaders/not_existing_sampler_demo.frag'),
    Future<void>.delayed(const Duration(seconds: 2)),
  ]);
  _record('FragmentProgram.fromAsset probe', true);
} catch (e) {
  _record('FragmentProgram.fromAsset probe', true,
      note: 'Expected in test env: $e');
}
```

Until the script is fixed, the test is **skipped** in
`hardly_relevant_classes_1_test.dart` to prevent test-suite cascade
failures.

---

## 8. Action/Intent Type-Keyed Dispatch with User-Defined Subclasses

### Error Messages

```
flutter: Unable to find an action for an Intent with type _InterpretedIntent in an Actions widget.
```

Or silently returns null when `Actions.invoke<T>(context, intent)` is called with a
user-defined Intent subclass.

### Impact

- Any script that defines custom Intent subclasses and uses them with `Actions.invoke<T>` or
  `Actions(actions: {MyIntentClass: myAction})`.
- Affects: `context_action_test.dart` and any other script with user-defined Action/Intent pairs.

### Why This Cannot Be Fixed in the Interpreter

Dart's `Actions` widget dispatches by `intent.runtimeType`. It does:

```dart
actions[intent.runtimeType]; // looks up the action by the intent's runtime Type
```

In D4rt, **all** user-defined Intent subclasses are wrapped in a single native proxy class
`_InterpretedIntent`. Dart does not allow creating new `Type` values at runtime, so every
interpreted Intent subclass has `runtimeType == _InterpretedIntent` — regardless of the
script-level class name.

When the `Actions` widget is constructed with:
```dart
Actions(
  actions: {GreetIntent: greetAction, ToggleIntent: toggleAction},
  ...
)
```

D4rt coerces this map via `D4.coerceMap<Type, Action<Intent>>`. The map keys are
`InterpretedClass` objects (the D4rt class descriptors). `coerceMapKey<Type>` converts each
`InterpretedClass` to its nearest bridged native supertype — which is `Intent` for all of them.
The resulting native map is `{Intent: lastAction}`, collapsing all entries to a single key.

At dispatch time, `actions[intent.runtimeType]` = `actions[_InterpretedIntent]` — neither
`Intent` nor `_InterpretedIntent` is in the map, so no action is found.

This is **fundamental to Dart's type system**: there is no API to create a new distinct
runtime `Type` value without declaring a new class at compile time.

The proxy factory emits a `debugPrint` warning the first time each interpreted Intent class
is wrapped, identifying the class name and explaining the limitation:
```
[D4rt] D4rt-LIMIT: User-defined Intent subclass "GreetIntent" wrapped as _InterpretedIntent.
Actions.invoke<GreetIntent> / type-keyed dispatch (...) will NOT work — all interpreted Intent
subclasses share runtimeType _InterpretedIntent at runtime. Workaround: call
action.invoke(intent[, context]) directly on the Action instance.
```

### Partial Support: SDK-Provided Intent Types

**Intent subclasses defined in the Flutter SDK itself work correctly** because they are real
Dart classes with distinct `runtimeType` values. These can be used with `Actions.invoke<T>`
and `Actions(actions: {T: myAction})` without any workaround:

| SDK Intent Type | Works with `Actions.invoke`? |
|----------------|------------------------------|
| `VoidCallbackIntent` | ✅ Yes |
| `DismissIntent` | ✅ Yes |
| `ScrollIntent` | ✅ Yes |
| `ActivateIntent` | ✅ Yes |
| `ButtonActivateIntent` | ✅ Yes |
| `ExpandSelectionByCharacterIntent` | ✅ Yes |
| `SelectAllTextIntent` | ✅ Yes |
| `CopySelectionTextIntent` | ✅ Yes |
| `DoNothingIntent` | ✅ Yes |
| Any other SDK-defined Intent | ✅ Yes |
| **User-defined `class MyIntent extends Intent`** | ❌ No |

User-defined `Action` subclasses (e.g. `class MyAction extends Action<MyIntent>`) work
correctly when invoked directly — the `invoke()` method delegates to the interpreter. Only
the type-keyed lookup mechanism (`Actions.invoke<T>`, `Actions(actions: {T: ...})`) fails.

### Script Workaround

Replace all `Actions.invoke<T>(context, intent)` calls with direct invocation on the action
instance:

```dart
// BEFORE: Fails — type-keyed dispatch cannot find the action
Actions.invoke<GreetIntent>(context, const GreetIntent('World'));

// AFTER: Works — call action.invoke() directly
// D4RT-LIMITATION: Actions.invoke type-keyed dispatch (#8) — call directly
greetAction.invoke(const GreetIntent('World'), context);
```

Similarly, replace `Actions.find<T>(context)` (which also uses type-keyed lookup) by
extracting the action instance before the `Actions` widget:

```dart
// BEFORE: Fails
final action = Actions.find<GreetIntent>(context) as GreetContextAction;

// AFTER: Use the already-known action variable directly
// D4RT-LIMITATION: Actions.find type-keyed lookup (#8) — use variable directly
final action = greetAction; // variable declared before the Actions widget
```

For `Actions(actions: {T: action})` widget construction, the map will silently collapse to a
single entry; the widget tree still renders, but `Actions.invoke` won't work. Continue
providing the map for documentation purposes, but add the direct-call workaround for all
invoke sites.

### Fixed Scripts

- `retest/widgets/context_action_test.dart` — all `Actions.invoke<T>` and `Actions.find<T>`
  calls replaced with direct action invocation. All 9 dispatch sites rewritten.

### Surveyed Test Files (33 Action/Intent scripts checked)

The following patterns were identified across the full retest corpus:

| Pattern | Files | Works? |
|---------|-------|--------|
| SDK Intent types with `Actions.invoke` (e.g. `ScrollIntent`, `DismissIntent`) | Several | ✅ Yes |
| User-defined `Action` subclass direct `invoke()` | Several | ✅ Yes |
| `Actions(actions: {SdkIntent: action})` widget construction | Several | ✅ Yes |
| `Actions.invoke<UserDefinedIntent>(ctx, intent)` | `context_action_test.dart` | ❌ No |
| `Actions.find<UserDefinedIntent>(ctx)` | `context_action_test.dart` | ❌ No |
| `Actions(actions: {UserDefinedIntent: action})` map key | `context_action_test.dart` | ❌ Collapsed |
