// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableNum from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableNum test executing');
  print('=' * 50);

  // RestorableNum stores non-null num
  print('RestorableNum<T extends num>:');
  print('Purpose: Store and restore non-null numeric values');
  print('Extends: _RestorablePrimitiveValue<T>');
  print('');

  // Create with int
  print('Creating with int:');
  final intProp = RestorableNum<int>(100);
  print('Created: RestorableNum<int>(100)');
  print('runtimeType: ${intProp.runtimeType}');
  print('');

  // Create with double
  print('Creating with double:');
  final doubleProp = RestorableNum<double>(2.718);
  print('Created: RestorableNum<double>(2.718)');
  print('');

  // Generic num
  print('Creating with generic num:');
  final numProp = RestorableNum<num>(42);
  print('Created: RestorableNum<num>(42)');
  print('');

  // Specialized subclasses
  print('Specialized subclasses (preferred):');
  final restorableDouble = RestorableDouble(1.5);
  print('RestorableDouble(1.5) - for double values');

  final restorableInt = RestorableInt(10);
  print('RestorableInt(10) - for int values');
  print('');

  // Type hierarchy
  print('Type hierarchy:');
  print('RestorableNum<T extends num>');
  print('  extends _RestorablePrimitiveValue<T>');
  print('    extends _RestorablePrimitiveValueN<T>');
  print('      extends RestorableValue<T>');
  print('');

  // Use case guidance
  print('Use case guidance:');
  print('  Prefer RestorableInt for integers');
  print('  Prefer RestorableDouble for decimals');
  print('  Use RestorableNum when type varies');
  print('');

  // Type checks
  print('Type checks:');
  print('is RestorableProperty: ${intProp is RestorableProperty}');
  print('RestorableDouble is RestorableNum: ${restorableDouble is RestorableNum}');
  print('RestorableInt is RestorableNum: ${restorableInt is RestorableNum}');

  // Cleanup
  intProp.dispose();
  doubleProp.dispose();
  numProp.dispose();
  restorableDouble.dispose();
  restorableInt.dispose();

  print('\n' + '=' * 50);
  print('RestorableNum test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableNum Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Generic non-null numeric restoration'),
      Text('Parent of RestorableInt, RestorableDouble'),
      Text('Type parameter constrains stored type'),
    ],
  );
}
