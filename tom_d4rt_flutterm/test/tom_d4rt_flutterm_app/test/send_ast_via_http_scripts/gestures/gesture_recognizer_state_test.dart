// D4rt test script: Tests GestureRecognizerState from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GestureRecognizerState test executing');

  // Enumerate all GestureRecognizerState values
  print('GestureRecognizerState values:');
  for (final value in GestureRecognizerState.values) {
    print('  ${value.name}: $value');
  }
  print('GestureRecognizerState has ${ GestureRecognizerState.values.length} values');

  final first = GestureRecognizerState.values.first;
  final last = GestureRecognizerState.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('GestureRecognizerState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('GestureRecognizerState Tests'),
      Text('Values: ${ GestureRecognizerState.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
