// D4rt test script: Tests TimePickerEntryMode from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TimePickerEntryMode test executing');

  // Enumerate all TimePickerEntryMode values
  print('TimePickerEntryMode values:');
  for (final value in TimePickerEntryMode.values) {
    print('  ${value.name}: $value');
  }
  print('TimePickerEntryMode has ${ TimePickerEntryMode.values.length} values');

  final first = TimePickerEntryMode.values.first;
  final last = TimePickerEntryMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TimePickerEntryMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TimePickerEntryMode Tests'),
      Text('Values: ${ TimePickerEntryMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
