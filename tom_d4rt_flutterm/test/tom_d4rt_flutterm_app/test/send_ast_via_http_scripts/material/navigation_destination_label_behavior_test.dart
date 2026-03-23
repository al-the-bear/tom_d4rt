// ignore_for_file: avoid_print
// D4rt test script: Tests NavigationDestinationLabelBehavior from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigationDestinationLabelBehavior test executing');

  // Enumerate all NavigationDestinationLabelBehavior values
  print('NavigationDestinationLabelBehavior values:');
  for (final value in NavigationDestinationLabelBehavior.values) {
    print('  ${value.name}: $value');
  }
  print('NavigationDestinationLabelBehavior has ${ NavigationDestinationLabelBehavior.values.length} values');

  final first = NavigationDestinationLabelBehavior.values.first;
  final last = NavigationDestinationLabelBehavior.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('NavigationDestinationLabelBehavior test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NavigationDestinationLabelBehavior Tests'),
      Text('Values: ${ NavigationDestinationLabelBehavior.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
