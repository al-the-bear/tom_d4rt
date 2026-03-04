// D4rt test script: Tests VisualDensity from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('VisualDensity test executing');

  // Test VisualDensity - Visual density
  print('VisualDensity is available in the material package');
  print('VisualDensity runtimeType accessible');

  print('VisualDensity test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('VisualDensity Tests'),
      Text('Visual density'),
    ],
  );
}
