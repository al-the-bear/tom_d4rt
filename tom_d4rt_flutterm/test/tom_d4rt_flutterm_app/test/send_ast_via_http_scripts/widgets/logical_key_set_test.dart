// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LogicalKeySet from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('LogicalKeySet test executing');
  print('=' * 50);

  // === Test LogicalKeySet class ===
  print('\nLogicalKeySet defines a set of logical keys for shortcuts');

  // Create a simple LogicalKeySet
  print('\n--- Testing LogicalKeySet creation ---');
  final keySet1 = LogicalKeySet(LogicalKeyboardKey.keyA);
  print('Created LogicalKeySet with keyA');
  print('keySet1.keys: ${keySet1.keys}');
  print('keySet1.runtimeType: ${keySet1.runtimeType}');

  // Create with multiple keys
  print('\n--- Testing with multiple keys ---');
  final keySet2 = LogicalKeySet(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.keyC,
  );
  print('Created Ctrl+C keyset');
  print('keySet2.keys: ${keySet2.keys}');
  print('keySet2.keys.length: ${keySet2.keys.length}');

  // Create with 3 keys
  print('\n--- Testing with 3 keys ---');
  final keySet3 = LogicalKeySet(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.shift,
    LogicalKeyboardKey.keyS,
  );
  print('Created Ctrl+Shift+S keyset');
  print('keySet3.keys: ${keySet3.keys}');

  // Create with 4 keys using fromSet
  print('\n--- Testing LogicalKeySet.fromSet ---');
  final keySet4 = LogicalKeySet.fromSet({
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.alt,
    LogicalKeyboardKey.shift,
    LogicalKeyboardKey.keyZ,
  });
  print('Created Ctrl+Alt+Shift+Z from set');
  print('keySet4.keys.length: ${keySet4.keys.length}');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('keySet1 is KeySet: ${keySet1 is KeySet}');
  print('keySet1 is ShortcutActivator: ${keySet1 is ShortcutActivator}');

  // Test triggers
  print('\n--- Testing triggers ---');
  print('keySet1.triggers: ${keySet1.triggers}');
  print('keySet2.triggers: ${keySet2.triggers}');

  // Test debugDescribeKeys
  print('\n--- Testing debugDescribeKeys ---');
  print('keySet2.debugDescribeKeys(): ${keySet2.debugDescribeKeys()}');
  print('keySet3.debugDescribeKeys(): ${keySet3.debugDescribeKeys()}');

  // Test equality
  print('\n--- Testing equality ---');
  final keySetCopy = LogicalKeySet(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.keyC,
  );
  print('keySet2 == keySetCopy: ${keySet2 == keySetCopy}');
  print('keySet1 == keySet2: ${keySet1 == keySet2}');

  // Test hashCode
  print('\n--- Testing hashCode ---');
  print('keySet2.hashCode: ${keySet2.hashCode}');
  print('keySetCopy.hashCode: ${keySetCopy.hashCode}');

  print('\n' + '=' * 50);
  print('LogicalKeySet test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'LogicalKeySet Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Single key count: ${keySet1.keys.length}'),
      Text('Ctrl+C count: ${keySet2.keys.length}'),
      Text('Is ShortcutActivator: ${keySet2 is ShortcutActivator}'),
    ],
  );
}
