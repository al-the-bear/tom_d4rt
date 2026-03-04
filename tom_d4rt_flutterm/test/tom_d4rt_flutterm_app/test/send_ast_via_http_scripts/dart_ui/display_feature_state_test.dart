// D4rt test script: Tests DisplayFeatureState from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DisplayFeatureState test executing');

  // Enumerate all DisplayFeatureState values
  print('DisplayFeatureState values:');
  for (final value in DisplayFeatureState.values) {
    print('  ${value.name}: $value');
  }
  print('DisplayFeatureState has ${ DisplayFeatureState.values.length} values');

  final first = DisplayFeatureState.values.first;
  final last = DisplayFeatureState.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DisplayFeatureState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DisplayFeatureState Tests'),
      Text('Values: ${ DisplayFeatureState.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
