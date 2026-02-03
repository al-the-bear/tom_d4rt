# D4rt User Guide

This guide covers the integration and usage of the `tom_d4rt` interpreter within your Dart applications. It focuses on initializing the runtime, executing code, and managing the sandboxed environment.

For information on bridging Dart classes and functions to the interpreter, see the [Bridging Guide](BRIDGING_GUIDE.md).

## Table of Contents

- [Getting Started](#getting-started)
- [Initialization and Execution Model](#initialization-and-execution-model)
- [The execute() Method](#the-execute-method)
  - [Basic Usage](#basic-usage)
  - [Calling Custom Functions](#calling-custom-functions)
  - [Passing Arguments](#passing-arguments)
  - [Multi-File Execution](#multi-file-execution)
- [The eval() Method](#the-eval-method)
- [File-Based Execution](#file-based-execution)
- [Continued Execution](#continued-execution)
- [Registering Bridges](#registering-bridges)
- [The Standard Library](#the-standard-library)
- [Imports and Library URIs](#imports-and-library-uris)
- [Security and Permissions](#security-and-permissions)
- [Script Structure Requirements](#script-structure-requirements)
- [Advanced Topics](#advanced-topics)
  - [Debug Logging](#debug-logging)
  - [Configuration Introspection](#configuration-introspection)
  - [Execution Flow](#execution-flow)

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

## Initialization and Execution Model

The core class is `D4rt`. There is **no `init()` method** — instead, the interpreter is initialized through the first call to `execute()`.

**Key concept:** You must call `execute()` at least once to establish the execution context before using `eval()`. The `execute()` method:
1. Initializes a fresh module loader and global environment
2. Parses and declares all top-level definitions (classes, functions, variables)
3. Calls a specified function (defaults to `main`)

```dart
final d4rt = D4rt();

// First call to execute() initializes the environment
d4rt.execute(
  source: '''
    var counter = 0;
    void increment() { counter++; }
    int getCounter() => counter;
  ''',
  name: 'getCounter',  // Call getCounter() after declarations
);

// Now eval() works in this established context
d4rt.eval('increment()');
print(d4rt.eval('counter'));  // 1
```

---

## The execute() Method

The `execute()` method is the primary way to run D4rt scripts. It accepts several parameters for flexible execution.

### Basic Usage

```dart
d4rt.execute(
  source: '''
    void main() {
      print("Hello from D4rt!");
    }
  ''',
);
```

By default, `execute()` calls a function named `main` after processing declarations.

### Calling Custom Functions

The `name` parameter specifies which function to call:

```dart
d4rt.execute(
  source: '''
    void setup() {
      print("Setting up...");
    }
    
    void run() {
      print("Running...");
    }
  ''',
  name: 'setup',  // Calls setup() instead of main()
);
```

### Passing Arguments

Use `positionalArgs` and `namedArgs` to pass arguments to the called function:

**Positional arguments:**
```dart
d4rt.execute(
  source: '''
    String greet(String name, int age) {
      return "Hello \$name, you are \$age years old";
    }
  ''',
  name: 'greet',
  positionalArgs: ['Alice', 30],
);
// Returns: "Hello Alice, you are 30 years old"
```

**Named arguments:**
```dart
d4rt.execute(
  source: '''
    void configure({required String mode, int port = 8080}) {
      print("Mode: \$mode, Port: \$port");
    }
  ''',
  name: 'configure',
  namedArgs: {'mode': 'production', 'port': 9000},
);
```

**Mixed arguments:**
```dart
d4rt.execute(
  source: '''
    String greet(String greeting, {required String name}) {
      return "\$greeting \$name";
    }
  ''',
  name: 'greet',
  positionalArgs: ['Hello'],
  namedArgs: {'name': 'World'},
);
```

### Multi-File Execution

For multi-file projects, use the `library` and `sources` parameters:

```dart
d4rt.execute(
  library: 'package:my_app/main.dart',
  sources: {
    'package:my_app/main.dart': '''
      import 'package:my_app/utils.dart';
      
      void main() {
        print(greet("World"));
      }
    ''',
    'package:my_app/utils.dart': '''
      String greet(String name) => "Hello \$name!";
    ''',
  },
);
```

For filesystem-based imports, use `basePath` and `allowFileSystemImports`:

```dart
d4rt.grant(FilesystemPermission.any);  // Required for filesystem access

d4rt.execute(
  source: '''
    import './utils.dart';
    void main() => greetFromUtils();
  ''',
  basePath: '/path/to/project/lib',
  allowFileSystemImports: true,
);
```

---

## The eval() Method

The `eval()` method executes code in the context established by a previous `execute()` call. It's designed for REPL-style interaction.

**Prerequisite:** You must call `execute()` first. Calling `eval()` without a prior `execute()` throws a `RuntimeError`.

```dart
final d4rt = D4rt();

// Establish context first
d4rt.execute(
  source: '''
    var counter = 0;
    void increment() { counter++; }
    int getCounter() => counter;
  ''',
);

// Now use eval() for incremental operations
d4rt.eval('increment()');
d4rt.eval('increment()');
print(d4rt.eval('getCounter()'));  // 2

// Define new functions via eval
d4rt.eval('int double(int x) => x * 2;');
print(d4rt.eval('double(counter)'));  // 4
```

**What eval() can do:**
- Evaluate expressions: `d4rt.eval('2 + 2')` → `4`
- Call functions: `d4rt.eval('myFunction()')`
- Declare new functions: `d4rt.eval('int add(int a, int b) => a + b;')`
- Declare new variables: `d4rt.eval('var x = 10;')`
- Execute statements: `d4rt.eval('counter++;')`

---

## File-Based Execution

Use the `executeFile` and `executeFileContinued` utility functions from `package:tom_d4rt/src/script_execution.dart` for file-based execution.

**executeFile — Fresh execution:**
```dart
import 'package:tom_d4rt/src/script_execution.dart';

final d4rt = D4rt();
// Register any needed bridges first...

final result = executeFile(d4rt, 'path/to/script.dart');

if (result.success) {
  print('Result: ${result.result}');
  print('Sources loaded: ${result.sourcesLoaded}');
} else {
  print('Error: ${result.error}');
}
```

This function:
1. Reads the script from the file
2. Recursively resolves all relative imports
3. Calls `execute()` (which resets the environment)

---

## Continued Execution

Use `continuedExecute()` or `executeFileContinued()` to execute additional code in an existing context without resetting the environment.

**continuedExecute() method:**
```dart
// First execution establishes context
d4rt.execute(source: '''
  var sharedState = 0;
  void incrementState() { sharedState++; }
''');

// Continue in same context
d4rt.continuedExecute(
  source: '''
    void doubleState() { sharedState *= 2; }
  ''',
  name: 'doubleState',
);

print(d4rt.eval('sharedState'));  // State is preserved
```

**executeFileContinued() for files:**
```dart
import 'package:tom_d4rt/src/script_execution.dart';

final d4rt = D4rt();

// Execute setup file (uses execute() internally)
executeFile(d4rt, 'setup.dart');

// Execute main script in the same context (uses eval() internally)
final result = executeFileContinued(d4rt, 'main.dart');
```

---

## Registering Bridges

Before executing scripts that use bridged types, register them with the interpreter:

```dart
final d4rt = D4rt();

// Register a bridged class
d4rt.registerBridgedClass(
  MyClassBridge(),
  'package:my_app/my_app.dart',
);

// Register a bridged enum
d4rt.registerBridgedEnum(
  myEnumDefinition,
  'package:my_app/my_app.dart',
);

// Register a global variable
d4rt.registerGlobalVariable(
  'config',
  {'debug': true, 'version': '1.0'},
  'package:my_app/my_app.dart',
);

// Register a global getter (lazy evaluation)
d4rt.registerGlobalGetter(
  'currentTime',
  () => DateTime.now(),
  'package:my_app/my_app.dart',
);

// Register a top-level function
d4rt.registertopLevelFunction(
  'log',
  (args, namedArgs) => print('[LOG] ${args[0]}'),
  'package:my_app/my_app.dart',
);
```

Scripts access these via import statements:

```dart
d4rt.execute(source: '''
  import 'package:my_app/my_app.dart';
  
  void main() {
    print(config);         // Access global variable
    print(currentTime);    // Access global getter
    log("Hello!");         // Call top-level function
    final obj = MyClass(); // Use bridged class
  }
''');
```

See the [Bridging Guide](BRIDGING_GUIDE.md) for detailed bridging documentation.

---

## The Standard Library

D4rt includes reimplementations of core Dart libraries:

| Library | Description | Permission Required |
|---------|-------------|---------------------|
| `dart:core` | Basic types, printing, exceptions | None |
| `dart:math` | Math functions and constants | None |
| `dart:async` | Future, Stream (partial support) | None |
| `dart:convert` | JSON encoding/decoding | None |
| `dart:collection` | Queue, LinkedList, etc. | None |
| `dart:typed_data` | Typed data buffers | None |
| `dart:io` | File, network, process operations | `FilesystemPermission` |
| `dart:isolate` | Isolate operations | `IsolatePermission` |

**Not available:**
- `dart:mirrors` — Reflection not supported
- `dart:ffi` — Foreign function interface not available  
- `dart:ui` — Flutter UI library not available (use Flutter-specific bridges)

---

## Imports and Library URIs

Scripts must import bridged code using the library URI specified during registration:

```dart
// Registration (host code)
d4rt.registerBridgedClass(counterBridge, 'package:utils/counter.dart');

// Script
d4rt.execute(source: '''
  import 'package:utils/counter.dart';
  
  void main() {
    final c = Counter(0);
    c.increment();
  }
''');
```

The library URI can be any valid package URI — it doesn't need to correspond to an actual file.

---

## Security and Permissions

D4rt is a sandboxed environment. By default, scripts cannot:
- Access the filesystem
- Make network requests
- Execute processes
- Use isolates
- Access platform information

Grant permissions explicitly:

```dart
final d4rt = D4rt();

// Filesystem access
d4rt.grant(FilesystemPermission.any);           // All operations
d4rt.grant(FilesystemPermission.read);          // Read only
d4rt.grant(FilesystemPermission.write('/tmp')); // Write to specific path

// Network access
d4rt.grant(NetworkPermission.any);                     // All hosts
d4rt.grant(NetworkPermission.connect('api.example.com')); // Specific host

// Process execution
d4rt.grant(ProcessRunPermission.any);

// Isolate operations
d4rt.grant(IsolatePermission.any);

// Platform information (dangerous)
d4rt.grant(DangerousPermission.any);

// Check permissions
if (d4rt.hasPermission(FilesystemPermission.any)) {
  print('Filesystem access granted');
}

// Revoke permissions
d4rt.revoke(NetworkPermission.any);
```

---

## Script Structure Requirements

Dart does not allow top-level statements outside declarations. Scripts must:

1. **Contain functions for executable logic:**
   ```dart
   void main() {
     print('Hello!');  // Statements go inside functions
   }
   ```

2. **Use imports for bridged types:**
   ```dart
   import 'package:my_app/types.dart';
   
   void main() {
     final obj = MyBridgedClass();
   }
   ```

3. **Keep declarations at the top level:**
   ```dart
   // Valid top-level declarations
   int globalCounter = 0;
   const version = '1.0';
   
   void helperFunction() {
     print('Helper');
   }
   
   class MyClass {
     // ...
   }
   
   void main() {
     globalCounter++;
     helperFunction();
   }
   ```

---

## Advanced Topics

### Debug Logging

Enable detailed logging for troubleshooting:

```dart
d4rt.setDebug(true);

// All operations now log detailed information
d4rt.execute(source: 'void main() => print("test");');
```

### Configuration Introspection

Query the interpreter's configuration:

```dart
final config = d4rt.getConfiguration();

// Registered imports
for (final import in config.imports) {
  print('Library: ${import.libraryUri}');
  print('  Classes: ${import.classes.map((c) => c.name)}');
  print('  Functions: ${import.functions.map((f) => f.name)}');
}

// Granted permissions
for (final perm in config.permissions) {
  print('${perm.type}: ${perm.description}');
}

// Global variables and getters
for (final v in config.globalVariables) {
  print('Variable: ${v.name} (${v.valueType})');
}
```

Get the current environment state (after execution):

```dart
final state = d4rt.getEnvironmentState();
if (state != null) {
  print('Variables: ${state.variables.map((v) => v.name)}');
  print('Bridged classes: ${state.bridgedClasses}');
  print('Bridged enums: ${state.bridgedEnums}');
}
```

### Execution Flow

Understanding how D4rt processes scripts:

1. **Parsing:** Source code → Abstract Syntax Tree (AST)
2. **Declaration Pass:** Top-level declarations registered in environment
3. **Import Processing:** Import directives resolved, bridged types loaded
4. **Interpretation Pass:** Declarations interpreted (variable initializers evaluated)
5. **Function Call:** Specified function called with provided arguments
6. **Result Bridging:** Return value converted from interpreted to native representation

For async functions, D4rt properly handles `Future` return values:

```dart
final result = d4rt.execute(
  source: '''
    Future<int> fetchValue() async {
      await Future.delayed(Duration(milliseconds: 100));
      return 42;
    }
  ''',
  name: 'fetchValue',
);

// result is a Future<int>
print(await result);  // 42
```
