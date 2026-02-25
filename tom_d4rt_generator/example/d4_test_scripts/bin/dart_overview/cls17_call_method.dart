// D4rt test: CLS17 - call() method
// Verifies classes with call() method work via bridges.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Multiplier has call(int) method — instances are callable
  var doubler = Multiplier(2);
  var tripler = Multiplier(3);

  // Test via explicit call()
  var r1 = doubler.call(5);
  if (r1 != 10) {
    errors.add('Multiplier(2).call(5) expected 10, got $r1');
  }

  var r2 = tripler.call(4);
  if (r2 != 12) {
    errors.add('Multiplier(3).call(4) expected 12, got $r2');
  }

  // Test via implicit call (callable syntax)
  var r3 = doubler(7);
  if (r3 != 14) {
    errors.add('Multiplier(2)(7) expected 14, got $r3');
  }

  if (errors.isEmpty) {
    print('CLS17_PASSED');
  } else {
    print('CLS17_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
