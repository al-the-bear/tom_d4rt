// ignore_for_file: avoid_print
// D4rt test script: Tests DiagonalDragBehavior from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DiagonalDragBehavior test executing');

  // Enumerate all DiagonalDragBehavior values
  print('DiagonalDragBehavior values:');
  for (final value in DiagonalDragBehavior.values) {
    print('  ${value.name}: $value');
  }
  print('DiagonalDragBehavior has ${ DiagonalDragBehavior.values.length} values');

  final first = DiagonalDragBehavior.values.first;
  final last = DiagonalDragBehavior.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DiagonalDragBehavior test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DiagonalDragBehavior Tests'),
      Text('Values: ${ DiagonalDragBehavior.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
