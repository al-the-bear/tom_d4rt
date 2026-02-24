// D4rt test: TYPE01 - Record type parameter
// Verifies functions with record-type parameters work via bridges.
// Note: Records are structural types — bridges may not be needed.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // swap takes (int, int) record and returns (int, int)
  var result = swap((10, 20));
  if (result.$1 != 20) {
    errors.add('swap((10,20)).\$1 expected 20, got ${result.$1}');
  }
  if (result.$2 != 10) {
    errors.add('swap((10,20)).\$2 expected 10, got ${result.$2}');
  }

  if (errors.isEmpty) {
    print('TYPE01_PASSED');
  } else {
    print('TYPE01_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
