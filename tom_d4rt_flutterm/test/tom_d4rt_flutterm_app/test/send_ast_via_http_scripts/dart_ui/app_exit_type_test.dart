// D4rt test script: Tests AppExitType from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AppExitType test executing');

  // Enumerate all AppExitType values
  print('AppExitType values:');
  for (final value in AppExitType.values) {
    print('  ${value.name}: $value');
  }
  print('AppExitType has ${ AppExitType.values.length} values');

  final first = AppExitType.values.first;
  final last = AppExitType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('AppExitType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AppExitType Tests'),
      Text('Values: ${ AppExitType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
