# D4 Advanced Bridging Examples

This folder contains examples demonstrating the `D4` helper class and best practices for creating robust bridges between native Dart code and D4rt scripts.

## Overview

The `D4` class provides static helper methods used by both the code generator and manual bridge implementations. These utilities handle common bridging challenges:

- **Type coercion** - Converting D4rt runtime types (List<Object?>, Map<Object?, Object?>) to typed collections
- **Argument extraction** - Safely extracting and validating positional and named arguments
- **Target validation** - Ensuring instance method calls have the correct target type
- **Error messages** - Providing clear, actionable error messages with context

## Examples

### [d4_type_coercion_example.dart](d4_type_coercion_example.dart)

Demonstrates `D4.coerceList<T>()` and `D4.coerceMap<K,V>()` for converting D4rt runtime collections to typed collections.

Key methods:
- `D4.coerceList<T>(arg, paramName)` - Convert List<Object?> to List<T>
- `D4.coerceListOrNull<T>(arg, paramName)` - Same, but returns null if arg is null
- `D4.coerceMap<K,V>(arg, paramName)` - Convert Map<Object?, Object?> to Map<K,V>
- `D4.coerceMapOrNull<K,V>(arg, paramName)` - Same, but returns null if arg is null

### [d4_argument_extraction_example.dart](d4_argument_extraction_example.dart)

Demonstrates argument extraction helpers for positional and named parameters.

Key methods:
- `D4.getRequiredArg<T>(positional, index, paramName, methodName)` - Required positional
- `D4.getOptionalArg<T>(positional, index, paramName)` - Optional positional (nullable)
- `D4.getOptionalArgWithDefault<T>(positional, index, paramName, default)` - Optional with default
- `D4.getRequiredNamedArg<T>(named, paramName, methodName)` - Required named
- `D4.getOptionalNamedArg<T>(named, paramName)` - Optional named (nullable)
- `D4.getNamedArgWithDefault<T>(named, paramName, default)` - Named with default
- `D4.requireMinArgs(positional, count, methodName)` - Validate minimum arg count
- `D4.requireExactArgs(positional, count, methodName)` - Validate exact arg count

### [d4_target_validation_example.dart](d4_target_validation_example.dart)

Demonstrates target validation for instance methods and getters.

Key methods:
- `D4.validateTarget<T>(target, typeName)` - Validate and extract target for instance members
- `D4.extractBridgedArg<T>(arg, paramName)` - Extract typed value from BridgedInstance or native

### [d4_globals_example.dart](d4_globals_example.dart)

Demonstrates bridging top-level functions and global variables.

Registration methods:
- `d4rt.registerGlobalVariable(name, value, importPath)`
- `d4rt.registerGlobalGetter(name, getter, importPath)`
- `d4rt.registertopLevelFunction(name, impl, importPath)`

### [d4_complete_bridge_example.dart](d4_complete_bridge_example.dart)

A complete, realistic example showing all D4 helpers working together in a task management system with enums, classes, factory constructors, and complex method signatures.

### UserBridge Examples

For UserBridge examples (operator overrides, complex generics, native type mappings), see the
`tom_d4rt_generator` package:
- Documentation: `tom_d4rt_generator/doc/user_bridge_user_guide.md`
- Examples: `tom_d4rt_generator/example/userbridge_user_guide/`

## Quick Reference

### Common Patterns

```dart
// Validate target for instance method
final t = D4.validateTarget<MyClass>(target, 'MyClass');

// Get required positional argument
final name = D4.getRequiredArg<String>(positional, 0, 'name', 'methodName');

// Get optional named argument with default
final count = D4.getNamedArgWithDefault<int>(named, 'count', 10);

// Coerce list from D4rt
final items = D4.coerceList<Item>(positional[0], 'items');

// Coerce map from D4rt  
final config = D4.coerceMap<String, int>(positional[0], 'config');

// Extract bridged argument (handles BridgedInstance wrapping)
final shape = D4.extractBridgedArg<Shape>(positional[0], 'shape');
```

### Error Messages

All D4 methods provide clear error messages including:
- The parameter name that failed
- The expected type
- The actual type received
- The method/class name for context

Example error: `add: Missing required argument "b" at position 1. Expected at least 2 arguments, got 1`

## See Also

- [../bridging_guide/](../bridging_guide/) - Basic bridging examples
- [../../doc/BRIDGING_GUIDE.md](../../doc/BRIDGING_GUIDE.md) - Complete bridging documentation
- [../../doc/advanced_bridging_user_guide.md](../../doc/advanced_bridging_user_guide.md) - User guide for advanced bridging
