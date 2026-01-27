# D4rt Bridge Generator - TODO Items

This document tracks unbridgeable parameter types reported during bridge generation that may need manual intervention or future generator improvements.

**Log file:** [tom_generation_log.txt](tom_generation_log.txt)

---

## Summary of Unbridgeable Function Types

The generator currently cannot automatically bridge parameters with function types. These require either:
1. Manual UserBridge overrides
2. Future generator enhancements to support function type bridging
3. Wrapper classes that convert function types

---

## Issues by Project

### tom_core_kernel

| Class/Method | Parameter | Function Type | Priority |
|--------------|-----------|---------------|----------|
| `firstWhere` | `orElse` | `dynamic Function()?` | Medium |
| `lastWhere` | `orElse` | `dynamic Function()?` | Medium |
| `singleWhere` | `orElse` | `dynamic Function()?` | Medium |
| `update` | `ifAbsent` | `V Function()?` | Medium |

**Analysis:** These are standard Dart collection methods. The `orElse` parameter provides a fallback value when no match is found. Scripts can work around this by catching exceptions or checking conditions before calling.

---

### tom_core_server

| Class | Parameter | Function Type | Priority |
|-------|-----------|---------------|----------|
| `TomDbColumn` | `fromDbConverter` | `DART_TYPE Function(COL_TYPE)?` | Low |
| `TomDbColumn` | `toDbConverter` | `COL_TYPE Function(DART_TYPE)?` | Low |
| `TomPersistenceEventHandler` | `postPersist` | `void Function(DBTYPE)?` | Low |
| `TomPersistenceEventHandler` | `postLoad` | `void Function(DBTYPE)?` | Low |
| `TomPersistenceEventHandler` | `preLoad` | `void Function(DBTYPE)?` | Low |
| `TomPersistenceEventHandler` | `prePersist` | `void Function(DBTYPE)?` | Low |

**Analysis:** These are ORM/persistence configuration classes with generic type parameters. Function callbacks are used for type conversion and lifecycle hooks. Low priority as these are typically configured in native Dart code, not scripts.

---

### tom_core_flutter

| Class | Parameter | Function Type | Priority |
|-------|-----------|---------------|----------|
| `TomObservingWidget` | `child` | `Widget Function(T)` | Medium |
| `TomObservingWidgetState` | `child` | `Widget Function(T)` | Medium |
| `TomField` | `valueConverter` | `T Function(String)?` | Medium |
| `TomField` | `valueToTextConverter` | `String Function(T)?` | Medium |
| `TomField` | `inputValidator` | `String? Function(String)?` | Medium |
| `TomField` | `valueValidator` | `String? Function(String)?` | Medium |

**Analysis:** Flutter widget builders and form field validators. These are commonly needed in UI scripting scenarios. Consider:
- Adding support for simple `Widget Function(T)` patterns
- Providing pre-built validator functions that can be selected by name

---

### tom_build

| Class | Parameter | Function Type | Priority |
|-------|-----------|---------------|----------|
| `D4rtRunner` | `evaluator` | `D4rtEvaluator?` | Low |

**Analysis:** This is a type alias for an evaluator function. Low priority as this is infrastructure code.

---

## Potential Solutions

### Option 1: Function Wrapper Bridge

Create a `BridgedFunction` class that wraps D4rt-interpreted functions and allows them to be passed as callbacks:

```dart
// Native side
class BridgedFunction<R, A> {
  final D4rt interpreter;
  final String functionName;
  
  R call(A arg) {
    return interpreter.eval('$functionName($arg)') as R;
  }
}
```

### Option 2: Named Callback Registry

Register named callbacks that scripts can reference by string:

```dart
// Script
widget.setCallback('onTap', 'myTapHandler');

// Generated bridge
interpreter.registerCallback('myTapHandler', () => handleTap());
```

### Option 3: UserBridge Overrides

For specific high-priority cases, provide pre-built UserBridge overrides:

```dart
class IterableUserBridge extends D4UserBridge {
  static Object? overrideMethodFirstWhere(...) {
    // Handle orElse by catching exceptions
  }
}
```

---

## Action Items

- [ ] Investigate feasibility of BridgedFunction approach for simple function types
- [ ] Consider adding `orElse` overrides for collection methods as they're commonly used
- [ ] Document workarounds for function-type parameters in user guide
- [ ] Add configuration option to suppress function-type warnings for known patterns

---

## Notes

- Function types with generic parameters (e.g., `T Function(String)`) are particularly challenging
- Void callbacks (`void Function()`) are simpler and may be addressable first
- Some function types could potentially be bridged if D4rt supports callable objects
