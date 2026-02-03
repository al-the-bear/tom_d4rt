# D4rt Example Guidelines

This document provides guidelines for creating and maintaining example files in the `tom_d4rt` package.

## Example File Structure

Examples are located in the `example/` directory. Each example should:

1. **Be self-contained**: Include all necessary imports and class definitions
2. **Have a clear purpose**: Focus on demonstrating one concept or feature
3. **Include documentation header**: Reference the source documentation
4. **Be runnable**: Compile and execute without errors

## Naming Convention

Example files should follow this naming pattern:

```
{feature}_example.dart
```

Current examples:

| File | Description | Source Documentation |
|------|-------------|---------------------|
| `basic_execution_example.dart` | Basic D4rt execution | `d4rt_user_guide.md` |
| `arguments_example.dart` | Passing arguments to scripts | `d4rt_user_guide.md` |
| `eval_example.dart` | REPL-style interaction | `d4rt_user_guide.md` |
| `multi_file_example.dart` | Multi-file script execution | `d4rt_user_guide.md` |
| `permissions_example.dart` | Security permissions | `d4rt_user_guide.md` |
| `continued_execution_example.dart` | Continued execution | `d4rt_user_guide.md` |
| `async_example.dart` | Async function handling | `d4rt_user_guide.md` |
| `bridging_enums_example.dart` | Enum bridging | `BRIDGING_GUIDE.md` |
| `bridging_classes_example.dart` | Class bridging | `BRIDGING_GUIDE.md` |
| `bridging_async_example.dart` | Async method bridging | `BRIDGING_GUIDE.md` |
| `globals_example.dart` | Global variables/getters | `BRIDGING_GUIDE.md` |
| `d4rt_example.dart` | Comprehensive bridging example | Original example |

## Example File Template

```dart
// Example: {Feature Name}
// From: doc/{source_file.md} - {Section Name}
//
// Brief description of what this example demonstrates.

import 'package:tom_d4rt/d4rt.dart';

// Any native classes/enums needed for the example
class ExampleClass {
  // ...
}

void main() async {  // Use async if example uses await
  final d4rt = D4rt();

  print('=== Section Name ===');
  
  // Example code with explanatory comments
  // ...
}
```

## Key API Signatures

When writing examples, use these correct function signatures:

### BridgedMethodAdapter
```dart
(InterpreterVisitor visitor, Object target, List<Object?> positionalArgs,
 Map<String, Object?> namedArgs, List<RuntimeType>? typeArgs) => result
```

### BridgedConstructorCallable
```dart
(InterpreterVisitor visitor, List<Object?> positionalArgs,
 Map<String, Object?> namedArgs) => instance
```

### BridgedStaticMethodAdapter
```dart
(InterpreterVisitor visitor, List<Object?> positionalArgs,
 Map<String, Object?> namedArgs, List<RuntimeType>? typeArgs) => result
```

### BridgedInstanceGetterAdapter
```dart
(InterpreterVisitor? visitor, Object target) => value
```

### BridgedInstanceSetterAdapter
```dart
(InterpreterVisitor? visitor, Object target, Object? value) => void
```

### NativeFunctionImpl
```dart
(InterpreterVisitor visitor, List<Object?> args,
 Map<String, Object?> namedArgs, List<RuntimeType>? typeArgs) => result
```

## Verification

Before committing examples:

1. Run `dart analyze example/` to check for errors
2. Run individual examples to verify they work: `dart run example/{file}.dart`
3. Ensure output matches documentation expectations
