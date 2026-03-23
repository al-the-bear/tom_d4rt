// ignore_for_file: avoid_print
// D4rt test script: Tests ThemeMode from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ThemeMode test executing');

  // Enumerate all ThemeMode values
  print('ThemeMode values:');
  for (final value in ThemeMode.values) {
    print('  ${value.name}: $value');
  }
  print('ThemeMode has ${ ThemeMode.values.length} values');

  final first = ThemeMode.values.first;
  final last = ThemeMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ThemeMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ThemeMode Tests'),
      Text('Values: ${ ThemeMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
