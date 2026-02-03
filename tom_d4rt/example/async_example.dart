// Example: Async Functions in D4rt
// From: doc/d4rt_user_guide.md - Execution Flow (async section)
//
// D4rt properly handles Future return values from async functions.

import 'package:tom_d4rt/d4rt.dart';

void main() async {
  final d4rt = D4rt();

  print('=== Async Function Execution ===');

  // Execute an async function
  final result = await d4rt.execute(
    source: '''
      Future<int> fetchValue() async {
        await Future.delayed(Duration(milliseconds: 100));
        return 42;
      }
    ''',
    name: 'fetchValue',
  );

  print('Async result: $result'); // 42

  // Async function with arguments
  print('\n=== Async with Arguments ===');
  final greeting = await d4rt.execute(
    source: '''
      Future<String> fetchGreeting(String name) async {
        await Future.delayed(Duration(milliseconds: 50));
        return "Hello, \$name!";
      }
    ''',
    name: 'fetchGreeting',
    positionalArgs: ['World'],
  );

  print('Async greeting: $greeting'); // Hello, World!

  // Multiple async operations in a script
  print('\n=== Multiple Async Operations ===');
  final data = await d4rt.execute(
    source: '''
      Future<List<int>> processData() async {
        final results = <int>[];
        for (var i = 1; i <= 3; i++) {
          await Future.delayed(Duration(milliseconds: 10));
          results.add(i * 10);
        }
        return results;
      }
    ''',
    name: 'processData',
  );

  print('Processed data: $data'); // [10, 20, 30]
}
