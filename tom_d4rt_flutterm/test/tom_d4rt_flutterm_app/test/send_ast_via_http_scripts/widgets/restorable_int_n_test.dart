// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableIntN from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableIntN test executing');
  print('=' * 50);

  // RestorableIntN stores nullable int
  print('RestorableIntN:');
  print('Purpose: Store and restore nullable int values');
  print('Extends: RestorableNumN<int?>');
  print('');

  // Create with null default
  print('Creating with null default:');
  final nullProp = RestorableIntN(null);
  print('Created: RestorableIntN(null)');
  print('runtimeType: ${nullProp.runtimeType}');
  print('');

  // Create with int default
  print('Creating with int default:');
  final valueProp = RestorableIntN(42);
  print('Created: RestorableIntN(42)');
  print('');

  // Test various int values
  print('Testing various int values:');
  final zero = RestorableIntN(0);
  print('Zero: 0');

  final negative = RestorableIntN(-100);
  print('Negative: -100');

  final large = RestorableIntN(9223372036854775807);
  print('Max int64: 9223372036854775807');

  final minVal = RestorableIntN(-9223372036854775808);
  print('Min int64: -9223372036854775808');
  print('');

  // Practical examples
  print('Practical use cases:');
  print('  - Optional page index');
  print('  - Nullable count value');
  print('  - User-selected quantity');
  print('');

  // Type hierarchy
  print('Type hierarchy:');
  print('RestorableIntN');
  print('  extends RestorableNumN<int?>');
  print('    extends _RestorablePrimitiveValueN<int?>');
  print('');

  print('Type checks:');
  print('is RestorableNumN: ${nullProp is RestorableNumN}');
  print('is RestorableProperty: ${nullProp is RestorableProperty}');

  // Cleanup
  nullProp.dispose();
  valueProp.dispose();
  zero.dispose();
  negative.dispose();
  large.dispose();
  minVal.dispose();

  print('\n' + '=' * 50);
  print('RestorableIntN test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableIntN Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Nullable int restoration'),
      Text('Extends RestorableNumN<int?>'),
      Text('Full int64 range support'),
    ],
  );
}
