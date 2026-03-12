// D4rt test: TOP19 - Typedef (function)
// Typedefs are type aliases — not separate types needing bridges.
// The generator bridges the underlying types directly.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Function typedefs like IntOperation = int Function(int, int)
  // are just aliases. The bridge handles the underlying Function type.
  // We verify functions work with closure parameters (which is what
  // typedef'd functions look like at runtime).
  var result = transform([1, 2, 3], (n) => n + 10);
  if (result[0] != 11) {
    errors.add('transform with closure expected 11, got ${result[0]}');
  }

  if (errors.isEmpty) {
    print('TOP19_PASSED');
  } else {
    print('TOP19_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
