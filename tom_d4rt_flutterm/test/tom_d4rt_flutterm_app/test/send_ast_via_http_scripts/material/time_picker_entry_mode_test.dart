// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TimePickerEntryMode from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TimePickerEntryMode test executing');
  print('=' * 50);

  // TimePickerEntryMode enum overview
  print('TimePickerEntryMode enum overview:');
  print('  - Initial input mode for time picker');
  print('  - Controls digit vs dial entry');
  print('  - 4 values: dial, input, dialOnly, inputOnly');

  // Enumerate all values
  print('\nTimePickerEntryMode values:');
  for (final value in TimePickerEntryMode.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('TimePickerEntryMode has ${TimePickerEntryMode.values.length} values');

  // Test dial mode
  print('\nTest TimePickerEntryMode.dial:');
  final dial = TimePickerEntryMode.dial;
  print('  Name: ${dial.name}');
  print('  Index: ${dial.index}');
  print('  Allows switching to input: Yes');

  // Test input mode
  print('\nTest TimePickerEntryMode.input:');
  final input = TimePickerEntryMode.input;
  print('  Name: ${input.name}');
  print('  Index: ${input.index}');
  print('  Allows switching to dial: Yes');

  // Test dialOnly mode
  print('\nTest TimePickerEntryMode.dialOnly:');
  final dialOnly = TimePickerEntryMode.dialOnly;
  print('  Name: ${dialOnly.name}');
  print('  Index: ${dialOnly.index}');
  print('  Locked to dial mode: Yes');

  // Test inputOnly mode
  print('\nTest TimePickerEntryMode.inputOnly:');
  final inputOnly = TimePickerEntryMode.inputOnly;
  print('  Name: ${inputOnly.name}');
  print('  Index: ${inputOnly.index}');
  print('  Locked to input mode: Yes');

  // First and last
  print('\nFirst and last:');
  print('  First: ${TimePickerEntryMode.values.first}');
  print('  Last: ${TimePickerEntryMode.values.last}');

  // Usage context
  print('\nUsage context:');
  print('  showTimePicker initialEntryMode parameter');
  print('  TimePicker.initialEntryMode');

  // Switch pattern
  print('\nSwitch pattern:');
  final mode = TimePickerEntryMode.dial;
  switch (mode) {
    case TimePickerEntryMode.dial:
      print('  Clock dial mode');
      break;
    case TimePickerEntryMode.input:
      print('  Text input mode');
      break;
    case TimePickerEntryMode.dialOnly:
      print('  Dial only mode');
      break;
    case TimePickerEntryMode.inputOnly:
      print('  Input only mode');
      break;
  }

  // Mode categories
  print('\nMode categories:');
  print('  Switchable: dial, input');
  print('  Locked: dialOnly, inputOnly');

  print('\n' + '=' * 50);
  print('TimePickerEntryMode test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TimePickerEntryMode Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: dial, input, dialOnly, inputOnly'),
      Text('Purpose: Time picker input mode'),
    ],
  );
}
