// D4rt test script: Tests StrokeJoin from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('StrokeJoin test executing');

  // Enumerate all StrokeJoin values
  print('StrokeJoin values:');
  for (final value in StrokeJoin.values) {
    print('  ${value.name}: $value');
  }
  print('StrokeJoin has ${ StrokeJoin.values.length} values');

  final first = StrokeJoin.values.first;
  final last = StrokeJoin.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('StrokeJoin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StrokeJoin Tests'),
      Text('Values: ${ StrokeJoin.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
