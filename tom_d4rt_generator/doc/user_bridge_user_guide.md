# UserBridge User Guide

This guide explains how to create custom UserBridge classes to provide manual overrides when the tom_d4rt_generator cannot automatically handle certain patterns.

## Table of Contents

1. [Introduction](#introduction)
2. [When to Use UserBridge](#when-to-use-userbridge)
3. [Creating a UserBridge](#creating-a-userbridge)
4. [Override Naming Convention](#override-naming-convention)
5. [Operator Overrides](#operator-overrides)
6. [Native Names](#native-names)
7. [Complete Example](#complete-example)
8. [Best Practices](#best-practices)

## Introduction

The `tom_d4rt_generator` automatically generates bridge code for most Dart classes. However, some patterns require manual intervention. The `D4UserBridge` base class allows you to provide custom implementations that the generator will use instead of generating code.

## When to Use UserBridge

Use UserBridge when you need to override:

| Pattern | Reason |
|---------|--------|
| **Operators** (`[]`, `[]=`, `+`, `-`, etc.) | Complex parameter handling, type coercion |
| **Complex generics** | Runtime type handling beyond generator capabilities |
| **Native type mappings** | Multiple internal implementations for one public type |
| **Special parameter validation** | Custom validation beyond standard patterns |
| **Covariant parameters** | Type variance that generator cannot infer |

> **Note:** The generator **can** auto-generate many operators. Use UserBridge when you need custom handling, such as operators with complex parameter types (e.g., `List<int>` indices for `[]`).

## Creating a UserBridge

### Step 1: Create the UserBridge Class

```dart
import 'package:tom_d4rt/tom_d4rt.dart';

class Vector2DUserBridge extends D4UserBridge {
  /// Override operator+
  static Object? overrideOperatorPlus(
    Object? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final vec = D4.validateTarget<Vector2D>(target, 'Vector2D');
    final other = D4.extractBridgedArg<Vector2D>(positional[0], 'other');
    return vec + other;
  }
}
```

### Step 2: Register with Generator

Place your UserBridge class in a location the generator can find. The generator scans for classes extending `D4UserBridge` and uses their override methods.

### Method Signature

All override methods follow this signature:

```dart
static Object? overrideXxx(
  Object? visitor,      // The interpreter visitor (for advanced use)
  Object? target,       // The instance (for instance members)
  List<Object?> positional,  // Positional arguments
  Map<String, Object?> named, // Named arguments
)
```

## Override Naming Convention

The generator recognizes override methods by their names:

| Member Type | Override Method Name |
|-------------|---------------------|
| Default constructor | `overrideConstructor` |
| Named constructor `Foo.named()` | `overrideConstructorNamed` |
| Getter `value` | `overrideGetterValue` |
| Setter `value=` | `overrideSetterValue` |
| Method `doWork()` | `overrideMethodDoWork` |
| Static getter | `overrideStaticGetterName` |
| Static method | `overrideStaticMethodName` |
| Operator `+` | `overrideOperatorPlus` |
| Operator `-` | `overrideOperatorMinus` |
| Operator `*` | `overrideOperatorMultiply` |
| Operator `/` | `overrideOperatorDivide` |
| Operator `%` | `overrideOperatorModulo` |
| Operator `~/` | `overrideOperatorTruncateDivide` |
| Operator `[]` | `overrideOperatorIndex` |
| Operator `[]=` | `overrideOperatorIndexAssign` |
| Operator `==` | `overrideOperatorEquals` |
| Operator `<` | `overrideOperatorLess` |
| Operator `<=` | `overrideOperatorLessOrEqual` |
| Operator `>` | `overrideOperatorGreater` |
| Operator `>=` | `overrideOperatorGreaterOrEqual` |
| Operator `&` | `overrideOperatorBitwiseAnd` |
| Operator `\|` | `overrideOperatorBitwiseOr` |
| Operator `^` | `overrideOperatorBitwiseXor` |
| Operator `<<` | `overrideOperatorShiftLeft` |
| Operator `>>` | `overrideOperatorShiftRight` |
| Operator `>>>` | `overrideOperatorShiftRightUnsigned` |
| Operator `~` | `overrideOperatorBitwiseNegate` |
| Unary `-` | `overrideOperatorUnaryMinus` |

## Operator Overrides

### Binary vs Unary Minus

> **Important:** The D4rt interpreter uses the same `-` key for both binary subtraction (`a - b`) and unary negation (`-a`). For unary operations, `positional` will be empty.

Your override should check `positional.isEmpty` to distinguish:

```dart
static Object? overrideOperatorMinus(
  Object? visitor,
  Object? target,
  List<Object?> positional,
  Map<String, Object?> named,
) {
  final vec = D4.validateTarget<Vector2D>(target, 'Vector2D');
  if (positional.isEmpty) {
    // Unary negation: -vector
    return -vec;
  } else {
    // Binary subtraction: vector1 - vector2
    final other = D4.extractBridgedArg<Vector2D>(positional[0], 'other');
    return vec - other;
  }
}
```

### Index Operators with Complex Parameters

For `[]` operators that take complex parameters (like `List<int>` for multi-dimensional access):

```dart
static Object? overrideOperatorIndex(
  Object? visitor,
  Object? target,
  List<Object?> positional,
  Map<String, Object?> named,
) {
  final matrix = D4.validateTarget<Matrix2x2>(target, 'Matrix2x2');
  // D4rt passes a List for the indices - coerce it
  final indices = D4.coerceList<int>(positional[0], 'indices');
  return matrix[indices];
}

static Object? overrideOperatorIndexAssign(
  Object? visitor,
  Object? target,
  List<Object?> positional,
  Map<String, Object?> named,
) {
  final matrix = D4.validateTarget<Matrix2x2>(target, 'Matrix2x2');
  final indices = D4.coerceList<int>(positional[0], 'indices');
  final value = D4.extractBridgedArg<double>(positional[1], 'value');
  matrix[indices] = value;
  return null;
}
```

## Native Names

For classes with multiple internal implementations (like Dart's `List` which has `_GrowableList`, `_FixedLengthList`, etc.), use `nativeNames`:

```dart
class MyListUserBridge extends D4UserBridge {
  /// Map internal List implementations to this bridge
  static List<String> get nativeNames => ['_GrowableList', '_FixedLengthList'];
  
  // Override methods...
}
```

The generator will use this to map all these internal types to your bridge.

## Complete Example

See [example/userbridge_user_guide/](../example/userbridge_user_guide/) for a complete, runnable example demonstrating:

- Vector2D with arithmetic operators (`+`, `-`, `*`, unary `-`)
- Matrix2x2 with index operators (`[]`, `[]=`)
- Proper handling of BridgedInstance wrapping
- Type coercion for complex parameters

### Vector2D UserBridge

```dart
class Vector2DUserBridge extends D4UserBridge {
  /// Override operator+
  static Object? overrideOperatorPlus(
    Object? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final vec = D4.validateTarget<Vector2D>(target, 'Vector2D');
    final other = D4.extractBridgedArg<Vector2D>(positional[0], 'other');
    return vec + other;
  }

  /// Override operator- (handles both binary and unary)
  static Object? overrideOperatorMinus(
    Object? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final vec = D4.validateTarget<Vector2D>(target, 'Vector2D');
    if (positional.isEmpty) {
      return -vec;  // Unary
    } else {
      final other = D4.extractBridgedArg<Vector2D>(positional[0], 'other');
      return vec - other;  // Binary
    }
  }

  /// Override operator*
  static Object? overrideOperatorMultiply(
    Object? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final vec = D4.validateTarget<Vector2D>(target, 'Vector2D');
    final scalar = D4.extractBridgedArg<double>(positional[0], 'scalar');
    return vec * scalar;
  }
}
```

### Registering the Bridge

```dart
BridgedClass createVector2DBridge() {
  return BridgedClass(
    nativeType: Vector2D,
    name: 'Vector2D',
    constructors: {
      '': (visitor, positional, named) {
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Vector2D');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Vector2D');
        return Vector2D(x, y);
      },
    },
    getters: {
      'x': (visitor, target) =>
          D4.validateTarget<Vector2D>(target, 'Vector2D').x,
      'y': (visitor, target) =>
          D4.validateTarget<Vector2D>(target, 'Vector2D').y,
    },
    methods: {
      // Operators using UserBridge overrides
      // Note: '-' handles both binary subtraction and unary negation
      '+': (visitor, target, positional, named, typeArgs) =>
          Vector2DUserBridge.overrideOperatorPlus(
              visitor, target, positional, named),
      '-': (visitor, target, positional, named, typeArgs) =>
          Vector2DUserBridge.overrideOperatorMinus(
              visitor, target, positional, named),
      '*': (visitor, target, positional, named, typeArgs) =>
          Vector2DUserBridge.overrideOperatorMultiply(
              visitor, target, positional, named),
    },
  );
}
```

## Best Practices

### 1. Always Use D4 Helpers

Use the `D4` helper class for consistent error handling:

```dart
// ✅ Good - clear error messages
final vec = D4.validateTarget<Vector2D>(target, 'Vector2D');
final other = D4.extractBridgedArg<Vector2D>(positional[0], 'other');

// ❌ Bad - cryptic errors
final vec = target as Vector2D;
final other = positional[0] as Vector2D;
```

### 2. Handle BridgedInstance Wrapping

Arguments from D4rt may be wrapped in `BridgedInstance`. Use `D4.extractBridgedArg`:

```dart
// Handles both raw objects and BridgedInstance wrappers
final shape = D4.extractBridgedArg<Shape>(positional[0], 'shape');
```

### 3. Coerce Collections

D4rt collections are untyped (`List<Object?>`). Always coerce:

```dart
final indices = D4.coerceList<int>(positional[0], 'indices');
final config = D4.coerceMap<String, dynamic>(positional[0], 'config');
```

### 4. Check Argument Count for Overloaded Operators

For operators that can be unary or binary (like `-`), check argument count:

```dart
if (positional.isEmpty) {
  // Unary operation
} else {
  // Binary operation
}
```

### 5. Return Null for Void Methods

Methods/operators that don't return a value should return `null`:

```dart
static Object? overrideOperatorIndexAssign(...) {
  // ... set the value ...
  return null;  // void return
}
```

## See Also

- [bridgegenerator_user_guide.md](bridgegenerator_user_guide.md) - Full generator documentation
- [userbridge_override_design.md](userbridge_override_design.md) - Design document for UserBridge system
- [example/userbridge_override/](../example/userbridge_override/) - Existing UserBridge examples
