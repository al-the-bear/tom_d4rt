// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableNumN from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableNumN test executing');
  print('=' * 50);

  // RestorableNumN stores nullable num
  print('RestorableNumN<T extends num?>:');
  print('Purpose: Store and restore nullable numeric values');
  print('Extends: _RestorablePrimitiveValueN<T>');
  print('');

  // Create with null default
  print('Creating with null default:');
  final nullProp = RestorableNumN<num?>(null);
  print('Created: RestorableNumN<num?>(null)');
  print('runtimeType: ${nullProp.runtimeType}');
  print('');

  // Create with num default
  print('Creating with num default:');
  final intProp = RestorableNumN<num?>(42);
  print('Created with int: RestorableNumN<num?>(42)');

  final doubleProp = RestorableNumN<num?>(3.14);
  print('Created with double: RestorableNumN<num?>(3.14)');
  print('');

  // Type flexibility
  print('Type flexibility (num can be int or double):');
  print('  Can store: int values');
  print('  Can store: double values');
  print('  Nullable: can be null');
  print('');

  // Subclasses
  print('Specialized subclasses:');
  print('  RestorableDoubleN - nullable double');
  print('  RestorableIntN - nullable int');
  print('');

  // When to use
  print('When to use RestorableNumN directly:');
  print('  - Need to store both int and double');
  print('  - Generic numeric handling');
  print('  - Usually prefer specialized subclass');
  print('');

  // Serialization
  print('Serialization:');
  print('  Stores raw num value or null');
  print('  Type preserved during serialize/deserialize');
  print('');

  // Type hierarchy
  print('Type hierarchy:');
  print('RestorableNumN<T extends num?>');
  print('  extends _RestorablePrimitiveValueN<T>');
  print('    extends RestorableValue<T>');
  print('');

  print('Type checks:');
  print('is RestorableProperty: ${nullProp is RestorableProperty}');
  print('is RestorableValue: ${nullProp is RestorableValue}');

  // Cleanup
  nullProp.dispose();
  intProp.dispose();
  doubleProp.dispose();

  print('\n' + '=' * 50);
  print('RestorableNumN test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableNumN Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Generic nullable numeric restoration'),
      Text('Parent of RestorableIntN, RestorableDoubleN'),
      Text('Accepts both int and double'),
    ],
  );
}
