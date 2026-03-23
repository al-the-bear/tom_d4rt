// ignore_for_file: avoid_print
// D4rt test script: Tests SelectionEventType from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionEventType test executing');

  // Enumerate all SelectionEventType values
  print('SelectionEventType values:');
  for (final value in SelectionEventType.values) {
    print('  ${value.name}: $value');
  }
  print('SelectionEventType has ${ SelectionEventType.values.length} values');

  final first = SelectionEventType.values.first;
  final last = SelectionEventType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SelectionEventType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionEventType Tests'),
      Text('Values: ${ SelectionEventType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
