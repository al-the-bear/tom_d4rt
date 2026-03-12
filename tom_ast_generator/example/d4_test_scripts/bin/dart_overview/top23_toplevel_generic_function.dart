// D4rt test: TOP23 - Top-level generic function
// Verifies generic top-level functions are callable via bridges.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // firstOrNull<T> is a generic top-level function
  var result1 = firstOrNull([1, 2, 3]);
  if (result1 != 1) {
    errors.add('firstOrNull([1,2,3]) expected 1, got $result1');
  }

  var result2 = firstOrNull(<int>[]);
  if (result2 != null) {
    errors.add('firstOrNull([]) expected null, got $result2');
  }

  var result3 = firstOrNull(['a', 'b']);
  if (result3 != 'a') {
    errors.add('firstOrNull(["a","b"]) expected "a", got $result3');
  }

  if (errors.isEmpty) {
    print('TOP23_PASSED');
  } else {
    print('TOP23_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
