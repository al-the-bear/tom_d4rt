// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableDateTimeN from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableDateTimeN test executing');
  print('=' * 50);

  // RestorableDateTimeN stores nullable DateTime
  print('RestorableDateTimeN:');
  print('Purpose: Store and restore nullable DateTime values');
  print('Extends: RestorableValue<DateTime?>');
  print('');

  // Create with null default
  print('Creating with null default:');
  final nullDefault = RestorableDateTimeN(null);
  print('Created: RestorableDateTimeN(null)');
  print('runtimeType: ${nullDefault.runtimeType}');
  print('');

  // Create with DateTime default
  final now = DateTime.now();
  print('Creating with DateTime default:');
  final dateDefault = RestorableDateTimeN(now);
  print('Created: RestorableDateTimeN(DateTime.now())');
  print('Default value: $now');
  print('');

  // Specific date testing
  final epoch = DateTime.fromMillisecondsSinceEpoch(0);
  final y2k = DateTime(2000, 1, 1);
  final future = DateTime(2100, 12, 31, 23, 59, 59);

  print('Testing with various dates:');
  print('Epoch (1970-01-01): $epoch');
  print('Milliseconds: ${epoch.millisecondsSinceEpoch}');
  print('');

  print('Y2K (2000-01-01): $y2k');
  print('Milliseconds: ${y2k.millisecondsSinceEpoch}');
  print('');

  print('Future (2100-12-31): $future');
  print('Milliseconds: ${future.millisecondsSinceEpoch}');
  print('');

  // Restoration serialization
  print('Serialization (toPrimitives/fromPrimitives):');
  print('  Stores: value?.millisecondsSinceEpoch');
  print('  Restores: DateTime.fromMillisecondsSinceEpoch(data)');
  print('  Null case: returns null if data is null');
  print('');

  // Type info
  print('Type information:');
  print('is RestorableProperty: ${nullDefault is RestorableProperty}');
  print('is RestorableValue: ${nullDefault is RestorableValue}');
  print('');

  // Cleanup
  nullDefault.dispose();
  dateDefault.dispose();
  print('Properties disposed');

  print('\n' + '=' * 50);
  print('RestorableDateTimeN test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableDateTimeN Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Nullable DateTime restoration'),
      Text('Serializes via millisecondsSinceEpoch'),
      Text('Can default to null'),
    ],
  );
}
