// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TimePickerEntryMode from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TimePickerEntryMode test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nTimePickerEntryMode values:');
  for (final value in TimePickerEntryMode.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('TimePickerEntryMode has ${TimePickerEntryMode.values.length} values');

  // First and last
  final first = TimePickerEntryMode.values.first;
  final last = TimePickerEntryMode.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('dial: ${TimePickerEntryMode.dial.name} (index ${TimePickerEntryMode.dial.index})');
  print('  Shows a clock dial for time selection');
  print('  User rotates hands to pick hour and minute');
  print('input: ${TimePickerEntryMode.input.name} (index ${TimePickerEntryMode.input.index})');
  print('  Shows text input fields for hour and minute');
  print('  User types the time directly via keyboard');
  print('dialOnly: ${TimePickerEntryMode.dialOnly.name} (index ${TimePickerEntryMode.dialOnly.index})');
  print('  Only shows the clock dial, no toggle to input');
  print('  Prevents user from switching to text entry');
  print('inputOnly: ${TimePickerEntryMode.inputOnly.name} (index ${TimePickerEntryMode.inputOnly.index})');
  print('  Only shows text input, no toggle to dial');
  print('  Prevents user from switching to clock dial');

  // Toggling capability
  print('\nToggle capability:');
  for (final mode in TimePickerEntryMode.values) {
    final canToggle = mode == TimePickerEntryMode.dial ||
        mode == TimePickerEntryMode.input;
    print('  ${mode.name}: canToggle=$canToggle');
  }

  // Initial mode vs locked mode
  print('\nMode categories:');
  print('  Initial modes (user can switch): dial, input');
  print('  Locked modes (user cannot switch): dialOnly, inputOnly');

  // Equality tests
  print('\nEquality tests:');
  print('dial == dial: ${TimePickerEntryMode.dial == TimePickerEntryMode.dial}');
  print('dial == input: ${TimePickerEntryMode.dial == TimePickerEntryMode.input}');
  print('identical: ${identical(TimePickerEntryMode.dial, TimePickerEntryMode.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is TimePickerEntryMode: ${first is TimePickerEntryMode}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in TimePickerEntryMode.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // showTimePicker usage
  print('\nshowTimePicker integration:');
  print('  initialEntryMode: TimePickerEntryMode.dial (default)');
  print('  initialEntryMode: TimePickerEntryMode.input');
  print('  initialEntryMode: TimePickerEntryMode.dialOnly');
  print('  initialEntryMode: TimePickerEntryMode.inputOnly');

  // Accessibility considerations
  print('\nAccessibility:');
  print('  input/inputOnly: better for screen readers');
  print('  dial/dialOnly: more visual, harder for assistive tech');
  print('  Consider inputOnly for accessibility-first apps');

  // Indexed iteration
  print('\nIndexed iteration:');
  for (var i = 0; i < TimePickerEntryMode.values.length; i++) {
    final v = TimePickerEntryMode.values[i];
    print('  [$i] ${v.name} (index=${v.index})');
  }

  print('\n' + '=' * 50);
  print('TimePickerEntryMode test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TimePickerEntryMode Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${TimePickerEntryMode.values.length}'),
      for (final v in TimePickerEntryMode.values)
        Text('  ${v.name} (${v.index})'),
      Text('TimePicker: all entry modes supported'),
    ],
  );
}
