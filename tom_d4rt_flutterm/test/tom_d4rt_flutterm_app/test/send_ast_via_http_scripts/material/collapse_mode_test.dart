// ignore_for_file: avoid_print
// D4rt test script: Tests CollapseMode from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CollapseMode test executing');

  // Enumerate all CollapseMode values
  print('CollapseMode values:');
  for (final value in CollapseMode.values) {
    print('  ${value.name}: $value');
  }
  print('CollapseMode has ${ CollapseMode.values.length} values');

  final first = CollapseMode.values.first;
  final last = CollapseMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('CollapseMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CollapseMode Tests'),
      Text('Values: ${ CollapseMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
