// D4rt test: CLS13 - Static setter
// Verifies static setter is accessible via bridges.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Counter.label has a static setter that trims the value
  Counter.label = '  Custom Label  ';
  var after = Counter.label;
  // Setter trims, getter prefixes with 'Counter: '
  if (after != 'Counter: Custom Label') {
    errors.add('Counter.label after set expected "Counter: Custom Label", got "$after"');
  }

  // Restore (set without spaces)
  Counter.label = 'default';

  if (errors.isEmpty) {
    print('CLS13_PASSED');
  } else {
    print('CLS13_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
