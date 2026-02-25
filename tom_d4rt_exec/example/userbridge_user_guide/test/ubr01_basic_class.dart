// D4rt test: UBR01 - User bridge class (basic)
//
// Tests that a user bridge class is properly registered and its members
// are accessible. Uses Vector2D which has a user bridge class.
//
// Verifies: class construction, field access, method calls, toString().

import 'package:userbridge_user_guide_example/userbridge_user_guide_example.dart';

void main() {
  var errors = <String>[];

  // ── Construction ─────────────────────────────────────────────────

  var v = Vector2D(3.0, 4.0);

  // ── Field access ─────────────────────────────────────────────────

  if (v.x != 3.0) errors.add('v.x expected 3.0, got ${v.x}');
  if (v.y != 4.0) errors.add('v.y expected 4.0, got ${v.y}');

  // ── Method call (auto-generated, not overridden) ─────────────────

  var scaled = v.scale(2.0);
  if (scaled.x != 6.0) errors.add('scale.x expected 6.0, got ${scaled.x}');
  if (scaled.y != 8.0) errors.add('scale.y expected 8.0, got ${scaled.y}');

  // ── Method call (user bridge override) ───────────────────────────

  var v2 = Vector2D(1.0, 2.0);
  var dot = v.dot(v2);
  if (dot != 11.0) errors.add('dot expected 11.0, got $dot');

  // ── toString ─────────────────────────────────────────────────────

  var str = v.toString();
  if (str != 'Vector2D(3.0, 4.0)') {
    errors.add('toString expected "Vector2D(3.0, 4.0)", got "$str"');
  }

  // ── Matrix2x2 user bridge class ──────────────────────────────────

  var m = Matrix2x2(1.0, 2.0, 3.0, 4.0);
  var det = m.determinant;
  if (det != -2.0) errors.add('determinant expected -2.0, got $det');

  var tr = m.trace;
  if (tr != 5.0) errors.add('trace expected 5.0, got $tr');

  // ── Summary ──────────────────────────────────────────────────────

  if (errors.isEmpty) {
    print('UBR01_PASSED');
  } else {
    print('UBR01_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
