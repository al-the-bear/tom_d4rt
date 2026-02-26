// D4rt test: CLS12 - Static getter
// Verifies static getter is accessible via bridges.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Counter.label is a static getter (returns 'Counter: $_label')
  var val = Counter.label;
  if (!val.startsWith('Counter:')) {
    errors.add('Counter.label expected to start with "Counter:", got "$val"');
  }

  if (errors.isEmpty) {
    print('CLS12_PASSED');
  } else {
    print('CLS12_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
