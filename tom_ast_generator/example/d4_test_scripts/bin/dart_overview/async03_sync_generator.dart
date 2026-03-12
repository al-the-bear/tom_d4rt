// D4rt test: ASYNC03 - Sync* generator (Iterable)
// Verifies sync* generators (Iterable) work via bridges.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // countTo is a sync* generator returning Iterable<int>
  var list = countTo(5).toList();
  if (list.length != 5) {
    errors.add('countTo(5) expected 5 items, got ${list.length}');
  }
  if (list.isNotEmpty && list[0] != 1) {
    errors.add('countTo first expected 1, got ${list[0]}');
  }
  if (list.length >= 5 && list[4] != 5) {
    errors.add('countTo last expected 5, got ${list[4]}');
  }

  // range is a sync* generator with parameters
  var rangeList = range(10, 15).toList();
  if (rangeList.length != 6) {
    errors.add('range(10,15) expected 6 items, got ${rangeList.length}');
  }
  if (rangeList.isNotEmpty && rangeList[0] != 10) {
    errors.add('range first expected 10, got ${rangeList[0]}');
  }

  // naturalNumbers is an infinite sync* generator — take first 5
  var first5 = naturalNumbers().take(5).toList();
  if (first5.length != 5) {
    errors.add('naturalNumbers take 5 expected 5, got ${first5.length}');
  }
  if (first5.isNotEmpty && first5[0] != 1) {
    errors.add('naturalNumbers first expected 1, got ${first5[0]}');
  }

  // fibonacci is a sync* generator
  var fib = fibonacci().take(8).toList();
  if (fib.length != 8) {
    errors.add('fibonacci take 8 expected 8, got ${fib.length}');
  }
  // First 8 fibonacci: 0, 1, 1, 2, 3, 5, 8, 13
  if (fib.length >= 8 && fib[7] != 13) {
    errors.add('fibonacci[7] expected 13, got ${fib[7]}');
  }

  if (errors.isEmpty) {
    print('ASYNC03_PASSED');
  } else {
    print('ASYNC03_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
