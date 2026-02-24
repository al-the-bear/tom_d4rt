// D4rt test: TOP24 - Top-level async function
// Verifies async functions (returning Future) work via bridges.
import 'package:d4_example/dart_overview.dart';

void main() async {
  var errors = <String>[];

  // fetchGreeting returns Future<String>
  var greeting = await fetchGreeting('D4rt');
  if (greeting != 'Hello, D4rt!') {
    errors.add('fetchGreeting("D4rt") expected "Hello, D4rt!", got "$greeting"');
  }

  // computeSum returns Future<int>
  var sum = await computeSum([1, 2, 3, 4, 5]);
  if (sum != 15) {
    errors.add('computeSum([1,2,3,4,5]) expected 15, got $sum');
  }

  if (errors.isEmpty) {
    print('TOP24_PASSED');
  } else {
    print('TOP24_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
