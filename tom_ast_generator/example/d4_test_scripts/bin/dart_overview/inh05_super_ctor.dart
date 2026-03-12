// D4rt test: INH05 - Super constructor call
// Verifies subclass constructors that call super constructors work.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Employee extends PersonBase with super(name, age) call
  var emp = Employee('Alice', 30, 'Engineering');
  if (emp.name != 'Alice') {
    errors.add('Employee.name expected "Alice", got "${emp.name}"');
  }
  if (emp.age != 30) {
    errors.add('Employee.age expected 30, got ${emp.age}');
  }
  if (emp.department != 'Engineering') {
    errors.add('Employee.department expected "Engineering", got "${emp.department}"');
  }

  // Manager uses super.name, super.age (Dart 3 super params)
  var mgr = Manager('Bob', 45, 'Sales', 12);
  if (mgr.name != 'Bob') {
    errors.add('Manager.name expected "Bob", got "${mgr.name}"');
  }
  if (mgr.age != 45) {
    errors.add('Manager.age expected 45, got ${mgr.age}');
  }
  if (mgr.teamSize != 12) {
    errors.add('Manager.teamSize expected 12, got ${mgr.teamSize}');
  }

  if (errors.isEmpty) {
    print('INH05_PASSED');
  } else {
    print('INH05_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
