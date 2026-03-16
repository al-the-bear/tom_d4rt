// D4rt test script: Tests TimeOfDayFormat from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TimeOfDayFormat test executing');

  // Enumerate all TimeOfDayFormat values
  print('TimeOfDayFormat values:');
  for (final value in TimeOfDayFormat.values) {
    print('  ${value.name}: $value');
  }
  print('TimeOfDayFormat has ${ TimeOfDayFormat.values.length} values');

  final first = TimeOfDayFormat.values.first;
  final last = TimeOfDayFormat.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TimeOfDayFormat test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TimeOfDayFormat Tests'),
      Text('Values: ${ TimeOfDayFormat.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
