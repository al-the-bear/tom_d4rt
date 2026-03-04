// D4rt test script: Tests SemanticsValidationResult from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SemanticsValidationResult test executing');

  // Enumerate all SemanticsValidationResult values
  print('SemanticsValidationResult values:');
  for (final value in SemanticsValidationResult.values) {
    print('  ${value.name}: $value');
  }
  print('SemanticsValidationResult has ${ SemanticsValidationResult.values.length} values');

  final first = SemanticsValidationResult.values.first;
  final last = SemanticsValidationResult.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SemanticsValidationResult test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SemanticsValidationResult Tests'),
      Text('Values: ${ SemanticsValidationResult.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
