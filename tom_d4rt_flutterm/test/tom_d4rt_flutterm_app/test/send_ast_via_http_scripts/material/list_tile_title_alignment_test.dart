// D4rt test script: Tests ListTileTitleAlignment from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ListTileTitleAlignment test executing');

  // Enumerate all ListTileTitleAlignment values
  print('ListTileTitleAlignment values:');
  for (final value in ListTileTitleAlignment.values) {
    print('  ${value.name}: $value');
  }
  print('ListTileTitleAlignment has ${ ListTileTitleAlignment.values.length} values');

  final first = ListTileTitleAlignment.values.first;
  final last = ListTileTitleAlignment.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ListTileTitleAlignment test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ListTileTitleAlignment Tests'),
      Text('Values: ${ ListTileTitleAlignment.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
