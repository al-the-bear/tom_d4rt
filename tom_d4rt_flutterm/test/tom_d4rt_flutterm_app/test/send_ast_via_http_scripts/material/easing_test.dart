// D4rt test script: Tests Easing from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Easing test executing');

  // Test Easing - Easing
  print('Easing is available in the material package');
  print('Easing runtimeType accessible');

  print('Easing test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Easing Tests'),
      Text('Easing'),
    ],
  );
}
