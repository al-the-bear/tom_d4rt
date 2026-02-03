// Example: Using eval() for REPL-style Interaction
// From: doc/d4rt_user_guide.md - The eval() Method
//
// This example demonstrates how to use eval() for incremental code
// execution after establishing context with execute().
//
// IMPORTANT: You must call execute() first before using eval().

import 'package:tom_d4rt/d4rt.dart';

void main() {
  final d4rt = D4rt();

  // First, establish context with execute()
  print('=== Establishing Context ===');
  d4rt.execute(
    source: '''
      var counter = 0;
      void increment() { counter++; }
      int getCounter() => counter;
    ''',
  );

  // Now use eval() for incremental operations
  print('\n=== Using eval() ===');
  d4rt.eval('increment()');
  d4rt.eval('increment()');
  print('Counter after 2 increments: ${d4rt.eval('getCounter()')}'); // 2

  // Evaluate expressions
  print('\n=== Evaluating Expressions ===');
  print('2 + 2 = ${d4rt.eval('2 + 2')}');
  print('counter * 5 = ${d4rt.eval('counter * 5')}');

  // Declare new functions via eval
  print('\n=== Declaring New Functions ===');
  d4rt.eval('int double(int x) => x * 2;');
  print('double(counter) = ${d4rt.eval('double(counter)')}'); // 4

  // Declare new variables via eval
  d4rt.eval('var multiplier = 3;');
  print('counter * multiplier = ${d4rt.eval('counter * multiplier')}'); // 6

  // Execute statements
  d4rt.eval('counter++;');
  print('Counter after counter++: ${d4rt.eval('counter')}'); // 3
}
