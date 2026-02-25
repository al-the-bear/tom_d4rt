// D4rt test: PAR06 - Function-typed parameter
// Verifies that functions accepting function parameters work via bridges.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // transform(List<int>, int Function(int)) -> List<int>
  var numbers = [1, 2, 3, 4, 5];

  var doubled = transform(numbers, (n) => n * 2);
  if (doubled.length != 5) {
    errors.add('transform doubled length expected 5, got ${doubled.length}');
  }
  if (doubled[0] != 2) {
    errors.add('transform doubled[0] expected 2, got ${doubled[0]}');
  }
  if (doubled[4] != 10) {
    errors.add('transform doubled[4] expected 10, got ${doubled[4]}');
  }

  var squared = transform(numbers, (n) => n * n);
  if (squared[0] != 1) {
    errors.add('transform squared[0] expected 1, got ${squared[0]}');
  }
  if (squared[2] != 9) {
    errors.add('transform squared[2] expected 9, got ${squared[2]}');
  }

  if (errors.isEmpty) {
    print('PAR06_PASSED');
  } else {
    print('PAR06_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
