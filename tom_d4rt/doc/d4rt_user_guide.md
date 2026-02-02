# D4rt User Guide

This guide covers the integration and usage of the `tom_d4rt` interpreter within your Dart applications. It focuses on initializing the runtime, executing code, and managing the sandboxed environment.

For information on bridging Dart classes and functions to the interpreter, see the [Bridging Guide](BRIDGING_GUIDE.md).

## Table of Contents

- [D4rt User Guide](#d4rt-user-guide)
  - [Table of Contents](#table-of-contents)
  - [Getting Started](#getting-started)
  - [Initialization](#initialization)
  - [Execution Modes](#execution-modes)
    - [Evaluating Expressions](#evaluating-expressions)
    - [Executing Scripts](#executing-scripts)
    - [Executing Files](#executing-files)
    - [Continued Execution](#continued-execution)
  - [The Environment](#the-environment)
    - [Standard Library](#standard-library)
    - [Imports and Bridged Code](#imports-and-bridged-code)
    - [Security \& Permissions](#security--permissions)
  - [Script Structure Requirements](#script-structure-requirements)
  - [Interpreted Code Execution Flow](#interpreted-code-execution-flow)
  - [Advanced Topics](#advanced-topics)
    - [Permission System](#permission-system)
    - [Debug Logging](#debug-logging)
    - [Configuration Introspection](#configuration-introspection)

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

The core class is `D4rt`. The interpreter is ready to use immediately after instantiation, but **you must call `execute()` at least once before using `eval()`** to establish the execution context.

```dart
void main() async {
  final d4rt = D4rt();
  
  // First, establish context with execute()
  d4rt.execute(
    source: '''
      var counter = 0;
      void increment() { counter++; }
    ''',
  );
  
  // Now eval() can be used in this context
  d4rt.eval('increment()');
  final result = d4rt.eval('counter');
  print(result); // 1
}
```

**Important:** The `D4rt` class does not have an `init()` method. The first call to `execute()` establishes the global environment that `eval()` operates within.

---

## Execution Modes

D4rt supports different ways to run code depending on your needs.

### Evaluating Expressions

Use `eval()` to execute code in the context of a previous `execute()` call. **You must call `execute()` first** to establish the execution environment.

```dart
final d4rt = D4rt();

// First, establish context
d4rt.execute(
  source: '''
    var counter = 0;
    void increment() { counter++; }
    int getCounter() => counter;
  ''',
);

// Now eval() works in this context
d4rt.eval('increment()');
d4rt.eval('increment()');
final result = d4rt.eval('getCounter()');
print(result); // 2

// You can also define new functions via eval
d4rt.eval('int double(int x) => x * 2;');
final doubled = d4rt.eval('double(counter)');
print(doubled); // 4
```

### Executing Scripts

Use `execute()` to run a full Dart script source string. The script should contain top-level declarations (functions, classes, variables). You specify which function to call and what arguments to pass.

**Basic execution (calls `main()` by default):**

```dart
const script = '''
  void main() {
    print("Running inside D4rt!");
  }
''';

d4rt.execute(
  source: script,
  // name: 'main' is the default
);
```

**Passing arguments to the function:**

```dart
const script = '''
  void greet(String name, int age) {
    print("Hello \$name, you are \$age years old");
  }
''';

d4rt.execute(
  source: script,
  name: 'greet',  // Specify which function to call
  positionalArgs: ['Alice', 30],
);
```

**Using named arguments:**

```dart
const script = '''
  void configure({required String mode, int port = 8080}) {
    print("Mode: \$mode, Port: \$port");
  }
''';

d4rt.execute(
  source: script,
  name: 'configure',
  namedArgs: {'mode': 'production', 'port': 9000},
);
```

**Note:** The function name doesn't have to be `main()` — you can call any top-level function in the script by specifying the `name` parameter.

### Executing Files

Use the `executeFile` utility function (from `package:tom_d4rt/src/script_execution.dart`) to load and run a Dart file from the filesystem. This automatically resolves relative imports.

```dart
import 'package:tom_d4rt/tom_d4rt.dart';
import 'package:tom_d4rt/src/script_execution.dart';

void main() {
  final d4rt = D4rt();
  final result = executeFile(d4rt, 'path/to/script.dart');
  
  if (result.success) {
    print('Executed successfully: ${result.result}');
  } else {
    print('Error: ${result.error}');
  }
}
```

### Continued Execution

Use `executeFileContinued` to execute a file within the context of a previously executed file. This allows you to:
1.  Execute a setup file that declares global variables and functions
2.  Execute additional files that use those globals

```dart
import 'package:tom_d4rt/src/script_execution.dart';

final d4rt = D4rt();

// First, execute a setup file
executeFileContinued(d4rt, 'setup.dart');

// Then execute main script in that context
final result = executeFileContinued(d4rt, 'main.dart');
```

Unlike `executeFile` which uses `execute()` and creates fresh state, `executeFileContinued` uses `eval()` to add declarations to the existing global environment.

---

## The Environment

### Standard Library

D4rt comes with a reimplementation of core Dart libraries:

*   **`dart:core`**: Basic types (`int`, `double`, `String`, `List`, `Map`, `Set`, `bool`, `num`, `Object`, `Null`), printing, exceptions, and basic utilities.
*   **`dart:math`**: Mathematical constants (`pi`, `e`) and functions (`sin`, `cos`, `sqrt`, `pow`, `max`, `min`, etc.).
*   **`dart:async`**: `Future`, `Stream` (partial support in interpreted context).
*   **`dart:convert`**: JSON encoding/decoding support.
*   **`dart:collection`**: Collection types (`Queue`, `LinkedList`, etc.).
*   **`dart:typed_data`**: Typed data buffers.

**Restricted Libraries** (require permissions):

*   **`dart:io`**: File system, network, and process operations. **Requires `FilesystemPermission`** to access.
*   **`dart:isolate`**: Isolate operations. **Requires `IsolatePermission`** to access.

**Not Available:**

*   **`dart:mirrors`**: Reflection is not supported in the interpreter.
*   **`dart:ffi`**: Foreign function interface is not available.
*   **`dart:ui`**: Flutter UI library is not available (use Flutter-specific bridges instead).

### Imports and Bridged Code

Scripts must use `import` statements to access bridged classes and functions. Bridged code is registered with a library identifier (usually a package URI like `package:my_app/my_app.dart`), and scripts import from that library.

**Example:**

```dart
// Host application registers bridges
d4rt.registerBridgedClass(MyClassBridge(), 'package:my_app/my_app.dart');
d4rt.registerGlobalVariable('config', {'debug': true}, 'package:my_app/my_app.dart');

// Script uses imports to access them
const script = '''
  import 'package:my_app/my_app.dart';
  
  void main() {
    print(config); // Access global variable
    final obj = MyClass(); // Use bridged class
  }
''';
```

**Global Context Setup:**

You cannot directly inject globals into the interpreter's environment. Instead:
1.  Register variables/functions with a library identifier using `registerGlobalVariable` or `registerGlobalGetter`
2.  Scripts import from that library to access them

Or, use the `executeFileContinued` pattern to build up context incrementally.

### Security & Permissions

D4rt is designed to be a sandbox.

1.  **Memory Isolation:** Interpreted objects are wrappers around native objects. Direct memory access is not possible.
2.  **No IO Access by Default:** Scripts cannot read files, access the network, or spawn processes unless you explicitly grant permissions.
3.  **Type Safety:** The interpreter enforces Dart's type system at runtime.

---

## Script Structure Requirements

**Important:** Dart does not allow top-level statements outside of function or class declarations. Scripts must:

1.  **Have a `main()` function** if you want to execute logic:
    ```dart
    void main() {
      print('Hello!');
    }
    ```

2.  **Use imports** to access bridged classes:
    ```dart
    import 'package:my_app/my_app.dart';
    
    void main() {
      final obj = MyBridgedClass();
    }
    ```

3.  **Declare globals properly** (variables, functions, classes can be top-level, but executable statements must be in `main()`):
    ```dart
    // Valid
    int globalCounter = 0;
    
    void helperFunction() {
      print('Helper');
    }
    
    void main() {
      globalCounter++;
      helperFunction();
    }
    ```

---

## Interpreted Code Execution Flow

1.  **Parsing:** The source code is parsed into an AST (Abstract Syntax Tree).
2.  **Declaration Phase:** Top-level declarations (classes, functions, variables) are registered.
3.  **Execution:** The `main()` function (or evaluated expression) is executed.
4.  **Interop:** When the script calls a bridged function, the interpreter yields to the native Dart runtime, executes the native code, and converts the result back to an interpreted object.

---

## Advanced Topics

### Permission System

D4rt includes a comprehensive permission system to control access to sensitive operations.

**Available Permissions:**

*   `FilesystemPermission`: Controls file/directory read/write access
    *   `FilesystemPermission.any` - Allow all filesystem operations
    *   `FilesystemPermission.read` - Allow read operations
    *   `FilesystemPermission.write(path)` - Allow write to specific path
*   `NetworkPermission`: Controls network socket operations
    *   `NetworkPermission.any` - Allow all network operations
    *   `NetworkPermission.connect(host)` - Allow connections to specific host
*   `ProcessRunPermission`: Controls process execution
    *   `ProcessRunPermission.any` - Allow executing any process
*   `IsolatePermission`: Controls isolate operations
    *   `IsolatePermission.any` - Allow all isolate operations
*   `DangerousPermission`: Grants access to platform information
    *   `DangerousPermission.any` - Allow access to `Platform` class

**Granting Permissions:**

```dart
final d4rt = D4rt();

// Grant filesystem access
d4rt.grant(FilesystemPermission.any);

// Grant network access to specific host
d4rt.grant(NetworkPermission.connect('api.example.com'));

// Grant process execution
d4rt.grant(ProcessRunPermission.any);
```

**Checking Permissions:**

```dart
if (d4rt.hasPermission(FilesystemPermission.any)) {
  print('Filesystem access granted');
}

// Or check if any permission allows an operation
if (d4rt.checkPermission('filesystem:read:/tmp/file.txt')) {
  print('Can read /tmp/file.txt');
}
```

### Debug Logging

Enable detailed logging to troubleshoot script execution:

```dart
d4rt.setDebug(true);

// Now all execution will log detailed information
final result = await d4rt.eval('2 + 2');
```

### Configuration Introspection

Query the interpreter's current configuration (bridges, permissions, globals):

```dart
final config = d4rt.getConfiguration();

// Access registered bridges
for (final importInfo in config.imports.values) {
  print('Classes: ${importInfo.classes.map((c) => c.name)}');
  print('Functions: ${importInfo.functions.map((f) => f.name)}');
}

// Access permissions
for (final perm in config.permissions) {
  print('Permission: ${perm.type} - ${perm.description}');
}
```
