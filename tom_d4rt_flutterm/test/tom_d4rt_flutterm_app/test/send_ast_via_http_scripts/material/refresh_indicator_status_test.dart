// D4rt test script: Tests RefreshIndicatorStatus from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RefreshIndicatorStatus test executing');

  // Enumerate all RefreshIndicatorStatus values
  print('RefreshIndicatorStatus values:');
  for (final value in RefreshIndicatorStatus.values) {
    print('  ${value.name}: $value');
  }
  print('RefreshIndicatorStatus has ${ RefreshIndicatorStatus.values.length} values');

  final first = RefreshIndicatorStatus.values.first;
  final last = RefreshIndicatorStatus.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('RefreshIndicatorStatus test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RefreshIndicatorStatus Tests'),
      Text('Values: ${ RefreshIndicatorStatus.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
