// D4rt test script: Tests Tristate from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Tristate test executing');

  // Enumerate all Tristate values
  print('Tristate values:');
  for (final value in Tristate.values) {
    print('  ${value.name}: $value');
  }
  print('Tristate has ${ Tristate.values.length} values');

  final first = Tristate.values.first;
  final last = Tristate.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('Tristate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Tristate Tests'),
      Text('Values: ${ Tristate.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
