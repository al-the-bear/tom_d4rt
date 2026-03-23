// ignore_for_file: avoid_print
// D4rt test script: Tests DayPeriod from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DayPeriod test executing');

  // Enumerate all DayPeriod values
  print('DayPeriod values:');
  for (final value in DayPeriod.values) {
    print('  ${value.name}: $value');
  }
  print('DayPeriod has ${ DayPeriod.values.length} values');

  final first = DayPeriod.values.first;
  final last = DayPeriod.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DayPeriod test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DayPeriod Tests'),
      Text('Values: ${ DayPeriod.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
