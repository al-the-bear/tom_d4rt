# tom_d4rt

A secure, sandboxed Dart interpreter written in Dart.

`tom_d4rt` allows you to execute Dart code dynamically at runtime without compilation. It features a robust bridging system to expose native Dart objects and libraries to the interpreted environment safely.

## Features

*   **Comprehensive Dart Support**: Full coverage of Dart language features including classes, generics, patterns, extensions, async/await, streams, and generators.
*   **Sandboxed Execution**: Scripts run in an isolated environment with fine-grained permission control.
*   **Dynamic Evaluation**: `execute()` full scripts or use `eval()` for REPL-style interaction.
*   **Bridging**: Expose any Dart class, function, or library to the interpreter.
*   **Code Generation**: Automate bridge creation with `tom_d4rt_generator`.
*   **Type Safety**: Runtime type checking compatible with Dart's type system.
*   **Async Support**: Full `async`/`await` support including `async*`/`sync*` generators and stream handling.

## Installation

```yaml
dependencies:
  tom_d4rt: ^1.6.0
```

## Quick Start

```dart
import 'package:tom_d4rt/tom_d4rt.dart';

void main() {
  final d4rt = D4rt();

  // Execute a script with a main function
  d4rt.execute(
    source: '''
      void main() {
        print("Hello from D4rt!");
      }
    ''',
  );
}
```

## Usage

### Basic Execution

The `execute()` method runs a script and calls a specified function (defaults to `main`):

```dart
final d4rt = D4rt();

// Call main() by default
d4rt.execute(source: '''
  void main() {
    print("Hello!");
  }
''');

// Call a custom function with arguments
final result = d4rt.execute(
  source: '''
    String greet(String name, int age) {
      return "Hello \$name, you are \$age";
    }
  ''',
  name: 'greet',
  positionalArgs: ['Alice', 30],
);
print(result);  // "Hello Alice, you are 30"
```

### REPL-Style Evaluation

After calling `execute()`, use `eval()` for incremental execution:

```dart
final d4rt = D4rt();

// Establish context
d4rt.execute(source: '''
  var counter = 0;
  void increment() { counter++; }
''');

// Use eval() in the established context
d4rt.eval('increment()');
d4rt.eval('increment()');
print(d4rt.eval('counter'));  // 2
```

### Exposing Native Code (Bridging)

Register bridged classes to make them available in scripts:

```dart
// Register bridges before execution
d4rt.registerBridgedClass(myClassBridge, 'package:my_app/types.dart');

// Scripts import and use them
d4rt.execute(source: '''
  import 'package:my_app/types.dart';
  
  void main() {
    final obj = MyClass();
    obj.doSomething();
  }
''');
```

**Recommended:** Use `tom_d4rt_generator` to automatically create bridges.
*   See [Bridge Generator User Guide](../tom_d4rt_generator/doc/bridgegenerator_user_guide.md)

For manual bridging, see the [Bridging Guide](doc/BRIDGING_GUIDE.md).

### Security and Permissions

D4rt is sandboxed by default. Grant permissions for sensitive operations:

```dart
final d4rt = D4rt();

// Grant filesystem access
d4rt.grant(FilesystemPermission.any);

// Grant network access
d4rt.grant(NetworkPermission.connectTo('api.example.com'));

// Grant process execution
d4rt.grant(ProcessRunPermission.any);
```

## Documentation

*   [User Guide](doc/d4rt_user_guide.md): Complete usage documentation, execution modes, and configuration.
*   [Bridging Guide](doc/BRIDGING_GUIDE.md): How to bridge native Dart classes and functions.
*   [Generator Guide](../tom_d4rt_generator/doc/bridgegenerator_user_guide.md): Automating bridge creation with code generation.
*   [Generator Reference](../tom_d4rt_generator/doc/bridgegenerator_user_reference.md): Generator configuration options.
