// D4rt test script: Tests FlexFit from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FlexFit test executing');

  // Enumerate all FlexFit values
  print('FlexFit values:');
  for (final value in FlexFit.values) {
    print('  ${value.name}: $value');
  }
  print('FlexFit has ${ FlexFit.values.length} values');

  final first = FlexFit.values.first;
  final last = FlexFit.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('FlexFit test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FlexFit Tests'),
      Text('Values: ${ FlexFit.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
