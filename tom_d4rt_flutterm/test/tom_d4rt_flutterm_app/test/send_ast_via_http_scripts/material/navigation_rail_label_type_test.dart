// D4rt test script: Tests NavigationRailLabelType from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigationRailLabelType test executing');

  // Enumerate all NavigationRailLabelType values
  print('NavigationRailLabelType values:');
  for (final value in NavigationRailLabelType.values) {
    print('  ${value.name}: $value');
  }
  print('NavigationRailLabelType has ${ NavigationRailLabelType.values.length} values');

  final first = NavigationRailLabelType.values.first;
  final last = NavigationRailLabelType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('NavigationRailLabelType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NavigationRailLabelType Tests'),
      Text('Values: ${ NavigationRailLabelType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
