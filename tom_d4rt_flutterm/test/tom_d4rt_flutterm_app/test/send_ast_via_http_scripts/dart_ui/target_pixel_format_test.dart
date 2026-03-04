// D4rt test script: Tests TargetPixelFormat from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TargetPixelFormat test executing');

  // Enumerate all TargetPixelFormat values
  print('TargetPixelFormat values:');
  for (final value in TargetPixelFormat.values) {
    print('  ${value.name}: $value');
  }
  print('TargetPixelFormat has ${ TargetPixelFormat.values.length} values');

  final first = TargetPixelFormat.values.first;
  final last = TargetPixelFormat.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TargetPixelFormat test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TargetPixelFormat Tests'),
      Text('Values: ${ TargetPixelFormat.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
