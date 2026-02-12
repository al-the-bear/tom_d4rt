// D4rt test: CTOR08 - Super parameters (super.x)
// Verifies constructors using Dart 3 super parameters are bridged.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // PersonBase is the parent class
  var person = PersonBase('Alice', 30);
  if (person.name != 'Alice') {
    errors.add('PersonBase.name expected "Alice", got "${person.name}"');
  }
  if (person.age != 30) {
    errors.add('PersonBase.age expected 30, got ${person.age}');
  }

  // Employee extends PersonBase with super(name, age) call
  var emp = Employee('Bob', 25, 'Engineering');
  if (emp.name != 'Bob') {
    errors.add('Employee.name expected "Bob", got "${emp.name}"');
  }
  if (emp.age != 25) {
    errors.add('Employee.age expected 25, got ${emp.age}');
  }
  if (emp.department != 'Engineering') {
    errors.add('Employee.department expected "Engineering", got "${emp.department}"');
  }

  // Manager extends PersonBase using super.name, super.age (super params)
  var mgr = Manager('Carol', 40, 'Sales', 8);
  if (mgr.name != 'Carol') {
    errors.add('Manager.name expected "Carol", got "${mgr.name}"');
  }
  if (mgr.teamSize != 8) {
    errors.add('Manager.teamSize expected 8, got ${mgr.teamSize}');
  }

  if (errors.isEmpty) {
    print('CTOR08_PASSED');
  } else {
    print('CTOR08_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
