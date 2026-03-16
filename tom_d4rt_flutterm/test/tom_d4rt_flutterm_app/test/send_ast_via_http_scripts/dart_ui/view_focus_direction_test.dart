// D4rt test script: Tests ViewFocusDirection from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ViewFocusDirection test executing');

  // Enumerate all ViewFocusDirection values
  print('ViewFocusDirection values:');
  for (final value in ViewFocusDirection.values) {
    print('  ${value.name}: $value');
  }
  print('ViewFocusDirection has ${ ViewFocusDirection.values.length} values');

  final first = ViewFocusDirection.values.first;
  final last = ViewFocusDirection.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ViewFocusDirection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ViewFocusDirection Tests'),
      Text('Values: ${ ViewFocusDirection.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
