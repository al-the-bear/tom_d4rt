// D4rt test: TYPE03 - Nullable parameter
// Verifies functions with nullable parameters work correctly.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // describe({required String name, int? age, String? city})
  // All named, age and city are nullable
  // We just verify it can be called without optional params
  describe(name: 'Alice');

  // With nullable params provided
  describe(name: 'Bob', age: 30);
  describe(name: 'Charlie', age: 25, city: 'NYC');

  // firstOrNull<T>(List<T>) returns T? (nullable return)
  var result = firstOrNull(<int>[]);
  if (result != null) {
    errors.add('firstOrNull([]) expected null, got $result');
  }

  var result2 = firstOrNull([42]);
  if (result2 != 42) {
    errors.add('firstOrNull([42]) expected 42, got $result2');
  }

  if (errors.isEmpty) {
    print('TYPE03_PASSED');
  } else {
    print('TYPE03_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
