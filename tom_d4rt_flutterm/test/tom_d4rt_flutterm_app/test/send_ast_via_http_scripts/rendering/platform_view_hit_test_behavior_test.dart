// D4rt test script: Tests PlatformViewHitTestBehavior from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformViewHitTestBehavior test executing');

  // Enumerate all PlatformViewHitTestBehavior values
  print('PlatformViewHitTestBehavior values:');
  for (final value in PlatformViewHitTestBehavior.values) {
    print('  ${value.name}: $value');
  }
  print('PlatformViewHitTestBehavior has ${ PlatformViewHitTestBehavior.values.length} values');

  final first = PlatformViewHitTestBehavior.values.first;
  final last = PlatformViewHitTestBehavior.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('PlatformViewHitTestBehavior test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformViewHitTestBehavior Tests'),
      Text('Values: ${ PlatformViewHitTestBehavior.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
