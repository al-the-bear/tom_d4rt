// D4rt test script for userbridge_user_guide
// Tests Vector2D and Matrix2x2 operators via user bridge overrides.
//
// Verifies that user bridge code executes instead of generated code
// by checking for print markers:
//   [Vector2DUserBridge] operator+ called
//   [Vector2DUserBridge] binary operator- called
//   [Vector2DUserBridge] unary operator- called
//   [Vector2DUserBridge] operator* called
//   [Vector2DUserBridge] dot() called
//   [Matrix2x2UserBridge] operator[] called
//   [Matrix2x2UserBridge] operator[]= called

import 'package:d4_example/userbridge_user_guide.dart';

void main() {
  var errors = <String>[];

  // ── Vector2D basic construction ──────────────────────────────────

  var v1 = Vector2D(3.0, 4.0);
  var v2 = Vector2D(1.0, 2.0);

  if (v1.x != 3.0) errors.add('v1.x should be 3.0, got ${v1.x}');
  if (v1.y != 4.0) errors.add('v1.y should be 4.0, got ${v1.y}');

  // ── Vector2D.zero() constructor ──────────────────────────────────

  var vz = Vector2D.zero();
  if (vz.x != 0.0) errors.add('zero.x should be 0.0, got ${vz.x}');
  if (vz.y != 0.0) errors.add('zero.y should be 0.0, got ${vz.y}');

  // ── Vector2D operator+ (user bridge) ─────────────────────────────

  var sum = v1 + v2;
  if (sum.x != 4.0) errors.add('sum.x should be 4.0, got ${sum.x}');
  if (sum.y != 6.0) errors.add('sum.y should be 6.0, got ${sum.y}');

  // ── Vector2D operator- binary (user bridge) ──────────────────────

  var diff = v1 - v2;
  if (diff.x != 2.0) errors.add('diff.x should be 2.0, got ${diff.x}');
  if (diff.y != 2.0) errors.add('diff.y should be 2.0, got ${diff.y}');

  // ── Vector2D unary operator- (user bridge) ───────────────────────

  var neg = -v1;
  if (neg.x != -3.0) errors.add('neg.x should be -3.0, got ${neg.x}');
  if (neg.y != -4.0) errors.add('neg.y should be -4.0, got ${neg.y}');

  // ── Vector2D operator* (user bridge) ─────────────────────────────

  var scaled = v1 * 2.0;
  if (scaled.x != 6.0) errors.add('scaled.x should be 6.0, got ${scaled.x}');
  if (scaled.y != 8.0) errors.add('scaled.y should be 8.0, got ${scaled.y}');

  // ── Vector2D.dot() method (user bridge) ──────────────────────────

  var dotResult = v1.dot(v2);
  if (dotResult != 11.0) errors.add('dot should be 11.0, got $dotResult');

  // ── Vector2D.scale() method (auto-generated, no user bridge) ─────

  var scaleResult = v1.scale(3.0);
  if (scaleResult.x != 9.0) errors.add('scale.x should be 9.0, got ${scaleResult.x}');
  if (scaleResult.y != 12.0) errors.add('scale.y should be 12.0, got ${scaleResult.y}');

  // ── Vector2D.toString() ──────────────────────────────────────────

  print('v1.toString: ${v1.toString()}');

  // ── Matrix2x2 basic construction ─────────────────────────────────

  var m = Matrix2x2(1.0, 2.0, 3.0, 4.0);

  // ── Matrix2x2 operator[] (user bridge) ───────────────────────────

  var elem = m[[0, 1]];
  if (elem != 2.0) errors.add('m[0,1] should be 2.0, got $elem');

  var elem2 = m[[1, 0]];
  if (elem2 != 3.0) errors.add('m[1,0] should be 3.0, got $elem2');

  // ── Matrix2x2 operator[]= (user bridge) ──────────────────────────

  m[[0, 1]] = 99.0;
  var updated = m[[0, 1]];
  if (updated != 99.0) errors.add('m[0,1] should be 99.0 after set, got $updated');

  // ── Matrix2x2.row() ──────────────────────────────────────────────

  var row0 = m.row(0);
  print('row0: $row0');

  // ── Matrix2x2.determinant ────────────────────────────────────────

  var m2 = Matrix2x2(1.0, 2.0, 3.0, 4.0);
  var det = m2.determinant;
  if (det != -2.0) errors.add('determinant should be -2.0, got $det');

  // ── Matrix2x2.trace ──────────────────────────────────────────────

  var tr = m2.trace;
  if (tr != 5.0) errors.add('trace should be 5.0, got $tr');

  // ── Matrix2x2.identity() constructor ─────────────────────────────

  var identity = Matrix2x2.identity();
  var iDet = identity.determinant;
  if (iDet != 1.0) errors.add('identity determinant should be 1.0, got $iDet');

  // ── Report ───────────────────────────────────────────────────────

  if (errors.isNotEmpty) {
    for (var e in errors) {
      print('FAIL: $e');
    }
  } else {
    print('ALL_TESTS_PASSED');
  }
}
