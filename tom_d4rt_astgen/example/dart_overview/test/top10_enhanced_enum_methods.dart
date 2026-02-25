// D4rt test: TOP10 - Enhanced enum methods
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Operation.add
  var addResult = Operation.add.execute(10.0, 3.0);
  if (addResult != 13.0) {
    errors.add('Operation.add.execute(10.0, 3.0) expected 13.0, got $addResult');
  }
  if (Operation.add.symbol != '+') {
    errors.add('Operation.add.symbol expected "+", got "${Operation.add.symbol}"');
  }

  // Test Operation.subtract
  var subResult = Operation.subtract.execute(10.0, 3.0);
  if (subResult != 7.0) {
    errors.add('Operation.subtract.execute(10.0, 3.0) expected 7.0, got $subResult');
  }
  if (Operation.subtract.symbol != '-') {
    errors.add('Operation.subtract.symbol expected "-", got "${Operation.subtract.symbol}"');
  }

  if (errors.isEmpty) {
    print('TOP10_PASSED');
  } else {
    print('TOP10_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
