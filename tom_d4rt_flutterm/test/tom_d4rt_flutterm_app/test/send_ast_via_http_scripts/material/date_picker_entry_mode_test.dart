// ignore_for_file: avoid_print
// D4rt test script: Tests DatePickerEntryMode from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DatePickerEntryMode test executing');

  // Enumerate all DatePickerEntryMode values
  print('DatePickerEntryMode values:');
  for (final value in DatePickerEntryMode.values) {
    print('  ${value.name}: $value');
  }
  print('DatePickerEntryMode has ${ DatePickerEntryMode.values.length} values');

  final first = DatePickerEntryMode.values.first;
  final last = DatePickerEntryMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DatePickerEntryMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DatePickerEntryMode Tests'),
      Text('Values: ${ DatePickerEntryMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
