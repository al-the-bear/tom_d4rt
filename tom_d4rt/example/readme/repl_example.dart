// Example: REPL-Style Evaluation
// From: README.md - REPL-Style Evaluation
//
// Demonstrates using eval() for incremental execution.

import 'package:tom_d4rt/d4rt.dart';

void main() {
  final d4rt = D4rt();

  // Establish context
  d4rt.execute(
    source: '''
      var counter = 0;
      void increment() { counter++; }
    ''',
  );

  // Use eval() in the established context
  d4rt.eval('increment()');
  d4rt.eval('increment()');
  print('Counter: ${d4rt.eval('counter')}'); // 2
}
