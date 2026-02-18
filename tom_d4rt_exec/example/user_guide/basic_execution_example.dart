// Example: Basic D4rt Execution
// From: doc/d4rt_user_guide.md - Getting Started, Basic Usage
//
// This example demonstrates the fundamental D4rt execution model:
// - Creating an interpreter instance
// - Executing simple scripts
// - The initialization model (execute() initializes the context)

import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  final d4rt = D4rt();

  // Basic execution - calls main() by default
  print('=== Basic Execution ===');
  d4rt.execute(
    source: '''
      void main() {
        print("Hello from D4rt!");
      }
    ''',
  );

  // Calling a custom function instead of main
  print('\n=== Custom Function ===');
  d4rt.execute(
    source: '''
      void setup() {
        print("Setting up...");
      }
      
      void run() {
        print("Running...");
      }
    ''',
    name: 'setup', // Calls setup() instead of main()
  );

  // Execute returns the function's return value
  print('\n=== Return Values ===');
  final result = d4rt.execute(
    source: '''
      int add(int a, int b) => a + b;
    ''',
    name: 'add',
    positionalArgs: [10, 20],
  );
  print('Result of add(10, 20): $result'); // 30
}
