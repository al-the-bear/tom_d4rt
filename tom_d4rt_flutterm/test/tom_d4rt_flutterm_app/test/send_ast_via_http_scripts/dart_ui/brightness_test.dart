// D4rt test script: Tests Brightness from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Brightness test executing');

  // Enumerate all Brightness values
  print('Brightness values:');
  for (final value in Brightness.values) {
    print('  ${value.name}: $value');
  }
  print('Brightness has ${ Brightness.values.length} values');

  // Test first and last
  final first = Brightness.values.first;
  final last = Brightness.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('Brightness test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Brightness Tests'),
      Text('Values: ${ Brightness.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
