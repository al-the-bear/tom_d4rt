// D4rt test script for example_project
// Tests basic class instantiation, methods, enums via generated bridges.

import 'package:d4rt_generator_example/test_classes.dart';

void main() {
  // Test Person class
  var person = Person('Alice', 30);
  print('Person name: ${person.name}');
  print('Person age: ${person.age}');
  print('Person greet: ${person.greet()}');

  // Test named constructor
  var guest = Person.guest();
  print('Guest name: ${guest.name}');

  // Test Calculator class
  var calc = Calculator();
  print('Add: ${calc.add(5, 3)}');
  print('AddOptional: ${calc.addOptional(10, 20)}');

  // Test static method
  var formatted = Calculator.format(3.14159);
  print('Formatted: $formatted');

  // Test MathUtils static members
  print('Pi: ${MathUtils.pi}');
  print('Circle area: ${MathUtils.circleArea(5.0)}');

  // Test Status enum
  print('Status: ${Status.active}');
  print('Status name: ${Status.active.name}');

  // Test Priority enum
  print('Priority: ${Priority.high}');
  print('Priority name: ${Priority.high.name}');

  print('ALL_TESTS_PASSED');
}
