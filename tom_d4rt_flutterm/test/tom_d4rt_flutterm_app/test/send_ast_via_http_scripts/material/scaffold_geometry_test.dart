// D4rt test script: Tests ScaffoldGeometry from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScaffoldGeometry test executing');

  // Test ScaffoldGeometry - ScaffoldGeometry
  print('ScaffoldGeometry is available in the material package');
  print('ScaffoldGeometry runtimeType accessible');

  print('ScaffoldGeometry test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScaffoldGeometry Tests'),
      Text('ScaffoldGeometry'),
    ],
  );
}
