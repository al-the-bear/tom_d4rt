// D4rt test script: Tests PointMode from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PointMode test executing');

  // Enumerate all PointMode values
  print('PointMode values:');
  for (final value in PointMode.values) {
    print('  ${value.name}: $value');
  }
  print('PointMode has ${ PointMode.values.length} values');

  final first = PointMode.values.first;
  final last = PointMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('PointMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointMode Tests'),
      Text('Values: ${ PointMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
