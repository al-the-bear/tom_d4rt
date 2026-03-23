// ignore_for_file: avoid_print
// D4rt test script: Tests FloatingCursorDragState from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FloatingCursorDragState test executing');

  // Enumerate all FloatingCursorDragState values
  print('FloatingCursorDragState values:');
  for (final value in FloatingCursorDragState.values) {
    print('  ${value.name}: $value');
  }
  print(
    'FloatingCursorDragState has ${FloatingCursorDragState.values.length} values',
  );

  final first = FloatingCursorDragState.values.first;
  final last = FloatingCursorDragState.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('FloatingCursorDragState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FloatingCursorDragState Tests'),
      Text('Values: ${FloatingCursorDragState.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
