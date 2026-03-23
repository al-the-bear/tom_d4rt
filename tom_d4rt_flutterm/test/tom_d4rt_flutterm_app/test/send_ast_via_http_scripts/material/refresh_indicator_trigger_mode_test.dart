// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RefreshIndicatorTriggerMode from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RefreshIndicatorTriggerMode test executing');

  // Enumerate all RefreshIndicatorTriggerMode values
  print('RefreshIndicatorTriggerMode values:');
  for (final value in RefreshIndicatorTriggerMode.values) {
    print('  ${value.name}: $value');
  }
  print('RefreshIndicatorTriggerMode has ${ RefreshIndicatorTriggerMode.values.length} values');

  final first = RefreshIndicatorTriggerMode.values.first;
  final last = RefreshIndicatorTriggerMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('RefreshIndicatorTriggerMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RefreshIndicatorTriggerMode Tests'),
      Text('Values: ${ RefreshIndicatorTriggerMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
