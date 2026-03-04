// D4rt test script: Tests ScrollDirection from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollDirection test executing');

  // Enumerate all ScrollDirection values
  print('ScrollDirection values:');
  for (final value in ScrollDirection.values) {
    print('  ${value.name}: $value');
  }
  print('ScrollDirection has ${ ScrollDirection.values.length} values');

  final first = ScrollDirection.values.first;
  final last = ScrollDirection.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ScrollDirection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollDirection Tests'),
      Text('Values: ${ ScrollDirection.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
