# tom_d4rt

A secure, sandboxed Dart interpreter written in Dart.

`tom_d4rt` allows you to execute Dart code dynamically at runtime without compilation. It features a robust bridging system to expose native Dart objects and libraries to the interpreted environment safely.

## Features

*   **Sandboxed Execution**: Scripts run in an isolated environment.
*   **Dynamic Evaluation**: `eval()` expressions or `execute()` full scripts found in files or strings.
*   **Bridging**: Expose any Dart class, function, or library to the interpreter.
*   **Code Generation**: Automate bridge creation with `tom_d4rt_generator`.
*   **Type Safety**: Runtime type checking compatible with Dart's type system.

## Installation

```yaml
dependencies:
  tom_d4rt: ^1.5.0
```

## Usage

### Basic Evaluation

```dart
import 'package:tom_d4rt/tom_d4rt.dart';

void main() async {
  final d4rt = TomD4rt();
  
  // Initialize the interpreter
  await d4rt.init();

  // Evaluate a simple expression
  var result = await d4rt.eval('2 + 2');
  print(result); // 4

  // Execute a script with a main function
  await d4rt.execute('''
    void main() {
      print("Hello from D4rt!");
    }
  ''');
}
```

### Exposing Native Functions (Bridging)

You can expose simple functions using `addGlobal`:

```dart
d4rt.addGlobal('sayHello', (String name) {
  print('Hello, $name!');
});

await d4rt.eval("sayHello('World')");
```

### Exposing Classes (Advanced Bridging)

To expose full Dart classes, you use "Bridges". A Bridge defines the methods, properties, and constructors available to the script.

**1. Generate Bridges (Recommended)**

Use `tom_d4rt_generator` to automatically create bridges for your packages.
*   See [Bridge Generator User Guide](../tom_d4rt_generator/doc/bridgegenerator_user_guide.md)

**2. Manual Bridging**

You can also write bridges manually by extending `BridgedClass`:

```dart
class MyClass {
  void doSomething() => print('Working');
}

class MyClassBridge extends BridgedClass<MyClass> {
  // Bridge definitions...
}
```
*   See [Bridging Guide](doc/BRIDGING_GUIDE.md) for details.

### Script Execution

Load and execute scripts from files:

```dart
final d4rt = TomD4rt();
// ... register bridges ...

// Execute a file
await d4rt.executeFile('path/to/script.dart');

// Execute a script with arguments
await d4rt.execute('''
  void main(List<String> args) {
    print(args);
  }
''', arguments: ['--verbose']);
```

## Security

`tom_d4rt` provides isolation. Scripts cannot access `dart:io` or the file system unless you explicitly bridge those libraries.

*   **FileSystem Access**: Use `tom_d4rt_dcli` or bridge `dart:io` selectively if needed.
*   **Network**: Not available by default.

## Documentation

*   [User Guide](doc/d4rt_user_guide.md): Core usage, initializing, and execution modes.
*   [Bridging Guide](doc/BRIDGING_GUIDE.md): How to write and use bridges.
*   [Generator Guide](../tom_d4rt_generator/doc/bridgegenerator_user_guide.md): Automating bridge creation.
*   [API Reference](../tom_d4rt_generator/doc/bridgegenerator_user_reference.md): Generator configuration options.
