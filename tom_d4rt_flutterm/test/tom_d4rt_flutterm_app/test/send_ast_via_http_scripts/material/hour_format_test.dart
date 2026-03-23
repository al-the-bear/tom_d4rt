// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests HourFormat from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('HourFormat test executing');

  // Enumerate all HourFormat values
  print('HourFormat values:');
  for (final value in HourFormat.values) {
    print('  ${value.name}: $value');
  }
  print('HourFormat has ${ HourFormat.values.length} values');

  final first = HourFormat.values.first;
  final last = HourFormat.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('HourFormat test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('HourFormat Tests'),
      Text('Values: ${ HourFormat.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
