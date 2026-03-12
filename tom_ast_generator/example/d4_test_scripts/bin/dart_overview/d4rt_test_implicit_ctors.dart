// D4rt test script: GEN-042 — Implicit default constructors
// Isolated test for classes with no explicit constructor.
// Expected: FAILS until GEN-042 is fixed.

import 'package:d4_example/dart_overview.dart';

void main() {
  // Person has no explicit constructor, just field defaults:
  //   String name = '';
  //   int age = 0;
  var person = Person();
  person.name = 'Alice';
  person.age = 30;
  print('Person name: ${person.name}');
  print('Person age: ${person.age}');

  // Calculator also has no explicit constructor, only methods:
  //   int add(int a, int b) => a + b;
  var calc = Calculator();
  print('Calc add: ${calc.add(5, 3)}');
  print('Calc subtract: ${calc.subtract(10, 4)}');
  print('Calc multiply: ${calc.multiply(6, 7)}');

  print('ALL_IMPLICIT_CTOR_TESTS_PASSED');
}
