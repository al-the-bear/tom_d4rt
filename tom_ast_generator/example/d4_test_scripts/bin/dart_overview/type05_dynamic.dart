// D4rt test: TYPE05 - Dynamic parameter/return
// Verifies dynamic-typed parameters and returns work via bridges.
// (This feature is marked ✅ in coverage via e2e, but having a focused test is good.)
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // dynamicReturn(int) returns dynamic based on choice
  var result = dynamicReturn(1);
  if (result is! String) {
    errors.add('dynamicReturn(1) expected String, got ${result.runtimeType}');
  }

  var result2 = dynamicReturn(2);
  if (result2 is! int) {
    errors.add('dynamicReturn(2) expected int, got ${result2.runtimeType}');
  }

  // inferredReturn() — inferred return type
  var result3 = inferredReturn();
  if (result3 != 42) {
    errors.add('inferredReturn() expected 42, got $result3');
  }

  if (errors.isEmpty) {
    print('TYPE05_PASSED');
  } else {
    print('TYPE05_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
