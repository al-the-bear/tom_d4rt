// ignore_for_file: avoid_print
// D4rt test script: Tests SliderInteraction from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliderInteraction test executing');

  // Enumerate all SliderInteraction values
  print('SliderInteraction values:');
  for (final value in SliderInteraction.values) {
    print('  ${value.name}: $value');
  }
  print('SliderInteraction has ${ SliderInteraction.values.length} values');

  final first = SliderInteraction.values.first;
  final last = SliderInteraction.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SliderInteraction test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliderInteraction Tests'),
      Text('Values: ${ SliderInteraction.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
