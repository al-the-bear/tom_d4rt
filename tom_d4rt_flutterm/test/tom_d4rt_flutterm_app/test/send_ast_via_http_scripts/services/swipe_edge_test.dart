// ignore_for_file: avoid_print
// D4rt test script: Tests SwipeEdge from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SwipeEdge test executing');

  // Enumerate all SwipeEdge values
  print('SwipeEdge values:');
  for (final value in SwipeEdge.values) {
    print('  ${value.name}: $value');
  }
  print('SwipeEdge has ${SwipeEdge.values.length} values');

  final first = SwipeEdge.values.first;
  final last = SwipeEdge.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SwipeEdge test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SwipeEdge Tests'),
      Text('Values: ${SwipeEdge.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
