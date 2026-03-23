// ignore_for_file: avoid_print
// D4rt test script: Tests ListTileControlAffinity from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ListTileControlAffinity test executing');

  // Enumerate all ListTileControlAffinity values
  print('ListTileControlAffinity values:');
  for (final value in ListTileControlAffinity.values) {
    print('  ${value.name}: $value');
  }
  print('ListTileControlAffinity has ${ ListTileControlAffinity.values.length} values');

  final first = ListTileControlAffinity.values.first;
  final last = ListTileControlAffinity.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ListTileControlAffinity test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ListTileControlAffinity Tests'),
      Text('Values: ${ ListTileControlAffinity.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
