// D4rt test script: Tests FramePhase from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FramePhase test executing');

  // Enumerate all FramePhase values
  print('FramePhase values:');
  for (final value in FramePhase.values) {
    print('  ${value.name}: $value');
  }
  print('FramePhase has ${ FramePhase.values.length} values');

  final first = FramePhase.values.first;
  final last = FramePhase.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('FramePhase test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FramePhase Tests'),
      Text('Values: ${ FramePhase.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
