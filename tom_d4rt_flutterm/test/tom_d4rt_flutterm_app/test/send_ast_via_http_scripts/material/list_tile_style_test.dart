// D4rt test script: Tests ListTileStyle from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ListTileStyle test executing');

  // Enumerate all ListTileStyle values
  print('ListTileStyle values:');
  for (final value in ListTileStyle.values) {
    print('  ${value.name}: $value');
  }
  print('ListTileStyle has ${ ListTileStyle.values.length} values');

  final first = ListTileStyle.values.first;
  final last = ListTileStyle.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ListTileStyle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ListTileStyle Tests'),
      Text('Values: ${ ListTileStyle.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
