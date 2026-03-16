// D4rt test script: Tests CheckedState from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CheckedState test executing');

  // Enumerate all CheckedState values
  print('CheckedState values:');
  for (final value in CheckedState.values) {
    print('  ${value.name}: $value');
  }
  print('CheckedState has ${ CheckedState.values.length} values');

  final first = CheckedState.values.first;
  final last = CheckedState.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('CheckedState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CheckedState Tests'),
      Text('Values: ${ CheckedState.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
