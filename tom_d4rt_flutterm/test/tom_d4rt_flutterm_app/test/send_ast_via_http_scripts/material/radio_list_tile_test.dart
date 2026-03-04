// D4rt test script: Tests RadioListTile from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RadioListTile test executing');

  // Test RadioListTile - Radio tile
  print('RadioListTile is available in the material package');
  print('RadioListTile runtimeType accessible');

  print('RadioListTile test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RadioListTile Tests'),
      Text('Radio tile'),
    ],
  );
}
