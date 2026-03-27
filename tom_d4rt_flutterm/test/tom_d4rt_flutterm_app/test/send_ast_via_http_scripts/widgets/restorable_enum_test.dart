// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableEnum from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableEnum test executing');
  print('=' * 50);

  // RestorableEnum stores non-null enum values
  print('RestorableEnum<T extends Enum>:');
  print('Purpose: Store and restore non-null enum values');
  print('Extends: RestorableValue<T>');
  print('');

  // Create with enum default
  print('Creating RestorableEnum:');
  final axisDir = RestorableEnum<AxisDirection>(
    AxisDirection.up,
    values: AxisDirection.values,
  );
  print('Created: RestorableEnum<AxisDirection>(up, values: ...)');
  print('runtimeType: ${axisDir.runtimeType}');
  print('');

  // Enumerate all AxisDirection values
  print('AxisDirection enum:');
  for (final value in AxisDirection.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('AxisDirection has ${AxisDirection.values.length} values');
  print('');

  // Test with Axis enum
  print('Axis enum:');
  final axis = RestorableEnum<Axis>(
    Axis.horizontal,
    values: Axis.values,
  );
  for (final value in Axis.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('');

  // Test with TextDirection
  print('TextDirection enum:');
  final textDir = RestorableEnum<TextDirection>(
    TextDirection.ltr,
    values: TextDirection.values,
  );
  for (final value in TextDirection.values) {
    print('  ${value.name}');
  }
  print('');

  // Serialization
  print('Serialization details:');
  print('toPrimitives(): value.name');
  print('fromPrimitives(data): looks up by name in values');
  print('Falls back to default if name not found');
  print('');

  // Values set property
  print('Values set:');
  print('  - Required constructor parameter');
  print('  - Typically use EnumType.values');
  print('  - Used for name lookup during restore');
  print('');

  // Cleanup
  axisDir.dispose();
  axis.dispose();
  textDir.dispose();

  print('\n' + '=' * 50);
  print('RestorableEnum test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableEnum Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Non-null enum restoration'),
      Text('Serializes via name string'),
      Text('Falls back to default value'),
    ],
  );
}
