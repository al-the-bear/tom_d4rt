// D4rt test script: Tests SemanticsRole from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SemanticsRole test executing');

  // Enumerate all SemanticsRole values
  print('SemanticsRole values:');
  for (final value in SemanticsRole.values) {
    print('  ${value.name}: $value');
  }
  print('SemanticsRole has ${ SemanticsRole.values.length} values');

  final first = SemanticsRole.values.first;
  final last = SemanticsRole.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SemanticsRole test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SemanticsRole Tests'),
      Text('Values: ${ SemanticsRole.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
