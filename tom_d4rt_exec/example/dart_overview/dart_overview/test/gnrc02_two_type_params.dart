// D4rt test: GNRC02 - Generic with two type parameters
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Pair<String, int>
  var pair1 = Pair('key', 100);
  if (pair1.first != 'key') {
    errors.add('Pair.first expected "key", got "${pair1.first}"');
  }
  if (pair1.second != 100) {
    errors.add('Pair.second expected 100, got ${pair1.second}');
  }

  // Test Pair<bool, double>
  var pair2 = Pair(true, 3.14);
  if (pair2.first != true) {
    errors.add('Pair.first expected true, got ${pair2.first}');
  }
  if (pair2.second != 3.14) {
    errors.add('Pair.second expected 3.14, got ${pair2.second}');
  }

  // Test Result.success
  var success = Result.success(42);
  if (success.isSuccess != true) {
    errors.add('Result.success(42).isSuccess expected true, got ${success.isSuccess}');
  }

  // Test Result.failure
  var failure = Result.failure('err');
  if (failure.isSuccess != false) {
    errors.add('Result.failure("err").isSuccess expected false, got ${failure.isSuccess}');
  }

  if (errors.isEmpty) {
    print('GNRC02_PASSED');
  } else {
    print('GNRC02_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
