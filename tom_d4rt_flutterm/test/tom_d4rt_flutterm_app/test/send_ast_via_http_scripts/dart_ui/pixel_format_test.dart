// D4rt test script: Tests PixelFormat from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PixelFormat test executing');

  // Enumerate all PixelFormat values
  print('PixelFormat values:');
  for (final value in PixelFormat.values) {
    print('  ${value.name}: $value');
  }
  print('PixelFormat has ${ PixelFormat.values.length} values');

  final first = PixelFormat.values.first;
  final last = PixelFormat.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('PixelFormat test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PixelFormat Tests'),
      Text('Values: ${ PixelFormat.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
