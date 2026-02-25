// D4rt test: OP07 - operator %
// Verifies operator % (modulo) on bridged classes.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  var a = NumberWrapper(10);
  var b = NumberWrapper(3);

  var result = a % b;
  // 10 % 3 = 1
  if (result.value != 1.0) {
    errors.add('NumberWrapper(10) % NumberWrapper(3) expected 1.0, got ${result.value}');
  }

  var c = NumberWrapper(15);
  var d = NumberWrapper(4);
  var result2 = c % d;
  // 15 % 4 = 3
  if (result2.value != 3.0) {
    errors.add('NumberWrapper(15) % NumberWrapper(4) expected 3.0, got ${result2.value}');
  }

  if (errors.isEmpty) {
    print('OP07_PASSED');
  } else {
    print('OP07_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
