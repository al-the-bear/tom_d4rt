// D4rt test script: Tests BlurStyle from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BlurStyle test executing');

  // Enumerate all BlurStyle values
  print('BlurStyle values:');
  for (final value in BlurStyle.values) {
    print('  ${value.name}: $value');
  }
  print('BlurStyle has ${ BlurStyle.values.length} values');

  final first = BlurStyle.values.first;
  final last = BlurStyle.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('BlurStyle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BlurStyle Tests'),
      Text('Values: ${ BlurStyle.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
