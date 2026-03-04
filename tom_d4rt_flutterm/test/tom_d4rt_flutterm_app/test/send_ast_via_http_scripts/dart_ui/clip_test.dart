// D4rt test script: Tests Clip from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Clip test executing');

  // Enumerate all Clip values
  print('Clip values:');
  for (final value in Clip.values) {
    print('  ${value.name}: $value');
  }
  print('Clip has ${ Clip.values.length} values');

  final first = Clip.values.first;
  final last = Clip.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('Clip test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Clip Tests'),
      Text('Values: ${ Clip.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
