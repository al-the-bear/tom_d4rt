// D4rt test script: Tests MaterialType from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialType test executing');

  // Enumerate all MaterialType values
  print('MaterialType values:');
  for (final value in MaterialType.values) {
    print('  ${value.name}: $value');
  }
  print('MaterialType has ${ MaterialType.values.length} values');

  // Test first and last
  final first = MaterialType.values.first;
  final last = MaterialType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('MaterialType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MaterialType Tests'),
      Text('Values: ${ MaterialType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
