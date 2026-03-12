// D4rt test script for user_guide
// Tests Calculator and Greeter classes via generated bridges.

import 'package:d4_example/user_guide.dart';

void main() {
  // Test Calculator
  var calc = Calculator();
  print('Add: ${calc.add(10, 5)}');
  print('Subtract: ${calc.subtract(10, 5)}');
  print('Multiply: ${calc.multiply(6, 7)}');
  print('Divide: ${calc.divide(10.0, 3.0)}');

  // Test static method
  print('QuickAdd: ${Calculator.quickAdd(100, 200)}');

  // Test Greeter
  var greeter = Greeter('Hi');
  print('Greet: ${greeter.greet("World")}');
  print('Greeting: ${greeter.greeting}');

  // Test named constructor
  var defaultGreeter = Greeter.defaultGreeting();
  print('Default greet: ${defaultGreeter.greet("Dart")}');

  print('ALL_TESTS_PASSED');
}
