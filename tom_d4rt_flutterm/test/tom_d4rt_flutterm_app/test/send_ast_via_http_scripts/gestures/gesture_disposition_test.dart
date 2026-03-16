// D4rt test script: Tests GestureDisposition from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GestureDisposition test executing');

  // Enumerate all GestureDisposition values
  print('GestureDisposition values:');
  for (final value in GestureDisposition.values) {
    print('  ${value.name}: $value');
  }
  print('GestureDisposition has ${ GestureDisposition.values.length} values');

  final first = GestureDisposition.values.first;
  final last = GestureDisposition.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('GestureDisposition test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('GestureDisposition Tests'),
      Text('Values: ${ GestureDisposition.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
