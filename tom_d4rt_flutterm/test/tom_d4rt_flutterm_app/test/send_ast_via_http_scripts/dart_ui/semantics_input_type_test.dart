// D4rt test script: Tests SemanticsInputType from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SemanticsInputType test executing');

  // Enumerate all SemanticsInputType values
  print('SemanticsInputType values:');
  for (final value in SemanticsInputType.values) {
    print('  ${value.name}: $value');
  }
  print('SemanticsInputType has ${ SemanticsInputType.values.length} values');

  final first = SemanticsInputType.values.first;
  final last = SemanticsInputType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SemanticsInputType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SemanticsInputType Tests'),
      Text('Values: ${ SemanticsInputType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
