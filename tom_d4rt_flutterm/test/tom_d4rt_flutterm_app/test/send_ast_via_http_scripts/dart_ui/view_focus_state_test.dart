// D4rt test script: Tests ViewFocusState from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ViewFocusState test executing');

  // Enumerate all ViewFocusState values
  print('ViewFocusState values:');
  for (final value in ViewFocusState.values) {
    print('  ${value.name}: $value');
  }
  print('ViewFocusState has ${ ViewFocusState.values.length} values');

  final first = ViewFocusState.values.first;
  final last = ViewFocusState.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ViewFocusState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ViewFocusState Tests'),
      Text('Values: ${ ViewFocusState.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
