# D4rt User Guide

This guide covers the integration and usage of the `tom_d4rt` interpreter within your Dart applications. It focuses on initializing the runtime, executing code, and managing the sandboxed environment.

For information on bridging Dart classes and functions to the interpreter, see the [Bridging Guide](BRIDGING_GUIDE.md).

## Table of Contents

1.  [Getting Started](#getting-started)
2.  [Initialization](#initialization)
3.  [Execution Modes](#execution-modes)
    *   [Evaluating Expressions](#evaluating-expressions)
    *   [Executing Scripts](#executing-scripts)
    *   [Executing Files](#executing-files)
4.  [The Environment](#the-environment)
    *   [Standard Library](#standard-library)
    *   [Globals](#globals)
    *   [Security & Isolation](#security--isolation)
5.  [Interpreted Code Execution Flow](#interpreted-code-execution-flow)

---

## Getting Started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  tom_d4rt: ^1.5.0
```

Import the package:

```dart
import 'package:tom_d4rt/tom_d4rt.dart';
```

---

## Initialization

The core class is `TomD4rt`. You must Create an instance and call `init()` prior to executing any code. This step sets up the core libraries and types.

```dart
void main() async {
  final d4rt = TomD4rt();
  await d4rt.init();
  
  // Ready to execute
}
```

---

## Execution Modes

D4rt supports different ways to run code depending on your needs.

### Evaluating Expressions

Use `eval` to compute a value from a single D4rt expression string. This is useful for calculations, condition checking, or retrieving values.

```dart
final result = await d4rt.eval('2 * 21');
print(result); // 42

final message = await d4rt.eval('"Hello " + "World"');
print(message); // Hello World
```

### Executing Scripts

Use `execute` to run a full Dart script source string. The script should ideally contain a `main()` function, or top-level statements.

```dart
const script = '''
  void main() {
    print("Running inside D4rt!");
  }
''';

await d4rt.execute(script);
```

You can pass arguments to the `main` function:

```dart
const script = '''
  void main(List<String> args) {
    print("Args: \$args");
  }
''';

await d4rt.execute(script, arguments: ['--flag', 'value']);
```

### Executing Files

Use `executeFile` to load and run a Dart file from the filesystem.

```dart
await d4rt.executeFile('path/to/script.dart', arguments: ['arg1']);
```

---

## The Environment

### Standard Library

D4rt comes with a reimplementation of core Dart libraries:
-   `dart:core`: Basic types (`int`, `double`, `String`, `List`, `Map`, etc.), printing, and basic utilities.
-   `dart:math`: Mathematical constants and functions.
-   `dart:async`: `Future`, `Stream` (partial support in interpreted context).

**Note:** `dart:io` and `dart:isolate` are **NOT** available by default for security reasons.

### Globals

You can inject variables and functions into the global scope of the interpreter.

**Adding a Value:**
```dart
d4rt.addGlobal('apiVersion', 1);
```

**Adding a Function:**
```dart
d4rt.addGlobal('log', (String msg) => print('[LOG] $msg'));
```

**Lazy Loading (Getters):**
Use `registerGlobalGetter` for objects that should only be instantiated when accessed by the script.

```dart
d4rt.registerGlobalGetter('heavyResource', () => HeavyResource());
```

### Security & Isolation

D4rt is designed to be a sandbox.

1.  **Memory Isolation:** Interpreted objects are wrappers around native objects. Direct memory access is not possible.
2.  **No IO Access:** Scripts cannot read files, access the network, or spawn processes unless you explicitly bridge those capabilities.
3.  **Type Safety:** The interpreter enforces Dart's type system at runtime.

---

## Interpreted Code Execution Flow

1.  **Parsing:** The source code is parsed into an AST (Abstract Syntax Tree).
2.  **Compilation (Internal):** The AST is converted into bytecode or an optimized intermediate representation.
3.  **Execution:** The interpreter runs the instructions.
4.  **Interop:** When the script calls a bridged function, the interpreter yields to the native Dart runtime, executes the native code, and converts the result back to an interpreted object.
