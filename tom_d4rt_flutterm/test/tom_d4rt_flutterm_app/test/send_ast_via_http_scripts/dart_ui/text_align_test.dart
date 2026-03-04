// D4rt test script: Tests TextAlign from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextAlign test executing');

  // Enumerate all TextAlign values
  print('TextAlign values:');
  for (final value in TextAlign.values) {
    print('  ${value.name}: $value');
  }
  print('TextAlign has ${ TextAlign.values.length} values');

  final first = TextAlign.values.first;
  final last = TextAlign.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TextAlign test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextAlign Tests'),
      Text('Values: ${ TextAlign.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
