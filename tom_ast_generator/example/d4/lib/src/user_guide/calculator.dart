/// Calculator class from User Guide example.
///
/// Demonstrates methods with various parameter types.
library;

/// A basic calculator with arithmetic operations.
class Calculator {
  /// Create a new calculator.
  Calculator();

  /// Add two numbers.
  int add(int a, int b) => a + b;

  /// Subtract two numbers.
  int subtract(int a, int b) => a - b;

  /// Multiply two numbers.
  int multiply(int a, int b) => a * b;

  /// Divide two numbers with optional precision.
  double divide(double a, double b, {int precision = 2}) {
    final result = a / b;
    final factor = _pow10(precision);
    return (result * factor).roundToDouble() / factor;
  }

  int _pow10(int n) {
    var result = 1;
    for (var i = 0; i < n; i++) {
      result *= 10;
    }
    return result;
  }

  /// Static method for quick addition.
  static int quickAdd(int a, int b) => a + b;
}
