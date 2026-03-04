// D4rt test script: Tests TextAffinity from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextAffinity test executing');

  // Enumerate all TextAffinity values
  print('TextAffinity values:');
  for (final value in TextAffinity.values) {
    print('  ${value.name}: $value');
  }
  print('TextAffinity has ${ TextAffinity.values.length} values');

  final first = TextAffinity.values.first;
  final last = TextAffinity.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TextAffinity test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextAffinity Tests'),
      Text('Values: ${ TextAffinity.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
