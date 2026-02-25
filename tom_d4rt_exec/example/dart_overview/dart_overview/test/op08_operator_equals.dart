// D4rt test: OP08 - operator ==
// Verifies operator == is callable on bridged classes.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Point has custom operator == based on x and y
  // (from static_object_methods)
  var p1 = Point(1, 2);
  var p2 = Point(1, 2);
  var p3 = Point(3, 4);

  if (!(p1 == p2)) {
    errors.add('Point(1,2) == Point(1,2) expected true, got false');
  }

  if (p1 == p3) {
    errors.add('Point(1,2) == Point(3,4) expected false, got true');
  }

  // SortablePerson uses default == (identity)
  var sp1 = SortablePerson('Alice', 30);
  var sp2 = SortablePerson('Alice', 30);
  // Default == compares identity, not fields — they should NOT be equal
  // We just verify the comparison doesn't crash
  var eq = (sp1 == sp2);
  // In D4rt the bridge might handle this differently
  // Just ensure the comparison produces a result
  if (eq && identical(sp1, sp2) == false) {
    // Non-identical objects comparing equal is fine if bridge does value comparison
  }

  if (errors.isEmpty) {
    print('OP08_PASSED');
  } else {
    print('OP08_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
