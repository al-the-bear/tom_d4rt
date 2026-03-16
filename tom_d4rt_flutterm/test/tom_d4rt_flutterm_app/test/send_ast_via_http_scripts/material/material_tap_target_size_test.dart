// D4rt test script: Tests MaterialTapTargetSize from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialTapTargetSize test executing');

  // Enumerate all MaterialTapTargetSize values
  print('MaterialTapTargetSize values:');
  for (final value in MaterialTapTargetSize.values) {
    print('  ${value.name}: $value');
  }
  print('MaterialTapTargetSize has ${ MaterialTapTargetSize.values.length} values');

  final first = MaterialTapTargetSize.values.first;
  final last = MaterialTapTargetSize.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('MaterialTapTargetSize test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MaterialTapTargetSize Tests'),
      Text('Values: ${ MaterialTapTargetSize.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
