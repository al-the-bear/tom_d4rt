// D4rt test script: Tests RenderAnimatedSizeState from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderAnimatedSizeState test executing');

  // Enumerate all RenderAnimatedSizeState values
  print('RenderAnimatedSizeState values:');
  for (final value in RenderAnimatedSizeState.values) {
    print('  ${value.name}: $value');
  }
  print('RenderAnimatedSizeState has ${ RenderAnimatedSizeState.values.length} values');

  final first = RenderAnimatedSizeState.values.first;
  final last = RenderAnimatedSizeState.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('RenderAnimatedSizeState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAnimatedSizeState Tests'),
      Text('Values: ${ RenderAnimatedSizeState.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
