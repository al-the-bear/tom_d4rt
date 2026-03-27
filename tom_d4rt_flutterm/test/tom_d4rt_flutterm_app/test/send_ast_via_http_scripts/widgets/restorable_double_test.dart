// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableDouble from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableDouble test executing');
  print('=' * 50);

  // RestorableDouble stores non-null double
  print('RestorableDouble:');
  print('Purpose: Store and restore non-null double values');
  print('Extends: RestorableNum<double>');
  print('');

  // Create with default value
  print('Creating with default value:');
  final prop = RestorableDouble(0.0);
  print('Created: RestorableDouble(0.0)');
  print('runtimeType: ${prop.runtimeType}');
  print('');

  // Mathematical constants
  print('Testing mathematical constants:');
  final pi = RestorableDouble(3.14159265358979);
  print('Pi: 3.14159265358979');

  final e = RestorableDouble(2.71828182845905);
  print('Euler\'s number: 2.71828182845905');

  final phi = RestorableDouble(1.61803398874989);
  print('Golden ratio: 1.61803398874989');
  print('');

  // Precision demonstration
  print('Double precision:');
  final precise = RestorableDouble(0.1 + 0.2);
  print('0.1 + 0.2 = ${0.1 + 0.2}');
  print('Shows floating-point representation');
  print('');

  // Practical values
  print('Practical value ranges:');
  final temp = RestorableDouble(98.6);
  print('Temperature: 98.6 (body temp F)');

  final currency = RestorableDouble(1234.56);
  print('Currency: 1234.56');

  final percent = RestorableDouble(0.75);
  print('Percentage: 0.75 (75%)');
  print('');

  // Inheritance chain
  print('Type hierarchy:');
  print('RestorableDouble');
  print('  extends RestorableNum<double>');
  print('    extends _RestorablePrimitiveValue<double>');
  print('      extends _RestorablePrimitiveValueN<double>');
  print('        extends RestorableValue<double>');
  print('');

  print('is RestorableNum: ${prop is RestorableNum}');
  print('is RestorableProperty: ${prop is RestorableProperty}');

  // Cleanup
  prop.dispose();
  pi.dispose();
  e.dispose();
  phi.dispose();
  precise.dispose();
  temp.dispose();
  currency.dispose();
  percent.dispose();

  print('\n' + '=' * 50);
  print('RestorableDouble test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableDouble Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Non-null double restoration'),
      Text('Extends RestorableNum<double>'),
      Text('Handles precision values'),
    ],
  );
}
