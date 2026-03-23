// ignore_for_file: avoid_print
// D4rt test script: Tests Thumb from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Thumb test executing');

  // Enumerate all Thumb values
  print('Thumb values:');
  for (final value in Thumb.values) {
    print('  ${value.name}: $value');
  }
  print('Thumb has ${ Thumb.values.length} values');

  final first = Thumb.values.first;
  final last = Thumb.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('Thumb test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Thumb Tests'),
      Text('Values: ${ Thumb.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
