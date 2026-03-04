// D4rt test script: Tests ClipOp from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClipOp test executing');

  // Enumerate all ClipOp values
  print('ClipOp values:');
  for (final value in ClipOp.values) {
    print('  ${value.name}: $value');
  }
  print('ClipOp has ${ ClipOp.values.length} values');

  final first = ClipOp.values.first;
  final last = ClipOp.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ClipOp test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClipOp Tests'),
      Text('Values: ${ ClipOp.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
