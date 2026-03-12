// D4rt test script: GEN-041 — Enhanced enum fields
// Isolated test for enhanced enum field access via bridges.
// Expected: FAILS until GEN-041 is fixed.

import 'package:d4_example/example_project.dart';

void main() {
  // Simple enum — name and index should work
  print('Status.active name: ${Status.active.name}');
  print('Status.active index: ${Status.active.index}');

  // Enhanced enum — custom field access (this is the bug)
  print('Priority.high value: ${Priority.high.value}');
  print('Priority.low value: ${Priority.low.value}');
  print('Priority.critical value: ${Priority.critical.value}');

  // Enhanced enum — Color with multiple fields
  print('Color.red r: ${Color.red.r}');
  print('Color.red g: ${Color.red.g}');
  print('Color.red b: ${Color.red.b}');

  // Enhanced enum — Color getter access
  print('Color.red hex: ${Color.red.hex}');
  print('Color.red brightness: ${Color.red.brightness}');

  print('ALL_ENUM_FIELD_TESTS_PASSED');
}
