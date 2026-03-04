// D4rt test script: Tests SelectionStatus from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionStatus test executing');

  // Enumerate all SelectionStatus values
  print('SelectionStatus values:');
  for (final value in SelectionStatus.values) {
    print('  ${value.name}: $value');
  }
  print('SelectionStatus has ${ SelectionStatus.values.length} values');

  final first = SelectionStatus.values.first;
  final last = SelectionStatus.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SelectionStatus test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionStatus Tests'),
      Text('Values: ${ SelectionStatus.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
