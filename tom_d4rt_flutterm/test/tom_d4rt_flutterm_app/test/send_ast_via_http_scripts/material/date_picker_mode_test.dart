// D4rt test script: Tests DatePickerMode from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DatePickerMode test executing');

  // Enumerate all DatePickerMode values
  print('DatePickerMode values:');
  for (final value in DatePickerMode.values) {
    print('  ${value.name}: $value');
  }
  print('DatePickerMode has ${ DatePickerMode.values.length} values');

  final first = DatePickerMode.values.first;
  final last = DatePickerMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DatePickerMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DatePickerMode Tests'),
      Text('Values: ${ DatePickerMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
