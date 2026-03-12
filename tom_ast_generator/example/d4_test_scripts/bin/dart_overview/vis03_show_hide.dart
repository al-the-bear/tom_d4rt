// D4rt test: VIS03 - Show/hide combinators
// Verifies barrel show/hide combinators correctly filter exports.
// The barrel uses show/hide on all its export directives.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Verify types that ARE exported (show)
  // These should be accessible via the barrel
  var person = Person();
  person.name = 'Test';
  if (person.name != 'Test') {
    errors.add('Person from barrel failed');
  }

  var box = Box<int>(42);
  if (box.value != 42) {
    errors.add('Box from barrel failed');
  }

  // MathUtils is shown from static_object_methods
  var sq = MathUtils.square(5);
  if (sq != 25) {
    errors.add('MathUtils.square(5) expected 25, got $sq');
  }

  // Counter is shown
  var count = Counter.instanceCount;
  if (count < 0) {
    errors.add('Counter.instanceCount should be non-negative');
  }

  // firstOrNull is shown from globals
  var r = firstOrNull([1, 2, 3]);
  if (r != 1) {
    errors.add('firstOrNull from barrel expected 1, got $r');
  }

  // The barrel hides 'main' from all modules — this is validated
  // by the fact that there's no name conflict

  if (errors.isEmpty) {
    print('VIS03_PASSED');
  } else {
    print('VIS03_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
