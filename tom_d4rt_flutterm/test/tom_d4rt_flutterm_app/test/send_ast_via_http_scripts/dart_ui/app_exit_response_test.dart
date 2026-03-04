// D4rt test script: Tests AppExitResponse from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AppExitResponse test executing');

  // Enumerate all AppExitResponse values
  print('AppExitResponse values:');
  for (final value in AppExitResponse.values) {
    print('  ${value.name}: $value');
  }
  print('AppExitResponse has ${ AppExitResponse.values.length} values');

  final first = AppExitResponse.values.first;
  final last = AppExitResponse.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('AppExitResponse test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AppExitResponse Tests'),
      Text('Values: ${ AppExitResponse.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
