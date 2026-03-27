// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableDateTime from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableDateTime test executing');
  print('=' * 50);

  // RestorableDateTime stores non-null DateTime
  print('RestorableDateTime:');
  print('Purpose: Store and restore non-null DateTime values');
  print('Extends: RestorableValue<DateTime>');
  print('');

  // Create with current time
  final now = DateTime.now();
  print('Creating with DateTime.now():');
  final prop = RestorableDateTime(now);
  print('Created: RestorableDateTime(now)');
  print('runtimeType: ${prop.runtimeType}');
  print('Default: $now');
  print('');

  // Various date scenarios
  print('Testing date storage scenarios:');

  final epoch = DateTime.fromMillisecondsSinceEpoch(0);
  final epochProp = RestorableDateTime(epoch);
  print('Unix epoch: $epoch');
  print('');

  final specific = DateTime(2024, 6, 15, 10, 30, 0);
  final specificProp = RestorableDateTime(specific);
  print('Specific date: $specific');
  print('Year: ${specific.year}, Month: ${specific.month}, Day: ${specific.day}');
  print('Hour: ${specific.hour}, Minute: ${specific.minute}');
  print('');

  // UTC handling
  final utc = DateTime.utc(2024, 1, 1);
  final localEquiv = utc.toLocal();
  print('UTC date: $utc (isUtc: ${utc.isUtc})');
  print('Local equivalent: $localEquiv');
  print('');

  // Serialization details
  print('Serialization internals:');
  print('toPrimitives(): value.millisecondsSinceEpoch');
  print('fromPrimitives(data): DateTime.fromMillisecondsSinceEpoch(data)');
  print('');

  // Type hierarchy
  print('Type hierarchy:');
  print('is RestorableProperty: ${prop is RestorableProperty}');
  print('is RestorableValue: ${prop is RestorableValue}');
  print('is ChangeNotifier: ${prop is ChangeNotifier}');
  print('');

  // Typical use case
  print('Typical use case:');
  print('  - Store selected date from date picker');
  print('  - Restore date across app restart');
  print('  - Persist timestamp for user action');

  // Cleanup
  prop.dispose();
  epochProp.dispose();
  specificProp.dispose();

  print('\n' + '=' * 50);
  print('RestorableDateTime test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableDateTime Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Non-null DateTime restoration'),
      Text('Uses millisecondsSinceEpoch'),
      Text('Handles UTC and local time'),
    ],
  );
}
