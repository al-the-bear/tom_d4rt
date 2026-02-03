// Example: Basic Execution
// From: README.md - Basic Execution
//
// Demonstrates calling functions with arguments.

import 'package:tom_d4rt/d4rt.dart';

void main() {
  final d4rt = D4rt();

  // Call main() by default
  print('=== Default main() call ===');
  d4rt.execute(
    source: '''
      void main() {
        print("Hello!");
      }
    ''',
  );

  // Call a custom function with arguments
  print('\n=== Custom function with arguments ===');
  final result = d4rt.execute(
    source: '''
      String greet(String name, int age) {
        return "Hello \$name, you are \$age";
      }
    ''',
    name: 'greet',
    positionalArgs: ['Alice', 30],
  );
  print(result); // "Hello Alice, you are 30"
}
