// D4rt test script: Tests ColorSpace from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ColorSpace test executing');

  // Enumerate all ColorSpace values
  print('ColorSpace values:');
  for (final value in ColorSpace.values) {
    print('  ${value.name}: $value');
  }
  print('ColorSpace has ${ ColorSpace.values.length} values');

  final first = ColorSpace.values.first;
  final last = ColorSpace.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ColorSpace test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ColorSpace Tests'),
      Text('Values: ${ ColorSpace.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
