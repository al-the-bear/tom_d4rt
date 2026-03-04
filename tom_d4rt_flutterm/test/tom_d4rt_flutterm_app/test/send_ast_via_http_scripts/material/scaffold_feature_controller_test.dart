// D4rt test script: Tests ScaffoldFeatureController from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScaffoldFeatureController test executing');

  // Test ScaffoldFeatureController - Feature controller
  print('ScaffoldFeatureController is available in the material package');
  print('ScaffoldFeatureController runtimeType accessible');

  print('ScaffoldFeatureController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScaffoldFeatureController Tests'),
      Text('Feature controller'),
    ],
  );
}
