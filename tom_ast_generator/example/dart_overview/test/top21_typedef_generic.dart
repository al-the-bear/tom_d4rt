// D4rt test: TOP21 - Typedef (generic)
// Generic typedefs (e.g., typedef Predicate<T> = bool Function(T))
// don't need bridges — resolved to concrete function types at usage.
import 'package:dart_overview/dart_overview.dart';

void main() {
  // Generic typedefs are compile-time constructs.
  // We verify that generic function parameters work correctly.
  var result = firstOrNull<int>([100, 200]);
  if (result != 100) {
    print('TOP21_FAILED');
    print('  - firstOrNull expected 100, got $result');
  } else {
    print('TOP21_PASSED');
  }
}
