// D4rt test script for userbridge_override
// Tests MyList, global functions and variables via generated bridges.

import 'package:userbridge_override_example/userbridge_override_example.dart';

void main() {
  // Test global constants
  print('App name: $appName');
  print('Max retries: $maxRetries');
  print('Version: $version');

  // Test top-level functions
  print('Greet: ${greet("World")}');
  print('Calculate add: ${calculate(5, 3)}');
  print('Calculate subtract: ${calculate(10, 4, operation: "subtract")}');

  // Test MyList class
  var list = MyList();
  list.add(1);
  list.add(2);
  list.add(3);
  print('List length: ${list.length}');
  print('List empty: ${list.isEmpty}');

  print('ALL_TESTS_PASSED');
}
