// D4rt test script: Tests SelectionResult from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionResult test executing');

  // Enumerate all SelectionResult values
  print('SelectionResult values:');
  for (final value in SelectionResult.values) {
    print('  ${value.name}: $value');
  }
  print('SelectionResult has ${ SelectionResult.values.length} values');

  final first = SelectionResult.values.first;
  final last = SelectionResult.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SelectionResult test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionResult Tests'),
      Text('Values: ${ SelectionResult.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
