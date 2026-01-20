# UserBridge Override System Design

**Status:** Implemented
**Quest:** tom_core (D4rt Bridge Generator)
**Date:** 2026-01-19

## Overview

This specification describes a system for providing handwritten bridge method overrides that integrate elegantly with auto-generated bridges. The generated bridge references static methods from a user-defined class, allowing selective override of individual methods without excluding the entire class from generation.

## Base Class

All user bridges must extend `D4UserBridge` from `package:tom_d4rt/d4rt.dart`:

```dart
import 'package:tom_d4rt/d4rt.dart';

class MyListUserBridge extends D4UserBridge {
  // Static override methods...
}
```

**Important:** 
- Classes extending `D4UserBridge` are automatically excluded from bridge generation - they are helper classes, not classes to be bridged.
- All override methods must be **static**.
- The `extends D4UserBridge` pattern ensures reliable exclusion even if similar class names exist in the codebase.

## Problem Statement

Current approach requires:
1. Exclude entire class from generation via `excludeClasses`
2. Write complete handwritten bridge for that class
3. Maintain entire handwritten bridge when source class changes

**Issues:**
- All-or-nothing: Can't fix just one method while generating the rest
- Maintenance burden: Must update handwritten bridge for any class change
- Duplication: Most of the bridge code is still boilerplate

## Solution Design

### Concept

For each bridged class `Foo`, the generator looks for a companion class `FooUserBridge` extending `D4UserBridge`. If found:
1. Generator scans `FooUserBridge` for **static** override methods
2. For each detected override, generator calls `FooUserBridge.overrideXxx(...)` instead of generating code
3. All classes extending `D4UserBridge` are automatically excluded from generation

### Naming Convention

All override methods must be **static**. The generated code references them directly as `FooUserBridge.overrideXxx(...)`.

| Member Type | User Override Method (static) | Generated Code |
|-------------|------------------------------|----------------|
| Constructor `Foo()` | `static overrideConstructor(visitor, positional, named)` | `FooUserBridge.overrideConstructor` |
| Named constructor `Foo.named()` | `static overrideConstructorNamed(visitor, positional, named)` | `FooUserBridge.overrideConstructorNamed` |
| Instance getter `value` | `static overrideGetterValue(visitor, target)` | `FooUserBridge.overrideGetterValue` |
| Instance setter `value=` | `static overrideSetterValue(visitor, target, value)` | `FooUserBridge.overrideSetterValue` |
| Instance method `doWork()` | `static overrideMethodDoWork(visitor, target, positional, named)` | `FooUserBridge.overrideMethodDoWork` |
| Static getter `instance` | `static overrideStaticGetterInstance(visitor)` | `FooUserBridge.overrideStaticGetterInstance` |
| Static setter `config=` | `static overrideStaticSetterConfig(visitor, value)` | `FooUserBridge.overrideStaticSetterConfig` |
| Static method `create()` | `static overrideStaticMethodCreate(visitor, positional, named)` | `FooUserBridge.overrideStaticMethodCreate` |
| Operator `[]` | `static overrideOperatorIndex(visitor, target, positional, named)` | `FooUserBridge.overrideOperatorIndex` |
| Operator `[]=` | `static overrideOperatorIndexAssign(visitor, target, positional, named)` | `FooUserBridge.overrideOperatorIndexAssign` |
| `nativeNames` | `List<String> get nativeNames` | Uses getter value |

### Operator Override Methods

All operators have corresponding override method names defined in `D4UserBridge.operatorMethodNames`:

| Operator | Override Method |
|----------|-----------------|
| `[]` | `overrideOperatorIndex` |
| `[]=` | `overrideOperatorIndexAssign` |
| `+` | `overrideOperatorPlus` |
| `-` | `overrideOperatorMinus` |
| `*` | `overrideOperatorMultiply` |
| `/` | `overrideOperatorDivide` |
| `~/` | `overrideOperatorIntegerDivide` |
| `%` | `overrideOperatorModulo` |
| `==` | `overrideOperatorEquals` |
| `<` | `overrideOperatorLessThan` |
| `>` | `overrideOperatorGreaterThan` |
| `<=` | `overrideOperatorLessThanOrEqual` |
| `>=` | `overrideOperatorGreaterThanOrEqual` |
| `&` | `overrideOperatorBitwiseAnd` |
| `|` | `overrideOperatorBitwiseOr` |
| `^` | `overrideOperatorBitwiseXor` |
| `~` | `overrideOperatorBitwiseNot` |
| `<<` | `overrideOperatorLeftShift` |
| `>>` | `overrideOperatorRightShift` |
| `>>>` | `overrideOperatorUnsignedRightShift` |
| `unary-` | `overrideOperatorUnaryMinus` |

### Example

**Source class:**
```dart
class MyList<T> {
  final List<T> _items = [];
  
  T operator [](int index) => _items[index];
  void operator []=(int index, T value) => _items[index] = value;
  
  int get length => _items.length;
  void add(T item) => _items.add(item);
  
  static MyList<T> empty<T>() => MyList<T>();
}
```

**User override class:**
```dart
// lib/src/d4rt_bridges/my_list_user_bridge.dart
import 'package:tom_d4rt/d4rt.dart';

/// User overrides for MyList bridge.
/// 
/// Only override methods that need custom handling.
/// All other members will be auto-generated.
class MyListUserBridge extends D4UserBridge {
  /// Custom nativeNames for internal implementations.
  @override
  List<String> get nativeNames => ['_GrowableList', '_FixedLengthList'];
  
  /// Override operator[] - not auto-generated.
  Object? overrideOperatorIndex(
    Object? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final list = D4.validateTarget<MyList>(target, 'MyList');
    final index = D4.getRequiredArg<int>(positional, 0, 'index', '[]');
    return list[index];
  }
  
  /// Override operator[]= - not auto-generated.
  dynamic overrideOperatorIndexAssign(
    InterpreterVisitor? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final list = D4.validateTarget<MyList>(target, 'MyList');
    final index = D4.getRequiredArg<int>(positional, 0, 'index', '[]=');
    final value = positional[1];
    list[index] = value;
    return value;
  }
}
```

**Generated bridge (extends user bridge):**
```dart
// lib/src/d4rt_bridges/my_list_bridge.g.dart (generated)

class _MyListBridgeImpl extends MyListUserBridge {
  BridgedClass createBridge() {
    return BridgedClass(
      nativeType: MyList,
      name: 'MyList',
      nativeNames: nativeNames, // From user bridge
      constructors: {
        '': (visitor, positional, named) {
          // Auto-generated
          return MyList();
        },
      },
      getters: {
        'length': (visitor, target) {
          // Auto-generated
          return D4.validateTarget<MyList>(target, 'MyList').length;
        },
      },
      methods: {
        'add': (visitor, target, positional, named) {
          // Auto-generated
          final t = D4.validateTarget<MyList>(target, 'MyList');
          final item = D4.getRequiredArg<Object?>(positional, 0, 'item', 'add');
          t.add(item);
          return null;
        },
        // Uses override from user bridge
        '[]': (visitor, target, positional, named) =>
            overrideOperatorIndex(visitor, target, positional, named),
        '[]=': (visitor, target, positional, named) =>
            overrideOperatorIndexAssign(visitor, target, positional, named),
      },
      staticMethods: {
        'empty': (visitor, positional, named) {
          // Auto-generated
          return MyList.empty();
        },
      },
    );
  }
}

// Bridge factory function
BridgedClass _createMyListBridge() {
  return _MyListBridgeImpl().createBridge();
}
```

## Configuration

### Finding User Bridge Files

Option 1: **Convention-based** (recommended)
- Look for `{class_name}_user_bridge.dart` in same directory as output
- Or in a `user_bridges/` subdirectory

Option 2: **Configuration-based**
```yaml
# build.yaml
modules:
  - name: all
    barrelFiles:
      - lib/my_package.dart
    outputPath: lib/src/d4rt_bridges/bridges.dart
    userBridgePath: lib/src/d4rt_bridges/user_bridges/  # Optional
```

Option 3: **Annotation-based**
```dart
@D4rtUserBridge(MyList)
class MyListUserBridge { ... }
```

**Recommendation:** Use Option 1 (convention) as default, with Option 2 as override.

### Discovery Algorithm

1. For each class `Foo` being bridged:
   - Look for `FooUserBridge` class in:
     a. `{output_dir}/user_bridges/foo_user_bridge.dart`
     b. `{output_dir}/foo_user_bridge.dart`
     c. Any file matching `*_user_bridge.dart` in output directory
2. If found, parse the class for override methods
3. Build override map: `{memberName: overrideMethodName}`

## Override Method Signatures

### Constructor Overrides

```dart
/// Default constructor override
Object overrideConstructor(
  InterpreterVisitor? visitor,
  List<Object?> positional,
  Map<String, Object?> named,
);

/// Named constructor override (e.g., Foo.fromJson)
Object overrideConstructorFromJson(
  InterpreterVisitor? visitor,
  List<Object?> positional,
  Map<String, Object?> named,
);
```

### Instance Member Overrides

```dart
/// Getter override
Object? overrideGetterPropertyName(
  InterpreterVisitor? visitor,
  Object? target,
);

/// Setter override
void overrideSetterPropertyName(
  InterpreterVisitor? visitor,
  Object? target,
  Object? value,
);

/// Method override
Object? overrideMethodMethodName(
  InterpreterVisitor? visitor,
  Object? target,
  List<Object?> positional,
  Map<String, Object?> named,
);
```

### Static Member Overrides

```dart
/// Static getter override
Object? overrideStaticGetterPropertyName(
  InterpreterVisitor? visitor,
);

/// Static setter override
void overrideStaticSetterPropertyName(
  InterpreterVisitor? visitor,
  Object? value,
);

/// Static method override
Object? overrideStaticMethodMethodName(
  InterpreterVisitor? visitor,
  List<Object?> positional,
  Map<String, Object?> named,
);
```

### Operator Overrides

```dart
/// operator[]
Object? overrideOperatorIndex(
  InterpreterVisitor? visitor,
  Object? target,
  List<Object?> positional,
  Map<String, Object?> named,
);

/// operator[]=
Object? overrideOperatorIndexAssign(
  InterpreterVisitor? visitor,
  Object? target,
  List<Object?> positional,
  Map<String, Object?> named,
);

/// operator+
Object? overrideOperatorPlus(
  InterpreterVisitor? visitor,
  Object? target,
  List<Object?> positional,
  Map<String, Object?> named,
);

/// etc.
```

### Special Overrides

```dart
/// nativeNames for internal implementation mapping
List<String> get nativeNames => ['_InternalImpl'];

/// Custom toString bridge (if toString override needed)
String overrideMethodToString(
  InterpreterVisitor? visitor,
  Object? target,
  List<Object?> positional,
  Map<String, Object?> named,
);
```

## Implementation Plan

### Phase 1: Core Infrastructure
1. Add `UserBridgeScanner` class to detect and parse user bridge files
2. Add `UserBridgeInfo` class to hold detected overrides
3. Update `BridgeGenerator` to accept override info

### Phase 2: Code Generation Updates
1. Generate bridge class that extends user bridge (when present)
2. For each member, check override map before generating
3. Generate override call instead of inline code when override exists

### Phase 3: Configuration
1. Add `userBridgePath` option to config
2. Add convention-based discovery
3. Document in user reference

### Phase 4: Testing
1. Unit tests for UserBridgeScanner
2. Integration tests for override detection
3. End-to-end tests with sample overrides

## Benefits

1. **Selective overrides** - Fix only problematic members
2. **Maintainable** - Source class changes don't break non-overridden members
3. **Clear separation** - User code in `_user_bridge.dart`, generated in `_bridge.g.dart`
4. **Type-safe** - Override methods have explicit signatures
5. **Discoverable** - Naming convention makes overrides obvious
6. **No boilerplate** - Only write code for what needs fixing

## Naming Conventions Summary

| Original Member | Override Method Name |
|-----------------|---------------------|
| `Foo()` | `overrideConstructor` |
| `Foo.named()` | `overrideConstructorNamed` |
| `get value` | `overrideGetterValue` |
| `set value=` | `overrideSetterValue` |
| `doWork()` | `overrideMethodDoWork` |
| `static get instance` | `overrideStaticGetterInstance` |
| `static set config=` | `overrideStaticSetterConfig` |
| `static create()` | `overrideStaticMethodCreate` |
| `operator[]` | `overrideOperatorIndex` |
| `operator[]=` | `overrideOperatorIndexAssign` |
| `operator+` | `overrideOperatorPlus` |
| `operator-` | `overrideOperatorMinus` |
| `operator- (unary)` | `overrideOperatorUnaryMinus` |
| `operator*` | `overrideOperatorMultiply` |
| `operator/` | `overrideOperatorDivide` |
| `operator~/` | `overrideOperatorIntegerDivide` |
| `operator%` | `overrideOperatorModulo` |
| `operator==` | `overrideOperatorEquals` |
| `operator<` | `overrideOperatorLessThan` |
| `operator>` | `overrideOperatorGreaterThan` |
| `operator<=` | `overrideOperatorLessThanOrEqual` |
| `operator>=` | `overrideOperatorGreaterThanOrEqual` |
| `operator&` | `overrideOperatorBitwiseAnd` |
| `operator|` | `overrideOperatorBitwiseOr` |
| `operator^` | `overrideOperatorBitwiseXor` |
| `operator~` | `overrideOperatorBitwiseNot` |
| `operator<<` | `overrideOperatorLeftShift` |
| `operator>>` | `overrideOperatorRightShift` |
| `operator>>>` | `overrideOperatorUnsignedRightShift` |

## File Structure Example

```
lib/
  src/
    d4rt_bridges/
      user_bridges/                    # User-maintained
        my_list_user_bridge.dart       # MyListUserBridge
        stream_user_bridge.dart        # StreamUserBridge
      all_bridges.dart                 # Generated barrel
      my_list_bridge.g.dart            # Generated (extends MyListUserBridge)
      stream_bridge.g.dart             # Generated (extends StreamUserBridge)
      simple_class_bridge.g.dart       # Generated (no user bridge)
```
