// D4rt test: TOP11 - Enhanced enum implements interface
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Operation implements MathOperation
  var mulResult = Operation.multiply.execute(4.0, 5.0);
  if (mulResult != 20.0) {
    errors.add('Operation.multiply.execute(4.0, 5.0) expected 20.0, got $mulResult');
  }

  var divResult = Operation.divide.execute(10.0, 2.0);
  if (divResult != 5.0) {
    errors.add('Operation.divide.execute(10.0, 2.0) expected 5.0, got $divResult');
  }

  // Verify all operations work via the interface
  var ops = [Operation.add, Operation.subtract, Operation.multiply, Operation.divide];
  for (var op in ops) {
    // All Operation values should be usable as MathOperation
    var result = op.execute(6.0, 3.0);
    if (result.isNaN) {
      errors.add('Operation.${op.name}.execute(6.0, 3.0) returned NaN');
    }
  }

  if (errors.isEmpty) {
    print('TOP11_PASSED');
  } else {
    print('TOP11_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
