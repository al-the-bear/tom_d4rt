// D4rt test: ASYNC06 - Instance sync* method (Iterable)
// Verifies that instance methods using sync* returning Iterable<T>
// are correctly bridged and can be iterated from a D4rt script.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // ── Create instance ──────────────────────────────────────────────

  var processor = DataProcessor('test');

  // ── Test instance sync* method ───────────────────────────────────

  var items = processor.generateRange(3, 7).toList();
  if (items.length != 5) {
    errors.add('generateRange(3,7) expected 5 items, got ${items.length}');
  }
  if (items.isNotEmpty && items[0] != 3) {
    errors.add('generateRange first expected 3, got ${items[0]}');
  }
  if (items.length >= 5 && items[4] != 7) {
    errors.add('generateRange last expected 7, got ${items[4]}');
  }

  // Test lazy evaluation — take only first 2 from a larger range
  var lazy = processor.generateRange(1, 100).take(2).toList();
  if (lazy.length != 2) {
    errors.add('generateRange take 2 expected 2 items, got ${lazy.length}');
  }
  if (lazy.isNotEmpty && lazy[0] != 1) {
    errors.add('lazy first expected 1, got ${lazy[0]}');
  }

  // ── Summary ──────────────────────────────────────────────────────

  if (errors.isEmpty) {
    print('ASYNC06_PASSED');
  } else {
    print('ASYNC06_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
