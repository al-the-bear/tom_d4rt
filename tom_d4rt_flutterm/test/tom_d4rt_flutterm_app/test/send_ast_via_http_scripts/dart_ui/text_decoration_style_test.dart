// D4rt test script: Tests TextDecorationStyle from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextDecorationStyle test executing');

  // Enumerate all TextDecorationStyle values
  print('TextDecorationStyle values:');
  for (final value in TextDecorationStyle.values) {
    print('  ${value.name}: $value');
  }
  print('TextDecorationStyle has ${ TextDecorationStyle.values.length} values');

  final first = TextDecorationStyle.values.first;
  final last = TextDecorationStyle.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TextDecorationStyle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextDecorationStyle Tests'),
      Text('Values: ${ TextDecorationStyle.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
