// D4rt test script: Tests TraversalEdgeBehavior from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TraversalEdgeBehavior test executing');

  // Enumerate all TraversalEdgeBehavior values
  print('TraversalEdgeBehavior values:');
  for (final value in TraversalEdgeBehavior.values) {
    print('  ${value.name}: $value');
  }
  print('TraversalEdgeBehavior has ${ TraversalEdgeBehavior.values.length} values');

  final first = TraversalEdgeBehavior.values.first;
  final last = TraversalEdgeBehavior.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TraversalEdgeBehavior test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TraversalEdgeBehavior Tests'),
      Text('Values: ${ TraversalEdgeBehavior.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
