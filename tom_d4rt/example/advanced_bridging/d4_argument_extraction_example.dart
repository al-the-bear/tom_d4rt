/// D4 Argument Extraction Example
///
/// Demonstrates the D4 class helper methods for extracting and validating
/// positional and named arguments in bridge implementations.
///
/// These methods provide:
/// - Type-safe argument extraction
/// - Clear error messages with parameter names and method context
/// - Support for optional arguments with defaults
///
/// Run with: dart run example/advanced_bridging/d4_argument_extraction_example.dart
library;

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

// =============================================================================
// Example Classes for Bridging
// =============================================================================

/// A calculator service demonstrating various argument patterns.
class Calculator {
  /// Add two numbers (required positional).
  int add(int a, int b) => a + b;

  /// Subtract with optional parameters.
  int subtract(int a, [int b = 0]) => a - b;

  /// Divide with named parameters.
  double divide({required int dividend, required int divisor, int precision = 2}) {
    final result = dividend / divisor;
    final factor = _pow10(precision);
    return (result * factor).round() / factor;
  }

  /// Power function with default exponent.
  int power(int base, {int exponent = 2}) {
    int result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }

  /// Calculate with multiple optional named parameters.
  int calculate(int value, {
    int add = 0,
    int subtract = 0,
    int multiply = 1,
  }) {
    return ((value + add) - subtract) * multiply;
  }

  int _pow10(int n) {
    int result = 1;
    for (int i = 0; i < n; i++) {
      result *= 10;
    }
    return result;
  }
}

// =============================================================================
// Bridge Implementation Using D4 Argument Helpers
// =============================================================================

BridgedClass createCalculatorBridge() {
  return BridgedClass(
    nativeType: Calculator,
    name: 'Calculator',
    constructors: {
      '': (visitor, positional, named) => Calculator(),
    },
    methods: {
      // Example 1: Required positional arguments
      'add': (visitor, target, positional, named, typeArgs) {
        final calc = D4.validateTarget<Calculator>(target, 'Calculator');

        // D4.getRequiredArg validates presence and type
        // Parameters: list, index, paramName (for errors), methodName
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'add');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'add');

        return calc.add(a, b);
      },

      // Example 2: Optional positional argument with default
      'subtract': (visitor, target, positional, named, typeArgs) {
        final calc = D4.validateTarget<Calculator>(target, 'Calculator');

        // First arg is required
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'subtract');

        // Second arg is optional with default value
        final b = D4.getOptionalArgWithDefault<int>(positional, 1, 'b', 0);

        return calc.subtract(a, b);
      },

      // Example 3: Required named arguments
      'divide': (visitor, target, positional, named, typeArgs) {
        final calc = D4.validateTarget<Calculator>(target, 'Calculator');

        // D4.getRequiredNamedArg for required named parameters
        final dividend =
            D4.getRequiredNamedArg<int>(named, 'dividend', 'divide');
        final divisor = D4.getRequiredNamedArg<int>(named, 'divisor', 'divide');

        // D4.getNamedArgWithDefault for optional named with default
        final precision = D4.getNamedArgWithDefault<int>(named, 'precision', 2);

        return calc.divide(
          dividend: dividend,
          divisor: divisor,
          precision: precision,
        );
      },

      // Example 4: Mixed positional and named arguments
      'power': (visitor, target, positional, named, typeArgs) {
        final calc = D4.validateTarget<Calculator>(target, 'Calculator');

        // Required positional
        final base = D4.getRequiredArg<int>(positional, 0, 'base', 'power');

        // Optional named with default
        final exponent = D4.getNamedArgWithDefault<int>(named, 'exponent', 2);

        return calc.power(base, exponent: exponent);
      },

      // Example 5: Multiple optional named arguments
      'calculate': (visitor, target, positional, named, typeArgs) {
        final calc = D4.validateTarget<Calculator>(target, 'Calculator');

        // Required positional
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'calculate');

        // Multiple optional named with defaults
        final add = D4.getNamedArgWithDefault<int>(named, 'add', 0);
        final subtract = D4.getNamedArgWithDefault<int>(named, 'subtract', 0);
        final multiply = D4.getNamedArgWithDefault<int>(named, 'multiply', 1);

        return calc.calculate(
          value,
          add: add,
          subtract: subtract,
          multiply: multiply,
        );
      },
    },
    methodSignatures: {
      'add': 'int add(int a, int b)',
      'subtract': 'int subtract(int a, [int b = 0])',
      'divide': 'double divide({required int dividend, required int divisor, int precision = 2})',
      'power': 'int power(int base, {int exponent = 2})',
      'calculate': 'int calculate(int value, {int add = 0, int subtract = 0, int multiply = 1})',
    },
  );
}

// =============================================================================
// Demonstration
// =============================================================================

void main() async {
  print('D4 Argument Extraction Example');
  print('=' * 60);

  final d4rt = D4rt();
  d4rt.registerBridgedClass(
      createCalculatorBridge(), 'package:example/example.dart');

  final script = '''
import 'package:example/example.dart';

void main() {
  final calc = Calculator();
  
  // Example 1: Required positional arguments
  print('add(5, 3) = \${calc.add(5, 3)}');
  
  // Example 2: Optional positional argument
  print('subtract(10, 3) = \${calc.subtract(10, 3)}');
  print('subtract(10) = \${calc.subtract(10)}');  // Uses default b=0
  
  // Example 3: Required named arguments
  print('divide(dividend: 22, divisor: 7) = \${calc.divide(dividend: 22, divisor: 7)}');
  print('divide(dividend: 22, divisor: 7, precision: 4) = \${calc.divide(dividend: 22, divisor: 7, precision: 4)}');
  
  // Example 4: Mixed positional and named
  print('power(2) = \${calc.power(2)}');  // Uses default exponent=2
  print('power(2, exponent: 10) = \${calc.power(2, exponent: 10)}');
  
  // Example 5: Multiple optional named
  print('calculate(10, add: 5) = \${calc.calculate(10, add: 5)}');
  print('calculate(10, add: 5, multiply: 2) = \${calc.calculate(10, add: 5, multiply: 2)}');
  print('calculate(10, subtract: 3, multiply: 4) = \${calc.calculate(10, subtract: 3, multiply: 4)}');
}
''';

  print('\nExecuting script...\n');
  await d4rt.execute(source: script);

  // Demonstrate error handling
  print('\n' + '-' * 60);
  print('Error Handling Demonstration:');
  print('-' * 60);

  try {
    // Missing required argument
    final errorScript = '''
import 'package:example/example.dart';

void main() {
  final calc = Calculator();
  calc.add(5);  // Missing second required argument
}
''';
    await d4rt.execute(source: errorScript);
  } catch (e) {
    print('Expected error for missing arg: $e');
  }

  print('\n' + '=' * 60);
  print('Example completed!');
}
