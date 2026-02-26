// D4rt test: OP06 - operator ~/
// Verifies operator ~/ (integer divide) on bridged classes.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  var a = NumberWrapper(10);
  var b = NumberWrapper(3);

  var result = a ~/ b;
  // 10 ~/ 3 = 3
  if (result.value != 3.0) {
    errors.add('NumberWrapper(10) ~/ NumberWrapper(3) expected 3.0, got ${result.value}');
  }

  var c = NumberWrapper(7);
  var d = NumberWrapper(2);
  var result2 = c ~/ d;
  if (result2.value != 3.0) {
    errors.add('NumberWrapper(7) ~/ NumberWrapper(2) expected 3.0, got ${result2.value}');
  }

  if (errors.isEmpty) {
    print('OP06_PASSED');
  } else {
    print('OP06_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
