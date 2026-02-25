// D4rt test: CLS11 - Static method
// Verifies static methods are callable via bridges.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // MathUtils has static methods: square, cube, isEven
  var sq = MathUtils.square(5);
  if (sq != 25) {
    errors.add('MathUtils.square(5) expected 25, got $sq');
  }

  var cb = MathUtils.cube(3);
  if (cb != 27) {
    errors.add('MathUtils.cube(3) expected 27, got $cb');
  }

  var even = MathUtils.isEven(4);
  if (even != true) {
    errors.add('MathUtils.isEven(4) expected true, got $even');
  }

  var odd = MathUtils.isEven(7);
  if (odd != false) {
    errors.add('MathUtils.isEven(7) expected false, got $odd');
  }

  if (errors.isEmpty) {
    print('CLS11_PASSED');
  } else {
    print('CLS11_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
