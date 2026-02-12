// D4rt test: ASYNC01 - Async function (Future)
// Verifies async/await pattern works via bridges.
import 'package:d4_example/dart_overview.dart';

void main() async {
  var errors = <String>[];

  // Test calling async function and awaiting result
  var result1 = await fetchGreeting('World');
  if (result1 != 'Hello, World!') {
    errors.add('fetchGreeting("World") expected "Hello, World!", got "$result1"');
  }

  // Test chaining async calls
  var sum1 = await computeSum([10, 20, 30]);
  var sum2 = await computeSum([sum1, 40]);
  if (sum2 != 100) {
    errors.add('chained computeSum expected 100, got $sum2');
  }

  if (errors.isEmpty) {
    print('ASYNC01_PASSED');
  } else {
    print('ASYNC01_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
