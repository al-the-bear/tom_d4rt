# Advanced Bridging User Guide

This guide explains how to create robust bridges between native Dart code and D4rt scripts using the `D4` helper class. These techniques are used by the `tom_d4rt_generator` code generator and are essential for manual bridge implementations.

## Table of Contents

1. [Introduction](#introduction)
2. [The D4 Helper Class](#the-d4-helper-class)
3. [Type Coercion](#type-coercion)
4. [Argument Extraction](#argument-extraction)
5. [Target Validation](#target-validation)
6. [Bridging Global Functions](#bridging-global-functions)
7. [Complete Example](#complete-example)
8. [Best Practices](#best-practices)

## Introduction

When D4rt executes scripts, it uses dynamic types internally. For example:

- List literals become `List<Object?>`
- Map literals become `Map<Object?, Object?>`
- Arguments are passed as `List<Object?>` (positional) and `Map<String, Object?>` (named)
- Objects may be wrapped in `BridgedInstance`

The `D4` class provides helper methods to safely convert these runtime types to the expected Dart types with clear error messages.

## The D4 Helper Class

The `D4` class (`package:tom_d4rt/tom_d4rt.dart`) provides static helper methods for:

| Category | Purpose |
|----------|---------|
| Type Coercion | Convert `List<Object?>` and `Map<Object?, Object?>` to typed collections |
| Argument Extraction | Extract and validate positional and named arguments |
| Target Validation | Validate instance method targets and unwrap `BridgedInstance` |
| Error Handling | Provide clear error messages with context |

Import it with:

```dart
import 'package:tom_d4rt/tom_d4rt.dart';
```

## Type Coercion

### The Problem

D4rt creates untyped collections even when all elements are the same type:

```dart
// In D4rt script:
final items = [Item('a', 1), Item('b', 2)];  // Creates List<Object?>

// In bridge:
void addItems(List<Item> items);  // Expects List<Item>
```

### The Solution: D4.coerceList and D4.coerceMap

```dart
'addItems': (visitor, target, positional, named, typeArgs) {
  final service = D4.validateTarget<InventoryService>(target, 'InventoryService');
  
  // Coerce List<Object?> to List<Item>
  final items = D4.coerceList<Item>(positional[0], 'items');
  
  service.addItems(items);
  return null;
},
```

### Available Methods

| Method | Description |
|--------|-------------|
| `D4.coerceList<T>(arg, paramName)` | Convert to `List<T>`, throws if null or wrong type |
| `D4.coerceListOrNull<T>(arg, paramName)` | Same, but returns null if arg is null |
| `D4.coerceMap<K,V>(arg, paramName)` | Convert to `Map<K,V>`, throws if null or wrong type |
| `D4.coerceMapOrNull<K,V>(arg, paramName)` | Same, but returns null if arg is null |

### Example

```dart
// From d4_type_coercion_example.dart

'addFromConfig': (visitor, target, positional, named, typeArgs) {
  final service = D4.validateTarget<InventoryService>(target, 'InventoryService');

  // D4rt passes Map<Object?, Object?> for map literals
  // Use D4.coerceMap to convert to Map<String, int>
  final config = D4.coerceMap<String, int>(positional[0], 'config');

  service.addFromConfig(config);
  return null;
},
```

## Argument Extraction

### Positional Arguments

```dart
// Required positional argument
final name = D4.getRequiredArg<String>(positional, 0, 'name', 'greet');

// Optional positional argument (returns null if missing)
final suffix = D4.getOptionalArg<String>(positional, 1, 'suffix');

// Optional with default value
final count = D4.getOptionalArgWithDefault<int>(positional, 1, 'count', 10);
```

### Named Arguments

```dart
// Required named argument
final title = D4.getRequiredNamedArg<String>(named, 'title', 'Task');

// Optional named argument (returns null if missing)
final description = D4.getOptionalNamedArg<String?>(named, 'description');

// Optional with default value
final priority = D4.getNamedArgWithDefault<int>(named, 'priority', 1);
```

### Argument Count Validation

```dart
// Require minimum number of arguments
D4.requireMinArgs(positional, 2, 'add');  // At least 2 args

// Require exact number of arguments
D4.requireExactArgs(positional, 3, 'setRGB');  // Exactly 3 args
```

### Complete Method Reference

| Method | Description |
|--------|-------------|
| `D4.getRequiredArg<T>(positional, index, paramName, methodName)` | Required positional, throws if missing |
| `D4.getOptionalArg<T>(positional, index, paramName)` | Optional positional, returns null if missing |
| `D4.getOptionalArgWithDefault<T>(positional, index, paramName, default)` | Optional with default |
| `D4.getRequiredNamedArg<T>(named, paramName, methodName)` | Required named, throws if missing |
| `D4.getOptionalNamedArg<T>(named, paramName)` | Optional named, returns null if missing |
| `D4.getNamedArgWithDefault<T>(named, paramName, default)` | Named with default |
| `D4.requireMinArgs(positional, count, methodName)` | Validate minimum arg count |
| `D4.requireExactArgs(positional, count, methodName)` | Validate exact arg count |

### Example

```dart
// From d4_argument_extraction_example.dart

'divide': (visitor, target, positional, named, typeArgs) {
  final calc = D4.validateTarget<Calculator>(target, 'Calculator');

  // Required named arguments
  final dividend = D4.getRequiredNamedArg<int>(named, 'dividend', 'divide');
  final divisor = D4.getRequiredNamedArg<int>(named, 'divisor', 'divide');

  // Optional named with default
  final precision = D4.getNamedArgWithDefault<int>(named, 'precision', 2);

  return calc.divide(
    dividend: dividend,
    divisor: divisor,
    precision: precision,
  );
},
```

## Target Validation

### The Problem

When D4rt calls an instance method, the target may be:
- A native object (direct reference)
- Wrapped in a `BridgedInstance` (when accessed through the bridge)

### The Solution: D4.validateTarget

```dart
'getLength': (visitor, target, positional, named, typeArgs) {
  // Validate target is MyList, unwrap BridgedInstance if needed
  final list = D4.validateTarget<MyList>(target, 'MyList');
  return list.length;
},
```

### Extracting Bridged Arguments

When arguments may be wrapped in `BridgedInstance`:

```dart
'addShape': (visitor, target, positional, named, typeArgs) {
  final canvas = D4.validateTarget<Canvas>(target, 'Canvas');
  
  // The shape argument may be a BridgedInstance or native object
  final shape = D4.extractBridgedArg<Shape>(positional[0], 'shape');
  
  canvas.addShape(shape);
  return null;
},
```

### Methods

| Method | Description |
|--------|-------------|
| `D4.validateTarget<T>(target, typeName)` | Validate and extract target for instance members |
| `D4.extractBridgedArg<T>(arg, paramName)` | Extract typed value, handles BridgedInstance |
| `D4.extractBridgedArgOrNull<T>(arg, paramName)` | Same, returns null if arg is null |

## Bridging Global Functions

### Registration Methods

```dart
void registerGlobals(D4rt d4rt, String importPath) {
  // Global variables (constants)
  d4rt.registerGlobalVariable('appVersion', '1.0.0', importPath);
  
  // Global getters (computed values)
  d4rt.registerGlobalGetter('currentTime', () => DateTime.now(), importPath);
  
  // Global functions
  d4rt.registertopLevelFunction(
    'greet',
    (visitor, positional, named, typeArgs) {
      final name = D4.getRequiredArg<String>(positional, 0, 'name', 'greet');
      return 'Hello, $name!';
    },
    importPath,
  );
}
```

### Example with Complex Parameters

```dart
// From d4_globals_example.dart

d4rt.registertopLevelFunction(
  'joinStrings',
  (visitor, positional, named, typeArgs) {
    // D4rt creates List<Object?>, use D4.coerceList to convert
    final strings = D4.coerceList<String>(positional[0], 'strings');
    final separator = D4.getNamedArgWithDefault<String>(named, 'separator', ', ');
    return strings.join(separator);
  },
  importPath,
);
```

## Complete Example

Here's a complete bridge implementation for a Task class:

```dart
// From d4_complete_bridge_example.dart

BridgedClass createTaskBridge() {
  return BridgedClass(
    nativeType: Task,
    name: 'Task',
    constructors: {
      '': (visitor, positional, named) {
        // Required named arguments
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'Task');
        final title = D4.getRequiredNamedArg<String>(named, 'title', 'Task');

        // Optional named arguments
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final priority = D4.getOptionalNamedArg<Priority?>(named, 'priority');
        final completed = D4.getOptionalNamedArg<bool?>(named, 'completed');

        // List parameter - needs coercion
        List<String>? tags;
        if (named.containsKey('tags') && named['tags'] != null) {
          tags = D4.coerceList<String>(named['tags'], 'tags');
        }

        return Task(
          id: id,
          title: title,
          description: description,
          priority: priority ?? Priority.medium,
          completed: completed ?? false,
          tags: tags,
        );
      },
      'fromMap': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Task.fromMap');
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        return Task.fromMap(map);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<Task>(target, 'Task').id,
      'title': (visitor, target) => D4.validateTarget<Task>(target, 'Task').title,
      'description': (visitor, target) => D4.validateTarget<Task>(target, 'Task').description,
      'priority': (visitor, target) => D4.validateTarget<Task>(target, 'Task').priority,
      'completed': (visitor, target) => D4.validateTarget<Task>(target, 'Task').completed,
      'tags': (visitor, target) => D4.validateTarget<Task>(target, 'Task').tags,
    },
    setters: {
      'description': (visitor, target, value) =>
          D4.validateTarget<Task>(target, 'Task').description = value as String?,
      'priority': (visitor, target, value) =>
          D4.validateTarget<Task>(target, 'Task').priority = value as Priority,
    },
    methods: {
      'complete': (visitor, target, positional, named, typeArgs) {
        D4.validateTarget<Task>(target, 'Task').complete();
        return null;
      },
      'addTag': (visitor, target, positional, named, typeArgs) {
        final task = D4.validateTarget<Task>(target, 'Task');
        final tag = D4.getRequiredArg<String>(positional, 0, 'tag', 'addTag');
        task.addTag(tag);
        return null;
      },
      'hasTag': (visitor, target, positional, named, typeArgs) {
        final task = D4.validateTarget<Task>(target, 'Task');
        final tag = D4.getRequiredArg<String>(positional, 0, 'tag', 'hasTag');
        return task.hasTag(tag);
      },
      'toMap': (visitor, target, positional, named, typeArgs) {
        return D4.validateTarget<Task>(target, 'Task').toMap();
      },
    },
    methodSignatures: {
      'complete': 'void complete()',
      'addTag': 'void addTag(String tag)',
      'hasTag': 'bool hasTag(String tag)',
      'toMap': 'Map<String, dynamic> toMap()',
    },
  );
}
```

## Best Practices

### 1. Always Use D4 Helpers

Don't manually cast or validate - use D4 helpers for consistent error messages:

```dart
// ❌ Bad - manual casting with unclear errors
final name = positional[0] as String;

// ✅ Good - D4 helper with clear error message
final name = D4.getRequiredArg<String>(positional, 0, 'name', 'greet');
```

### 2. Include Parameter and Method Names

Always pass parameter and method names for clear error messages:

```dart
// Error output: "greet: Missing required argument "name" at position 0"
D4.getRequiredArg<String>(positional, 0, 'name', 'greet');
```

### 3. Handle Optional Parameters Correctly

```dart
// For optional with null default
final description = D4.getOptionalNamedArg<String?>(named, 'description');

// For optional with non-null default
final count = D4.getNamedArgWithDefault<int>(named, 'count', 10);
```

### 4. Coerce Collections Before Use

Always coerce collections passed from D4rt:

```dart
// ❌ Bad - will fail at runtime
final items = positional[0] as List<Item>;

// ✅ Good - handles type coercion
final items = D4.coerceList<Item>(positional[0], 'items');
```

### 5. Provide Method Signatures

Add `methodSignatures`, `constructorSignatures`, etc. for better introspection:

```dart
BridgedClass(
  // ...
  methodSignatures: {
    'add': 'void add(T item)',
    'remove': 'bool remove(T item)',
  },
);
```

## Examples

See the [example/advanced_bridging/](../example/advanced_bridging/) folder for complete, runnable examples:

| Example | Description |
|---------|-------------|
| `d4_type_coercion_example.dart` | List and Map coercion |
| `d4_argument_extraction_example.dart` | Positional and named arguments |
| `d4_target_validation_example.dart` | Target validation and inheritance |
| `d4_globals_example.dart` | Global functions and variables |
| `d4_complete_bridge_example.dart` | Complete realistic example |

> **Note:** For UserBridge examples (operator overrides, complex generics), see the
> [tom_d4rt_generator documentation](../../tom_d4rt_generator/doc/user_bridge_user_guide.md)
> and examples in `tom_d4rt_generator/example/userbridge_user_guide/`.

## See Also

- [BRIDGING_GUIDE.md](BRIDGING_GUIDE.md) - Basic bridging concepts
- [d4rt_user_guide.md](d4rt_user_guide.md) - General D4rt usage guide
- [d4rt_limitations.md](d4rt_limitations.md) - Known limitations
- [tom_d4rt_generator: user_bridge_user_guide.md](../../tom_d4rt_generator/doc/user_bridge_user_guide.md) - UserBridge overrides for code generation
