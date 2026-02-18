// Example: Continued Execution
// From: doc/d4rt_user_guide.md - Continued Execution
//
// This example demonstrates continuedExecute() for running additional
// code in an existing context without resetting the environment.

import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  final d4rt = D4rt();

  // First execution establishes context
  print('=== Initial Execution ===');
  d4rt.execute(
    source: '''
      var sharedState = 0;
      void incrementState() { sharedState++; }
      
      void main() {
        incrementState();
        print('Initial state: \$sharedState');
      }
    ''',
  );

  // Continue in the same context with additional code
  print('\n=== Continued Execution ===');
  d4rt.continuedExecute(
    source: '''
      void doubleState() { sharedState *= 2; }
    ''',
    name: 'doubleState',
  );

  // Verify state is preserved
  print('State after doubleState: ${d4rt.eval('sharedState')}'); // 2

  // Continue with more operations
  d4rt.continuedExecute(
    source: '''
      void addToState(int amount) { sharedState += amount; }
    ''',
    name: 'addToState',
    positionalArgs: [10],
  );

  print('State after addToState(10): ${d4rt.eval('sharedState')}'); // 12
}
