// ignore_for_file: avoid_print
// D4rt test script: Tests FloatingLabelBehavior from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FloatingLabelBehavior test executing');

  // Enumerate all FloatingLabelBehavior values
  print('FloatingLabelBehavior values:');
  for (final value in FloatingLabelBehavior.values) {
    print('  ${value.name}: $value');
  }
  print('FloatingLabelBehavior has ${ FloatingLabelBehavior.values.length} values');

  final first = FloatingLabelBehavior.values.first;
  final last = FloatingLabelBehavior.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('FloatingLabelBehavior test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FloatingLabelBehavior Tests'),
      Text('Values: ${ FloatingLabelBehavior.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
