// Run the UserBridge override example with D4rt.
//
// This script demonstrates how generated bridges work with
// UserBridge overrides for operators and globals.

import 'package:tom_d4rt/tom_d4rt.dart';

import '../lib/src/my_list.dart';
import '../lib/src/globals.dart' as globals;
// Import generated bridge when available
// import 'userbridge_override_bridge.g.dart';

void main() async {
  print('=== UserBridge Override Example ===\n');

  // Example 1: Using MyList directly in Dart
  print('1. Using MyList in Dart:');
  final list = MyList<String>();
  list.add('one');
  list.add('two');
  list.add('three');
  print('   list.length: ${list.length}');
  print('   list[0]: ${list[0]}');
  print('   list[1]: ${list[1]}');

  // Example 2: Using globals directly in Dart
  print('\n2. Using globals in Dart:');
  print('   appName: ${globals.appName}');
  print('   maxRetries: ${globals.maxRetries}');
  print('   version: ${globals.version}');
  print('   greet("World"): ${globals.greet("World")}');
  print('   calculate(5, 3): ${globals.calculate(5, 3)}');

  // Example 3: Using with D4rt interpreter
  print('\n3. Running in D4rt (requires generated bridges):');
  print('   Note: Run the bridge generator first with:');
  print('   dart run tom_d4rt_generator --config d4rt_bridging.json');
  print('');

  // Once bridges are generated, you can run scripts like:
  //
  // final interpreter = D4rtInterpreter();
  // registerBridges(interpreter);
  //
  // final script = '''
  // import 'userbridge_override_example.dart';
  //
  // var list = MyList<String>();
  // list.add('hello');
  // list.add('world');
  // print(list[0]);  // Uses bridged operator[]
  //
  // print(greet('D4rt'));  // Uses bridged global function
  // ''';
  //
  // await interpreter.run(script);

  print('\n=== Example complete ===');
}
