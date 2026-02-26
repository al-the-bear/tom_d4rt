// D4rt test: UBR05 - User bridge constructor
//
// Tests that constructors work through user bridge registered classes.
// Verifies both unnamed and named constructors.

import 'package:userbridge_user_guide_example/userbridge_user_guide_example.dart';

void main() {
  var errors = <String>[];

  // ── Unnamed constructor ──────────────────────────────────────────

  var v1 = Vector2D(5.0, 12.0);
  if (v1.x != 5.0) errors.add('Vector2D(5,12).x expected 5.0, got ${v1.x}');
  if (v1.y != 12.0) errors.add('Vector2D(5,12).y expected 12.0, got ${v1.y}');

  // ── Named constructor: Vector2D.zero() ───────────────────────────

  var vz = Vector2D.zero();
  if (vz.x != 0.0) errors.add('Vector2D.zero().x expected 0.0, got ${vz.x}');
  if (vz.y != 0.0) errors.add('Vector2D.zero().y expected 0.0, got ${vz.y}');

  // ── Matrix2x2 unnamed constructor ────────────────────────────────

  var m = Matrix2x2(1.0, 0.0, 0.0, 1.0);
  if (m.determinant != 1.0) {
    errors.add('Matrix2x2 identity det expected 1.0, got ${m.determinant}');
  }

  // ── Matrix2x2 named constructor: identity() ──────────────────────

  var mi = Matrix2x2.identity();
  if (mi.determinant != 1.0) {
    errors.add('Matrix2x2.identity() det expected 1.0, got ${mi.determinant}');
  }
  if (mi.trace != 2.0) {
    errors.add('Matrix2x2.identity() trace expected 2.0, got ${mi.trace}');
  }

  // ── Verify constructed objects are usable ─────────────────────────

  var v2 = Vector2D(3.0, 4.0);
  var sum = v1 + v2;
  if (sum.x != 8.0) errors.add('sum.x expected 8.0, got ${sum.x}');
  if (sum.y != 16.0) errors.add('sum.y expected 16.0, got ${sum.y}');

  // ── Summary ──────────────────────────────────────────────────────

  if (errors.isEmpty) {
    print('UBR05_PASSED');
  } else {
    print('UBR05_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
