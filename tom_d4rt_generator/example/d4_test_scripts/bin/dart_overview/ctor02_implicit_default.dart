// D4rt test: CTOR02 - Implicit default constructors (GEN-042 known broken)
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Person implicit default constructor (GEN-042)
  try {
    var person = Person();
    // If we get here, verify defaults
    if (person.name != '') errors.add('Person.name expected "", got "${person.name}"');
    if (person.age != 0) errors.add('Person.age expected 0, got ${person.age}');
  } catch (e) {
    errors.add('Person() threw: $e');
  }

  // Test Calculator implicit default constructor (GEN-042)
  try {
    var calc = Calculator();
    // If we get here, verify methods work
    var result = calc.add(2, 3);
    if (result != 5) errors.add('Calculator.add(2, 3) expected 5, got $result');
  } catch (e) {
    errors.add('Calculator() threw: $e');
  }

  if (errors.isEmpty) {
    print('CTOR02_PASSED');
  } else {
    print('CTOR02_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
