// D4rt test: CTOR06 - Redirecting constructor
// Verifies redirecting constructors are bridged.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Vector has redirecting constructors: Vector.zero() : this(0, 0) and Vector.unit() : this(1, 1)
  var v1 = Vector(3.0, 4.0);
  if (v1.x != 3.0) {
    errors.add('Vector(3,4).x expected 3.0, got ${v1.x}');
  }
  if (v1.y != 4.0) {
    errors.add('Vector(3,4).y expected 4.0, got ${v1.y}');
  }

  var zero = Vector.zero();
  if (zero.x != 0.0) {
    errors.add('Vector.zero().x expected 0.0, got ${zero.x}');
  }
  if (zero.y != 0.0) {
    errors.add('Vector.zero().y expected 0.0, got ${zero.y}');
  }

  var unit = Vector.unit();
  if (unit.x != 1.0) {
    errors.add('Vector.unit().x expected 1.0, got ${unit.x}');
  }
  if (unit.y != 1.0) {
    errors.add('Vector.unit().y expected 1.0, got ${unit.y}');
  }

  if (errors.isEmpty) {
    print('CTOR06_PASSED');
  } else {
    print('CTOR06_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
