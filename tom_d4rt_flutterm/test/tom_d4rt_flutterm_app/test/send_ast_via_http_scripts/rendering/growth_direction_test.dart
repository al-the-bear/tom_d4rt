// D4rt test script: Tests GrowthDirection from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('GrowthDirection test executing');

  // Enumerate all GrowthDirection values
  print('GrowthDirection values:');
  for (final value in GrowthDirection.values) {
    print('  ${value.name}: $value');
  }
  print('GrowthDirection has ${ GrowthDirection.values.length} values');

  final first = GrowthDirection.values.first;
  final last = GrowthDirection.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('GrowthDirection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('GrowthDirection Tests'),
      Text('Values: ${ GrowthDirection.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
