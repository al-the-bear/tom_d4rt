// D4rt test script: Tests TextDirection from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextDirection test executing');

  // Enumerate all TextDirection values
  print('TextDirection values:');
  for (final value in TextDirection.values) {
    print('  ${value.name}: $value');
  }
  print('TextDirection has ${ TextDirection.values.length} values');

  final first = TextDirection.values.first;
  final last = TextDirection.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TextDirection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextDirection Tests'),
      Text('Values: ${ TextDirection.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
