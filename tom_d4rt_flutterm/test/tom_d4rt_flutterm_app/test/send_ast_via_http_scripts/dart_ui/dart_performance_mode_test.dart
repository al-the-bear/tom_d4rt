// D4rt test script: Tests DartPerformanceMode from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DartPerformanceMode test executing');

  // Enumerate all DartPerformanceMode values
  print('DartPerformanceMode values:');
  for (final value in DartPerformanceMode.values) {
    print('  ${value.name}: $value');
  }
  print('DartPerformanceMode has ${ DartPerformanceMode.values.length} values');

  final first = DartPerformanceMode.values.first;
  final last = DartPerformanceMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DartPerformanceMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DartPerformanceMode Tests'),
      Text('Values: ${ DartPerformanceMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
