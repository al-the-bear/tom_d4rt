// D4rt test script: Tests TextBaseline from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextBaseline test executing');

  // Enumerate all TextBaseline values
  print('TextBaseline values:');
  for (final value in TextBaseline.values) {
    print('  ${value.name}: $value');
  }
  print('TextBaseline has ${ TextBaseline.values.length} values');

  final first = TextBaseline.values.first;
  final last = TextBaseline.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TextBaseline test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextBaseline Tests'),
      Text('Values: ${ TextBaseline.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
