/// Basic class examples for bridge generation testing.
/// 
/// This file demonstrates fundamental bridging capabilities:
/// - Simple classes with constructors
/// - Named and factory constructors
/// - Instance methods, getters, setters
/// - Static methods and fields
library;

/// A simple person class with basic properties.
class Person {
  final String name;
  int age;

  /// Default constructor.
  Person(this.name, this.age);

  /// Named constructor for creating a guest.
  Person.guest()
      : name = 'Guest',
        age = 0;

  /// Named constructor with age.
  Person.withAge(this.age) : name = 'Anonymous';

  /// Factory constructor that parses from string.
  factory Person.fromString(String data) {
    final parts = data.split(':');
    return Person(parts[0], int.parse(parts[1]));
  }

  /// Simple greeting method.
  String greet() => 'Hello, I am $name!';

  /// Greeting with optional prefix.
  String greetWith({String prefix = 'Hi'}) => '$prefix, $name!';

  /// Static factory for creating default person.
  static Person createDefault() => Person('Default', 18);

  /// Static counter for created instances.
  static int instanceCount = 0;
}

/// A class demonstrating different parameter types.
class Calculator {
  final int precision;

  Calculator([this.precision = 2]);

  /// Method with required positional parameters.
  int add(int a, int b) => a + b;

  /// Method with optional positional parameters.
  int addOptional(int a, [int b = 0, int c = 0]) => a + b + c;

  /// Method with named parameters (some required, some optional).
  double calculate({required double value, double multiplier = 1.0}) {
    return value * multiplier;
  }

  /// Static method with mixed parameters.
  static String format(double value, {int? decimals}) {
    final dec = decimals ?? 2;
    return value.toStringAsFixed(dec);
  }
}

/// A class with only static members (utility class pattern).
class MathUtils {
  MathUtils._(); // Private constructor

  static const double pi = 3.14159265359;
  static const double e = 2.71828182845;

  static double circleArea(double radius) => pi * radius * radius;
  static double square(double x) => x * x;
  static double cube(double x) => x * x * x;
}
