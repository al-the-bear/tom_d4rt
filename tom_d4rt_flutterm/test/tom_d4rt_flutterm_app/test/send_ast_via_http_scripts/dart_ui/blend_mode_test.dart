// D4rt test script: Tests BlendMode from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BlendMode test executing');

  // Enumerate all BlendMode values
  print('BlendMode values:');
  for (final value in BlendMode.values) {
    print('  ${value.name}: $value');
  }
  print('BlendMode has ${ BlendMode.values.length} values');

  final first = BlendMode.values.first;
  final last = BlendMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('BlendMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BlendMode Tests'),
      Text('Values: ${ BlendMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
