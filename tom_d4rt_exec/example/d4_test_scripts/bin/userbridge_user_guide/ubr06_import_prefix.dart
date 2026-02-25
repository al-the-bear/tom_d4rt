// D4rt test: UBR06 - User bridge import prefix
//
// Tests that user bridge generated code uses correct import prefixes.
// This verifies GEN-043 fix: user bridge references to bridged types
// must use the $pkg. prefix in generated code.
//
// If the import prefix is wrong, the bridge won't compile and this
// test will fail at runtime.

import 'package:d4_example/userbridge_user_guide.dart';

void main() {
  var errors = <String>[];

  // ── Vector2D via user bridge (tests import prefix) ───────────────

  var v1 = Vector2D(1.0, 2.0);
  var v2 = Vector2D(3.0, 4.0);

  // User bridge operator+ (references Vector2D type via import prefix)
  var sum = v1 + v2;
  if (sum.x != 4.0) errors.add('sum.x expected 4.0, got ${sum.x}');
  if (sum.y != 6.0) errors.add('sum.y expected 6.0, got ${sum.y}');

  // User bridge dot() method (returns double)
  var dot = v1.dot(v2);
  if (dot != 11.0) errors.add('dot expected 11.0, got $dot');

  // ── Matrix2x2 via user bridge (tests import prefix) ──────────────

  var m = Matrix2x2(1.0, 2.0, 3.0, 4.0);

  // User bridge operator[] (references Matrix2x2 type via import prefix)
  var elem = m[[0, 0]];
  if (elem != 1.0) errors.add('m[0,0] expected 1.0, got $elem');

  // User bridge operator[]= (references Matrix2x2 type via import prefix)
  m[[1, 1]] = 99.0;
  var updated = m[[1, 1]];
  if (updated != 99.0) errors.add('m[1,1] after set expected 99.0, got $updated');

  // ── row() method (auto-generated, also uses import prefix) ───────

  var row = m.row(0);
  print('row0: $row');

  // ── Summary ──────────────────────────────────────────────────────

  if (errors.isEmpty) {
    print('UBR06_PASSED');
  } else {
    print('UBR06_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
