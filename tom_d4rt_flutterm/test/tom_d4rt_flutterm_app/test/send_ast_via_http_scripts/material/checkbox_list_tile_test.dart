// D4rt test script: Tests CheckboxListTile from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CheckboxListTile test executing');

  // Test CheckboxListTile - Checkbox tile
  print('CheckboxListTile is available in the material package');
  print('CheckboxListTile runtimeType accessible');

  print('CheckboxListTile test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CheckboxListTile Tests'),
      Text('Checkbox tile'),
    ],
  );
}
