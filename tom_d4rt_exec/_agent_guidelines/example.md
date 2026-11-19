# D4rt Example Guidelines

This document provides guidelines for creating and maintaining example files in the `tom_d4rt` package.

## Example File Structure

Examples are organized in `example/<document-name>/` subfolders by source documentation:

```
example/
├── run_all_examples.dart    # Runs all examples to verify they work
├── d4rt_example.dart        # Comprehensive bridging example (original)
├── readme/                  # Examples from README.md
├── user_guide/              # Examples from doc/d4rt_user_guide.md
└── bridging_guide/          # Examples from doc/BRIDGING_GUIDE.md
```

Each example should:

1. **Be self-contained**: Include all necessary imports and class definitions
2. **Have a clear purpose**: Focus on demonstrating one concept or feature
3. **Include documentation header**: Reference the source documentation
4. **Be runnable**: Compile and execute without errors

## Running All Examples

Use `run_all_examples.dart` to verify all examples compile and run:

```bash
cd tom_d4rt
dart run example/run_all_examples.dart
```

**IMPORTANT:** When adding a new example, you MUST:
1. Add it to the appropriate subfolder
2. Add an import and run call to `run_all_examples.dart`
3. Verify it runs with `dart run example/run_all_examples.dart`

## Naming Convention

Example files should follow this naming pattern:

```
{feature}_example.dart
```

## Current Examples

### README Examples (`example/readme/`)

| File | Description |
|------|-------------|
| `quick_start_example.dart` | Minimal D4rt usage |
| `basic_execution_example.dart` | Function calls with arguments |
| `repl_example.dart` | eval() usage |
| `bridging_example.dart` | Simple class bridging |
| `permissions_example.dart` | Permission grants |

### User Guide Examples (`example/user_guide/`)

| File | Description |
|------|-------------|
| `basic_execution_example.dart` | Basic D4rt execution |
| `arguments_example.dart` | Passing arguments to scripts |
| `eval_example.dart` | REPL-style interaction |
| `multi_file_example.dart` | Multi-file script execution |
| `permissions_example.dart` | Security permissions |
| `continued_execution_example.dart` | Continued execution |
| `async_example.dart` | Async function handling |

### Bridging Guide Examples (`example/bridging_guide/`)

| File | Description |
|------|-------------|
| `bridging_enums_example.dart` | Enum bridging |
| `bridging_classes_example.dart` | Class bridging |
| `bridging_async_example.dart` | Async method bridging |
| `globals_example.dart` | Global variables/getters |

## Example File Template

```dart
// Example: {Feature Name}
// From: doc/{source_file.md} - {Section Name}
//
// Brief description of what this example demonstrates.

import 'package:tom_d4rt_exec/d4rt.dart';

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
