// D4rt test: UBR04 - User bridge operator overrides
//
// Tests that user bridge operator overrides execute instead of generated code.
// Verifies both correctness and that print markers appear (proving user bridge ran).
//
// Operators tested: +, - (binary), - (unary), *, [] (index), []= (index assign)

import 'package:userbridge_user_guide_example/userbridge_user_guide_example.dart';

void main() {
  var errors = <String>[];

  var v1 = Vector2D(3.0, 4.0);
  var v2 = Vector2D(1.0, 2.0);

  // ── operator+ (user bridge) ──────────────────────────────────────

  var sum = v1 + v2;
  if (sum.x != 4.0) errors.add('(v1+v2).x expected 4.0, got ${sum.x}');
  if (sum.y != 6.0) errors.add('(v1+v2).y expected 6.0, got ${sum.y}');

  // ── operator- binary (user bridge) ───────────────────────────────

  var diff = v1 - v2;
  if (diff.x != 2.0) errors.add('(v1-v2).x expected 2.0, got ${diff.x}');
  if (diff.y != 2.0) errors.add('(v1-v2).y expected 2.0, got ${diff.y}');

  // ── operator- unary (user bridge) ────────────────────────────────

  var neg = -v1;
  if (neg.x != -3.0) errors.add('(-v1).x expected -3.0, got ${neg.x}');
  if (neg.y != -4.0) errors.add('(-v1).y expected -4.0, got ${neg.y}');

  // ── operator* scalar (user bridge) ───────────────────────────────

  var scaled = v1 * 2.0;
  if (scaled.x != 6.0) errors.add('(v1*2).x expected 6.0, got ${scaled.x}');
  if (scaled.y != 8.0) errors.add('(v1*2).y expected 8.0, got ${scaled.y}');

  // ── Matrix2x2 operator[] (user bridge) ───────────────────────────

  var m = Matrix2x2(1.0, 2.0, 3.0, 4.0);
  var elem = m[[0, 1]];
  if (elem != 2.0) errors.add('m[0,1] expected 2.0, got $elem');

  // ── Matrix2x2 operator[]= (user bridge) ──────────────────────────

  m[[0, 1]] = 99.0;
  var updated = m[[0, 1]];
  if (updated != 99.0) errors.add('m[0,1] after set expected 99.0, got $updated');

  // ── Summary ──────────────────────────────────────────────────────

  if (errors.isEmpty) {
    print('UBR04_PASSED');
  } else {
    print('UBR04_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
