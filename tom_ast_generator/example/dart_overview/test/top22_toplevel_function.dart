// D4rt test: TOP22 - Top-level functions
// Verifies top-level functions are callable via bridges.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // multiply is a top-level function from functions/declarations
  var m = multiply(3, 4);
  if (m != 12) {
    errors.add('multiply(3, 4) expected 12, got $m');
  }

  // square is an arrow function
  var s = square(5);
  if (s != 25) {
    errors.add('square(5) expected 25, got $s');
  }

  // cube is an arrow function
  var c = cube(3);
  if (c != 27) {
    errors.add('cube(3) expected 27, got $c');
  }

  // isEven is an arrow function returning bool
  var even = isEven(4);
  if (even != true) {
    errors.add('isEven(4) expected true, got $even');
  }

  // log is from globals
  log('Test log message');

  if (errors.isEmpty) {
    print('TOP22_PASSED');
  } else {
    print('TOP22_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
