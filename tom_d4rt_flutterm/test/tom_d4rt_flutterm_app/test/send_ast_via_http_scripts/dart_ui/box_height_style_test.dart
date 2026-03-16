// D4rt test script: Tests BoxHeightStyle from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BoxHeightStyle test executing');

  // Enumerate all BoxHeightStyle values
  print('BoxHeightStyle values:');
  for (final value in BoxHeightStyle.values) {
    print('  ${value.name}: $value');
  }
  print('BoxHeightStyle has ${ BoxHeightStyle.values.length} values');

  final first = BoxHeightStyle.values.first;
  final last = BoxHeightStyle.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('BoxHeightStyle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BoxHeightStyle Tests'),
      Text('Values: ${ BoxHeightStyle.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
