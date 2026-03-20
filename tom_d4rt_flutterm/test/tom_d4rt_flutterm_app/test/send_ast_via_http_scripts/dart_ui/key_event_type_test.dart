// D4rt test script: Tests KeyEventType from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyEventType test executing');

  // Enumerate all KeyEventType values
  print('KeyEventType values:');
  for (final value in KeyEventType.values) {
    print('  ${value.name}: $value');
  }
  print('KeyEventType has ${KeyEventType.values.length} values');

  final first = KeyEventType.values.first;
  final last = KeyEventType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('KeyEventType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('KeyEventType Tests'),
      Text('Values: ${KeyEventType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
