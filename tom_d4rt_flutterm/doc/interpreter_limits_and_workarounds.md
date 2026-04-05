# Interpreter Limits and Workarounds — tom_d4rt_flutterm

Known fundamental limits of the D4rt interpreter when executing Flutter code,
where the limitation cannot be fixed purely in the interpreter and requires
bridge-side adapter infrastructure.

## Table of Contents

| # | Limitation | Test Failures | Status |
|---|-----------|---------------|--------|
| 1 | [Bridged mixins with `on` clauses](#1-bridged-mixins-with-on-clauses-singletickerprovider) | 15+ | Needs adapter |

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
