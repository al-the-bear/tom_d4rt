/// Global variables and getters from userbridge_override_design.md.
///
/// These globals demonstrate the GlobalsUserBridge override capability.
library;

/// Application name - can be overridden via GlobalsUserBridge.
const String appName = 'DefaultApp';

/// Maximum retry count.
const int maxRetries = 3;

/// Get the current timestamp (lazy getter).
DateTime get currentTime => DateTime.now();

/// Application version.
const String version = '1.0.0';

/// Top-level greeting function.
String greet(String name) => 'Hello, $name!';

/// Top-level calculation function.
int calculate(int a, int b, {String operation = 'add'}) {
  switch (operation) {
    case 'add':
      return a + b;
    case 'subtract':
      return a - b;
    case 'multiply':
      return a * b;
    default:
      throw ArgumentError('Unknown operation: $operation');
  }
}
