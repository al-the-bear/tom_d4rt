/// Greeter class from User Guide Quick Start example.
///
/// Demonstrates basic class bridging with constructors and methods.
library;

/// A simple greeter that can greet users.
class Greeter {
  final String greeting;

  /// Create a greeter with a custom greeting.
  Greeter(this.greeting);

  /// Create a default greeter with "Hello".
  Greeter.defaultGreeting() : greeting = 'Hello';

  /// Greet someone by name.
  String greet(String name) => '$greeting, $name!';

  /// Greet multiple people.
  String greetAll(List<String> names) {
    return names.map((n) => greet(n)).join(' ');
  }
}
