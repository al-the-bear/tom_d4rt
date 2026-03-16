// D4rt test script: Tests BoxWidthStyle from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BoxWidthStyle test executing');

  // Enumerate all BoxWidthStyle values
  print('BoxWidthStyle values:');
  for (final value in BoxWidthStyle.values) {
    print('  ${value.name}: $value');
  }
  print('BoxWidthStyle has ${ BoxWidthStyle.values.length} values');

  final first = BoxWidthStyle.values.first;
  final last = BoxWidthStyle.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('BoxWidthStyle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BoxWidthStyle Tests'),
      Text('Values: ${ BoxWidthStyle.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
