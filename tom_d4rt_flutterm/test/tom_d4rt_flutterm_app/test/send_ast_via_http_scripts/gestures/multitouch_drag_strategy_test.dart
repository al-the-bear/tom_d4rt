// ignore_for_file: avoid_print
// D4rt test script: Tests MultitouchDragStrategy from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MultitouchDragStrategy test executing');

  // Enumerate all MultitouchDragStrategy values
  print('MultitouchDragStrategy values:');
  for (final value in MultitouchDragStrategy.values) {
    print('  ${value.name}: $value');
  }
  print('MultitouchDragStrategy has ${ MultitouchDragStrategy.values.length} values');

  final first = MultitouchDragStrategy.values.first;
  final last = MultitouchDragStrategy.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('MultitouchDragStrategy test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MultitouchDragStrategy Tests'),
      Text('Values: ${ MultitouchDragStrategy.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
