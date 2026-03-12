// D4rt test: CLS07 - Static field (mutable)
// Verifies static mutable fields are readable and writable via bridges.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Counter has static int instanceCount
  var initial = Counter.instanceCount;

  // Creating a Counter increments the static field
  Counter();
  if (Counter.instanceCount != initial + 1) {
    errors.add('Counter.instanceCount after 1 creation expected ${initial + 1}, got ${Counter.instanceCount}');
  }

  Counter();
  if (Counter.instanceCount != initial + 2) {
    errors.add('Counter.instanceCount after 2 creations expected ${initial + 2}, got ${Counter.instanceCount}');
  }

  if (errors.isEmpty) {
    print('CLS07_PASSED');
  } else {
    print('CLS07_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
