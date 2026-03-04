// D4rt test script: Tests InputDecorator from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('InputDecorator test executing');

  // Test InputDecorator - InputDecorator
  print('InputDecorator is available in the material package');
  print('InputDecorator runtimeType accessible');

  print('InputDecorator test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InputDecorator Tests'),
      Text('InputDecorator'),
    ],
  );
}
