// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ButtonBarLayoutBehavior from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ButtonBarLayoutBehavior test executing');

  // Enumerate all ButtonBarLayoutBehavior values
  print('ButtonBarLayoutBehavior values:');
  for (final value in ButtonBarLayoutBehavior.values) {
    print('  ${value.name}: $value');
  }
  print('ButtonBarLayoutBehavior has ${ ButtonBarLayoutBehavior.values.length} values');

  final first = ButtonBarLayoutBehavior.values.first;
  final last = ButtonBarLayoutBehavior.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ButtonBarLayoutBehavior test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ButtonBarLayoutBehavior Tests'),
      Text('Values: ${ ButtonBarLayoutBehavior.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
