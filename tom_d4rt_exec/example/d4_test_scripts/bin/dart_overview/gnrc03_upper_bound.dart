// D4rt test: GNRC03 - Upper bound (T extends X)
// Verifies generic classes with upper bounds work via bridges.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Statistics<T extends num> — T is bounded to num
  var intStats = Statistics<int>([10, 20, 30, 40, 50]);

  if (intStats.min != 10) {
    errors.add('Statistics<int>.min expected 10, got ${intStats.min}');
  }
  if (intStats.max != 50) {
    errors.add('Statistics<int>.max expected 50, got ${intStats.max}');
  }

  var avg = intStats.average;
  if ((avg - 30.0).abs() > 0.001) {
    errors.add('Statistics<int>.average expected 30.0, got $avg');
  }

  // Double version
  var doubleStats = Statistics<double>([1.5, 2.5, 3.5]);
  if (doubleStats.min != 1.5) {
    errors.add('Statistics<double>.min expected 1.5, got ${doubleStats.min}');
  }
  if (doubleStats.max != 3.5) {
    errors.add('Statistics<double>.max expected 3.5, got ${doubleStats.max}');
  }

  if (errors.isEmpty) {
    print('GNRC03_PASSED');
  } else {
    print('GNRC03_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
