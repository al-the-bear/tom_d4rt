// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests KeySet from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('KeySet test executing');
  print('=' * 50);

  // === Test KeySet class ===
  print('\nKeySet is a set of KeyboardKey used for shortcuts');

  // Create a KeySet with a single key
  print('\n--- Testing single key KeySet ---');
  final singleKeySet = KeySet<LogicalKeyboardKey>(LogicalKeyboardKey.keyA);
  print('Created KeySet with keyA');
  print('keys: \${singleKeySet.keys}');
  print('keys.length: \${singleKeySet.keys.length}');
  print('runtimeType: \${singleKeySet.runtimeType}');

  // Create a KeySet with two keys
  print('\n--- Testing two key KeySet ---');
  final twoKeySet = KeySet<LogicalKeyboardKey>(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.keyC,
  );
  print('Created KeySet with control + keyC');
  print('keys: \${twoKeySet.keys}');
  print('keys.length: \${twoKeySet.keys.length}');

  // Create a KeySet with three keys
  print('\n--- Testing three key KeySet ---');
  final threeKeySet = KeySet<LogicalKeyboardKey>(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.shift,
    LogicalKeyboardKey.keyS,
  );
  print('Created KeySet with control + shift + keyS');
  print('keys: \${threeKeySet.keys}');
  print('keys.length: \${threeKeySet.keys.length}');

  // Create a KeySet with four keys
  print('\n--- Testing four key KeySet ---');
  final fourKeySet = KeySet<LogicalKeyboardKey>(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.shift,
    LogicalKeyboardKey.alt,
    LogicalKeyboardKey.keyF,
  );
  print('Created KeySet with control + shift + alt + keyF');
  print('keys: \${fourKeySet.keys}');
  print('keys.length: \${fourKeySet.keys.length}');

  // Create a KeySet from set
  print('\n--- Testing KeySet.fromSet ---');
  final fromSet = KeySet<LogicalKeyboardKey>.fromSet({
    LogicalKeyboardKey.meta,
    LogicalKeyboardKey.keyV,
  });
  print('Created KeySet.fromSet with meta + keyV');
  print('keys: \${fromSet.keys}');
  print('keys.length: \${fromSet.keys.length}');

  // Test equality
  print('\n--- Testing equality ---');
  final copySet = KeySet<LogicalKeyboardKey>(LogicalKeyboardKey.keyA);
  print('singleKeySet == copySet: \${singleKeySet == copySet}');
  print('singleKeySet == twoKeySet: \${singleKeySet == twoKeySet}');

  // Test hashCode
  print('\n--- Testing hashCode ---');
  print('singleKeySet.hashCode: \${singleKeySet.hashCode}');
  print('twoKeySet.hashCode: \${twoKeySet.hashCode}');
  print('copySet.hashCode: \${copySet.hashCode}');
  print('singleKeySet.hashCode == copySet.hashCode: \${singleKeySet.hashCode == copySet.hashCode}');

  // Test keys getter returns a copy
  print('\n--- Testing keys getter ---');
  final keysCopy = singleKeySet.keys;
  print('Original keys: \${singleKeySet.keys}');
  print('Keys copy: \$keysCopy');
  print('Is a Set: \${keysCopy is Set}');

  print('\n' + '=' * 50);
  print('KeySet test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'KeySet Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Single key count: \${singleKeySet.keys.length}'),
      Text('Two key count: \${twoKeySet.keys.length}'),
      Text('From set count: \${fromSet.keys.length}'),
      Text('Equality works: \${singleKeySet == copySet}'),
    ],
  );
}
