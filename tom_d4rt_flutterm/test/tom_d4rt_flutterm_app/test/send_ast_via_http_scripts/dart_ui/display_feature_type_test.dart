// D4rt test script: Tests DisplayFeatureType from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DisplayFeatureType test executing');

  // Enumerate all DisplayFeatureType values
  print('DisplayFeatureType values:');
  for (final value in DisplayFeatureType.values) {
    print('  ${value.name}: $value');
  }
  print('DisplayFeatureType has ${ DisplayFeatureType.values.length} values');

  final first = DisplayFeatureType.values.first;
  final last = DisplayFeatureType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DisplayFeatureType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DisplayFeatureType Tests'),
      Text('Values: ${ DisplayFeatureType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
