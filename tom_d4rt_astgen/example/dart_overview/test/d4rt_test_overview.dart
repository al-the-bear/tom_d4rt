// D4rt test script for dart_overview
// Tests classes from declarations, enums, and generics modules.

import 'package:dart_overview/dart_overview.dart';

void main() {
  // BUG: Implicit default constructors are not bridged
  // Person has no explicit constructor — just `String name = ''; int age = 0;`
  var person = Person();
  person.name = 'Alice';
  person.age = 30;
  print('Person name: ${person.name}');
  print('Person age: ${person.age}');

  // Test Dog class (explicit constructor)
  var dog = Dog('Buddy', 3);
  print('Dog name: ${dog.name}');
  print('Dog age: ${dog.age}');

  // Test Calculator class (implicit default constructor)
  var calc = Calculator();
  print('Add: ${calc.add(5, 3)}');
  print('Subtract: ${calc.subtract(10, 4)}');
  print('Multiply: ${calc.multiply(6, 7)}');

  // Test User class (explicit constructor)
  var user = User('Alice', 'alice@example.com');
  print('User name: ${user.name}');
  print('User email: ${user.email}');

  // Test Rectangle class (explicit constructor)
  var rect = Rectangle(5.0, 3.0);
  print('Area: ${rect.area}');
  print('Perimeter: ${rect.perimeter}');

  // Test Circle class (explicit constructor)
  var circle = Circle(5.0);
  print('Diameter: ${circle.diameter}');

  // Test Day enum
  print('Day: ${Day.monday}');
  print('Day name: ${Day.monday.name}');

  // Test Priority enum
  print('Priority: ${Priority.high}');

  // Test enhanced enum fields
  // BUG: Enhanced enum fields not accessible
  print('Season months: ${Season.spring.months}');
  print('HttpStatus code: ${HttpStatus.ok.code}');

  // Test Role enum
  print('Role: ${Role.admin}');

  // Test Box generic class (explicit constructor)
  var box = Box(42);
  print('Box value: ${box.value}');

  // Test Pair generic class
  var pair = Pair('Hello', 42);
  print('Pair first: ${pair.first}');
  print('Pair second: ${pair.second}');

  print('ALL_TESTS_PASSED');
}
