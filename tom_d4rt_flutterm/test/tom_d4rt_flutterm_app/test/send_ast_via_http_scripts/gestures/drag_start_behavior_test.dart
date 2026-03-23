// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DragStartBehavior from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DragStartBehavior test executing');

  // Enumerate all DragStartBehavior values
  print('DragStartBehavior values:');
  for (final value in DragStartBehavior.values) {
    print('  ${value.name}: $value');
  }
  print('DragStartBehavior has ${ DragStartBehavior.values.length} values');

  final first = DragStartBehavior.values.first;
  final last = DragStartBehavior.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DragStartBehavior test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DragStartBehavior Tests'),
      Text('Values: ${ DragStartBehavior.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
