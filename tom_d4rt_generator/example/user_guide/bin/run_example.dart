#!/usr/bin/env dart
/// Example script that uses generated bridges.
///
/// From: bridgegenerator_user_guide.md - Quick Start section
///
/// Run with:
/// ```bash
/// dart run bin/run_example.dart
/// ```
library;

import '../lib/src/greeter.dart';
import '../lib/src/calculator.dart';

// Uncomment when bridges are generated:
// import 'package:tom_d4rt/d4rt.dart';
// import 'package:user_guide_example/dartscript.dart';

void main() async {
  print('=== User Guide Quick Start Example ===');
  print('');

  // Example 1: Using classes directly in Dart
  print('1. Using classes directly in Dart:');

  final greeter = Greeter('Hello');
  print('   ${greeter.greet("World")}');

  final defaultGreeter = Greeter.defaultGreeting();
  print('   ${defaultGreeter.greet("D4rt")}');

  final calc = Calculator();
  print('   2 + 3 = ${calc.add(2, 3)}');
  print('   10 / 3 = ${calc.divide(10.0, 3.0, precision: 3)}');
  print('   Quick add: ${Calculator.quickAdd(5, 7)}');

  // Example 2: Using with D4rt interpreter (requires generated bridges)
  print('\n2. Using with D4rt interpreter:');
  print('   Note: First generate bridges with:');
  print('   dart run tom_d4rt_generator --config d4rt_bridging.json');
  print('');

  // Once bridges are generated, uncomment and run:
  /*
  final d4rt = D4rt();
  UserGuideExampleBridges.registerAllBridges(d4rt);

  const script = '''
import 'package:user_guide_example/user_guide_example.dart';

void main() {
  final greeter = Greeter('Hi');
  print(greeter.greet('World'));
  
  final calc = Calculator();
  print('2 + 3 = \${calc.add(2, 3)}');
  
  return 'Example completed successfully!';
}
''';

  final result = await d4rt.execute(source: script);
  print('Result: $result');
  */

  print('\n=== Example complete ===');
}
