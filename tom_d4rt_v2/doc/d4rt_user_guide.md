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
- [Extension Registration and Facades](#extension-registration-and-facades)
  - [registerExtensions and finalizeBridges](#registerextensions-and-finalizebridges)
  - [Registration Facades](#registration-facades)
  - [Warmup](#warmup)
  - [Relaxer Usage Logging](#relaxer-usage-logging)
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
  tom_d4rt: ^1.8.21
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

## Extension Registration and Facades

Bridge packages frequently need to wire up additional runtime state — type
relaxers, interface proxies, generic-constructor factories — **after** their
main `registerBridgedClass` / `registerBridgedEnum` calls have run. Rather than
relying on a comment-driven "must run after bridges" convention, `D4rt` exposes
a programmatic extension hook with an enforced ordering contract. The same hook
exists on the analyzer-free runners (`D4rtRunner` in `tom_d4rt_ast`, `D4rt` in
`tom_d4rt_exec`), so bridge packages register once and run unchanged against
either interpreter.

### registerExtensions and finalizeBridges

`registerExtensions(packageName, body)` queues a callback for a bridge package.
The body is **not** run immediately — the runner stores it and runs every queued
body in registration order when `finalizeBridges()` is called, or implicitly on
the first `execute()` / `eval()` that follows.

```dart
final d4rt = D4rt();

// Wire the package's base bridges first…
registerMyPackageBridges(d4rt);

// …then queue the post-bridge extension wiring.
d4rt.registerExtensions('package:my_pkg/my_pkg.dart', () {
  d4rt.registerRelaxerFactory('MyBox', (inner, visitor) => MyBox(inner));
  d4rt.registerInterfaceProxy('MyListener', (instance, visitor) => _MyProxy(instance, visitor));
});

// Runs all queued callbacks once, in registration order. Optional —
// the first execute()/eval() calls it for you.
d4rt.finalizeBridges();

d4rt.execute(source: '/* … */');
```

Contract:

- **One callback per package name.** A second `registerExtensions` with the
  same `packageName` overwrites the previous body.
- **Run once, then frozen.** `finalizeBridges()` is idempotent — repeat calls
  return without re-running anything. After it has run, calling
  `registerExtensions` throws a `StateError` (registering extensions after
  finalization is a misuse).
- Call `registerExtensions` for every bridge package **before** the first
  `execute()` / `eval()` (or before an explicit `finalizeBridges()`).

### Registration Facades

These three methods register custom runtime adapters on the static `D4`
registries. They are thin facades intended to be called **from inside a
`registerExtensions` body** so the registration runs once at finalize time, in
package order, after the standard bridges are wired up. (They may also be called
directly before the first `execute()` / `eval()`.) All three are idempotent on
factory identity.

| Method | Purpose |
|--------|---------|
| `registerRelaxerFactory(baseTypeName, factory)` | A *relaxer* converts an interpreted/bridged value into a native instance of a parameterized (or plain) bridged type when an argument of that type is required. `baseTypeName` is the base type name without type arguments (e.g. `'ValueListenable'`, `'MyBox'`). |
| `registerInterfaceProxy(bridgedTypeName, factory)` | A *proxy* wraps an `InterpretedInstance` that implements a bridged abstract interface so it can be passed where the native interface is required. |
| `registerGenericConstructor(className, constructorName, factory)` | Builds a native instance of a generic bridged class from interpreted arguments and type arguments. Use `''` for the unnamed constructor. |

For large bridge surfaces, `tom_d4rt_generator` emits these registrations
automatically; the facades exist so embedders and hand-written bridges can
register adapters for their own (user-project) types without touching the
generator.

**Imperative vs. declarative.** The three methods above are the *imperative*
path — you call them at runtime. For a user project's **own** generic classes,
there is also a *declarative* path: annotate a marker class with
`@D4rtUserProxy` / `@D4rtUserRelaxer` (both re-exported from
`package:tom_d4rt/d4rt.dart`, mirroring the `@D4rtUserBridge` member-override
convention) and let the generator expand the concrete type-argument
instantiations — including multi-type-parameter generics the auto-generator
does not cover — without editing `buildkit.yaml`. See the generator's
[user_proxy_relaxer_annotations.md](../../tom_d4rt_generator/doc/user_proxy_relaxer_annotations.md)
for the variant syntax and worked examples.

### Warmup

`warmup()` calls `finalizeBridges()` and then executes a trivial throwaway
script (`int main() => 0;`). This JIT-warms the analyzer parser, the module
loader environment, bridge finalization, and the interpreter call path in one
pass, so the first *real* build does not cold-start mid-test under host load. It
is idempotent and script-neutral — every real `execute*` rebuilds its module
loader and environment from scratch, so the throwaway state is discarded. Call
it once after all bridge registration and before the first real build.

### Relaxer Usage Logging

To audit which relaxers, proxies, and generic constructors are actually hit at
runtime, enable usage logging:

```dart
D4.usageLogEnabled = true;
// … run scripts …
print(D4.usageLogSummary());
```

Alternatively, set the environment variable `D4RT_LOG_RELAXER_USAGE` to a
truthy value (`1`, `true`, `yes`, `on`, case-insensitive). On `finalizeBridges()`
the runner enables the flag, resets the log, and prints the usage summary at run
end automatically. Embedders that enable the flag programmatically do their own
reporting and are not affected by the env var.

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
