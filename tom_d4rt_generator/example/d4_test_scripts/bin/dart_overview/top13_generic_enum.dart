// D4rt test: TOP13 - Generic enum
// Dart does not support generic enums (enums cannot have type parameters).
// This test verifies that enhanced enums with const constructor work instead.
// Marked as N/A in coverage: Dart language limitation, not a bridge limitation.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Dart enums cannot be generic (no `enum Foo<T> { ... }`).
  // Enhanced enums with fields are the closest alternative.
  // HttpStatus is an enhanced enum with fields (code, message)
  var status = HttpStatus.ok;
  if (status.code != 200) {
    errors.add('HttpStatus.ok.code expected 200, got ${status.code}');
  }

  // Operation is an enhanced enum with methods
  var add = Operation.add;
  var result = add.execute(5.0, 3.0);
  if (result != 8.0) {
    errors.add('Operation.add.execute(5.0, 3.0) expected 8.0, got $result');
  }

  // This test passes because the feature is N/A (language limitation).
  // We test the closest equivalent (enhanced enums) to verify they work.
  if (errors.isEmpty) {
    print('TOP13_PASSED');
  } else {
    print('TOP13_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
