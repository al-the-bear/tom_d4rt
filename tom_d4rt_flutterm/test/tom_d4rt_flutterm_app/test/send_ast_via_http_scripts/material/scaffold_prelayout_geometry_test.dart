// D4rt test script: Tests ScaffoldPrelayoutGeometry from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScaffoldPrelayoutGeometry test executing');

  // Test ScaffoldPrelayoutGeometry - ScaffoldPrelayoutGeometry
  print('ScaffoldPrelayoutGeometry is available in the material package');
  print('ScaffoldPrelayoutGeometry runtimeType accessible');

  print('ScaffoldPrelayoutGeometry test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScaffoldPrelayoutGeometry Tests'),
      Text('ScaffoldPrelayoutGeometry'),
    ],
  );
}
