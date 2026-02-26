// D4rt test: TOP03 - Sealed class
// Verifies sealed class subtypes are constructible and usable.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Construct sealed subtypes
  var circle = SealedCircle(5.0);
  if (circle.radius != 5.0) {
    errors.add('SealedCircle.radius expected 5.0, got ${circle.radius}');
  }

  var square = SealedSquare(4.0);
  if (square.side != 4.0) {
    errors.add('SealedSquare.side expected 4.0, got ${square.side}');
  }

  var tri = SealedTriangle(3.0, 6.0);
  if (tri.base != 3.0) {
    errors.add('SealedTriangle.base expected 3.0, got ${tri.base}');
  }
  if (tri.height != 6.0) {
    errors.add('SealedTriangle.height expected 6.0, got ${tri.height}');
  }

  if (errors.isEmpty) {
    print('TOP03_PASSED');
  } else {
    print('TOP03_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
