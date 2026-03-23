// ignore_for_file: avoid_print
// D4rt test script: Tests ShowValueIndicator from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ShowValueIndicator test executing');

  // Enumerate all ShowValueIndicator values
  print('ShowValueIndicator values:');
  for (final value in ShowValueIndicator.values) {
    print('  ${value.name}: $value');
  }
  print('ShowValueIndicator has ${ ShowValueIndicator.values.length} values');

  final first = ShowValueIndicator.values.first;
  final last = ShowValueIndicator.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ShowValueIndicator test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ShowValueIndicator Tests'),
      Text('Values: ${ ShowValueIndicator.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
