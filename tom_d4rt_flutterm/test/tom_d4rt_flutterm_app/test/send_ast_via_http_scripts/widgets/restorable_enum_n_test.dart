// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableEnumN from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableEnumN test executing');
  print('=' * 50);

  // RestorableEnumN stores nullable enum values
  print('RestorableEnumN<T extends Enum>:');
  print('Purpose: Store and restore nullable enum values');
  print('Extends: RestorableValue<T?>');
  print('');

  // Create with null default
  print('Creating with null default:');
  final nullAxis = RestorableEnumN<AxisDirection>(
    null,
    values: AxisDirection.values,
  );
  print('Created: RestorableEnumN<AxisDirection>(null, values: ...)');
  print('runtimeType: ${nullAxis.runtimeType}');
  print('');

  // Create with enum default
  print('Creating with enum default:');
  final axisUp = RestorableEnumN<AxisDirection>(
    AxisDirection.up,
    values: AxisDirection.values,
  );
  print('Created: RestorableEnumN<AxisDirection>(up, values: ...)');
  print('');

  // Test with various enums
  print('Testing with AxisDirection enum:');
  for (final value in AxisDirection.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('');

  // Test with Axis enum
  print('Testing with Axis enum:');
  final axisH = RestorableEnumN<Axis>(
    Axis.horizontal,
    values: Axis.values,
  );
  for (final value in Axis.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('');

  // Serialization mechanism
  print('Serialization (via name):');
  print('toPrimitives(): value?.name');
  print('fromPrimitives(data): finds enum by name');
  print('Null case: returns null');
  print('');

  // Values set requirement
  print('Constructor requirement:');
  print('  - values: Iterable<T> required');
  print('  - Used for restoration lookup');
  print('  - Default must be null or in values set');
  print('');

  // Type info
  print('Type information:');
  print('is RestorableProperty: ${nullAxis is RestorableProperty}');
  print('is RestorableValue: ${nullAxis is RestorableValue}');

  // Cleanup
  nullAxis.dispose();
  axisUp.dispose();
  axisH.dispose();

  print('\n' + '=' * 50);
  print('RestorableEnumN test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableEnumN Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Nullable enum restoration'),
      Text('Serializes via enum name'),
      Text('Requires values parameter'),
    ],
  );
}
