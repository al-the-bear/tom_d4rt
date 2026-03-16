// D4rt test script: Tests SemanticsHitTestBehavior from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SemanticsHitTestBehavior test executing');

  // Enumerate all SemanticsHitTestBehavior values
  print('SemanticsHitTestBehavior values:');
  for (final value in SemanticsHitTestBehavior.values) {
    print('  ${value.name}: $value');
  }
  print('SemanticsHitTestBehavior has ${ SemanticsHitTestBehavior.values.length} values');

  final first = SemanticsHitTestBehavior.values.first;
  final last = SemanticsHitTestBehavior.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SemanticsHitTestBehavior test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SemanticsHitTestBehavior Tests'),
      Text('Values: ${ SemanticsHitTestBehavior.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
