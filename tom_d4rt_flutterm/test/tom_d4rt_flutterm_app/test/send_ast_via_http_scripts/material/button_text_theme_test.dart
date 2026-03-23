// ignore_for_file: avoid_print
// D4rt test script: Tests ButtonTextTheme from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ButtonTextTheme test executing');

  // Enumerate all ButtonTextTheme values
  print('ButtonTextTheme values:');
  for (final value in ButtonTextTheme.values) {
    print('  ${value.name}: $value');
  }
  print('ButtonTextTheme has ${ ButtonTextTheme.values.length} values');

  final first = ButtonTextTheme.values.first;
  final last = ButtonTextTheme.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ButtonTextTheme test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ButtonTextTheme Tests'),
      Text('Values: ${ ButtonTextTheme.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
