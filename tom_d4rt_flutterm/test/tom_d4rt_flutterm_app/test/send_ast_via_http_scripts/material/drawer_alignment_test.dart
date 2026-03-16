// D4rt test script: Tests DrawerAlignment from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DrawerAlignment test executing');

  // Enumerate all DrawerAlignment values
  print('DrawerAlignment values:');
  for (final value in DrawerAlignment.values) {
    print('  ${value.name}: $value');
  }
  print('DrawerAlignment has ${ DrawerAlignment.values.length} values');

  final first = DrawerAlignment.values.first;
  final last = DrawerAlignment.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DrawerAlignment test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DrawerAlignment Tests'),
      Text('Values: ${ DrawerAlignment.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
