// D4rt test script: Tests MainAxisAlignment from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MainAxisAlignment test executing');

  // Enumerate all MainAxisAlignment values
  print('MainAxisAlignment values:');
  for (final value in MainAxisAlignment.values) {
    print('  ${value.name}: $value');
  }
  print('MainAxisAlignment has ${ MainAxisAlignment.values.length} values');

  final first = MainAxisAlignment.values.first;
  final last = MainAxisAlignment.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('MainAxisAlignment test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MainAxisAlignment Tests'),
      Text('Values: ${ MainAxisAlignment.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
