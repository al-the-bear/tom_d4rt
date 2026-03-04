// D4rt test script: Tests PathOperation from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PathOperation test executing');

  // Enumerate all PathOperation values
  print('PathOperation values:');
  for (final value in PathOperation.values) {
    print('  ${value.name}: $value');
  }
  print('PathOperation has ${ PathOperation.values.length} values');

  final first = PathOperation.values.first;
  final last = PathOperation.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('PathOperation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PathOperation Tests'),
      Text('Values: ${ PathOperation.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
