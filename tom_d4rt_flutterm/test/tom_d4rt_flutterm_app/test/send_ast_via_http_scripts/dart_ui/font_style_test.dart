// D4rt test script: Tests FontStyle from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FontStyle test executing');

  // Enumerate all FontStyle values
  print('FontStyle values:');
  for (final value in FontStyle.values) {
    print('  ${value.name}: $value');
  }
  print('FontStyle has ${ FontStyle.values.length} values');

  final first = FontStyle.values.first;
  final last = FontStyle.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('FontStyle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FontStyle Tests'),
      Text('Values: ${ FontStyle.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
