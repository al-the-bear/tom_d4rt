// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableDoubleN from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableDoubleN test executing');
  print('=' * 50);

  // RestorableDoubleN stores nullable double
  print('RestorableDoubleN:');
  print('Purpose: Store and restore nullable double values');
  print('Extends: RestorableNumN<double?>');
  print('');

  // Create with null default
  print('Creating with null default:');
  final nullProp = RestorableDoubleN(null);
  print('Created: RestorableDoubleN(null)');
  print('runtimeType: ${nullProp.runtimeType}');
  print('');

  // Create with double default
  print('Creating with double default:');
  final valueProp = RestorableDoubleN(3.14159);
  print('Created: RestorableDoubleN(3.14159)');
  print('');

  // Test various double values
  print('Testing various double values:');
  final zero = RestorableDoubleN(0.0);
  print('Zero: 0.0');

  final negative = RestorableDoubleN(-273.15);
  print('Negative: -273.15');

  final large = RestorableDoubleN(1.7976931348623157e+308);
  print('Large: 1.7976931348623157e+308');

  final small = RestorableDoubleN(2.2250738585072014e-308);
  print('Small: 2.2250738585072014e-308');
  print('');

  // Special values
  print('Special double values:');
  final inf = RestorableDoubleN(double.infinity);
  print('Infinity: ${double.infinity}');

  final negInf = RestorableDoubleN(double.negativeInfinity);
  print('Negative infinity: ${double.negativeInfinity}');

  final nan = RestorableDoubleN(double.nan);
  print('NaN: ${double.nan}');
  print('');

  // Common use cases
  print('Common use cases:');
  print('  - Optional slider value');
  print('  - Nullable progress/percentage');
  print('  - User-entered numeric input');
  print('');

  // Type info
  print('Type information:');
  print('is RestorableProperty: ${nullProp is RestorableProperty}');
  print('is RestorableNumN: ${nullProp is RestorableNumN}');
  print('');

  // Cleanup
  nullProp.dispose();
  valueProp.dispose();
  zero.dispose();
  negative.dispose();
  large.dispose();
  small.dispose();
  inf.dispose();
  negInf.dispose();
  nan.dispose();

  print('\n' + '=' * 50);
  print('RestorableDoubleN test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableDoubleN Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Nullable double restoration'),
      Text('Supports special values (Inf, NaN)'),
      Text('Extends RestorableNumN'),
    ],
  );
}
