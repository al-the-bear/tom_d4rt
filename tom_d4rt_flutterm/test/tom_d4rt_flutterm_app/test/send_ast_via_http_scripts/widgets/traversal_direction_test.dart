// ignore_for_file: avoid_print
// D4rt test script: Tests TraversalDirection from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TraversalDirection test executing');

  // Enumerate all TraversalDirection values
  print('TraversalDirection values:');
  for (final value in TraversalDirection.values) {
    print('  ${value.name}: $value');
  }
  print('TraversalDirection has ${ TraversalDirection.values.length} values');

  final first = TraversalDirection.values.first;
  final last = TraversalDirection.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TraversalDirection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TraversalDirection Tests'),
      Text('Values: ${ TraversalDirection.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
