// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ObjectKey from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class TestObject {
  final int id;
  TestObject(this.id);
}

dynamic build(BuildContext context) {
  print('ObjectKey test executing');
  print('=' * 50);

  // === Test ObjectKey class ===
  print('\nObjectKey identifies widget by object identity');

  // Create ObjectKey instances
  print('\n--- Testing creation ---');
  final obj1 = TestObject(1);
  final obj2 = TestObject(2);
  final key1 = ObjectKey(obj1);
  final key2 = ObjectKey(obj2);
  print('Created ObjectKey(obj1)');
  print('Created ObjectKey(obj2)');

  // Test value property
  print('\n--- Testing value property ---');
  print('key1.value: ${key1.value}');
  print('key2.value: ${key2.value}');
  print('key1.value == obj1: ${key1.value == obj1}');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('key1 is LocalKey: ${key1 is LocalKey}');
  print('key1 is Key: ${key1 is Key}');

  // Test equality (identity based)
  print('\n--- Testing equality ---');
  final keyA = ObjectKey(obj1);
  final keyB = ObjectKey(obj1);
  final keyC = ObjectKey(obj2);
  print('Same object: keyA == keyB: ${keyA == keyB}');
  print('Diff object: keyA == keyC: ${keyA == keyC}');

  // Test hashCode
  print('\n--- Testing hashCode ---');
  print('key1.hashCode: ${key1.hashCode}');
  print('keyA.hashCode: ${keyA.hashCode}');
  print('Same object = same hashCode');

  // Test with null value
  print('\n--- Testing with null ---');
  final nullKey = ObjectKey(null);
  print('ObjectKey(null).value: ${nullKey.value}');

  // Compare with ValueKey
  print('\n--- Comparing with ValueKey ---');
  final valueKey = ValueKey(obj1);
  print('ObjectKey: uses identical() for equality');
  print('ValueKey: uses == operator for equality');
  print('key1 == valueKey: ${key1 == valueKey}');

  // Test with Text widget
  print('\n--- Testing with widget ---');
  final text = Text('Hello', key: ObjectKey(obj1));
  print('Created Text with ObjectKey');
  print('text.key: ${text.key}');

  // Test toString
  print('\n--- Testing toString ---');
  print('key1.toString(): ${key1.toString()}');

  print('\n' + '=' * 50);
  print('ObjectKey test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ObjectKey Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('value is TestObject: ${key1.value is TestObject}'),
      Text('Same object keys equal: ${keyA == keyB}'),
      Text('Is LocalKey: ${key1 is LocalKey}'),
      text,
    ],
  );
}
