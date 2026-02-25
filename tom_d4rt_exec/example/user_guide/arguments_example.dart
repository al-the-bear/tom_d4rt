// Example: Passing Arguments to D4rt Scripts
// From: doc/d4rt_user_guide.md - Passing Arguments
//
// This example shows how to pass positional and named arguments
// to functions executed by D4rt.

import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  final d4rt = D4rt();

  // Positional arguments
  print('=== Positional Arguments ===');
  final greeting = d4rt.execute(
    source: '''
      String greet(String name, int age) {
        return "Hello \$name, you are \$age years old";
      }
    ''',
    name: 'greet',
    positionalArgs: ['Alice', 30],
  );
  print(greeting); // Hello Alice, you are 30 years old

  // Named arguments
  print('\n=== Named Arguments ===');
  d4rt.execute(
    source: '''
      void configure({required String mode, int port = 8080}) {
        print("Mode: \$mode, Port: \$port");
      }
    ''',
    name: 'configure',
    namedArgs: {'mode': 'production', 'port': 9000},
  );

  // Mixed positional and named arguments
  print('\n=== Mixed Arguments ===');
  final mixed = d4rt.execute(
    source: '''
      String greet(String greeting, {required String name}) {
        return "\$greeting \$name";
      }
    ''',
    name: 'greet',
    positionalArgs: ['Hello'],
    namedArgs: {'name': 'World'},
  );
  print(mixed); // Hello World
}
