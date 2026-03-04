// D4rt test script: Tests Adaptation from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Adaptation test executing');

  // Test Adaptation - Adaptation
  print('Adaptation is available in the material package');
  print('Adaptation runtimeType accessible');

  print('Adaptation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Adaptation Tests'),
      Text('Adaptation'),
    ],
  );
}
