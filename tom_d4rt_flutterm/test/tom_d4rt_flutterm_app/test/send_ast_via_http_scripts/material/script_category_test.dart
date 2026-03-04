// D4rt test script: Tests ScriptCategory from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScriptCategory test executing');

  // Enumerate all ScriptCategory values
  print('ScriptCategory values:');
  for (final value in ScriptCategory.values) {
    print('  ${value.name}: $value');
  }
  print('ScriptCategory has ${ ScriptCategory.values.length} values');

  final first = ScriptCategory.values.first;
  final last = ScriptCategory.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ScriptCategory test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScriptCategory Tests'),
      Text('Values: ${ ScriptCategory.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
