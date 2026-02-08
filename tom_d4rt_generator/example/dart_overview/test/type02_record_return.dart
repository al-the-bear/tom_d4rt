// D4rt test: TYPE02 - Record type return
// Verifies functions returning record types work via bridges.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // findMinMax returns ({int min, int max})
  var mm = findMinMax([5, 2, 8, 1, 9, 3]);
  if (mm.min != 1) {
    errors.add('findMinMax min expected 1, got ${mm.min}');
  }
  if (mm.max != 9) {
    errors.add('findMinMax max expected 9, got ${mm.max}');
  }

  // parseUserString returns (String, int)
  var parsed = parseUserString('Alice:30');
  if (parsed.$1 != 'Alice') {
    errors.add('parseUserString \$1 expected "Alice", got ${parsed.$1}');
  }
  if (parsed.$2 != 30) {
    errors.add('parseUserString \$2 expected 30, got ${parsed.$2}');
  }

  // divideWithRemainder returns ({int quotient, int remainder})
  var dr = divideWithRemainder(17, 5);
  if (dr.quotient != 3) {
    errors.add('divideWithRemainder quotient expected 3, got ${dr.quotient}');
  }
  if (dr.remainder != 2) {
    errors.add('divideWithRemainder remainder expected 2, got ${dr.remainder}');
  }

  if (errors.isEmpty) {
    print('TYPE02_PASSED');
  } else {
    print('TYPE02_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
