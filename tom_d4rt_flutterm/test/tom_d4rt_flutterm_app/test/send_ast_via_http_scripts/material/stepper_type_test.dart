// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests StepperType from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StepperType test executing');

  // Enumerate all StepperType values
  print('StepperType values:');
  for (final value in StepperType.values) {
    print('  ${value.name}: $value');
  }
  print('StepperType has ${ StepperType.values.length} values');

  // Test first and last
  final first = StepperType.values.first;
  final last = StepperType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('StepperType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StepperType Tests'),
      Text('Values: ${ StepperType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
