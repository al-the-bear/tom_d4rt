// ignore_for_file: avoid_print
// D4rt test script: Tests StretchMode from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StretchMode test executing');

  // Enumerate all StretchMode values
  print('StretchMode values:');
  for (final value in StretchMode.values) {
    print('  ${value.name}: $value');
  }
  print('StretchMode has ${ StretchMode.values.length} values');

  final first = StretchMode.values.first;
  final last = StretchMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('StretchMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StretchMode Tests'),
      Text('Values: ${ StretchMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
